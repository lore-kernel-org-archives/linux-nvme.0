Return-Path: <SRS0=pYv0=XF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6106FC5AE59
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2019 22:28:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3515E2171F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2019 22:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C5/deeU2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HdwIZHJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3515E2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vR4eh7Y4OwwU1Mb/4i+9AHPIrpb+HiG2FxDOP8A0ltc=; b=C5/deeU2Za1wlNVCbsIM9mABp
	tlHEpg0lBaHz+jwpXt1Ph1DLIDcl7xsb6VkhhkxvdygPvnMR1iy8wzPMUGbxUw9H8qjd1T7nz8crE
	k9ktf294gd8OhCssBDSlBktqF5XcwEuRt3obklKBZ0KPzLumB1tAvcdpnbTJtIn0cj/40ruOcELaY
	TlTS8FzXlWj/CeEc20rsQbkH24tvuNYhcntMDeQY3PC6Lla0DmZQPV993J9+caiKoDDYWQhoZDPb4
	gNVH9P6xqBNA+aI3DAJ3QsdB1E9/OmBV3Ywqep0SesSAOx3I9TgKT5WV1EORJjkt3bJMltcJqbCG5
	ipEjTaW5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7oc4-00020U-Qp; Tue, 10 Sep 2019 22:27:52 +0000
