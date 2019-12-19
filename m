Return-Path: <SRS0=TwGh=2J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF97DC2D0C0
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2019 05:50:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC9121582
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2019 05:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O8jw+5e+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H0mJmWNu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bnnEHC3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC9121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BYGoLms/US8VcGIs+0hWKKsUgLQEjaoiHIzPUtZqxj0=; b=O8jw+5e+LHE0Th
	UnfSrrvmjuzjIf0fUHc0z36nrwDVZAdIrY6AQ10B4rBaWG+T7Y2RrQc1opcap0l5VxFZWmfZD5Qco
	cvYzdCytVVXRjXoTfOlBhje23U4HmuNvYtQ7KXuugzBNdXpLBxZYjg1sfnppWUfrQeLrGE+8XdXo+
	hN/6dCColMMrsS9LwZ2NqrzzLl8Cm4QDO2Lj6OXUuPTHphS6qlo5XXUudZNTzbcUUrE9RBkQN23qj
	qA+F+tZ9jW0tmN1r/6z7VR8JQDKZDlvc8RGXd1Ki1U6KjuiW0ncpGBPWQB74SfC16o9FmTGEUXwcg
	pFizUGAAk67O1AHmjlTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ihohp-0007k5-Qr; Thu, 19 Dec 2019 05:50:37 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihohb-0007U1-E8
 for linux-nvme@lists.infradead.org; Thu, 19 Dec 2019 05:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1576734624; x=1608270624;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=GSbrsWDTBXgHv3L5mAv4ZzvX+qsh5gMKdqmsq6Kw2gs=;
 b=H0mJmWNuEdensl74H0udz4zoSBlWTdDWCK3qUKMIfOEAjOZEgBgreZdo
 SSch6eOk7Ay2qoaP88xhl87zxFQGoNfPQWHVtz9t4USJ4wp2w3dOsjL9N
 1FjsJ3f69dJc2ONodoxAn2skD7EyVVfztT5SRJIIv4D5tQO+j5ACio1Xv
 3UqsgGO99vD8harZniHCFJTaeQ17yiJDJYcDCML/noGzVtVmbyvu0AnCc
 KDf7FitPTNu38bHXh07/EXXeIpdYxXblq/Uu7pOpA0BbfYCbZkFNWKwup
 KPfJia0J0cp8kgrGuqz4zf0NKi+1skgU7jcXT1MpfSLvveIJ1XjZIhI2a A==;
IronPort-SDR: pl8jH+D7IjC8IEupgG3gTKHC/ULEzq1wb/aF+3Orm7DMhtzoNJeXpA9b5S1bwQiJvSPE9m0NE6
 qTJxeS+y+rIepVt25BigOTYx1eybaRY5/ZkM3t8/pm4drai4kINQtJQcGv0HQhC0F0fLGbfnnk
 oHxP1Uq19j9A0XXkQJe6QzSpgjiGH0Jfsx/+j1/HT30H7FkRdAZaIfyMoZz1fRXpeEWghneyhE
 pklqpcAVNoir0y8fM07vDATa22i2BneVOSZ7KFs9/u6Z5cBwfdhIvyFYdMj/po7iiSOsQAfBkO
 C/s=
