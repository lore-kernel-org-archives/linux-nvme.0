Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D415C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8YrcD6dpBkWetrITcppYG3SGMANVAWjRG79Ho99E23w=; b=jXjcp56+OQQ3SXzpVjppyNIffP
	utUynpOqfMesJWj62xBiN65PERPYuINkxm7vwt9aRRmkw8rjKpRufeO2mNBOoLYtL/7gmeOp9CI/G
	QFb2xYq5l/bEI82DSClrAsvyiSmE7PvN5G2c2wRnnLmEghIYs9sWBizaLbAM2sUrp1d430vSspLz4
	JGxUHz6UkvLAC56ga7eeoTZjTfCDST5fTjg+GdXCCjDaoJPVHiKMXa16/2H0jcofDYN8ORDZpCZ/b
	5nE/+c/DEX8muLKGxiQ+zUmjMJYZVZ0fM2/Df6V274kSteNAII00yjj3Lv4U1l7W7/XPmVwiXhxNt
	h5THQAgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAMU-00000008I6Y-3iXH;
	Mon, 13 Jul 2026 06:41:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAMS-00000008I5t-0E8G
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 06:41:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2627868BEB; Mon, 13 Jul 2026 08:41:44 +0200 (CEST)
Date: Mon, 13 Jul 2026 08:41:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com
Subject: Re: [PATCH nvmet-v1 1/1] nvmet: zns: reject full zone report when
 buffer is too small
Message-ID: <20260713064143.GB29416@lst.de>
References: <cover.1783579899.git.liuxixin@kylinos.cn> <a7c3e91b4d20.1783579899.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7c3e91b4d20.1783579899.git.liuxixin@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_234152_243153_947A46F7 
X-CRM114-Status: GOOD (  22.89  )
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

On Thu, Jul 09, 2026 at 02:51:39PM +0800, Xixin Liu wrote:
> Zone Management Receive uses the Partial Report (PR) bit in dword 13.  On a
> partial report (PR bit set), the host accepts an incomplete listing and
> Number of Zones must not exceed the zone descriptors copied to the host
> buffer.  On a full report (PR bit clear), Number of Zones is the total
> number of matching zones and every descriptor must fit in the buffer (ZNS
> Command Set Specification Rev 1.2, section 3.4.2).
> 
> nvmet_bdev_zone_zmgmt_recv_work() already caps Number of Zones for partial
> reports, but on a full report it may still succeed when the buffer only
> holds part of the matching descriptors.  Reject the command in that case.
> 
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>  drivers/nvme/target/zns.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index f00921931eb6..a53986fcc04a 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -295,11 +295,20 @@ static void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
>  	}
>  
>  	/*
> -	 * When partial bit is set nr_zones must indicate the number of zone
> -	 * descriptors actually transferred.
> +	 * Partial report (PR bit set): the host accepts an incomplete listing,
> +	 * so cap Number of Zones to the descriptors that fit in the buffer.
> +	 * Full report (PR bit clear): Number of Zones is the match count; fail
> +	 * if the buffer cannot hold every matching zone descriptor.
>  	 */
> -	if (req->cmd->zmr.pr)
> +	if (req->cmd->zmr.pr) {
>  		rz_data.nr_zones = min(rz_data.nr_zones, rz_data.out_nr_zones);
> +	} else {
> +		if (rz_data.nr_zones > rz_data.out_nr_zones) {
> +			req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, numd);

Overly line here.  Easily fixed by using and else if above.


