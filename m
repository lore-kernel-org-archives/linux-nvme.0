Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A05DC87FCE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2E4q/VTewWdAiwGBze8dCv3IXOy5Ea14A1k3uP8YBWc=; b=jfvAgFUBUNiVTGOZEPutNb016R
	tnyIM2ONMka5rR906mh9S6oX5n4QsNhD4DYKDPKQZS3E0tL5VXu4hjmvr9ijduMqzDdCxBoVjTKuN
	Lvqk8H2fcLHjfh/TRo8KqAk93Z5q+6OVdTWhfSbyfpbojvCLK+pu2W0LCw8BdyPMw8q8wGPabExLs
	YXVGbp1tvJyRV7BpSo+MqyJq8vdJPSaw5VpwsqGQblOkfM7vycftuHGKAxwyisv+NasPWl0dwhbB0
	HvaSBs5Y8jqj8Kq5CU8mlxt/yyaDeQGe+ndgGrmQouDXhziSX8LFV7FAymQZ2qSUIqnQ+6Xu6bAV2
	ynKu8Fsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh99R-00000001tje-1FdL;
	Wed, 30 Jul 2025 15:55:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh986-00000001tYw-17Wb
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 15:54:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1C6868B05; Wed, 30 Jul 2025 17:54:06 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:54:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	inux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] nvme-auth: remove unneeded semicolon
Message-ID: <20250730155406.GD19799@lst.de>
References: <20250725075722.1974953-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725075722.1974953-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_085410_437507_60613574 
X-CRM114-Status: UNSURE (   8.15  )
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

Thanks, applied to nvme-6.17.


