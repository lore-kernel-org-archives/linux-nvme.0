Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472CBC4727C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 23:29:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C353B23A1B
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 23:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jA/8gzGH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oMwNZi8L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iiDjAT5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C353B23A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=MPNJpDKUYKt0MY5MnWGqvJUPE8mMtesaVkjJOpLmJvg=; b=jA/8gzGHJilNGaB752B8bAycE
	4DGPbBY/ZcVz4JwiLvEqMxmJAe5b60pce3YTBPqzgE+/YDqlxPBgNnjRa0zBgs+ZIzKDUaFEyNzgB
	+JothB/W9rLvzDPPRxrN+Iy583c8BqdPrZHgE8/Wu311Q3Dx0ZqQX4g54EtzEiY7A4iV2g6HpOwm7
	u5IyU8mkLnyILIW1LIJAoLygvuYBZW++Ap1eawrp27CW/k32Yr8w4d4c0cEO09bV1N7ieoKcZ1d1o
	UMpK8Uav/v5UQpRD3BjjtBnxXAlN3oFuZRM0RH+KJqH3L5u+822hIGa0T7JJLbR8F6GEodY1LBndb
	k9L6yzySQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKVFe-0006Zy-HC; Mon, 21 Sep 2020 23:29:42 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKVFb-0006Yc-0U
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 23:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600730979; x=1632266979;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jULtCyK5yOSjuWIoTiZSH31CnHkPC9/zZPQoLmAz3SU=;
 b=oMwNZi8L+z1ASQokzC6ABNQvwh2CZzak+biiV6yzKONSUyhOjfD+7CFZ
 xktjKCQvP+EFZNvDtVWg7n6HP8zNWO++vV2WMouzQaipGg0V9HWr0XJly
 ah/iXi9aRrT5LzPk/TZVKMGHtAO6kD4bSX5QlOBLxVvpOuRwRUDI6j53g
 yvwk51ZDXpvkBfo+Ww7NEl9QmAv6EmvoubUSAbMNCKyGWAcJSo8IwtdWr
 O/AnoDky49vk9JvJsoSOQchFszt6SpQPjIBjVOsITpnNFfqYSMdJF92ik
 DDfyLb29MCdpCbrU+O+LKTomnkTZF5OWgYtdC8kKN+zS4W0gta+XyBLsg A==;
IronPort-SDR: p7v9SHT08CSQwswz7ycraWXAO+PnkvpCcB7ur5m4og9aWAGxW7LCVyfbC9Us5q141D5BchmIHg
 mWszIYn6A2zDxlcAkS0YexskvXpSLM9rL0e/Bu6/yduQKhtbKKJGgnB/P8gSlggYgFt/6lhnJn
 XMSkCPNHJPSQQGxZLYh6bLKT31/T/8ze7o/yX3WF69H62iqspEC91wLP00KjULYMDaD3ORJJUW
 /KKY/uYgomccFY+i0mY1iT4diA1j3K/5MQBJak4hGsaSpEZ4n66i9TKZD2ggZFqnQdwbBYvDdj
 dSU=
X-IronPort-AV: E=Sophos;i="5.77,288,1596470400"; d="scan'208";a="149163945"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
 by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2020 07:29:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axIOee/+NCYX1oH+JI0aU8qNZc6B44ns6hVrJOKcUOEdIrB1kkAM1WljxPiRmnTQ+vlF/jpQAA72B6wt/MieQlag3O1wBcNpei/u5j33X82f2j+omPOAnej/lZBqRmLxNER1szZ9GWmMdN77qU9SkZdZ4v6FDmblGZlFbipW/JH/HOpWJDO+umO3mEKhCiqJbBc+SLDIGPhyN5dJloB9t40yioEhA/8AB7168i+uSMdSwzmP0YtMZnQaQiTAOTW1te+9Mz0md1kyU4HfIlsNF68oJMqgZv07gtWvEZ0/ZRF/C3O2Qk0Vm9VNPM2bSv38CzTF0+XjNwNsllUuwJPCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jULtCyK5yOSjuWIoTiZSH31CnHkPC9/zZPQoLmAz3SU=;
 b=dw0LwuAzcvvny5VkNQr7VeFoucu7TnCrxY7O1zzWciEnVRQMErbLhWPoRt3QMcn+T47+HJpjfjwyMFHEx7iZvxThEpsPh6oGBtiv3svGQSE5LoXvguSptWgB6AwFhLUQh6AddgbEB4PBdEnG31KsjnzVyUkmmHbCfjnVT/YNoSC5y+G0vjhKFw0d2CCrU/TbpMURuCAqJMS7BQyHYhBzc1baNwrRWKH/xgFGPaH6NEPitzByWnFxiCn+Q8HmvlHM9gEPRsQM+g+W5e5eBEk3b5waON0YHYaaJ5AbJhxwBOkoDxhNtYLGLbb8U54dtWKTRsQ1BK8Fqk30iqiI65fUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jULtCyK5yOSjuWIoTiZSH31CnHkPC9/zZPQoLmAz3SU=;
 b=iiDjAT5P7MUdiutgRhUnnYLUOajteaGedZIdPfQLXPXvlpPhtwHz/N9Dtd8AsQ71VHf/mr1dnF4E6RCXQWjjofRZ3LTEONHdku9uGaIIytSOdP3MpXt3ndCBT/i7aFOGnlYF4DXbjOSugmInrq3VdprDzEwK2iF/X8ywlmaCz2k=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4327.namprd04.prod.outlook.com (2603:10b6:a02:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 23:29:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3391.022; Mon, 21 Sep 2020
 23:29:30 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests 00/11] NVMe Target Passthru Block Tests
