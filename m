From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Jun 2017 02:56:17 -0700
Subject: [PATCH 7/9] xfs: add support for passing in write hints for
 buffered writes
In-Reply-To: <1498004526-4543-8-git-send-email-axboe@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-8-git-send-email-axboe@kernel.dk>
Message-ID: <20170626095617.GF14057@infradead.org>

> +	ioend->io_bio->bi_opf |= write_hint_to_opf(inode_write_hint(ioend->io_inode));

Too long line again.

I think simply adding an inode_hint_to_opf() flag would make the various
opencoded versions of the above call a little easier to read.
