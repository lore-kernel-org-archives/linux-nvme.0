From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Oct 2018 00:50:07 -0700
Subject: [PATCH v2 1/2] nvme-rdma: always have a valid trsvcid
In-Reply-To: <20181019063236.GB28667@lst.de>
References: <20181019004040.28527-1-sagi@grimberg.me>
 <20181019063236.GB28667@lst.de>
Message-ID: <a5447809-b158-a7e6-eeb2-990d720d48c6@grimberg.me>


>> +	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
>> +		opts->trsvcid =
>> +			kstrdup(__stringify(NVME_RDMA_IP_PORT), GFP_KERNEL);
> 
> This still locks error handling.

Not sure how I managed to miss this comment... Sorry..
