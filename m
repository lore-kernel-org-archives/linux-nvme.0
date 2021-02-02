Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE3DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:03:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D869A64ECE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D869A64ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=pdsd/QGsUZBxvg0mZAYj+R/TP/J/ijj7jaz9W8d94ZQ=; b=z4zEg4d0dlNcDILJFNopHLeO0
	A7YS2SeYZB9CpYzIWL7q2fX+xxL+1kvYGO+dA+M3MR/wmZgCaTMqn5ZbgDeYv0fHQ756N74kbob/X
	m7e/UaUKqUG77+zd8hFnsJOxOR53qvzh3Z4KUulVCyOlLa2AVTCttPNZtM96ACDevEBCOZpkdyp8I
	P9+kg6dZ6AUKTyb9ALRkfcJjxlg0qufX6Rr8pRXXo3NGH9qlCJDW6lHVaer2NiwxeG2vp4g40K8Yp
	KTd0PgLnXFMJmADZkjpMwulvdTKByrn9fME24ETMqy6EMJf6lDz+dqPoYO2wJDXG+8AyaJVKsWEJ3
	NHFA6nYog==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6jA9-0004Lk-Na; Tue, 02 Feb 2021 00:03:21 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6jA7-0004LF-W6
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 00:03:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612224939; x=1643760939;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5ejZP42GGqabrZzxwduT29k6h+nEnezHY/XdsuK6IPY=;
 b=rFWdwx+30PEf90Td9eJNfPFmIDD3Guv440dCyI++DZACgaxktzMX0OXW
 NSoBQPSRYQU/2MGhDu/geKxhdziDQCsp+mNF++xPJ1mdmpOx5e0udOjAp
 UqVYg0RQKjbu3ndEy12C+wgtCJAMeTEldjvrMbUE+z+/2xM632Ou/xwnt
 gbYckwa5PY+mRG7Fa2MtjgTJWnZwib5IQeMA9PYQVI3lTfVMchPYiSWB5
 LrsDqyC12c0i+kecjWXbaHZ3EOYP63i/TeRLyzChbewDDNu9ukwE5+lRF
 z5LS7Xu8AE0QL9xtgCqBe9+KaTbBg/UPbMldsYkxAuvDnn25sqHPtBhyA w==;
