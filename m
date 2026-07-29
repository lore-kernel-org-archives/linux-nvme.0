Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA3DC53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Z0UfM9Idf0hJb9hdMYAO6tKEF8
	t9UFmCRoeWy2fsWy0Q7EduWsegzswdvrRlR7uqCumkX46l7d7hLozbQ+LHtJCCq/QV+KHAauiybvy
	zoA1H8YUc6byQRByBjzfZcGEqNP9hvNrmAGwq/HCbnZHs0YqYaFMgXq4tBfNykf5qK86lmVAREe+f
	kFTZgWfLg23II4FxnhhhVlaoiR6loAKdZ5PbPdMOZjGi6Vp5LNTDfuJRTngNPwdFynDJvdO95mp8N
	45Qd2wnzD8DvO8D87Or0f7zKqbGvfglXQv0oTAcsZObQqYZDfeYxSu2TQPNJBCWP5XEQ4HuIuFQYg
	4r1eNYEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2Wr-00000007jki-3tHA;
	Wed, 29 Jul 2026 11:32:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2Wo-00000007jjU-48G5
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:32:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B310368BEB; Wed, 29 Jul 2026 13:32:47 +0200 (CEST)
Date: Wed, 29 Jul 2026 13:32:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Jay Freyensee <james_p_freyensee@linux.intel.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/4] nvme-fc: unmap cmd_iu DMA on rsp_iu mapping
 failure in init_request
Message-ID: <20260729113247.GB31402@lst.de>
References: <20260729105846.1401843-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729105846.1401843-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_043251_172420_7EA830EC 
X-CRM114-Status: GOOD (  10.39  )
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


