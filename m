Return-Path: <SRS0=TJkX=YV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC98CA9EA0
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 07:38:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC332054F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 07:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rT2cBl7a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZxGyaZgJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ae+o0ZPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC332054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Klc41wVG5wKokikz0cEZlgXLCOz09fzRrtmrM7rjDis=; b=rT2cBl7ai0By0A
	Bd3mEkJzkhDY15Mw9jBl3Zexlbx0Pe2GlEZhWkDYOd18qQH5n1X6Atopn7i5rBuFG2AWOOSUEhkGy
	ZH1BhX4fhOz3FnRPX7e3eHY2p4WFIS3M3NRBtlgP20ttvSjvTvpBI8Gb/OJdQxYVrZGU3daTj/8vv
	9Hsn+xpgoRyvq3WsWEm5k2j0Yu7Dhyxg0hTo5fx+kYwrnbWUvIi4g+SbHf3uegxZaM+f8SNMf2HN6
	D2K8O680lq+UiSxkquv+pBGPJAGLqOsxg92K5BqyW+JnTsDGvRhOW9tTz9lv9hN1+/fdd6nzljc8V
	fhmcAdj6m1B34/7LEIqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOzbP-0006HT-W4; Mon, 28 Oct 2019 07:38:11 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOzbN-0006Gq-Rs
 for linux-nvme@lists.infradead.org; Mon, 28 Oct 2019 07:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572248289; x=1603784289;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SoxXsg1G/4LFp6jbccqH9U6+YzcwCVKyPBCONlupH5A=;
 b=ZxGyaZgJY9PYTupedzNxrO6ugZmAZHcyJZn9JOSuacChfz3wiEcCthcr
 dDbK2Km4Y/LeUUGyFhJCWk3O4yb4ixxIJGBJbgqq/fBqrVKDQR0IXqMrl
 yrrXGh+z3jFWRzTZkcXHOivcK0u5ZzAxeC0GW3+DTlOTepAg243ckUGTw
 3+JJnhvsELQrpdf1DWYGu8KJrPASsXuo7zAOOHVaM5Wdr6XV1K0m6yPz5
 +Zdd5PNTDCbeZgrGM6gURToUbtH2KrTqFn/i3gssQ9Cc5f19BPfDGe8Rw
 EQwrdRxliSeQUDRzKaJGCU3yU4vG5+zenegnIMd+Nn25DFX6fFdGmxQDW w==;
IronPort-SDR: bTPjqPLE2MXJpp0Nph8Wg4kC/ST6djnAZnqxym1Z/GTGvM/KxScseiqGmuOcpQT0M7iVwD3e4z
 brXQkIfOoHze5wZFX9PLRYTIKjdVZdxqoOtcVBtIPcDm9D+dgO1KB+DTaouM0zUyfOFSBmhP3z
 v0MFdoYHeO2VQgYcnOlrqz5PQUsYbomhWk8LY6w2pixA8d/EtqO3pUXkDxJHEF++KFX9E9ENy2
 LIH8h7suE33otSUBmd4S4MRmbWB9dBNHzW422W/Z3ZcDfRSTbv3G3blCoRT/ov9LBlnhInsfn2
 /7c=
