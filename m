Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B536C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 23:55:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1884C21941
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 23:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wKmWSNUu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YsZUOP0v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="abXx2G/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1884C21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=dFRIFeAiZbzEX4Rpd0bOdBKNuT55dkWZWBlMptYTWzI=; b=wKmWSNUu47PchbgHQ+i+s6fIk
	WaqFVv3tcAZSXeK5XJLVwSAHoqWLzdCoMA9kVrfc0MXzGWLGd0ZAKY9XD4O5m52OvKamPg6mTPi3c
	UZCVrIO0qH1RYHdxQ93mFcnJUmwD/iqIfSatD/iqRNkwgyDdpvn1ZiP7RC7pmWvJPRQBuNKiDovEQ
	64+DeTXHNH7eNV26IH8vE02Y7kaq+KoxKDtb/dsmXr7Y8OeqbeyF9kvj+fQeH9TzWgWia5azYJtSN
	eJIS3x2cFOKTF1xdJZa+h1Ox+T5IQn+pCvyIXesOrd5/CCyvfpoLTHnr35BI6Sy3ncViH5BYW++Om
	XIAqE8fGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIhH4-0006LI-7U; Wed, 16 Sep 2020 23:55:42 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIhH1-0006Km-JH
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 23:55:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600300584; x=1631836584;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=mSQM1UcbNmqR3OJ1vTDfpfefj6JNidRwVe6WBFt26yI=;
 b=YsZUOP0v7jm99iVNevSbzbgkrEYRpP51AquvF4CcHJ7PZUFZE1rWIvmm
 uua0IgLhz8tKvUE3nlQ7hK8qzqLLz4fABBxECRjVZYXhKISbEIMvOvpIs
 NcHuy4YieaJVXLLE/mexdgs5Dt/tH22tjOkQ3rb73QsrGYxnaUHh3uBWn
 /utVzz6mSyRduxF5o5A0SYL1FNZPC8DrOiDVM+fItk22Mv5i6kCcpCSV+
 XV1hVG5QTPQZw/zgmOJ4ZeKUcExUA9ARy7WzJ2cW5bJL6V9IbRQwcS+wk
 5jYixDAVL+vaHR2xEuTQp08mJOKcm4uJFlSYpb++P+tm8cwG51k+CuhsP g==;
