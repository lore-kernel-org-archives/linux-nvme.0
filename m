Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71D9C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:40:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8D423428
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="seuzqbPp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kd3kV5pR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p967WWbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8D423428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=u6bsAL7exPB/I5/DeahZKvfyTdfD4xIgh3qazaFEjkU=; b=seuzqbPpc3vvHH
	M4+CPonqlOEBsDcqZWvIl1Bb1usygn4vLt+CG0V1ibGpsFaGRCxVoYwpcDobRR/mgvWVL6nAksxm5
	Dw9j/fxT6xVG7oAOW7HFjaZu3Uo1C+Urb4NnqtXzLnpMyWVnjZKilcShpSngoLlBJ1c+AcWIrN6IW
	OuZjYd8TxtjNasq27aMNW9GHdc5us3T31WbKPlaVKOD0KWnHjG8ajBkHfvrk2wUn+ISX9aetzQ3Pz
	r+kxS54Gd6kPZheLX8yFiQU2LGIlOolQjQbI1Zh4Duou618ubnsrICTEK46t4H+CFKfM7Hhgunv7y
	/Gzgz/cc6i6qxUH2P+nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3loW-00044s-Gb; Fri, 30 Aug 2019 18:40:00 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3loT-00044H-LX
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:39:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567190398; x=1598726398;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=JMeu5AKE6xUVSWZwE7+IKIMSahiqAU7+kAhQjcb9xN0=;
 b=Kd3kV5pRlXDi/PPO0gWytEjWuBdBsq56Ykndwsz1/qN8mOJ6ZldKlnnV
 Au4AgJvdXIMtAF0IoNGztet/rlpenfacOXVJIsJz6A6CczCOuNKSsIrz/
 WKhBHmY4VRgErC4pacdmVA7DeRjy1YvY7N16kDgDlj7T6tI2TYtlZgqsZ
 70kyPx9lPz49qkNrtMHhQPB65JajapSAvPI6sIDKky2AonY9DdL6CYEEw
 TYbSzRB5AzjdBwjvEQsh8q4GPZv/s38xx/1AxbkzWbRAZ06ZtihvhcOr+
 a5Q9f1P+P3w+HxZYqgtIBxVIWtr/c7mFBPljcxrP5dPEo77oRDKwhjEuk g==;
IronPort-SDR: 9Zo65a5JvUWr/dbfd6uGZSvL3G/AVzGiD5Wuzu+x0IJiAtrDr4DM6DswvW229M0vULFCrhOI6/
 DUX3ZR9WmwsWZKAMTem9PL0wYTgv2NeNkudiSuzafI6OU5N1hHix3rw+ZhqpXeXgqvEonIoeIg
 cQW7A35I0qshRneU8DTrgmpnN36H6ZOvC7Y/eM5wX1sz99RXuAVtq2zMxTsRqwV/5e0MOwIoYv
 k1ndFhuGKe6Swn8eWcWZZb3xC84c79VR4jIWXdV+FjRXVl3GP4KqGlZ4P2CP9xUOnwthHpFKou
 QsY=
X-IronPort-AV: E=Sophos;i="5.64,447,1559491200"; d="scan'208";a="118641540"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2019 02:39:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3PAkh2t8QO5DT5cRsMJKYF2qIYCCa35lRTIAU99nx42/ajL/eYLcMTRg2tGMBT9HDtkSr2X/Ktu8sueUBxscVU9TJMZlRSHtoNJO8NZrXw+XCNMu7bRft7XIJAP/fv5Ccbx6hDY6N7iRxKEoL7IRIG+KFZx8sXcOSBtvE91lJK7OTKsiLO8VP6v4F+bJQlVyCMCwZ+HZN+TOS2yoo7hrRbWcoShzYlmryPsRAAKTS09/NJOE2VsbPKaBpi0+utSRnJrYZjeEzcSw2CfgjGqhsF9pB1BgFbUq2X7EochTEV30voVp2QrIgRJu/4ZVydci8zThmzgPCivimeIhWDbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18Bc176+JCuso1PIWSPdJoiDYtAlCl2BKWBr9WcYktU=;
 b=fMziWdWNSKRIpzGnPBOdqse+KPRKrOBFLMaPUkX0knIukpV6Wo8RegsqtB4M1nL4jLnIijUevesm7I6TTI9w3hp7ZY1e7kjJGgy7nAYohvWbQgzyOKLcQGw3aQUWBVTtfPRFMCnfH1eR56C3L26yyjTeWKueuaVfuA0KII+n0f5PaIR9quMUV8BKf1i4Dixd5tDOQPHxlkqu/s+h59cHaVwQ3lcJCh98m8tzWt+g88O89fL84xRTpioBeaPM3XrS1dDO5eqPmJojct0euzbieoJN+HqolRbaNFAHuyvIaZmvhq02rzpSumsARnofe8AHvc4VRhe9E+SRSJZgSrl8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18Bc176+JCuso1PIWSPdJoiDYtAlCl2BKWBr9WcYktU=;
 b=p967WWbJT+ekXNoXZoB4810+t8lY0DaYIMGV/SZ58aGuHY57nLTLDszVa3u37bVhI7gfOmozmxUqf1Mn199C5BpnX2uoh3TjIHAmgyl+5FKZtWxyS9yH2dZZZz4Ne/pVVdp8zOAuQ33WsJDbfrahZKpxgzdkr0DVinROlw8LsaU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4296.namprd04.prod.outlook.com (20.176.251.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 18:39:53 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 18:39:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v9 1/9] nvme: fail cancelled commands with
 NVME_SC_HOST_PATH_ERROR
