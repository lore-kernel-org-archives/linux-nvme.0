From: hch@lst.de (Christoph Hellwig)
Date: Fri, 30 Mar 2018 09:06:51 +0200
Subject: [PATCH] nvme-multipath: implement active-active round-robin
 path selector
In-Reply-To: <CAB2tqtvZ6zQ60jca7W4uKka2LfavsW=oKhTx9Gv0sXR7-SBUVg@mail.gmail.com>
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
 <20180328194741.GJ13039@localhost.localdomain>
 <CAB2tqtvZ6zQ60jca7W4uKka2LfavsW=oKhTx9Gv0sXR7-SBUVg@mail.gmail.com>
Message-ID: <20180330070651.GA17095@lst.de>

On Fri, Mar 30, 2018@01:57:25PM +0900, Baegjae Sung wrote:
> Our prototype uses dual-ported PCIe NVMe connected to a single host. The
> host's HBA is connected to two switches,

What "HBA"?  We are talking about NVMe here..
