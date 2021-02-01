Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F377C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 14:36:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B4564DDE
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 14:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B4564DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WFTeKmnjOmFcPfLOgIK45sUqgjwq+NdRQnagwqHZVBo=; b=dOduQPQxOOZTZPJfuHQNrizHwf
	n4XnmiytcyVRnN0X1o4qFDjnXbYt/ckd3mOTa4Y8LA2td2t7gv4WWKLyvM70hhL752szrn0yKHxo+
	v+1ym1cV7cq9vterOtlrxon5arIGpbHrpYK2/899HKDYtvDGuFh2oeECQ83IQxlPYSYbhO/bcAkoF
	b644wse3ohhSBApxJeWpoLTWfQQDBwYOXZsuHAiciT7+FIuoLbtuhcTGJcyopEsWh9miGJtTYpuui
	VcHD2+1jyZ0H2gAmSoRHL5PtuRqWffbcnfxMU9lwXL5bZkmqIBcz+Ub+871QZp6/zmwTDclzLnxDo
	Mr3krj8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6aJR-0006xu-Vl; Mon, 01 Feb 2021 14:36:22 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6aJM-0006wp-OU
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 14:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612190572; x=1643726572; h=from:to:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=NOB1JHCSJVgTnWBYisDcqfHGfFr64pKdn4SmhGQzrSs=;
 b=CmA4gv5Uwm9cQBZhe7D+JBJF3vrALU8YgnP6AmQpx/jWTIDxaOn0u3Iq
 jQ5duHZ32Xj4S57fuXPeZmxyu9UWxIxHmga2z0fxWc9Z2NEw8Cxa0Jt75
 dzpbnVm0F8cX/bCRaj4y9nsOC3Io7HEtifDJXdniyhEf2bOIGm8pzdnCb
 JfxlFkdN5mobGD8sDz19WNF6iOVHM47Mq3JEfyx16bQVlL91vfszHTN3W
 phL5LZg1rL4zzttMMwA+55U+iJI4pIsNfnZloVwP9IeHRhKGDghXLgrNX
 yKxRAhLp5GzvBz1kZZZfY92w2G7FHEo+oVFD0tFStxlJSi0oVc72dAaia g==;
IronPort-SDR: 09ELRT8Fk/UtrAHhsDk5hvcyNj+d2PXhdg/LxmQKsfQf0p/vx+BRPxPMl0UJZ1F2YnSXXUy1NL
 tVmitxtxHnv11PTCML6NDPjof3S5nxCsZmeZ3AjKcZeXTrfUsh3aowotaVkkujhLvsYkukLlTY
 bLbejR44dVohCwJ6glpdiLVuqHstJbXC4Gqd/rd+yuKkZFVmcHsdBavia8554b9894RnKG8ac8
 kk/V6z+Qw/F/n+r+c4Ru/5odyb5Uz8wdXeG+Irw05/RRDyPskYigesLUj8LNuYRktMSeVttGaB
 1Zo=
