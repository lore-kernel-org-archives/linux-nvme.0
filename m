From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 17 May 2013 09:41:07 -0400
Subject: [PATCH] NVMe: Fix a signedness bug in nvme_trans_modesel_get_mp
In-Reply-To: <1368478518-5892-1-git-send-email-vishal.l.verma@linux.intel.com>
References: <1368478518-5892-1-git-send-email-vishal.l.verma@linux.intel.com>
Message-ID: <20130517134107.GR6057@linux.intel.com>

On Mon, May 13, 2013@02:55:18PM -0600, Vishal Verma wrote:
> nvme_trans_modesel_get_mp() was defined with a unsigned return
> type, but can return signed values.
> 
> Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
> Signed-off-by: Vishal Verma <vishal.l.verma at linux.intel.com>

Applied
