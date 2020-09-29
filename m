Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED7EC47420
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:17:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602632075E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sdip9Zdu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i4x02AAA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Sw5F3vdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602632075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=RgxDveWwy2hMzg9AguVCG5ERz8UoTWP0/g04xS2i5JM=; b=Sdip9ZduByP6/Z2PSJmbYSMBd
	8WAzmGckWZuJPCto9ng1lhNcqQAVd+iRq8fyBxtGXohi2gHcEtzWWNqqc875fcBtHA5knQQVxtgF0
	u19zCsaW1pQAs+W44Bh3mTGGYmtcFLCAIoSk45vE9cwT7kMCYsj5XyPcBsBLD9B4l8rv7Jk8R0aDS
	EgAeqOgzQa+8avXVhhHuQq/5qFReq73hV2tbLEs/GewD1hp7p20g6Ay+fENAT/iHhdL5DYC0nrlHH
	hduJrpgJijLSPA0MfdyhZsKuraZhgNBM7LnWaumb0/7XW0MHwmu1wuQj0P8p+X6pwdVQyx8tqv59p
	702AMCqLw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNMzs-0001fo-7v; Tue, 29 Sep 2020 21:17:16 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNMzp-0001f7-Pb
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601414233; x=1632950233;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=QP7Cw/7h2rAV2qglPUcsLp4X4i/RaRvtQead2TT6y0U=;
 b=i4x02AAATX9RKvyhUwge2wAJ8YpwtyzU5BZWVQoVxyuTTnMxlD0Ao418
 AG6Hn+pub00oYYdG7iWMP6PrGtDNkDByLZ+juDGcvc6qZOUCR9fujHc0V
 WiR0mfqiOET+8KHKxMDrXJi873sZl5SKyRYSs52/imYv+z8KLYTqRsmDX
 PVbAkd9FUphrpJ9N0h+ZZHR7RzcOIyfwrw0CBmKD8QgUdKyJN0jSZ+OOq
 8yw+YZANoQm56o3aZp6x//52kQ+DWZ2VBXANiUAY7+ATWh3Fbj3e5r3Fn
 6enqX2hCHAph1ZsIUn6cnlf4CX6LslKQKgCUkUOoy8YF6j/vIyGITZLcx w==;
IronPort-SDR: 74f/EdqoLvBVxXixnVkJVETMJHyyRWHyXZOH3cgmmwOd7ne5XeoZHYpPXR2Zsz87WCXdIqp+s3
 13JQEoY1qHeUAhIjGLp8RaxoRFSjSpfvC1TcLhEDmj43jOyx8EuoE65yueccsLE2tEP2TBJPHf
 r6kiXdhFZgvFCKlLdUxGW6jZHBAIiHB2m60WGwgGp+LfFVO0jXQs4tqJfaAGP8ZWfj1RTJFJON
 0q1ZNQRWx1GVhlwfe/+71QVYbxHsfiJ7ybVbLC2HvDdyUdoQvHlMTiSBABONLTNLjml8CZ8bGL
 8wk=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="258329855"
Received: from mail-bn8nam08lp2045.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:17:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtdZjJhsvN7+rRqjSR18d1nD9GkBwAZZMQZw3BRNCqNZ7P7hqai03q5Qtdjjx5yMBoiMgINIT63WjFj8PImtItbQ1+iyDRmSN9UGARE+1vfvUaug2+HIcY5/AYYBf7K6VT7FpGqMeXSJrSAjtTIfvK2jl+yRHvLDzrL5DzjYbUx3XArrYgZiDwcpNJUOg/f3/I+/j/ZHTWfd4CDclwEieRhv+FM6uJcmBlZykVnJrYJfyWfn3RxXtqoqcy1dioB2rkGq9+TMacxwVvLCCOk/CclZdnaOsSOLJoZRikjlYxtIiXAi3xGUV1itUkiKTlyHvpZ40ja2RB3egiyLxnHB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP7Cw/7h2rAV2qglPUcsLp4X4i/RaRvtQead2TT6y0U=;
 b=Vvac6bdE9PLmbh8UWFxVvZplxFdi0++PGIlSW1y+zYUU4QQzGto7sXhaphKdTK5qpfhFh2J8hM3F3qFpeOqymCqxFCOCqycXEA76K/wWCnIzVjq48C8H3qpeGaXdktfdKMW4wHQoyXhRKxLEzjXWyzu424M7afNDU9va3jhxg8jk935Ha46ptDP4T5OSV5zI9BcOluDdUPlg5h1tcdYhv4ZCzUf5NbvnAHujgex9PLssNI4oqtG+PEqLffm4Vcu2poJ1eziWVO1I/716OOaSkVteujhFn+vFsHrrvxH+MeFd/A8khPE1D8t/3qxagA6RQzhtouTNfFWI05iUnovXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP7Cw/7h2rAV2qglPUcsLp4X4i/RaRvtQead2TT6y0U=;
 b=Sw5F3vdgJ7S6bRIqb8qtlyO4taCosGveanI9ydKoy/lJCqHi9ohfomIY6kVJCRTTVwB0LA5bH7dV5N2nIpfrF30+uUJCFC8efDQ88yI3AF1EAFHEuWTqwXUxUcomfv9XQo/qMsG9HdruPzjEK6sevozWvzqU/cARjq8wviVLVKs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6102.namprd04.prod.outlook.com (2603:10b6:a03:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 21:17:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:17:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 04/20] nvme: rename nvme_validate_ns to
 nvme_validate_or_alloc_ns
