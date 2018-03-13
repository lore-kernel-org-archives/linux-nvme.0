From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 13 Mar 2018 09:14:16 +0000
Subject: [pci PATCH v5 3/4] ena: Migrate over to unmanaged SR-IOV support
In-Reply-To: <20180313085442.GA1537@lst.de>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172309.3487.76690.stgit@localhost.localdomain>
 <1520928772.28745.53.camel@infradead.org> <20180313081628.GA618@lst.de>
 <1520930719.11412.2.camel@infradead.org> <20180313085442.GA1537@lst.de>
Message-ID: <1520932456.11412.6.camel@infradead.org>



On Tue, 2018-03-13@09:54 +0100, Christoph Hellwig wrote:
> On Tue, Mar 13, 2018@08:45:19AM +0000, David Woodhouse wrote:
> Because binding to pci-stub means that you'd now enable the simple
> SR-IOV for any device bound to PCI stub.??Which often might be the wrong
> thing.

No, *using* it would be the wrong thing (bad root; no biscuit).

Except when the PF doesn't have SR-IOV capability anyway, in which case
who cares.

Or when the PF does have SR-IOV capability and root has ensure that
she's doing the right thing.

I understand the arguments about disallowing root from doing bad
things. Not that I agree with them. But simply changing to a
*different* driver seems pointless.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5213 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180313/090f5acf/attachment-0001.bin>
