From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 16:33:57 -0800
Subject: [PATCH] nvme-core: small cleanups
In-Reply-To: <1543876976.185366.175.camel@acm.org>
References: <20181129171804.5241-1-chaitanya.kulkarni@wdc.com>
 <1543876976.185366.175.camel@acm.org>
Message-ID: <01b3109f-76d4-590b-b643-028ed1ee0dc3@grimberg.me>


>>   static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
>>   {
>> -	struct nvme_command c = { };
>> +	struct nvme_command c;
>>   	int error;
>>   
>> +	memset(&c, 0, sizeof(c));
> 
> Please drop this and all similar changes. I think the preferred style in the Linux
> kernel for structure initialization is to use "= { }" instead of memset().

Agree with Bart.
