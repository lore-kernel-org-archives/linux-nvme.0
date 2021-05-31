Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EED7C47080
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 11:09:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87BE61287
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 11:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87BE61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lFSP3Pt78n8GwaSfPt0DS34+T2vydUWnsUtgBK0+Eis=; b=A3TMfOGdEXmHFq
	uvYXZnmOlPqEgoaU/7y3JcW300iCKVFJOj2lxVPMTwRcYv14HuzD4kzJ6zfKKYj5QTxIC/JMlq5O8
	LDBJVY1a9+sGirFxbuU0hu68lyNf+liOub80QNioj7iOxebR+99mAogbZU3zNEKs807vrNUFx72La
	CmZY4DLyLvXS1K0zrQcF6UoTq80NXgs/s7jPdWO14V1dW+VWZUPUQXWR5oWFpLLeY6sGWKh4G/y2A
	+/g//DZppRRBWNQ5DbY0Fl3xFhjvY1k0wJhfiFb3SDvRBRv7agjFjtAhASBmekFdlgoECxbRgmswp
	Qd6gQ8kzAnJuePkkCbnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnfnj-00BvQk-47; Mon, 31 May 2021 11:09:43 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnfnf-00BvQK-Nh
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 11:09:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622459379; x=1653995379;
 h=from:to:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=0eNeW4VSLL9eW3BCDzwUmpBRSHJmIBi0VIUwyWRFeSo=;
 b=AeqqOjnDMu8Qk9X3wiW4feQbUOHT2tFolTMT0LlWRrVsFCXZrMQCBoWx
 A55P8IljTaPWYZLfFIrAzL/wt3+zyN6bNxgIz7VPh13npyXX2/pjgPvxt
 SMnjm62SxEFmxS9YZD9RsW+bMitph9fqzywY778gcEMgIOCHTfQrIzui2
 gYFfOBNXjZ/EgNfhiEUZqN/K0ml5ySEIrrkUce9sAlEU+WustOgM/yKIu
 /BZmNgs8MvfDqlE1e/YNgp3AcnCJuYrCfH0D3aC4TpYc7cms49NJDWCMD
 tDrcOwHZZWXGkDHN03Q7DqEEnpDlLtPNRuCc5rcQwRxP0rqnY65XOz0QT A==;
IronPort-SDR: zKFkNHS494bGUJ5O9w5Au8a8zb/SEHrtu1sCh8S4DeP+PCGTZ5r/YE7yr5IOLdSUO0s6J1aWFG
 yov0KaguzaxANK4+icY4/CFw2pLENI4c1QcoksYnP8XrrbFBo8htP93/14jI7bb9sQe057H2dy
 p1TFWR7Mw5fG3EewTjDK4/2p8T98FUdVQ+pUziwkros4AZmWLWxCidonpkjys3zftWgDczDIHh
 2JakH+yFk4RD9OifeaUOl4ykuEFX/ZtvwlL2SZc6rz+3eKEKFYzi+zDAUNb4RRvmqOEHr4TfC0
 tQY=
