Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07075C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:23:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79A860F11
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C79A860F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=znhzSowz0s7aKvOyhLVQxKAKa3wlPdKVWKMpH4Irri8=; b=wMudabaV+uaXI2
	FtDNl8jbzFDaTjXABqpumaGjXX6U1MsBE6y6phClVlHpue2LcYJLPu7zbr3xnKgT3g8PYAvMOlaKv
	/lwrBRzCGh6Z+QcuYfhRfSPK2msup2j4+35JEt1VEFKessgciSgSE+96UJDVaS6KVOglwNAOQMOHx
	zQdfDCU+uxllgmGY5U20j4JsrfJdHpuCNwqPRcxv7cgVizmHlWZsea+HyCkhyXA536GjEgCgOYepU
	aSy4Xr4RazPWfneX/5Z558RXb05hrqrHe6izi43VhhQDa0yOHmV0U0vAFCljvRfFMlJlfW7Z5bkat
	x9UnDQVnstyzLvvYXVEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maXfW-00F8UI-9s; Wed, 13 Oct 2021 06:23:14 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVNmI-009WML-Aw
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 00:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1632876534; x=1664412534;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=P2TS+BFfXgIxKiyjyCBFdWalj7bxK40HN4zXpXcDPmY=;
 b=CBrLePZXh38WccMsSC9xJ1bya0GB7r+S6ZvlZnzropThaIqJ28WtpY+U
 2+2kOIyGN7RqVp65TkrFqJ2desO3w18rxP8T2ZqLjG3xyn+sNIE6rP9Ju
 IlFfRZaf/V5TuL0YEq4TwTY3FIFaOxAHoK1qHPsr9dWvd+r/C7eu6DnZr k=;
X-IronPort-AV: E=Sophos;i="5.85,330,1624320000"; d="scan'208";a="163309998"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2c-34cb9e7b.us-west-2.amazon.com) ([10.25.36.214])
 by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 29 Sep 2021 00:48:51 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-pdx-2c-34cb9e7b.us-west-2.amazon.com (Postfix) with
 ESMTPS id A606941D2A; Wed, 29 Sep 2021 00:48:50 +0000 (UTC)
Received: from EX13D06UWA004.ant.amazon.com (10.43.160.164) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 29 Sep 2021 00:48:50 +0000
Received: from EX13D04UWA003.ant.amazon.com (10.43.160.212) by
 EX13D06UWA004.ant.amazon.com (10.43.160.164) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 29 Sep 2021 00:48:49 +0000
Received: from EX13D04UWA003.ant.amazon.com ([10.43.160.212]) by
 EX13D04UWA003.ant.amazon.com ([10.43.160.212]) with mapi id 15.00.1497.023;
 Wed, 29 Sep 2021 00:48:50 +0000
From: "Nikitin, Andrey" <nikitina@amazon.com>
To: Christoph Hellwig <hch@infradead.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "Buches, Dave" <davebuch@amazon.com>
Subject: Re: [RFC PATCH 0/3] nvme sq associations
Thread-Topic: [RFC PATCH 0/3] nvme sq associations
Thread-Index: AQHXtMvEHiGGv9KaSkCtteKn961M9g==
Date: Wed, 29 Sep 2021 00:48:49 +0000
Message-ID: <79563B18-671F-4654-AE74-7FD9AB5417EF@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.36]
Content-ID: <65F48592BAF857439BDD90CAF773D8AB@amazon.com>
MIME-Version: 1.0
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_174854_466007_342FAB50 
X-CRM114-Status: GOOD (  13.35  )
X-Mailman-Approved-At: Tue, 12 Oct 2021 22:54:01 -0700
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

On 9/25/21, 01:38, "Christoph Hellwig" <hch@infradead.org> wrote:
>
> Honestly I'd rather not merge this whole patchset at all.  It is a
> completly frinde feature for a totally misdesigned part of the NVMe
> spec.  Until actual controller in the hands of prosumers support
> anything like that I'm very reluctant to bloat the driver fast path for
> it.

Thank you for the feedback.
While I agree with your remarks regarding feature design in NVMe spec
the minimal implementation proposed in this patchset would help resolving
the problems outlined int the original post (undesired queue sharing and
noisy neighbor).
For controllers that do not support NVM sets and SQ associations the
configuration would stay the same as it used to be. So I would be
interested to know more about what brings your concerns for the driver
fast path.

Best regards,
Andrey


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
