Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BFAC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:06:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD5E221FC
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0NEpCrrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD5E221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QfNkhG9KjkSNc96dRDEybWXw3EBchRstilssqGUJ3oA=; b=0NEpCrrq4dd2KRXAAVKOmEUZB
	rUnVgNxsD53cUZAqOtjiDQwvHE21ieXtgauhigxEk73cdMF0Glzoma4XX/DndddCeX2fy1x+1pwMM
	sJtmTX6C3UdctM2xrGqt7Wgq1rWgP6zxQr4NnElfVW2oebnSTvaJ9dYWmb8T3Y7Q/B4ag6VBNtUqR
	GjYMiq5DfjcOKesq4Bf3b3uKt85JIx2NR83vSBR1Rpj4fjb5szWP9fLXfRrzgZx1hw3ye1s93v5fa
	wrsfneUu0vsADQgVTckf38NKov6f04iEXC3Hco4ZOQvElcvrVLbYfzKefY7Ws+f+wmEjyE9pdNJqe
	Yl5DZn1Vw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvIlk-0001zo-MT; Tue, 14 Jul 2020 11:06:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvIli-0001zG-HT
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 11:06:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F2F2D68CFE; Tue, 14 Jul 2020 13:06:35 +0200 (CEST)
Date: Tue, 14 Jul 2020 13:06:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 rfc 1/3] nvme: split nvme_remove_namespaces
Message-ID: <20200714110635.GG16178@lst.de>
References: <20200705075935.506535-1-sagi@grimberg.me>
 <20200705075935.506535-2-sagi@grimberg.me> <20200708151752.GA26154@lst.de>
 <c7c6c2da-8408-72e7-84ce-bf4f7a886ca6@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c7c6c2da-8408-72e7-84ce-bf4f7a886ca6@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_070638_694873_9E0C2170 
X-CRM114-Status: GOOD (  12.19  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 09, 2020 at 09:35:13PM -0700, Sagi Grimberg wrote:
>> I find the split rather confusing.  So I looked into alternatives
>> and found that the state change should just be a no-op for the PCIe
>> reset case.
>
> Looks like the original version, but the only thing that bothers me
> is that in the reset handler, if we failed to setup any I/O queues,
> we'll put the state in DELETING_NOIO while it's not deleting, I think
> that the point of allowing this is to have the device still up for the
> user to analyze and debug it.

Based on the state machine we can't really move from that state to
DELETING_NOIO as indicated in the comment I added, can we?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
