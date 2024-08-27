Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E33C52D6F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 03:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=z9grhw2FmPFkXDuI3mMQxVPL8F
	saJ4Jwz1gBz5U9tHjx5888FRAcx470tbmQqIaVwv//QkTmLYcYfiON1LY9VMDe/fsD5RS2N3b5oly
	mrQcHgKwjrqtLrgtIR8OAgf1t3Ixpp2ylS1mpATgUUjbj01z4XxBTttOlid+gC/7fiQ6okZxLU7Qo
	VX3AephaQ6QlRHSTS4IkJaDwiRlLPV78Om+6BMZ6gwmGdWjXmn//H2ONQ6cL9k1JeazdWjDSVdRNL
	UT4SewYAqKaI/3a6QCNd5y4TiRQhJzRDLIfsr04pVDtlpdR1AZvIkjz4fyQNU5vJslHdIfKG0CW4x
	75MuXfkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1simoV-00000009aNh-2XfH;
	Tue, 27 Aug 2024 03:24:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1simnL-00000009aCG-0wZW
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 03:23:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE938227AAA; Tue, 27 Aug 2024 05:22:55 +0200 (CEST)
Date: Tue, 27 Aug 2024 05:22:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] nvme: rename apptag and appmask to lbat and lbatm
Message-ID: <20240827032255.GB9442@lst.de>
References: <CGME20240826104721epcas5p2ed0968a3369d61762c8bfda767120e44@epcas5p2.samsung.com> <20240826103943.143962-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826103943.143962-1-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_202259_410984_A184C6CD 
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


