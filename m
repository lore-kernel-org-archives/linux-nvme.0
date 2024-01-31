Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14120C48285
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 06:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BaPJ+f66FmMttiTGh0UdfsvjbG
	0yvKKww61gUqiIkxshA6i9AzDZE1QyNiJtqrxwGJFNf2EDh15lDkCgII+S0Gh+rEwLmn2R9PpyFGz
	g1EaMYDYfJ1i15STIeo4hVUPZ3IxgW7vg4kGAHHsuSdLwtSv35yyWhFxZLuY8yjoSmnHhPhXrnAsW
	uQUgF6lOu1FYlof/oqpf16jq9CbnMkgAN90uTh3Csi9x3eAf+Rujy0lKaXtvwfDo6HDnlNEuGzmqe
	yy8Jz9w+X07FwAhWguEFi49zd3eZt/bnyfC5kSpYWcRg3xZ6l3EKDQOceH+eyT6vQrub2TksWL65F
	pRkTwUbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV45p-00000001fJB-2d0o;
	Wed, 31 Jan 2024 06:29:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV45m-00000001fHJ-2cmo
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 06:29:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0647668B05; Wed, 31 Jan 2024 07:29:00 +0100 (CET)
Date: Wed, 31 Jan 2024 07:28:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/12] nvmet-fc: take ref count on tgtport before
 delete assoc
Message-ID: <20240131062859.GJ16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-12-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-12-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_222902_862777_A75702CC 
X-CRM114-Status: UNSURE (   9.84  )
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

