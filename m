From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 13 Mar 2018 08:12:52 +0000
Subject: [pci PATCH v5 3/4] ena: Migrate over to unmanaged SR-IOV support
In-Reply-To: <20180312172309.3487.76690.stgit@localhost.localdomain>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172309.3487.76690.stgit@localhost.localdomain>
Message-ID: <1520928772.28745.53.camel@infradead.org>

On Mon, 2018-03-12@10:23 -0700, Alexander Duyck wrote:
> 
> -???????.sriov_configure = ena_sriov_configure,
> +#ifdef CONFIG_PCI_IOV
> +???????.sriov_configure = pci_sriov_configure_simple,
> +#endif
> ?};

I'd like to see that ifdef go away, as discussed. I agree that just
#define pci_sriov_configure_simple NULL
should suffice. As Christoph points out, it's not going to compile if
people try to just invoke it directly.

I'd also *really* like to see a way to enable this for PFs which don't
have (and don't need) a driver. We seem to have lost that along the
way.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5213 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180313/a3ed0f1f/attachment-0001.bin>
