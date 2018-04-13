From: sbates@raithlin.com (Stephen  Bates)
Date: Fri, 13 Apr 2018 21:56:06 +0000
Subject: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <20180327094701.0000300d@huawei.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <20180326121138.00005e30@huawei.com>
 <20180326140118.GA221690@bhelgaas-glaptop.roam.corp.google.com>
 <c717eb06-1e83-f0f3-4d6c-15531aa808e0@deltatee.com>
 <20180327094701.0000300d@huawei.com>
Message-ID: <178FD8FA-53BA-49DA-807F-F8736157F179@raithlin.com>

 
>  I'll see if I can get our PCI SIG people to follow this through 

Hi Jonathan

Can you let me know if this moves forward within PCI-SIG? I would like to track it. I can see this being doable between Root Ports that reside in the same Root Complex but might become more challenging to standardize for RPs that reside in different RCs in the same (potentially multi-socket) system. I know in the past we have seem MemWr TLPS cross the QPI bus in Intel systems but I am sure that is not something that would work in all systems and must fall outside the remit of PCI-SIG ;-).

I agree such a capability bit would be very useful but it's going to be quite some time before we can rely on hardware being available that supports it.

Stephen
    
