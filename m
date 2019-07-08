From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Mon, 8 Jul 2019 11:56:05 -0600
Subject: [PATCH] nvmet: print a hint while rejecting NSID 0 or 0xffffffff
In-Reply-To: <8bfa9035-ad7c-bdd2-a480-b8d26c597767@acm.org>
References: <c3a8458b54fcd189f7a441eb959274937faf8568.1562586068.git.mskorzhinskiy@solarflare.com>
 <8bfa9035-ad7c-bdd2-a480-b8d26c597767@acm.org>
Message-ID: <0e01bd67-8f1f-4b6c-0643-b3801ca0e6fd@intel.com>



On 7/8/2019 9:09 AM, Bart Van Assche wrote:
> On 7/4/19 1:01 AM, Mikhail Skorzhinskii wrote:
>> Adding this hint for the sake of convenience.
>>
>> It was spotted that a few times people spent some time before 
>> understanding
>> what is exactly wrong in configuration process. This should save a few 
>> time
>> in such situations, especially for people who is not very confident with
>> NVMe requirements.
>>
>> Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
>> ---
>> ? drivers/nvme/target/configfs.c | 4 +++-
>> ? 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index 08dd5af357f7..cd52b9f15376 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -588,8 +588,10 @@ static struct config_group *nvmet_ns_make(struct 
>> config_group *group,
>> ????????? goto out;
>> ????? ret = -EINVAL;
>> -??? if (nsid == 0 || nsid == NVME_NSID_ALL)
>> +??? if (nsid == 0 || nsid == NVME_NSID_ALL) {
>> +??????? pr_err("invalid nsid %#x", nsid);
>> ????????? goto out;
>> +??? }
>> ????? ret = -ENOMEM;
>> ????? ns = nvmet_ns_alloc(subsys, nsid);
> 
> If Linux users want to figure out which code reported an error message 
> they sometimes run grep over the Linux kernel source code. Seeing the 
> above message makes me wonder whether enough context information is 
> provided to allow users to figure out unambiguously which code reported 
> the error message? Have you considered to include the function name in 
> the error message?

It would also be nice to see a device or namespace name, if available.


> 
> Thanks,
> 
> Bart.
> 
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
