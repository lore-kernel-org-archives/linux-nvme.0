From: mlin@kernel.org (Ming Lin)
Date: Tue, 9 Feb 2016 16:09:19 -0800
Subject: [PATCH 4/4] nvme: split pci module out of core module
In-Reply-To: <20160209092650.GE21250@lst.de>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-5-git-send-email-mlin@kernel.org>
 <20160209092650.GE21250@lst.de>
Message-ID: <CAF1ivSbi4ujnBkcmEpvW3jrJcz_g4fofHrrTmO-N5c7nkwz13A@mail.gmail.com>

On Tue, Feb 9, 2016@1:26 AM, Christoph Hellwig <hch@lst.de> wrote:
> Looks fine,
>
> but as Johannes poined out we'll probably need some Kconfig magic
> to keep existing configfs working.

I didn't find the magic.
So just keep the old CONFIG name in v2 patches.
