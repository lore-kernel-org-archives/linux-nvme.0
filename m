From: bdeyal@gmail.com (Eyal BenDavid)
Date: Tue, 6 Nov 2018 17:44:31 +0200
Subject: nvme-cli: connect-all failed with EALREADY but exit code is 0
Message-ID: <CAPrnrPDk+Mopaoni030JJ49TKCe95Vv7AfJDFT7_99zXaBUBqw@mail.gmail.com>

Hi All,

Scenario:
1. A nvme controller already exists for FC traddr and host_traddr
2. Running connect all with those parameters again failed
3. nvme-cli result is:
   "Failed to write to /dev/nvme-fabrics: Operation already in progress"
4. Exit code for nvme cli is 0

Is it intended that exit code is 0?

Thanks,
Eyal


More info:
==========
# nvme connect-all \
--host-traddr=nn-0x20000090fa94845f:pn-0x10000090fa94845f \
--hostid=d8266f50-5f24-4c55-8959-23d500e4e450 \
--hostnqn=nqn.2014-08.org.nvmexpress:uuid:d8266f50-5f24-4c55-8959-23d500e4e450 \
--traddr=nn-0x500507680c00002b:pn-0x500507680c2a002b \
--transport=fc
Failed to write to /dev/nvme-fabrics: Operation already in progress

# echo $?
0

>From strace we can see that discovery controller and discovery log page commands
were ok but the creation of the nvme (io) controller failed with EALREADY

== strace ==

open("/dev/nvme-fabrics", O_RDWR)       = 3
write(3, "nqn=nqn.2014-08.org.nvmexpress.d"..., 281) = 281
read(3, "instance=17,cntlid=4099\n", 4096) = 24
close(3)                                = 0
open("/dev/nvme17", O_RDWR)             = 3
ioctl(3, NVME_IOCTL_ADMIN_CMD, 0x7ffe3790a260) = 0
ioctl(3, NVME_IOCTL_ADMIN_CMD, 0x7ffe3790a260) = 0
ioctl(3, NVME_IOCTL_ADMIN_CMD, 0x7ffe3790a260) = 0
close(3)                                = 0
open("/sys/class/nvme/nvme17/delete_controller", O_WRONLY) = 3
write(3, "1", 1)                        = 1
close(3)                                = 0
open("/dev/nvme-fabrics", O_RDWR)       = 3
write(3, "nqn=nqn.1986-03.com.ibm:nvme:214"..., 300) = -1 EALREADY
(Operation already in progress)

=======
