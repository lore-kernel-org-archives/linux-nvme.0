Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B2C43457
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 00:26:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C70D2078A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 00:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dd2r017p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q/pD9HtU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EMHuHXd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C70D2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=U5y8kNPrZeVmWUDifFE63nVjf0wSBCwcvtVOGf441Tg=; b=dd2r017psWiNxsEF3uIzkiWRA
	oR8CpeTPNMkN0rsWyWGi+9p6rB+eq1S6d8MbX3uI+HDl+y8Z1jXbT40Ynt5HCivJhcWfXZt7mmUif
	Aj1uyr2khROJvqjRHd4XDK22KOsjIb29nkeEcGauWXdFOKbP1CMZHOYh2qwAQRcHLG3pUognLCWm6
	ly5gExjjWfIEWiPZNL3Pofh8z0s9LBTzsmVdpUC58miqLpZL1SEpx5NRNASZQcQcX7mUzXMh3mOTe
	+Xmj39aJILX23rbyvsTVGHq97a90IEapJSiXf9uzggmAuMlXx5Sh9Kl4Gxo4E+WkNYYCRCUCIKck1
	POIf8fQ9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSUcL-00045q-Ma; Wed, 14 Oct 2020 00:26:09 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSUcD-00043b-F9
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 00:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602635161; x=1634171161;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=bZhhV9tVCwk4E0rMV1SVgBzKsn5mYO9SXvH1Nv+nj9g=;
 b=Q/pD9HtUOVgWjH/Mzm4yCUeOZqxBAtOQ9trsQs88qGbq/rQAYWgwz88s
 10HA/idnDZ0eFAku3UY3BKowwDHbW8hoPHcyxSqd5yYMoEmahHj/0MkUz
 4y+vDR2d3xoTXp/8scwPuz1GUS0pcc0/9dvNuuebEDO9oFPn5429Dgnmh
 i/hGCUWRY7REqDbvY8tS34xBSmpdJ4+4KS+pqmnKjDVF+geRL0dthUrji
 dXG9SYtu0m9WrhRfiQ9I770F6pTtShuyuwwOOFWuVVINHyds9FFEGK4xf
 IAmw7HvqtmFfWCJcgfS3zuLJgFgxom9DvvaSVa9ncvCkGnpibmINGfa5r g==;
IronPort-SDR: 9ly3DpMPPgMHDIzupTyOJphPUp6vcHySreMhyAmzh3dE4T721lYNQqR+HdvNZN/ueopkVquptk
 gaLoq/hEcFzrXeedkCEP7eTh7jpYrB/8OC1WrODJQcIxKzrAyb7OdJ1VoH9PdnwGAb8LSLqOJk
 vVLe4Rs7kJMIbQLPOTk+xTWK0pbqY82QJjj7OHCrgrELbaZAb+Q++B5ZPyObqN9lpMjW41gMAt
 VvT7IeFZ01z7Y6cQbpD2osfnbfe5F18f6XngHzvbRiVCaVsOzyJLiQPHPqLDTy35ZObFRWi88U
 cGU=
