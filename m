From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 8 Oct 2013 09:10:36 -0400
Subject: [PATCH RFC 0/2] Convert from bio-based to blk-mq
In-Reply-To: <1381224862-5299-1-git-send-email-m@bjorling.me>
References: <1381224862-5299-1-git-send-email-m@bjorling.me>
Message-ID: <20131008131036.GC7422@linux.intel.com>

On Tue, Oct 08, 2013@11:34:20AM +0200, Matias Bj?rling wrote:
> The nvme driver implements itself as a bio-based driver. This primarily because
> of high lock congestion for high-performance nvm devices. To remove the
> congestion, a multi-queue block layer is being implemented.

Um, no.  You'll crater performance by adding another memory allocation
(of the struct request).  multi-queue is not the solution.
