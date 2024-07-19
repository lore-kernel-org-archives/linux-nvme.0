Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1C6C3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 05:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=CH1sBwOCliHZoiRoVtTMfPA0ER
	cKzH4U7dkry66Ckx0xFoQOgJarewHVrTXZKMd/n89IewniuwcaYo6i7HJW6G8dhXdZ7ASh7i8rkDd
	b4BJSaQF2V+NKhU0gbIaXgnFt3Z+NuxZBeGitTA9kNDjMBuRG6R8xRzapC8366g9NUCHNrWViZWP4
	UlKtATPseHOnSRq48mCMlSCJ9e5Tc6oS27EJNq+TeWGdBS8y62mETmxpvUWCxJ1dwxd4Avp72p2HK
	xoelCbLtH8MtSgbIJ7B+Vnqs7Bbw6d1cWmKsXzGJiWEOkBFZ7Igr0M1GldhElu/pvr+Z7wAmQEye4
	Ou05OESA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgIx-00000001f2t-2EG1;
	Fri, 19 Jul 2024 05:37:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgIt-00000001f1g-0xLp
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 05:37:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB7D068BFE; Fri, 19 Jul 2024 07:37:12 +0200 (CEST)
Date: Fri, 19 Jul 2024 07:37:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/8] nvme: add a newline to the 'tls_key' sysfs
 attribute
Message-ID: <20240719053712.GB21604@lst.de>
References: <20240718144858.19074-1-hare@kernel.org> <20240718144858.19074-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718144858.19074-5-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_223715_416650_EFD0566C 
X-CRM114-Status: UNSURE (   9.90  )
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