X-IronPort-AV: E=Sophos;i="5.68,239,1569254400"; d="scan'208";a="228627750"
Received: from mail-by2nam03lp2059.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.59])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2019 15:38:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIfAIstkG+wlw3CJwn2Pkg+ztPR5NJX4S3WR5DuU/76kl0eFXbcTucegzjbKr6/VeAKsCC1FB1oWEYKuUuROBkT2janY53oHTWwYQpSPHcQYoSkd6Z0keSoL+sp42WkMv6VWB5JpOWIjTjh7nFbTJ7sGiWNhDVkaCFispt5+l3ExX2ACvyuZI/I2787OnRxbIitKlQ4DZ47AAbcZR+oYc7lj6bkgAXQkrWi/z+w6R0g5nelkVyZsXKwm5wxBNa/xSfaDmjFrHRC8nKA+n+xTuEk0BkIA1J+x7eeTjoysU9pqQKlF5ZymH6trwEJWUKbdwvQPod+AkNm9MrG5FMBw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoxXsg1G/4LFp6jbccqH9U6+YzcwCVKyPBCONlupH5A=;
 b=eKVTBhOoLUUjNPCNj6yKVHxph49Zz8Ks6SaC8xbpUfemepgHFZ2QAgQdB6u9vb8Bk4Gv6zeM9IhFiHlPksF/6gfvrO3REY5ATwKGj+82Rpv62+WmSLt/tc6kxFiZGv30sG3EHo20tnjFRf0QL4hw0YnKP9YD0lZ6povnF4Y2MmcX3hnvJCTemK4+P1b0ceW9ryV13m4wfM3pgJAulGk7SsX/ntcXy4xb69nN3uD1lR/h4HV5poOahNlmMvtJqD+LOa/bhPyy3PKazZPlhafwlMYAkptqSz97qhexw/KPhy+YJRIrZXOV694QXCd8sulKYX2qT27n9qDzcLDShwpUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoxXsg1G/4LFp6jbccqH9U6+YzcwCVKyPBCONlupH5A=;
 b=ae+o0ZPrmv1Hw9ycIDtlqxG16HqrTFLN8DCMl8xDYoVCm9jRsVRicl1pZM/pPq5AlUU+GzSmc/tZ5RfPSDQw8xRERmS9XAHxPjx3i/b9uGig33zFWspc7Z0Rzm0Uxb9tqrH2dMX3LbSRPmkx5CC9Ejm1+EwIQ/Lmu8Yh8oGmdV4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4149.namprd04.prod.outlook.com (20.176.250.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Mon, 28 Oct 2019 07:38:05 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 07:38:05 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Topic: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Index: AQHVid7kgFRDrsrFkkeJqDNfcuN3xQ==
Date: Mon, 28 Oct 2019 07:38:05 +0000
Message-ID: <BYAPR04MB5749A6D339572EFC0C9C401686660@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191023201715.4236-1-chaitanya.kulkarni@wdc.com>
 <20191024020003.GA2148@redsun51.ssa.fujisawa.hgst.com>
 <FA6B6A9F-649B-4B58-99D0-2D09076E2482@onestopsystems.com>
 <20191025040540.GA19941@redsun51.ssa.fujisawa.hgst.com>
 <20191025042658.GB19941@redsun51.ssa.fujisawa.hgst.com>
 <109617B2-CC73-4CDE-B97A-FDDB12CD22BD@onestopsystems.com>
 <20191027150330.GA5843@lst.de>
 <20191028005517.GA6693@redsun51.ssa.fujisawa.hgst.com>
 <BYAPR04MB57491F5ED34EEE047D86C2D186660@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20191028073545.GA20427@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dab22dfc-f2b1-4c2d-7a7b-08d75b79c51a
x-ms-traffictypediagnostic: BYAPR04MB4149:
x-microsoft-antispam-prvs: <BYAPR04MB4149A7732F12AB762ED7EEC586660@BYAPR04MB4149.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(33656002)(66066001)(64756008)(66556008)(66476007)(26005)(55016002)(446003)(4744005)(66946007)(5640700003)(4326008)(6246003)(186003)(6436002)(6116002)(6916009)(478600001)(25786009)(76116006)(66446008)(3846002)(14454004)(316002)(54906003)(229853002)(7736002)(305945005)(9686003)(6506007)(74316002)(476003)(7696005)(486006)(2906002)(256004)(5660300002)(99286004)(71190400001)(71200400001)(2351001)(53546011)(76176011)(81166006)(81156014)(102836004)(52536014)(1730700003)(8676002)(8936002)(86362001)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4149;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lfm9IBFPhGs628cgYHlqTka9syjWKqAvowhmezYnTHzVrs2YgjYEyIZIDsNVmazYXswzGlDoqBNSeby+kXIPIlSmMPz17OteCHaGOF+Bbftr9CXVpH2OgcOSnjO1Br8CFoSk0ZjDppWXeiDV7j/f+s5ljRXF5ogqNbFkLZ3RjfHjbxBN1WdrxrWa+YPKEGQETxerKZwgN0VQOMUOGkUdKO7VSAaXRfy8swvCgZ6ZKobTUOZk3PpCekMDWBZHYO8xFaGBEX5Z2tCvXDqdLfd0pYjv4lLAEcCiqQw+ZkCcCWgWg7XT8h+gETG+RVWpvr8Vvzpt7Vg0mnic0p42rN9RvrBz1LmS4i87DqCf1A/eIMlzKaS2BrZnC5v4mNpUnzduGFSy8BWoCfIU3DRg57DG6Bhzf8HchCtu5hI9vqw+i7O4L2OnpWnsLRY4PMV1cFY
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab22dfc-f2b1-4c2d-7a7b-08d75b79c51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 07:38:05.0542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rwQInKORWUdRXNwDT4BkfAbCnkGIHF9SeghkVle2kLLz4O3D70mnZFiKg2NeT/UigY+oKDOvlBzovEvUGs8+oGbQtCigkHBgjibugniTRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4149
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191028_003809_920565_8EBC6AA3 
X-CRM114-Status: UNSURE (   8.51  )
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
Cc: Keith Busch <kbusch@kernel.org>, Mark Ruijter <MRuijter@onestopsystems.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/28/19 12:35 AM, hch@lst.de wrote:
> On Mon, Oct 28, 2019 at 07:32:45AM +0000, Chaitanya Kulkarni wrote:
>> Just did a quick test with following patch on the top of
>> plug patch :-
> 
> Yes, that change makes total sense - in fact Keith also mentioned I
> placed the finish_plug incorrectly.
> 

Do you want me to send a new plug patch with updated patch
description and performance numbers keeping you original
author ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
