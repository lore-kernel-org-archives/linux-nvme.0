Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CA9C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 13:03:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931F564E08
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 13:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931F564E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r3VvrByXHJfaZ19r+Fmo81BiM7pgo+o899/A8FLqX+c=; b=Whs3xi2KK9J9AGtnHrD/1oppp
	bPFdk/0OLjtTwuJ4TTFmkxbT/W4HCMSoFMcPqKv+eT4PMLWW+w+mvcY1dRHQM9k8EA6MseU42Y7xc
	5p09ad2vwehCn88NyNjnqUwOWTM15JeyZ71fSnQgi2sY62yj+3EOVf5DVCotGiRGhkoOXTmf0UV2F
	fBZ1y/lmnqSdMVlKwGvr29fBIiAzagaspmxYq30jb2WZ6qyf4Jhsd/2AJJMQ8au0InikwMb/6ghTS
	rAGCvgkNUcZjl6Enyg+GRS6IoyTdXZJ+2QR4k+vvvH9jBgqCcWB/E+U4KDW+tqkkgdmrIftn4xUy1
	C03mbxSQw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lABcR-00037b-Pv; Thu, 11 Feb 2021 13:02:51 +0000
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lABcN-00036n-Qt
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 13:02:49 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60252af40000>; Thu, 11 Feb 2021 05:02:44 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 13:02:43 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Feb
 2021 13:02:01 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 11 Feb 2021 13:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gui9pTfqAi/Jn3PwEsUKb+MMZ2HS09BV2AqXEDazp5uXUvP8gpDaIQwHUIsA4kRLx1c/St/n1WSr/ogawOTqC13Qr5p19AGJTVgjyAI8Nqxo28xC/Bokamvd45gza2X/brNJ8zpp2LmoItvCDRDZI/JAx5ogSR7NCUe8dSAijiBMrLp24S1zkfw4Huiy9cv7wG4d+bN6AmRquBbzwLV+ztGuCorFTjhELe/hwObzX3H346gp+SlIkuCybYwnqgNTMP+RsQM0nRNDdAmDu5PJoDNsTc+fhzk8UTS4gH+QtHhEd08DwAs8CwkjquIsE83LYuJaH7Jv0lqqi18iOsR1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXVmrjQBvofql9H/QdCam/ZObY3T4LXOC5iel7jy0RM=;
 b=NEZAr2dTPG8n8CLnoSBnRcUo4LNkYD2plDjo8DJMFjK/DuX4UuhMOCLfK5dLrrh+IBudLLPMmvyBdVHUU+uXJTUbXWech4J9GjKJ3bLqUwMMH2QuLLE/zJzwkQj9OoyCDMiX9noxjeeFsCGKdLMlP9OGjIfH7m/iDnN8RGXnsbC1t9aJhXccjv9RdCB0kUQ7WxPyNIuwzaN3dKZ2qAlVOwSPd9Lpw+plzSYosoevaaCMqZGngDf4vNM40eeFDhBaCyc7pge14jywBOs5fHYkku7S/hjdPQFyshYo5GSIre0kT68EDGTBpqsgaJJ21/BtRDA+iKDNd0KX6DjaIx4YLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3494.namprd12.prod.outlook.com (2603:10b6:a03:ad::28)
 by BYAPR12MB3320.namprd12.prod.outlook.com (2603:10b6:a03:d7::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 11 Feb
 2021 13:01:57 +0000
Received: from BYAPR12MB3494.namprd12.prod.outlook.com
 ([fe80::d1c7:dc40:412d:e16d]) by BYAPR12MB3494.namprd12.prod.outlook.com
 ([fe80::d1c7:dc40:412d:e16d%6]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 13:01:57 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 2/2] nvme: resync header file with common nvme-cli tool
Thread-Topic: [PATCH 2/2] nvme: resync header file with common nvme-cli tool
Thread-Index: AQHW79U2U5OoVr6Ea0CKYk5QvvwVUKo7yT2AgBRBWFCAAAgFgIAC+STQ
Date: Thu, 11 Feb 2021 13:01:56 +0000
Message-ID: <BYAPR12MB34947F0C352E4035BAC258CFDE8C9@BYAPR12MB3494.namprd12.prod.outlook.com>
References: <20210121090948.8027-1-mgurtovoy@nvidia.com>
 <20210121090948.8027-4-mgurtovoy@nvidia.com> <20210127174717.GF28180@lst.de>
 <BYAPR12MB349445BDAFCBD9C9FBC32701DE8E9@BYAPR12MB3494.namprd12.prod.outlook.com>
 <20210209153503.GA8607@lst.de>
In-Reply-To: <20210209153503.GA8607@lst.de>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dcce254-f434-43f7-d469-08d8ce8d3656
x-ms-traffictypediagnostic: BYAPR12MB3320:
x-microsoft-antispam-prvs: <BYAPR12MB332047142ED58A968C744233DE8C9@BYAPR12MB3320.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRbcmxjlDGrLMcmQIPMd0mExGuwZjQy8balj4MMygYYV1glujYy0MUbXsjms5CLtFGkeubx7Qognt92oMbw+A2frX/8enyr5iws0N7FLyd64ZnV05aQtrcenA8MWEb0KqZrFTEQrRyqSOwLRe9zQ/FnA+GDsAJfi2zJn8pYCBDKnbRtdz1+cneeBaLe9NHxSlOiGfGfbo485EsAnZpxlB3p1N2cYP8QyJLM9uBIKcyju7pttJHZMpeKeuzfEPSq/ms/DXNbHXU381/wRw6Vh9NgkX2ZQeoMm22EX+rvspKkKB5dpl5c01vxwapm5WqrBLV6TYSR1bB7KT9v/aK7IzU4i5GtoJxtsiRgWUVPuiqJt/5MMhdkTcabYonN/9MgguKCUETM1yvEWMABkEDqUTp41A7HCTUNxinC5Ayl+9Y7n1b/dcvIh5DJuNVNUPlgcKQ5jArCG8l+HuSa1o45pslE3mjZm22yXDMPE0rz/r2zJFcY4bQrkNOoUUMGz/SYv27f1SLFQ9YiuEDyx5no50g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(55016002)(316002)(66556008)(64756008)(186003)(86362001)(2906002)(7696005)(4326008)(99936003)(83380400001)(478600001)(6916009)(54906003)(66946007)(76116006)(9686003)(6506007)(71200400001)(33656002)(53546011)(4744005)(52536014)(5660300002)(66616009)(8936002)(66446008)(26005)(66476007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HeJXf2ocxd+WNssjk5OKponrjaXmGMowmpT1SMxMjsZ6oa2Xk7tDCs0lGE3U?=
 =?us-ascii?Q?gJJj3ufAh3BL38HOpsV7VNOoaD5IEKdwRsH7brxMhf///kqp33r89CULoTwc?=
 =?us-ascii?Q?PO/Lltiw0juAtXgzwzBDsZOgIERE8NIOuJYwVNlsgWTtchtatIx2wP7bdQSy?=
 =?us-ascii?Q?B/U4OE8jPGMSBGWekaBpM46gPhluS7nqMRUe61RgavxX/j5RpcCWP93GnEhA?=
 =?us-ascii?Q?1xdBGb9M/72Gg3gTiQMM4TTEBS/GB4ey7tHFrUqa9rfGPyZkRDUI5abiq6vA?=
 =?us-ascii?Q?rXLq4Rjuj73T4go23SPHLSw4Xo+xu386vHJ9Xgu0BnpTPx7IrcBAiW9s1K+Q?=
 =?us-ascii?Q?pdbjf3ctcu2J+FCAlBevt1FALsjE398PMJSsZM2E5bt0TpSNrwD0NDTKKkjF?=
 =?us-ascii?Q?xM/dY3XeXhwsvleQyTQrer3C4G5vzkA05oAnolY+gfyUcuX9RVqLIo0kbw3g?=
 =?us-ascii?Q?0aWUQQKPxEkQKWmYs0mBRwMlcYviL/+N3GeDRyhy0HdkDNp7q4jDTP9LAR0h?=
 =?us-ascii?Q?E2hn0eOMMj5FhaNYJ8gjebH2fdkUqfMw/gFny2UzrEN3Yq0ZPK5wiiGPfSzr?=
 =?us-ascii?Q?KfbsuTCrgNP36H/t3zo1nRDTElDP2PwSyTKvXYPect11vOweW+qL+N3uc0yD?=
 =?us-ascii?Q?vmMNb7OFiDCFy5vD+mlkyMVwOjjmcsAMkihtIxIs5MEadC9SJd6M2Ya7FUph?=
 =?us-ascii?Q?yZPI8ndZ2LQcuQbih0JJxiTo0cJCDr48V/pEplQBGAppldNjiiLGVjWLadMU?=
 =?us-ascii?Q?xC+Eouacc7sxoQv3WhPxTlxvJcUlmthVsOnUfCrHhDwHpXghXygIXP7FAflD?=
 =?us-ascii?Q?QR09wffi2y6Bzqk18G19ixnEuNVEY2/fDpAlyZfgBTet+IGGOrFAArvImxgo?=
 =?us-ascii?Q?em3D61CYNhFJagx/aAzR5lgTTiM/fXdYL0VbqQvNFgBfhHgO0CVSGnQNJJvR?=
 =?us-ascii?Q?ATAvUfetMNkk+gR3GCwDI32hc61lAK0miOCpKVgWAxO6t9rpomZRu7kaUXVH?=
 =?us-ascii?Q?lGIKoBvu71CvbuoXJBHbQk1LVgTPUHRy8myKJqEXxCQDdieXCQ1rrrQ4HMSk?=
 =?us-ascii?Q?U/fjRrU4DiNWbPjbNHG3A9QghteWfEKILtB/8fvQoDnsIt7/z9JWLxIeHoGf?=
 =?us-ascii?Q?V0lGIb7zDOmevUE2zJcdWYhqO1gpOaB03bOWoowxmye7Um/M3zbAzAHQDbqC?=
 =?us-ascii?Q?JcIOroGxrF9PwLIkjEnu2AjzmWEIqVll0a/1+ORCSiyeddUW9C3OiuEgXNDJ?=
 =?us-ascii?Q?3oeeaIfsopd/vgajDurhl2IPAfvEKujEimO2oKjKM7htOnF0JvY1nzJjJtOH?=
 =?us-ascii?Q?aERpYcdC8MsaBQTq4MFCMeUp?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
 boundary="_002_BYAPR12MB34947F0C352E4035BAC258CFDE8C9BYAPR12MB3494namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcce254-f434-43f7-d469-08d8ce8d3656
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 13:01:56.9296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3765Ci5FRHZIhkLQOYu8f7BsZYg10BfHwaoVlw7+WHBBJQgC6yuiNBnkYKAZTQSYsdvTYaUt8moZZag8bydjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3320
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1613048564; bh=TETRFmyGjN/LzyQWj3u7GNNG5gwQ2isyCJeA6Khj3hQ=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:x-header:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 x-ms-exchange-transport-forked:Content-Type:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=iNsBCD6ZYnlc063KeB0loMNitVIF7PrgayCBlnydcJk2b5eu1sHDE4GxVMWYpwMds
 ceSxw6uD12BBWrQFMSl8zNT3H0tWLZaiSON05CfHLM+H9XcYV2ab8ln45UAJHOvqHE
 K9DmEIuv4nzpv5BQiiBiH0QLwiWj4kpUwoL1/w2QjEW1nQPDXmdUqm/pIrt7GJ/fhS
 CBObvg4Yv8RV6LYhBdm7ArXs7oyk4rM4e/03hcHi++FSMwtbZb3Yp1/9uk226LeUiJ
 cT5kuwkuV5Xv7xa+XQxbkrm4o2tJI7vRgi+CbIbY7n809ALbSok9Qyd57WW62WvAN2
 j/sD2rpeUMX0g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_080248_110250_9D77E09E 
X-CRM114-Status: GOOD (  17.61  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--_002_BYAPR12MB34947F0C352E4035BAC258CFDE8C9BYAPR12MB3494namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

see attached.

Btw, the nvme-5.12 is not so stable.
I didn't debug it but I couldn't establish rdma/tcp/loop connections.
So the attached was just compiled and not tested.

-----Original Message-----
From: Christoph Hellwig <hch@lst.de>=20
Sent: Tuesday, February 9, 2021 5:35 PM
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>; linux-nvme@lists.infradead.org; sagi@gr=
imberg.me; kbusch@kernel.org; chaitanya.kulkarni@wdc.com
Subject: Re: [PATCH 2/2] nvme: resync header file with common nvme-cli tool

On Tue, Feb 09, 2021 at 03:07:05PM +0000, Max Gurtovoy wrote:
> is this respin still needed ?

Yes.

--_002_BYAPR12MB34947F0C352E4035BAC258CFDE8C9BYAPR12MB3494namp_
Content-Type: application/octet-stream;
	name="0001-nvme-resync-header-file-with-common-nvme-cli-tool.patch"
Content-Description: 0001-nvme-resync-header-file-with-common-nvme-cli-tool.patch
Content-Disposition: attachment;
	filename="0001-nvme-resync-header-file-with-common-nvme-cli-tool.patch";
	size=5814; creation-date="Thu, 11 Feb 2021 12:59:00 GMT";
	modification-date="Thu, 11 Feb 2021 12:59:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlYTg3ODI5YzE2NTJhZTVjMjFhYWU1NjYwNTRlMzE4N2U5ZGQ5MWJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPgpE
YXRlOiBUaHUsIDIxIEphbiAyMDIxIDAwOjE1OjI2ICswMDAwClN1YmplY3Q6IFtQQVRDSCAxLzFd
IG52bWU6IHJlc3luYyBoZWFkZXIgZmlsZSB3aXRoIGNvbW1vbiBudm1lLWNsaSB0b29sCgpJbXBv
cnQgY29uc3RhbnQgZGVmaW5pdGlvbnMgdGhhdCB3ZXJlIGFkZGVkIHRvIG52bWUtY2xpIGFuZCB3
ZXJlIG5vdAphZGRlZCB0byBMaW51eC4gVGhpcyBpcyB0aGUgZmlyc3Qgc3RlcCB0byBhbGlnbiBu
dm1lLmggZmlsZXMgZnJvbSBMaW51eAprZXJuZWwgaW5jbHVkZS9saW51eC9udm1lLmggYW5kIG52
bWUtY2xpIGxpbnV4L252bWUuaC4KClNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0b3ZveSA8bWd1cnRv
dm95QG52aWRpYS5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9udm1lLmggfCA2OSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNTIgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9udm1lLmggYi9pbmNsdWRlL2xpbnV4L252bWUuaAppbmRleCBiMDg3ODdjZDA4ODEu
Ljg5YmE1NjE4YzNmYiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9udm1lLmgKKysrIGIvaW5j
bHVkZS9saW51eC9udm1lLmgKQEAgLTExMywyMSArMTEzLDE2IEBAIGVudW0gewogCU5WTUVfUkVH
X0NNQlNaCT0gMHgwMDNjLAkvKiBDb250cm9sbGVyIE1lbW9yeSBCdWZmZXIgU2l6ZSAqLwogCU5W
TUVfUkVHX0JQSU5GTwk9IDB4MDA0MCwJLyogQm9vdCBQYXJ0aXRpb24gSW5mb3JtYXRpb24gKi8K
IAlOVk1FX1JFR19CUFJTRUwJPSAweDAwNDQsCS8qIEJvb3QgUGFydGl0aW9uIFJlYWQgU2VsZWN0
ICovCi0JTlZNRV9SRUdfQlBNQkwJPSAweDAwNDgsCS8qIEJvb3QgUGFydGl0aW9uIE1lbW9yeSBC
dWZmZXIKLQkJCQkJICogTG9jYXRpb24KLQkJCQkJICovCi0JTlZNRV9SRUdfQ01CTVNDID0gMHgw
MDUwLAkvKiBDb250cm9sbGVyIE1lbW9yeSBCdWZmZXIgTWVtb3J5Ci0JCQkJCSAqIFNwYWNlIENv
bnRyb2wKLQkJCQkJICovCisJTlZNRV9SRUdfQlBNQkwJPSAweDAwNDgsCS8qIEJvb3QgUGFydGl0
aW9uIE1lbW9yeSBCdWZmZXIgTG9jYXRpb24gKi8KKwlOVk1FX1JFR19DTUJNU0MJPSAweDAwNTAs
CS8qIENvbnRyb2xsZXIgTWVtb3J5IEJ1ZmZlciBNZW1vcnkgU3BhY2UgQ29udHJvbCAqLworCU5W
TUVfUkVHX0NNQlNUUwk9IDB4MDA1OCwJLyogQ29udHJvbGxlciBNZW1vcnkgQnVmZmVyIFN0YXR1
cyAqLworCiAJTlZNRV9SRUdfUE1SQ0FQCT0gMHgwZTAwLAkvKiBQZXJzaXN0ZW50IE1lbW9yeSBD
YXBhYmlsaXRpZXMgKi8KIAlOVk1FX1JFR19QTVJDVEwJPSAweDBlMDQsCS8qIFBlcnNpc3RlbnQg
TWVtb3J5IFJlZ2lvbiBDb250cm9sICovCiAJTlZNRV9SRUdfUE1SU1RTCT0gMHgwZTA4LAkvKiBQ
ZXJzaXN0ZW50IE1lbW9yeSBSZWdpb24gU3RhdHVzICovCi0JTlZNRV9SRUdfUE1SRUJTCT0gMHgw
ZTBjLAkvKiBQZXJzaXN0ZW50IE1lbW9yeSBSZWdpb24gRWxhc3RpY2l0eQotCQkJCQkgKiBCdWZm
ZXIgU2l6ZQotCQkJCQkgKi8KLQlOVk1FX1JFR19QTVJTV1RQID0gMHgwZTEwLAkvKiBQZXJzaXN0
ZW50IE1lbW9yeSBSZWdpb24gU3VzdGFpbmVkCi0JCQkJCSAqIFdyaXRlIFRocm91Z2hwdXQKLQkJ
CQkJICovCisJTlZNRV9SRUdfUE1SRUJTCT0gMHgwZTBjLAkvKiBQZXJzaXN0ZW50IE1lbW9yeSBS
ZWdpb24gRWxhc3RpY2l0eSBCdWZmZXIgU2l6ZSAqLworCU5WTUVfUkVHX1BNUlNXVFAgPSAweDBl
MTAsCS8qIFBlcnNpc3RlbnQgTWVtb3J5IFJlZ2lvbiBTdXN0YWluZWQgV3JpdGUgVGhyb3VnaHB1
dCAqLworCU5WTUVfUkVHX1BNUk1TQyA9IDB4MGUxNCwJLyogUGVyc2lzdGVudCBNZW1vcnkgUmVn
aW9uIENvbnRyb2xsZXIgTWVtb3J5IFNwYWNlIENvbnRyb2wgKi8KIAlOVk1FX1JFR19EQlMJPSAw
eDEwMDAsCS8qIFNRIDAgVGFpbCBEb29yYmVsbCAqLwogfTsKIApAQCAtMTQyLDYgKzEzNywxNCBA
QCBlbnVtIHsKIAogI2RlZmluZSBOVk1FX0NNQl9CSVIoY21ibG9jKQkoKGNtYmxvYykgJiAweDcp
CiAjZGVmaW5lIE5WTUVfQ01CX09GU1QoY21ibG9jKQkoKChjbWJsb2MpID4+IDEyKSAmIDB4ZmZm
ZmYpCisjZGVmaW5lIE5WTUVfQ01CX1NaKGNtYnN6KQkoKChjbWJzeikgPj4gMTIpICYgMHhmZmZm
ZikKKyNkZWZpbmUgTlZNRV9DTUJfU1pVKGNtYnN6KQkoKChjbWJzeikgPj4gOCkgJiAweGYpCisK
KyNkZWZpbmUgTlZNRV9DTUJfV0RTKGNtYnN6KQkoKGNtYnN6KSAmIDB4MTApCisjZGVmaW5lIE5W
TUVfQ01CX1JEUyhjbWJzeikJKChjbWJzeikgJiAweDgpCisjZGVmaW5lIE5WTUVfQ01CX0xJU1RT
KGNtYnN6KQkoKGNtYnN6KSAmIDB4NCkKKyNkZWZpbmUgTlZNRV9DTUJfQ1FTKGNtYnN6KQkoKGNt
YnN6KSAmIDB4MikKKyNkZWZpbmUgTlZNRV9DTUJfU1FTKGNtYnN6KQkoKGNtYnN6KSAmIDB4MSkK
IAogZW51bSB7CiAJTlZNRV9DTUJTWl9TUVMJCT0gMSA8PCAwLApAQCAtMjQ0LDcgKzI0NywxMCBA
QCBzdHJ1Y3QgbnZtZV9pZF9jdHJsIHsKIAlfX2xlMzIJCQlydGQzZTsKIAlfX2xlMzIJCQlvYWVz
OwogCV9fbGUzMgkJCWN0cmF0dDsKLQlfX3U4CQkJcnN2ZDEwMFsyOF07CisJX19sZTE2CQkJcnJs
czsKKwlfX3U4CQkJcnN2ZDEwMls5XTsKKwlfX3U4CQkJY250cmx0eXBlOworCWNoYXIJCQlmZ3Vp
ZFsxNl07CiAJX19sZTE2CQkJY3JkdDE7CiAJX19sZTE2CQkJY3JkdDI7CiAJX19sZTE2CQkJY3Jk
dDM7CkBAIC0yNzYsMTIgKzI4MiwxNCBAQCBzdHJ1Y3QgbnZtZV9pZF9jdHJsIHsKIAlfX2xlMzIJ
CQlzYW5pY2FwOwogCV9fbGUzMgkJCWhtbWluZHM7CiAJX19sZTE2CQkJaG1tYXhkOwotCV9fdTgJ
CQlyc3ZkMzM4WzRdOworCV9fbGUxNgkJCW5zZXRpZG1heDsKKwlfX2xlMTYJCQllbmRnaWRtYXg7
CiAJX191OAkJCWFuYXR0OwogCV9fdTgJCQlhbmFjYXA7CiAJX19sZTMyCQkJYW5hZ3JwbWF4Owog
CV9fbGUzMgkJCW5hbmFncnBpZDsKLQlfX3U4CQkJcnN2ZDM1MlsxNjBdOworCV9fbGUzMgkJCXBl
bHM7CisJX191OAkJCXJzdmQzNTZbMTU2XTsKIAlfX3U4CQkJc3FlczsKIAlfX3U4CQkJY3FlczsK
IAlfX2xlMTYJCQltYXhjbWQ7CkBAIC0yOTUsNyArMzAzLDcgQEAgc3RydWN0IG52bWVfaWRfY3Ry
bCB7CiAJX191OAkJCW52c2NjOwogCV9fdTgJCQlud3BjOwogCV9fbGUxNgkJCWFjd3U7Ci0JX191
OAkJCXJzdmQ1MzRbMl07CisJX19sZTE2CQkJb2NmczsKIAlfX2xlMzIJCQlzZ2xzOwogCV9fbGUz
MgkJCW1uYW47CiAJX191OAkJCXJzdmQ1NDRbMjI0XTsKQEAgLTM2OCw3ICszNzYsMTAgQEAgc3Ry
dWN0IG52bWVfaWRfbnMgewogCV9fbGUxNgkJCW5wZGc7CiAJX19sZTE2CQkJbnBkYTsKIAlfX2xl
MTYJCQlub3dzOwotCV9fdTgJCQlyc3ZkNzRbMThdOworCV9fbGUxNgkJCW1zc3JsOworCV9fbGUz
MgkJCW1jbDsKKwlfX3U4CQkJbXNyYzsKKwlfX3U4CQkJcnN2ZDgxWzExXTsKIAlfX2xlMzIJCQlh
bmFncnBpZDsKIAlfX3U4CQkJcnN2ZDk2WzNdOwogCV9fdTgJCQluc2F0dHI7CkBAIC00MTAsOCAr
NDIxLDEwIEBAIGVudW0gewogCU5WTUVfSURfQ05TX0NUUkwJCT0gMHgwMSwKIAlOVk1FX0lEX0NO
U19OU19BQ1RJVkVfTElTVAk9IDB4MDIsCiAJTlZNRV9JRF9DTlNfTlNfREVTQ19MSVNUCT0gMHgw
MywKKwlOVk1FX0lEX0NOU19OVk1TRVRfTElTVAkJPSAweDA0LAogCU5WTUVfSURfQ05TX0NTX05T
CQk9IDB4MDUsCiAJTlZNRV9JRF9DTlNfQ1NfQ1RSTAkJPSAweDA2LAorCU5WTUVfSURfQ05TX0NT
X05TX0FDVElWRV9MSVNUCT0gMHgwNywKIAlOVk1FX0lEX0NOU19OU19QUkVTRU5UX0xJU1QJPSAw
eDEwLAogCU5WTUVfSURfQ05TX05TX1BSRVNFTlQJCT0gMHgxMSwKIAlOVk1FX0lEX0NOU19DVFJM
X05TX0xJU1QJPSAweDEyLApAQCAtNDE5LDYgKzQzMiwxMCBAQCBlbnVtIHsKIAlOVk1FX0lEX0NO
U19TQ05EUllfQ1RSTF9MSVNUCT0gMHgxNSwKIAlOVk1FX0lEX0NOU19OU19HUkFOVUxBUklUWQk9
IDB4MTYsCiAJTlZNRV9JRF9DTlNfVVVJRF9MSVNUCQk9IDB4MTcsCisJTlZNRV9JRF9DTlNfQ1NJ
X05TX1BSRVNFTlRfTElTVAk9IDB4MWEsCisJTlZNRV9JRF9DTlNfQ1NJX05TX1BSRVNFTlQJPSAw
eDFiLAorCU5WTUVfSURfQ05TX0NTSQkJCT0gMHgxYywKKwogfTsKIAogZW51bSB7CkBAIC02Nzks
NiArNjk2LDcgQEAgZW51bSBudm1lX29wY29kZSB7CiAJbnZtZV9jbWRfcmVzdl9yZXBvcnQJPSAw
eDBlLAogCW52bWVfY21kX3Jlc3ZfYWNxdWlyZQk9IDB4MTEsCiAJbnZtZV9jbWRfcmVzdl9yZWxl
YXNlCT0gMHgxNSwKKwludm1lX2NtZF9jb3B5CQk9IDB4MTksCiAJbnZtZV9jbWRfem9uZV9tZ210
X3NlbmQJPSAweDc5LAogCW52bWVfY21kX3pvbmVfbWdtdF9yZWN2CT0gMHg3YSwKIAludm1lX2Nt
ZF96b25lX2FwcGVuZAk9IDB4N2QsCkBAIC0xMDUyLDYgKzEwNzAsNyBAQCBlbnVtIHsKIAlOVk1F
X0ZFQVRfUExNX1dJTkRPVwk9IDB4MTQsCiAJTlZNRV9GRUFUX0hPU1RfQkVIQVZJT1IJPSAweDE2
LAogCU5WTUVfRkVBVF9TQU5JVElaRQk9IDB4MTcsCisJTlZNRV9GRUFUX0lPQ1NfUFJPRklMRQk9
IDB4MTksCiAJTlZNRV9GRUFUX1NXX1BST0dSRVNTCT0gMHg4MCwKIAlOVk1FX0ZFQVRfSE9TVF9J
RAk9IDB4ODEsCiAJTlZNRV9GRUFUX1JFU1ZfTUFTSwk9IDB4ODIsCkBAIC0xMDY4LDkgKzEwODcs
MTQgQEAgZW51bSB7CiAJTlZNRV9MT0dfVEVMRU1FVFJZX0hPU1QgPSAweDA3LAogCU5WTUVfTE9H
X1RFTEVNRVRSWV9DVFJMID0gMHgwOCwKIAlOVk1FX0xPR19FTkRVUkFOQ0VfR1JPVVAgPSAweDA5
LAorCU5WTUVfTE9HX1BSRUxBVF9QRVJfTlZNU0VUCT0gMHgwYSwKKwlOVk1FX0xPR19QUkVMQVRf
RVZFTlRfQUdHCT0gMHgwYiwKIAlOVk1FX0xPR19BTkEJCT0gMHgwYywKKwlOVk1FX0xPR19QRVJT
SVNURU5UX0VWRU5UICAgPSAweDBkLAogCU5WTUVfTE9HX0RJU0MJCT0gMHg3MCwKIAlOVk1FX0xP
R19SRVNFUlZBVElPTgk9IDB4ODAsCisJTlZNRV9MT0dfU0FOSVRJWkUJPSAweDgxLAorCU5WTUVf
TE9HX1pPTkVfQ0hBTkdFRF9MSVNUID0gMHhiZiwKIAlOVk1FX0ZXQUNUX1JFUEwJCT0gKDAgPDwg
MyksCiAJTlZNRV9GV0FDVF9SRVBMX0FDVFYJPSAoMSA8PCAzKSwKIAlOVk1FX0ZXQUNUX0FDVFYJ
CT0gKDIgPDwgMyksCkBAIC0xMzEwLDYgKzEzMzQsOSBAQCBzdHJ1Y3QgbnZtZl9kaXNjX3JzcF9w
YWdlX2VudHJ5IHsKIAkJCV9fdTE2CXBrZXk7CiAJCQlfX3U4CXJlc3YxMFsyNDZdOwogCQl9IHJk
bWE7CisJCXN0cnVjdCB0Y3AgeworCQkJX191OAlzZWN0eXBlOworCQl9IHRjcDsKIAl9IHRzYXM7
CiB9OwogCkBAIC0xNTQyLDYgKzE1NjksMTQgQEAgZW51bSB7CiAJTlZNRV9TQ19BTkFfR1JPVVBf
SURfSU5WQUxJRAk9IDB4MTI0LAogCU5WTUVfU0NfQU5BX0FUVEFDSF9GQUlMRUQJPSAweDEyNSwK
IAorCS8qCisJICogQ29tbWFuZCBTZXQgU3BlY2lmaWMgLSBOYW1lc3BhY2UgVHlwZXMgY29tbWFu
ZHM6CisJICovCisJTlZNRV9TQ19JT0NTX05PVF9TVVBQT1JURUQJPSAweDEyOSwKKwlOVk1FX1ND
X0lPQ1NfTk9UX0VOQUJMRUQJPSAweDEyYSwKKwlOVk1FX1NDX0lPQ1NfQ09NQklOQVRJT05fUkVK
CT0gMHgxMmIsCisJTlZNRV9TQ19JTlZBTElEX0lPQ1MJCT0gMHgxMmMsCisKIAkvKgogCSAqIEkv
TyBDb21tYW5kIFNldCBTcGVjaWZpYyAtIE5WTSBjb21tYW5kczoKIAkgKi8KLS0gCjIuMTYuMwoK

--_002_BYAPR12MB34947F0C352E4035BAC258CFDE8C9BYAPR12MB3494namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--_002_BYAPR12MB34947F0C352E4035BAC258CFDE8C9BYAPR12MB3494namp_--

