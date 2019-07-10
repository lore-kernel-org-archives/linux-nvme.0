From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Wed, 10 Jul 2019 07:26:46 +0200 (CEST)
Subject: [PATCH v2] nvme: fix multipath crash when ANA desactivated
In-Reply-To: <20190709212904.GB9636@lst.de>
References: <1575872828.30576006.1562335512322.JavaMail.zimbra@kalray.eu>
 <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com>
 <20190709212904.GB9636@lst.de>
Message-ID: <516302383.30860772.1562736406606.JavaMail.zimbra@kalray.eu>



----- On 9 Jul, 2019,@23:29, Christoph Hellwig hch@lst.de wrote:

> On Sat, Jul 06, 2019@01:06:44PM +0300, Max Gurtovoy wrote:
>>> +	/* check if multipath is enabled and we have the capability */
>>> +	if (!multipath)
>>> +		return 0;
>>> +	if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) != 0))
>>
>> shouldn't it be:
>>
>> if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) == 0))
>>
>> or
>>
>> if (!ctrl->subsys || !(ctrl->subsys->cmic & (1 << 3)))
>>
>>
>> Otherwise, you don't really do any initialization and return 0 in case you have
>> the capability, right ?
> 
> Yes.  FYI, my idea how to fix this would be something like:

Thanks both, error when changing the condition on my side. I submit the next
version very soon.

Christoph, why would you like to put the use_ana function in the header?
It isn't used anywhere else outside of that file.

Regards,
Marta
