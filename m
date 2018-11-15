From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Nov 2018 09:32:57 -0800
Subject: [PATCH v3 2/4] nvmet: don't override treq upon modification.
In-Reply-To: <20181115114014.GA17319@lst.de>
References: <20181114182534.28807-1-sagi@grimberg.me>
 <20181114182534.28807-3-sagi@grimberg.me> <20181115114014.GA17319@lst.de>
Message-ID: <f0997348-25c3-ecad-0434-7d3998ccbb62@grimberg.me>


>> index 613a37683eae..abc603fa725d 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -56,6 +56,8 @@
>>   #define IPO_IATTR_CONNECT_SQE(x)	\
>>   	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>>   
>> +#define NVMET_TREQ_SECURE_CHANNEL_MASK 0x3
> 
> Shouldn't this go with the other NVMET_TREQ_ symbols in the enum?

You mean NVME_TREQ_ enum in nvme.h, I can place it there, but probably
still as a define as it is a mask and not an enumeration.
