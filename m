Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26524CF259D
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 06:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bw/D9038kfa2tpNI1ABOLEXvrV
	9fEX9gR0epzyqHJJHxc6C79ApW72EV9H7DBWwhZs1rDIHgou+7Oxoxy71RwzeDP4jn+BXElczbA7x
	+XdpbcshWUdjL6jBq//1ZKFBAIsJF/7fE6zSTjZ07JtcP9/onOYWD+MWY1eCzsrfCUKLh1q0RrGnM
	ZnOdmevKj3Ld73/9DMhaudFJGD5h0RqP8wNo+VZou/gkNk3ijOUrq4/W/T0SfJPIQ4RYmW4DAvVj2
	eDSb9eShltOdk6JbBtyKd2cY57MYwhDUJpEY5dT6xLK9X/uzqAIaIBB3eKdkAxg6gWlUpWOCi/A/D
	jasNBSZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0EJL-00000003qwB-0U7Y;
	Mon, 14 Oct 2024 06:12:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0EJE-00000003qsX-2qB9
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 06:12:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54FD5227AA8; Mon, 14 Oct 2024 08:11:51 +0200 (CEST)
Date: Mon, 14 Oct 2024 08:11:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v15 1/2] nvme: add reservation command's defines
Message-ID: <20241014061151.GB20775@lst.de>
References: <20241014061045.62436-1-kanie@linux.alibaba.com> <20241014061045.62436-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014061045.62436-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_231201_100500_075B3C97 
X-CRM114-Status: UNSURE (   8.93  )
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


