From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 15 Aug 2018 00:20:43 +0300
Subject: [Suspected-Phishing]Re: [PATCH nvme-cli 2/2] fabrics: write
 keep-alive-timeout to fabrics device on connect
In-Reply-To: <147f0ed4-ce7d-3f98-6df9-48b54d75d721@mellanox.com>
References: <20180808071032.5914-1-jthumshirn@suse.de>
 <20180808071032.5914-3-jthumshirn@suse.de>
 <147f0ed4-ce7d-3f98-6df9-48b54d75d721@mellanox.com>
Message-ID: <2f341a20-8eba-06a9-1f31-ac5b3d0c2557@mellanox.com>



On 8/15/2018 12:18 AM, Max Gurtovoy wrote:
> 
> 
> On 8/8/2018 10:10 AM, Johannes Thumshirn wrote:
>> Commit 7099227b07a8 ("fabrics: add option to supply keep-alive-timeout
>> for connect-all") introduced a keep-alive-timeout option for
>> connect-all but forgot to write it down to the kernel's fabrics
>> device in connect_ctrl().
>>
>> Pass down the keep-alove-timeouts if we're connecting to a non
>> discovery controller.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
>> Fixes: 7099227b07a8 ("fabrics: add option to supply keep-alive-timeout 
>> for connect-all")
>> ---
>> ? fabrics.c | 7 +++++++
>> ? 1 file changed, 7 insertions(+)
>>
>> diff --git a/fabrics.c b/fabrics.c
>> index baff94ae865c..c0e50d148eb4 100644
>> --- a/fabrics.c
>> +++ b/fabrics.c
>> @@ -628,6 +628,13 @@ static int connect_ctrl(struct 
>> nvmf_disc_rsp_page_entry *e)
>> ????????? p+= len;
>> ????? }
>> +??? if (cfg.keep_alive_tmo && !discover) {
>> +??????? len = sprintf(p, ",keep_alive_tmo=%s", cfg.keep_alive_tmo);
>> +??????? if (len < 0)
>> +??????????? return -EINVAL;
>> +??????? p += len;
>> +??? }
>> +
>> ????? switch (e->trtype) {
>> ????? case NVMF_TRTYPE_LOOP: /* loop */
>> ????????? len = sprintf(p, ",transport=loop");
>>
> 
> Looks good,
> 
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>


  ohh, I see that this already applied so even better :)
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C77b07198d60044dd2d0908d6022b7ee7%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636698783171589227&amp;sdata=UKY1HVky9RrcNGEU7MAqX1qWvb4MdGS5v7JGHLo7FDc%3D&amp;reserved=0 
> 
