Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDE2C433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:59:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E99520720
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o9dKVvpx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kgDCOx7Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DY8JJyib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E99520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=QFLudur+KgTeHJGFkP5GSzu8YfdrIUAdbGuymAwdzV8=; b=o9dKVvpx2Q61BJgaivK2myiHv
	wjx/CkQnM1WopV0UBJPGJYISZIeunDCEp8oUwVY90E05udHA8ERTSsLjsu42PF+tkcEjhyxQ57G7w
	Fo86+4mgPkFzpkQM5OWETZzSmZPAUwzOLiW9QAEFIbgN6P6MFVlnum6QL+UgC8fqFZRPbJVq2o107
	oWwER+a8j+i8USkEmDoIuZfysbitvfCa6r86lNwZ0xBPplM/pIp9Tsqdr/0s4MxJqir96O1egkpa+
	QlBPWM4sVO3Au5LpwJYi1YEXmCrbd80W3tWjJ3k9zUIPioJvj2wvL64/fSkPyUuDsG1fden+WNLVL
	HNmhM7W/Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIKqv-0005Uj-N1; Tue, 15 Sep 2020 23:59:13 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIKqt-0005UL-2p
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 23:59:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600214351; x=1631750351;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=kdmYCQ3mNXFc7dqunIebfuSdUp9n61dzXK6z9Wv+6RM=;
 b=kgDCOx7Y4rLaGQIZN9NaTzmt/IfmDGW8uTZ2WaY6E4/Em7Jvqgi490RO
 370PEcJ+v1DahWN5ni2NVAe4DzXS/uojYt0o7LtcvS4JaE4fBihSzzhvc
 KBNaLOP0Ov8uYsNJdV8oLFJ0pwAwvCe6pAFjhFCaGvxxyKkjwsFS04190
 3VoGjphwDBe3w2c/e/sLg1rbBH79FybHNrfZs7wkTOhBc1TQC56NEtDOF
 FfR9HgL6b2ZDv2AJAfnC7IFgD0HaHqPQiSuiLqr47sG+sBuqK1Xy+hIru
 mYVrhy06zF8jKPpGZlRNTghpxExI/rP64SI1OkaSqDYJo3t3kxiYlTgUz A==;
IronPort-SDR: qBxgVcw7HmnaZZ6ePW3AIeB34T1o586SLsQ1DAIVsaFf7mdjmrH+mLel+H8VSkXr64YweIOiKJ
 6hIOl6Pb47WkhkqRzw4nyhR0ZIbddE0gzlAOFnA6Nwp1y+Gw2+w05td3pvlgkeha/GDPBBfOZF
 jRoZF6mNuRm31v0Zf9vy8kRM6E9e++UN3trt+xxkpy584gHtgmHoD5z2FHeUPNtxsbY+p+5pU/
 UyYynTsMTxE2WTgIV/r/GFncegCTvFSaYbiN2M7rad9Z21k6QhkR+RS8Ao2LjFG8lUQ2C7ng3a
 tNY=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147393487"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 07:59:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXOhvwz6jlJ+oEGix9V9+FlbwqxlAWvU59255iUslDm4PNpjKgdbJ2BLTW4nWH7tUSot7Lnba2Y4ZIea7TcUWs+59GCeHH/QA7HfmzzYDbcZRCFQenM+pD+CQ2K7hzCR+LF2IXfnuIx2fTUw7l7TVX189/PDYTJUXFIvfHZFAbLZ5pN8LRl2qmo+5Cr1B92wQyzvTqn3I6DeWiXz+Yxc1gmUG0ICLsfrlC/6TZR4sUAyOzxAgn72zHcl9iplIk8QotkxpqeKb6IMqm4XTcAiF0LZKcrfbcNJ9UybHtZGPQbBDtftyH/7ZmANEYOjx55GB9GMEO50tePwj5olYoipeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBS+5v6Sr6xGvqXGsSFWv2aXjq7VatfJcF5EKTwIhl0=;
 b=eyoRBGV+T+EY48/vBXoGmK4gt0ydCMkH6ZLezlmYbdHdYEx8TaZuVthQ9dGcNqA2ukIkIJI8V/OUBqCtmrt9cR0+hajRBXq2r9TI+qnDCnQR0WFZjd0W5IYaWcg/O3ZF3H1F4XFVy3QjtbM38P12BjXEwytkHOsNvMSUj1cSkcypalfvv87PuFS3jfKxaCKcmC7lKtFEFkp1Z45Sw0McJDzVLe8Tko8wDB47Imk+G25WHL0l9EolchYjwyM19qTdgkhZhou/dIdzwzIucOX35KNYs7X+nIJelq9TJQJDUlfXSj3bA0XGwZjD+jMkRE6WbBIYIbeNE/SBQz7fi17e5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBS+5v6Sr6xGvqXGsSFWv2aXjq7VatfJcF5EKTwIhl0=;
 b=DY8JJyibOorHN8Finpy8+kshO+zwwiUfnVcn/OLC9ep6gOW4azFZ+AofRvdnuaO3B47U3MqSTLIS+Q8t7AlSfVY2m3wK7eYHlmPSA1n3ttipwM+E1bgJc58gZ2C8bM2xCmeiXMmS8EZBpSwhbb7GsXIFLRX4aDqy91fGKo+1fD8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0569.namprd04.prod.outlook.com (2603:10b6:903:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 23:59:07 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 23:59:07 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCHv2 1/2] block: map BLK_STS_ZONE_RESOURCE to errno
