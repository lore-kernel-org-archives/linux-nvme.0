Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55153C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=LxqO4YKL3EO9agtsrDoPabN/u2
	RvPO7VP0uA8VeXXmr7tfYRt66Fhu3apqaOCcqaWKWWfSTni4kPGVEqWYlqC2sfSSZw10H5230S7dI
	uARQLTV9/hcvqh52oFPW0/brtwfYgWw5BrYTTIKXaZcfttx0OCXcCup7nviJ+E0qHRzccC4rBgac2
	jDMmBM4iq4sQudXpNuKVldhoXpEdh/t/0XBaYtv6spk5gtNZ+RTafGxtjhU2pE51ns3J7z43d93Jg
	3HMpu+eJW4BTMX7hdzTa/WE0IqcrXAR3fdtKDuNMPLnkMHQbzlqSQRZ1UYqkQFjvz/rt5DMJ4f1Jm
	pbOGECIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK02H-000h68-B6; Mon, 23 Jan 2023 16:51:09 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJzxQ-000f0U-0B; Mon, 23 Jan 2023 16:46:08 +0000
Date: Mon, 23 Jan 2023 08:46:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] improve nvme error logging
Message-ID: <Y865zzj0v+U+VEHx@infradead.org>
References: <1670855159-3182917-3-git-send-email-amit.engel@dell.com>
 <1670874036-3222795-1-git-send-email-amit.engel@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670874036-3222795-1-git-send-email-amit.engel@dell.com>
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

Thanks,

applied to nvme-6.3.


