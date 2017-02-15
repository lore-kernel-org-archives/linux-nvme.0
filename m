From: axboe@fb.com (Jens Axboe)
Date: Tue, 14 Feb 2017 19:47:50 -0700
Subject: [PATCH V6 1/3] uapi: sed-opal fix IOW for activate lsp to use
 correct struct
In-Reply-To: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>
References: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>
Message-ID: <9cd7e86f-7d2f-f58e-65c1-7f7ddd85b904@fb.com>

On 02/14/2017 05:29 PM, Scott Bauer wrote:
> The IOC_OPAL_ACTIVATE_LSP took the wrong strcure which would
> give us the wrong size when using _IOC_SIZE, switch it to the
> right structure.

Applied 1-3, thanks.

-- 
Jens Axboe