IronPort-SDR: O8TFV7ztpyJcslBMh7rQyUnDeGJJ5N6BvBqj6KmfvsHaHOLWfqV2IO+Y4Boymeqb1YRsewzlYx
 ke/B/IgRxC5njSq5vo/O7oioXiqo2q6YjGQnjl6Ib1kSYmyvac7r7gMxlcJLuQTdeT3hYzI1AQ
 XMLmdOCWqQpt24ddTbbY0gUO89AnDFYH/u/GHA5Avu7OLfPkUIDIr9JvdZWAHckFFhnl09Z7mW
 vDX73dW9pUSegckI4EIgR75g1GnY51XlBKrrwpr0GQnk0q1LfKdzjglC2lRLeb9kt0N2Z+f8x/
 mCQ=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; d="scan'208";a="262935251"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 08:15:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niauH4uNkwUuKbOwdBHqDMEy6oVgw4z36v+8UwufkEaStFtfnHdBH/1E8QOE0+iIcqfE6A/FFpwwdKMknxCtwsSDCg0Xpkirl3F7K6IsLFayPiCjDtsxfl8n99CRjrgkLjbKmFqXLpJMScEqQ3H9eIxF7Wa2RKu1IGADJ9t7LXa6yhLvF4Z3FpLoTdriCFqsE+kPSC90hejapWwJpOnsx9jH2eC5tLB90f6NtRSjSOs+lCJKb3wU44JZXAZ81Muitm9E5HbITcRVHSCzMvm7QpjyPNLCb2RrC4FEetXF2muZMhKPAFWUBZE2QqTFbrafdfw8q1nLvDhvKdICrMIPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ejZP42GGqabrZzxwduT29k6h+nEnezHY/XdsuK6IPY=;
 b=hQHD/rs6fjz71sXp7kOwSUVdi1QI02QkuBR6FcIyUTMTYuODmzetaW89/X9EzfAL/I5EvG/EmSzlVtm0fgueJmDEfLzVk4bcvl8Qiz6rXFfzQsy1WaTJMXwAIwUC4Oz8K5Lq882ieFWp25vRRK0E8ueJoSuM6iou+L0lbwXRAObfkvSMMZECAr1sDz1dJiumYImwkLL73XaDcSVFvZOirJeD12ARIwlZfvtD/d66DYSMJK22PrGPRWM5ApO/KkkP3UJoJi2UKfFBIPybn3+DeDbPLNLVHCcuJewtINVyvzFrPIFGxwRA4t6q6BBBwSPc/1I/eaEskTxnzDsHRTaz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ejZP42GGqabrZzxwduT29k6h+nEnezHY/XdsuK6IPY=;
 b=waIXY6uWI4BWfccgAHkcmoRb3ylAeFmtR1ECmvQmiH4jJh0DVqMtpwE/iXwschsI9Ycz61aQEDrPpyGPVgwApauwCw11RLrhrM3137EZrLkmV9nKAMf1SA132w85pStUnKANvhzwkwB50PXQpUyxPMsyfkZk92zBBRx6jo+UC7A=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5527.namprd04.prod.outlook.com (2603:10b6:a03:e3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 00:03:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 00:03:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmetcli documentation: fix typo
Thread-Topic: [PATCH] nvmetcli documentation: fix typo
Thread-Index: AQHW+KpLw+IjdOjXMUykvcWmV7fb+Q==
Date: Tue, 2 Feb 2021 00:03:17 +0000
Message-ID: <BYAPR04MB49658DDB7011AD1A1F9E6C9886B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201144756.37538-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3c951cc-221f-43fd-3fe8-08d8c70df1a4
x-ms-traffictypediagnostic: BYAPR04MB5527:
x-microsoft-antispam-prvs: <BYAPR04MB5527622D8477EB384740E38386B59@BYAPR04MB5527.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CApZsHtz/Cf/n47vYdiPWVNaku6O2S5Cp1u+U8tkK7Va0g0pdcOFHWF2tZsJM/f1b99w3jgvKONoOCMuupaZMhH3wOWLAljdIGFFAXZXFOKiYdUrasd6nWspriXAd0PiT8cOKfWILT4YU/S5jDA1TuFlHpgJPihb3jKsEBnCYwSonxVB8hd7Hx5gXdqmZ4MTEt9Dy0qWciWr3sq8/RR9NIOb1zG1B5F42zA+mu5F9zcbj4NJn60KFTAXuTcz8nG6scmVyR2XUBV9l5uzVSOPbwLWOf0PS7JEhh89XXnhj5Kpb3L/RwtC2Ov8d8mLGj03ucNM+Xw4foMR2edS7OtfMy/ymZjPZQzxhkzg8bXwDQlLUDRqvOirjSH+h38Ft7ALDcZF+AZUdU6JX0T6kb/pGpN0wwmzh3ofmYZLVGw1YleaK1jlLcF3/fIDlv/lDBtjlnR7D7rX2faTu8HEWjwDsOsdQk0dNDpKc/uquieBz1CAxd9Lff9YIzXikGDmU9BgDoodUpRkbW0uI5fgq2IadA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(86362001)(53546011)(52536014)(186003)(6506007)(26005)(2906002)(5660300002)(71200400001)(7696005)(8936002)(4326008)(478600001)(8676002)(66446008)(558084003)(9686003)(66476007)(66946007)(64756008)(76116006)(110136005)(91956017)(316002)(55016002)(33656002)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YPXFWz6Qin2TAL1taBsNWxc/9Gp6Zomzv0VYgCDEhb3P9MMn1npk0tNby1tW?=
 =?us-ascii?Q?IyApYfTBMZueVp30gFIBI0iSU8wU//3kVgaWXZ9Bfn33BYwfEPZJCxKCiwYr?=
 =?us-ascii?Q?KIR0g5eJL9ki1rBbxBzeSh1wuxtpTZsP+1dvqeNvdcH/o1ofDi2jrn20oyZS?=
 =?us-ascii?Q?LSs+gBkd+EHIJPKITLa9NkNTLpJij2p1v2E26MAQzBuLTwbSfbJ39y0s/RBx?=
 =?us-ascii?Q?4d4my9gymLrcT2nGuWYkbHyWVikHbuSv5JQseflj9etjjVZ4hjt1DPg9ODSx?=
 =?us-ascii?Q?OviTINVNWrTBMPgLvwE6LyweRWk7DR9CW5JhbQP51+zECeAvZWenMmNgC7BD?=
 =?us-ascii?Q?hV08bUX2fHBUGnTq3L6Si47G5+gB0vvz95M4tOdT3Obh75mRt3ve2yfdfH4V?=
 =?us-ascii?Q?SlcI8zo1KjoBHQURZQcUzZUPeV7Z5YpnRevib17o6cCzfsTZ9p/w3cpNvLiB?=
 =?us-ascii?Q?tBjyXJ7yobo+cAiYPy5Ao+3XNDVDcFGQXr6Vao2TuH790rEWIE0z9PWxaPz3?=
 =?us-ascii?Q?0yNX9oJbFE8/lRyswdu7yA1R50IZAc6vPE9uDqPWdi6mplRBYrsAngY4z9TQ?=
 =?us-ascii?Q?Yodd6IN87DPIodvFO32uZ6llUfWPF/g2pv9lb2gjztYW+czjpNd372ZcGIrd?=
 =?us-ascii?Q?bK4NMEMrwl8DPp+P53HTy4GRnKDu+/08uST18AJ0YR8JbQ4UMMMIfD8kIEni?=
 =?us-ascii?Q?qduGDhob4Bdq4YrIw9DEtimZQFO1wmXFT5Tioy2B082oekBNbhHAainRDD2K?=
 =?us-ascii?Q?/Mzq9jwJDGAW/EmnBdWlrGhoCpvu7k8yLk49UAvW8+yHoQfpU/QGU+RyyP+V?=
 =?us-ascii?Q?w2LllRbB61mQ1Kgodb1tS7inK3F3mEN5KXhsd71pPtF/VbC+IWYOdz2VtjBq?=
 =?us-ascii?Q?Ab+T1UVCfAWFYzZXCdKLEdrS1Ni5F9lx+74srrOQ5hEK9jQXMXY68i7p82s6?=
 =?us-ascii?Q?WI4iftS9pL3DaY74gQnf6UbfGVCmE1etqkZJ3jjtznlYnFyRytEcP5+mYSxk?=
 =?us-ascii?Q?RNd51gRFusFymprDNZOWI9779QKONVym12xQkiQWNMAv9H4+7f0mJeumsAC4?=
 =?us-ascii?Q?HpGeRLW3SIbX6ixKzPYCiDtIvkwg8Q=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c951cc-221f-43fd-3fe8-08d8c70df1a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 00:03:17.4251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xe4sozuYkkipTZqCo/SaiNhmUXnt1pzNHOcxX/b1VIIjvR2bzlBvgWrzCzEesNCAGga6U5kaFcaeRQ1znxoChlVWtot9TbSFLALNyBT5Wkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5527
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_190320_193125_33046025 
X-CRM114-Status: UNSURE (   8.66  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/1/21 06:55, Maurizio Lombardi wrote:
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
