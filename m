From: javier@cnexlabs.com (Javier Gonzalez)
Date: Mon, 26 Feb 2018 18:21:13 +0000
Subject: [PATCH] lightnvm: pblk: remove unused variable
In-Reply-To: <423c58a6-afde-5ebe-6199-78ff2661d8ac@lightnvm.io>
References: <1519651129-17897-1-git-send-email-javier@cnexlabs.com>
 <423c58a6-afde-5ebe-6199-78ff2661d8ac@lightnvm.io>
Message-ID: <829B1AB7-A09B-4CA8-BA71-70B354E5E612@cnexlabs.com>


> On 26 Feb 2018,@19.20, Matias Bj?rling <mb@lightnvm.io> wrote:
> 
> On 02/26/2018 02:18 PM, Javier Gonz?lez wrote:
>> Remove unused variable after a previous cleanup (a8112b631adb)
>> Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c | 3 ---
>>  1 file changed, 3 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index ce6a7cfdba66..e6cb4317bb50 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1071,7 +1071,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
>>  	struct nvm_geo *geo = &dev->geo;
>>  	struct pblk_line_meta *lm = &pblk->lm;
>>  	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>> -	int nr_bb = 0;
>>  	u64 off;
>>  	int bit = -1;
>>  	int emeta_secs;
>> @@ -1087,8 +1086,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
>>  		bitmap_or(line->map_bitmap, line->map_bitmap, l_mg->bb_aux,
>>  							lm->sec_per_line);
>>  		line->sec_in_line -= geo->c.clba;
>> -		if (bit >= lm->emeta_bb)
>> -			nr_bb++;
>>  	}
>>    	/* Mark smeta metadata sectors as bad sectors */
> 
> Should Fixes be added?

It's not a bug as such, that's why I didn't add it. But be welcome to do
so if you think it's better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180226/33c21c90/attachment-0001.sig>