X-IronPort-AV: E=Sophos;i="5.79,392,1602518400"; d="scan'208";a="262889722"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 22:42:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBS71TnU0EciGvlEEYsUOCaR4V4PQ3f6VErnxso01blW7L5W/BE+1K8AKmZGcnHsFhF8ZOAu4fGVlGNseUjDBE2r8IaFKdMbhS9Br68sRJbKRG26nOAjB4Y9Dq4NUVhV0v2pf7coJdgJnBoi9VxACaOP/Y3rtJCNsjRUpz09FgD5WUhQiOtW3Ax8w3Dd/T1GQ7z4IMPS7gD/Oy64Kgn8OHW3ULPZffNSz0wqng/QWMZPjxVvEijhbhjFozBeB7fhOfh2Nvjg5ch/J6ePoraEBWxT1KIX2iJfO+yGeuylFaFtv8wwU7TT2GDCrRgDwxYVl5fdhSAzIAzOUMGkaou+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKeS2RUQTCCsCLXTtXjDwpkrh3NU7W2VmD83EfjA6sc=;
 b=W4RSr/e1jkkknyeNufUyZTz6/UIRuPfG6gqFkA2tXdKrNNahnu4IRN4QjV/sMjsge9eXAzlriQMLM0rznZLVovC8Wor3/LBhsk4/9jtor6Mh+XNede7HaFr1ZpD0LuRfRhVZ6TXNjdNUSa7IZGfqTz/pgma0J0pXeL5ObaAPboqx9zneyvFcOaFIPFyMeke+cLWuyJmLJZTkiE4KXba5kOCkr55QW6e5PRG07peiKDj9YGsH/WbdWb7E/EktI0bfQoMR0QVY5+UVRoJ0P7a2HgbsTYI8vJjBTvXBcJGF4fytFQIyz4QG9uXk625/ymZefab0RQ7w5w5wwq3FgghZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKeS2RUQTCCsCLXTtXjDwpkrh3NU7W2VmD83EfjA6sc=;
 b=yVnwEXv96mj1+O5Sfe+8178E9YxNBtaQgj6pUfQfKNs/TRyboLlzXwnVJGr/GpxVja2xLBw/I6sPDjdVAjVGwt3p5umyeP36e7waTr+IQkiC3h3Fr0nWywQJCv7WjezDHDVc9gRiLBH85INUqY1DDQRATMTKPjM3RZbD60zZNj4=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by BYAPR04MB5991.namprd04.prod.outlook.com (2603:10b6:a03:e6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 14:36:13 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e0b3:5bbf:9ef1:ca21]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e0b3:5bbf:9ef1:ca21%3]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 14:36:12 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Buffer I/O Errors from Zoned NVME devices
