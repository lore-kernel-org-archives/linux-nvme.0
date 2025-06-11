Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B335FC61CE7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 04:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z8iKv5bv8aZbQHnuodoDBkelNqDNhAuEF3apB+/FiAw=; b=G+Om2Sssk/Su5M5Ow3zfnCoXac
	1OWWkrZC0IHPkDxkrpsWJsd7i9nC35uaeLdNgnmHb8WhFzH25YpWudvYmY/59cBRj6NpKpq+JQcW+
	gTqBqf6ktVV7ZdvhUs4KTrYyaULB9jEIIbAKCRxE8zJT227ZUCLPIFUfrPoA/RTU/4mOg/fYbli6N
	7vz+ra3K3pw+GlULsUk59ObXvB+HahG/6cxiB2zNinm5tqnVxoBJoHmwcSlIg3WTHOPzr3NUOn8Nn
	8QWpHj9cduzhPIj+vfD/9ocYX92EVRBjAREoOSCpzVGe30t/Z/5Sa5/xOLrY125wEwryn31WHqfkz
	NpbC1iXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPDWH-00000008qrX-2Ndc;
	Wed, 11 Jun 2025 04:57:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPDWG-00000008qrM-3DSH
	for linux-nvme@bombadil.infradead.org;
	Wed, 11 Jun 2025 04:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z8iKv5bv8aZbQHnuodoDBkelNqDNhAuEF3apB+/FiAw=; b=Qm09RLvmu4vMEYc27u2ROl/FrP
	PHtE0WGMpdRD8mzYvI8otoFAhA5nA2yrv18dSCJxWokGqbN+i+QRKKi6Ije5dtcHye99cGA+OqWqI
	2sXWgjb8tE1vkI01ueMbHCr4t2Go809gMokBdcHKEcQQW59R9z3zRlqqrjAArJQF/p7Q3kYFigLCr
	tLA2D89cNoSAwuhoM29Y/Z4Zf3BiYZeAvd/kB/RdGk9X+7UYS3M/0EPy5adRyUUJ0lVFkGITtF9nU
	5C5V1AkVUIRfQE24CrAjhAcAAlBFLAWSGLJtJMOpPhqaPEy8GGnqBIhiXjaaGw7npYPKhxoofPvV9
	rtXJvWsA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPDWE-0000000276G-2FkL
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 04:57:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F52968AA6; Wed, 11 Jun 2025 06:56:48 +0200 (CEST)
Date: Wed, 11 Jun 2025 06:56:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, nilay@linux.ibm.com,
	sagi@grimberg.me, hare@suse.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: reset delayed remve_work after reconnect
Message-ID: <20250611045647.GA3925@lst.de>
References: <20250609184844.3158382-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609184844.3158382-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_055658_713622_42D2894C 
X-CRM114-Status: UNSURE (   7.32  )
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

Thanks,

applied to nvme-6.16 with a small typo fix in the subject.


