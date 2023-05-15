Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18DEC7EE23
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=; b=Ev5FhKPmXJCgci11GIabRBazvL
	jERZBAUQE4LHZ78EnTnfs8dRtBhwub1yxbQ1q0TJivlKOOcFplkGrpZWOLXIfSBZzY8AFh2GVjugt
	9vXtie96nLDzKh2I+zUr5MsoMszcXm2aHzSvigaxme6f9+pX2D2t4OxQ5cTOTButVKbVF50rUFXQm
	CmkkX91uGwEy5XGADgCXdaP448rhwa/Z/2xTM2rI95Lfb6simXOc9IWm0nauN0T2BwUvrdENoFECy
	4/b9G14JZODhj0E3LCo8HfLVbL1ZJgN4HdHMT6MT/xwKWJqLUpQvJTdfYlUrpt5EFSeNuCqO5ItW2
	decUWC7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyblt-002tNn-2m;
	Mon, 15 May 2023 17:14:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyblr-002tMz-0Y
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 17:14:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A7DB362B9F;
	Mon, 15 May 2023 17:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E501AC4339C;
	Mon, 15 May 2023 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684170842;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdl4s9MS6OZCQWiV2xOq1OIAM985+U7Af9mS5B40LPACapJMRW7GQuxAWuwojz4C3
	 dY3msFvcRZxbVXiiRIEE8uW2NCAhlqNQuqGeoL/tJpPg/feG8IZrBhr9zThRACkWf+
	 df8FWhEL5pLLmNmy27HQUBS7cmFxqpCTVZK2IIVTc/fpwzn9oP0Ddr/BGQOQKhzTeq
	 oNlW8bjXYbbPjCFKlHAqyMxiOf5vr4weCeTsah3PwwkKW/uLC7miT/CmCLKrRE3rWN
	 auF/IYsgjkiZtYATRnIaPgsbKGqScr2Eh14sZ25QT154gTrRkEVWP8U6UwHVYgVKMg
	 wGLKsCJs9nxnQ==
Date: Mon, 15 May 2023 11:13:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: cleaning up nvme_pci_init_request
Message-ID: <ZGJoVjWehzDjbhfY@kbusch-mbp>
References: <20230512060537.70097-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512060537.70097-1-irvincoteg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_101403_255084_872C86D2 
X-CRM114-Status: UNSURE (   7.09  )
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

Thanks, applied to nvme-6.5.

