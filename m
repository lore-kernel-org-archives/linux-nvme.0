Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E44AC56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:37:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD07520B80
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ztEuqwQP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OhC/esYj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Qdx08VVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD07520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=QjWREPLUbF01XBYd70yUeOVXXToFEmKsmmsq7R+aeHM=; b=ztEuqwQPJ4803szHI3hdsqtNw
	Atk5mY6BzM8xpbhrVZSMECH7gPQMbqpgfgx2kLE9yQ6cmeb37JJXLT2wxl6Blm/IvUtKm/xyTpXaP
	35I5aMvQxT0/IDtD59exlNXOo+BHeI7FB+Rce9yuJfZSllk0RUl/KxgIzk/WOkXToKTy+uwPFQMhI
	sL3ewJ0eO2yyQANQM7MihA9NFDjxSUD6MCfdfN2q7GO2e6zUx91yXjrQY7EpuLqPIiCoMHqMKQgR3
	L0FdM4J19yy1fsU7hxQHub5PYJIdSUrgUEFU5l+1czmQlEf/CbtC0+prxwK9wJdo0KKw+VBrZEiZR
	gxbfGoPDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiClw-0001RP-F0; Thu, 26 Nov 2020 08:37:00 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiClo-0001N5-AB
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 08:36:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606379812; x=1637915812;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3+Zs3cFr/wAFX09LoCV00LcsHbIRRsR/T/W/6T503GA=;
 b=OhC/esYjLwqJ/u2jrWziwY1AVVM+iFj6i620nCNFYxvLm65wKsT1/L88
 ef8no8tymP2+82NErzwf1Aj8oGtfoUkHii+Mt6q93K05DnygGr1gt8enh
 ZWcJSqrN8wVQNokYpAf11Eu9M8gs99DTWWCH8qoloa9Z3LTMHLrEu4xRG
 wq8OdQ0sv1/kQvBT4PHqT9uh0svi4LeaoTE8L+kb265wMHwEwM8vgGS31
 ZVo9u9rN4C2TMtrmr34hyY1n2qP7fOEXLXEFBzMkJNiTzCDikP99R/Pla
 DN2nEvz1dhtEXm8JwgmynhWZhEbcrrB7qrm0uKbaAABN9LGOxZlq1cZDx g==;
