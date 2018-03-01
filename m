From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 1 Mar 2018 19:01:31 +0000
Subject: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
In-Reply-To: <20180301184249.GI19007@ziepe.ca>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
Message-ID: <88ACB0F6-DE78-400B-A42C-953B49026FA2@raithlin.com>

    
> I agree, I don't think this series should target anything other than
> using p2p memory located in one of the devices expected to participate
> in the p2p trasnaction for a first pass..

I disagree. There is definitely interest in using a NVMe CMB as a bounce buffer and in deploying systems where only some of the NVMe SSDs below a switch  have a CMB but use P2P to access all of them. Also there are some devices that only expose memory and their entire purpose is to act as a p2p device, supporting these devices would be valuable.
    
> locality is super important for p2p, so I don't think things should
>  start out in a way that makes specifying the desired locality hard.

Ensuring that the EPs engaged in p2p are all directly connected to the same PCIe switch ensures locality and (for the switches we have tested) performance. I agree solving the case where the namespace are CMB are on the same PCIe EP is valuable but I don't see it as critical to initial acceptance of the series.
    
Stephen
    
