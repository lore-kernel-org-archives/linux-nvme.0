Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117A4CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMO8bXjEPl+MR5jGJEeR2qe476rgeclIoWpM7gS2Odk=; b=fINWWl9btBifZvpaAj6DYg8PEg
	UEr/fjFTFHM1ZV2u5DOs4ysGnu6IY7Pe11hjnSyexPivz7QTeJy8ACkk0+F455U+YAsDeoHvlF9Xj
	HJmiL+eOfjEmWTN0UTHOnmqeBZgLGlA7ueuwlnkRn/Lhf561QKTVhdoUHc21t/+RZekndNehwP752
	3v65Ryz4qxjNdu99v/4VN/hCSMv1B4uXZqkrENtRkyfZwpRNO4jOLMvBJa6G7LEv2rX3Vw3SzoXmv
	5SSAuZ79RA7XeIjR+yyAtletNKjxq6lVq/hH2aV1zBsuM/n3lVnZ2AvorF5gA4fnWxYw0WEGRoDjM
	rA/9vcVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8ob-00F6aq-1m;
	Wed, 18 Oct 2023 15:50:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8oY-00F6YJ-2T
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 15:50:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD5F867373; Wed, 18 Oct 2023 17:50:20 +0200 (CEST)
Date: Wed, 18 Oct 2023 17:50:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, joshiiitr@gmail.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] nvme: fix error-handling for io_uring nvme-passthrough
Message-ID: <20231018155020.GA26481@lst.de>
References: <CGME20231018140334epcas5p128c55c56fb9203a19479cbf86175a1d6@epcas5p1.samsung.com> <20231018135718.28820-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018135718.28820-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_085030_954823_C102E9A4 
X-CRM114-Status: GOOD (  11.48  )
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

On Wed, Oct 18, 2023 at 07:27:18PM +0530, Kanchan Joshi wrote:
> @@ -508,8 +508,11 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>  	req->bio = pdu->bio;
>  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>  		pdu->nvme_status = -EINTR;
> -	else
> +	else {
>  		pdu->nvme_status = nvme_req(req)->status;
> +		if (!pdu->nvme_status)
> +			pdu->nvme_status = blk_status_to_errno(err);
> +	}

Hmm, shoudn't err take precedence over the nvme status?


