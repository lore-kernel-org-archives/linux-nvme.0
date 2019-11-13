Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A457C43331
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 00:50:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1F921872
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 00:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KV9dAo3Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ed9so5qS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1F921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Udzxa27w8qmB1BmeeC7CXYjjd3MtV0Zq73bUBsLasrA=; b=KV9dAo3Q6PChgm
	nKrIIu1yu1AwP9ZG9gphl1Hc6cT1ekabygduZcYag8axraimxTFlWZXc3qVVcwmUcks3GlIC3Z8cY
	6Cw1qfN+gCsY8lb+z2ycxHu/n1ala2/kBry7dckEGeARUSfCeSJOHcfglzPfHVWbXfyrCK7+nuOEY
	acrKxFYv9PW1hdrcSypuXc9SgJcw90laYj84rfWC/3qIV4O/LUAe5Zo8As6lg77tBXA2jpy5nsJAW
	pZP15CNDxQmGD22y0wAJFsmkNVUhn+tk8xHYWu2mu7DBGKEts3XIrw658BOf7ssE731ib+7n/9S6U
	4VJ+vm1J69/owL21rU4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUgrg-0005sK-LB; Wed, 13 Nov 2019 00:50:32 +0000
Received: from mail-eopbgr760110.outbound.protection.outlook.com
 ([40.107.76.110] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUgrd-0005rb-L1
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 00:50:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoiP1e5UNIIDMkyWcgwSJlSHcXkkRxyCN64dOCztHlJvhhJS/k8P6T09Lr43Fh2QTOuEUkbbsalf+qNEccIqX79clD/Lb5wfVWzSE/6rSEhkHWKAOH191XKX7oOGM9FgtdAXmFQVWXVqxgASGe5rFbdDQzAlQWF3PlQob4MNL7Cbrmh4qs/NgWTeRSaWHsRpSWlGBXeK5vjVctUBW5K7dcal6NhbMrbSX/hVm3Gls6RBXDUt4H5y8uvuNshgoA0TT8Sm632U+W/H6CYpAbRanqBd0WfD28ipBcfpyt5LSfuf4BCONmna6EmgCchKv+iRaYNFUE3JDT9eZWqTRWHPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAfYDPrQZTF5gG/UFRr498a8eNkZMs2jEE8o3ovC4Hs=;
 b=iyMu2m3byN51zeEeQyfv6ieWjbP+ubToEE6LaeY8TjlInHa/2tZvScpRn56X5CVKo5KH2BZM9CX/1kshP8p0RQdLcXvJo9ovJUid1g4iCXtMhHOQk4YF1cXWtS+fiGPJun1S/Uht+gjuRh4d+Ee6bggqLQ7TW7/5oS/8pgkAer3B3hLQikPb3un+y4KtX1AyOeRYMtC15YcqE7FkwSNgemlsoBrqtmErX9IMASNk3FJgui6ncG54hgaIPpS0NAv3fl6UEflHnQEdohgsM1qQvBljguuEJ9eB+urxQTRYwCetVjderdkEVI4HOmVxXLB90QQwuURgh2fCJ7vxENkhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAfYDPrQZTF5gG/UFRr498a8eNkZMs2jEE8o3ovC4Hs=;
 b=Ed9so5qSNBfD5969ACmDO/5srnZHEGXv+7Jep6SzjYnNpDvjdorkWKdgqefdXO1m4ql2jvynMTI6Wmj32NTfLLVgjJ6VL8QrdLpKEaXDoVq2j5Et9YKOq3XAqy7Pl+pONAbgXETjCC9TM5m/IGk4YZdtD8Wu29dQJ9jLdVglzXY=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0183.namprd21.prod.outlook.com (10.173.193.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.7; Wed, 13 Nov 2019 00:50:26 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::8c0d:e8a3:4fb7:e083]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::8c0d:e8a3:4fb7:e083%9]) with mapi id 15.20.2451.018; Wed, 13 Nov 2019
 00:50:26 +0000
From: Long Li <longli@microsoft.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Topic: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Index: AQHVlehiYcB/lSKxl0SzyAz+DwfVW6eGdeMAgAAtylCAADVHAIABOLmggAAFEgCAADTM4A==
Date: Wed, 13 Nov 2019 00:50:26 +0000
Message-ID: <CY4PR21MB07411D73ACA4BA55BD608CB5CE760@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com> <20191111204446.GA26028@lst.de>
 <CY4PR21MB0741004E62F9C50B8EF7DA9ECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20191112023920.GD15079@ming.t460p>
 <CY4PR21MB0741BB1F48C64613BF6E45F6CE770@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20191112213646.GA1964@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191112213646.GA1964@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:eddf:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36d65505-4fb2-4507-aaf6-08d767d37951
