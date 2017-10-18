From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 17 Oct 2017 23:30:27 -0700
Subject: AHCI NVMe remap update
In-Reply-To: <CAD8Lp450TSnpzTAGiAgKjJws6VnVu9ZWv_x-GFQ5RhNOTnNCpQ@mail.gmail.com>
References: <CAD8Lp450TSnpzTAGiAgKjJws6VnVu9ZWv_x-GFQ5RhNOTnNCpQ@mail.gmail.com>
Message-ID: <20171018063027.GA12755@infradead.org>

On Wed, Oct 18, 2017@11:01:33AM +0800, Daniel Drake wrote:
> Would be great if you could take another look at this.

The right way to do this would be to expose a fake PCIe root port
that both the AHCI and NVMe driver bind to.  But only Intel has the
detailed information to do this.  Especially as we'd have to do
things like recovering the exact PCI ID for quirks in the NVMe driver
to make this whole scheme work reliably.
