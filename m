Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29858C433E3
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 03:55:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E503420715
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 03:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jYJCXQkS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="K8LgK7r8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E503420715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9yqXcPLhC4EWYosIV7skmcW7Jee5lwu4ZbEE0dpUlus=; b=jYJCXQkSIYTanFux8OVXD2e42
	BMUWm7T1TLcYelgwef5vd/ojR7wD8yW8sOUCZ4EfCZ+fTSK3jxcbQZeCdqh+7gIn/Frs7p7O3z4qn
	LofbbwhJgJfHfV60ZM0UPV4t5AlY4tekmzcoSKFB3iLvPtEgXleQkktZVv/ggHj4VjnWuZCp5YTqk
	uZJb5Mmz+KAo/CkVXyS/ycKa0wgZt86MVRk4sr1Ai7Gw0xlteTvzJgHkgzWHbuD9ZQSMbOoHJlaD4
	v+FpbRl0HZp0XTq7o9b66RR459fgntEd5lD+UKXV2uMeQY8J/ft7ZDp3dZ/y7tZM7hUDJFeoy4N/a
	WBX74d8Cg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k64L7-00043D-3w; Thu, 13 Aug 2020 03:55:41 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k64L4-00042Q-DJ
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 03:55:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mut7N42mh5vYAnOGpRQfTephvtNDrJcec2/m7aRKhb0=; b=K8LgK7r8nixrKQsEJO7cKuUmi5
 85iU3LQed/6W8Jblqn1daLqQqiDKsepKA3iAsMumiAH5v3UVTRsBX7m/OVFVuyQUjHQqoffztqlzi
 +fpod/sxu2YxplgTD8K+g8EoMTXg9P6KbMdiOQ7CJCQtGxZknapgf4wYecK3B/OwVUPWMaCw4l08t
 WHUMrEtC3cKJTfUoVRXkKAfahj5gLCam/zHPgRNkhVZjpo2jbEdc4ybItCYYjdtIE2roKouxoeniX
 nKN2zs13wqbYsFeT5RGPM1FXmhK5+xn26xzBzXOEq+jGpqgL/kOdOXfn04ckjXOHoop/+yihs0ETg
 Pfcs7CVw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1k64L1-0002aC-AP; Wed, 12 Aug 2020 21:55:36 -0600
To: Keith Busch <kbusch@kernel.org>
References: <20200812232444.18310-1-logang@deltatee.com>
 <20200813003200.GA1640756@dhcp-10-100-145-180.wdl.wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <829bed01-44c9-cac7-eb1b-9d1ccca7fd47@deltatee.com>
Date: Wed, 12 Aug 2020 21:55:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813003200.GA1640756@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 keith.busch@wdc.com, sagi@grimberg.me, axboe@kernel.dk, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2] nvme: Use spin_lock_irq() when taking the ctrl->lock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_235538_491517_E96842F1 
X-CRM114-Status: UNSURE (   9.53  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-12 6:32 p.m., Keith Busch wrote:
> There's an unrelated whitespace change in nvme_init_identify().
> Otherwise, looks fine.

Oops, sorry. can this be fixed up when it's merged?

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
