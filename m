From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 9 Jul 2019 09:42:19 -0700
Subject: [PATCH] nvmet: print a hint while rejecting NSID 0 or 0xffffffff
In-Reply-To: <8bfa9035-ad7c-bdd2-a480-b8d26c597767@acm.org>
References: <c3a8458b54fcd189f7a441eb959274937faf8568.1562586068.git.mskorzhinskiy@solarflare.com>
 <8bfa9035-ad7c-bdd2-a480-b8d26c597767@acm.org>
Message-ID: <9d060ad8-0b47-7f4e-4a39-a11883a6d1ec@grimberg.me>


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

I don't think we need that, the same argument can be made for almost any
error print, and its pretty obvious that this is the ns creation
failure.

The location can be retrieved from:
grep -rIn "invalid nsid" drivers/nvme/target/