IronPort-SDR: QqX1UEwGTVtMizGdBjZRHEZr4OIGQe6g+QxadzxcWNfvnBx7n7+oKINp9SJTV0dQw3HF8k2RKG
 bB05qsy43wb3VvNO20Z4huI44tG/PUx2+oPilCjpkeLx4DUJOY4n0L/uog9pgpUxVUyrebwmPA
 8DREonEvk4WO33vMa/XT9HdjAxjV/wSJqlIVCxzGnZ2YTFzhwAwJwRTmdL0gUdFT+GrJRxBAxW
 jGVU8ov49+d/uPq2B8b8/lqyTQ7ywVel+b0+aaWqjtW6ri9Tq8fWr1GRFzyiUm/ztNprjJIiGM
 aIE=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; d="scan'208";a="153611958"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 16:36:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOfipZga9pTRuzUL+UXvgaq6h1SLeIwZHSVOpesBkkxvM7KE5JLuXIiBDKT7ZPcLMzKS/WMIKXX8McuAA0qO8tq4Is1vX8+20ob2bPFaS6+HjkctebbEOrYhghjXV73eiAgRzK19LoosEHOFMh/agKdWS7TTjzlUN6RRbMgBS46oSnanwvceq+vjOpQvQyjg1IV8OwAdAdl1f1M5UQ2lpKFNoIEre02xiwAj0GS6B4bf4lplthXCTuOjRPfHv+TbeCmXkrU0zgh2fu+1zsUyhHq343Yp8LLEb/FAl7ZYiaQlDQkm6yFiNw6KYKIvWvOGfniIXJZo6GeD3Y2PZAqj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0zlJVz8eTyLk8P/LT6yR2Jljv8eXld6gIZGoVHt0k8=;
 b=Dxtu/4zDzIEyOxrb7A32Sfw2oY3g95N8HeGh4s0vMR7dIaGbt2KKDA8xhBDcPM8pWcI4sdOVwlK4o4APwyAIyNm/1VJ6w819sVV8trdnYQrZhSz8hb/3LlZeIZDfg3RMF5UguX5ysJxuIpBtuoPaUCw7AfsJ912+LlV/qcCN7jjxRwaRJfmtqi8raP6RV+O/Mh+KIQxUuM54a7OYE3Ceggb0S7RSmK0Gi02ai5e5wXWTQUUNUOXNdnVtR4141Ghk4q3xDCC4dziHvIGUIZ3Fl71pZ3FKckkr8t1/azsro3+yoRiZYvGv6KZk3z0UBu1J5ZsekznG8rZyOs+xKCgHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0zlJVz8eTyLk8P/LT6yR2Jljv8eXld6gIZGoVHt0k8=;
 b=Qdx08VVKsw7FT3w57aMpK7uV6QFeZDBKkkoUwLWAHMo4eS+65EGqsB7K0WlKw8RnaeAZMl/zNgP0DhSavlC63ZyKlAulE4FdnRk4Y2FWM7Gk6WgQ6T5yOKXi/CfovWyVXRikgfjCZmCeS0A9KzcfHGWKIkjyZ7iGeZxpteQf2fg=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7095.namprd04.prod.outlook.com (2603:10b6:610:9e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 08:36:50 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 08:36:49 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWw53W//+mWSEaQk2ZMnl01vomXw==
Date: Thu, 26 Nov 2020 08:36:49 +0000
Message-ID: <CH2PR04MB6522298714A02E18D356081CE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64bc8777-accd-49ea-5958-08d891e66b22
x-ms-traffictypediagnostic: CH2PR04MB7095:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB70952A202082FB13C1BE5425E7F90@CH2PR04MB7095.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0fBgIkkkA+HZRVWtWjsfkKybFVAVHb/SFBuFI/s92VqbkAzClZLi6dGc2nwW0ktUgsWUeaPmQ++HWnPWB2fgzzDGVR/HDxz80f2RxV6Hjo42U06Au2SNyHMCV+ygdxzwXpT6gmB5/JqZw0CMvifVOq8dSIvFcTo7pJltRPjoAInCuvgFlJC28bH6aHU3fgABqrRbbQ0Jxmvt4DSGy/EmgnrUvB4+W5htWGWIvQ9IK9jd++UoIWn3dgj50z2M71MMkOA1Kpr0pu+pRFV71VqqqDJIENjylgz0t5KDW3qZ+VWk1lk7/uv9PyMbNXQs6kOP1t53l974f+PnBXjUpNhtAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(86362001)(30864003)(66946007)(6506007)(7696005)(83380400001)(53546011)(76116006)(33656002)(54906003)(66556008)(64756008)(66476007)(2906002)(71200400001)(186003)(66446008)(5660300002)(110136005)(478600001)(91956017)(4326008)(8936002)(8676002)(55016002)(9686003)(316002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?avfQAy/eoz8GUlK8g/wCZzXKHZjwn8p+iO/YwNYH5+CqpxyOGVZa7hBU1kSm?=
 =?us-ascii?Q?vP4boBEu2JfCjAg3dT6nkL/xokiravkgfV/hOon6YL5B9gScdcAKvTxAmnLI?=
 =?us-ascii?Q?CM/R/vnSwdTfKzBL+teAfOK1te7micwlHFb/4o0udPm+pPMFXjbcUfxRAWG7?=
 =?us-ascii?Q?zjqAcFHhSX9GMI5SUXq5g0fobe1Lp5Ofk8tFkBrSjwJoP/yOT9q8DOg79ok0?=
 =?us-ascii?Q?FvuFcLTCzMQBzOHr2E9/ClcSPTFlyjrlCFoZCwpt7oxkL/PkLbgqgfAnw8Zw?=
 =?us-ascii?Q?BpiCBSfqJUXegIWGsDC1n4RTS8rWWLxAb9LWY53B7mWs+H8WQ85+XFISDM3R?=
 =?us-ascii?Q?lspOIhj+9uz0pdCTjWiIKT5o2hrTgpWK/RHz8HoHdG8l2uCDaAeRKxkP3ltW?=
 =?us-ascii?Q?+8+7VIA/2VPy1x/Aujxv+9QU/14in5V5lEDfeUdbNw9lOBQUJ9Lg/ZwBAl0y?=
 =?us-ascii?Q?7IaBSgjtCwDQ/fu0oskz410dn3kVoRI0HdjipxFrdmmrH7b6R1sxMsJFlwxX?=
 =?us-ascii?Q?CLHOGpUR0vYqu9TMPnsdd7lTxp+iA0HGVL5FyjajU2aJSQa+72tE4d0P7NPD?=
 =?us-ascii?Q?9v7ahcJoSHJ8o9lYhxc78zYaKL9IpBRoZbYdxfD789L7j3y/Xgc1u2cjWjGB?=
 =?us-ascii?Q?cE/YtrHrWBiKOgib7Dbz9YGmql7Oja9N88TmH0Pn4kN8fW29JPJAM92q9y9b?=
 =?us-ascii?Q?/Pw1VpPt0XSWrRm7GVzsSpw7/6c4bnT9Nm3BWrxWqWIb58xeJf9gF8iOWl0v?=
 =?us-ascii?Q?zYdydWLUbkr60wPY/+5hGaeCFtPmpQyRpUWqdp64sEAD0sNMp7fStVqnXeQ4?=
 =?us-ascii?Q?f9R+MLcQvsl6QndM8zVhJZVrGeEKJy1WkPrpHtddrqZmwhyesRN8FFsFGHv/?=
 =?us-ascii?Q?olYI9HFMInTTpP4mpjaiPIHT/O0JQr2Im6Yla4QjcaNTBz0DQJ+FBSZrrL8D?=
 =?us-ascii?Q?T7FTzNM5VSTogue+uMopLYfMm5D6oI24XKV7KDj+uB12JvzsF5hbL3BpUcXC?=
 =?us-ascii?Q?4Q3HhzV4vxYyKxCuhvFReWhxxfthjjdDNIGrePOn/V1+U6+6s9ds3niskFFz?=
 =?us-ascii?Q?I8GVXw9W?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bc8777-accd-49ea-5958-08d891e66b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 08:36:49.7450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTsLlfMKqHmdfBl2bpnrtIPn6XcB/M3N+youUX5mY5DGBs0wLKJUaZ0mmOlpUaQdCqeNqRUK9uY0rE4OOH5mOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_033652_982368_F0495EBE 
X-CRM114-Status: GOOD (  21.54  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:
> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,
> zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS
> support for bdev.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/Makefile      |   2 +
>  drivers/nvme/target/admin-cmd.c   |   4 +-
>  drivers/nvme/target/io-cmd-file.c |   2 +-
>  drivers/nvme/target/nvmet.h       |  18 ++
>  drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++
>  5 files changed, 413 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/nvme/target/zns.c
> 
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index ebf91fc4c72e..bc147ff2df5d 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -12,6 +12,8 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
>  			discovery.o io-cmd-file.o io-cmd-bdev.o
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
> +
>  nvme-loop-y	+= loop.o
>  nvmet-rdma-y	+= rdma.o
>  nvmet-fc-y	+= fc.o
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index dca34489a1dc..509fd8dcca0c 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -579,8 +579,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
>  	nvmet_req_complete(req, status);
>  }
>  
> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> -				    void *id, off_t *off)
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> +			     void *id, off_t *off)
>  {
>  	struct nvme_ns_id_desc desc = {
>  		.nidt = type,
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 0abbefd9925e..2bd10960fa50 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -89,7 +89,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  	return ret;
>  }
>  
> -static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
>  {
>  	bv->bv_page = sg_page(sg);
>  	bv->bv_offset = sg->offset;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 592763732065..0542ba672a31 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -81,6 +81,9 @@ struct nvmet_ns {
>  	struct pci_dev		*p2p_dev;
>  	int			pi_type;
>  	int			metadata_size;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	struct nvme_id_ns_zns	id_zns;
> +#endif
>  };
>  
>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
> @@ -251,6 +254,10 @@ struct nvmet_subsys {
>  	unsigned int		admin_timeout;
>  	unsigned int		io_timeout;
>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	struct nvme_id_ctrl_zns	id_ctrl_zns;
> +#endif
>  };
>  
>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)
> @@ -603,4 +610,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
>  	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
>  }
>  
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);
> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns);
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log);
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> +			     void *id, off_t *off);
> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg);
>  #endif /* _NVMET_H */
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> new file mode 100644
> index 000000000000..8ea6641a55e3
> --- /dev/null
> +++ b/drivers/nvme/target/zns.c
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe ZNS-ZBD command implementation.
> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/uio.h>
> +#include <linux/nvme.h>
> +#include <linux/blkdev.h>
> +#include <linux/module.h>
> +#include "nvmet.h"
> +
> +#ifdef CONFIG_BLK_DEV_ZONED

