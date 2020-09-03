Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACFEC433E9
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:23:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D8D20716
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eR2URTdg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I/izIBWE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kAAak/aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D8D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Sbdn2VH7CApZlD5hfWMkAKmKpx8oEGOzRc+XbnqDsZ8=; b=eR2URTdggxUdpWz8NQqk9+L5+
	0/Ma04mXmfs7qhTd+L2T2g4hKl0wXj+r7yqjzQFkUlPOB1M6J4XpQ6CAb1iGuMB7cejcHgPEY+C6s
	NVQSTifeW19ppNvCKne68AfLKW6JnDI7/kTyzeNTq+kCL29yC70Lx5su0TNUpGUXrQs/aFUFxso1v
	DWDz5beWvu8Eii2ZD3T+CuoXEMJTokT8PE3C1PWPWPBDA1egjX6KTsHrFnADL9WfMrFCZPMVskUCE
	nC27luZkUlKbfcAmaulm23SxkRoUl1ZW0VsMFxwse5ijsbS4nspyz50p1EUnsMKUdS7cDetQbPmIq
	qGA72T4Yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDttc-00078a-SM; Thu, 03 Sep 2020 18:23:40 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDtta-000786-TW
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 18:23:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599157419; x=1630693419;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=GO4WmDNE1EFxvzDS1QeoHzCCI+y6+WAG1rz9T9Gm3Tk=;
 b=I/izIBWEnDFP5O9pKCbktEmq9t7GSpr9YRS9r2J8tm0ViQM7rzBxK+E2
 5w9iKAbA5+VnuO512R8uUG3GYKTykZjYN6GNMcHx7aOJ0CK/5IDLFK2Jp
 Yxjf9vI5JLc+JM0lRqeS8+do66FfuWLeXN6bbKhJZUxDewg5Hl+y8slKD
 2Eq8+E/G/70zu1PpAeBS8HqYbHEXc/Eb7NtpLwlMyLg5KJmLZn61AIQQT
 8xft1C4Y+xIcJ9DeiTaa9+ie8DLSflEZkpw+t6XPFFdG+FSIpTuu4zeK/
 NfZ0vnX0+xoqaQRC0YxK1UCFDjAJpfofT9TWUmPb6+QHeiPqq9rAkjGx7 Q==;
IronPort-SDR: B6qxBdxsvlOsD7ZT27DxFG+R2/hGGPBBNOCbXtYklXHwRJSvCmmGDBK7sTwR2aFpKs9KgN6x4Z
 Y8QmRFwX9Xjb3TkA8RwQzwc4aPcoMwhFuUhOsHfNDjsSzx3ErRdOSNvfhfQsFXsLesXpAFMqbB
 vLfqyYxMbYxduIWw+3+DYChbI/eg0yX8eVFrF5VYtmiScRvF2wB8jqehbG4XnUBU3n2B9cf4TJ
 hB+wZ/XfMPtFNFfkl+i/G8SRFEpu1bj6tz5ZdtySC8RJPOfckBqSpN8v6BloIyj8lPx9pwsGHF
 h2Y=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146514045"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 02:23:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWC75aZc9zcZTzaraMObHjYbWBPZoTtJdVYgpHbmz4OtnRA35wSQBSYinfSvy+lo65iX/JQMbWyaWJTd/FaUgpXfuMwaFKUuxPMKlbr6gcLlYX/812gOoOdTi1YbnMP+oKmBgVpHj2yyMuooYXIBdrep4EJhxbsGKtNmB5hhwm85VwgGMRfSrYU3MfPK+PJu2d/MukVf5a1/jGJaB443XJ0IjoBQEJ9MXSPTQMJbD6HePBQWhMMG4GlY2dnbqDVUqmcg3rGNriEKwyOCu5ZsFEBBKt1Q+pqR+uHXlrODGPhLjS3KCfcJmW1DGLeZf5bF02GAH92mTC6NAZgURliFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJsaVHP8pBz4EilVrPD1drpvfnGqBrV9q5YULdaIiss=;
 b=X4gXQdrM/ypaLyaNzsoDW+Ke17pcIYyCGJ+niJUwpxEKT7IiKXZJREu5v//kB/eKgeL7gDnv0qM/drvghur27hxtIFVu+ZH4UF7VHVMmcV6LaJORtyKLhRySmB9ChT20kG4K1kqnxs4sOiGkkOy8zvIts5XEl9DALZbIy+DJRnr9k58tsyTVSKgfe7TmFw/gGN7eLcUeZPd2MXUsRAiku7xYI65b+j3ahUhZugrMRvtVgRF0EVtx6MPCP6RmB0PxcZTxYhIHrOMOz1lSOayLScIvPTES+UpbQ2dEKt7ETcCSGrfRK6VEjXasB1zLjlzoNKRB/OjE0My5blplNzxH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJsaVHP8pBz4EilVrPD1drpvfnGqBrV9q5YULdaIiss=;
 b=kAAak/aJK6Su9TTf+7D3wj2I1Z5P9saBS/hrwZPcUTsgzABPsHgzg2l8IJED/CkI2kYeX6CznybQLShX0h/USSnm4Jk1TURgqDKBKhJDOFai0IEEi4zMQ3H/xZWUbQcF/29Sch8sbpBVBGy1bzDisM31KyC+0YZ5S3YhPmtjODA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6552.namprd04.prod.outlook.com (2603:10b6:a03:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 18:23:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 18:23:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 11/12] nvmet: use minimized version of blk_rq_append_bio
