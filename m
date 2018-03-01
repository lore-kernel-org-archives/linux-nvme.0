From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 1 Mar 2018 23:00:51 +0000
Subject: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
In-Reply-To: <20180301224540.GL19007@ziepe.ca>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
Message-ID: <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>

>> We'd prefer to have a generic way to get p2pmem instead of restricting
>> ourselves to only using CMBs. We did work in the past where the P2P memory
 >> was part of an IB adapter and not the NVMe card. So this won't work if it's
  >> an NVMe only interface.
    
 > It just seems like it it making it too complicated.

I disagree. Having a common allocator (instead of some separate allocator per driver) makes things simpler.

> Seems like a very subtle and hard to debug performance trap to leave
> for the users, and pretty much the only reason to use P2P is
> performance... So why have such a dangerous interface?

P2P is about offloading the memory and PCI subsystem of the host CPU and this is achieved no matter which p2p_dev is used.

Stephen
    