Thread-Topic: [PATCHv2 1/2] block: map BLK_STS_ZONE_RESOURCE to errno
Thread-Index: AQHWi4zTONwTnPBcek6OfX/xA1pLpQ==
Date: Tue, 15 Sep 2020 23:59:07 +0000
Message-ID: <CY4PR04MB37513296CFC091D1B3EEE52DE7200@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200915181230.3674743-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b178:89b:b9c7:c5e0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b692cbb1-2e0b-4fbf-9c25-08d859d3551f
x-ms-traffictypediagnostic: CY4PR04MB0569:
x-microsoft-antispam-prvs: <CY4PR04MB0569FE98B3A7F1525C13CC46E7200@CY4PR04MB0569.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ppAT5u0TUGwpuLrpDOhd32AzGREKxPFs2soDZdFZrA4a21qLB+eNIsrB/yAevzR4WN0ZIOpkt3rHKFTnI5sv3Fa20C+eM84lnRuAm9XUeAD1YpHW2Pt2GdvOaQ3m3MhWFwBeQPPVt53Eitj4UX3/nczoSP3WiaIS+SfrCmgf/cCAwvD6b7PLRP6b2UfoT626syaHbfWfGyB+VLs9bAnhJuVlCX+hx+II+8E2OzuuEH29QAJ5LkVf5bwa8NoxZzzr3/JGuMgG3LbpLP8DuBDzgmLoBiqYkaky4dRJqU/n3737EvMoSBDWVbHFF4ob6BEPmisNzCulMMeBVE537J1+lQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(66556008)(83380400001)(66446008)(33656002)(64756008)(76116006)(91956017)(66946007)(52536014)(71200400001)(66476007)(4326008)(186003)(86362001)(110136005)(316002)(8936002)(478600001)(8676002)(55016002)(9686003)(53546011)(7696005)(5660300002)(6506007)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: CTH6uWIUhVzticmsx/Z6SDINcV80/Hh0glIoNoCLxJslBc7YPFnq/u5VnEON3nkmiEwGOK+wIKgItIGpu33cIb449DqljYZ/plQuL3viy1/3NsfgTq/sHD7SCnwcDSykFXMAC/Vp2dZ3BgHRiyXOkABo8WXbvQhrVlRdMcmUrKIRsoV2To+VsdS/8FiVvazIgoKHuWmofqT0Twvybeo08JYRve+j1nGEg3m6JL5Wt84XqOcFP/dGuBxS+XoSHmjvmrAyH2MhysKU3HLaQtG0fyLPx+HxocC132b0pfo3Q33tGVdDa58PnvpbaXOBHbMOYqZcPF7xotUgSQYs83AfyYiJ1HXa4HUbbK+mloKBLwPNX5XVlqgZFQId3Z6WeR4dE54C8yBYm58v3LdAkKqN2Id9GfYcF/3cPAIB0/zdXlbpARnCi3hAG53erhhXZH5lapzIWCO3Vwnx7AXDRIGPXBRzB2MwTmey4SUcnzK2A8VZktCcXGkK+ekJi9A8vsQKFBUtS3iNlPSrbX6KDQ6apuzDAvFReo+DPYXNE35mvAOV/jSmVb9Odq5tf94rDuXfMdFfDXJaKIKAWL4zq9q/zIi68/FkbChLNh8zUoUwvKmIUWhE+SdaluQT38LQ7hGd3vrz5t6ZBkzj/MeeZDhIuQST3wP8l6K51VVBZCknh6qeZkaSbQesGUEDevkwKT8T9Ftn7ANDThlu0JcZmxsDrQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b692cbb1-2e0b-4fbf-9c25-08d859d3551f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 23:59:07.2682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BU4uZIG/SMI4xG3Xm5efXuQ4w3fFMv8CmXXm6Md7POcia/U9UDASfDbqVG1We8iCwchiJpU0rqOGMuy4gF+2Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_195911_247569_7C5514C9 
X-CRM114-Status: GOOD (  17.55  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/16 3:20, Keith Busch wrote:
> A zoned device with limited resources to open zones for writing may
> return an error when the host exceeds those limits. Provide an
> appropriate errno for this condition for drivers that return the zone
> resource block status error when the device responds with these
> conditions.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Pick an errno to map BLK_STS_ZONE_RESOURCE
> 
>  block/blk-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 10c08ac50697..3594efe05117 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -186,6 +186,9 @@ static const struct {
>  	/* device mapper special case, should not leak out: */
>  	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
>  
> +	/* too many zone resources in use */
> +	[BLK_STS_ZONE_RESOURCE]	= { -ETOOMANYREFS, "zone resource exceeded" },

OK. I think this is somewhat matching. The error message that strerrror()
returns for this error will be somewhat obscure to users though. We need to
document this.

> +
>  	/* everything else not covered above: */
>  	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
>  };
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