Thread-Topic: [PATCH 04/20] nvme: rename nvme_validate_ns to
 nvme_validate_or_alloc_ns
Thread-Index: AQHWlZT3X81P4NXz2UyN+kk5HSqTzg==
Date: Tue, 29 Sep 2020 21:17:10 +0000
Message-ID: <BYAPR04MB496558454B9693844EBE759B86320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d408e19f-4e77-42f5-3b54-08d864bd0747
x-ms-traffictypediagnostic: BYAPR04MB6102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6102DD91212AFA0EBEF4F8D086320@BYAPR04MB6102.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wnw7YGEnHqymT0wtc2FDF4g0la5LL3OXPHltZtKAiFO92ZKsP0Ye2Pyxv97TJk97lhgcqlch7MPtM7VD5NMixaAqwbHs1wldPzCDV3WFcIuAHmhEti3cVLvVRarLeI/7EqBpxWtu0ompwK7LqBDhxD5aOcqytmD1M7MoQarukUBuGOafjDb+I36VjXcv+rhk+5EJO/spl+0ZE6uk7nt7pWwPzmr0unU6+6L1JwYoiZZQrwIJdoclvrrBxqu1k8lLGGaCn2tuwFhIFbC4tSvQf7otWt99X3anb6sW9rzO7lrawSdq2nBdgC/NfskT4syy9P2wutLwuyDf0JtVoVKHJAejMYai6IAcPw9N6Z56qML2BXVS511Avkw5sG/2UEej
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(55016002)(8676002)(8936002)(86362001)(66476007)(66446008)(64756008)(66556008)(52536014)(5660300002)(76116006)(66946007)(2906002)(83380400001)(33656002)(6506007)(53546011)(26005)(9686003)(558084003)(186003)(7696005)(110136005)(478600001)(316002)(54906003)(4326008)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: QG2Ocf9Cb1EjlJV1RuAzkLRPCtylNaP8JWNd1BdfstBMd56W6zgC4mx4EKJzF92vKSIFyu+pR/Trp/TtuB/bhfmutl0Q2zz7Gd/ZNSppDMGZ0cTWpNv4yTTgE8bzdjXMs/3BNqg7ntBG2BtsLCgQGj7dS+gRqBhqwfdZSotjlLS4H7R8SlTsy3FXRBr06ecmayD5cPQYPfsvbz+0mviA+IWneA/nO7cSEZ72UGkAVt0rhgQXZy5qziRsthORy0jKTMv2w3CDXF0erfimkUWpuaeMqo6vAzFDJh2bwTnFOc8pISKth94O1x4zP6K9bauY/XkeuONq2sdpLUpItMOL3+1IRZRGEkWkEQZYkGCIkpXS+i3AwWmjPfLotFbeOC9FOCnadqTkgyS397//EmLxNdOSYjwGFSga6tiaQ4Hvw7+vtECGD8kmJfd6WTs20LBC/gCn4G/6+IaLcofUtDH6/idAXs2oJpEcmszzfq14I+RNZlNAoR75Ec2oFrsZWsG0gzCY7MuNgjd5REBLesxEWMTVBoxcGWeXTDuEcafxJOt9tJdLGQb5XsssdnXEHW37sbNfzmY7WzY/nT0F9B1M/VtoiiAY8zSzo4M6rOz4qE/T03MQxcvfwGUpRjpVfQdbDvIwXdGlFfsujXMMC9w03g==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d408e19f-4e77-42f5-3b54-08d864bd0747
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:17:10.4751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81F7aXHGem611mlPx7r7iTzmTpzurgVLr7I/a6Uzjn/3XeoDWLMTi+mb5h/GXxy4xGEG0J23Ht9rZuLBMUQM++PVGRNID87gi77PT6SK4h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_171713_991384_899FE13B 
X-CRM114-Status: GOOD (  11.77  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:43, Christoph Hellwig wrote:
> Use a slightly more descriptive name to enable reusing nvme_validate_ns
> in the next patch for a lower level function.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
