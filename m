Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73D3C49ED7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 07:17:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763E5206A4
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 07:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CWkLfYHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763E5206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J8FLc/cfnhHQk8dnHKX0FjXs6uY02DmbqYtM+5DCRkE=; b=CWkLfYHWmQ9Gnb
	+P4TCJd1q6tbmapR4srzGwfaMVRGqjzzciJPoEaiQVSYTOyd5EzsGloE5O+KnJgSj718vG6R0aQyW
	06MlAs4XCh78JxbkVp3d0dC9NcSH5mT3Poy6PefUhQbuyzaijR8YqjftUziUArzg0/NCtITXD7tyC
	gO2QdMhldw/L8lvZP7xTIKMz7YVyTVEacg/a5VBMQdgUiWj4qHL1tbAwZa1xWkCPDveu13+7VqY1j
	XZyJIcrLc2XWxd0OXuVDrz/kF88GExnAPb9eGPuQEAghxJCyq5ay2xtuy3uDVpgTLoO71PUsmzRyN
	vaxdNl8N+ZvDBSTpktQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9lFw-0002VR-Gc; Mon, 16 Sep 2019 07:17:04 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9lFr-0002UM-56
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 07:17:00 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Sep 2019 00:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; d="scan'208";a="180348412"
Received: from irsmsx153.ger.corp.intel.com ([163.33.192.75])
 by orsmga008.jf.intel.com with ESMTP; 16 Sep 2019 00:16:54 -0700
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 IRSMSX153.ger.corp.intel.com (163.33.192.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Sep 2019 08:16:53 +0100
Received: from irsmsx104.ger.corp.intel.com ([169.254.5.103]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.139]) with mapi id 14.03.0439.000;
 Mon, 16 Sep 2019 08:16:53 +0100
From: "Baldyga, Robert" <robert.baldyga@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 0/2] nvme: Add kernel API for admin command
Thread-Topic: [PATCH 0/2] nvme: Add kernel API for admin command
Thread-Index: AQHVaiSqeBhk6f9KbEiN+m1w1CltIacpnGSAgARMMRA=
Date: Mon, 16 Sep 2019 07:16:52 +0000
Message-ID: <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
 <20190913143709.GA8525@lst.de>
In-Reply-To: <20190913143709.GA8525@lst.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDJjN2Q3NWMtOTA4My00MTk0LWI3MDgtNjdkODc4MDQzZjUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYlRnMERubmMzNzBoUmp4Z3dLSjAyUkQ1KzhIQktWMW13Y3ZCMHhkMWhzRkJRdTdFdGhRdHVWNTFPc09rZ1pBZiJ9
x-originating-ip: [163.33.239.182]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_001659_284143_4DA212AF 
X-CRM114-Status: GOOD (  18.76  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "Rakowski, Michal" <michal.rakowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 13, 2019 at 04:37:09PM +0200, Christoph Hellwig wrote:
> On Fri, Sep 13, 2019 at 01:16:08PM +0200, Robert Baldyga wrote:
> > Hello,
> > 
> > This patchset adds two functions providing kernel to kernel API 
> > for submiting NVMe admin commands. This is for use of NVMe-aware
> > block device drivers stacking on top of NVMe drives. An example of
> > such driver is Open CAS Linux [1] which uses NVMe extended LBA 
> > formats and thus needs to issue commands like nvme_admin_identify.
> 
> We never add functionality for out of tree crap.  And this shit really
> is a bunch of crap, so it is unlikely to ever be merged. 

So that modules which are by design out of tree have to hack around
lack of API allowing to use functionality implemented by driver.
Don't you think that this is what actually produces crap?

> Why can't intel sometimes actually do something useful for a change
> instead of piling junk over junk?

Proposed API is equally useful for both in tree and out of tree modules,
so I find your comment unrelated.

If you don't like the way it's done, we can look for alternatives.
The point is to allow other drivers use NVMe admin commands, which is
currently not possible as neither the block layer nor the nvme driver
provides sufficient API.

Best regards,
Robert Baldyga
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
