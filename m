Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53589C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 22:25:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8136206F4
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 22:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qVRcBwmL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cahkkXme";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XFKHq3ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8136206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=tEXz4Q4UipaTmIoknLthCf/xhJY1pc0XoWbWOPL4i0g=; b=qVRcBwmLRlH6j9tqzXBWehNao
	zaNUoxjn6myQGnQOYGi8PMsmPgcoEv/fAcdAgqyqtl2l/9uWRn3WBV4IIw5KsqegfZ+/u3lc+G8VR
	SVcayt5D1FcX4BAVjdahWy1IwZ/L/jWYz9kSlmOVjfwSYXSxSvcSU9eD2k73Hn/2DVUNmB1G9Qlzq
	BLaElOJXPbPhfPJJ7524tsfC1eyjxhX3ZX74rYfq1FfNAFg9EET4omz7ySBNl8xZ36596yb1uf53n
	QsVYYHxNN+DCoj0LCjpJ2QAaXrZM3guIjxW9bOiLzpiD9VVRvqmfawQfGPoIPKhJmnNwoHGKjIG9R
	NTMQfkUAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGV0Y-0006m2-J6; Thu, 10 Sep 2020 22:25:34 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGV0T-0006lU-2m
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 22:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599776728; x=1631312728;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=kqOcHLT4Vbsh4oBDYiykiJWCfTKjogvA844wsu2DsDQ=;
 b=cahkkXmeRs9uUJ28wRFr0wiWzNyPoXrPiBtFT1eZ+FuSej0ff1VZhzah
 iOvVWpj+p1E9zadwSR/OKjqGLfQqGJVOdvaq49P/3L0a39+6oRLE2rtX8
 ViZiuv3IiT99Xt4BbRmhvkPbV5cWeevghsTwQW1Oz4GXeJPLVZkeiqsA4
 6iETyHXFCeOeKJ8I9Gy1SvgEfPqeDS6TnHzblV3unw7Oqrx4jZCpGteyi
 QAjDw13rm8fznXu35SI14KhqOkIAaFYJbjVHe2crNDA/oHLq0W1pKYy5P
 MuWWSZ0As/TgylsyoxcRQ9GpeD7cPsY0orP3TxviB81ahuVG4qLkWfuRM g==;
