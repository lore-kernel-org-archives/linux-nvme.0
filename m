From: jg@lightnvm.io (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Tue, 9 May 2017 12:19:42 +0200
Subject: [PATCH] lightnvm: Remove an unused variable
In-Reply-To: <20170509093450.dgj3qghdwefpg6li@mwanda>
References: <20170509093450.dgj3qghdwefpg6li@mwanda>
Message-ID: <79988EFB-7909-4234-B4D9-435AAFAE2E07@lightnvm.io>

> On 9 May 2017,@11.34, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> "rq" is never used in nvme_nvm_rqtocmd().  We also recently shifted some
> code around so it's uninitialized and causes a static checker warning.
> Let's just remove it.
> 

Looks good. I didn't see it when I refactored that part.
Matias: If it is ok with you, can you pick it up?

Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170509/ffea115f/attachment.sig>
