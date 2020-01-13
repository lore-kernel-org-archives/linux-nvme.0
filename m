Return-Path: <SRS0=NYF9=3C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4392C33CA9
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2020 23:53:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFB3206E5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2020 23:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F5mRpBVP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BVlZPcH9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lNyHUfsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFB3206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8jKd5pMf+ddwKmwLnEX/NIARFZDovamc4FN7jSDEC+U=; b=F5mRpBVP7Gg1lL
	6zVXRYRdSDfzF9Ug43dKxj7f3wc9JXItHUZhPFQpgG/Zgfg0Z/wWojgXYE7c305MjaF+bsj2vvl5F
	u8zDx2mmlb5RxJRkVN/ggT1f2GiWW2JF1uTDyz1c3l0WKzYoGeWbGk999NqaaJ9ZBRPns5XJu9JOu
	mYsDyX5xkeK3EHLd+Red3JP5UvIKDvX4DB1W/9PlBDeBFY9kGv74BtqkqxLV2QtS/FKcY2PCcHI7y
	wNiqHvVKiSaJ+W8rJXd+aekUbX0VNMUULbW76xlvnY8IgDwXxn5R/qB4zSTvng63P8ztIqMVLrq40
	iyfDDrHQEvwNyJg1z22Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ir9Vw-0008Uw-G1; Mon, 13 Jan 2020 23:52:56 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ir9Vt-0008Ue-EJ
 for linux-nvme@lists.infradead.org; Mon, 13 Jan 2020 23:52:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578959573; x=1610495573;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=vmWf2Sk+aGWBKXIOaJDSJsf23EQt1tOn9urLaYiNgqo=;
 b=BVlZPcH9Pe3Yhb0nBhrNClwIN4N5nPtWR1w78fhUuBWHU/FbUD+uec5T
 iBGuJ9FhxNKKDn9eEjGChcAhBckVp9tkjtT7AcUkHWDPlIkrefZjwpyVr
 xP0g5Fva8yERTNUPp2DkA877YdQtNp0xy/ReYYqBdTN4h2JPzpTilO+lO
 mG1BO8332oLCZg2C2xThERMukHQ8r+COz79Bji/wsSw7Yaj21YjdfZEUK
 EIDF1ZvCSE+LgOHg4ElZ+/uWabKNpw92DG6Pk/L4aS4CEFcp+09lQJZFV
 Sxcql6aUQPalPRIuaEuvy/P/TF9xSbuBfNEnpJG9nwK0aSjPg80qV4CPD w==;
IronPort-SDR: zJRuv/XkXlZ55CLGLTzL1AWQ34zrbjmlzXc1BdItvRqtF4kp3p2w0pz4LNX6vo2uZvA8Nh8Sd+
 rLXYkpyFgspPXJOo/Q/ZdLjbFBpQ/uWaYrbFCajObHVDPVLOGb6uiVIwMiBLYQZ7HZIReGa2L5
 +Cagp5H2VmI3pokktENwk4vlczbJpb4wI/Vea17ZNW6Ozt0EU9jspc1vAF8RHeikgzF+a8E3MJ
 rfubVLMNbF/2T+J90CG1cg1UHtzyDnQUm5bbodVV9BYRL/vnM7EwhVf539h1/U5P4PxoKeAz8X
 yiU=
