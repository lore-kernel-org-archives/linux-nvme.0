From: keith.busch@intel.com (Keith Busch)
Date: Thu, 2 Mar 2017 13:34:25 -0500
Subject: [PATCH] nvme: Correct NVMF enum values to match NVMe-oF rev 1.0
In-Reply-To: <CAG4TOxM-2Xs55ja1jWcGEbjez0K3ofcf5_7mH1D+Zzz09MLeyQ@mail.gmail.com>
References: <20170302022201.2946-1-roland@kernel.org>
 <20170302155242.GA31807@infradead.org>
 <20170302160227.GD14852@localhost.localdomain>
 <20170302155613.GA9623@infradead.org>
 <CAG4TOxM-2Xs55ja1jWcGEbjez0K3ofcf5_7mH1D+Zzz09MLeyQ@mail.gmail.com>
Message-ID: <20170302183425.GA6857@localhost.localdomain>

On Thu, Mar 02, 2017@10:08:24AM -0800, Roland Dreier wrote:
> On Thu, Mar 2, 2017@7:56 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > Grr, damn github pull requests that defeat review..
> 
> Are mailing list patches or github pull requests preferred for
> nvme-cli changes?  (Christoph I know how you'll answer, more wondering
> about Keith ;)

Just considering the convenience, I can pull github requests from just about
anywhere in the world with one click on my phone. It's a slightly more
involved process to apply email patches. :)

I'm really okay with either, though substantial changes should be sent to
the mailing list first since that is our single source of all linux-nvme
related reviewers. I currently rely on our best judgement to decide what's
mailing list material, but if Christoph or anyone is really concerned
about this, I will concede the mailing list as the preferred path.
