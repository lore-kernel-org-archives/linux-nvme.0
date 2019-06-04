From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Jun 2019 09:18:16 +0200
Subject: [PATCH v2] nvme: Fix u32 overflow in the number of namespace
 list calculation
In-Reply-To: <CAJX3CtgdrbaPhFPnR13CT9mAQ8yVRyPFMjbFz01gcNz6G=2T_g@mail.gmail.com>
References: <1559604301-14042-1-git-send-email-jalee@purestorage.com>
 <CAJX3CtgdrbaPhFPnR13CT9mAQ8yVRyPFMjbFz01gcNz6G=2T_g@mail.gmail.com>
Message-ID: <20190604071816.GA15680@lst.de>

On Mon, Jun 03, 2019@04:42:28PM -0700, Jaesoo Lee wrote:
> The Number of Namespaces (nn) field in the identify controller data structure is
> defined as u32 and the maximum allowed value in NVMe specification is
> 0xFFFFFFFEUL. This change fixes the possible overflow of the DIV_ROUND_UP()
> operation used in nvme_scan_ns_list() by casting the nn to u64.
> 
> Signed-off-by: Jaesoo Lee <jalee at purestorage.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
