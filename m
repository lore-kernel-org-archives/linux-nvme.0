From: javier@cnexlabs.com (Javier Gonzalez)
Date: Thu, 22 Feb 2018 07:55:16 +0000
Subject: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
In-Reply-To: <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
 <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
Message-ID: <F70FB36A-967C-4B37-8037-C550249A0C3B@cnexlabs.com>

> On 22 Feb 2018,@08.45, Matias Bj?rling <mb@lightnvm.io> wrote:
> 
> On 02/21/2018 10:26 AM, Javier Gonz?lez wrote:
>> Complete the generic geometry structure with the maxoc and maxocpu
>> felds, present in the 2.0 spec.
>> Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 4 ++++
>>  include/linux/lightnvm.h     | 2 ++
>>  2 files changed, 6 insertions(+)
>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>> index cca32da05316..9c1f8225c4e1 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>>  	dev_geo->c.ws_min = sec_per_pg;
>>  	dev_geo->c.ws_opt = sec_per_pg;
>>  	dev_geo->c.mw_cunits = 8;		/* default to MLC safe values */
>> +	dev_geo->c.maxoc = dev_geo->all_luns;	/* default to 1 chunk per LUN */
>> +	dev_geo->c.maxocpu = 1;			/* default to 1 chunk per LUN */
> 
> One can't assume that it is 1 open chunk per lun. If you need this for specific hardware, make a quirk for it.
> 

Which default you want for 1.2 if not specified then? I use 1 because it
has been the implicit default until now.

Javier
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180222/9b10ae86/attachment-0001.sig>