X-IronPort-AV: E=Sophos;i="5.69,330,1571673600"; d="scan'208";a="227287347"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2019 13:50:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7Gwy03+7HYqeulaUjJhPbMdmxSjxQGLF4ZZTIp4tWtaUG6061BZA7kC3uVc0rINxOawR/HXXy0Y55+7nrRG5ZOgo7WJDFn3CBK24qPX7EaUyN/i30RzaxwLL6UdILgI0Fa20TPItywLE/ZLc7oDu/xlWr3xkM8af2y0927zRFc4AKfAdtY5mYurkU4dSOBf3YhFiE8bHgiawj1H4Zph7pLXGMpsfQHRlxYDuaQqq371P5atkBJFLbAOz4TAs3BN7CVKXX2XaATwnS5rXRxEvV5PFcyyBdhGAXpQHBuBhvWIMSwFfrIo6BfsrJHHeSigrHG0k5HZieHq34jYn8/Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au2TeOyuXzWOq3tHvcR/f6Kt/0KqUXEd2nKodGWrGOQ=;
 b=JWvN8L+4b2b5S7BrrBE+ZD61mGqeKknHB/ck8sUxDmgDe8Egx1ZtJaMEqtQL03oUSzOocy5FWUxYlmoeWRTnndWAqVc4VF5yMMsf2RIMHGxQA4Z/ZffnfoWnV/WHQ41g2CcwQchEvdUZEZqnMhDMVEp978BUpX50bnwjPeFkItM1L6F7JHLhr/CqL+K5VJ7WhBjWsEjY+s3BiDDsjEyIxhY+OgTYHNRX5upkEEJSxkBzniZBgSL5QtuLy0gY02a7MK8pJWWkyVnGX7nR9kVgSGKb7PGa+bYRYcIfeXyXcXte4Zi/S4nIjHbWPM2PlJDdSp9QwatqQMZjwPdejRojTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au2TeOyuXzWOq3tHvcR/f6Kt/0KqUXEd2nKodGWrGOQ=;
 b=bnnEHC3ecIk8rxI3H9QJYZIGI2Bq3CsbV7zEQ9C126r2g2vYH5i71v1Q523HlxXHxbbzIUIrpufwcCavlBANl+RgjsrhQbrp2zOKwLc4uVUcxhIApqWA1criVRhreDYpyKtVN5KQtb5MH3+yMqei7fzXbxhnwetTltlHPFHXcIk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4232.namprd04.prod.outlook.com (20.176.250.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Thu, 19 Dec 2019 05:50:17 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2559.015; Thu, 19 Dec 2019
 05:50:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Index: AQHVr+qGZa1SvOsf40W81LFPPtqF+Q==
Date: Thu, 19 Dec 2019 05:50:16 +0000
Message-ID: <BYAPR04MB5749EDD9E5928E769413B38086520@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01e547f0-d8db-49fe-b66c-08d784475340
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4232FC16811E558C08DC976686520@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(78114003)(189003)(199004)(66476007)(66556008)(8676002)(66446008)(54906003)(4326008)(53546011)(71200400001)(8936002)(9686003)(7416002)(76116006)(478600001)(64756008)(186003)(316002)(52536014)(26005)(5660300002)(33656002)(6916009)(55016002)(86362001)(7696005)(81166006)(81156014)(2906002)(66946007)(6506007)(966005)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4232;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3U/+slddiThf7MTVPaAj1qHkNMn7HrKngqwUfK7uY2PQcLvCxvA+u4i5+FX+snXBBHbZSnqcOZLlomtRjSPySuyEqvHmIC+CLplYU0EsgH7Cj+Zhhu8flzFNoiB3kHFVXv6i2MKJAg1uyhZS/FsZCVTpwk3slZ14YUZpT0smwHOXVbLrwFQEasIn9p46YejttIqOQUGoIzSWzOXBbgttZDy5iFo0vhPasWGFwR31pOJlpXjrp3jEJ3MkWZ3NuehI9NmyMnywG9b+FNvfPS4JnBNKasVAWZrn7K8EYVwHGxZ5XywISw362a+NA23OtvaGMv2LEVmBo0s9IjffF4YGFjz9Lc2aGJlSH3QHeHvE03qD+/PitxmjOLwgw+WA2oLdZLF/Merx0EhyzWZ8ewJjnqcLEra/1vxWyXf6/ZOU6v3DqRqIharuOud25SwSz2Eokfm9Gl6F37VIj5/7CjnNctL0CbFrfU3vGBORVYb/0hsK47pxTdtoznv5W8br1IJWGkw+bXEXf4bBVK2q339bS3SihRKjyDPvw/xcYO4aCFxwkulyNbojAG1lEf+g64yf
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e547f0-d8db-49fe-b66c-08d784475340
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 05:50:16.9489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Btgr0pNs1NbnT8VTmGcUIAO7ay+JEmp8bo4mKNJufK3bl9s67FcTmLE2Dkic13v2SQo+OiK9XNME6S7dA+rUSCTN2PweK8dAS0uFzh/IJVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191218_215023_608031_6EEB5503 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Bart Van Assche <bvanassche@acm.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Keith Busch <kbusch@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Adding Damien to this thread.
On 12/10/2019 10:17 PM, Chaitanya Kulkarni wrote:
> Hi,
>
> * Background:-
> -----------------------------------------------------------------------
>
> Linux Kernel Block layer now supports new Zone Management operations
> (REQ_OP_ZONE_[OPEN/CLOSE/FINISH] [1]).
>
> These operations are added mainly to support NVMe Zoned Namespces
> (ZNS) [2]. We are adding support for ZNS in Linux Kernel Block layer,
> user-space tools (sys-utils/nvme-cli), NVMe driver, File Systems,
> Device-mapper in order to support these devices in the field.
>
> Over the years Linux kernel block layer tracing infrastructure
> has proven to be not only extremely useful but essential for:-
>
> 1. Debugging the problems in the development of kernel block drivers.
> 2. Solving the issues at the customer sites.
> 3. Speeding up the development for the file system developers.
> 4. Finding the device-related issues on the fly without modifying
>      the kernel.
> 5. Building white box test-cases around the complex areas in the
>      linux-block layer.
>
> * Problem with block layer tracing infrastructure:-
> -----------------------------------------------------------------------
>
> If blktrace is such a great tool why we need this session for ?
>
> Existing blktrace infrastructure lacks the number of free bits that are
> available to track the new trace category. With the addition of new
> REQ_OP_ZONE_XXX we need more bits to expand the blktrace so that we can
> track more number of requests.
>
> * Current state of the work:-
> -----------------------------------------------------------------------
>
> RFC implementations [3] has been posted with the addition of new IOCTLs
> which is far from the production so that it can provide a basis to get
> the discussion started.
>
> This RFC implementation provides:-
> 1. Extended bits to track new trace categories.
> 2. Support for tracing per trace priorities.
> 3. Support for priority mask.
> 4. New IOCTLs so that user-space tools can setup the extensions.
> 5. Ability to track the integrity fields.
> 6. blktrace and blkparse implementation which supports the above
>      mentioned features.
>
> Bart and Martin has suggested changes which I've incorporated in the RFC
> revisions.
>
> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
>
> I'd like to propose a session for Storage track to go over the following
> discussion points:-
>
> 1. What is the right approach to move this work forward?
> 2. What are the other information bits we need to add which will help
>      kernel community to speed up the development and improve tracing?
> 3. What are the other tracepoints we need to add in the block layer
>      to improve the tracing?
> 4. What are device driver callbacks tracing we can add in the block
>      layer?
> 5. Since polling is becoming popular what are the new tracepoints
>      we need to improve debugging ?
>
>
> * Required Participants:-
> -----------------------------------------------------------------------
>
> I'd like to invite block layer, device drivers and file system
> developers to:-
>
> 1. Share their opinion on the topic.
> 2. Share their experience and any other issues with blktrace
>      infrastructure.
> 3. Uncover additional details that are missing from this proposal.
>
> Regards,
> Chaitanya
>
> References :-
>
> [1] https://www.spinics.net/lists/linux-block/msg46043.html
> [2] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
> namespaces-zns-as-go-to-industry-technology/
> [3] https://www.spinics.net/lists/linux-btrace/msg01106.html
>       https://www.spinics.net/lists/linux-btrace/msg01002.html
>       https://www.spinics.net/lists/linux-btrace/msg01042.html
>       https://www.spinics.net/lists/linux-btrace/msg00880.html
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