This file is compiled only if CONFIG_BLK_DEV_ZONED is defined, so what is the
point of this ? The stubs for the !CONFIG_BLK_DEV_ZONED case should go into the
header file, no ?

> +
> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)
> +{
> +	u16 status = 0;
> +
> +	if (!bdev_is_zoned(req->ns->bdev)) {
> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto out;

Why not return status directly here ? Same for the other cases below.

> +	}
> +
> +	if (req->cmd->zmr.zra != NVME_ZRA_ZONE_REPORT) {
> +		status = NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	if (req->cmd->zmr.zrasf != NVME_ZRASF_ZONE_REPORT_ALL) {
> +		status = NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	if (req->cmd->zmr.pr != NVME_REPORT_ZONE_PARTIAL)
> +		status = NVME_SC_INVALID_FIELD;
> +out:
> +	return status;
> +}
> +
> +static struct block_device *nvmet_bdev(struct nvmet_req *req)
> +{
> +	return req->ns->bdev;
> +}
> +
> +static u64 nvmet_zones_to_descsize(unsigned int nr_zones)
> +{
> +	return sizeof(struct nvme_zone_report) +
> +		(sizeof(struct nvme_zone_descriptor) * nr_zones);
> +}

These could be declared as inline.

> +
> +static inline u64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
> +{
> +	return sect >> (ns->blksize_shift - SECTOR_SHIFT);
> +}
> +
> +static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
> +{
> +	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
> +}
> +
> +/*
> + *  ZNS related command implementation and helprs.

s/helprs/helpers

> + */
> +
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
> +{
> +	u16 nvme_cis_zns = NVME_CSI_ZNS;
> +
> +	if (bdev_is_zoned(nvmet_bdev(req))) {
> +		return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
> +						 NVME_NIDT_CSI_LEN,
> +						 &nvme_cis_zns, off);
> +	}

No need for the curly brackets.

> +
> +	return NVME_SC_SUCCESS;
> +}
> +
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
> +{
> +	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
> +}
> +
> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
> +{
> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
> +		pr_err("block device with conventional zones not supported.");

pr_err("block devices with conventional zones are not supported.");

With SMR drives, the last zone of the disk can be smaller than the other zones.
That needs to be checked too as that is not allowed by ZNS. Drives with a last
smaller runt zone cannot be allowed.

> +		return false;
> +	}
> +	/*
> +	 * SMR drives will results in error if writes are not aligned to the
> +	 * physical block size just override.
> +	 */

	/*
	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
	 * to the device physical block size. So use this value as the logical
	 * block size to avoid errors.
	 */

> +	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
> +	return true;
> +}
> +
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *zone, unsigned int idx,
> +				     void *data)
> +{
> +	struct blk_zone *zones = data;
> +
> +	memcpy(&zones[idx], zone, sizeof(struct blk_zone));
> +
> +	return 0;
> +}
> +
> +static void nvmet_get_zone_desc(struct nvmet_ns *ns, struct blk_zone *z,
> +				struct nvme_zone_descriptor *rz)
> +{
> +	rz->zcap = cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
> +	rz->zslba = cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
> +	rz->wp = cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
> +	rz->za = z->reset ? 1 << 2 : 0;
> +	rz->zt = z->type;
> +	rz->zs = z->cond << 4;
> +}
> +
> +/*
> + * ZNS related Admin and I/O command handlers.
> + */
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
> +{
> +	struct nvme_id_ctrl_zns *id;
> +	u16 status = 0;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Even though this function sets Zone Append Size Limit to 0,
> +	 * the 0 value here indicates that the maximum data transfer size for
> +	 * the Zone Append command is indicated by the ctrl
> +	 * Maximum Data Transfer Size (MDTS).

But the target drive may have different values for max zone append sectors and
max_hw_sectors/max_sectors. So I think this needs finer handling.

> +	 */
> +	id->zasl = 0;
> +
> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +
> +	kfree(id);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
> +{
> +	struct nvme_id_ns_zns *id_zns;
> +	u16 status = 0;
> +	u64 zsze;
> +
> +	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
> +		req->error_loc = offsetof(struct nvme_identify, nsid);
> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
> +	if (!id_zns) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
> +	if (!req->ns) {
> +		status = NVME_SC_INTERNAL;
> +		goto done;

That will result in nvmet_copy_to_sgl() being executed. Is that OK ?
Shouldn't you do only the kfree(id_zns) and complete with an error here ?

> +	}
> +
> +	if (!bdev_is_zoned(nvmet_bdev(req))) {
> +		req->error_loc = offsetof(struct nvme_identify, nsid);
> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto done;

Same comment.

> +	}
> +
> +	nvmet_ns_revalidate(req->ns);
> +	zsze = (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>
> +					req->ns->blksize_shift;
> +	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
> +	id_zns->mor = cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));
> +	id_zns->mar = cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));
> +
> +done:
> +	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
> +	kfree(id_zns);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +	struct request_queue *q = nvmet_bdev(req)->bd_disk->queue;
> +	struct nvme_zone_mgmt_recv_cmd *zmr = &req->cmd->zmr;
> +	unsigned int nz = blk_queue_nr_zones(q);
> +	u64 bufsize = (zmr->numd << 2) + 1;
> +	struct nvme_zone_report *rz;
> +	struct blk_zone *zones;
> +	int reported_zones;
> +	sector_t sect;
> +	u64 desc_size;
> +	u16 status;
> +	int i;
> +
> +	desc_size = nvmet_zones_to_descsize(blk_queue_nr_zones(q));
> +	status = nvmet_bdev_zns_checks(req);
> +	if (status)
> +		goto out;
> +
> +	zones = kvcalloc(blkdev_nr_zones(nvmet_bdev(req)->bd_disk),
> +			      sizeof(struct blk_zone), GFP_KERNEL);

