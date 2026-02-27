Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D326FEFB50
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=a81k8F1eSlms/0jAjzme9PIda9
	HXbGSkarxT3TSEZbujz11Uqaf4jKecOi8xWlfm2/OjZ3E6WPpEMlfQgtQelB2h3oicmXHeevoQ/wI
	EdXsAlqlYUYufLYHa9vLmxd3PmcwqGMHrQxIqdq6fnN5Ioi1cewykuph3BuBRXTQqO1PWsikSUq41
	E/P3q1+NRdhd2NhQNEo3cjPlR7gyhXd5CcM3JV8IlBrOw/cR2cA/XQlSQ/UmtkZSHaO4HpGz/U5tX
	YCJiIy5YLmIzV7oCCxKNFzUoxKLWqAZRMAPcR9jI5Tk7xYZbLofNg58d/D9z+CW8VO0L8zvSTgmZ7
	WQIC3Trw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyF4-00000008PCd-0Cjo;
	Fri, 27 Feb 2026 13:50:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyF0-00000008PB3-3iEb
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 13:50:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DC4068B05; Fri, 27 Feb 2026 14:50:46 +0100 (CET)
Date: Fri, 27 Feb 2026 14:50:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, mcgrof@kernel.org
Subject: Re: [PATCH] nvme: update comment about invalid LBA size
Message-ID: <20260227135046.GA20573@lst.de>
References: <20260227102332.1641359-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227102332.1641359-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_055051_064378_19457F23 
X-CRM114-Status: UNSURE (   9.12  )
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


