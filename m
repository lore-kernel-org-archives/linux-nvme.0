Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D932C43465
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 02:28:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A952078E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 02:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0rcE9h3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A952078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vpgJYQ/ZpUNKtmPvPB3UIiaoVXtaFEwi62OLpubTjjs=; b=0rcE9h3PRudo9KUCN5PLIrFeXP
	YS1TfgHAdhx6jPdXwwXh9FFt0aT0iaXWlZ4CY2VRayPla35IbioK7RA8biHSU/ojF67Hf0zkWoz68
	QfgWqaaMFm+WvFl0di+yPhuCIlUC5cCftHmzf5HSyHdlsG9TwDs5EepCxj3dybw6OqwIcVAp31qq/
	CZPhexq+1LP70ZeB5TJEkn5z9MvHE6JJ/XrDwW5jo2CugPTjfTFQ38X7UddoxKIPbCCesWT77ai4N
	sdo+Vg/LqIG/12SHt46JJyzwq+4h+9jdjMJMh8DjfrqjpoFnw+hyO5H+unpNReP//QtJ8q2+hnwsW
	fhJd3YYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKBYo-0000SA-3w; Mon, 21 Sep 2020 02:28:10 +0000
Received: from smtp.h3c.com ([60.191.123.50] helo=h3cspam02-ex.h3c.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKBYl-0000QD-Su
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 02:28:08 +0000
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([10.8.0.71])
 by h3cspam02-ex.h3c.com with ESMTPS id 08L2RUFn078830
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Sep 2020 10:27:30 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 10:27:31 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.1713.004; Mon, 21 Sep 2020 10:27:31 +0800
From: Tianxianting <tian.xianting@h3c.com>
To: Keith Busch <kbusch@kernel.org>
Subject: =?gb2312?B?s7e72DogW1BBVENIXSBbdjJdIG52bWU6IHVzZSBjb3JyZWN0IHVwcGVyIGxp?=
 =?gb2312?B?bWl0IGZvciB0YWcgaW4gbnZtZV9oYW5kbGVfY3FlKCk=?=
Thread-Topic: [PATCH] [v2] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Thread-Index: AQHWj77BvjMzTC+ou0aptn5bKR4hYw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 21 Sep 2020 02:27:31 +0000
Message-ID: <c8f208cc0e7f4f778de0579a8696c1f8@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08L2RUFn078830
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200920_222808_394734_5667E08F 
X-CRM114-Status: UNSURE (   3.54  )
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
Cc: "axboe@fb.com" <axboe@fb.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

dGlhbnhpYW50aW5nIChSRCkgvauzt7vY08q8/qGwW1BBVENIXSBbdjJdIG52bWU6IHVzZSBjb3Jy
ZWN0IHVwcGVyIGxpbWl0IGZvciB0YWcgaW4gbnZtZV9oYW5kbGVfY3FlKCmhsaGjCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
