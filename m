Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E9FC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=0t4M3El8FL84E1ns/+0WX/SIwu
	wf8g2m+XFE79oAO7Dql4IvEkKGuR/bNdMb4/hIspLZtPeNqTOILlQj9mJDMNb96xRNgh8G4YXurkr
	shDiJoWoMYCgoqtxzJrxBSbbDV60Llu+nixWH1FohdAnSv0vLrljFX911pl9PDz9q69l3yOSrccvA
	P0C9SIEAvJbpwCMeFQtGnhWmAiyvVToqSadJ1ClSQt1xLFgzmyH3l170ecKDIz/bcsz5lf5n4iP/0
	47lLdVfI86RCFVxAN/oAJEz1KbL9n6uHhUeNjmGFOLnevH6KKBFb7ITdS061Dxr8jFTiajEKNV7/J
	riDINWEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97bj-00BEot-76; Wed, 06 Jul 2022 16:10:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97bg-00BEmf-KP
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 16:10:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9177068AA6; Wed,  6 Jul 2022 18:10:19 +0200 (CEST)
Date: Wed, 6 Jul 2022 18:10:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Chris Egolf <cegolf@ugholf.net>
Subject: Re: [PATCH] nvme-pci: phison e16 has bogus namespace ids
Message-ID: <20220706161019.GA1844@lst.de>
References: <20220705172102.3522189-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705172102.3522189-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_091028_852447_BCF6ABD3 
X-CRM114-Status: UNSURE (   7.28  )
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

applied to nvme-5.19.

