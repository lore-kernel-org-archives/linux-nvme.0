From: keith.busch@intel.com (Keith Busch)
Date: Wed, 9 Dec 2015 18:00:22 +0000
Subject: [patch] nvme: precedence bug in nvme_pr_clear()
In-Reply-To: <56686B55.7020900@fb.com>
References: <20151209102406.GD3173@mwanda>
 <56686B55.7020900@fb.com>
Message-ID: <20151209180021.GA31657@localhost.localdomain>

On Wed, Dec 09, 2015@10:56:37AM -0700, Jens Axboe wrote:
> On 12/09/2015 03:24 AM, Dan Carpenter wrote:
> >The "|" operator has higher precedence than "?:" so this didn't work as
> >intended.  I had previously fixed this bug, but it we copied the older
> >unfixed version when we moved the function between files.
> >
> >Fixes: 1673f1f08c88 ('nvme: move block_device_operations and ns/ctrl freeing to common code')
> >Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
> 
> Dejavu, but I guess in a different function. Christoph, you are
> hereby banned from ever using ?:!

Ah, that came from me. I wrote the patch on one machine, tested on
another. The tests required those issues be fixed, but the fixes didn't
propgate back to the original machine that generated the patch.

git user fail...
