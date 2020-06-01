Return-Path: <SRS0=I3sE=7O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F618C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2020 15:28:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB992206C3
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2020 15:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RRycYdpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB992206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cdYNUOrbFp7d/bNMt4RWS3jLNNgjgRSJrggWQJ6p6tI=; b=RRycYdpydqvqOK
	mS6DXWrySGAOLt4Az6pHAbCFOXsNz5r64fqmJoq87lzGUw55dwDDZUCVQw+jGPKB6x1baceBVNFp1
	kdCfbPNKuvINPX446PUY4xrAZkIlnxT19AJkHTKk7U1E/uavrRKUyEAQWLIkJStTOGaQRf2u/f2bX
	J26gHXY1vqth14F/r7K6AO0jfxOVDTbVHvQCA+3wOHqAdq9uhy2DoBtFMunzSGKViVlCCkat03bwN
	e24wUFnf28dqgkNFClL8NvN4RYyRJcsJyY07zH4xbao0P9kPwS9KSNqJe3HQ+b6PapETC/D6A+OEA
	gAYtMfAHzRec3IoOd3/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jfmMA-0003G8-Pv; Mon, 01 Jun 2020 15:28:06 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfmM7-0003F6-Dg
 for linux-nvme@lists.infradead.org; Mon, 01 Jun 2020 15:28:05 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 1 Jun 2020 08:28:00 -0700
Received: from SJSMAIL01.us.kioxia.com ([fe80::48c6:fbb4:9884:9a1c]) by
 SJSMAIL01.us.kioxia.com ([fe80::48c6:fbb4:9884:9a1c%3]) with mapi id
 15.01.1779.004; Mon, 1 Jun 2020 08:28:00 -0700
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [bug report] nvmet-tcp: Memory leak when connecting / disconnecting
 to the target
Thread-Topic: [bug report] nvmet-tcp: Memory leak when connecting /
 disconnecting to the target
Thread-Index: AdY4KTU4gt1aoBuCRKuy+fyFMtrw1Q==
Date: Mon, 1 Jun 2020 15:28:00 +0000
Message-ID: <d9e18f6916a24a5a921ebbf5ec5e0249@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200601_082803_459633_1C5729AE 
X-CRM114-Status: UNSURE (   3.78  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

[Environment]
Branch: nvme-5.7
Commit: 9210c075cef29c1f764b4252f93105103bdfb292

[Steps]
At the target:
1.1 Check free memory before the test
	# grep MemFree /proc/meminfo
	MemFree:        64060460 kB
1.2 Create portal:
	#./target_create_portal.sh 1 69.69.69.1 4420 tcp
1.3 Create target:
	#./target_add.sh /dev/nvme1n1 target_t0 1

At the host:
2.1 Connect to the target (number of IO queues is 10)
2.2 Disconnect from the target.
2.3 Repeat steps 2.1 and 2.2 ~1000 times

At the target:
3.1 Check free memory after the test
	# grep MemFree /proc/meminfo
	MemFree:        63685072 kB 

[Result]:
Free memory of the target system was reduce to 375388 kB
Note: The size of leakage memory depends on the number of IO queues.

Best Regards,
Victor Gladkov


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
