Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF851C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 00:44:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8324522208
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 00:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gVBlqf7E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UxuoA3Co";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XHyZb0dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8324522208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=Rwlbaw/aXjFoS1GmHkdcFIlb/2TD8eTZN7TlJRc/ZZM=; b=gVBlqf7ED9tojv/JiVeTZL+Upq
	fkzOIXQp77atO3n+QN2qNJwb2Gjc80jBYXSGYpctWpeTWQrpzZqBX4q9ZeE9XyGxHoQH0jT3Fh5I7
	g5rXcQlNpQ94KZ+fCEQ7XWbYwvbYwNzMxNBlCnjBVkdKc9dkA3XwLj8zwmlacpQXv5se4WnW/T7RN
	DqcXufxCGVf1fyV7evgKWg3XuqMngpNlHjwq4sTzLYRsdRPLqKOK4yTVOQrqbDvjDh/5jDntlWczX
	r1yNdduULklo1kJrXPpch6XuLmUV8/nabS5+qcjEOmXkoJ+99imYl9WUpIk2I7r59ckCoO+8WM/ox
	itvy3xRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGAhD-0002lm-TC; Thu, 10 Sep 2020 00:44:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGAh9-0002lS-C5
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 00:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599698652; x=1631234652;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3cae4ok4sUP7shc7oNnIeUNyd7OTuj2BYDlJqEzS+yU=;
 b=UxuoA3CoCY5ivWlRQccv5SOB7c8vGg2pu9GiXLk0Yrklz+8N+MhTt9RR
 tiDNQadN7zkH8A21NFcTD26nvBtFCKOE6KfWoAJmGuc8Q7dUtOP5pUoLk
 jQCXSJOTbSr+9+CuCWFt1ppvnK6md6UucV5EJDm5BALP1b0w7xELs9V1I
 kuxdeb1x44dVxG8s7+0k/c8CpfnMXM/5OTjbgcvUZk4Jso30RoqaerfeH
 LnbjN10g/GaKAl3cb1xZpGaSpph4PsjaqTSo7NawffYKTBk12bqnchqRj
 1GWxb9lXc4qGOsTVf4TQDWcJLk0zjl1llMiBJoTYmckNrjn1L4ps4irX3 g==;
IronPort-SDR: HrEt/gVWUXhXf+7f+w6OF3EYxsswQImtFY4EInagtxluROPvr6qRh3daTiIfb/yZv4GKVW/i+J
 mmUWSpFPB4fhgRlKf2aPw6KI/8CmHifAOTqvWyKSCzBCni1AoJ4788jw6y8gEsrFCB+1RHvwd3
 2w5MD1SbDHnWWxp+RrgI5pgVfu6W9pk+OppnECOMaEGigRdzJXbuX/RofmghPLTaqvVeHWqbKG
 X1eDleibLF93ppJkPifQEat5whxrE/1464Sg2iqFDJcCHgxy/WxtBHTF01Tg4crgjU0ykIrWgm
 o6Y=
X-IronPort-AV: E=Sophos;i="5.76,411,1592841600"; d="scan'208";a="148206026"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
 by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 08:44:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPXeXIc6rp88NA8Pk2cwJsd3S/vjp4Yy/cvidSREZshEv2Wu+bdniZnj4fyCgq9eMQ4QQ5BCUMEk4hEoLBuUcVxxHH/XTQx6H3SrRGGOTAqAarHtS9H3YqXo/23IU1ajfwqdg7B4B9T8PfD2zAu/P3GF5CiRhw5y9K3+bN4TGkmIj1eCtIhZEsolLzrXaZx10nx2JPfXdOItmpyJ84MYSyMxNieJdVGLMIHGfCl6/cgzmH7nwN4jY4d9ctzbDRUpK2pJsswh7RuaekbuiBI+91d5yr21v8LuWQg78H/bdODnrKa4kVNd7ggBBOxDI4/AhXt5UAEjLTPq+JGOOo7VQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIaQMnwDMubhMm5a6+pw13mMMBW9GHu2q8fejY5NgfU=;
 b=i5lTwcJRJWBkB/VWPKzn6yOEeeMvPHTkiZUz4nsXW2++Bwd27xUBhRECF1LKpOH88UblVpPltBR1B9zr7BoyqJzsq+AK4AjuftoSaPc8mrc0fMl2uyfeuFFrGtxEUeNCDpPb3jRh2shLcR7LspMMXot9ipYxE49Q8O96d6qUXXP5sAXikkNbM8Tb1uBs1apAUM74J7OV34Ta59+Cp4MU+lILSolSIVw+jdwnvwdYZGPvAzHWT3WUnEz7DmYluFBdzpXRtakONq0W/qOz48lamBluQ9EcCxCJJGMsIXk/09vYYEopHnEqq14Eg53zsTR670vfoXx0FzNYt/sKqrL39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIaQMnwDMubhMm5a6+pw13mMMBW9GHu2q8fejY5NgfU=;
 b=XHyZb0dxu/XPETtRFYdeykUkH0WUTwRsfjNj2IAernAiGgSPqZjyi4z+lsulSrAErk+lJHnm6VPGtlxjNIou5TBdEC/gyRabHOBbo40ZO+3sQEd8Ln/sXbmOuLW4hJEKCsd/UeCkDn5mLFHIEyiTAAoNZlQbzOp9SQKrK3dWD9A=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:51::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 00:44:05 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 00:44:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Topic: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Index: AQHWhukkr+7z5FAjgEyIuorVxC+8EQ==
