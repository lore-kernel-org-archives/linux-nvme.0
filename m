From: mlin@kernel.org (Ming Lin)
Date: Tue, 26 Jan 2016 10:11:02 -0800
Subject: [PATCH 2/2] NVMe: Fix io incapable return values
In-Reply-To: <20160126165415.GC609@infradead.org>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <1453757017-13640-2-git-send-email-keith.busch@intel.com>
 <20160126165415.GC609@infradead.org>
Message-ID: <CAF1ivSZEoSbnQTiJFYh+pjdz1FdhO=Hhq96mjf8OZuWS7asNoA@mail.gmail.com>

On Tue, Jan 26, 2016@8:54 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jan 25, 2016@02:23:37PM -0700, Keith Busch wrote:
>> The function returns true when the controller can't handle IO.
>
> Ooops.  I though I had actually seen a fix for this a short while
> ago, not sure why that got missed.

Yes, you saw that. It is in NVMeOF driver.

>
> Acked-by: Christoph Hellwig <hch at lst.de>
