Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355A8C83F3E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 06:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BBtEKSWrHX7oRi7nDuVmg9+2L2x4e71Ci9OtLRXKd2c=; b=h+x+hG3Qn8PQeK8k1yODArnvDJ
	cmM8RuPXSHfjwCkdxvbm+VU3zdJER1W78ts0R1wCMJ8A4xMYzogGCLVI1cUS0Wfdxg6pOjyR1H6US
	xgoffWSsAJ92h2Ja7ct+V2SfBT3xPYcbGHfUviK7lsqQ6bLWRcDEMm6wfqF23H12kkenW81JDsDIX
	48VAUCtIwI1oqQEA/G0hRWjSzQ1gIPZztkejifCbo3TFTh/CQiJDuUlzdObV4dGZTj4qN0YwDQ9cn
	wozFJDD1FhHSSm4qqbtJczbZG4+IyVzfdDa6SDnxWklI8Fyc/Pd2z3FZj09zJaIutE0bgcyLZoaNY
	OmP0HPJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPtE-005M3r-34;
	Tue, 05 Sep 2023 06:50:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPrs-005M2r-2F
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 06:48:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82C3B68AFE; Tue,  5 Sep 2023 08:48:46 +0200 (CEST)
Date: Tue, 5 Sep 2023 08:48:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v1 1/4] nvmet-trace: avoid dereferencing pointer too early
Message-ID: <20230905064846.GA19701@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de> <20230829091350.16156-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829091350.16156-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230904_234856_893103_D8132D8B 
X-CRM114-Status: GOOD (  11.10  )
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

> +static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
>  {
> -	return req->sq->ctrl;
> +	if (!req->sq || !req->sq->ctrl)
> +		return 0;
> +	return req->sq->ctrl->cntlid;

Can you add a comment here why we have this check?