IronPort-SDR: +7DyJ1Tdq1x4ljGi6sPlocXKIMwoYWrosz4P43fxPZE7DuOiWyfZTlmAb2XAbdRMpl9vpftAtl
 ZNKxa5WMQ3pSnpj69QGVBXQjLb6J2BarSaiEJOT8s6Vpqje5fLjvRPD82WKSHpf7Esx8kJ+Yl+
 xlLpOwN38+XWqE5VwtQNt6qOWd/otuOlzuBp5Z+Sr6nh7iwpgCulYGeaERs2rvJOP4Ybr9MSUY
 TYweQNsGRkp/sG7jxE0JnhJx/R4oEo20hgSy2Z+c5rJFaG+pKjU6F6c/3OIjWBSMCTvYEHb7zo
 hcg=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146996670"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 06:25:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZrZYx4bhjs/f3AQ68MK2HvrLfnDTNntytY6RCWsQqes5dCOqr6NNRpTgXbxcSf4o+OXnMJGenwM9xfEXKdnykqCqCi4GL9EjyBGzTwZejxGNzwuBBwz4CroPvOwQpbppUM8DnpycoBEuZOX6s3eL1o6MaUSFnuZtQAHWsysE/PF9O15ekPJTBKAn/HqIO3Gi35rM98SwJkX8atEeQ/cvk3N2hBlKA8KCiAq3qivemnoY7ynDlx2S0DclgAfqxqof3SL0LCpSjadGxQ9Fw9Hrxx7GF/0/D3wM7gohrrp6ekUmPWtTQ97wEWebThKgpVaMlXFrV8OvI9OR/TXDJEbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98WTduDKqv91TyZY5hf7Oi5kevS/ycVUmizbUWuYgjU=;
 b=E91AF2v3jttjK0eczGESx11sCksZQZTAaUiIsN3Hx3wDVg8kBOzyTzmcLKD0M7uGCN+adlam/gR9WNIH3sjtZ30S7cYwtA7mkSPRpxO4PEqRZPDcaeAgKEc0XUKlMCQX2Nedwta1GGOmjIdCI0Yok4vUdlvCx6RfB9YzpfpVilnm+4mRHIL0CouMarGKFngYVpcQg02wRwqxGc4JmI7W20E5ZxoP7yVISajLb11h7fyKkIz0cQUlsRAParCI0rgxHENiua3Vq+Wkb4FcgEesJpc3RHnBQEmEMsHwTIuc7vDuwhewS44fYSPc6/6y7M7KegDzMo87EHRJ93+F6H0Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98WTduDKqv91TyZY5hf7Oi5kevS/ycVUmizbUWuYgjU=;
 b=XFKHq3ap/lwSQv6N5m4Hv5EXZVXGMzcNXLES0O15mE6z1D/RTTlXiGK68piLV9tHXAGbpkGRgaGMPqRVICMSq7qsfCwOuExhIjyt0g803aqAU8cvf8h8y0UTeztxsceMqL5fcFdrlQj6cJ+B68XXtdqJ5MMuN/q7GIfcGMZcuEg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0247.namprd04.prod.outlook.com (2603:10b6:903:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 22:25:24 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 22:25:24 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Topic: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Index: AQHWhukkr+7z5FAjgEyIuorVxC+8EQ==
Date: Thu, 10 Sep 2020 22:25:24 +0000
Message-ID: <CY4PR04MB375101AA0F80FB54BAFBC427E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:dc48:bbfc:f5cc:32c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b7591cf-eb2f-4fc2-b9af-08d855d8696f
x-ms-traffictypediagnostic: CY4PR04MB0247:
x-microsoft-antispam-prvs: <CY4PR04MB02476F41D08F4DDFF1A7DB9DE7270@CY4PR04MB0247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Elj4sEKKm+sVkUR2ydQgLJq7i3KTxQlDfoF6QboTGUB7qGajiEHIgv2kycJxeETsksgHd7oPz9BdzV4o6CAPiZhVKLebx/hrzYYqWXzpfHoCRbMI/YRFDpG1JyDx5uoPBBb5dx0s44QlZ3cazpaYtl4lxQ3WhvTAHKCgHFtCTK8hVI/f4qwj2xA1DYsMGdlVbzJqnLs7E6AEzxSv7tRBJcQY/zpDi9CKiTbAx8oVzRVELPRNQkrxuIe7dSTMo61zq1clkqDXD8y1D4PcRky1ZpbZAaonQ/hVqLkxsk8FVXKL/LEGINOTCoigd9xfo/YoYRBl7T1DcqFDxubZ54hgYiHQOmJjxQ9Bf2Qa57jGP7y2Qbr76CQtJYj/j1oPsb46
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(186003)(64756008)(76116006)(66476007)(2906002)(91956017)(8936002)(66556008)(66946007)(66446008)(5660300002)(86362001)(71200400001)(52536014)(9686003)(55016002)(6506007)(53546011)(8676002)(7696005)(316002)(4326008)(54906003)(478600001)(110136005)(83380400001)(33656002)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: fP4ptaQyqKmFsjvcJib6geBuvsdgVqMvTN+CXjb9vwpVNg6MigRIl9cSJg/rjAyxUS/TKJWl+veViGxpXrOrPADbcU2sp019VXBO+iUJOGga329Gqwwyz3W2bDItypK5fEXi42Qkv84EbruX/S/JrX7PP8eFB7ZDnCAuCucrtr9Arx8oLjDusrq96EWGt2nrOUizoL0j8gIpC7w+KyNuUXNJURitGJZSNC94cmo1KwoPeNjrWXzvQ3xVmPo7oSHFredipUz7q0oOvrnAXMFRNCEn4nmpsTw0Lpt1wJyH9wdGClQnmpqv2MMY4RRjLFcPiELXxXeG2OE9ndi3/Qvzt7+Ct9nyV37NP5284XXKk0Lun2S2ohNr5le6NlGmv9wZMN81L5zBH5D4ZgfLcLl34YSXaqaF21W3GudRqdne5FCNn37svkP/AP5Apz3kpooozfDl7Azi3SEAM4GTx4ka+cdDcmjzcDYSYG3TU0n9bGV90oR4jqSVP0LmeEE31Bj1Eb2M7497FeVAkf++8MHjqEJJtkC+3iZFps/DgdcEojMoSk7EAv8DnKMU6Czy4h7fdjd0c14I38VvGnioEdtaKWwiEdBaY5f4XHu9bVOfs2u7YokY3+oh7RK6MT1d+m/wcSmkFRMNo52GVqDMwVvR/2L/2p8ZcUQP8slp+y4bZw6EVk+vd59x54WWCSU07rMaFsOR8YMiwnfh48qgJnDuKA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7591cf-eb2f-4fc2-b9af-08d855d8696f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 22:25:24.2152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEa0p/aS5RmYoKpteSBnlL74CAJj+yASjLEJsk1tVGDqPtMUywXOecO6HQTfO8tKtnXjrbKw95s4Bdqn3rOR2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0247
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_182529_342292_C0D3C624 
X-CRM114-Status: GOOD (  17.85  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/10 14:34, Christoph Hellwig wrote:
> On Wed, Sep 09, 2020 at 01:33:24PM -0700, Keith Busch wrote:
>> EBUSY is the appropriate errno for commands that complete with zone
>> resource errors.
>>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>> ---
>>  drivers/nvme/host/core.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index ea1fa41fbba8..aff556837115 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -249,6 +249,9 @@ static blk_status_t nvme_error_status(u16 status)
>>  		return BLK_STS_NEXUS;
>>  	case NVME_SC_HOST_PATH_ERROR:
>>  		return BLK_STS_TRANSPORT;
>> +	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
>> +	case NVME_SC_ZONE_TOO_MANY_OPEN:
>> +		return BLK_STS_DEV_RESOURCE;
> 
> I'm not sure this is the best idea, we probably need specific error codes
> if we want file systems to be aware of the limit.

Do you mean something else than -EBUSY being returned to the user by the block
layer ? Or a different/specific BLK_STS_XXX code which translates into -EBUSY in
blk_status_to_errno() ?



-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
