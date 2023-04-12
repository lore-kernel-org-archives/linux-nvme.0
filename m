Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A5EC7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IXgErTOU6MWjh0/bsDBJzPq3vIN+6PWS6ZsIFLUCqPY=; b=G0BOHPdfuALKuhVJT6nWJSwLGu
	Ge1zP9C3OT0V+ZCoBOxBYHULg8DvLYIWOD1B4IM2rGQZfJESBo/cPgw0nMkWi5xGB6GgkDri/VSDN
	huFpkGwwtfP2bWjV42yBWMAcmaq4ZNuvKq0RpwjnZ1JRWt8pT5UqIy9Io6IVqxgd+Hgcgkh2EcbaJ
	qSaBMfPNYiaVIrsCYPex/AcFskU3R3cRo+/bFpsTWi58fsR5CTyGm5+NsLQuuakhkCAf8MfnWTNfc
	TU0QlmxNtF0Ttjl85jJCczYgAgs7uDtR/Slry9wPzsS5+L8IsrJFFt72uhj7ACeLKIVFWx0qLGXP6
	4lVS7V6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmULy-0021hr-1m;
	Wed, 12 Apr 2023 06:53:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmULw-0021gr-00
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 06:53:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C97D168AA6; Wed, 12 Apr 2023 08:53:07 +0200 (CEST)
Date: Wed, 12 Apr 2023 08:53:07 +0200
From: "hch@lst.de" <hch@lst.de>
To: Jinyoung CHOI <j-young.choi@samsung.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-integrity: add rq_integrity_payload_size helper
Message-ID: <20230412065307.GA20550@lst.de>
References: <CGME20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4> <20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_235312_209025_7A9531A2 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
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

> +	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> +		return 0;

This should work for multiple segments as well.

