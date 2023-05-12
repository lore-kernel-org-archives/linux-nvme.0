Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8424C77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dMXs8XAufJSiRMJKirI8VOMWJE
	zsNWSLQYPV6VXVSwueYH1ZxS76DEY0dpgx8pYuMs6Wfo60pwg3PbrI+/r/b7PcOa7v/9clNo7UNYV
	UgbRjkLa0uMUxgdkhALYNcMVEHUt7jymFqZ0o1iv00dnxiH8ELW+wAfMp5WVUPdt/n9NpRd+WyYaR
	pDX5oBf4r8jv6nZHnSih43jQ6ZF4RUz82K4MLvG8zWfvqQRfetRIXxKpNEPP0XGFMuv5OhciP+xwh
	udJSoSSToML4qb75Te02tb61q++6D90rpbOVJaqzK+CopnbT+aH+7l3QowZZ4eEVgwhgAExGp4KZN
	+CxCQ6/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxZQy-00CtcM-2H;
	Fri, 12 May 2023 20:32:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxZQw-00Ctbv-1L
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 20:32:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90B8D68AFE; Fri, 12 May 2023 22:32:07 +0200 (CEST)
Date: Fri, 12 May 2023 22:32:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, oren@nvidia.com,
	israelr@nvidia.com
Subject: Re: [PATCH v2 1/1] nvme: move sysfs code to a dedicated sysfs.c
 file
Message-ID: <20230512203207.GB21713@lst.de>
References: <20230424211242.19614-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424211242.19614-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_133210_622521_B17EF4F9 
X-CRM114-Status: UNSURE (   9.20  )
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

