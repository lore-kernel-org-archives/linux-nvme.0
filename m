Return-Path: <SRS0=bzk4=OV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51868C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 13:56:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3417619EE
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 13:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3417619EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ik7WUjRJ1oAhj3g6wr4pWP3dAdNeJbl844z3LWFH638=; b=2sJePae4iJB14z
	6szxHj9sZeXa2jQxOX5kZLtNsRje8YyTWV+jny2TyVxtjvSkP8TqTj11XcGl1Dtw+APOcul8l+QGg
	iagPeP2JIjo3DW24y6b4r8+uCXga6lbTNGny5ej2LSkXX0kNyq6eobaAcQprNL+CldnQPT7kQKEuH
	Gog6phowNo2hra1/tXBiVgVya5+RqzOHaQTFicYvfjuF2wirKs58uc9g8X+X1E+HkNeeG0gayp0ZQ
	vA/GDpOvlwhy2JlwARR+kN/kWyVWchSAoPRMFMrgmAAI27spmBNhMK7bV/L1AJjtIN303s9A6qIB8
	JD6wPs+Uq/WB5w6OxseA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWJ0z-000Spu-NX; Fri, 01 Oct 2021 13:55:53 +0000
Received: from mail-dm6nam10olkn2054.outbound.protection.outlook.com
 ([40.92.41.54] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWJ0w-000SpJ-UV
 for linux-nvme@lists.infradead.org; Fri, 01 Oct 2021 13:55:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtvV7BIZwQgihiLKFFjnW+ghmL/X2rSaXPyCs4dc4HzGdQIOL611zEPjk+0zHvKJIPDkvgZbtjBbT5pigX/5SwXFABStcjvlxW5P4N5GhyIk7nVI9755KnjvNUIXcyx8PodgutXsDTAD+7e2vAOM+gPZV5PHv7anVHNfpM/oSSNwbhp77XX/BIz1lxXmvDfAr9o3VA/beWyCWLWWUqwzFkB1Y+FhzMCyJJPtyrsRi5V6CC2MRcGfW5IWeap9tkM9PlsB3FgUrZMw4voE9/s4S3ZSJeJaj+jN7vr6Yl1qtTHKRl/iYkTs6oyuiaV1hLZ3FPQx+mztw40dEGFp8eoJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn9E9GF0fxoqLIBFdoY2c70FGoWJMDTr5T/q8zkPvdI=;
 b=eMXqDua4MkwFSWjWYfJM1SJp2aNg//Iv9WFkbbOnx2MH5N1/tISSJNbk31jRFjfaWStwT8MijR8QttT1EHbPFjHAD7NiUTFoDu4EBx12pbZ/dmcQnsi8mM6fsCI+63ocOMo/oUNurkj4/M8k7Iq/mHkspvHqIAPdVYxh7vhWEwyts857SeF2g2DJjUkTQJNE4WIDXmVJ7A9qFTXo6IdIY/WMOlePwcqLulH9ZvfKwXWlEp458jJweOGUXEFHUciU5wv84lXbfNMyn2ZaEGtWFfMEifWBz1qNepXeh6tgG3AJ0Knue3bTwZAondzK0ZTak8f3ko7jRO1mpespwi48hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn9E9GF0fxoqLIBFdoY2c70FGoWJMDTr5T/q8zkPvdI=;
 b=IkfT+XTKtAzt9329/mICJseOkgTaI6eNO/jLTnzTf+QnxbebKCEft5LYo9eJr4cAGIZnIy6c2sldfJM9Okb0EALBIpLs8g/3RKWlvJTfBVYfo+hVbhHffrEa9FRA+5CuMQVD9HKoG/LlJMSG/TE00VO9rw4+NqXpe70M6aWWjO6jZVQtzq120/vMGa/8dAOckPLXENCE8JSwZEpUYDvnjj7wHSz/ABQ7aP+Q25Awj18Qx8JT+J2LW752ZE+HMnM60QYhThWdz5q4PLYMxx6kKKX+hty8ie/ReX7V9fgSRLV15eVPiMSBaFeuQfgNqwgLEVzpzgJZQ0IYch0vdzNQbQ==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3648.namprd13.prod.outlook.com (2603:10b6:208:1e8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.12; Fri, 1 Oct
 2021 13:55:48 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::b504:e6a9:7b77:e348]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::b504:e6a9:7b77:e348%7]) with mapi id 15.20.4587.009; Fri, 1 Oct 2021
 13:55:48 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Martin
 Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH] nvme-fabrics: Use shutdown timeout on disconnect
