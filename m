Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B29C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:54:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B07207DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0/cX27Jv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ0BrO/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B07207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JZigpB47ZVQlX416WKVdL67uwZmIbyvlOlvnytwAI94=; b=0/cX27JvMNVxCzp15mfeT0JL6
	60/+/BDqv3/wFU/s+FHM1Q02CL7hbXdyZe3v0TzBWcD6KxDCQhHMdsmPflLdc0Sm8UIKTnH//h8A+
	YCpn/jUfqxMkpY8H4XLpfQPsLqE+ZDj/gOL+6g/N5EKLZD9mc9866o8PArnDP6QEfm8BZvPcV7B+m
	tJ7uFtBsR7zJP5arUgTUqC22mDs+9Yjjo7pb62F3oSkg/5X0C6PllW7CoRVYauVjAhQbql7nQQTT3
	ZWFLCdWBzvykgJXYbnu2uyhxybSr8qwYN4RFB7DM/XABRxobnvF+BMS902fvYPp/qFRAzmVtZWa21
	MhpX7pxIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8W2a-0005Xe-Ft; Wed, 19 Aug 2020 21:54:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8W2Y-0005X3-4U
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 21:54:38 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 331E2207DE;
 Wed, 19 Aug 2020 21:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597874077;
 bh=TiVfs9TnTvt8NCzLeiBYwXiLkKQkqLvNw6cM0aafRmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EZ0BrO/S/u78UU6nbW2RE/EClwO8YkdubWqFbrVwD/x8khsZ3TJsRMs0y++iTUzjM
 lRhSOdixwts92bxBI0ZWrQK39qz4phHG0w9jeF2HQ8IjhJA04Lcu1hum97fDITAOlp
 si6D7iFg/INB9Ynbrsg1euUAVeAhxY9riDy+zaGQ=
Date: Wed, 19 Aug 2020 14:54:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH nvme-cli] fabrics: fix segfault when -t <transport> is
 not passed
Message-ID: <20200819215435.GA26818@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200819103157.50211-1-sagi@grimberg.me>
 <BYAPR04MB4965F354B86BE5F807732247865D0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965F354B86BE5F807732247865D0@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_175438_284699_47BEE699 
X-CRM114-Status: UNSURE (   8.52  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you, patch applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
