From: amhetre@nvidia.com (Ashish Mhetre)
Date: Wed, 12 Dec 2018 13:15:15 +0530
Subject: [PATCH] scatterlist: Update size type to support greater then 4GB
 size.
In-Reply-To: <5f70fc16-e3cd-37c1-e7ed-e131ad79d387@grimberg.me>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
 <20181211.222950.1995970751331458343.davem@davemloft.net>
 <5f70fc16-e3cd-37c1-e7ed-e131ad79d387@grimberg.me>
Message-ID: <eea4ccbb-a750-581f-525c-ce05d912f537@nvidia.com>



On 12/12/18 12:19 PM, Sagi Grimberg wrote:
> 
>>> ? struct nvme_sgl_desc {
>>> ????? __le64??? addr;
>>> -??? __le32??? length;
>>> +??? __le64??? length;
>>> ????? __u8??? rsvd[3];
>>> ????? __u8??? type;
>>> ? };
>>
>> Isn't this a device or protocol defined datastructure?? You can't just
>> change it like this.
> 
> You're correct, we can't...
> [Replied before seeing this issue was already highlighted]
> 
> The positive side is that it can safely be removed without affecting the
> rest of the patch...

Ohh, I am not aware of this protocol defined data-structures. But it 
seems that this need not be changed as Sagi is saying sg length for NVME
will never cross 32 bit size.
I'll send a new version removing this change. Thanks.
