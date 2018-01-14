From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 11:27:07 +0200
Subject: [PATCH 1/2] nvme-fabrics: Fix memory leak when parsing host ID
 option
In-Reply-To: <CAG4TOxMi4SMVL8ETKvjSocB37Rj_P=vc5cMsVv81WBgM-muU8w@mail.gmail.com>
References: <20180111213800.1767-1-roland@kernel.org>
 <20180112101656.cscb4rhv3dj264cc@linux-x5ow.site>
 <CAG4TOxMi4SMVL8ETKvjSocB37Rj_P=vc5cMsVv81WBgM-muU8w@mail.gmail.com>
Message-ID: <ad6b60fa-6b03-957c-b3b1-623034cea30a@grimberg.me>


> Thanks for the review.  I don't think the same pattern is there for
> the other options - a pointer to the string is
> stored in opts and freed in nvmf_free_options(). NVMF_OPT_HOST_ID is
> unique in that we don't stash the
> strdup'ed pointer anywhere.

Agreed, thanks Roland,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
