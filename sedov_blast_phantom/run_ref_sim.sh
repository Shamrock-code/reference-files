#####################################
# to build phantom :
#
# sh ../scripts/writemake.sh sedov > Makefile
# make IND_TIMESTEPS=no
# make setup IND_TIMESTEPS=no
#####################################

./phantomsetup blast
./phantom blast.in
