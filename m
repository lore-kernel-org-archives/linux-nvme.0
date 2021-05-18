Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0F5C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 04:28:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C073660E08
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 04:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C073660E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=oSYdKS4nF77eOZAtnZv0IDWDKxf0NGI5TTWTVxlCI0c=; b=Fzrdm9bnpDgR+i/4Q4FaZTBXq
	68r+LKuEAa5SI0b5U/KtkKzgyunA5SWJcu3gievCeaav5STVxbTXwwWOVpNy1vpW4NVxF1QTUj6nz
	vVvvUO7ogCEog7zPZ9imGC//TYsDrO9CK9QGBLUzvc15wZScL44pMfKqLgr6gKFyTvHGv+j+jyByR
	6eq0jUZWm/xplUJ2oKq7yn80keIXM5JP68Y2dO1xkD97XnTMAKRm0kHONyqLg+kU+OmQoYMyZCS5V
	8rZIpNo3AtSLXe1UJo1TZ5HiBgmpr11/YvDWmPspeNisPodeJmfUxd0zMAhHFsKLSpBSalfMyCbua
	nM0uDTg4Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lirKg-00GvKQ-4q; Tue, 18 May 2021 04:27:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirKc-00GvJw-17
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 04:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=riOyWCGCfagiaL4/BqVrgpz2q9ai3y4RxtrWAsDd7N0=; b=GGk5fT94Dc+QWf+MZ1vI+n80aE
 pb3FrwmdOLLgb1TtCk8J/IPj3C+ceEzd+vEJIDHHL63sA5D07Ttu1e1S+xiww+vaLa7eB0ZemUef9
 H6RpPhvTsyym16Nz42iwPEP0ySeILJNHvnNf6oTQcGysPb4y4jBmBxE/GpI8SLxnIuWL5wCpP5sDj
 aq/86RijeCF6NN7Q7LFaNOXj4eWrfYJIiVnXXKdubbjXbOaREmCfuGz4IHniR5iQYHhvzL7gtjQB1
 yV8TELzZvbZEgbJKhPuKpwIMNE683ifYEJGSki0fxV3l4s5Nj9kn/B5UzlN4wz3s/THcKY4gfpjo9
 WIhR2saw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirKX-00EIji-IY
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 04:27:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621312061; x=1652848061;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=riOyWCGCfagiaL4/BqVrgpz2q9ai3y4RxtrWAsDd7N0=;
 b=p5peemcO0rqgCS81OkwTOBaoTBHzHfR11OlLfEB/PSSs1Nw/n/YUp8Gs
 THpd/NlbNZd5N+RTKuUyz+HrffWkhK8IUal4/mzqPy0hI/DxwRkEnwZdQ
 cqWFufHncJdnUE4lVrZe9aT6xf3qOSWqGOCAbUHh96KygGmU14qUoszb3
 TBQ/L/1Wv9ULee+ggdf+kC8oz+N48QOLadrLXkxJmUpqt4PfO04b3f3KW
 oy1pl/bIw99pBZAe7yZigzgx5jg+gDUnaMVwt615fOEzoPWZtgxtcR7CU
 N2YDR7gD5woMSe83+4wBegG+vXGooRDXfMpdnhL18LFHB8mQbMI93h2kb Q==;
IronPort-SDR: yDmB2cse2XETlLYvxVMxeE2kZJuL/HhTvHLKa9NhXa3hA8pRZaJL8z09Fju6+CW2nJlUIxcXQ3
 ga/hk1Vl9s8wd5ZGw5zXlYXShWfnwBfqJ+vMjOa0xqERxc4Dl2f4vYiV2WieJX7/9xQKCW6NN1
 uWYweOvGqkzI8xfHfzwttdrgBh5DSipwPFQS33A8UbaF9cPirbOmzrJK6Ktaq+5dwqbN+AK6Ba
 95cuJF8/cbE59MysL2quIZHbeoB4QK5XhXYxY23F9G6D1ILkQfHSHd/2cZRj8rpZjJo4TOfA50
 AGo=
