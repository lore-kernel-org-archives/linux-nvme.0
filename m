From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Oct 2017 00:59:43 -0700
Subject: [PATCH V6] nvme-pci: add SGL support
In-Reply-To: <20171009180300.GD19329@localhost.localdomain>
References: <1507232903-9532-1-git-send-email-ckulkarnilinux@gmail.com>
 <1507232903-9532-2-git-send-email-ckulkarnilinux@gmail.com>
 <20171009180300.GD19329@localhost.localdomain>
Message-ID: <20171016075943.GB14943@infradead.org>

On Mon, Oct 09, 2017@12:03:00PM -0600, Keith Busch wrote:
> There's two loops here doing essentially the same thing, but I don't
> think the single segment needs to have a special case.

Except that for the larger case we'd need another branch for the
indirection entry.  I'm not sure it's clear cut either way, so I'd
just let Chaitanya chose which one he prefers.
