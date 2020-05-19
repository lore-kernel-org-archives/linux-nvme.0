Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EB2C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:41:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59894204EA
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pWvZ+o8k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mfJHoW9s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xm9ZwySQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59894204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=S/KxzZG6QA5IgGxSXpZwUEiUJxxc1C2wDIHpTMA+AI0=; b=pWvZ+o8kvNcFYe
	3xYAbTHVozjlpIbpe8BciAkMGHQFuD0aYDjDtf2pVp36ENEcZs9fGTeKp9Wt2ziM/cg2R1L1ckkIx
	vTmEmB/2ho6gYyZlOUiVwfFbmz7YzjUPod8mgfaNSS3jWGW59RkzMuuwaO4OLUQl9z8W1SHGWtmxs
	rF2IVL5QZdI3E7EQE2VyzYAdqjv2KexDEgI467zKJ1l+BmuLPYH+wXK9f+++lYeSY8b8SPFp4+8Hr
	wUNCikPDDya4bsik4dZubZj14+rkJodnDEujlAmkTrhFZTV9VRr5pMUCJtGewhY21gdhS4u2YnCHu
	NOFxV87Obl5DmA50DxJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaxo8-0004eY-Jb; Tue, 19 May 2020 08:41:04 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaxo5-0004e2-6j
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 08:41:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589877751; x=1621413751;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=d7tpSiGOxovl8mBptd8s5DuEMlbYfYAez/7uw0R8gm4=;
 b=mfJHoW9sLBZbOmggZkU44awwm4hxBL96GBBI5ybMJJCDtaPT+hTbVM94
 4QXTvmbjjzwyZaEAaossyGFi+UAAbh1CpvjFAvHCWHLH3fuKN4S7Sa/hL
 LRWPlZbFWH+PnYp511z+6O+iD5XpfPI12F2ytSX2wv7QZnRonaIAqZpUH
 RF6XHpDN0xTDJ0ffvs3WY84YkopFApJfTgdzRlplipAo4Vtl3exscqmzF
 6yL83BgGW2T75Yz8hsLcto/fgRstRXSC4jxR3SuClww8MRchUx6H27A/R
 wnYeKHqqvNtnJEM9LEfdGtkisWVs06etWjPH+vTN5MZ0tU6pjfQsvSNSx Q==;
IronPort-SDR: 9Y2mWlG8z/cpyntWfl4wlJn7DbrxaUWW261VuQoU8+jhI0E71Mdqm255G8yu0qIEX+CRSh+3f8
 P08Mm9oMUFDh3YD2wij9Spnmx29dw2rAI1Dt0UGx3Ubzejnid1KRm/pcIhMdUu0hMF/WUiDZu5
 yo8MCI5Or+OMb9oPKdgx2OY88aXvOGmSmQZEVtiJ7/5YPE/D5Uue4mkS3bgr6j6Yi9466OqdLf
 iJE1r57RGU5pqtU/sFHMLYxAfp1C5Aha7EFMWlXPFxLsYpx1y5S/yMSNz/8BfgKemFVRoIr8gP
 NO0=
X-IronPort-AV: E=Sophos;i="5.73,409,1583164800"; d="scan'208";a="240759127"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 16:42:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgR+R12Vv4xezG2BeSK3+zNJnKIpPOijYB44S/UzMDc1jvkTA9dHTnWlLrRV071l8Nag/o0TvSQyuOuWtlgejLEfHY1pRuWsBqcU2FnFlv03WnbDvSc8BR1BLuj5GvdHBLPkLv32Em4Q++konabgckl28mzIiHA/XOWd8Cnu+YtUXhIH3AqBRO62viyAN86K3GFStUQPqItmZd2SwHbkVeGI4BBNndqx3GI8Hd/GhgiZHayu2Mvw/I0HwilDb0JncH86d4f66bDn0j+j0FH/Q2fpynVFXSAhGomG2pUERev5qi9gUDbAVK6ArMAWIHB9jI5QRl0ThzMduJPY66k+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bArCO4lohiSTJEiKiuQ9V4/cnLv9baiq7h6gJisb+s=;
 b=HsLeNLiDJnZ9UmXXzK2NSwW+PsMzZC3WQIfUxGDF82EkWNfuEwx0mO/G7osiPDCOQmfBATnoCSdSl2FXhzzHx92/mVxVF1hrw3xnbUM8WtmB0Q/iGVsdRDtcg2y4OG0B+EJpDKbYI3WXecpH0FWM08ptosfC1lu86+nazuDfb4eVTO4cFptFIO2XqPVG2FXDQ9QM3TMJQ8AqDCgF2VdBTq9TvW485614rBVV4IgICXBkYY/kkIoITTQh0XSrMKBNhh7d0zZA/MCZ3uDVUZYbLZdN2vGYB6u8KIMVCtmUHlVYCvWWCvkv57M5TgAEjlkr+TgRHgS0k3QJY1+7kz9SGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bArCO4lohiSTJEiKiuQ9V4/cnLv9baiq7h6gJisb+s=;
 b=xm9ZwySQrhSA3bNZgwzyNmOOH9RTRu/ARWhPtFBW9adSoayJkMXeM0Zo3ZpSzfbu4GbFwJasIFGfzwQtP00RE0IyxI3w1lG66sKFq1lomKsbXPvXXsgZPN3sY4+5CMAfvPr5geLunTaGeUUYFatp/16pPLF5U2+LTAmEgXd6CU8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4214.namprd04.prod.outlook.com (2603:10b6:a02:f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Tue, 19 May
 2020 08:40:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 08:40:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: David Milburn <dmilburn@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] nvmet: fixup processing async events