Thread-Topic: [PATCH v9 1/9] nvme: fail cancelled commands with
 NVME_SC_HOST_PATH_ERROR
Thread-Index: AQHVXrYVbtCjXFykJES2ceYJKE5f/g==
Date: Fri, 30 Aug 2019 18:39:52 +0000
Message-ID: <BYAPR04MB57495F808960CC3D45BC7B8786BD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190829220645.5480-1-sagi@grimberg.me>
 <20190829220645.5480-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4a09bc3-1a39-41da-d831-08d72d797274
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4296; 
x-ms-traffictypediagnostic: BYAPR04MB4296:
x-microsoft-antispam-prvs: <BYAPR04MB429656A86A97A8D32BCCC95486BD0@BYAPR04MB4296.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(186003)(71200400001)(14444005)(256004)(102836004)(26005)(6436002)(229853002)(55016002)(9686003)(110136005)(54906003)(81166006)(81156014)(8936002)(8676002)(76176011)(305945005)(66066001)(7736002)(7696005)(74316002)(2501003)(71190400001)(53546011)(99286004)(6506007)(486006)(446003)(476003)(86362001)(4326008)(64756008)(66446008)(53936002)(2906002)(76116006)(3846002)(6116002)(66556008)(316002)(66476007)(66946007)(14454004)(25786009)(5660300002)(33656002)(6246003)(52536014)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4296;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6ieXfuNXeNnvDJ5DieN1LZ6/uFKpPw6P3tfPw4vol2FjB4t4qTZbTA19Y89zw6NMaSNtnqdDDMetkWNz/WbQB7UrhGWQplPdj8RAJV85dE1Cg1s61rRwlo+1WEpTjMjL3it0hxdS/JQ8+h7++1skdr1f91vDIKk+n8ykFb1warf0l+dTus2gfeJJVm+5Ak7dbGxN/KV4UmUBZVkoCGDkvU/yCFKmBmld31lQCfxN0wt2C4zI1+qw4ps+dhqzBAZYurK86DjwLb17sK3VTNgAMiKw5EdMdelDTgQYtxpcTIX6u3jdvRzmey6iuFmcUebNzoDICkC2B+ofcaGNxgBaE7C9WG4hh3PxSvRgcPJPdtJh/KSOpOPmnl4IBklwNmqEWqQuGx4v2JQbwk0QI1+aABTGq9C48LEbJMYXcDs/L6Y=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a09bc3-1a39-41da-d831-08d72d797274
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:39:52.8608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7drxRhy8iDUj1kNG+sKIkgREmZC/HFbwJq8/sFSAuNIRyBv5Rovo8/4IXqOYxagCwBdeUUcTHG1nTr3T5GaPSOcVKUXTr/pgFHP+CR+zbpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4296
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_113957_773570_66CB21FA 
X-CRM114-Status: GOOD (  17.72  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 08/29/2019 03:07 PM, Sagi Grimberg wrote:
> NVME_SC_ABORT_REQ means that the request was aborted due to
> an abort command received. In our case, this is a transport
> cancellation, so host pathing error is much more appropriate.
>
> Also, convert NVME_SC_HOST_PATH_ERROR to BLK_STS_TRANSPORT for
> such that callers can understand that the status is a transport
> related error. This will be used by the ns scanning code to
> understand if it got an error from the controller or that the
> controller happens to be unreachable by the transport.
>
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: James Smart <james.smart@broadcom.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0eb5c1bb2f48..11ef174e8399 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -226,6 +226,8 @@ static blk_status_t nvme_error_status(struct request *req)
>   		return BLK_STS_PROTECTION;
>   	case NVME_SC_RESERVATION_CONFLICT:
>   		return BLK_STS_NEXUS;
> +	case NVME_SC_HOST_PATH_ERROR:
> +		return BLK_STS_TRANSPORT;
>   	default:
>   		return BLK_STS_IOERR;
>   	}
> @@ -294,7 +296,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   	if (blk_mq_request_completed(req))
>   		return true;
>
> -	nvme_req(req)->status = NVME_SC_ABORT_REQ;
> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
>   	blk_mq_complete_request(req);
>   	return true;
>   }
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
