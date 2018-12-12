From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 22:49:16 -0800
Subject: [PATCH] scatterlist: Update size type to support greater then 4GB
 size.
In-Reply-To: <20181211.222950.1995970751331458343.davem@davemloft.net>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
 <20181211.222950.1995970751331458343.davem@davemloft.net>
Message-ID: <5f70fc16-e3cd-37c1-e7ed-e131ad79d387@grimberg.me>


>>   struct nvme_sgl_desc {
>>   	__le64	addr;
>> -	__le32	length;
>> +	__le64	length;
>>   	__u8	rsvd[3];
>>   	__u8	type;
>>   };
> 
> Isn't this a device or protocol defined datastructure?  You can't just
> change it like this.

You're correct, we can't...
[Replied before seeing this issue was already highlighted]

The positive side is that it can safely be removed without affecting the
rest of the patch...
