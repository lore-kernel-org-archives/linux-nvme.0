From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 14:29:25 -0800
Subject: [PATCH v2 13/14] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181121130712.GG1373@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-15-sagi@grimberg.me> <20181121130712.GG1373@lst.de>
Message-ID: <18549b2b-74dd-31df-9442-118cae370e1d@grimberg.me>


>>   #define NVME_TCP_DISC_PORT	8009
>>   #define NVME_TCP_ADMIN_CCSZ	SZ_8K
>> +#define NVME_TCP_DIGEST_LENGTH	4
> 
> This should go into the previous patch.

Correct.
