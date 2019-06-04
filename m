From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Jun 2019 08:47:47 -0700
Subject: [Suspected-Phishing]Re: [PATCH] Revert "nvme-rdma: remove
 redundant reference between ib_device and tagset"
In-Reply-To: <b4a79dfe-ffc8-0571-9f54-cf5b98c21500@mellanox.com>
References: <20190603231159.17034-1-sagi@grimberg.me>
 <b98d3c8f-85ee-06f2-b47a-a3e04261c0d1@grimberg.me>
 <F4E18075-01AA-443B-BF43-23A4BA80C10C@intel.com>
 <d2a20c0f-092d-28ca-3365-1fb5df2cb816@mellanox.com>
 <b4a79dfe-ffc8-0571-9f54-cf5b98c21500@mellanox.com>
Message-ID: <251f83e0-75f1-ef0b-2747-8ae09f038ce8@grimberg.me>


> James,
> 
> can you test the attached patch (without the revert) ?

Max, I think that its pretty late for this change for 5.2,
I'm leaning towards reverting the offending patch for 5.2-rc and
getting this into 5.3
