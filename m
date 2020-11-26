Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8917C63697
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 13:22:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6717C21D1A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 13:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dn2wDABw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6717C21D1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTXgRi7SHEw06lkNHBlHqp3VD2fwMBhmy3jWuYn7TPY=; b=Dn2wDABw469IvIm6BnClZi9s7
	95wYA8EIMcegD9oGSgBLnu0yoMcdASWLd9MN8+990Zzp0wVSzwe5pk4axL2N6QGYC10K+EEDFJBxk
	wwJjCSZ6/qbxBhZH7ve3ZmKLkWIxbQBO9OhhoYYwrPGoBG+RZ/LnMeA6HmIUtzE14TyV1/N74dj7B
	HbDsd2QfD5NOXCY5gFIO8uQz689vcAyy3e4d/byHtDzv5s6VyzB1U6Xbt4FD4PaZ46dnGrqDegeVj
	BNb4h0Be4zbuhwPvssXIvQmoj/gm9fytboBaO9a4/ZYGizvSkCSclvlqu7pPLTmgPtvCLEdR4Kc+4
	rl8pYFTRQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiHEK-0004wN-Eo; Thu, 26 Nov 2020 13:22:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiHCC-0003jo-QH
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 13:20:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E97C768B05; Thu, 26 Nov 2020 14:20:21 +0100 (CET)
Date: Thu, 26 Nov 2020 14:20:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Victor Gladkov <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH v11] nvme-fabrics: reject I/O to offline device
Message-ID: <20201126132021.GB5350@lst.de>
References: <bf6b3ed97dec401ab9ba9626d7764ab1@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf6b3ed97dec401ab9ba9626d7764ab1@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_082025_020640_D13BBC16 
X-CRM114-Status: UNSURE (   7.51  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 "Ewan D. Milne" <emilne@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
