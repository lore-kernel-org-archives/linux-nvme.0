Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B3606A891
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KVjERxDH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mMNwc/L5WVh73MBuimgul84oe/8CoXdF45cgMt+e8jc=; b=KVjERxDHAQQ8WUXnpMiew2oGZx
	A8qDMl/JYy7828d6oLftWSdKZ7Shbg6mIGbmcomboJ5oRat5LRzAFswNZyqPA8pVmeAMCJlWoZHeD
	Gn1p0tCdasx7+ZIqv6Cz0lieE5dmF9MsGiu8wXG+TniFm6tADFrQ3efho8oCpAwahH8Ohu4WS4ZhH
	OrJGP/sDxkIE3+G5CHHLFgC5s5n8zI8z6wgArFIA4at+mPYu7AnxbV67psd/KB8Z0rvOQBc1lEV3w
	50eZyutmkyRtsaOSDMM8bmmpFv3TgbdMi7t1cW13mGB/MyuEiYkW32gLcdG08L4bGOJcTlYyTNY6S
	mAQST0Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRBPp-00000007Do4-10d9;
	Wed, 11 Nov 2026 16:43:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRBPn-00000007DnW-23nL
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 16:43:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E6CB68D17; Wed, 11 Nov 2026 17:43:12 +0100 (CET)
Date: Wed, 11 Nov 2026 17:43:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmet: use overflow-safe range checks in the file
 backend
Message-ID: <20261111164311.GB18076@lst.de>
References: <20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn> <20261111224247129g0VbfWdGlwDMhBpChnT-8@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111224247129g0VbfWdGlwDMhBpChnT-8@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_084315_684281_09E672AC 
X-CRM114-Status: GOOD (  24.68  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 10:42:47PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> The file backend shifts a host-supplied SLBA to form a byte offset
> before checking it against the namespace size. The shift can discard
> high bits: with a 4 KiB block size, SLBA 2^52 + 1 becomes offset 4096.
> The range check then accepts a command aimed outside the namespace and
> the backend accesses data at the wrapped offset.
> 
> Reject overflowing LBA-to-byte conversions and check the transfer
> length against the remaining namespace size without adding it to the
> offset. Apply the checks to reads, writes, discard and write zeroes.
> 
> Fixes: 9c891c139894 ("nvmet: check fileio lba range access boundaries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> 
> Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
> and a 4 MiB file-backed namespace.
> 
> A Write with SLBA = 2^52 + 1 and a 4 KiB block size yields a byte
> offset that wraps to 0x1000 and passes the size check:
> 
>   unpatched                            patched
>   ret=0 (write accepted at 0x1000)     ret=24705 (Capacity Exceeded)
>   drivers/nvme/target/io-cmd-file.c |   41 +++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932e..d59dbf61b1b0 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -125,17 +125,22 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
>  	size_t len = 0, total_len = 0;
>  	ssize_t ret = 0;
>  	loff_t pos;
> +	u64 pos64;
>  	int i;
>  	struct scatterlist *sg;
>  
>  	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
>  		is_sync = true;
>  
> -	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
> -	if (unlikely(pos + req->transfer_len > req->ns->size)) {
> +	if (unlikely(check_shl_overflow(le64_to_cpu(req->cmd->rw.slba),
> +					req->ns->blksize_shift,
> +					&pos64) ||
> +		     pos64 > req->ns->size ||
> +		     req->transfer_len > req->ns->size - pos64)) {

This condition looks like something that should be factored into a
helper to a bit more readable and so that the pos64 variable can be
hidden inside it.

Otherwise looks good.