Date: Thu, 10 Sep 2020 00:44:05 +0000
Message-ID: <CY4PR04MB375148CED3D2B42653008A32E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200909203324.3356679-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1c31:4ce8:636b:3f7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 407e502c-f1eb-4b01-934b-08d855229edc
x-ms-traffictypediagnostic: CY4PR04MB0968:
x-microsoft-antispam-prvs: <CY4PR04MB0968B6F2BE48D67B660596AFE7270@CY4PR04MB0968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6RrhvE746GiKbme4nUuZ9fGGzbF40lDSsPPrTWdPAJup66KYVp6eW297m5M036zV3qIbbOsASJzI0OVzgguCkhhDrfpKzksALfQ61kX2WV+YOyOzKYVuCukCkhdFZNmVZaPnMxnd9/Wzea7n+q4FRLFIhoVx0iB8PYg1JEd4zbllM1eAWlYINCoRfaXj+0qQDoXZFT7y7a+wqgmXdnrUvvRJ+HoUygEtHU2a19scn6fVSjK9ijNN+B0kh2yCEqtCWZkorNSzarQeUEdFA6BemzUE8zcRr3lDtghK6Jc+Bcm1Emw6YAVCa0MQkaQcIf7ZmC9jZskhHL3pgASW5UPLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(6506007)(53546011)(66556008)(316002)(66476007)(76116006)(8936002)(66946007)(91956017)(7696005)(66446008)(8676002)(71200400001)(186003)(4744005)(52536014)(55016002)(64756008)(5660300002)(2906002)(9686003)(86362001)(33656002)(110136005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MCTiqqM/yCF2WMF9Ell69c5rrHr/XLiwjou7EfuhNGqoKDtJAGdHtCObk207SUiYGOM1ZFvp9iDM/Hxu/Gsu4HDAdfok8iX2/rxNUwM0rkl6tNY1hCwvYZ+ctWFUvgIiVdhmCmeOmC3tlGbTo2CCB/V18xHjjceRoCsWSu5y3wT6kWSuKfCkPnV6jyUlmaxRTStLhpShnvp0PB7jXIeopEjp1trS4EdYMEXxa78VyCQQiDoLjwUbVygtTyLZ3gp4uovjwywRG8ZY5w6RKA7Zef4fUa4qJ84jHXfZqFnFJbTkO/g0xaY7CkXHFSItwI2vUhEQxKVNntoBaZllFhRY2911VFDjtO78F9DunKFxsOARVyvuMLCd8fyVcWozkFok3kZ7RD3dZgujxoNmO8w5lBgR+IsnyssbNJmkJBdbJqIzjlOsHCllmuwN3ydvuDjKfHsTQa0SLeaCUnEdDWeFWWrYXaE9vdayMsTDdQ7K74mrsAfKjP1M3diy9D18K9EYePDMG5In8ea/bcZw6ptEbVgndiUVmeZYwlqos4BQ7DD+F33r4e9doxRy9xg+om0+vWV3KbViq21KzNtJXsFzjvHWCbV4dR7sn7zmkM5TZBgv25fF1VFQVaPpxS5jAJ7FCLexl+oPBCyEOU0xuHuXO6Q6bWjKeyBHmUIxH0Ii/GKeJ40mW9IBAV8PghIHTBwM2YqvJMXnCUfMPUtagFBD/Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407e502c-f1eb-4b01-934b-08d855229edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 00:44:05.4700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AsVVj0oBsW10jnz30kQS2oGrLK3cxdwR1iCjaiyTE9KiBWjNPK8zPS0HDr4c2TBkznpyh9lx5mwvz4INDAYrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_204411_745064_F1085D72 
X-CRM114-Status: GOOD (  15.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/10 5:38, Keith Busch wrote:
> EBUSY is the appropriate errno for commands that complete with zone
> resource errors.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ea1fa41fbba8..aff556837115 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -249,6 +249,9 @@ static blk_status_t nvme_error_status(u16 status)
>  		return BLK_STS_NEXUS;
>  	case NVME_SC_HOST_PATH_ERROR:
>  		return BLK_STS_TRANSPORT;
> +	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
> +	case NVME_SC_ZONE_TOO_MANY_OPEN:
> +		return BLK_STS_DEV_RESOURCE;
>  	default:
>  		return BLK_STS_IOERR;
>  	}
> 

Perfect ! That fits nicely with what Johannes is working on with zonefs explicit
zone open. I will check the scsi side to make sure the same is returned for too
many open zones case.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