Thread-Topic: Buffer I/O Errors from Zoned NVME devices
Thread-Index: Adb4pjHrgmuLFbHxQCmk7MJnaI/frQ==
Date: Mon, 1 Feb 2021 14:36:12 +0000
Message-ID: <BYAPR04MB56561E48A54530BC7F6DCF30EAB69@BYAPR04MB5656.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c479fe0-66f2-4b79-7f6d-08d8c6beb965
x-ms-traffictypediagnostic: BYAPR04MB5991:
x-microsoft-antispam-prvs: <BYAPR04MB5991FCB9FBABEF85ED37A516EAB69@BYAPR04MB5991.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HgcyQGm4YTDQeDKk51xiyT6Q28cK+8u0IeuguPE8AM35iX3nD0j6CA4QbWkZrgnFyjGAcLMAErMlYKkDgs+KWtNzN4zlqZs1m0rLY7lYZ5mV4wmuttYevE0PFA6UjZ8mSt/ZakMoRKBloon/oKOgPZlStILuY6q589sPYfDSxPgGQnU1DSYlqmwphARzV7vzDQbdh0kofNqPn4nzy5zg5qFtvwPsFoYCrik+z29jgc8kkbLnlopYGUcHn0BGiNwKSZ5OC6q1nztAq3akR75dX1+lUO7h9VtcwzrBz/Bj7FIUhAnJXTUWlc+70KlwHnVtwdPBMSMlhsrhog5oizj8QQt8LfjU9Sav4vscL81YHpy+sgXCX0BNtOz6uTYJdqiIaxRZTgpnbq3uBXCuOM1UNF6AP7MSYUo61+vddqQ8zTCfPvP/reiQbRwh9y99Cf6E9n6CYEtLssapGyJIaS0eTXXQY3MGra5nWtHnTU0cPvd/Dr+/ST9pk/I5DjePn0ZpKYOsZod0OSOe3gt7nf4Y3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(26005)(55016002)(76116006)(52536014)(64756008)(66476007)(86362001)(186003)(5660300002)(66446008)(66946007)(8676002)(66556008)(110136005)(316002)(6506007)(478600001)(2906002)(71200400001)(33656002)(8936002)(9686003)(7696005)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2ZGG/7C+7qfQKT8YygM3fXbVpDKkBJdeT1HtBFqrkfdWAYJki3laP90d0xVi?=
 =?us-ascii?Q?EAf8SUEWVyZo2cWp3vQoA+TV0zPvSKG6SFubDGdEb6h4Mg31AUgNUXvW7UyO?=
 =?us-ascii?Q?NAd3bglcuOitCaNFTpe6SWqotYfpNO38tMITTys2mmFs89qENas07b1aChhB?=
 =?us-ascii?Q?3sTwne5S3ivsXwT87tNDvOr5aBk8SN/Xa26jPr/nEJHvSOI2beR4tneOWcKb?=
 =?us-ascii?Q?QmqSEEBHB+xzcAzC2DSBJn3jwvB+jNLymbxWlnFXJsrxpS0xr5/j+QmHCB4H?=
 =?us-ascii?Q?x2SFi1lZGMQZX0O4TdHE5FQFtApFIxiVqiAyKUTEClfSlC1EYuPz7exAljez?=
 =?us-ascii?Q?cXCX+xbtUon3XMlCb/rzHmAhyGOFVTQ7bKU02WVVVs6jxH2S3vBXZmVem8Kh?=
 =?us-ascii?Q?Gnx1+Kw1SdkzgMEeBFgQEzZ0SBFJXnL+84UCUq3fl1xuRiGNznNBvcQQ8Izh?=
 =?us-ascii?Q?KZCTOYfy9idxkYqClCJqnF7TaCLnx8Q5OcelqmJDa6tjvrAIboBdBaD7xctE?=
 =?us-ascii?Q?kg6twS9sfkMSE96EzSo/RuM8xtGWjOZtC1SIkd2Cxc/yvNfIy2mLTTC8TGAY?=
 =?us-ascii?Q?vWEnPdxpFwfcf9wUrJLzubOD/BnvLG5Xu69WIbhMm8Bb0RqSMqBjWgZ4H034?=
 =?us-ascii?Q?drtxFR7ImIye0Pk5MrA/1rcegLajE8h1AhxIvkwB+xkQQn40ny8sB3H+JpGW?=
 =?us-ascii?Q?05dI8Ih3/YqW8QFJ2Nj5HU7X+w/4B1xxalounRLJJzpV7r8Ww7OM0YYcnVWR?=
 =?us-ascii?Q?I4Q0CTpLms6EZ1Z1lt/T5KhCn2O9eOhShdn/wSlro4Il7hITnRO/10dnZCa5?=
 =?us-ascii?Q?V3lFEzIk0YyQxFwRFLcxP9noGh1GOFKfLFdSQwot3/wU0navumBwmgxT1sQG?=
 =?us-ascii?Q?IGjNXQFWKR3wfSj1r0DpdF5BrF+NcHhyJcHSARt5pvggWyWaBKnUtBR1dPUZ?=
 =?us-ascii?Q?GnGTeSFKe+K9f11C9xlSweAsPPC0k4VXxZ/YilSBB7Bn3I+cd1xvTXiywq7q?=
 =?us-ascii?Q?FIewf/KFQgrbN1n/WvPJJXyjtrRqdd+ANSXIhwYrNRvcEomQQdaes0utytZC?=
 =?us-ascii?Q?JFKqjznv?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5656.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c479fe0-66f2-4b79-7f6d-08d8c6beb965
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 14:36:12.8448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHfvahFLw/M3GvYl7sywhXzQkjuc86SN2QYjzp7afK74Xh+MGjB1YLDgUMtAhedKhLB9wYUlVmssNBnZtMfw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5991
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_093617_096220_2F634353 
X-CRM114-Status: GOOD (  11.27  )
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

Christoph, Keith
We're seeing a lot of these Buffer I/O errors with our zoned nvme devices.  One of the FW developers looked into it and had the following explanation:
All these Reads are from the kernel during enumeration and for LBAs that are in last zone's hole hence expected to return boundary error which is getting logged by kernel.

[65281.936988] Buffer I/O error on dev nvme1n2, logical block 3800039296, async page read
[65281.937165] blk_update_request: I/O error, dev nvme1n2, sector 3800039297 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[65281.937166] Buffer I/O error on dev nvme1n2, logical block 3800039297, async page read
[65281.937335] blk_update_request: I/O error, dev nvme1n2, sector 3800039298 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[65281.937336] Buffer I/O error on dev nvme1n2, logical block 3800039298, async page read
[65281.937498] blk_update_request: I/O error, dev nvme1n2, sector 3800039299 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0

Are you aware of this issue and if so, do you have any recommendations on how to avoid or resolve?  

Thanks

Jeff Lien
eSSD Core SW Tools & Drivers

Western Digital
2900 37th St NW
Building 108-1
Rochester, MN 55901
Email:  Jeff.Lien@wdc.com
Office: +1-507-322-2416


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