Received: from mail-eopbgr150053.outbound.protection.outlook.com
 ([40.107.15.53] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7oc1-0001zn-Nn
 for linux-nvme@lists.infradead.org; Tue, 10 Sep 2019 22:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUm4cegM5hwezL89nw06mCo+ib1ZZNC3BSw30e2n39b57dyzxgSZaH110H7q/gPABTSXHLgolpI+9r3UNAIIHGjD1cVHsWjBcrzVFEgvbRXv29lltCtKTHUyHcixoTm+dOlQKowBmnLgG5Th9x6A1yMdQMpYPjCaqD5U+ApDJn3apkQAZGfqmNQS+93tNUu2C4ZJIoMMG5mQQjbCVg9P5mDWMa5mlnH5ZtmaTtL4lLMNDd+Ciylu9k08mgiQp3fuKZbZGRTy4+nXA6ABZeGUeGWm80/r2GnIZP9xpnQp6D3BXPpQbXioE95k9RUnCBvoVNGasvibEzOwQrd51Ozs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueuqhc/E9CCt8XZTnfi6ZGUiaA3iPjH6jHyYwtDZ/CM=;
 b=FxhpgTR3G9MJIVrbHbz7JaD8eBI4g7Sq26deCH/fRO4Jo8XLonIFdEIEEkdkjQzYBLKMjeJXWVppjBoRRPUR853by4vv6mzRtt8V5AFMHNOLSxHyuRyEy1fbRT8uYOoxZXiJrCTtm3XldGHndvzsEFL7dmXvKCuY0fcYLftZP/8Tt1654OgiQwlwc2+z81cZaCObB1UcRNi27xVqpYw0ZlV/HQ21Ogs6Tqaas978i0YHB6CLDkeQwka3TA9bRyjjEpOQbJV+k4l8NEBgtmq4LLXwmHY8nfhkhX1cSBlFs++PWtCcHYQeoF8ejfhYLksE0QazIxN4DoyqksbLlBv5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=grimberg.me smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueuqhc/E9CCt8XZTnfi6ZGUiaA3iPjH6jHyYwtDZ/CM=;
 b=HdwIZHJ0Q2vh8DcWz269X3P/+KOuqqOFKb8sVIUNFIbkvnwbVc5fs8xI6clcOFYf6VZxPnaAOsYSV8IrdZH5jJD2waev1/lXY1LsyYgdf2Y/IcJbaurm6jwIaH/uZ4IUgSKhpwmO+W/DwgeEHrlqr4rgv23fHFihZFKhMbHuDhU=
Received: from AM6PR0502CA0059.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::36) by AM6PR05MB4454.eurprd05.prod.outlook.com
 (2603:10a6:209:47::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18; Tue, 10 Sep
 2019 22:27:42 +0000
Received: from DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by AM6PR0502CA0059.outlook.office365.com
 (2603:10a6:20b:56::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14 via Frontend
 Transport; Tue, 10 Sep 2019 22:27:42 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT031.mail.protection.outlook.com (10.152.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Tue, 10 Sep 2019 22:27:41 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 11 Sep 2019 01:27:40
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 11 Sep 2019 01:27:40 +0300
Received: from [172.16.0.16] (172.16.0.16) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 11 Sep 2019 01:27:31
 +0300
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the block
 layer
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <yq1mufei4zk.fsf@oracle.com>
 <d6cfe6e5-508a-f01c-267d-c8009fafc571@mellanox.com>
 <yq1d0g8hoj5.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com>
Date: Wed, 11 Sep 2019 01:27:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <yq1d0g8hoj5.fsf@oracle.com>
Content-Language: en-US
X-Originating-IP: [172.16.0.16]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(199004)(189003)(51914003)(53936002)(36756003)(16526019)(2616005)(476003)(26005)(356004)(186003)(53546011)(478600001)(4326008)(126002)(3846002)(8936002)(305945005)(230700001)(65956001)(50466002)(7736002)(86362001)(81156014)(65806001)(31696002)(70206006)(81166006)(8676002)(6246003)(6916009)(31686004)(336012)(11346002)(446003)(6116002)(70586007)(229853002)(486006)(2906002)(16576012)(54906003)(316002)(58126008)(23676004)(2486003)(76176011)(106002)(107886003)(14444005)(5660300002)(47776003)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB4454; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d426a94f-1d45-4a2f-1c69-08d7363e1841
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM6PR05MB4454; 
X-MS-TrafficTypeDiagnostic: AM6PR05MB4454:
X-Microsoft-Antispam-PRVS: <AM6PR05MB4454D4CC705C3884201FB67DB6B60@AM6PR05MB4454.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01565FED4C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RsoYQRowWKrgsqvcIq2SRweTdErTHW/yNC4sDIBWInGRHPS+jdtUIMn9GO35dYXZWr2LCq8pjiJ/4QMLr0N4HzI3we7ORYH2GQKvc4Fo9XqkG0WUYPLakUm8FrpGc9n4HCBoCVeBQEerN0NErD7u5dBt3uDZzIboeGri8xYIzFU6xxiiECt4cyOraebgWpl8vkNp9IHqnbXTEx1YafNAykijpbgsQOEU58c5VxKE7aFR6wiJwAYsKinhNeFVEySJdLjmztES9FID8DqNFpSN4CSI7/qW9Avfb4q88qmVCo49Kl9R5Pa+lzSdqt9D+br39ZqjpCfodFrT+gJOjydZYp47C7GXcAQ/0xxxpjFJ/7NyAY1Eux/Klg6BO2b+65NkMcWmgda8TegRKmiPrhpLq6FXD/XUWE3YtTi/dQafItY=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2019 22:27:41.7315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d426a94f-1d45-4a2f-1c69-08d7363e1841
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4454
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190910_152749_789095_7AE5201A 
X-CRM114-Status: GOOD (  20.40  )
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
Cc: axboe@kernel.dk, keith.busch@intel.com, sagi@grimberg.me,
 israelr@mellanox.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, shlomin@mellanox.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 9/10/2019 5:29 AM, Martin K. Petersen wrote:
> Max,

Hi Martin,

thanks for the great explanation !

>
>> maybe we can add profiles to type0 and type2 in the future and have
>> more readable code.
> It's a deliberate feature that we treat DIX Type 0, 1, and 2 the
> same. It's very common to mix and match legacy drives, T10 PI Type 1,
> and T10 PI Type 2 devices in a system. In order for MD/DM stacking,
> multipathing, etc. to work, it is important that all devices share the
> same protection format, interpretation of the tags, etc.
>
> Type 2, where the ref tag can be different from the LBA, was designed
> exclusively for use inside disk arrays where the array firmware is the
> sole entity accessing blocks on media. And thus always knows what the
> expected ref tag should be for a given LBA (typically the LUN LBA as
> seen by the host interface and not the target LBA on the back-end
> drive).
>
> For Linux, however, where we need to support dd'ing from the device node
> without any knowledge an application or filesystem may have about the
> written PI, it's imperative that the reference tag is something
> predictable. Therefore it is deliberate that we always use the LBA (or
> a derivative thereof for the smaller intervals) for the reference tag.
> Even if T10 PI Type 2 in theory allows for the tag to be an arbitrary
> number. But Linux is a general purpose OS and not an array controller
> firmware. So we can't really leverage that capability.
>
> Also. Take MD, for instance. The same I/O could be going to a mirror of
> Type 1 and Type 2 devices. We obviously can't have two different types
> of PI hanging off a bio. Nor do we have the capability to handle
> arbitrary MD/DM stacking with PI format properties potentially changing
> many times within the block range constituting a single I/O.

I guess Type 1 and Type 3 mirrors can work because Type 3 doesn't have a 
ref tag, right ?

> That's why we have the integrity profile which describes a common block
> layer PI format that's somewhat orthogonal to how the underlying device
> is formatted.
>
> There are a couple of warts in that department. One is the IP checksum
> which is now mostly a legacy thing and not implemented/relevant for
> NVMe. The other is Type 3 devices that need special care and
> feeding. But Type 3 does not appear to be actively used by anyone
> anymore. We recently discovered that it's completely broken in the NVMe
> spec and nobody ever noticed. And I don't think it was ever used
> as-written in SCSI (Type 3 was an attempt to standardize a particular
> vendor's existing, proprietary format).
>
> Anyway. So my take on all this is that the T10-DIF-TYPE1-CRC profile is
> "it" and everything else is legacy.

do you see any reason to support the broken type 3 ?


>
>> I think I'll prepare dummy/empty callbacks for type3 and for nop
>> profiles instead of setting it to NULL.
>>
>> agreed ?
> Sure. Whatever works.

I'll send the patch tomorrow for review.

-Max.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