This is not super nice: a large disk will have an enormous number of zones
(75000+ for largest SMR HDD today). But you actually do not need more zones
descs than what fits in req buffer.

> +	if (!zones) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +	if (!rz) {
> +		status = NVME_SC_INTERNAL;
> +		goto out_free_zones;
> +	}
> +
> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zmr.slba));
> +
> +	for (nz = blk_queue_nr_zones(q); desc_size >= bufsize; nz--)
> +		desc_size = nvmet_zones_to_descsize(nz);
> +
> +	reported_zones = blkdev_report_zones(nvmet_bdev(req), sect, nz,
> +					     nvmet_bdev_report_zone_cb,
> +					     zones);
> +	if (reported_zones < 0) {
> +		status = NVME_SC_INTERNAL;
> +		goto out_free_report_zones;
> +	}
> +
> +	rz->nr_zones = cpu_to_le64(reported_zones);
> +	for (i = 0; i < reported_zones; i++)
> +		nvmet_get_zone_desc(req->ns, &zones[i], &rz->entries[i]);

This can be done directly in the report zones cb. That will avoid looping twice
over the reported zones.

> +
> +	status = nvmet_copy_to_sgl(req, 0, rz, bufsize);
> +
> +out_free_report_zones:
> +	kvfree(rz);
> +out_free_zones:
> +	kvfree(zones);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
> +{
> +	sector_t nr_sect = bdev_zone_sectors(nvmet_bdev(req));
> +	struct nvme_zone_mgmt_send_cmd *c = &req->cmd->zms;
> +	u16 status = NVME_SC_SUCCESS;
> +	enum req_opf op;
> +	sector_t sect;
> +	int ret;
> +
> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));
> +
> +	switch (c->zsa) {
> +	case NVME_ZONE_OPEN:
> +		op = REQ_OP_ZONE_OPEN;
> +		break;
> +	case NVME_ZONE_CLOSE:
> +		op = REQ_OP_ZONE_CLOSE;
> +		break;
> +	case NVME_ZONE_FINISH:
> +		op = REQ_OP_ZONE_FINISH;
> +		break;
> +	case NVME_ZONE_RESET:
> +		if (c->select_all)
> +			nr_sect = get_capacity(nvmet_bdev(req)->bd_disk);
> +		op = REQ_OP_ZONE_RESET;
> +		break;
> +	default:
> +		status = NVME_SC_INVALID_FIELD;
> +		break;

You needa goto here or blkdev_zone_mgmt() will be called.

> +	}
> +
> +	ret = blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL);
> +	if (ret)
> +		status = NVME_SC_INTERNAL;
> +
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> +{
> +	unsigned long bv_cnt = min(req->sg_cnt, BIO_MAX_PAGES);
> +	int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
> +	u64 slba = le64_to_cpu(req->cmd->rw.slba);
> +	sector_t sect = nvmet_lba_to_sect(req->ns, slba);
> +	u16 status = NVME_SC_SUCCESS;
> +	int sg_cnt = req->sg_cnt;
> +	struct scatterlist *sg;
> +	size_t mapped_data_len;
> +	struct iov_iter from;
> +	struct bio_vec *bvec;
> +	size_t mapped_cnt;
> +	size_t io_len = 0;
> +	struct bio *bio;
> +	int ret;
> +
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
> +		return;

No request completion ?

> +
> +	if (!req->sg_cnt) {
> +		nvmet_req_complete(req, 0);
> +		return;
> +	}
> +
> +	bvec = kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);
> +	if (!bvec) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	while (sg_cnt) {
> +		mapped_data_len = 0;
> +		for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {
> +			nvmet_file_init_bvec(bvec, sg);
> +			mapped_data_len += bvec[mapped_cnt].bv_len;
> +			sg_cnt--;
> +			if (mapped_cnt == bv_cnt)
> +				break;
> +		}
> +		iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);
> +
> +		bio = bio_alloc(GFP_KERNEL, bv_cnt);
> +		bio_set_dev(bio, nvmet_bdev(req));
> +		bio->bi_iter.bi_sector = sect;
> +		bio->bi_opf = op;
> +
> +		ret =  __bio_iov_append_get_pages(bio, &from);
> +		if (unlikely(ret)) {
> +			status = NVME_SC_INTERNAL;
> +			bio_io_error(bio);
> +			kfree(bvec);
> +			goto out;
> +		}
> +
> +		ret = submit_bio_wait(bio);
> +		bio_put(bio);
> +		if (ret < 0) {
> +			status = NVME_SC_INTERNAL;
> +			break;
> +		}
> +
> +		io_len += mapped_data_len;
> +	}

This loop is equivalent to splitting a zone append. That must not be done as
that can lead to totally unpredictable ordering of the chunks. What if another
thread is doing zone append to the same zone at the same time ?

> +
> +	sect += (io_len >> 9);
> +	req->cqe->result.u64 = le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));
> +	kfree(bvec);
> +
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +#else  /* CONFIG_BLK_DEV_ZONED */
> +static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
> +{
> +}
> +static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
> +{
> +}
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
> +{
> +	return 0;
> +}
> +static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
> +{
> +	return false;
> +}
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +}
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
> +{
> +}
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> +{
> +}
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
> +{
> +}

These should go in the header file. And put the brackets on the same line.

> +#endif /* CONFIG_BLK_DEV_ZONED */
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
