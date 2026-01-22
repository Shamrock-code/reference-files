Sample of a Phantom disc simulation

```sh
set -e

#rm -rf phantom_run
mkdir -p phantom_run

cd phantom_run
git clone https://github.com/danieljprice/phantom.git
cd phantom
mkdir -p disc; cd disc

echo "Writing Makefile"
../scripts/writemake.sh disc > Makefile

echo "Running Makefile"

export COMPILE_JOBS=$(nproc)
export SYSTEM=gfortran
make; make setup

cp ../../../disc_setup.setup disc.setup
./phantomsetup disc

# change end time to 6.0
sed -i 's/^\(\s*tmax\s*=\s*\).*\(! end time\)/\1  6.0    \2/' disc.in
```

Phantom setup file to be writen in the folder
```
# input file for disc setup routine

# resolution
                  np =      100000    ! number of gas particles

# units
           mass_unit =      solarm    ! mass unit (e.g. solarm,jupiterm,1e6*solarm)
           dist_unit =          au    ! distance unit (e.g. au,pc,kpc,0.1pc)

# central object(s)/potential
            icentral =           1    ! use sink particles or external potential (0=potential,1=sinks)
              nsinks =           1    ! number of sinks

# options for central star
                  m1 =       1.000    ! star mass
               accr1 =       1.000    ! star accretion radius

# oblateness
            J2_body1 =       0.000    ! J2 moment (oblateness)

# options for gas accretion disc
             isetgas =           0    ! how to set gas density profile (0=total disc mass,1=mass within annulus,2=surface density normalisation,3=surface density at reference radius,4=minimum Toomre Q,5=minimum Toomre Q and Lstar)
          sigma_file =           F    ! reading gas profile from file sigma_grid.dat
           itapergas =           F    ! exponentially taper the outer disc profile
          ismoothgas =           T    ! smooth inner disc
               iwarp =           F    ! warp disc
                iecc =           F    ! eccentric disc
                R_in =       1.000    ! inner radius
               R_ref =         1.     ! reference radius
               R_out =        10.     ! outer radius
              disc_m =       0.050    ! disc mass
             lumdisc =           0    ! Set qindex from stellar luminosity (ieos=24) (0=no 1=yes)
              pindex =       1.500    ! power law index of surface density sig=sig0*r^-p
              qindex =       0.500    ! power law index of sound speed cs=cs0*r^-q
             posangl =       0.000    ! position angle (deg)
                incl =       0.000    ! inclination (deg)
                 H_R =       0.050    ! H/R at R=R_ref
             alphaSS =       0.005    ! desired alphaSS (0 for minimal needed for shock capturing)

# Minimum Temperature in the Simulation
             T_floor =       0.000    ! The minimum temperature in the simulation (for any locally isothermal EOS).

# set sphere around disc
          add_sphere =           F    ! add sphere around disc?

# set planets
            nplanets =           0    ! number of planets

# thermal stratification
           discstrat =           0    ! stratify disc? (0=no,1=yes)

# timestepping
             norbits =           1    ! maximum number of orbits at outer disc
              deltat =       0.100    ! output interval as fraction of orbital period
```

Here i will store only the .tmp and .in file
