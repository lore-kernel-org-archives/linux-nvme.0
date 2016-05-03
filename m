From: javier@cnexlabs.com (=?iso-8859-1?Q?Javier_Gonz=E1lez?=)
Date: Tue, 3 May 2016 16:14:42 +0000
Subject: [PATCH] lightnvm: pass dma address to hardware rather than pointer
In-Reply-To: <1462288968-763853-1-git-send-email-arnd@arndb.de>
References: <1462288968-763853-1-git-send-email-arnd@arndb.de>
Message-ID: <E3EC5236-A5C4-4D52-9BE3-9BF382434D46@cnexlabs.com>

> 
> On 03 May 2016,@17:22, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> A recent change to lightnvm added code to pass a kernel pointer
> to the hardware, which gcc complained about:
> 
> drivers/nvme/host/lightnvm.c: In function 'nvme_nvm_rqtocmd':
> drivers/nvme/host/lightnvm.c:472:32: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>  c->ph_rw.metadata = cpu_to_le64(rqd->meta_list);
> 
> It looks like this has no way of working anyway, so this changes
> the code to pass the dma_address instead. This was most likely
> what was intended here. Neither of the two are currently ever
> written to, so the effect is the same for now.
> 

Thanks Arnd.

It was my mistake. I had it fixed in the pblk branch, where we use the
metadata field and was waiting to send it together with other fixes.

Javier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160503/71226fdc/attachment.sig>