X-IronPort-AV: E=Sophos;i="5.83,236,1616428800"; d="scan'208";a="281516044"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 31 May 2021 19:09:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WibT+blsZCITMMgGIyoFPHOK/zN7varqneqxNlCyvaESC7a1qBvJ1aczxZZXldhOnNWhpnj4+QKj8KlDIQoP9nwxOV6qNVY1T3BnISeUFm1jOLUre67ACC9f9D0wFWk3/2QBmUZv66i40TSPlWaC94A2dCOf6oIN1P1HUySRlYsbZvzRQX8VKKhk4XwfPV4MdMKY28pgx7aZ5Ebn3Cyd/7ddHEM9Fh9aAgqHeydiAfU87sQe+1p5RhMTQnrqpAoi9EfjIfB+ER1C+ynFpIBLi9heYCPix82x4AXjW475iPU6UZ3LhvG/2y78ZHdUB86CwDVUSs1s25EA6fs04xFvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eNeW4VSLL9eW3BCDzwUmpBRSHJmIBi0VIUwyWRFeSo=;
 b=Bt0Datpayqwyg+/BKlRI4pPdkOt07vgF28pDk9YzdI7Re3xh4r02296vf6YI/0ota1qh31eOJOfZo5GvhIRHOgG5xt+V4e0VcjGCrSuXgAOfP+4jyJW/HbV1oC7VAGiU+OKPQIN0dPf3c+Qlycp1MFqKceMWwJOurwhjUHB6G9xEpoCpwDoenCjDX7yRxsPQCyU3GruOeBOCPtduzJNku2HTuUAg0B2sA51/9/uQXVny506ZQmEXHNBIL626eu2EUVeHfLdWZTaI37qiEBuLDa20xb3u4KpTXxefxDb3yltgi9uY+6qasl5yfAjYzhvIBBl6HCUOFVC7a8SjPRtjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eNeW4VSLL9eW3BCDzwUmpBRSHJmIBi0VIUwyWRFeSo=;
 b=SPI27nmPoTBdpm+p5QquVm9DjZRdlY69839yfe1xeiyyWzEOCXGtXmPUGmPSx1+WVpj99pFKxA+7L4YxOsRaB2HTCno8wZLVShTeSCkzJ/B5Djca9N77VKQbh183YLvUwh+TlsfjUJjchakQFHFiCtf83XCK8BOwTo7jI3FnLkY=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7640.namprd04.prod.outlook.com (2603:10b6:510:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 11:09:35 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 11:09:35 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: NVME_IOCTL_SUBMIT_IO access control
Thread-Topic: NVME_IOCTL_SUBMIT_IO access control
Thread-Index: AQHXVg1wiuJ99YXz7kOV/ZWcdShpSg==
Date: Mon, 31 May 2021 11:09:35 +0000
Message-ID: <YLTD7gcSIiNRJvGX@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a80c615c-8822-4bba-6d8b-08d924249343
x-ms-traffictypediagnostic: PH0PR04MB7640:
x-microsoft-antispam-prvs: <PH0PR04MB7640CEF71C282A8115DFB2A5F23F9@PH0PR04MB7640.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p3i/DFvXFoKSprLd/NYuM+yJesf094YS6DWGg0E7VprYFMlJS8PPyl2TyvVNsF7/pz4V3Fpm+eTWiG96PeVB5oDHloaC8/nfdDaWxiEq9DGzVLnZDgvWRbeXqwkxIb+qlS0ki47biVabUOTbjFvsGrci1XPN/4rvedOYVFnw4lrDAk/6bamPG5aAWF0m0J9VXm8ueT2N3rNaJkskGQ+YmHpuaMXKq3VrifPif5I2g1OTkrRA59FSkmCUyoJ7IS45BKe0oMsCYmoKK2fFwdRmsNSvbl2mP4CAEeL8s8r9FT4F2i5JO4B7n11RJsjIlfJUrfJsJG0EKHFayqe2yB51SgvogFe6IOP4gkuEWn/1MVRMPvJUFj9piRXTFNPG7RwZC+Opqe6Q8VZDhxKz75dt+41tjOPFYxf19/jOq/hPWAR3aE7jVPMzMUKrLallCijr7U2oapSwpIzh2fuuoq2y8hipGmafKkyHYUw9ppYw3u7b6h5841T1ESxdkyG6REegECoY5F5T2q2numb4sIAkCwmD5PpxWn+QQGN3Wmneas5/AZuTJijl/kCAPuzBmdH3a4+fauX2KUSjSQqOXN2u45JCLqDyxowU2zNobSEsjJU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(396003)(346002)(39860400002)(376002)(366004)(136003)(316002)(6512007)(9686003)(76116006)(6916009)(71200400001)(86362001)(8676002)(66446008)(64756008)(66476007)(66946007)(2906002)(91956017)(6506007)(26005)(186003)(66556008)(6486002)(33716001)(7116003)(5660300002)(8936002)(122000001)(38100700002)(4744005)(83380400001)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EvmrmbD4JzM/rrkcRLUUKvcD1Ye3/M1EDfyGR5minT6+XazCsd0Hs0ZMiGTI?=
 =?us-ascii?Q?/Cz6GV0ci0SsFzVsjDZUUnatnqVCLD3FteXjax8KWDAUXuKpHetpjxUtSee/?=
 =?us-ascii?Q?MzlhAT/+oKlPQNy3rLoo4JPINYq61MG66lu5NQJd4iCvD5z07HUVMet2VdKM?=
 =?us-ascii?Q?tFullBdb8tA4f67r66dcGh+arLraslaXyPOetP8+GO8w2NCqjNb5kuKNq+0S?=
 =?us-ascii?Q?jddorWbUuhGVTwJuIoqH9hFtXFma2Kde/Y3C1qj2QywW5/UQSvVnx2WQES1p?=
 =?us-ascii?Q?5tkFfG9+NlPWcxuDYUeMoy/A/3bHEIE4RAWGiBez7EtJQEhReFVRlUZCLYby?=
 =?us-ascii?Q?pKesHSFiAG5l6iJg7BJJa8ypduwCBcHDLnS4Mu+RuG+QXrcsypnBhDZpoG93?=
 =?us-ascii?Q?gj+5eiLFvJ8VMiBG8x8rvBtPTHOM+foy0l10DnBnup3La4go8vaMw0qqn1a0?=
 =?us-ascii?Q?4sDDEKZjeQCvpg0KBc4wtfyG446Jj9f7Li+J2C+m72MxLoxaudA/kUQ1PxPw?=
 =?us-ascii?Q?KsZ3mIuq/wS395/hA911PjoJ8xhgZ9iLfu5kfGkjThiP6NMUQMCK+2hUIuyI?=
 =?us-ascii?Q?QmjiAP4C1tGW5q77CPqhj8JC8ourvClCMfUgsJu4D5wVZzyxVJKgTTvlN2BV?=
 =?us-ascii?Q?GkkDdx+OT2826hXFOZA/iXFyHS2AWaUmCemVgR+Ug/MNapeiAZIv7F1u8OMl?=
 =?us-ascii?Q?8o3lOcFOnm5bEe7uV9qJglDaN+fgJASYLhUBF8wMadv8yePgEWDoZ6Q0uTR3?=
 =?us-ascii?Q?96uB7n0jVusBYZjbQveMAEyt3ovC8a9pv1K4EenWAWV3pFLMbh+voZrlYkkq?=
 =?us-ascii?Q?ZoqO5CuuXmNil3opIrzBVQLS4gvhEVAQB1rYjH+NilhCrIX44fEmM+W+Okeb?=
 =?us-ascii?Q?6cogHJnJ6p/OfzWCQIrFeifoPDenAPs1qa25ydtVUeHmPZT3dSuRDtXzZcJE?=
 =?us-ascii?Q?95ECRX5s3DHjME1/Mhda5hvsrDABqvVIG8WV5Tqkz0VTw96rOgK08Ye17Vhg?=
 =?us-ascii?Q?2SFdOrXVCUzncQFT7AOlPe76R2//BCtPzxr2PQpOtHKRiELOYSISV5mh7Rup?=
 =?us-ascii?Q?zoieSZzJIuUqA6WfuJLrVFY43fw1aPrkKhV/pKqzCy2JlWUtIYc3b7/qsKJK?=
 =?us-ascii?Q?8JQCk/oaoYOATrbzdNFR7XmWztNMi3hWya3gjRfMJYdt6yJxwTYYicfhe22B?=
 =?us-ascii?Q?MbM1SmIgY6iWkvDMzB2vcRLbBCJLW6E9vHFRmZWB9krs/Eyiu3BAjBEFPrkO?=
 =?us-ascii?Q?2ACMhrrKSwBRyZztzaGjN70iT5T4+Gm8YqFezsbguHY6fduXdncQluLOzZKU?=
 =?us-ascii?Q?fX+Geh1uyp9cN3CldbCnZFPQ?=
x-ms-exchange-transport-forked: True
Content-ID: <D1A4FA08420949409A3B200233826B31@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80c615c-8822-4bba-6d8b-08d924249343
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 11:09:35.6264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9o1YuPzJhquFKmgQldf1OcXO5wkZ6mD/t0DRPVeX+rywsqVGFUJFsBKerAdBfua7iC2r9wsySNh2VttMM7E16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7640
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210531_040939_862144_400DF98A 
X-CRM114-Status: GOOD (  10.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello there,

How is the NVME_IOCTL_SUBMIT_IO access control supposed to work?

$ echo "hello" | nvme write /dev/nvme0n1 -s 0 -c 1 -z 512
/dev/nvme0n1: Permission denied

$ sudo chmod o+r /dev/nvme0n1

$ echo "hello" | nvme write /dev/nvme0n1 -s 0 -c 1 -z 512
Rounding data size to fit block count (8192 bytes)
write: Success


Am I supposed to be able to do a write if I only have read permission?

$ ls -al /dev/nvme0n1
brw-rw-r-- 1 root disk 259, 0 May 31 10:59 /dev/nvme0n1


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