X-IronPort-AV: E=Sophos;i="5.69,430,1571673600"; d="scan'208";a="127328934"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2020 07:52:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUXJe0TkrPvUOSBpu9EMwPt/f0+kGx/pgSCsAwGKoYCLcB3L3WDfBagHZi71ZQ4FYBhRXsmpeQOk0BKxXcUwoaOVnd8Ed9b0Z87G2SctU5JpwrNoOG3z78XBX+Zv5CD9J7YxQPkvdDFyEO1iC36vTetUd62p0dn06+pf3Sxf82O1rFbFZuKhphBaJwxRHIRr6G/LKsbTfxE1Pg9HZ9TzURGFF02l8aDyoc8XPnWSBZQx92XNzWUo0KeF8tRLpdh+CF34feJQj0IUxWQj8kKUkjJjxyA7J16UbZSQGXxiNkQRkJvrQbMsfc5v3ti1b4KY3mQ/61JhWXoZW9TmdrIysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmWf2Sk+aGWBKXIOaJDSJsf23EQt1tOn9urLaYiNgqo=;
 b=juaRCxbfhgyLJ56KJbdPemsaFySZxMsIN/6oakwTEitNCLtROMHVeqcwDrCms60dCZi6PPf1NVDwRWaLHn9ZXW7drdZvG3qUyS0H7gmhfzXcSlB19t/g/6UyBtzRLFNngT9qu+J5o0MjrzUvsU4T65VLtexYDNi9hvatV9UvwFtccLjXurFVVwqtJBnZ297X37/blR4ff1MYcbvSCrJwdPl5KUKopDaOpCiBWe/miT7WCquVs+vkaOu0OJ6Dxm1kFOSd3FUV4ZluQArLpNOHgfoepv+hcKLZjkyFdto4cEpIY2yWiv9m2E92VrYoXB13p2vGUU+XdkeLaCQGcK35DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmWf2Sk+aGWBKXIOaJDSJsf23EQt1tOn9urLaYiNgqo=;
 b=lNyHUfsg8C2uVMB6ixfFur7H++ZuBzUqLV0QnC60h56CH7WtaVA0pvnTRXVw36gu6EZUO4/W4k6r7RJIw0bDbLt7pGJuQSZpp19O3iZPvDCLlWRafFuxwnuJdpkJjCp61KpMKDh4unABdO9QB4GwxfqQFfpI1wbhgCduDFzF08s=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.51.24) by
 DM6PR04MB4475.namprd04.prod.outlook.com (20.176.113.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 23:52:48 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::f123:d623:d0e3:daab]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::f123:d623:d0e3:daab%5]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 23:52:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/4] nvmet: misc model, ctrl-id and AEN fixes
Thread-Topic: [PATCH 0/4] nvmet: misc model, ctrl-id and AEN fixes
Thread-Index: AQHVxqoLiMhyYo1lo0iQcoZol119XA==
Date: Mon, 13 Jan 2020 23:52:47 +0000
Message-ID: <DM6PR04MB5754B9326B154EB2EDBF1D6786350@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20200109050244.5493-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c30e791c-cfd1-4860-ebaf-08d79883b160
x-ms-traffictypediagnostic: DM6PR04MB4475:
x-microsoft-antispam-prvs: <DM6PR04MB4475ED5A5963E3B4229144F486350@DM6PR04MB4475.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(5660300002)(6916009)(91956017)(53546011)(26005)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(2906002)(6506007)(186003)(7696005)(52536014)(33656002)(55016002)(71200400001)(4326008)(478600001)(54906003)(9686003)(4744005)(316002)(86362001)(8936002)(8676002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4475;
 H:DM6PR04MB5754.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+0bdFnrUMeZgOz9ac2UfukuhKuuHXyjT2xG4tfwGipgIcYWz6T1AVYQbgyjeIyy83JK3bMddVTT+6w81BEYeos1WaV7Db/3bw456TlDW+qf+/bl1rk5m7T1fG2WyL1t3ur2HQKulPUvqLwGiL4j/TRqH9gRQfEp9KxkTD8M2rLdX4hPbMrALwF58qLDk+SVKlCMnPDSB4FqvTr08WtesPoKIuT5Wcdpfv2Srvi1ZPx88Mjca5hlzpD1Eymmctj9k0zN74jvKsDt7TIkj67faDIuxRjrSUyxHgzxSsqfBd5owOvLkz3hKt+hRJm8gTsPEYePOO+pLlnEBzqPMRAwUcEv4FHKpYFTV4EUwgtu+bvWZDDSD8nAlzpkY3ovU/ESJ8DBGDyM4h85wTrVJ3J5R3+OeSXWNBCFj4k3F9yRF9W6SIediP4C/pd3aa/Xw7Bh
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30e791c-cfd1-4860-ebaf-08d79883b160
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 23:52:47.9121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vYzvPTDGr5md6r2uM1ALLBkomoSjAIL2QevAzSRDGcfZt+86cSnqtNj5hN46JvEiZ6f5YRBcsuRBY0Vc5zm5AowIHFPrH3zewljJIX9wNjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4475
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200113_155253_609397_D1E059DA 
X-CRM114-Status: UNSURE (   9.30  )
X-CRM114-Notice: Please train this message.
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ping?

On 01/08/2020 09:02 PM, Chaitanya Kulkarni wrote:
> Hi,
>
> This is a small patch series that allows users to configure the model
> and controller ID. Also, patch #3 has a fix for missing sscanf check
> in the nvmet_subsys_attr_serial_store() where patch #4 provides a=C2 fix
> to clear out the async event for which AEN is not generated.
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
