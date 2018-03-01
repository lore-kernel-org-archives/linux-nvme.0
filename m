From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 1 Mar 2018 18:09:58 +0000
Subject: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <1519876569.4592.4.camel@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
Message-ID: <B4151146-0490-40D4-BB0A-4FC9DE5841A4@raithlin.com>

>> So Oliver (CC) was having issues getting any of that to work for us.
>> 
>> The problem is that acccording to him (I didn't double check the latest
>> patches) you effectively hotplug the PCIe memory into the system when
>> creating struct pages.
>> 
>> This cannot possibly work for us. First we cannot map PCIe memory as
>> cachable. (Note that doing so is a bad idea if you are behind a PLX
>> switch anyway since you'd ahve to manage cache coherency in SW).
>   
>   Note: I think the above means it won't work behind a switch on x86
>   either, will it ?
 
Ben 

We have done extensive testing of this series and its predecessors using PCIe switches from both Broadcom (PLX) and Microsemi. We have also done testing on x86_64, ARM64 and ppc64el based ARCH with varying degrees of success. The series as it currently stands only works on x86_64 but modified (hacky) versions have been made to work on ARM64. The x86_64 testing has been done on a range of (Intel) CPUs, servers, PCI EPs (including RDMA NICs from at least three vendors, NVMe SSDs from at least four vendors and P2P devices from four vendors) and PCI switches.

I do find it slightly offensive that you would question the series even working. I hope you are not suggesting we would submit this framework multiple times without having done testing on it....

Stephen
