From: echang@sk.com (Eric H. Chang)
Date: Fri, 30 Mar 2018 09:04:46 +0000
Subject: [PATCH] nvme-multipath: implement active-active round-robin	path
 selector
In-Reply-To: <20180330070651.GA17095@lst.de>
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
 <20180328194741.GJ13039@localhost.localdomain>
 <CAB2tqtvZ6zQ60jca7W4uKka2LfavsW=oKhTx9Gv0sXR7-SBUVg@mail.gmail.com>
 <20180330070651.GA17095@lst.de>
Message-ID: <e22676055aca4e8d936b7479d6301d85@skt-tnetpmx2.SKT.AD>

We internally call PCIe-retimer as HBA. It's not a real Host Bus Adapter that translates the interface from PCIe to SATA or SAS. Sorry for the confusion.

Our setup is like below:
 CPU [server]
 <-> PCIe switch based retimer(aka HBA herein) [server]
 <-> dual PCIe switch nodes [NVMe JBOF storage]
 <-> dual port NVMe SSD [NVMe JBOF storage]

Every server is hooked up with dual PCIe switch nodes for HA purpose. 

-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Friday, March 30, 2018 4:07 PM
To: Baegjae Sung <baegjae at gmail.com>
Cc: Keith Busch <keith.busch at intel.com>; Christoph Hellwig <hch at lst.de>; axboe at fb.com; sagi at grimberg.me; linux-nvme at lists.infradead.org; linux-kernel at vger.kernel.org; ????/SW-Defined Storage Lab <echang at sk.com>
Subject: Re: [PATCH] nvme-multipath: implement active-active round-robin path selector

On Fri, Mar 30, 2018@01:57:25PM +0900, Baegjae Sung wrote:
> Our prototype uses dual-ported PCIe NVMe connected to a single host. 
> The host's HBA is connected to two switches,

What "HBA"?  We are talking about NVMe here..