Thread-Topic: [PATCH] nvme-fabrics: Use shutdown timeout on disconnect
Thread-Index: AQHXtgtzpGUDjsGdgUCq1Qf0g6p5SKu9/iIAgAAqgpo=
Date: Fri, 1 Oct 2021 13:55:48 +0000
Message-ID: <BL0PR13MB42917F29A038398392FECB4A9CAB9@BL0PR13MB4291.namprd13.prod.outlook.com>
References: <BL0PR13MB42919DA26E7A75E9219F62DF9CAA9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20211001111142.cpergy5bcleywv72@carbon.lan>
In-Reply-To: <20211001111142.cpergy5bcleywv72@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 1cff4bc1-79df-b931-e591-232ca0e384dd
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [+nPpysPHTdFSJ76iMQycTRs80UVg3Pzz]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77c44d9d-895f-44e1-6689-08d984e32c56
x-ms-traffictypediagnostic: MN2PR13MB3648:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PYpluSiBtUMQKEs0DYUzeDouPUiGHdbZkI8Aioiuny4I2eQMTu57YLH9dm5AgQab03dBrcDsiJPlPxdChT0Zdon2ZsO3q4HF54BBOsYwcnNLs+eSNIBc2nLaVFkgfMix+ObFqWlilkbzhASj5c/NMdOGJrOYo1gej4mV2eaiZNm+GzVAWLgvIzygWYwEw8x46v8EJ6/jQGILomwChgmJ6DwwXbZnWYuFc4Z7+MfvYSNXun04l6QZTq7UxtBbzZcr37i+rVivlqhEBJzAk7se+sVWV7WE1sKJt18jzn4PP53torGygPLdUukPU46aQXGqXNnOhYMVaYv7hidEPgVK0niMCLCt3iv/XKNbvUYeNmyYv7Zn71r4riS3QmyAQpp2NZ+XoE/dvx0r+GeaOfwgF3sEioc/Ci/t/Psz1yl9dI4WoS7uDjZYt3+ktYjcoKPc
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: RTQZjH2EWkFHpprCeNtAZ/Yg0n2rfTQS1ZPVJvHMfVaQ4T3+cBn3FjL5B5/ANcub8u/QGA3nUAETjvQd0KHVvKhktcNHC1LC44qGNVMZF593vgBjIGQRKa9AJwzlFlZo9F3kbU2Qqr0CJlPDnPtf9g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c44d9d-895f-44e1-6689-08d984e32c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 13:55:48.5008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3648
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211001_065551_095439_08756B1B 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Daniel Wagner <dwagner@suse.de>
Sent: Friday, October 1, 2021 7:11 AM
To: Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org <linux-nvme@lists.infradead.org>; kbusch=
@kernel.org <kbusch@kernel.org>; axboe@fb.com <axboe@fb.com>; hch@lst.de <h=
ch@lst.de>; sagi@grimberg.me <sagi@grimberg.me>; Martin Belanger <martin.be=
langer@dell.com>
Subject: Re: [PATCH] nvme-fabrics: Use shutdown timeout on disconnect =

=A0
On Thu, Sep 30, 2021 at 10:56:34AM -0400, Martin Belanger wrote:
> @@ -244,8 +257,8 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off,=
 u32 val)
>=A0=A0=A0=A0=A0=A0=A0 cmd.prop_set.offset =3D cpu_to_le32(off);
>=A0=A0=A0=A0=A0=A0=A0 cmd.prop_set.value =3D cpu_to_le64(val);
>=A0 =

> -=A0=A0=A0=A0 ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL,=
 NULL, 0, 0,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NVME_QID_AN=
Y, 0, 0);
> +=A0=A0=A0=A0 ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL,=
 NULL, 0,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 timeout, NVME_QID_ANY, 0, 0);

If I am not mistaken nvmf_connect_io_queue() suffers from the same
problem.

What I'm trying to fix is the timeout when disconnecting. The disconnect ti=
meout should be short so that we don't get blocked for 1 minute. nvmf_conne=
ct_io_queue() is used when establishing a connection, in which case we do w=
ant to use the default (longer) timeout.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
