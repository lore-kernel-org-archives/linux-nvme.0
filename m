Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227F1F54ACE
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=13mSfhwoJnBqmY1EsJwHTBOxgqivJHqYKUs2RuNr1oI=; b=oqeI5UFJVF7K5jQDGs17RW+ebP
	z3uWI3Jh2gs52rkN/bj6emk34WnWLqvFnGtXd/UrtcWGFksZDCEB4wlzvgXqQuXBElQnMoGR2kqkf
	E2pJENPRfqmwApjcvtwA8lzlCPLsERexm63sHQBT3TNKVjTQB//9kPfb3GtwkN5TPJOpgjAr1JGYF
	U2WQSRahoXDpC6TMzP3ccAZMvP8xZPmT+HBZ0lPikN7d57f1TBG++23ZuYfof8G28Rezntzmk26kM
	olvx6HmzISEsEnChGnnKKys9RC6sdpi1AVV4J/TmG/AIyGDiF8MHMjABzDN0HJUSPbxw+AgANkbJG
	ruhZwCyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53hm-00000001lGT-3Txc;
	Tue, 24 Mar 2026 15:30:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53hl-00000001lGC-1gcJ
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 15:30:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 95C6660127;
	Tue, 24 Mar 2026 15:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1AAC19424;
	Tue, 24 Mar 2026 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774366204;
	bh=13mSfhwoJnBqmY1EsJwHTBOxgqivJHqYKUs2RuNr1oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGjenFxloxdE0wGlXiPTnIk+vIo9YE9svZHSACGKIIz2qiHwnamX/AkyrgFZ906Kf
	 Jd+uYk7uyDBJT3gV887DoosRSw66317W0f1CZiFirOiNj4fFhg+5HxYNXhUtvXzDtY
	 JjhzMeXb3Ha9rTXOFoM0RWrcrExlLkunTgjBruJaZwnYg9xDH0xEe5ediq5ZYFEka4
	 PfzWo9mTOz2tKRuRybO+VgrCj86qnWMM06+A/TaUK5spAzOMl9L21svaV0G8XviSjj
	 RN7eGDVja/0ODdEygo8mdel3NVHBTh/RA4hNYy8ukiRoIZ0vmhtqXAt366YPJW8o6+
	 oMuXjF9mWXo4Q==
Date: Tue, 24 Mar 2026 09:30:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, gjoyce@ibm.com
Subject: Re: [PATCH 1/1] nvme-loop: do not cancel I/O and admin tagset during
 ctrl reset/shutdown
Message-ID: <acKt-pvG0B7diqoN@kbusch-mbp>
References: <20260313113856.1366774-1-nilay@linux.ibm.com>
 <20260313113856.1366774-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313113856.1366774-2-nilay@linux.ibm.com>
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

On Fri, Mar 13, 2026 at 05:08:48PM +0530, Nilay Shroff wrote:
> Cancelling the I/O and admin tagsets during nvme-loop controller reset
> or shutdown is unnecessary. The subsequent destruction of the I/O and
> admin queues already waits for all in-flight target operations to
> complete.

Thanks, applied to nvme-7.1.

