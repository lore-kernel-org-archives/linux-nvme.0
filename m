Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA06D1AD21
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 08:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ob9koKsm81su70veSN4BNdosHI
	liplQFnOHxK+CFgLNDXQwihOZPczWyCeeF3RnuiLkqA2XdExK7Xk9+Xj0P+/6B96dLpmhCSbhDyHU
	1Q2AmV91wVn8zssxdIr6Xw4h54QnyvUP7PospNUZKWOibk+X40EfiufOHoAedkkMNHzZP1yIPtAHm
	LDd2ZH6MinoAeLD6IxFdsaglCzqLeIyDgXsJdtI/DEo7UFyxB+Bw3zc91ntbMgG6QWzqXtCZaLG9m
	7cF+9hvabbGw32TqgVYucqnFKD8zyPaIw7fe+niHG/U3hzPjZiekU5FMO89c7NwsF7ddwAsEmsDPW
	1coYAlmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0yzb-0000000AvxK-12Ek;
	Wed, 16 Oct 2024 08:02:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ywb-0000000AvSX-1qSH
	for linux-nvme@bombadil.infradead.org;
	Wed, 16 Oct 2024 07:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HB9MbVkV5kpylRQv16AIZgr2SR
	aJxgMvdSWXSk0+puwXBOd2Rg1qpaZZR7qygd4WU0Ia7Vkmaj2svUT3IQPmP574BnkFCP1FlxRZNYC
	FmcLUl0glwYA3euY/UA5lYBkhJRkdgTXhU5rADsTNyb2QqUcZBTkGwMIKZdAO53FmY6Wh7swgBwU5
	nUr9vVB1PIMcQoPq0UxUwu1DA3tmvgLXwPAIciTlHlScTWxa10L/+6DxKx42Z2+JVJ0Db4WE79smd
	u1DbeV4zI5iNJi3+tpDOY3l1tpLo/R0uCIAS40MhvpL8Z3ki4hvI2iVUI0K+0fCRKusFuceCpwhns
	KczxfRrQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ywX-00000006kpm-47VN
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 07:59:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA94D227A8E; Wed, 16 Oct 2024 09:59:29 +0200 (CEST)
Date: Wed, 16 Oct 2024 09:59:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	dlemoal@kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v4 2/3] nvme: make keep-alive synchronous operation
Message-ID: <20241016075928.GA30313@lst.de>
References: <20241016030339.54029-1-nilay@linux.ibm.com> <20241016030339.54029-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016030339.54029-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_085942_230895_18F9F663 
X-CRM114-Status: UNSURE (   8.72  )
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


