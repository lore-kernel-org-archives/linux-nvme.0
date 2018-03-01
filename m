From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 1 Mar 2018 23:57:43 +0000
Subject: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
In-Reply-To: <20180301234930.GG14799@localhost.localdomain>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301234930.GG14799@localhost.localdomain>
Message-ID: <CE2A5D93-E735-4414-8DC1-B308B74A1C5B@raithlin.com>

> We don't want to lump these all together without knowing which region you're allocating from, right?

In all seriousness I do agree with you on these Keith in the long term. We would consider adding property flags for the memory as it is added to the p2p core and then the allocator could evolve to intelligently dish it out. Attributes like endurance, latency and special write commit requirements could all become attributes in time. Perhaps one more reason for a central entity for p2p memory allocation so this code does not end up having to go into many different drivers?

Stephen
    
