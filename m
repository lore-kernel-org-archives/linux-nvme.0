Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B02C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 12:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXkiixr3KV9Mx0s78d0G0tbKuj0Y7rEU9i1vCYuNXzI=; b=P3YUpK2kSwufq9HZzQI/HU/8bq
	TMJ1rOW6xf+yIcsLfAKfHzHJekvcqHbAE/LJrQhGLL8nWa97qD/Fw3y2n9cgLPtuDkScYwcuNRDCB
	J0y/oN6tMKcw7FJaf4OfkRHqwDtuHWy1oCRwPYeepsWKo2vaZMentTPVnbBKflfC5iEACxMghT1kL
	KpbK/f8cctkDkANckEInTb4EnQXDiYTfQKYd07pEH60tx467pyyWOYt4TlcVy9vdfuiFx47okKh+y
	jpHR+Fob8jlluM09lJeme80AKgQ2wzv7skdV5QXyclznSb8DnwQuNkjTTah1wP9d/JUU5a6K8fV87
	Bn/4qlQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJKN-0000000BNKi-0QNo;
	Thu, 03 Jul 2025 12:46:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXINH-0000000BCXA-07gW
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 11:45:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1DB767373; Thu,  3 Jul 2025 13:45:03 +0200 (CEST)
Date: Thu, 3 Jul 2025 13:45:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, alan.adamson@oracle.com
Subject: Re: [PATCH] nvme: fix endianness of command word prints in
 nvme_log_err_passthru()
Message-ID: <20250703114502.GC17686@lst.de>
References: <20250630162153.4040149-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630162153.4040149-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_044507_210095_B74AD847 
X-CRM114-Status: UNSURE (   9.64  )
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

I tried to apply this to nvme-6.17, but it depend on the previous
cdw numbering fix in 6.16.  I guess we'll want to pick this up after
6.17-rc1 unless there's a need to rush it into 6.16.