Thread-Topic: [PATCH v2 0/2] nvmet: fixup processing async events
Thread-Index: AQHWLUaKQHkkaJuAX0uNYZCymYDUHQ==
Date: Tue, 19 May 2020 08:40:52 +0000
Message-ID: <BYAPR04MB4965E89E9794EC5D80D830BC86B90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1589828396-144513-1-git-send-email-dmilburn@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8a72a5d-1d39-4914-6273-08d7fbd0577a
x-ms-traffictypediagnostic: BYAPR04MB4214:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB4214A0F96768F3D8E6251F5D86B90@BYAPR04MB4214.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dtzN0PCuTRToKhggHsAow3rBshkfVTYxBpSs82x2eYlN4ykN+WpG9oLKggR5zq5KSGzh02idMJllB3KFojV3Mx/p61TNtRFPY2QR4+5nN2sa9tyIWr8paPHcEzt/Hi+ZSwtzLGsFm9aIkkc5QuWJAzDwDph/a2isKO1fv2ZbdN9oyZxtfHWQFM1sJWQHI5JJyunyhPHsDMqEpypQW7GtvkPgq/7XHiHAJZ+l9pWVaImRVLaVGWAYm3e1LMeLIcP5W6azAkviEPHEo9RxVIJwUGA7A2RlX14ggDcNsRikoSNmPtqeOagYQN2offeInNkBzcK6Lj/iaMixVITX2FJJklcIqv1NVpwaaQJEq9Fv7lgidjdILmfCWlGMYP/tb9jvyZ+YqUqvsUpe72X7dwfcMJQnQlDaF5s3t7KuEqUi0i6dCxOEfg4Dn3kelq9UavmS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(66556008)(64756008)(66446008)(76116006)(5660300002)(66946007)(86362001)(7696005)(478600001)(2906002)(4326008)(8676002)(8936002)(53546011)(6506007)(55016002)(71200400001)(9686003)(66476007)(26005)(186003)(52536014)(54906003)(316002)(110136005)(4744005)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: eJr4ctzkb/GOVWFuIheU7kTouysy4uGRTR8NpsqBIinXAyBJ6LFtOsgRqY8CwXiEKBHlCp8NZ6HYwWzzJOzFLuhEB/EC3UFC0RPSRWhU9fhOtvx/iYxrKW58C2ITlAPPBJUkL3EqjP4L6H5pQpBEKv7u+4SuRdeUV3oUA4IQ+uJVOOJSkyw44Vflc4Y5YihnHe/zr+pG/ffai7V+C6+nA+dKwqbu2GgeIBktArJzh1qul9AF6GbAZKukm5TCdMSIQzwJPm3TaI4dSlbT0WZlQcaGK4pxX0cx+qPwGcKeuTm6mmDe2z8+s+8WdrT5eNHtBABKmnWgMu8IqJHvmfRelYw3yG9GGPjYFkWGm7R1LZ61MOTvDnI8jsbnNsj7CI789dlWOAsWp9Ne7rnp9irdFy/cHw3NUwoo1XPD8orS2ehCMeDx0bN5DM/hD8ncdhzr5y7+AL80iISoxiVWEIeRe794uHizEAXH2938I5VNl8U=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a72a5d-1d39-4914-6273-08d7fbd0577a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 08:40:52.9255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddG+aRxROGSQATZReQr24H1qZuy2UGkkNJk1ln0M8nMk7NhWD8j7VXIjPpSHnqF6dAa7uRjxcQMDajBxuXbAxnBJke23nD9v0O+6Cl3espU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4214
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_014101_499113_8AEE2BFA 
X-CRM114-Status: GOOD (  11.44  )
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
Cc: "hch@infradead.org" <hch@infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/18/20 12:00 PM, David Milburn wrote:
> This patch series changes how async events are processed
> and freed based upon review from Christoph Hellwig and
> Daniel Wagner, this was discovered while debugging a memory
> leak after clearing connection on the target.
> 
> Changes from v1:
>   - free aens separate from completing requests in nvmet_async_events_free().
>   - declare struct nvmet_async_event in second patch.
> 
> 
I'm still trying to reproduce the issue with nvme-loop.
Are able to reproduce this issue with nvme-loop ? if so can you
please share the steps ? OR this is transport specific ?


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
