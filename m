Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D5C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 07:44:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB644208E4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 07:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qf6yRJyr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lv0Xdivk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB644208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qt1aje6ESubN7JG3fICnfAZrmGyEvN2UYI2wK8YxNVE=; b=Qf6yRJyrGCcXPpSPduNQPDOBZ3
	Ber1TEgOinFP6aICjmMAZtJEVtMyg7px4Mo7F4YSA6NiNFOJMbYRik06UbSkCuWlY7RXS94zP/cnt
	aX96jQQF/v/gx1UQlDgnJmDHF79O1v8XYgtNRSoWGGc01BNGn/4M78JXyvUThKPyyG9wMgavaJIFo
	yHHrmTUK8BhQ/qONlSkgLzBTALDJukzCqcWM+WJF2d74X5QyMpy1lEW353n995y0VniMLLd7z47DI
	CiWz7aZnmrYnDtwnNlpQ76lCEVT7YeYOcUSX0Qjj7bkDekvaL8oCcjTA0dXh42lyAejG+TJ7G2THA
	4MvhjcHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyVty-0008T4-Uq; Thu, 23 Jul 2020 07:44:27 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyVs2-0006xK-KG
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 07:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1595490147; x=1627026147;
 h=to:from:subject:message-id:date:mime-version:
 content-transfer-encoding;
 bh=I4vKZmDN5Mg/2gUSO2RfG7Wpl0IlYoIXkh3vsWj0Gfk=;
 b=lv0XdivkfFSu1siEEgYBybz0tG2nAKc85ka7SYNk7F+Svc/neCVHntpZ
 Pye+AnJOBfMKbkQlB5LRAU8Fg/ju8AhXIYnjh6wrBhUzTjc0vptApzYwi
 hASyap5vwtgrRGvUZtnW7kCP5BhuIE7l7Aso2UhOBq0uX6x+L7RB6Ij/7 U=;
IronPort-SDR: +4ZwmvnjXq/DZRPox2XFyCIXAXIOdNJ5QmRI5WdXuc46tDSGY+5baiyKTOpmRYy1LY5MW+XglH
 acKPg78hD0UA==
X-IronPort-AV: E=Sophos;i="5.75,385,1589241600"; d="scan'208";a="43459460"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 23 Jul 2020 07:42:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS
 id A0572A2622
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 07:42:21 +0000 (UTC)
Received: from EX13D32UWA004.ant.amazon.com (10.43.160.193) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 23 Jul 2020 07:42:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D32UWA004.ant.amazon.com (10.43.160.193) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 13:05:52 +0000
Received: from u908889d5e8f057.ant.amazon.com (10.1.213.29) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Jul 2020 13:05:51 +0000
To: <linux-nvme@lists.infradead.org>
From: <vrd@amazon.com>
Subject: NVME io_poll with kernel 5.x
Message-ID: <e5528438-eabc-acae-8516-d97cda739b33@amazon.com>
Date: Wed, 22 Jul 2020 15:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_034226_815247_C4344FE4 
X-CRM114-Status: UNSURE (   9.09  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Since commit a4668d9ba ("nvme: default to 0 poll queues") [1], the nvme driver needs to be explicitly configured with poll_queues > 0 to allow enabling io_poll.

However, prior to poll queues separation in 4b04cc6a8 ("nvme: add separate poll queue map") [2], io_poll was enabled by default on nvme block devices. How does this work on older kernels, without dedicated poll queues?

The commit [1] says:

> We need a better way of configuring this, and given that polling is
> (still) a bit niche, let's default to using 0 poll queues.

Are there any plans / work needed for nvme to provide > 0 poll_queues by default?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=a4668d9ba
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=4b04cc6a8

Thanks,
Varad



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
