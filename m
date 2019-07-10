From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jul 2019 18:38:53 +0200
Subject: [PATCH v2] nvme: fix multipath crash when ANA desactivated
In-Reply-To: <516302383.30860772.1562736406606.JavaMail.zimbra@kalray.eu>
References: <1575872828.30576006.1562335512322.JavaMail.zimbra@kalray.eu>
 <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com>
 <20190709212904.GB9636@lst.de>
 <516302383.30860772.1562736406606.JavaMail.zimbra@kalray.eu>
Message-ID: <20190710163853.GB25486@lst.de>

On Wed, Jul 10, 2019@07:26:46AM +0200, Marta Rybczynska wrote:
> Christoph, why would you like to put the use_ana function in the header?
> It isn't used anywhere else outside of that file.

nvme_ctrl_use_ana has a single caller in core.c as well.
