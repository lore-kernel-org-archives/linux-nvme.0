Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C884C4727D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 15:49:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A7C2399A
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 15:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cXA0dNfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A7C2399A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uGg1O4jyDRsVkHfGaGWOGLinKCe132SIbOCqEtsM0jE=; b=cXA0dNfZr6wLvx2ZWJbfNRVEL
	5ZEi8xKvegnDmmgqxl6wPF9k5thFAgD3rF3bvDvUQAcF0z5soLIP8sVEHxzpKDfBL2ES1vyvRb1Rp
	PFGfdR4yEnofK3IQrsvoe40PL1ZlmARbtm++jpsuQJ4SKOIaubegAEr4qRpP5OAnEUMnEwz7j5VRy
	QyHXh+xD/LIR1k98fkWKH8CsQIgntA+N4R/RqLwbxy3FMZosddO54uuoDWNyyIU3CE9tbPX75v8i1
	EK81KFADckkSMxGg9HfRgF80oTo9se4jYdCc1TRSKA/NMUhpQpsc/Up8V7xdl5BN90WVCbMwOSnr2
	FST+JS5fA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKkXG-0006ir-6P; Tue, 22 Sep 2020 15:48:54 +0000
Received: from smtp.h3c.com ([60.191.123.50] helo=h3cspam02-ex.h3c.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKkXA-0006fz-6C
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 15:48:52 +0000
Received: from DAG2EX05-BASE.srv.huawei-3com.com ([10.8.0.68])
 by h3cspam02-ex.h3c.com with ESMTPS id 08MFlZF4029649
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Sep 2020 23:47:36 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 23:47:40 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.1713.004; Tue, 22 Sep 2020 23:47:40 +0800
From: Tianxianting <tian.xianting@h3c.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Thread-Topic: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Thread-Index: AQHWkKof6KH2tOMk4EuCjM46q9dNfal0OdSAgAAAdACAAI18gP//fluAgACHctA=
Date: Tue, 22 Sep 2020 15:47:40 +0000
Message-ID: <53ae0341e62346f985ca289c6325078d@h3c.com>
References: <20200922062517.30031-1-tian.xianting@h3c.com>
 <20200922145705.GA4035426@dhcp-10-100-145-180.wdl.wdc.com>
 <20200922145842.GB28420@lst.de> <5099986543624f9fbbeb26c2173934ba@h3c.com>
 <20200922154105.GA31758@lst.de>
In-Reply-To: <20200922154105.GA31758@lst.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08MFlZF4029649
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_114851_415926_1C187451 
X-CRM114-Status: UNSURE (   9.03  )
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
Cc: Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Finally, it applied:)
Thanks again for all your kindly guides to me.

-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Tuesday, September 22, 2020 11:41 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: Christoph Hellwig <hch@lst.de>; Keith Busch <kbusch@kernel.org>; axboe@fb.com; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking whether req is null

On Tue, Sep 22, 2020 at 03:27:27PM +0000, Tianxianting wrote:
> Thank you Keith, Christoph,
> So I don't need to send v3 patch? 

No, it is all fine.  I've already applied it locally.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
