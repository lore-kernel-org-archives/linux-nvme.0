From: keith.busch@intel.com (Keith Busch)
Date: Wed, 4 Apr 2018 08:30:27 -0600
Subject: [PATCH] nvme-multipath: implement active-active round-robin
 path selector
In-Reply-To: <e22676055aca4e8d936b7479d6301d85@skt-tnetpmx2.SKT.AD>
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
 <20180328194741.GJ13039@localhost.localdomain>
 <CAB2tqtvZ6zQ60jca7W4uKka2LfavsW=oKhTx9Gv0sXR7-SBUVg@mail.gmail.com>
 <20180330070651.GA17095@lst.de>
 <e22676055aca4e8d936b7479d6301d85@skt-tnetpmx2.SKT.AD>
Message-ID: <20180404143027.GE4485@localhost.localdomain>

On Fri, Mar 30, 2018@09:04:46AM +0000, Eric H. Chang wrote:
> We internally call PCIe-retimer as HBA. It's not a real Host Bus Adapter that translates the interface from PCIe to SATA or SAS. Sorry for the confusion.

Please don't call a PCIe retimer an "HBA"! :)

While your experiment is setup to benefit from round-robin, my only
concern is it has odd performance in a real world scenario with
IO threads executing in different nodes. Christoph's proposal will
naturally utilize both paths optimally there, where round-robin will
saturate node interlinks.

Not that I'm against having the choice; your setup probably does represent
real use. But if we're going to have multiple choice, user documentation
on nvme path selectors will be useful here.
