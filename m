From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Mar 2018 16:49:30 -0700
Subject: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
In-Reply-To: <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
Message-ID: <20180301234930.GG14799@localhost.localdomain>

On Thu, Mar 01, 2018@11:00:51PM +0000, Stephen  Bates wrote:
> 
> P2P is about offloading the memory and PCI subsystem of the host CPU
> and this is achieved no matter which p2p_dev is used.

Even within a device, memory attributes for its various regions may not be
the same. There's a meaningful difference between writing to an NVMe CMB
vs PMR, and a single device could have both. We don't want to lump these
all together without knowing which region you're allocating from, right?
