Return-Path: <SRS0=TJkX=YV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7059CA9EC0
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 23:51:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7792E20862
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 23:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K+WuDaFl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvqvSJBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7792E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vG5ARtpq2hrlhsHafKAbWw72dXZsVB+IqzmFDPsTPj0=; b=K+WuDaFlaYVyPJ
	aSWLuOWFcikbSKzyKwXRWr38zmGc26BKwgKv3OtMMOVCWwIR2km1vcchaMLaxZ/SYRT/4mlgLv4ZL
	ZHlnvemzd82pdJospqQ/cP+PNRR9kztIN8WZFfoz0auOx5F2XmUrTgtGfiPQs0v/GIq9hE4XwC7wo
	gNa6vCbRncRRzpHI3U2pL0jlYElTFS3Sc1tM7FkVembtqfQzTOY4d+F0+HcAVNRFZVi1xWXzcbjtt
	I18QNepWZTraGTkFskUtL8Affpk6JwqbfjPOJPMGwqjPyWfDGHK+XteznGDdwUhEhd4dqE4Ps486A
	zyF4wbiMN4cSbkrDZJeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPEn1-0002r4-DZ; Mon, 28 Oct 2019 23:51:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPEmy-0002qa-VM
 for linux-nvme@lists.infradead.org; Mon, 28 Oct 2019 23:51:10 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C607B20578;
 Mon, 28 Oct 2019 23:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572306668;
 bh=s/VgZswTSM3tl2SFZC36Ok1cphb7D1/PcaSPf7oZa5U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LvqvSJBDHUBhGHZaLGumYNvtVL/C617mD/7kq4QWAxefGHVi1D5hG0MxswZBpYxvX
 v7JzJwWFpr+yKC5ti4Ut0kCvtaEd38Dh8PSCifrGLvQz/egwwGECRcqAqxkrvQzmDs
 UnVfwt4tf6YK79/DlCOxlGqMNEEwLHhB0JdgP1FQ=
Date: Tue, 29 Oct 2019 08:51:03 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: add plugging for read/write when ns is bdev
Message-ID: <20191028235103.GA3064@redsun51.ssa.fujisawa.hgst.com>
References: <20191028182326.14311-1-chaitanya.kulkarni@wdc.com>
 <4fef7f91-67ce-548e-ae0d-6f43fe1d1bfd@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4fef7f91-67ce-548e-ae0d-6f43fe1d1bfd@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191028_165109_033454_7C7B5234 
X-CRM114-Status: UNSURE (   6.77  )
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
Cc: linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Added to nvme-5.5, thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
