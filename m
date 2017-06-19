From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 19:47:46 +0300
Subject: [PATCH v2 2/2] nvme: use a single NVME_AQ_DEPTH and relax it to 32
In-Reply-To: <20170619160103.GA21765@localhost.localdomain>
References: <1497791759-5754-1-git-send-email-sagi@grimberg.me>
 <1497791759-5754-2-git-send-email-sagi@grimberg.me>
 <20170619160103.GA21765@localhost.localdomain>
Message-ID: <5082db92-854b-ec46-4c62-96fcfd8d37eb@grimberg.me>


>> No need to differentiate fabrics from pci/loop, also lower
>> it to 32 as we don't really need 256 inflight admin commands.
> 
> Might want to check with Jens on reducing the count. d31af0a325ca4f increased the
> limit from 64 to 256 for a particular use case.

Can we modparam it? or quirk it like Martin suggested? My impression is
that its an overkill for 99.9% of the use-cases...
