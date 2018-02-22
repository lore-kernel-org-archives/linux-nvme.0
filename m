From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Thu, 22 Feb 2018 11:00:51 +0100
Subject: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
In-Reply-To: <BA0987F5-AEA5-43BD-A065-3BF72E9A8676@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
 <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
 <F70FB36A-967C-4B37-8037-C550249A0C3B@cnexlabs.com>
 <ec5d6c53-c3a1-7d66-9db7-407a519f0feb@lightnvm.io>
 <BA0987F5-AEA5-43BD-A065-3BF72E9A8676@cnexlabs.com>
Message-ID: <9c8c1b50-0c8e-36cd-0f1d-a07753567f43@lightnvm.io>

On 02/22/2018 10:52 AM, Javier Gonzalez wrote:
>> On 22 Feb 2018,@10.45, Matias Bj?rling <mb@lightnvm.io> wrote:
>>
>> On 02/22/2018 08:55 AM, Javier Gonzalez wrote:
>>>> On 22 Feb 2018,@08.45, Matias Bj?rling <mb@lightnvm.io> wrote:
>>>>
>>>> On 02/21/2018 10:26 AM, Javier Gonz?lez wrote:
>>>>> Complete the generic geometry structure with the maxoc and maxocpu
>>>>> felds, present in the 2.0 spec.
>>>>> Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
>>>>> ---
>>>>>   drivers/nvme/host/lightnvm.c | 4 ++++
>>>>>   include/linux/lightnvm.h     | 2 ++
>>>>>   2 files changed, 6 insertions(+)
>>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>>>> index cca32da05316..9c1f8225c4e1 100644
>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>>>>>   	dev_geo->c.ws_min = sec_per_pg;
>>>>>   	dev_geo->c.ws_opt = sec_per_pg;
>>>>>   	dev_geo->c.mw_cunits = 8;		/* default to MLC safe values */
>>>>> +	dev_geo->c.maxoc = dev_geo->all_luns;	/* default to 1 chunk per LUN */
>>>>> +	dev_geo->c.maxocpu = 1;			/* default to 1 chunk per LUN */
>>>>
>>>> One can't assume that it is 1 open chunk per lun. If you need this for specific hardware, make a quirk for it.
>>> Which default you want for 1.2 if not specified then? I use 1 because it
>>> has been the implicit default until now.
>>
>> INT_MAX, since it then allows the maximum of open chunks. It cannot be assumed that other 1.2 devices is limited to a single open chunk.
> 
> So you want the default to be that all blocks on the device can be
> opened at the same time. Interesting... I guess that such a SSD will
> have a AA battery attached to it, but fine by me if that's how you want
> it.

I feel you're a bit sarcastic here. One may think of SLC and other 
memories that does one-shot programming. In that case no caching is 
needed, and therefore power-caps can be limited on the hardware.

> 
> Assuming this, can we instead set it to the reported number of chunks,
> since this is the hard limit anyway.
> 

Works for me.