IronPort-SDR: bVpSitGlA48+K/dXUSwGM1fvO5DCFeBHtIwkF32DCpC9A34tZNs+Ksr4kRuwAclcBTUkOHcefc
 RPbYlfEVq26XZVvlMcXc5Z8rnKc5JFNx0y8jzipj3P5Ka5WMtN6DWhHbcJ4fRW9cvZzUxo90JM
 7dUXCvsvzZ+kA8GLXWPTL2FE8VxX4YGhjbnY0ct89dH0jlt+GlGv0yIjin0jLcFcKNM21btmcJ
 EW3NepiG9Q7/cSDv2/bW1ztYOKxNXGCy0AIbJFBgBICNVrsX7N73hRFb9DJiGiumswD3vATMQI
 uvo=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; d="scan'208";a="250911473"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 07:56:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOzrFFAL+OTCrH6CE7eFc2JsVHOQ4tw5WdtBJMADzraVzMiN77XRNbOCldPiKIZDLv+5kHwD8biu5PfR5ZbJU9AVnEQu4HD4hfWKP9Rz11YjrLBe4JFXFFXJDcEP8KIyYba2iCpxNhSJMyOTiQKdv7ujLcD/pETTt/wxzP94DDw2xkVUGLEj2rHiycy8yMZ4l0lRNnxjjPugQoRJnb2Vi3/SIXxW8gXxO9C+Jr8xFdiF1lkjseDnSQDOV+Ef77Ym16QKE1w8TVe5h+DXTz30BMIpFN+YXDnVcErfwF7Z5TV+pZ/07n3PMeSwk5pPDiQXwyjjncA1xL4NyHfk6cHU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSQM1UcbNmqR3OJ1vTDfpfefj6JNidRwVe6WBFt26yI=;
 b=S3oDjDO3Tv4gjr6rgXc9WPO6tME+WRRHkBUbcquaSuIn/scwVQIcyiS/DFwF+obpAxqjhrv6uH4di8a+XeAcLlsFHOLrgFgAsZmSbT3/lM8zRkrA7cO/OjXWtZ5ogNEbF/o7uFK9tWKVMgl8FsVmFc4QJGkxVeeEBFZ3NlFe+gYOmTuXOA7YpMM8tIyPTSJh+BZ8xMTSatoH3trJCNapj1IIIhgOe+O4UrAQj+8yhmb5jvm5Y36d6RsTxXN7F9om4fKSJpOMtuzzeKqGt/nOcjGBqZX76fqLvxh5XnjBH4zu1hTIWNRb4puVC23ROgnVfEjOSUIPq6OjwlHH5nCnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSQM1UcbNmqR3OJ1vTDfpfefj6JNidRwVe6WBFt26yI=;
 b=abXx2G/0C7kiNqg3Ja9D3An0HjNSUrmiPPZbEDicAwGPcW51bZvFNvyifBlammNh6SUEqB07fxUY6L6f7A41qKRkPZY2p+oVoPWy6/ssi5oUMn6w7s/nK0ZhBHXnuZxPSiRrZcVIRrWMU68zBE2lVvV4qTmCgko8IOEmxjQ8Am0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6690.namprd04.prod.outlook.com (2603:10b6:a03:22c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 23:55:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 23:55:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Thread-Topic: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Thread-Index: AQHWi7SiU+yGXE+Gyk6gjm+/HimNtA==
Date: Wed, 16 Sep 2020 23:55:36 +0000
Message-ID: <BYAPR04MB49652FCF7820D232A7428A7E86210@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
 <9aaecc8f-7eda-b792-2e5f-a8cc8f8178f2@grimberg.me>
 <BYAPR04MB49658A3CB5BA3AB70434551E86210@BYAPR04MB4965.namprd04.prod.outlook.com>
 <9ae2644e-73e4-768f-965e-ff1d41c19c6c@grimberg.me>
 <BYAPR04MB49655525AAD3191DF31E2B9286210@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b9851360-0087-adb0-a355-62700d4fe047@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8d96a7b-db71-434a-3467-08d85a9c01d7
x-ms-traffictypediagnostic: BY5PR04MB6690:
x-microsoft-antispam-prvs: <BY5PR04MB6690B0C4BEEC3F2BC501B46886210@BY5PR04MB6690.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QL5Y5pDnuoWrBj6fk0jhA+gNDv4Y8qM0ZiAqP3CjeKoy7yYi3LDJ7Om9XV1V9wyUTFk1QCk8VtvKC8FqD2qjf8aOkJkJ1i2ms2XHIPxEvYvQ7oVilOdGltZzLs2WTcLcwSzFEjuEwYiDql/3+a73dl/F6ugQdBNIiy2+pl8tOvA61YNpxpgtD091OEXIdUK8FJF20uJBY5QEPsqLOgbe0zfGrzlIWwVpWHbuDKM4O8HO2czsWu6slr7qSNxleiR+suw3Gv+mcTDPvXY4qGa9d4c11tqJGzyk/PwfWfQZMOV/vvivI+GrwL8efasYkwQ2m8MpD0GBcj1agdinLuMksQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(71200400001)(26005)(6506007)(53546011)(8676002)(4326008)(7696005)(316002)(2906002)(33656002)(8936002)(110136005)(86362001)(9686003)(186003)(4744005)(478600001)(66476007)(66556008)(64756008)(66946007)(5660300002)(76116006)(55016002)(52536014)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Tha5QNYzGOV3387uL9oLkGQ2Z5FOmaAEItRiiAxbb4V3Wq6w1vl7zt0dRSwmMZHDYWva42ahx1JC5T8AXgBAdVXXbjKSOOq6aZUMUkJYsdXlLZahGQLBQ1DT7QcKr1Qkmww4t55L9KRwCR+oyFVG8MMPpsJtBvLsCsA7iv2WhofHZ2X3quney5JoFp/xboVV41dtsmT+f+DUwA9ZGeQxzDQyJptQOADbAvCW8/vukumAsvWEXrVwTuIK4C8Wb94dAgd6b7a3qcglVbLI7pzLg3YQ/7qYP2MPhPaLd2PyuUwyiJVQl7L+wNUL0cpjL1DRDCgh098Ox6wdZw3a7zyZTL2dvOeeXhw/lNyJETFSixIDax80lRyaVsxlk6DSdfPHPJSgf6hmDk8Z8t7ng8abZr9ZAohFZN4iIi+QfIMkhNaI+IkjS0fXAjnzhSif1d8s5X5KNPd07ZK6XUB1TkjQ0RBAHmMvW2ZVkic/b1U+gbQPGceLxDp8ZpuuthqMPCH2L4pmZYVUWR4OpwUFH6rid2zDoqMMkVZXmP0V7Csux9Dz9q+7sQSNxqsHLmG/M9ArNFyW40qP1skJtVdMZYuMMjEmism9SQqpuCAMPEbXZ77RaiorxMN+hNti1iADUT0I/H+FPFEbZ4FMvt7LAwi8ag==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d96a7b-db71-434a-3467-08d85a9c01d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 23:55:36.3954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwZn2xEmuv87ptw0DUQOoKAaWbSpN6wRh3frkeFl9/OQFeCUMPR2JRjcoJgMeYRKqnwb/3orzqkjbC2Wu+fRYydNPlI7kZRG3vaNgxeyX0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6690
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_195539_942470_D42F449D 
X-CRM114-Status: GOOD (  15.84  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/16/20 16:30, Sagi Grimberg wrote:
>>> I'd say we need to fix nvme-cli not passing optional parameters by
>>> default...
>> I assume that we changed the nvme-cli to fix the issue and default
>> behavior (i.e. expecting and setting the ctrl_loss_tmo).
>>
>> Changing now again will break the fix in nvme-cli which requires this
>> default behavior ?
>>
>> I think it is easier fix with right comment documentation so we don't
>> have to rely on the tools, plus it is only for nvme-loop which we use
>> for development and testing but not in production.
> Its going to keep breaking if nvme-cli keeps sending optional params
> by default.
> 

That is my point, in this case it doesn't hurt as we are not breaking
any production code/expected semantics and keep using the nvme-cli with
a fix.

> Don't care all that much, but it just seems backwards to me.
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
