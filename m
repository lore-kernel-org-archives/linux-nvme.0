Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EF5C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=reOVl4bwYei2ygnIrNH08GUiPV
	h8y9DXyjZ6rXbsncD/hHP/zQ/JejzQ+xjgTDWlsoocR8MjYoWTNWukVz/QqOOmmvWpVUboPgMTfYf
	NdRYcLdjnQ6Rb3XhsQPM11KMcswqvbuHqNDVp7Ra5tYNvmgXxIOJOjfRdEXzkcVlhNE+XUviKP2O1
	DIVDDc0QPBO7n520yEmaEgtNaMR0jgwUWTGgxcmIPMWol+xynRxWWN9Zh/fGMVAf7zani40PkC0Zh
	BKqrw0o+VERpXiU7aAp7GZQSsUEx8dI2xH1rdAA6Vxas//woVW6ic9uYFMvQNlpshM+Wxo82IdomV
	ctjhSVYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1LwN-0098KC-1o;
	Tue, 23 May 2023 06:56:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1LwL-0098Ia-0Z
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 06:56:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70BB068B05; Tue, 23 May 2023 08:56:10 +0200 (CEST)
Date: Tue, 23 May 2023 08:56:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH 2/3] nvmet_auth: use common helper for buffer alloc
Message-ID: <20230523065609.GB8224@lst.de>
References: <20230522083713.107001-1-kch@nvidia.com> <20230522083713.107001-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522083713.107001-3-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_235613_361013_BA7BD471 
X-CRM114-Status: UNSURE (   8.63  )
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

