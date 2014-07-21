From: iziemba@cray.com (Ian Ziemba)
Date: Mon, 21 Jul 2014 16:17:25 +0000
Subject: NVME User Installation
In-Reply-To: <alpine.LRH.2.03.1407160835170.4703@AMR>
References: <8838223D960CB945AFF93D316204C6369D9F2F@CFWEX01.americas.cray.com>
 <alpine.LRH.2.03.1407160835170.4703@AMR>
Message-ID: <8838223D960CB945AFF93D316204C6369EB844@CFWEX01.americas.cray.com>

Hi Keith,

I copied over /uapi/linux/nvme.h into the correct location. The system does not seem to have any issues finding it. But, I ran into something else right now. Here is the printout from my screen:

iosr30-5:~/iziemba/nvme-user # make
cc -m64 -O2 -g -pthread -D_GNU_SOURCE -D_REENTRANT -W  -m64 -lm  nvme_smart.c nvme_identify.o   -o nvme_smart
In file included from /usr/src/linux-3.0.76-0.11/include/linux/nvme.h:22,
                 from nvme_smart.c:1:
/usr/src/linux-3.0.76-0.11/include/linux/types.h:13:2: warning: #warning "Attempt to use kernel headers from user space, see http://kernelnewbies.org/KernelHeaders"
nvme_smart.c:24: warning: 'struct nvme_smart_log' declared inside parameter list
nvme_smart.c:24: warning: its scope is only this definition or declaration, which is probably not what you want
nvme_smart.c: In function 'print_smart_log':
nvme_smart.c:27: error: dereferencing pointer to incomplete type
nvme_smart.c:28: error: dereferencing pointer to incomplete type
nvme_smart.c:30: error: dereferencing pointer to incomplete type
nvme_smart.c:32: error: dereferencing pointer to incomplete type
nvme_smart.c:33: error: dereferencing pointer to incomplete type
nvme_smart.c:34: error: dereferencing pointer to incomplete type
nvme_smart.c:37: error: dereferencing pointer to incomplete type
nvme_smart.c:40: error: dereferencing pointer to incomplete type
nvme_smart.c:43: error: dereferencing pointer to incomplete type
nvme_smart.c:46: error: dereferencing pointer to incomplete type
nvme_smart.c:49: error: dereferencing pointer to incomplete type
nvme_smart.c:52: error: dereferencing pointer to incomplete type
nvme_smart.c:55: error: dereferencing pointer to incomplete type
nvme_smart.c:58: error: dereferencing pointer to incomplete type
nvme_smart.c:61: error: dereferencing pointer to incomplete type
nvme_smart.c:64: error: dereferencing pointer to incomplete type
nvme_smart.c: In function 'main':
nvme_smart.c:79: error: dereferencing pointer to incomplete type
nvme_smart.c:107: error: dereferencing pointer to incomplete type
nvme_smart.c:108: error: dereferencing pointer to incomplete type
nvme_smart.c:124: warning: passing argument 1 of 'print_smart_log' from incompatible pointer type
nvme_smart.c:139: warning: passing argument 1 of 'print_smart_log' from incompatible pointer type
make: *** [nvme_smart] Error 1

I have ran into this before and haven't found a way to get around it...

Thanks,
Ian

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Wednesday, July 16, 2014 9:39 AM
To: Ian Ziemba
Cc: linux-nvme at lists.infradead.org
Subject: Re: NVME User Installation

On Fri, 11 Jul 2014, Ian Ziemba wrote:
> Hi,
>
> I am currently having trouble installing the nvme-user package on my system.
> Currently, I have an NVMe device up and running in my system. My 
> current configuration is a Dell R720 running SLES 11 SP3 with a Linux 
> kernel version of 3.0.76. In order to get my NVMe device to run, I had 
> to use the nvme-compatibility driver. I would like to get the 
> temperature reading off of my drive, but with my current setup, I cannot install the nvme-user package.
> Unfortunately, upgrading kernel versions is not an option.
>
> Any insight into how to install the nvme-user package on my system 
> would be greatly appreciated.

Most likely you don't have the nvme driver's user-api header in your include path. The compatibility driver has a copy at

  include/uapi/linux/nvme.h

If you know where your kernel headers are installed, you can just copy it there and should be able compile the user tools after.
