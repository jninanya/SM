##################################################
## PHOTOPERIOD AND SOLAR RADIATION AT TOP-OF-THE-ATMOSPHERE 
#################################################
library(lubridate)

Qs <- function(latitude, date){
  L = latitude
  X = as.Date(date)
  
  #--- D: angulo de la declinacion solar
  year0 = as.Date(paste0(year(X) - 1,"-12-22"))
  year1 = as.Date(paste0(year(X) - 0,"-12-22"))
  if (X >= year0 & X < year1){nd = as.numeric(X-year0) + 1}
  if (X >= year1){nd = as.numeric(X-year1) + 1}
  
  D = -23.45*cos(360/365*nd*pi/180)

  #--- H: angulo horario ---#
  H = acos(-1*tan(L*pi/180)*tan(D*pi/180))
  H = H*180/pi
  Hss = 12 - H/15
  Hps = 12 + H/15
  N = 2*H/15
  
  #--- dm_d: distancia promedio Sol-Tierra
  c1 = 1.00011
  c2 = 0.033523
  c3 = 0.00128
  c4 = 0.000739
  c5 = 0.000099
  
  date0 = as.Date(paste0(year(X),"-01-01"))
  n = as.numeric(X-date0) + 1
  th = 2*n*pi/365
  
  dm_d = c1 + c2*cos(th) + c3*sin(th) + c4*cos(2*th) + c5*sin(2*th)
  
  Qs = 37.211*dm_d*(H*pi/180*sin(L*pi/180)*sin(D*pi/180) + cos(L*pi/180)*cos(D*pi/180)*sin(H*pi/180))
}


lat = seq(-66, 66, by = 2)
lat = c(-23.5, -18, -12, -5, 0, 5, 12, 18, 23.5)
dat = seq(as.Date("2019-01-01"), as.Date("2019-12-31"), by = 3)

qs = matrix(nrow = length(lat), ncol = length(dat))

for(i in 1:length(lat)){
  for(j in 1:length(dat)){
    qs[i, j] = Qs(latitude = lat[i], date = dat[j])
  }
}

qs = as.data.frame(qs)
colnames(qs) = dat
rownames(qs) = lat

y = 1:length(dat)
x = lat
z = as.matrix(qs)

persp3D(x, y, z,
      main="", zlim = c(-20, 75),
      zlab = "Qs", xlab = "latitud", ylab = "meses", 
      theta = 232, phi = 40, col = jet.col (n = 100, alpha = 1),
      shade = 0.1)


par(mar = c(7, 7, 2, 2), cex = 1, cex.axis = 1.0)

image(y,x,t(z), col = jet.col (n = 100, alpha = 1),
      las = 1, axes = F,
      xlab = "", ylab = "")
box()
contour(y,x,t(z),add=T)

axis(side = 2, at = seq(-60, 60, by = 15), tck = -0.03, las = 1,
     labels = seq(-60, 60, by = 15), mgp = c(2, 1.3, 0))
mtext(side = 2, "latitud", line = 2.9, cex = 1.3)

axis(side = 1, at = c(15,46,74,105,135,166,196,227,258,288,319,345)*122/365, tck = -0.03, las = 2,
     labels = c("ENE","FEB","MAR","ABR","MAY","JUN","JUL","AGO","SET","OCT","NOV","DIC"), mgp = c(2, 1.3, 0))
mtext(side = 1, "meses", line = 3.5, cex = 1.3)


###########################################################
dQs <- function(latitude, date, h, Tr, ai, alpha, as){
  L = latitude
  X = as.Date(date)
  
  #--- D: angulo de la declinacion solar
  year0 = as.Date(paste0(year(X) - 1,"-12-22"))
  year1 = as.Date(paste0(year(X) - 0,"-12-22"))
  if (X >= year0 & X < year1){nd = as.numeric(X-year0) + 1}
  if (X >= year1){nd = as.numeric(X-year1) + 1}
  
  D = -23.45*cos(360/365*nd*pi/180)
  
  #--- H: angulo horario ---#
  H = acos(-1*tan(L*pi/180)*tan(D*pi/180))
  H = H*180/pi
  Hss = 12 - H/15
  Hps = 12 + H/15
  N = 2*H/15
  
  #--- dm_d: distancia promedio Sol-Tierra
  c1 = 1.00011
  c2 = 0.033523
  c3 = 0.00128
  c4 = 0.000739
  c5 = 0.000099
  
  date0 = as.Date(paste0(year(X),"-01-01"))
  n = as.numeric(X-date0) + 1
  th = 2*n*pi/365
  
  dm_d = c1 + c2*cos(th) + c3*sin(th) + c4*cos(2*th) + c5*sin(2*th)
  
  #cosZ
  hs=15*(h-12);
  cosZ=sin(L*pi/180)*sin(D*pi/180)+cos(L*pi/180)*cos(D*pi/180)*cos(hs*pi/180);
  
  S1=1395; #w/m2
  dQs1=S1*dm_d*cosZ;
  
  Qi=dQs1*Tr^(1/cosZ)
  q=S1*dm_d*(0.27-0.294*Tr^(1/cosZ))*sin(ai*pi/180)
  Qr=alpha*S1*dm_d*(0.27+0.706*Tr^(1/cosZ))*sin(ai*pi/180)
  
  as=90-ai
  Qig=Qi+q*(90+as)/180+Qr*(90+as)/180
  
  S = 2 #ly
  qs1 = 37.211*dm_d*(H*pi/180*sin(L*pi/180)*sin(D*pi/180) + cos(L*pi/180)*cos(D*pi/180)*sin(H*pi/180)) # MJ m-2 dia-1
  qs2 = 10.33*dm_d*(H*pi/180*sin(L*pi/180)*sin(D*pi/180) + cos(L*pi/180)*cos(D*pi/180)*sin(H*pi/180)) # kW m-2
  qs3 = 7.68*S*dm_d*(H*pi/180*sin(L*pi/180)*sin(D*pi/180) + cos(L*pi/180)*cos(D*pi/180)*sin(H*pi/180)) # mm dia-1
  qs4 = qs1*0.408
  
  out = data.frame("theta" = th, "dm_d2" = dm_d, "delta" = D,"H" = H, "Hss" = Hss, "Hps" = Hps,
                   "N" = N)
  qs = data.frame("Qs_MJ_dia"=qs1, "Qs_kW_m2" = qs2, "Qs_mm_dia"=qs3, qs4)
  #out = t(out)
  
  out2<-data.frame("cosZ"=cosZ, "dQs"=dQs1, "Qi"=round(Qi,2),"q"=q,"Qr"=Qr,"Qig"=Qig)
  dQs = list("summary" = out, "Qs" = qs, "dQs"=out2)
  
}

