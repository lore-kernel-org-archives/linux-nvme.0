From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 23 Jul 2015 02:53:51 -0700
Subject: [PATCH v5 4/5] null_blk: LightNVM support
In-Reply-To: <1437587464-7964-5-git-send-email-mb@lightnvm.io>
References: <1437587464-7964-1-git-send-email-mb@lightnvm.io>
 <1437587464-7964-5-git-send-email-mb@lightnvm.io>
Message-ID: <20150723095351.GB26420@infradead.org>

Any reason you're adding this to null_blk instead of having a separate
null_nvm driver?
