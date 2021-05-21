Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8459CC04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 21:23:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EED613EC
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 21:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EED613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=v2WrRqA28My5UWCfNp4+2OhTIcDqGOua70yRCVRiBqY=; b=m3OR/4xJtsG3+8TOyozExApdPS
	drBU7mBstoxFAd96pnGmtoZs9FdMIylZCEEsm9fElkAtCrAK1hzdwA9AnlwJcA4VtK1Mt5hzBsaVn
	DEoMnn3o7qzRJHAAu3h+6Ht/hjHBaJUZ511Z4TDoMfUy6L7LVX3cbdZM+p8CplxeG4ZasTWpvuTFT
	gaAapEnUjLmCBlap+vvEG4QAFqs3UNvqaxcHLL7UlkZeptP515uAOO4/b7h5bPMI/iz28kU0CH0Yp
	T8fwSBCAL/+4L+S8fC9V0hZLLiaB1YxjUHLE6zFZbgUsHHqUSHwUCHl+bhJ9Z7OEKtWAR2rn3CGPf
	QtQvUIQw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkCc6-0018pT-L4; Fri, 21 May 2021 21:23:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkCc0-0018oj-Ix
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 21:23:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=61zostn3Dt2EPX14usp5YBQvzYrCG+clEjjWG9CcXNw=; b=gChUD8xVslrxmo7DeyGJJd1CcP
 6/GSztsJYnK0LiC3fGzfh5L/v2bdTRKAVQA7mostVKvTKjG1VX3FimlEbupwN9Vj9tw+vuEqbQj4d
 h2AxZCa0rPQSuUCI478ijEZiuWb8r0DJgwKGl+QiB3Sasg+Mgcp32uFV0dTBiCPW++bpXcN/LCbgX
 c0fM++ydra+FzBtogNzb6LMUkCm8FqvWHnofKOj0KrYZNM7n9I9XP8Abh/3UmYS/+suUo248hfFxf
 uUq9PtQII9/qDYrErny6g1nUJJ1nVYfgn9MTfhR/FP/C0Vlfh+TxeoHZYduQjTmGqPYtbo8RJ5YEv
 76Zz3zMg==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkCbx-00HR0F-Bf
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 21:23:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621632192; x=1653168192;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=61zostn3Dt2EPX14usp5YBQvzYrCG+clEjjWG9CcXNw=;
 b=KlOulra+fUhXbnxJHPYzvqoET45EpzoHDk5C/bQFYn1Gc11OuFrgeQGc
 YqztLT0TEQpUiuSc5N10EI3BYqTz3x+E0W3THun4k8io7hWQefljao0uy
 QM9HwU/eBgAB+u8pMvSYSnrzi1YxdJH+K/QuzFgtoSpX+h+Cl4DVA8Ida
 Aq3e3/iazcaaAQqUjNLqQWdiO3IDNRmnPPFn/Oe/RrRT4YKQ0QJpq9YZa
 enzqfwXb5DwXUCFj+UMAHvYjGhQKQkESrTatYiNvMvAQVZTVQfZP66YA7
 xbuPLVznQaoC04srtw8OWxTpdTwC9d150EOz8lYYu7FJIZ/CEsKJT3WmJ w==;
IronPort-SDR: 7m5puHbKjFG3i2sZ0cmfo8iCZjNM5fPzqQ9pQVxSX6MipR5wUQWtFCjzr3X0g/824BHIgLCE8g
 EVsxx7Fj5yvN8nR+A0ijj4QXnPKl1i7zPdGBTyK9G3nLWBVw73fbKzwC+2HQcXZZKvscEGSJg9
 dOiEi1rDssoe3xtp9NXPIGyGpLiavauCAbpUtezU1g4YrRN6dQ//yNsv7jUqX/zlb++trA5e5q
 dmhjfew04DUkP9mBONXxzX9oE541nOs8ehIvLc+1I1JZdkpaSEPgL75fdEPi+oXXjJW+n5LmZg
 kbU=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; d="scan'208";a="169046803"
