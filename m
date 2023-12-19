Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73084C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 05:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=On4YBZD3RpulvXbShI49afEuDd
	WMemAgbr+T8rfGzKubXmtEOGzqk4G7YPR9MTNYLCudmgyFYC59end19IqPRC9x+ZDAN1R3/A5EZUr
	7PZtyPwPG7uigg+L98E6BUW2VDLBGANYGxigBDavUVs+Dj7aLHI1v/hxbUGEM76ohkwF8M+ojoub4
	yfiIE5U5h0mzaPHAWicD5iCVI90TqDG+VmmVoGU1Ym34WE1BiaG4VyZJjSxch3QTzchoBrsaoapYp
	1vUi4sXjLuh/Fd20/XvnCOe+Eu6qr/4KcJ0otw1ZxGaM0uwd32OXNYJ1CxezdNpQe/LwLMLz/sRN1
	0HOqaTSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSYr-00Csr0-21;
	Tue, 19 Dec 2023 05:22:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSYo-00Csqa-2u
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 05:22:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B6CE68C4E; Tue, 19 Dec 2023 06:22:28 +0100 (CET)
Date: Tue, 19 Dec 2023 06:22:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Evan Burgess <evan.burgess@seagate.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: configfs: use ctrl->instance to track passthru
 subsystems
Message-ID: <20231219052228.GA530@lst.de>
References: <SN7PR20MB6609070761257AD91613E47B8090A@SN7PR20MB6609.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR20MB6609070761257AD91613E47B8090A@SN7PR20MB6609.namprd20.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_212231_377198_E26759C7 
X-CRM114-Status: UNSURE (   9.35  )
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