Thread-Topic: [PATCH blktests 00/11] NVMe Target Passthru Block Tests
Thread-Index: AQHWfKssI7kSe/U/OUi/Jhb3l47wSg==
Date: Mon, 21 Sep 2020 23:29:30 +0000
Message-ID: <BYAPR04MB4965509EEAD6B8C5321BFE6C863A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200827194912.6135-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dac5e8f-32c5-47ba-9c69-08d85e8630b1
x-ms-traffictypediagnostic: BYAPR04MB4327:
x-microsoft-antispam-prvs: <BYAPR04MB43275FA60AFB3A8E73AD08BC863A0@BYAPR04MB4327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFkT07x6H1HRfn0qV8guG2fVx/qk8kkRnzFghan1T7sZ3W2N6KM0KUBPbDfcaPHYSDt41UuFdftLToOg8riYUpSGUImoDO9C/SvnUaifWiDmi7CE4ZRL0BBl7Di8ZvtC6REVZOCt1wvKKz2hKHNCaS0AAeixkK4KHPFAZ0+KokMrGGxV40b8u0fZjkPL6XlKOEw87tjDAAdCzzPY/prg07x3N+RHU2NIuKRI/Hm2G1KhvABxIMM0o26JRC9A5BLEKsj+IehVG33XRuMaJsRMhU0i6jzMbNTvurjIiBnINOsBtp+4tgQRhjqHkockJQr9V7zf8woY76k+kh9I9nPir2EvafsEJZTe1w+yf3aCDVyZCdH67lJrGyEfKS73udykEhVB1UASySNMTAvT3/ARIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(316002)(86362001)(966005)(66446008)(55016002)(2906002)(478600001)(66946007)(71200400001)(110136005)(64756008)(76116006)(66476007)(66556008)(9686003)(52536014)(5660300002)(54906003)(7696005)(53546011)(33656002)(8676002)(8936002)(4326008)(4744005)(26005)(186003)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 57ZFoRra3ysBJ1asLrRVP/Z/NTRcVhZW0iu8b6A5VryLh2kbIAm7b339LAK3SXl1jM8i+p6SoxZemdgpVj4AWshNvyIjHDj8iD31yAOKzHpVacbRmPeiUu6tYfUg6CQda5olsMQ+b0HurputeP2QcbXxSTAgmhhY94hxciC+aE9JT+IdYQp9KpQsZslzofy8b76lP6occHupWBGWR9WmjW39DO09IWE3rfq0CfuTygzyLscC/x03j0BrFlBmj55WDYq38vx5xtkviUXxipBJlDVjVxGdnjtNSE1e/i6cXcErUHLWsitbjG8rGy5/QvqoYsEbv5p2NiK5KqovyK9HnRW0/d2pObdAIi3NLMiaIJ45tJPgQbnn/0P0I7YrPWF9e4ImCAdXxRFzZpuxXLseOusZk3C2/JQ6FCRGj02Zkn6qNSx8qtGsVZhq+lkXU8zna5OCNoleFXVY4dCjt8K5xqJZRpVVZkuAzy7wxs61KfgjobrolC0qfiPUxwcSZaMwOffgYbHoIiQmrHuwIxx17PF6Fdx32OC7NY9KjF1PxPzyV4DKmpMThyPxPnz2fMq1AcNkgwr1/IjT2KU+CrqKBkhO8diY5HxO+3OXIzxqLb7YR7QuF+eMOjK3D56JkFf49UaP9tzG8MsvjFodIneNbA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dac5e8f-32c5-47ba-9c69-08d85e8630b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 23:29:30.7260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjpn81gMvc+aPJv3Udsfaas2Qj3g991eS5RBdCU8rrRX9SDpre+c8YAPI+uS5zcC3sxvyvka5zjA/eEf6PBPoeRD0qM57HkGYExKO9YX70U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4327
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_192939_166607_1D52A1C3 
X-CRM114-Status: GOOD (  15.88  )
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
Cc: Logan Gunthorpe <logan.gunthorpe@eideticom.com>,
 Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/27/20 12:49, Logan Gunthorpe wrote:
> From: Logan Gunthorpe <logan.gunthorpe@eideticom.com>
>
> Hi,
>
> Now that the passthru patches are in Linus's tree, I wanted to get
> the blktest changes that test them out there for some review.
>
> I know that Sagi has a series in progress to allow for running tests
> with other transports. These two patch sets will need to be reconciled
> at some point.
>
> This series is based off of the current blktests master and a git repo is
> available for this here:
>
> https://github.com/Eideticom/blktests nvmet_passthru
>
> Thanks,
>
> Logan

It will be great to have this on the top of Sagi's series once Omar

applies rdma/tcp series.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
