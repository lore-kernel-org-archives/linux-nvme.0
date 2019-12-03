Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727E4C432C3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 07:39:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448C020637
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 07:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mCPg8n9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448C020637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4yn+fm69gMOVISslyMETZ6vbmTnxPfgQWKJ1twZssus=; b=mCPg8n9vfv5rHH
	B6NxejFz/TQKo1HS4/Z5rEudlXXdCJgoqcPbfCZRhQUApSG9jhyJtK/0ULd5S5GZOpTrHFWf2W0xC
	9pX0qHdkaqB1FnzcXAs2OfnnPq7+4s1cOMkIZqCXe2Aj19W4dJXsaVvi/xufY6jAeNKvNyusz7ifb
	VO/0lWW/xvi6ofvNTkeSI6eb2RnrrtJUNCNMr2g10wTFuVnmVzgig5wrINArUWB953/lyFQ/GgsuS
	oHLn1XGteOEwlkszuWvrVGfGgYzK0LZwKvCpuwgx5sN2vOtuZKyi0c0iGBVlRzq2S8v9tNKzJ6St0
	z9cXBclf0MMrRZWpxxUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic2mC-0003Ee-CI; Tue, 03 Dec 2019 07:39:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic2jy-0001AH-P1
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 07:37:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1C5AE68BFE; Tue,  3 Dec 2019 08:36:56 +0100 (CET)
Date: Tue, 3 Dec 2019 08:36:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme/pci: Remove last_cq_head
Message-ID: <20191203073655.GA23881@lst.de>
References: <20191202221829.1940-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202221829.1940-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_233658_970431_D3FA7FD4 
X-CRM114-Status: UNSURE (   7.01  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2019 at 07:18:29AM +0900, Keith Busch wrote:
> We had been saving the last_cq_head seen from an interrupt so that a
> polled queue wouldn't mistakenly trigger spruious interrupt detection. We
> don't poll interrupt driven queues any more, so saving this value is
> pointless.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, didn't you also have some other patches to shrink the size of
struct nvme_queue from a few months ago?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
