Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B0CC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:30:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51866521D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51866521D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M6XpCxSGsbATDqfAo8mzfkV0ukkO4lYoY0QtN19iMkU=; b=UusFLDRLJISWpMpD2AWFxfJmQ
	/KyEHJzowSh1QOzIcRRRo38l1RvTwAaYoi3RXp6Xi01/vKzeH8jiUZExvm3YbPaLfreO5gqchOVNA
	LtLz4x9lYa7qTZzajBxvTBTqGIBX2muSANEnyj3pDuQMs0lVVH0p5MQwBx/hWp7giILnqER+yyzu6
	0D6Vkig0NVcNbbVC86pKP1lftBnhsvqIHvtON6V/xAgNcyxUqMPG3l2ttCTlhxQfbnms/n2kmsZY5
	5S8+mqn1vN+afwwHjbDQ4Mu4p4cKvZeR+ABZu8LLS8iO5+TpzGesXx2HynWCznHXOiOwUoiCi6NYZ
	AtY8zWllw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJZct-004DTA-Rn; Tue, 09 Mar 2021 10:30:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZcn-004DRt-8m
 for linux-nvme@desiato.infradead.org; Tue, 09 Mar 2021 10:30:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TI5JtNlIj41ghFjUI6AbYuHOozcJ3rlR/cZvgNSuVRU=; b=NqrWy8NxtbOD4r1GwoBxlyaB8+
 Ea8OJC7vElOlOOtj9TQvdv1vmncpXm7k/n0dyexu+VwDWklz5Z2B9ZRpsiNxs9f5UUUiTCYXtA9ij
 pizyivhq/N8dUihcWd+/+PnXvQIyHiiln3zRRQmHfTP38tHudeMl3e7lQnum826Yl3WpFDlkIYahI
 u3UcjgIm1fD7HhLZH+xCE7pVI56vhLZ7uH892K5MHnIaSWFOmd64Lum4HhWdIoErJJCsLO6nS/0Hz
 gntlWMJ04i5YsekzFhR0FnnGSMBpVs+EVCr11eRn6BsDRCdL3sh9o01Po9B1ZWkIwtgIK+iH/dK7Z
 A0ttiHbg==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZHI-000QZS-QB
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 10:08:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E010468B02; Tue,  9 Mar 2021 11:07:47 +0100 (CET)
Date: Tue, 9 Mar 2021 11:07:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 james.smart@broadcom.com, sagi@grimberg.me
Subject: Re: [PATCH V2 4/8] nvme-core: use likely in nvme_init_request()
Message-ID: <20210309100747.GA7372@lst.de>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
 <20210301020611.18669-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210301020611.18669-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_100805_501973_4F7E92FA 
X-CRM114-Status: UNSURE (   5.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

How is a likely for a trivial variable assignment ever going to make
a difference?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
