Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE73C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=foUosPy+PP4ppDjDo74WZHKMV0lc/CVBIwOk5TfACAk=; b=zVFyNeMpL64rlptiwlYT8Wan+H
	q13RsDh2+zCLoelcfcUG3ldLQZNpcQl+ea/yGQhbsLURS++Qf9Lu1c6CStyVBIOixvWLo2kwHPk5y
	pqrP2DjIk6qtWjlMMX2VW+xZh2Ap2G61LCq6Cn7PjouoNXhLEch7pouuounf/ThO2StzG5M0DEqgG
	pQqNcsH2QpYcd/0dEE0r2ruvsO52zqSZWi+AccZusP2O/QmXH2pQvJwN2sho3VNr6gSeLmqOdsp4o
	g4U9paE/4DgTDZSagaGQFmukRChJp9WJC2sjbJetcNtNV2415a238dpMjmvzCvbJYMve+kqGFrGHv
	JIdvVzUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQQY-00000004SRF-0gSN;
	Mon, 12 Feb 2024 07:08:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQQW-00000004SQq-0ZAQ
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:08:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88F66227A87; Mon, 12 Feb 2024 08:08:25 +0100 (CET)
Date: Mon, 12 Feb 2024 08:08:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, djeffery@redhat.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/5] nvme: Add two-pass shutdown support
Message-ID: <20240212070825.GC17718@lst.de>
References: <20240207214044.2374295-1-jallison@ciq.com> <20240207214044.2374295-6-jallison@ciq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207214044.2374295-6-jallison@ciq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_230828_342004_3CFE6040 
X-CRM114-Status: UNSURE (   9.82  )
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

> +		/*
> +		 * NVME_PCI_DISABLE_SHUTDOWN_TWOPASS requests shutdown
> +		 * but doesn't wait for completion.
> +		 */

Nit: please use up the normal 80 character line length for comments if
possible.  Same for at least one other comment further down.

Otherwise this looks good.

