Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7107C7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 06:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/1/3Eikw8RwiASSzqiDyHhestujvL1djLVDAsiAWwM=; b=m8q+TBGGYAP0/Tcm1jfboGo9ec
	EGHBnKG2aiLL3uWcpKJYKk6Itc+lBOWWQK87Mus13OLBUq/X90cGFGaN3TvfDBUfGqw3nMqMZ46oI
	3Ddjn5A6iRkILJ4363ciqu4btWnbm3rBADqvk7GPM1sM386+iO06TzUCXn+su1ru9OUCsWpD24G7k
	QMqCnoCR/u/RPJNqOVy1iKknqwzR6jALFmtF3lQiCh50yHUwOXmxTIHATqtLksJb17XB+8XRuL+I7
	2JvvCqx8DfsKK0/h/Ezyb/RZkqTiSFuLIa6hpry7CHDUEpK2SFXS9V5LQ5QOa8mtQhI4MgMkvJIIl
	VJ4BCkKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW86G-00000001LMA-2skY;
	Mon, 30 Jun 2025 06:34:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW86E-00000001LKJ-1PBc
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 06:34:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92E4068AFE; Mon, 30 Jun 2025 08:34:30 +0200 (CEST)
Date: Mon, 30 Jun 2025 08:34:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Subject: Re: [PATCH RESEND] nvme: Fix incorrect cdw15 value in passthru
 error logging
Message-ID: <20250630063430.GA29582@lst.de>
References: <20250628181234.3978844-1-alok.a.tiwari@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628181234.3978844-1-alok.a.tiwari@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_233442_513992_CD5B2396 
X-CRM114-Status: UNSURE (   9.17  )
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

applied to nvme-6.16.

I fixed up the commit message to include a Fixes tag and drop the
mailing list reference.


