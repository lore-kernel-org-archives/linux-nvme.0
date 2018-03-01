From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 1 Mar 2018 23:32:46 +0000
Subject: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
In-Reply-To: <20180301232038.GO19007@ziepe.ca>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301232038.GO19007@ziepe.ca>
Message-ID: <2F4ADC7B-0A78-4FA3-9DE3-B20FB0C537E7@raithlin.com>

>   No, locality matters. If you have a bunch of NICs and bunch of drives
>   and the allocator chooses to put all P2P memory on a single drive your
>   performance will suck horribly even if all the traffic is offloaded.
    
Sagi brought this up earlier in his comments about the _find_ function. We are planning to do something about this in the next version. This might be a randomization or a "user-pick" and include a rule around using the p2p_dev on the EP if that EP is part of the transaction.

Stephen


    
