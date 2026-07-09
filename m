Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10637C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 05:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ikppEVVLyRbGyIVQzjPxwIfgJl
	IEU6iECpKC7I79oGmnBZxypwjABcVY64q5H4wxE6SwFtHJYWiLUXIQEoFRfjpRC52+IKZ00M2P2g6
	U0YC6EJBRiMQZg5kl/rR3Lx3QNYSb3uLe1YN5fRXGV3nR5FuHHuBTNrB0KV5cxeRvn3f2xmK9E7j7
	zyZumo5q7PzCs1L6UlOoUcfRdScf7PxI3xeqGIKR39spiqBMRUlhkXH6GGoR/vZRa3RFCGW+u9R3g
	S7wCI8NgJC4RfB7Wn2qh2XR8pv4KwZQHsfWcHn4fn8qLdDUCgQFXN6l0sF5IjJHp5ZZFDwkbCMSY2
	aAU2YAQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhlM-0000000168i-2e8k;
	Thu, 09 Jul 2026 05:57:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhlJ-0000000167Y-40Ni
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 05:57:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2837568BFE; Thu,  9 Jul 2026 07:57:27 +0200 (CEST)
Date: Thu, 9 Jul 2026 07:57:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>, Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v2 0/2] nvmet: add namespace-level debugfs for
 reservation state
Message-ID: <20260709055726.GB16298@lst.de>
References: <20260707121114.2273629-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707121114.2273629-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_225730_138463_09C9EFB6 
X-CRM114-Status: UNSURE (   9.06  )
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