x-ms-traffictypediagnostic: CY4PR21MB0183:
x-microsoft-antispam-prvs: <CY4PR21MB0183CABD6001A3B201FB77F6CE760@CY4PR21MB0183.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(346002)(39860400002)(376002)(189003)(199004)(6116002)(22452003)(4326008)(6246003)(66476007)(54906003)(316002)(6506007)(86362001)(66556008)(64756008)(66446008)(9686003)(76176011)(186003)(10290500003)(71190400001)(7696005)(71200400001)(55016002)(102836004)(14444005)(256004)(76116006)(2906002)(99286004)(66946007)(33656002)(6436002)(478600001)(25786009)(46003)(305945005)(446003)(8936002)(11346002)(7736002)(476003)(6916009)(81156014)(486006)(81166006)(74316002)(8676002)(52536014)(8990500004)(10090500001)(14454004)(5660300002)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0183;
 H:CY4PR21MB0741.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZ1jplfb4vBUWMEIiOa8LyZxCjX/Q9om8Rofq7HbIrHoFAqeErJXBvsJp3TVw0Vy9wrNIzivho2iGZ0Rh3LEVglwuZsJbFjaS7VO5a/GA8/NZco+DZOE4fNqpcJGS6EPi3galYrz49PYdT4hPCZdA5xGnn4RoYyg0aoLWCX8pwpZ/w1Nsqxxvc69cs4YAQLXWrlXTYQyMN1i+CvU0O8V4hqap9a8TK3rHtgKkbXX57QKJMrq2TfSqURas7WeqtKBguAGDiDJRFV3KjD1V8Igfe137wSu5qKMm+gKWXROnH2AYLMkM1v8p2TWcpRdee2drPHdCkyjzXzQHfoXSykDnyKZASvC2K52CMxU3qwPXcpE6c/2g3ov9lsxDTY2P2pDcwe7a4iA1QpE6QWV/taPILs2l8l086Ql4KSUcG6q2btTlGnExP+1Hx/Hbnh6bG1d
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d65505-4fb2-4507-aaf6-08d767d37951
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 00:50:26.6750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czSX61Wy8zhOCKWHueZvhV6PVk4ZmTLEhHUO1+yeBixNt3UlhqmbBMMGpBNcs0OJTfa8oOWxixXlkjszdSOiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0183
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_165029_775495_C105ABD3 
X-CRM114-Status: GOOD (  11.51  )
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for multi-
>mapping queue
>
>On Tue, Nov 12, 2019 at 09:20:27PM +0000, Long Li wrote:
>> >Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
>> >multi- mapping queue
>> >
>> >On Tue, Nov 12, 2019 at 12:33:50AM +0000, Long Li wrote:
>> >> >From: Christoph Hellwig <hch@lst.de>
>> >> >Sent: Monday, November 11, 2019 12:45 PM
>> >> >To: Ming Lei <ming.lei@redhat.com>
>> >> >Cc: linux-nvme@lists.infradead.org; Keith Busch
>> >> ><kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Christoph Hellwig
>> >> ><hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; Long Li
>> >> ><longli@microsoft.com>
>> >> >Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission
>> >> >for
>> >> >multi- mapping queue
>> >> >
>> >> >On Fri, Nov 08, 2019 at 11:55:08AM +0800, Ming Lei wrote:
>> >> >> f9dde187fa92("nvme-pci: remove cq check after submission")
>> >> >> removes cq check after submission, this change actually causes
>> >> >> performance regression on some NVMe drive in which single nvmeq
>> >> >> handles requests originated from more than one blk-mq sw
>> >> >> queues(call it multi-mapping queue).
>> >> >
>> >> >> Follows test result done on Azure L80sv2 guest with NVMe drive(
>> >> >> Microsoft Corporation Device b111). This guest has 80 CPUs and
>> >> >> 10 numa nodes, and each NVMe drive supports 8 hw queues.
>> >> >
>> >> >Have you actually seen this on a real nvme drive as well?
>> >> >
>> >> >Note that it is kinda silly to limit queues like that in VMs, so I
>> >> >really don't think we should optimize the driver for this particular case.
>> >>
>> >> I tested on an Azure L80s_v2 VM with newer Samsung P983 NVMe SSD
>> >(with 32 hardware queues). Tests also showed soft lockup when 32
>> >queues are shared by 80 CPUs.
>> >>
>> >
>> >BTW, do you see if this simple change makes a difference?
>>
>> Yes, I can confirm the patch fixed lockup on this VM configuration.  There is
>also no performance regression.
>
>What if you just use threaded interrupts with the path that scheduels the
>bottom-half on any CPU in the mask? Does that resolve lockup?

Yes, that patch also fixed the soft lockup problem. But it also introduced a performance regression, the peak IOPS dropped 40%.

The reason is that I/O issuing processes (FIO in the tests) get more involuntary schedules.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
