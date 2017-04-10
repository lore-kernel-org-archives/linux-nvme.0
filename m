From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 10 Apr 2017 08:37:32 -0700
Subject: [PATCH v7 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <b421e5a1-d60d-10b0-1d26-33a38298e01e@collabora.com>
References: <20170330173324.GH20181@localhost.localdomain>
 <1490895961-28828-1-git-send-email-helen.koike@collabora.com>
 <20170331070128.GA28852@infradead.org>
 <b421e5a1-d60d-10b0-1d26-33a38298e01e@collabora.com>
Message-ID: <20170410153732.GA4196@infradead.org>

On Sat, Apr 01, 2017@06:50:03PM -0300, Helen Koike wrote:
> 
> Hi Christoph,
> 
> Thanks for reviewing this patch
> 
> On 2017-03-31 04:01 AM, Christoph Hellwig wrote:
> > I'd still prefer to not hide the MMIO path behind nvme_write_doorbell,
> > but except for that this looks fine to me:
> > 
> 
> Do you mean wrapping the call to writel()? What do you think if I send a new
> version with the changes below? It wouldn't hide the call to writel()
> inside nvme_write_doorbell anymore.

Yes, that's the version I'd prefer.
