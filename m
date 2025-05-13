Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F11CC3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Kb2fCW4Nl+wuCE79zh9Em4E1xjxPRlg5oAc24SiRPw=; b=BZKXCEwhMbYNAoo4iH9KqL9JR2
	CGfaqKB2sY6r5xXPDqN96Mo5rYPeLs6WMP8c+oBA8LkOKbshey/VSduLBQS8cKluAm4JW9XB+MocL
	5muJoRxYz6U9WeGbDEOLmKeEFhGNrCGAuV4r+OV8FBD/yZ3LQdEwvkX98NfbKxPCqGRhjw7wgc0v9
	Qqh5Gp7VN2AH+SkS1+nhyt1iTTjSL775W7VdUarItcrql/zGODJjDsebT0CGyJO/B79cXUR0tnijE
	al0oxXRWWJN938SoYUkzwntCglojQnr0RUVqpSTwWKEv/CTEcvH0sAoHqx3g/ccOzYc57Z04ICZQr
	S3GLDu9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEk4J-0000000BcJz-3qe7;
	Tue, 13 May 2025 07:28:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEk4H-0000000BcJZ-1vMz
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 07:28:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D27484468C;
	Tue, 13 May 2025 07:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFAFC4CEE4;
	Tue, 13 May 2025 07:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121328;
	bh=fNLi7A42jT63ZfkpsaeL0L5lOIxitEvYLe0dRij2s08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=souRhCXfiu3jsVuwuuzHeadGMIcjG/psTlndh3rixG6b1JRfcRxhk5tsbRruePmH0
	 CFpiXWQrj417Aep08vClTrIXETvnvvflzJ6tFWwFQlc1UMmZvhgmuMrt1GYs4Qj31g
	 0/4/NPXt6NzXA7HOS4Ug2ahalmqIAh1xVlRuJBTI0gBcsAcm8FiSQxeue7TpMdNWE+
	 r5qjxBWPrrOEykMQK1ME9LN+De8KSWTNbXBzkxzOL/Ya2nINZZXM+FXEcI5V9wIyuL
	 6qDBCdEjculampTxv6A08QXfNfocHA3M00GwWn4t8431luCH06MvdrzmJopvW6bMk3
	 XQZr9xpTNRwbQ==
Date: Tue, 13 May 2025 10:28:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/7] nvme-pci: don't try to use SGLs for metadata on the
 admin queue
Message-ID: <20250513072842.GH22843@unreal>
References: <20250513070025.830930-1-hch@lst.de>
 <20250513070025.830930-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513070025.830930-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_002849_514197_FFC058A1 
X-CRM114-Status: GOOD (  20.95  )
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

On Tue, May 13, 2025 at 09:00:17AM +0200, Christoph Hellwig wrote:
> No admin command defined in an NVMe specification supports metadata,
> but to protect against vendor specific commands using metadata ensure
> that we don't try to use SGLs for metadata on the admin queue, as NVMe
> does not support SGLs on the admin queue for the PCI transport.  Do
> this by checking if the data transfer has been setup using SGLs as
> that is required for using SGLs for metadata.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e6b6b6ee0878..24f5292a349b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -971,7 +971,10 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct nvme_dev *dev,
>  
>  static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
>  {
> -	if (nvme_pci_metadata_use_sgls(dev, req))
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&

Won't it be more future error proof to check for NVME_CMD_SGL_ALL?

Anyway current proposal is also fine.

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>

