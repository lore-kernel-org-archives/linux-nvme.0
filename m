Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9CFC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/zY4xTIhQtmc/gDZH7RwDbiv7m7ofv8iuU1r0g2W4Ow=; b=TlOcHt7zfidJgGotJXk5ZeP5cE
	aRtUx6ccwcSPKYJHBVFZ6jc8za3COw4ZInVZ7/Y0svVcKhO+v6e7OOIuiOlEQjEC5cSLH9B852VAT
	pyvHY8x2MJl0MmqS0a2QAztIlJnwHKUF4X4Jd6xl03ClKv5vyCGrL4xaYyMNRHJhXgi2+VJejpdCY
	pxkNfGfDRac50EzkEVhEGryrZ6NeNTPuu5eLSCg3qffzMIy8Boo145tBochICSvnhXU9FvQx0nfEP
	komiWbqXvey3c1Oe+yMJIYiqoJAfQyDjqjwdt2h8+AcMM3ShiQtbc5Fzj4nJnMKtqBckLtHw18NrJ
	zF25Z69w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMXvR-00000007zkn-1e5c;
	Wed, 26 Jun 2024 19:03:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMXvP-00000007zk8-0f2s
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:03:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7F56361CE4;
	Wed, 26 Jun 2024 19:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863C1C116B1;
	Wed, 26 Jun 2024 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719428602;
	bh=7+Nq0+MW9vhhLumkoD91tY27IX6kXn9OtvDNRs8Njfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEWCzLqCUxEKg9C7ufB2cNXWxUWQKf91/IAuAiAHx7q6LldqrLR/lXhmT0Yr89zvN
	 xAK2wIzqTnIdq5igOojAFjxt3wnCXPlw80sPTo4+BJJKtMF0T3QCFUTrAc10FfiASq
	 rc0P4tKaxtcW+Plf/mFuzooCpwIo9Kb85ejhVb4OLrKfp5UgmG3+nmJ8ivZJI/iX2N
	 ClNPfIv6XtEyKxyaPIGuA9n5oj3BkS51Bug/16QOBLmODAogrcxqu9QGe38XU1HFlO
	 7osxBb61Pl0UHikfcCGzj+wfg+0+vRLqE4A308RXdILnp9iojPerF/N50xo1Kl4305
	 fb/aBKejK9yoQ==
Date: Wed, 26 Jun 2024 13:03:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: sagi@grimberg.me, emilne@redhat.com, hare@kernel.org, kbusch@meta.com,
	linux-nvme@lists.infradead.org, mlombard@redhat.com
Subject: Re: [PATCH v2 7/7] nvme: add reserved ioq tags for cancel
Message-ID: <Znxl9kFmoJWg1S0D@kbusch-mbp.dhcp.thefacebook.com>
References: <50a62d8e-b45e-4ae0-81dc-f12c46a5a65b@grimberg.me>
 <20240626183819.23960-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626183819.23960-1-jmeneghi@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_120323_261834_8C13FDED 
X-CRM114-Status: GOOD (  12.00  )
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

On Wed, Jun 26, 2024 at 02:38:19PM -0400, John Meneghini wrote:
> If the nvme Cancel command is supported, we need to reserve 2 tags for
> each IO queue. Note that one addition tag is reserved to account for
> the case where this is a fabrics controller.
 
> @@ -4580,9 +4581,13 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  	 */
>  	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
>  		set->reserved_tags = NVME_AQ_DEPTH;
> +	else if  (effects & NVME_CMD_EFFECTS_CSUPP)
> +		/* Reserve 2 X io_queue count for NVMe Cancel */
> +		set->reserved_tags = (2 * ctrl->queue_count);

The reserved_tags are already per queue, no need to multiply.

>  	else if (ctrl->ops->flags & NVME_F_FABRICS)
>  		/* Reserved for fabric connect */
>  		set->reserved_tags = 1;

You mentioned an addtional tags is supposed to be reserved for fabrics.
Shouldn't this just be an "if", not an "else if", and then increment
reserved_tags?