X-IronPort-AV: E=Sophos;i="5.82,309,1613404800"; d="scan'208";a="279742612"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
 by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 12:27:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maanQMGJRAL4GFamqlxUDK8nc6gh+v+B3T+toNiorRw1juOAtlqltEddllJHYB76U6B3Ri87RBv2lnxzSZ1XL2Uzj+ZyJbcr8b7Ixz3EZRykwz6YYMwvrSt+z9jb/w0jc9zHjXna9v+sSpFHmqZ64l7Pnhpu2LIU3yo+i4ULF3NEXNGuJSafzswfz8Q9QOo4XmzpAtm0xhCXKYZXo8KHfMXnSBH9cUbQ5QeuVVro6fcrsik5nZKYWhbZ22x80jf6rXSnFHg70dNmkiaHDgoqBaHILE+YG/nGlcAZPgN6XMs5R8KCpKfoBKYcC9jyIHtYbR+EkjZCdKpefdLMeyav+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riOyWCGCfagiaL4/BqVrgpz2q9ai3y4RxtrWAsDd7N0=;
 b=IIxKpnUeyAjSmrvYBe+esenxjZCituxUusIx2HPt+fgcCCQ+GcNLvV9c75Q6pojG+z5fzLCUmoIkXq0xWrGkjOg0dSZCzWO6nqYBnU5a+7e9mFkyYY1Zz2BkLjDUPckEj9tzt2icH5Btf4lC9bmBbCq0zC8HPDP4WykDFQH/gb2ErBpjCJoj6IuPr+kjzXaguin5DPTTKKAoGUgfDe7fWvmDY7UDznzAhWnpY54tjxK+axxmRgWVYK3d4Of/RM7YIljLSJaC3kJ1B8IV52x8Agucc36qHMNn01nvxTRutCmYUmlsPyKdkQQ8Lvj1a0T39T6y5bGB7zyg+8ibRrIwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riOyWCGCfagiaL4/BqVrgpz2q9ai3y4RxtrWAsDd7N0=;
 b=DHr2k6huKvGx27dGkFJFKv88TYi9JxGp7InwbM/rcLipb1CW3oiMZ2ET38eevhoCoagDWr64xqUQvNsTdZmKhvpCWXDscohSOZlDRkIhleGCdzfAg6cThs0gvZTXs9cpM6lT1PWZIGe7D2w8E1ZpQsZCKnqzKhyjuwm9M7GPcTs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6103.namprd04.prod.outlook.com (2603:10b6:a03:e6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 04:27:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 04:27:32 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sasha Levin <sashal@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Daniel Wagner
 <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.com>, Christoph Hellwig
 <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH AUTOSEL 5.4 2/2] nvmet: seset ns->file when open fails
Thread-Topic: [PATCH AUTOSEL 5.4 2/2] nvmet: seset ns->file when open fails
Thread-Index: AQHXS4QLY+4qNiq68Ua1UWDgR0mY1w==
Date: Tue, 18 May 2021 04:27:32 +0000
Message-ID: <BYAPR04MB4965B34C6F9C5E833782C7C1862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210518011002.1485938-1-sashal@kernel.org>
 <20210518011002.1485938-2-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9026b4c-fccf-4be0-32e7-08d919b5413d
