From: roland@kernel.org (Roland Dreier)
Date: Fri, 12 Jan 2018 12:00:32 -0800
Subject: [PATCH 1/2] nvme-fabrics: Fix memory leak when parsing host ID
 option
In-Reply-To: <20180112101656.cscb4rhv3dj264cc@linux-x5ow.site>
References: <20180111213800.1767-1-roland@kernel.org>
 <20180112101656.cscb4rhv3dj264cc@linux-x5ow.site>
Message-ID: <CAG4TOxMi4SMVL8ETKvjSocB37Rj_P=vc5cMsVv81WBgM-muU8w@mail.gmail.com>

On Fri, Jan 12, 2018@2:16 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> Looks good,
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
>
> Do you mind fixing the same pattern on:
> - NVMF_OPT_TRANSPORT
> - NVMF_OPT_NQN
> - NVMF_OPT_TRADDR
> - NVMF_OPT_TRSVCID
> - NVMF_OPT_HOST_TRADDR
> as well?

Thanks for the review.  I don't think the same pattern is there for
the other options - a pointer to the string is
stored in opts and freed in nvmf_free_options(). NVMF_OPT_HOST_ID is
unique in that we don't stash the
strdup'ed pointer anywhere.

 - R.
