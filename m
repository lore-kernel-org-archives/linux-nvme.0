Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33D9C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=b+bhWJnq006/po1jlbl12oCks9
	o8PNn6z1jlBaw3fmAN5VMe7ywRU0d5niKpLFnd8AWjuMtV8BnoqHspHDOIh3f+zrJZQmeDlxeLZ5g
	ReBnliAWWRrBLxrwSke6bF5SaSvYq392TcrOsDoCKFH4SQJU04lmnX7+JoajqPzfPGYREdVNGLWQ7
	AD2bOMwZWO0o3hjHVLFVwh4PCOgqWd1TYIxJdsAy33a1WG6i0Ngi5xg7Gu1SRCE4Hl6E0PTUsfFt6
	4SfeXc27Pa5eQTBx9ZAa5kC/vFii7wRbUNNZ+mLq6q6PNEWPCN0UEHwof6hb7PfcUaumbeCfleQKE
	cdoNpehA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmhbP-0000000FRx4-05se;
	Mon, 24 Feb 2025 23:11:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmhbM-0000000FRwS-18Ji
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 23:11:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4097668C4E; Tue, 25 Feb 2025 00:11:00 +0100 (CET)
Date: Tue, 25 Feb 2025 00:10:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/6] nvme-ioctl: fold open_for_write into flags
Message-ID: <20250224231059.GA16691@lst.de>
References: <20250224182128.2042061-1-kbusch@meta.com> <20250224182128.2042061-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182128.2042061-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_151104_440824_38A504C5 
X-CRM114-Status: UNSURE (   8.45  )
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


