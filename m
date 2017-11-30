From: keith.busch@intel.com (Keith Busch)
Date: Thu, 30 Nov 2017 14:40:29 -0700
Subject: [PATCH] nvme-cli: update show_registers_cc() to use nvme.h
In-Reply-To: <1512056957-17841-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1512056957-17841-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20171130214029.GB31358@localhost.localdomain>

On Fri, Dec 01, 2017@12:49:17AM +0900, Minwoo Im wrote:
> Replace constants for shift in show_register_cc() with macros defined.
> Also clean up a small typo (IOSQES to IOCQES).
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>

Thanks, applied.