Thread-Topic: [PATCH V2 11/12] nvmet: use minimized version of
 blk_rq_append_bio
Thread-Index: AQHWf+X8XH69rSKmxker3mfXjwqKug==
Date: Thu, 3 Sep 2020 18:23:27 +0000
Message-ID: <BYAPR04MB4965E69701F7EB8600A45741862C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-12-chaitanya.kulkarni@wdc.com>
 <20200903162308.GF25423@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85b06b6a-125a-4509-dfc5-08d8503673b0
x-ms-traffictypediagnostic: BY5PR04MB6552:
x-microsoft-antispam-prvs: <BY5PR04MB6552FE7FF1C35028014DEC55862C0@BY5PR04MB6552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWndPexmYRKU04Os6A7Ypmxtu1KXdsSpgvVAr5TrQ9bN/5TGREhxaJGAdxZBDB9blC0e6mKTiVyPlbsyGV7u1YMe9ojheCP/9n6WrEWB7B57cEnN87bEliFWEO8s4jVc/4uegUTfiWW8PHbbtMFN9sKx+bf0GyuUT2gr9Vf8r+6qJnPBb/XV8I/PT/GbikQwdRTj5g6RYFOxDAFcznp1j0ziFIlefzVtJBaEwvYWn5eSH5eddDOkZuWFMYeROvlMRUU4DeYGKXl43uQVpzAomnPWJdi+BXPa9oyRb6haH65zDgagUso3b/pagdE0Dbk3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(26005)(54906003)(5660300002)(8936002)(52536014)(6506007)(86362001)(6916009)(2906002)(4326008)(83380400001)(316002)(7696005)(53546011)(186003)(478600001)(55016002)(64756008)(66476007)(66556008)(66446008)(66946007)(4744005)(9686003)(8676002)(33656002)(71200400001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: bEYsQAJdhmUxWo7Hzg+7j9hN4/Xdhe83QECspoAI+Aqrxl6yEAbzW5ns3aharMm2HbYYpe9BbKnJyKzO4t6F9oKKVFGfKoHULi+vXgfZPoPvVxrPqsGeymM8V0A3uUr77ZmB92Gyk4Zw4nAeGwLsy1106A/nGMZn2a5p/T6L0U85Uxfged2qG+aYu+9vFvf+9OsALtMX1N7jO+6SA2mSMAKu+NR3YMZYpknnjt2We7GKF8JqN7JF4lj5KTrqy6ywbkt3n7YxwMEfc4bom+jpHdy8ai4VSe+y96V4/lbv25rYK7IghDLxbJUwwIQkRwJDGRYcgfuUP/tdNMxE3fDfE5sGKt7N/iqwNQzXTafn1QFRQnu2y1j5CTFBjXQiM3nhwso/OlCYu5C6FG6ZH1KD6GYy8Vr9cjIpBJewNn+ldNUFXc1nLdL3n9TP1RtgrEcSLdigE0oevjmuSqyf8yhp6w085QQHaq32rVboBwj3tNmrhrsGVegS2+hQ4MxFEnycU7qZlum1Wk9aYZ8rNWi9ppDZDRlRwFgbkuHBRjj2sStLcwTWQknlkrjMq+3oBZZMTdIM8xwYk/9cSzn15MjFcmy8SuAReZvmnQKCpfBxSXhRI+AfGm0b7Thmt/0GM1sJXMV5QS5LHCKmwzTI1vbHaQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b06b6a-125a-4509-dfc5-08d8503673b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 18:23:27.0693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gi4hrSGOdwfwIiNhlD3SZfKui9RzXhvGdgGBG/t0B+M8gfZNNTUJxTCCgol6PxPNrzLyJcgb+BrlhB1+A6guRZBagjR29dAb2snuR0oecxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6552
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_142339_166963_44157F5A 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/20 09:23, Christoph Hellwig wrote:
>> The NVMe PCIe driver does not use the queue bounce mechanism. In order
>> to find this out for each request processing in the passthru
>> blk_rq_append_bio() does extra work in the fast path for each request.
> We need to be able to deal with all transport drivers.  None of them
> uses bounce buffering, but the changelog needs to be correct.
> 

Okay I'll add those transports in the next changelog.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
