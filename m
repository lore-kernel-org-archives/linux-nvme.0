Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64081C25B47
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=07RYNUuh/vOKuf1fpExOLkrcvJ
	9OdmeJ7RZaJwM1Yl0KRq8S0jJO2fab3Jm7iOg3LHY5b7E1Hesa6P78B8EJtEthOTFn72r2uEqutkN
	XtdmWzgsiFtbnHnj2tJ3ejlqupcP/DvlzKYy04TnrFL+4CTNQeVt5FKe7HwoRnC5krFrsH9gcJ6mF
	9yF4MZuPUm2tPqD9lvJgWur6XJ7lt0D9z57Gy/Lq4FddLZUqHO/HDffP5dXAdDji7d0+lgy+pVeDc
	ScsbBvVQnswwu9DvwPX9y5Meno+H4hOSxzwc0xtK3TYF5Q/yhWzbdnvSgEp+HWM3XUB6w1110+kYV
	lD0fIh4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvBEY-0090ob-2n;
	Tue, 24 Oct 2023 06:49:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvBEV-0090o2-2y
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 06:49:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4659F6732D; Tue, 24 Oct 2023 08:49:41 +0200 (CEST)
Date: Tue, 24 Oct 2023 08:49:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	hare@suse.de
Subject: Re: [PATCH v2 2/3] nvme-auth: add flag for bi-directional auth
Message-ID: <20231024064940.GB9847@lst.de>
References: <20231023140003.58019-1-shiftee@posteo.net> <20231023140003.58019-3-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023140003.58019-3-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_234944_122649_D5F4E2E7 
X-CRM114-Status: UNSURE (   8.26  )
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

