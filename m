Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C75CC6B08
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlBC0q49k81MKuNEpjpc2UFQI0+KekKsQS4k6uGwbow=; b=p8QZfLHmtSsYf41vxo4Rsk04Z4
	yxZvNk2ockH8h1q7Wbc5p1bH+T5WRZuKc9Z+hFPZbmTGAL11/4hcO9mVB+KsKSsKMA2U6lcST6GVY
	G4lewi1X2XP/OCf65tLiNwmd8QXpnv94xpGKplpgzzwDRpkvuFJEZh2Fg0KMlf3DXar45/p/xu906
	Xag+S+wmbQ+k/7sWJtYZtOBmmRXUXxoA9U2tA/itv/Gk9Z+pfQMkUW139U43b74xD1k0sKvxoAv9z
	ovg17e4Qnw5INzJue44rNFInA38r7FkGfSTc0IzJd29WzyrbHxSltXHlJIJW5ioR2hf+k8+V8RnBV
	PN5OqAcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdT4-0000000D5UY-2FOX;
	Tue, 13 Oct 2026 14:27:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdSv-0000000D5Sq-0gIM
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:27:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EFD88227A88; Tue, 13 Oct 2026 16:26:49 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:26:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] nvmet: zns: reject a NUMD whose byte count wraps
Message-ID: <20261013142649.GD14759@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-4-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012141239.156408-4-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_072659_025495_3D508603 
X-CRM114-Status: GOOD (  24.98  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 12, 2026 at 04:12:30PM +0200, Andrea Parri wrote:
> Zone Management Receive computes its buffer size as (numd + 1) << 2 in
> u32, in nvmet_bdev_validate_zone_mgmt_recv(),
> nvmet_bdev_zone_zmgmt_recv_work() and
> nvmet_bdev_execute_zone_mgmt_recv(). NUMD is a 32-bit dword count, so
> any NUMD from 0x3fffffff up wraps.
> 
> The data length check in nvmet_bdev_execute_zone_mgmt_recv() sees the
> same wrapped value, so such a command can pass it. A data length that
> does not match the wrapped size is already rejected by that check, with
> Data SGL Length Invalid. Every site agrees on the wrapped size, so the
> target zeroes and fills only that many bytes and nothing leaks, but it
> answers a command whose NUMD asks for 4 GiB or more.
> 
> Reject a NUMD from U32_MAX / 4 up with Invalid Field, next to the
> existing check for a NUMD smaller than the report header. Computing the
> size in size_t instead would still wrap on 32-bit kernels, where
> nvmet_check_transfer_len() and req->transfer_len are 32 bits wide.
> 
> nvmet_io_cmd_transfer_len() in core.c uses the same expression and is
> left alone here.
> 
> Tested over the loop, tcp, rdma and fc transports with a zoned
> null_blk namespace: a wrapping NUMD, sent with a data length that
> matches the wrapped size, was accepted before this patch and now fails
> with Invalid Field, while ordinary NUMD values still succeed.
> 
> Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  drivers/nvme/target/zns.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index 78d82b6ff1214..14689ca0c38af 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -150,14 +150,17 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
>  static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
>  {
>  	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> -	u32 out_bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
> +	u32 numd = le32_to_cpu(req->cmd->zmr.numd);
> +	u32 out_bufsize = (numd + 1) << 2;
>  
>  	if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
>  		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, slba);
>  		return NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
>  	}
>  
> -	if (out_bufsize < sizeof(struct nvme_zone_report)) {
> +	/* From U32_MAX / 4 up, the byte count wraps and no longer matches NUMD. */

Overly long line here.

> +	if (numd >= U32_MAX / 4 ||
> +	    out_bufsize < sizeof(struct nvme_zone_report)) {

I guess to make various sanitizers happy we probably should only
calculate out_bufsize after bounds checking numd?

Otherwise this looks good.


