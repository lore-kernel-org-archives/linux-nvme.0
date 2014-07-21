From: keith.busch@intel.com (Keith Busch)
Date: Mon, 21 Jul 2014 15:33:19 -0600 (MDT)
Subject: NVME User Installation
In-Reply-To: <8838223D960CB945AFF93D316204C6369EB844@CFWEX01.americas.cray.com>
References: <8838223D960CB945AFF93D316204C6369D9F2F@CFWEX01.americas.cray.com>
 <alpine.LRH.2.03.1407160835170.4703@AMR>
 <8838223D960CB945AFF93D316204C6369EB844@CFWEX01.americas.cray.com>
Message-ID: <alpine.LRH.2.03.1407211024060.4703@AMR>

I just tired a SLES11 SP3 install and copied the nvme user api header
from the nvme-compatibility repo's 'include/uapi/linux/nvme.h' to
'/usr/include/linux/', and was able to build the user tools without error.

I'm not sure what else could be different between our two setups that
is causing the errors you're seeing.

On Mon, 21 Jul 2014, Ian Ziemba wrote:
> Hi Keith,
>
> I copied over /uapi/linux/nvme.h into the correct location. The system does
> not seem to have any issues finding it. But, I ran into something else right
> now. Here is the printout from my screen:
>
> iosr30-5:~/iziemba/nvme-user # make
> cc -m64 -O2 -g -pthread -D_GNU_SOURCE -D_REENTRANT -W  -m64 -lm  nvme_smart.c nvme_identify.o   -o nvme_smart
> In file included from /usr/src/linux-3.0.76-0.11/include/linux/nvme.h:22,
>                 from nvme_smart.c:1:
> /usr/src/linux-3.0.76-0.11/include/linux/types.h:13:2: warning: #warning "Attempt to use kernel headers from user space, see http://kernelnewbies.org/KernelHeaders"
> nvme_smart.c:24: warning: 'struct nvme_smart_log' declared inside parameter list
> nvme_smart.c:24: warning: its scope is only this definition or declaration, which is probably not what you want
> nvme_smart.c: In function 'print_smart_log':
> nvme_smart.c:27: error: dereferencing pointer to incomplete type
> nvme_smart.c:28: error: dereferencing pointer to incomplete type
> nvme_smart.c:30: error: dereferencing pointer to incomplete type
> nvme_smart.c:32: error: dereferencing pointer to incomplete type
> nvme_smart.c:33: error: dereferencing pointer to incomplete type
> nvme_smart.c:34: error: dereferencing pointer to incomplete type
> nvme_smart.c:37: error: dereferencing pointer to incomplete type
> nvme_smart.c:40: error: dereferencing pointer to incomplete type
> nvme_smart.c:43: error: dereferencing pointer to incomplete type
> nvme_smart.c:46: error: dereferencing pointer to incomplete type
> nvme_smart.c:49: error: dereferencing pointer to incomplete type
> nvme_smart.c:52: error: dereferencing pointer to incomplete type
> nvme_smart.c:55: error: dereferencing pointer to incomplete type
> nvme_smart.c:58: error: dereferencing pointer to incomplete type
> nvme_smart.c:61: error: dereferencing pointer to incomplete type
> nvme_smart.c:64: error: dereferencing pointer to incomplete type
> nvme_smart.c: In function 'main':
> nvme_smart.c:79: error: dereferencing pointer to incomplete type
> nvme_smart.c:107: error: dereferencing pointer to incomplete type
> nvme_smart.c:108: error: dereferencing pointer to incomplete type
> nvme_smart.c:124: warning: passing argument 1 of 'print_smart_log' from incompatible pointer type
> nvme_smart.c:139: warning: passing argument 1 of 'print_smart_log' from incompatible pointer type
> make: *** [nvme_smart] Error 1
>
> I have ran into this before and haven't found a way to get around it...
>
> Thanks,
> Ian