Received: from mail-dm3nam07lp2041.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
 by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 05:23:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuLkBv25+q86+UUBuu25v4ZcDbMiJY6JvpS+RdeBZI0w/Cl6kq+HvznslUAaYpKIdNcqmuUpTOj0Sd4i4p4qJa8iAobs0GG7A298tMylPxW8G1mc3BN5mDC8HqZWGt02+EO0zXkS482oSDRDlLh4ZOYICEJhQqH9CtrJJkQgzCSoLMtcNuhkEjlNAtQjXN8S//K6ElmEo1SkTyvBST0CPtrkHyhJD8HbOCy+py6swyj2n4ohZQ+Y89pKuQ4b0tfntofCIycmX3oj0htTUgErbuq/+LoPpMMVI7o8pXKV0uPP4FsEtzHfGlDHtZ/4s23pwjLJpXdjdI4XP0CUMxOwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61zostn3Dt2EPX14usp5YBQvzYrCG+clEjjWG9CcXNw=;
 b=Q8uD8IZW23QG6oJ6NQIGz5UJ5su2sxxPryXTZFRRYPDSm7ti0HaPB8nzSTzMxhp+e2xBVgvIG3TraFCs00Le+0bIVZ1gQ22HNWmFUI2JOmmAEx45aIFyLY7kETn9eNBgZAnRCA6/dobzN9aDWK3oCq2cMrocKghNuBeviyvZKB1Q9c064PQpjl3h/QdpUod+4fKC7o+T4Tk5wQElw+xY2BCp4386QDHmDgjrp6MKTIoLnGwtPaAMY9SjWlLVP+52e5bgH+XOXWUiXTihjGUZeTq9PYYFtsXFhiFGxuyxUOjRp+FBrH7phK+WQ10qTgxgU2LEnqoWXTHIXMOvCP7IeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61zostn3Dt2EPX14usp5YBQvzYrCG+clEjjWG9CcXNw=;
 b=UdwLd5y8xY1oGDFMiLdGqpbzdQUDOOm1w4AERWsiJf+n1I0XEpSBW/WliCjX79gMce6iMJ21ZuMQ0Mw0UzdLNJU1IuxUgOaivxGYGvS0eUin1bGI1abyvhMFsYLOQtx8ckpn8IFIHI+fYdyrMtwc4XagcbSLdB6TRznjWl5HHjE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5685.namprd04.prod.outlook.com (2603:10b6:a03:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 21:23:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 21:23:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Guoqing Jiang <jgq516@gmail.com>, "kbusch@kernel.org" <kbusch@kernel.org>, 
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me"
 <sagi@grimberg.me>, "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: fix potential memory leaks in nvme_cdev_add
Thread-Topic: [PATCH] nvme: fix potential memory leaks in nvme_cdev_add
Thread-Index: AQHXThU4ZhWqLQIBYUu+g1+46AZ7rQ==
Date: Fri, 21 May 2021 21:23:08 +0000
Message-ID: <BYAPR04MB4965FDA148A2292233E12AF686299@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210521073239.722341-1-jiangguoqing@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 829a841c-d2a7-4dde-38f5-08d91c9ea10f
x-ms-traffictypediagnostic: BYAPR04MB5685:
x-microsoft-antispam-prvs: <BYAPR04MB56852F60BD4070EB872A6B4986299@BYAPR04MB5685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7I5TMxqdmoNrruTRrBUZ/Qh0mSU5/LM2n6/FOcFmPohFf4s9cCI1Z5j9xM69+oIF40/oaOQT6N3ZnbCkp5iBot4wbV9js8i/BuaIdTiHBwtLv1wjL08eXt6dc0IQgA9WL0rm5izpyAiee0HzP3/3DugYisP/BPpuTpy+0pt+pAj4++kCXp7KsJ/1x4yhMf2hsS2a8qdVilKSXe3rAX43jW5jisojG3YEknZSDDaL/eZ6xAjl/M9/D6DF8JtRYxc5oIP5zg4//FTJNmjW7aKfQeqlKJlCP1J3+TWitun5LzQkXReC1EllufMk2erEEW2vTQ0ezIlPtRHrsSPJEZxorxZdCM06+I2Ji3+5+WHgf2CPG64aKwUiKC/86jlUCslxW9QBmzGH0HFSj8xXpCH3m/yiQK1VaNV8Q0U8LhsP8E0O4B/rpIy/VbzlIlT4g55UpVcNsNXqODyk5/ZTLz1q2VgrEWsw8r21noENgSBfvKGJDJ8IXxnJ38LN83JWR6CmkgLbYUwj67wcIzfLmX5rcxxr27nkrsfb0lj9ikbedHxC3Tmyl6xNh2L0OF3Olyi7t+5VYN8FtYOEtKNQQfaDMIUauDOgQes2Ve/FlhfjMvY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(55016002)(38100700002)(9686003)(53546011)(33656002)(6506007)(83380400001)(122000001)(110136005)(316002)(4326008)(76116006)(66446008)(66556008)(64756008)(66476007)(66946007)(2906002)(8676002)(8936002)(52536014)(5660300002)(7696005)(86362001)(478600001)(71200400001)(26005)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TEfq52Jv3jJp2fHh2wVFyjRSfnEJmt8H+/7KuGZBl0EMd1HXi7j/vnx0s5d+?=
 =?us-ascii?Q?jSA+frCFGWV+pdayN0fYsGM0cSSL1VjgHnRvNTK6g7QdRQhlID3/JQOlpy5u?=
 =?us-ascii?Q?BtSjJLPXg/3WSc5Ocd2GrtJeSnjS/6b4BKh15vmNvSsToInip6TXc7DqDPAj?=
 =?us-ascii?Q?jtk5g5Du2bEui34kpf8lKa0zz2cmN/1FTdJfgKRm7IynmC59u1m/xTk6anxd?=
 =?us-ascii?Q?SOHeaS00vMSnC1bNbYa9xF1y8uBU+M2q0J913VLYE+4Z7It+yW8KjER/Ep4j?=
 =?us-ascii?Q?Zgjti87fxfaJvtdJT/qvsxSUVGu+6O6gsiS2WRNY1OjeozqMRU6B2mGb7cIm?=
 =?us-ascii?Q?opzheFLtXLY12rod64w9H/L4Y3AYbrzg+YQR7/qpjDpUHR7ovrGoFo2uiYej?=
 =?us-ascii?Q?GQEuMNthSifJ48trsGl4MjGsnxG00sCo4ozYQHI3QexiCsNekf5FWMZzz/lz?=
 =?us-ascii?Q?rOcwsbJ6o2dnTSiQQbDjd0aJ0X/n8SO3gNQyaEnobeh4csIMSkdqDz2kHM1x?=
 =?us-ascii?Q?m8Sacj0YQg32TQGkVyiwmSzvlx1Sk0fSZoJZo8UMN4hx4e+csk/0hG8qyAst?=
 =?us-ascii?Q?hpP+0d4WZayOKXPzg6PsMzb7m0Lo7tPpv/CLrey6CIYrVjWdcPk33HTI6/Gw?=
 =?us-ascii?Q?nZXYHjqe0QOPPA9I6HkfWAJVatBQrzyJwH13OjC7vJ+EhLuD67xm/j4tam+Y?=
 =?us-ascii?Q?KeAk+a/QD9PjPzRmQDdcdkwfIsFyn0mgzH/7omJQv6rjIhTqcpOcgPH0vAyn?=
 =?us-ascii?Q?Kx2wf10nd9ssrHy3J0peJpcaregk5/SzfDPjEkdQ2qvlV29INCQ0qobSbIr7?=
 =?us-ascii?Q?ZrviRbGlD0D2s9agCfN52wZeyv10GPU/XjKeXwv8H0zdsI4wMT0ZhOQt0n7B?=
 =?us-ascii?Q?MekFub764Xj0ZWcGu+7/MzJHEtXXQks5OGiF0fiD5pt/jNFTIQGGdWZtHhUs?=
 =?us-ascii?Q?sHAn6f0aaGj7y6Cr8H/GBmD1TxamgX8dDMUxve2Ok5To9fXXDD1Xrplj0IRd?=
 =?us-ascii?Q?1azVo7GEdiRFJKAxI5twLs2uU43dqvPGrfflWlSmYYg8enXAAB+oCl+GaIGH?=
 =?us-ascii?Q?o5U4Rw29JLuSVE1bjG3+hK1SvTc15QnbG5itFNFYWzyFqwtlFPT/7i4GmQuY?=
 =?us-ascii?Q?KsXJL+W1oIE8EXDV7vLzrE1TRvUBGrQGHIWq6Lnz/s/mm1I8pKPZ1XocHrLX?=
 =?us-ascii?Q?zKeN8Bqpw6y5jaQPhimKg6O2Iws7GJfRqrmdSY11P7OTPvZJWVWWO2iMylHe?=
 =?us-ascii?Q?PpsSSjaWHDiOJtHrwMgni0kpjGAlTvTM2LqlnnMTDcmA+fB2T8zlkRBQP9Su?=
 =?us-ascii?Q?N8mFBXjNSW+6urCewh634C0o?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829a841c-d2a7-4dde-38f5-08d91c9ea10f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 21:23:08.1216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwXr4g/wqOzfjKtpay3IuoQkbry/tRRS0XUHx6euCgUvEzneJ75jyglWoLeoVMZg5TurWI2FBKUN0xZbQIwmkpw43BCILskq2pfvfuqlx+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5685
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_142313_510441_D277994B 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

On 5/21/21 00:45, Guoqing Jiang wrote:
> We need to call put_device if cdev_device_add failed, otherwise
> kmemleak has below report.
>
> [<0000000024c71758>] kmem_cache_alloc_trace+0x233/0x480
> [<00000000ad2813ed>] device_add+0x7ff/0xe10
> [<0000000035bc54c4>] cdev_device_add+0x72/0xa0
> [<000000006c9aa1e8>] nvme_cdev_add+0xa9/0xf0 [nvme_core]
> [<000000003c4d492d>] nvme_mpath_set_live+0x251/0x290 [nvme_core]
> [<00000000889a58da>] nvme_mpath_add_disk+0x268/0x320 [nvme_core]
> [<00000000192e7161>] nvme_alloc_ns+0x669/0xac0 [nvme_core]
> [<000000007a1a6041>] nvme_validate_or_alloc_ns+0x156/0x280 [nvme_core]
> [<000000003a763c35>] nvme_scan_work+0x221/0x3c0 [nvme_core]
> [<000000009ff10706>] process_one_work+0x5cf/0xb10
> [<000000000644ee25>] worker_thread+0x7a/0x680
> [<00000000285ebd2f>] kthread+0x1c6/0x210
> [<00000000e297c6ea>] ret_from_fork+0x22/0x30
>
> Fixes: 2637baed7801 ("nvme: introduce generic per-namespace chardev")
> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
