From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Jun 2017 02:51:48 -0700
Subject: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
In-Reply-To: <1498004526-4543-2-git-send-email-axboe@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-2-git-send-email-axboe@kernel.dk>
Message-ID: <20170626095148.GB14057@infradead.org>

Please document the userspace API (added linux-api and linux-man
to CC for sugestions), especially including the odd effects of the
per-inode settings.

Also I would highly recommend to use different fcntl commands
for the file vs inode hints to avoid any strange behavior.
