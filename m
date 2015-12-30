From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 Dec 2015 10:09:54 -0800
Subject: [PATCH 1/5] NVMe: Fix admin queue ring wrap
In-Reply-To: <56841A23.1010000@fb.com>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-2-git-send-email-keith.busch@intel.com>
 <56841A23.1010000@fb.com>
Message-ID: <20151230180954.GA27087@infradead.org>

On Wed, Dec 30, 2015@10:53:39AM -0700, Jens Axboe wrote:
> I missed this during review, which is a little sad since I ran into the same
> thing in the initial conversion of the nvme driver to blk-mq.

Another reason to finally add a comment and explain the magic one off..
