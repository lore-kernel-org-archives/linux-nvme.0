Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F8CC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XkxHoBeEYfco2aHf5CyMh6MwINRQ4ANAky6An9jkK9o=; b=1HbmNedUgbyY38NOtBqByzcFEJ
	oTdy1oKYGpWCg+ZCnYdX673iIUOs7G8OZyaLQ+RKN1a+Z09iL9dNEuAeazbuV3NFBEv1/G2wDyxTA
	mf1iuPkwxQ57Wu1AnZ1d4jydlEU3rTwV4Cq0aQtoMmiS7M9CEweC6hfsADVc2kadRDK3XTkkHZtRg
	zY6wOgs+6+j3SSZEuWYxlsEjsNaHNA4SzdXKyNaQle2JdAY4UPXCINmeZ/21PwTrssYq8IXv/Skp2
	GT0EylxBtus+ilHsyYpTNHycgsqlMtUa80I/I7NWvpsPCZNJnEtfp+6S2b6Vm97SZcl7WaPbxw6no
	q+iJD40Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Y9k-009iKs-Nx; Tue, 06 Dec 2022 13:38:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Y9i-009iGx-P1
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 13:38:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6781A68B05; Tue,  6 Dec 2022 14:38:33 +0100 (CET)
Date: Tue, 6 Dec 2022 14:38:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 8/9] nvme-pci: return early on ctrl state mismatch in
 nvme_reset_work
Message-ID: <20221206133833.GB25727@lst.de>
References: <20221129132208.4337-1-hch@lst.de> <20221129132208.4337-9-hch@lst.de> <Y48m2+Mn1W6E4Xs9@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y48m2+Mn1W6E4Xs9@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_053843_010286_127012EB 
X-CRM114-Status: GOOD (  12.41  )
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

On Tue, Dec 06, 2022 at 11:26:19AM +0000, Keith Busch wrote:
> Yeah, the only way something like that should happen is if a reset and
> remove happen near the same time. We don't want the reset work to
> disable the controller because the remove is already doing that.

Thanks, I've stole some of this for a better commit log.

