From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Nov 2018 16:10:21 -0800
Subject: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <MWHPR08MB2685DD0299C66EE7CD853B3DC0D90@MWHPR08MB2685.namprd08.prod.outlook.com>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me>
 <MWHPR08MB2685DD0299C66EE7CD853B3DC0D90@MWHPR08MB2685.namprd08.prod.outlook.com>
Message-ID: <2a620e3a-f08c-6251-7dbb-46e843118bf4@grimberg.me>


> Hi Sagi,
> 
>> +       icreq->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
>> +       icreq->maxr2t = cpu_to_le16(1); /* single inflight r2t supported */
>> +       icreq->hpda = 0; /* no alignment constraint */
> 
> The NVMe-TCP spec indicates that MAXR2T is a 0's-based value. To support a single inflight R2T as indicated in the comment above, icreq->maxr2t should be set to 0, right?

Correct, will fix in the next spin.

Thanks
