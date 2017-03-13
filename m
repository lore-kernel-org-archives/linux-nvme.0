From: keith.busch@intel.com (Keith Busch)
Date: Mon, 13 Mar 2017 12:54:40 -0400
Subject: [PATCH] nvme-cli: bug-fix: use right file name for perror.
In-Reply-To: <1489360404-16256-2-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1489360404-16256-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1489360404-16256-2-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <20170313165439.GA25758@localhost.localdomain>

On Sun, Mar 12, 2017@04:13:24PM -0700, Chaitanya Kulkarni wrote:
> Use right file descriptor while printing an error, when
> --metadata option is used for read/write commands.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>

Applied, thanks for the fix.
