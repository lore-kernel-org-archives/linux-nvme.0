From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Thu, 27 Apr 2017 09:30:25 -0300
Subject: [PATCH] nvme: avoid connecting to the same subsystem from the
 same path gain.
In-Reply-To: <f565b530-3504-1906-81c4-2ee207db2af1@huawei.com>
References: <1493040417-15680-1-git-send-email-guanjunxiong@huawei.com>
 <eb6c96b5-4427-083f-db6d-fa3180664b9a@linux.vnet.ibm.com>
 <f565b530-3504-1906-81c4-2ee207db2af1@huawei.com>
Message-ID: <04d9527a-4965-cf31-1ab7-8c142019f4b5@linux.vnet.ibm.com>

On 04/27/2017 04:21 AM, Guan Junxiong wrote:
> 
> 
> On 2017/4/26 23:33, Guilherme G. Piccoli wrote:
>> On 04/24/2017 10:26 AM, Guan Junxiong wrote:
>>> From: Junxiong Guan <guanjunxiong at huawei.com>
> 
>> Agree with you, and I'm curious too on why this is considered a feature
>> instead of a problematic behavior.
>>
>> Minor suggestions to the patch:
>>
>> 1) On title: s/gain/again/g
>>
>> 2) s/with nvme-cli tools/with nvme-cli tool/g
>>
>> 3) s/tranport/transport/g
>>
>> Thanks for the good fix!
>> Cheers,
>>
>>
>> Guilherme
> 
> Hi,Guilherme:
>    Thanks for your review. I will send next modified version of patch according
> your suggestion if Christoph Hellwig confirms this is really needed to be improved.
> 

Great, thank you!