X-IronPort-AV: E=Sophos;i="5.77,372,1596470400"; d="scan'208";a="151000374"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 08:26:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmwrfxqRGCOeXta1D6Qjt/wSPL3UPXpfrY1WyqnQEMV8vhisxTuta4exx8Camd/Y39FzPaf3y3+BUrhAq4AojmSghvt6AQwKEnQLOZtS2L/MAWlhWxhkR0v+jyxwpwPNd8Ka9rlk/SY+cZj5FXFt+K6vJ8qcyjqT8q671rzIMO19B88Akev+j08pKXXvopca85pO9HgcQejl1JkaJ+1vjpJjZhtP0h70wYzhHQz2vcIkN7IWisFRFJmNEF/5KPGWER9gUBX7kp6ICNTN47RtZFRmPsLZB/0VAhOQRFDyWcg1B+3uho903adIRzyRGZ98iNiUyRiuZbKy6sxQeegD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgGmWMK/llTiu+rj/wrp5ikZJ5p/Y9nV6dfI9xtcgd0=;
 b=dAgaHF/pjaUo6Ej6M25CsdElpgdHm3A6hZWOVtuZPJ2Lr7ah60N9lkJXmZZB96YJCGd7JESSrmf1p650DnH7uCjZXlb5iKsjv5yh4swmo9PBk1Umuy36Zb1ALtCg3ROjB0HX07QXVHfHSRvDtxEuYDb+Z9dMxqoXFOEQVIcscOIH+JA15EcFc5EArRL1tdXQ9BQYqrgVomcbS27QyFGNsE4hxO+yasWq65vGrvK6jUrl5JQebBx2wqd5mEMD0RTfumlUvlXideiUd4sc0na/7UP9MJ/YLsjvwCSTLZFJf8gnIeJRwQHtUt3Gvci2XVyLy8x3jGRMTlC9A8vqLc4XOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgGmWMK/llTiu+rj/wrp5ikZJ5p/Y9nV6dfI9xtcgd0=;
 b=EMHuHXd1ifoSJbIT3G4gSeRszV+55IuqJa67nVI4z+abLh7+UdSd94gH2NmEIyUXuNFd4CufDsImeCcveeNgkGUcrH6GmoLv4nEWQBg8Wuu6HT8Xer0K+AwPRjqsn7vL3vYbIZoXsl14Eazamect/Mx19mZWq0soMl/rdYULBps=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6024.namprd04.prod.outlook.com (2603:10b6:a03:e8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 00:25:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 00:25:58 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
Thread-Topic: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
Thread-Index: AQHWnpKB4t9kkbWTmEazQV1spdywRA==
Date: Wed, 14 Oct 2020 00:25:58 +0000
Message-ID: <BYAPR04MB49654B340081F257BF9C4BB486050@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201009231816.1524-1-logang@deltatee.com>
 <BYAPR04MB496556A3CBC239BC57EE588B86050@BYAPR04MB4965.namprd04.prod.outlook.com>
 <e7d76d3e-955b-1827-fd2f-9b7db49646ed@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f618829-5682-4a28-5bf6-08d86fd7b8f0
x-ms-traffictypediagnostic: BYAPR04MB6024:
x-microsoft-antispam-prvs: <BYAPR04MB6024326E1F0CACD02AE8537586050@BYAPR04MB6024.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqwzLmVFbihHeY72BPXuHiqhgMSVcaRVZIvDeZVLvKlx3UYz3VNdHCx0BnsnXe/I+3J6uMDQMXUK76XKnSY1mlRmMhIrDVAYDt8JzCv6LsmWNYe6sL4H36r2tuAdMqfm5I+rYeYJ7TQ/fdSY9/VryAWJJY4lVrUXKIKcWhDYZJmB4k8UmaxYLYwAIUIA3H7ujT1gTjFkwjFllolumZZRYC9xy4f6KSOgh6xaM96S12pUyRAiOj6SsbfBPMtf+/ZHxyH7ju3JBTbUsUPA/owjDzkB+UU/kyZFvd9KrTrrVrj8E56NpaV+bCyrPIdRghBPO+8HuGI8YBjArH8GMCyEVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(9686003)(5660300002)(76116006)(71200400001)(66946007)(66446008)(66556008)(186003)(55016002)(4001150100001)(26005)(52536014)(66476007)(64756008)(54906003)(110136005)(86362001)(4326008)(316002)(2906002)(83380400001)(8676002)(8936002)(478600001)(7696005)(33656002)(53546011)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: h6qwAv7StqgcUcmxgVoKys06eBjstHJIHvNhID/EuaupobFRPPC/cEsvfPUAxvxiDUEyBC1BC4xuDqyKf8KO3igTHCd7T2JR4DZWbI4gpz9bzHSlkAFBzDHA1IkeqeBDn8aOZyZz0AbKYwk99gXHhVO4TMhCmbKhNWcgBXzBspS0jCTMcQUI91Kp+GVDp5A5sXwknQcIwUh4ha8NwNlZv1hH5lh+5SbKpc4gqiC9X1HTDO8qNNBC7BO4dSe1T7G/5m9GYUnat1s0HlZEVqDlGKWba4Id0w/8IWeD3PYOwVF0VPDrLd8goi9BU6atDd8qBlifIElxoVMmx1NzdH28uHaFSKxS4dZ4juXXlqQc5AC5ZOfcYsnU60OKrr8TADlHFtVMROz0a8VSWW0WRkIIrp1s727rHQX/8gt+jZTQFNF6eO2szp1ZsWWcj7I7pSv9C2newBE8FP9uIO/HiOffW+omlnti0UuSeuQqzLL8Be3i4wPrnvJfNSlhI0uiddgd9tBuMC6WaQkUbaDku6m1TTfLEahI2FEaMzm/Rzky/0rH7twifQaeCx78U6V60wHU8KN/5rNn6Eg3jcIiK+iAKth1Zzv28saefQH7oYJABsB/+gqQrz2aSHjmiZFWHXA2OeiNwX18idlm6KM1sXiZbg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f618829-5682-4a28-5bf6-08d86fd7b8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 00:25:58.2777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5jknBFzHuMWV21q5M4jg0Ag1+6OH8UDqIuwYwL2/HIBdX7kqfMPF3xpzvfa+FhLijD0B+pjSUYMeikbSn/W7jRDL7imiznctQ9ruJzDlAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_202601_661083_E1C48168 
X-CRM114-Status: GOOD (  15.86  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/13/20 17:20, Logan Gunthorpe wrote:
>
> On 2020-10-13 6:16 p.m., Chaitanya Kulkarni wrote:
>> On 10/9/20 16:18, Logan Gunthorpe wrote:
>>> Clean up some confusing elements of nvmet_passthru_map_sg() by returning
>>> early if the request is greater than the maximum bio size. This allows
>>> us to drop the sg_cnt variable.
>>>
>>> This should not result in any functional change but makes the code
>>> clearer and more understandable. The original code allocated a truncated
>>> bio then would return EINVAL when bio_add_pc_page() filled that bio. The
>>> new code just returns EINVAL early if this would happen.
>>>
>>> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>> Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> why the prefix is nvmet-passthru ?
> Well that's the prefix I used in the first patch, which follows other
> similar conventions like nvmet-tcp, nvmet-fc, nvmet-rdma, nvmet-loop, etc.
>
> Logan
>
>
Those are transport types and passthru is a target backend.

I found this [1] in the git log, only one patch has that prefix.

The convention is to not add backend prefixes for target patches (see
bdev/file),

I'm not sure we want to start adding prefixes unless there is a specific

reason.

 # git log --oneline  drivers/nvme/target/passthru.c
dc1890b99602 nvmet: add passthru ZNS support
df8dd70a9db8 nvme: lift the file open code from nvme_ctrl_get_by_path
3a6b076168e2 (tag: nvme-5.9-2020-09-17) nvmet: get transport reference
for passthru ctrl
7ee51cf60a90 nvmet: call blk_mq_free_request() directly
a2138fd49467 nvmet: fix oops in pt cmd execution
4db69a3d7cfe nvmet: add ns tear down label for pt-cmd handling
0ceeab96ba59 nvmet-passthru: Reject commands with non-sgl flags set
ba76af676cd0 nvmet: Add passthru enable/disable helpers
c1fef73f793b nvmet: add passthru code to process commands


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
