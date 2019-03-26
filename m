From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 26 Mar 2019 15:50:01 +0800
Subject: [PATCH 2/4] nvmet: fix computation of io vector number
In-Reply-To: <20190326073800.GB21617@lst.de>
References: <20190326031928.9499-1-ming.lei@redhat.com>
 <20190326031928.9499-3-ming.lei@redhat.com>
 <20190326073800.GB21617@lst.de>
Message-ID: <CACVXFVNTOVcP7N_MCZ+JEUJX09WUH0Ds3yZ_DELrSkAfPEDrpg@mail.gmail.com>

On Tue, Mar 26, 2019@3:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I'd rather see this merged with the last one (and patch 3 dropped as
> it just gets removed entirely in 4) - that fixes all the issues together
> and doesn't require your patch 1 as as a workaround first.

Patch 1 isn't a workaround, which is needed for stable tree, and
the other fixes won't work without patch 1.

However, we may revert patch 1 for 5.1 in which multi-page bvec
is supported.

I am fine to merge the last three in one patch since the backporting
isn't too hard for me, :-) However I guess our stable guys may prefer to
simpler fix.

Thanks,
Ming Lei
