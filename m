Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2885C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 06:40:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D912075F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 06:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zLes89Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D912075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mRq4BR2QdrjQlcNfUvlZFW6d7LEI7VsMytQWjo4ziyY=; b=zLes89Av+e6ka81NoWERz3QLA
	focU/r3/H1Qh4dmXnbRWngYbvlg15V44QFKHJmC3GWPKnmisxWZiWdTdI4PiVNjSCm0UTkze3cS75
	ARnjt3VXKRzfOHYthiqk8tM872IdB8vZAl6rtiQ6ObPaLv1nGytwA9y/yF3BUkgH2unP73M003QJE
	fDPogp0KenmbgMRz4cpeCKee8s1P73YaJp/+iIyn7hz/Zi16ycz3SU45i/x6stIiFpxw2ssUz9Fr1
	biLe2SoV499depUOal+/fqDfPmb8GajlwhLZdtSvO/7w8hTNZK0QTZaBCfBo5emDyGeGEfQwDUkwg
	lbKz17U0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNVmO-0002T9-Oq; Wed, 30 Sep 2020 06:39:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNVmL-0002Sn-A0
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 06:39:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 97E6A68AFE; Wed, 30 Sep 2020 08:39:50 +0200 (CEST)
Date: Wed, 30 Sep 2020 08:39:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Victor Gladkov <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH v9] nvme-fabrics: reject I/O to offline device
Message-ID: <20200930063950.GA2418@lst.de>
References: <319b8b1869f34a48b26fbd902883ed71@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <319b8b1869f34a48b26fbd902883ed71@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_023953_493236_75A166D4 
X-CRM114-Status: UNSURE (   8.25  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, "Ewan D. Milne" <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The diff seems malformed, probably mangled by your mailer.  Can you
resend a working diff?  Feel free to fix up the obvious style problems,
otherwise I can do that as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