x-ms-traffictypediagnostic: BYAPR04MB6103:
x-microsoft-antispam-prvs: <BYAPR04MB61036049CAFD517872409647862C9@BYAPR04MB6103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7WLFUMHevqVC9AtoGXUxJOvJLXWifZOg/juS14Gv7HS4mRMjgJyZQbGVclvEfzViW/FqcjjjL2gLB0pV4sC7o3oU3wnwLDABtAhHJyAFJD1nVPo302kE96AfzmeAJdUxCCv/iWaf7tpYq/H5lisHiGwmnC+5qvITH8UDn1k/x9t1lYpInTARvMfJlk8zkGEzp25dmrgpVcsDchfMusk5v73MX/D4kBWx4ceFMXxRTTw6bvGaFq4rSesMzBmWWSr00hkdRoTuAI2YP45mY+GWG5pxXyW1Vtnj5bAyOpxLH+mRFF4vAx+2nkdheEXU3GIpZ9scSJVCoGyksIHbmzszvogUN0m6nf+IxaaVvDiZfuRIbjdBr+8FcuVhB8tJhzDdh2MKDUp54w3w5Mq27Fw1i9oeouJ7d/BGLARiRWSHcPrYVmyGNQOYDQ5EfGieSKLpYEap4s2aCnVUQ4W5BuQVp7EfPYzfHb/cjQqEQed7ynHih1HiaG+0N8e9k9uc43gh1IBig5X5+ezZ1GsWoX7KP0VYUT6zaQ8hthP7G8V2QiA7FoKVP8B3kIAbzydBwpl1zqedt2JS0C7aH9z9uPosv7jxaYOVt5vblIRs1EDugJA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(54906003)(7696005)(64756008)(66556008)(66476007)(8936002)(66446008)(33656002)(6916009)(2906002)(478600001)(8676002)(186003)(5660300002)(53546011)(316002)(4326008)(26005)(6506007)(122000001)(38100700002)(55016002)(52536014)(9686003)(4744005)(66946007)(86362001)(71200400001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G20Zp4T+9ytJRpu+bKBhf4X5dju+4OeyJPHoSyomgiVBLj7GlNQmsFoGwS84?=
 =?us-ascii?Q?oSXbAzaVoyYon/O8+zGxs153Ecq19gIj2dtpCgAF/dJZ1QDut/yFeC+805CO?=
 =?us-ascii?Q?oS/FmuCJoSjXQXJ46E2hEJXFRfLEfpK3o1/mG7XVU3NhqtrO83XoT4rYpJ6Z?=
 =?us-ascii?Q?snmuG3Blqe2HEUKub+MDUwbbQMXaCuSdSZ0vysPlDm7YbRC4QPl3ANJ0CXzm?=
 =?us-ascii?Q?0F/xCjQ60oWU3HIFQnmi6X3OEiPgFBlyYpetTUQFkYCk+z51+hZimxIHgAR9?=
 =?us-ascii?Q?i6E/HWhr5WPm7BvwVXqFN7DcEh+73HAc7iK7WiI2kwLy1PodQiVotqdOES5+?=
 =?us-ascii?Q?ZEzQbS5cUuRsvCNIJaHo6lt4ywys8QRwK/OMZX2jGCQT16QIgP5GSWUALLDY?=
 =?us-ascii?Q?DHKvfIdrbZ/wTYpPPQtxQvupsuWwpE1EaPp/4FiUEbMBCUuVvgFKbKKWcjvP?=
 =?us-ascii?Q?oeOLvvcKbRCDUZCBlyMVgLUEUcfeIoN+Qoitsw62MXOfimXZ9fiH3vi7CRzw?=
 =?us-ascii?Q?5mkw2PdXfjm29ZsrJARG5IodVooqFl5uFkMeH7ikEd0SPX112ygspDOEfqBA?=
 =?us-ascii?Q?Ou5X/xyugB/Kie2Zd2W10BizSMdmTiAKfe6nUY2DI9Vp6oZKqG8uf8ywDH8f?=
 =?us-ascii?Q?aRgE+iNLT3CW5vKIuotvrJvvzSASdu0b5lO+t1Ukg9UscBCLqLVp0G9qTuW1?=
 =?us-ascii?Q?0jMBX2mgkbrW4wTgQdcL/ew8R0EkU5MIKNXugK3vO19u+UXZDX4GRqRls4HK?=
 =?us-ascii?Q?BfXXvyBXiQpBnHh3/wyYsE6g781e9fxQZduy2rmvyS6LAKHo2xU9u1I814cq?=
 =?us-ascii?Q?CrbxZjD0grXEE3zS0/iqkK8SJ8OxtPQEXsZJt2r/Dz654H2YUhplJ0py9KCH?=
 =?us-ascii?Q?MQDGtrsemPXgT4NMj/PJLIjoqkjvU4hAA9LXR8UWKlLES321+M0f7hzCUWxN?=
 =?us-ascii?Q?M+S5kFWUy8hrz/sfTNPfyQWYp4tbmBZ8iuuhHfQsVNvhomqMY7k9rqf9nqjz?=
 =?us-ascii?Q?alXJ0/dM2nWSSJnHA8IX4RCcB5O08X3NMN/fZITKKgReH/e5s/4XvMhzGS2B?=
 =?us-ascii?Q?unvPHAjF44W6viP8JFodAOJLi1DVZR8ERc/mQNtJKuLuSRyfadqpkQWqVWm5?=
 =?us-ascii?Q?hpRywF0sKg3Q+kXgHrvgnVMWeAcedD9EK54YLxbcQlVBDJ56hcV//YYJk1lj?=
 =?us-ascii?Q?/R75EcRsVJP1qwILpqeR/owlcxKrwbcEwLmcRwBTTQ+Vvf+buNJ8HLpomDsB?=
 =?us-ascii?Q?mMvyPGcq8cwsvYJL0qANh9zCq+nfxAH9AW9LmXCRM81nBMy3oLfjQSuirHDM?=
 =?us-ascii?Q?DmaFHuVO7aoAq5p0rwkCQ8X6?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9026b4c-fccf-4be0-32e7-08d919b5413d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 04:27:32.2351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7dguruzbIGjas2T/ytm0kVMqU9QKxWcdmBd+kWPEVFeaVCiMJ34tXY3EzJ6exdxewDXlM5nfzNGnHgxmkARPnLWcnSPMkp2BwfQGavfegQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_212741_649991_4F452E47 
X-CRM114-Status: GOOD (  14.90  )
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

Sasha,

On 5/17/21 18:20, Sasha Levin wrote:
> From: Daniel Wagner <dwagner@suse.de>
>
> [ Upstream commit 85428beac80dbcace5b146b218697c73e367dcf5 ]
>
> Reset the ns->file value to NULL also in the error case in
> nvmet_file_ns_enable().
>
> The ns->file variable points either to file object or contains the
> error code after the filp_open() call. This can lead to following
> problem:
>
> When the user first setups an invalid file backend and tries to enable
> the ns, it will fail. Then the user switches over to a bdev backend
> and enables successfully the ns. The first received I/O will crash the
> system because the IO backend is chosen based on the ns->file value:

I think the patch subject line is being worked on since it needs to be
reset and not seset.

Not sure how we can go about fixing that.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
