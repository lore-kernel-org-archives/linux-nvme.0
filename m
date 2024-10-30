Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6B2D74961
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 04:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=rkY/+WvM2O2QLtMBWwu+rzp8To
	GgWG4dKkGYuMEq6+yFvvH8Jsga0++vQzAgK+3yCbW5i2Sn7YmcwZ/8uqI+5IW9g1WYqQQFEIHVxnh
	B1fnOMgwFfQ4UzCavhxtLjZPUc6kyVpDsfgkWZnPDDnYVVEq4JkpJ4pwIF+diJt42TrCk3YsDT85E
	K63VfpbR8Oi8kWTbcGbm8LqVtPmdi92DeEuXU0kK8uYe0ye8+f2GzEgQCNGcOl7gJDhzUykMssgBd
	Ov90w8WUbBEJrXeiqzsrlyLK701nBuhorJgIA4kUEooM8iS8QpbZUNCMRD/cK8gK5PpPl8SJdRTrG
	dUAHpdPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t60TF-0000000GgbW-0U8O;
	Wed, 30 Oct 2024 04:38:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t60TC-0000000Ggb5-11ez
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 04:38:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B764227A8E; Wed, 30 Oct 2024 05:38:06 +0100 (CET)
Date: Wed, 30 Oct 2024 05:38:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme-fc: fix race with connectivity loss and
 nvme_fc_create_association
Message-ID: <20241030043806.GA32190@lst.de>
References: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_213810_430549_B529003B 
X-CRM114-Status: GOOD (  10.72  )
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


