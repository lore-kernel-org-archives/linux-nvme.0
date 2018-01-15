From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 15 Jan 2018 08:44:20 +0100
Subject: [PATCH 1/2] nvme-fabrics: Fix memory leak when parsing host ID
 option
In-Reply-To: <CAG4TOxMi4SMVL8ETKvjSocB37Rj_P=vc5cMsVv81WBgM-muU8w@mail.gmail.com>
References: <20180111213800.1767-1-roland@kernel.org>
 <20180112101656.cscb4rhv3dj264cc@linux-x5ow.site>
 <CAG4TOxMi4SMVL8ETKvjSocB37Rj_P=vc5cMsVv81WBgM-muU8w@mail.gmail.com>
Message-ID: <20180115074420.4yzcro6ufn4ohm5r@linux-x5ow.site>

On Fri, Jan 12, 2018@12:00:32PM -0800, Roland Dreier wrote:
> On Fri, Jan 12, 2018@2:16 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> > Looks good,
> > Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> >
> > Do you mind fixing the same pattern on:
> > - NVMF_OPT_TRANSPORT
> > - NVMF_OPT_NQN
> > - NVMF_OPT_TRADDR
> > - NVMF_OPT_TRSVCID
> > - NVMF_OPT_HOST_TRADDR
> > as well?
> 
> Thanks for the review.  I don't think the same pattern is there for
> the other options - a pointer to the string is
> stored in opts and freed in nvmf_free_options(). NVMF_OPT_HOST_ID is
> unique in that we don't stash the
> strdup'ed pointer anywhere.

Correct. I'm sorry for the false alarm.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
