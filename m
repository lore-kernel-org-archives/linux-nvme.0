Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640CEC48BC2
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:17:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3633861001
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3633861001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YbefcrVhq11Hl33PchQyp9J8Iok4XjO8vvKduAHcI20=; b=ZaBogztNA1u4HS
	MZSF/bG+7gQZw3e0i0AumNhqpfMrlCv4/AQhMDwIzjwRIyr7HQ57r7DKs4KvoVNUajwGLBIsXvtY0
	5+4Az3ujS+b5a5SdJUgBRRNR2k/RaGQGWvXlHFKb5qKnGRCyd8/DenLwdfCaqcHVSmpT9oXb76E2X
	9WjKh3iF0bomKd55QUWAuKeVPC0yx3+yGe5m1+AXv+jRleqLPTq4HUYqbBV16sS8VyhkHB+wna+ks
	2GoVImGkPdj2EWjRE4gFSxE9CM/QHnW2DgF3xymIXUwOf2SagD22LzuQRagJWksyaMas/vVVxLVhA
	Q3yLGYObE/N5Sc9uVOJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvMcO-0044C9-G5; Mon, 21 Jun 2021 16:17:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvMcL-0044BS-Tq
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 16:17:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FCBF6128A;
 Mon, 21 Jun 2021 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624292265;
 bh=k4Gwf7Af3RDv0Bd4eZ5/TPIND1A/jXOMsAyRA8y0Wcw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SYPDbmr0ZSz95vibAS/Syqz1P1eL6e1qzBMueuayitoY7fWBMT16DL2C6RSvqEEwN
 GrWtrPrV4Q/HSR3XPML9OXQzvbQ1GcMEanLLpr2j7gZMout3e/SzlPDCK3ECERoCj+
 PJUH35qpybkLL4RIfQ9esMZq+c84sPHA2mVrf/cSXqz5qLLAYpgQvU7xJRmsVoxefg
 ym3wdycXob/JN8cqkoiNsHgZnO3vuQgzyY+8uSoSyclMfqjcBUFt0mXArPPiHpP7+/
 xqygfui8Bl/y54s1kZZEEGxmscYO4roLph2nMqwXK0hflwpGXX9NyQ8h4KOL01Rvlm
 8k6YJT9RzifZA==
Date: Mon, 21 Jun 2021 09:17:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: add comment to not use kobj_to_dev()
Message-ID: <20210621161743.GB1268033@dhcp-10-100-145-180.wdc.com>
References: <20210621030940.22286-1-chaitanya.kulkarni@wdc.com>
 <20210621053251.GA4360@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621053251.GA4360@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_091746_023602_9A4D1FD3 
X-CRM114-Status: GOOD (  13.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 21, 2021 at 07:32:51AM +0200, Christoph Hellwig wrote:
> On Sun, Jun 20, 2021 at 08:09:40PM -0700, Chaitanya Kulkarni wrote:
> > Add a comment in nvme_ns_id_attrs_are_visible() and
> > nvme_dev_attrs_are_visible() not to replace container_of() with
> > kobj_to_dev(). Since use of kobj_to_dev() makes code harder to read.
> > 
> > Suggested-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> Err, no.  This code is completely obvious as is, and if people keep
> sending these stupid patches we need to start blacklisting them.

People will continue to send these patches as long as
scripts/coccinelle/api/kobj_to_dev.cocci keeps warning about it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
