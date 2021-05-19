Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E9BC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 07:02:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC17610CD
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 07:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC17610CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KuWi+es1P/b+pZo/z5ZFGxrcRX+6KRReLQazcuQ7ZC4=; b=UnlwD/Rk2cvDKhcWklNS/ZZcw
	MPS4WQOQmiW2VjuSUG+DbyI1PfUPi9vSsufj5J8rDNVsBAw3xhtUwDmwYI9E3F6OG54tVAsfqZKEi
	mfbil7uTL/ksTY5x+qH5u6NzEbIuXWWpduCR55oZmEe1qNaM32dDrAZZufrcpWMZMmjb9JUIYAcGK
	hJ6n6ArFJofjeg/y8EC//XpQYVW+kYU243QmmfbufpTBE+EKExpojpLzaleqXAK33miU5BVH7pgir
	bWGfXRsImHhlbTVzLhgn8aVpJin4C8AMLMKOSCebl8LQ+atFlBksx0ZWumrvisqI3hfLbr9RzMURf
	9CmneBmyQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljGCz-0035TQ-Sv; Wed, 19 May 2021 07:01:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljGCL-0035Mh-Hx
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 07:00:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AtLQOmT3RWv+aEdvfhmvoXrvtO8TBTQq5ZLyKjbSK3s=; b=C4W+xW1f6t5TEUtDcTHHuhLQJJ
 VxIUsB9zP/0skTAqDrqmLp3L2yESBMkjDBeZNyyFp2xA6QjnwSu5LbuIKG4lQWFSGb6rXc047J45B
 LCqNwTDcL9lvdd8IKolmv6O/rEWbNDv7PWevIT4zQGii5B9n6vN6V05eZi5+oBknDfZwd2tlWE4N5
 rf5LD2xqs9Vr3CxN2c/1p6Q9LVScGjiEQi3M4WGuCF9jrRXbkrxxQowZ4g34owADe2eJ2WQEQ6oFx
 1MiSdqXUpmXCS9qjk8MRdPAU1P/L667UQka3nBdUwO3jbN6zAx9IH5f32RKlVgiBSGFqLdcdeUWRc
 6sWT1lZw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljGCJ-00FCZt-3z
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 07:00:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6E12067373; Wed, 19 May 2021 09:00:48 +0200 (CEST)
Date: Wed, 19 May 2021 09:00:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Colin King <colin.king@canonical.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: remove redundant initialization of variable ret
Message-ID: <20210519070048.GB32339@lst.de>
References: <20210513115952.58482-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513115952.58482-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_000051_320494_603FDD73 
X-CRM114-Status: UNSURE (   9.39  )
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

Thanks,

applied to nvme-5.14.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
