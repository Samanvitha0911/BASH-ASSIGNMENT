
user=$(whoami)
host=$(hostname)
datetime=$(date '+%Y-%m-%d %H:%M:%S')
os=$(uname -s)
curr_dir=$(pwd)
home_dir=$HOME
users_online=$(who | wc -l)
sys_uptime=$(uptime -p)
disk_usage=$(df -h / | awk 'NR==2 {print $3 "/" $2 " used (" $5 ")"}')
mem_info=$(free -h | awk 'NR==2 {print $3 "/" $2 " used"}')
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║       SYSTEM INFORMATION DISPLAY           ║${NC}"
echo -e "${GREEN}╠════════════════════════════════════════════╣${NC}"
echo -e "${GREEN}║${NC} ${YELLOW}Username    :${NC} $user"
echo -e "${GREEN}║${NC} ${YELLOW}Hostname    :${NC} $host"
echo -e "${GREEN}║${NC} ${YELLOW}Date & Time :${NC} $datetime"
echo -e "${GREEN}║${NC} ${YELLOW}OS          :${NC} $os"
echo -e "${GREEN}║${NC} ${YELLOW}Current Dir :${NC} $curr_dir"
echo -e "${GREEN}║${NC} ${YELLOW}Home Dir    :${NC} $home_dir"
echo -e "${GREEN}║${NC} ${YELLOW}Users Online:${NC} $users_online"
echo -e "${GREEN}║${NC} ${YELLOW}Uptime      :${NC} $sys_uptime"
echo -e "${GREEN}║${NC} ${YELLOW}Disk Usage  :${NC} $disk_usage"
echo -e "${GREEN}║${NC} ${YELLOW}Memory      :${NC} $mem_info"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
