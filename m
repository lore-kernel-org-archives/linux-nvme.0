From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 8 May 2018 22:10:57 -0700
Subject: [PATCH] nvmet: make the error message more generic
In-Reply-To: <20180508060233.4541-1-chaitanya.kulkarni@wdc.com>
References: <20180508060233.4541-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180509051057.GA28673@infradead.org>

On Tue, May 08, 2018@02:02:33AM -0400, Chaitanya Kulkarni wrote:
> "nvmet_check_ctrl_status()" is called from admin-cmd.c along
> with io-cmd.c, make the error message more generic.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
