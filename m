Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9977C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eScnjC3okrvivuj5SRyStQw7u7HqoA/CR3zXU/7Irh0=; b=cdAjH5m+ySrF+tSDTeZ1/ZYRha
	OTrHXQU/Mf8U7cPCQoVqqcZCE/PgAvA82ncYx/udIWgHysWFduMgnThkvc6yBvB8Zm1Ec+DyldgUZ
	ktY90zarhTlwomHtVgVn8BQKHFtgsxC/Z4zQ2UZZjxcMYCo6FBVexgeJOzBMZo+kbe/Ogjs/gb+Z6
	lJFWqV2XtBgxJg/XMJiQTFbVBWxak7lhNOCzMORHpI0Tpu7Wwrs30VYEb8e4uUYD/Pun65I7COp9Y
	hQ85WgXlSbBPXdtXCS3oSExaIGpUK4i31FqKjSmGfKVVB7muiTso/UgbYLPVMxRWqKyymNDw03iU1
	O6ukl0/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhdqK-00EybB-7C; Thu, 21 Apr 2022 20:56:00 +0000
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhdqG-00Eyaf-TH
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 20:55:58 +0000
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LJRsA0023950;
 Thu, 21 Apr 2022 20:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=eScnjC3okrvivuj5SRyStQw7u7HqoA/CR3zXU/7Irh0=;
 b=aKap2IllGTds8ek5NB8D3obzRZGheCfdSuE4GSPAjBSvy0TSP5Ide1zRk3QCY68XYPaJ
 hP3lUYSrDPtxuxe7bG0A57NAhibmTouangNbj1KqNt1sJb0wZ/OkXyuwQtDD/mKGWWHt
 J6zYwB+vlN+Nf36QzXDJwLhc59YVTtwBEaGlpC0UcFmqmCDctiBD7jNl2a4txdTPqI+n
 in6TurwdCvHTr+vtUJmJfbzo9LOUjFhuVakQMau29fq93Hf33pXJZwDQ4x7hMFGsrSUi
 es2nRYAww1ri9kSZm+LuctZbOqKulCqHfiR9seBav+GsmbH/wojrZVkk/wh487MTEqZR Yw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fkdehrk50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Apr 2022 20:55:42 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14878.it.hpe.com (Postfix) with ESMTPS id D2E5F13086;
 Thu, 21 Apr 2022 20:55:38 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 21 Apr 2022 08:55:24 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 21 Apr 2022 08:55:24 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 21 Apr 2022 08:55:24 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEEoqUsjqapIlq1/4qJPGmTdSG7Gcq5IT1/PaUeYGMXDBcbYKYb6TuUAM+jtPMrOahx3QO/jAImvrG1dgSkzwokfLKFMxaatUxmL4LZYmCp/bhu+NOOGhwJq1E9qdwmZPzRyazjqqnI1961eqyqL3bUEDA3kmb8gkSzbEsRRVE63kLuq5yEG43tO4Vd3fvUqRGlOLE07dfZrvQROE/K6KEESaw+kqHq5A17yZjEonaDLLbE5M6QdS1h8V2pkmjkvrK8InK3XHCyDYw7fhrMsWca3v269yiY/gwVe8xx6gMmP7DXF+b//MuuFC5Sz4SJVk221DHtXz5kzD+ZFWkV6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eScnjC3okrvivuj5SRyStQw7u7HqoA/CR3zXU/7Irh0=;
 b=J58yT4EYuV8eHcDps/DY8fZSy30heCl1SpnrX/WZ1KArj7xznBpeMO7d4iRz6tHwKAwV7sb8v1t0vExZbdWkkXRd1bUYMzbqJitkkE2sxfjnyaAJpnL0EGui7zgyAA7wn7LY1yzeBFJjtJ2Tb5NrXOBBUGKOBa/xqBn/DlczAhO5YVncjKtOFf8pQzPab0rTRhQ/WsTxyLbubu4PQxKC4/5BrXADNnkZ+CCRS9GK8QriYfPh/Cjvk/H9B26bz6YVDL92RxYenqoQtwJRvVZ00OFC1ZcsVePzqVFsmHSo8tOqFs4O+WCXLLjI+8mR5UnS8Ox64vK6/WXhKHPZum7FSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::15) by
 PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 20:55:22 +0000
Received: from DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d832:ef14:4fc7:fae9]) by DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d832:ef14:4fc7:fae9%2]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 20:55:16 +0000
From: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Topic: [PATCH] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Index: AdhVqlZ3h7upkXT4TAG9KVUkeJ9NKgAB8dUAAAPEAGA=
Date: Thu, 21 Apr 2022 20:55:16 +0000
Message-ID: <DM4PR84MB1590C311ABDB0895A1B4D16EA0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
References: <DM4PR84MB1590F030A9AF89C6E0E62A38A0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
 <YmGp4g/V9zkyMWzz@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YmGp4g/V9zkyMWzz@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a19ebd0-d9c4-4b51-e7eb-08da23d93ccc
x-ms-traffictypediagnostic: PH0PR84MB1480:EE_
x-microsoft-antispam-prvs: <PH0PR84MB1480349F7AF1F281F8052F2DA0F49@PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YPA0xXHmA0GSza5Pcr+tc+61zKoj9qsBNz15jgOtjNU+usvZq3F+VOd8rgwQh/iKhug0+MA/euCuSFmJoKGF1ECGlC/Bm54DAxeiXlKxTbnJWgp8fKD28oP4YYdRIhBEIEUSmyyMuPq8hO4VcOazCRQVGnH4s7M3R2/FT/PV9LfpKAf78FbYWNHyWc9Vi2l3c55MozdvR3/jEa4tQZ8EVgyO9CEnOV37Bf64rP7wYvb9dvASw1ZaTHCpM2NQmpZEhxBr5uMNZwvdguI6hkNuSDmbNqN9VEv2/FeelGdQxMMDNfFMK6XoSROaGLJieGhfMmpfZ/0YYAfbhg9MSTXt/BWBXcn3MukbgeLIBRHKaUfn9pJ5NZh/oVDe0+7ewSUfNwSweHZ5hYeRfRy3F7V64eLKkNYPNgAFFYkSELEt0WewVQTjPvFHBYYQWc8XXIgLAtI+N5TJgxflj7MQhVGk0gPNoQfBTAEVxeHeyUUoRermwoCPdOQivqijl+iSqW5PUcdZpaKqvU27RUkozl87DrcFndSNKC1q+5F5p/HbUGuDE3CkrBNznn7DYLIwQH9BKfcXAt41LfSXXe0ElsbwjhXIMXZ01Ih7SnXqrc62wgK8A5zJNcHYdjohfkPW0jfMJe0ca17HIBwZOR0zAtaNnzeB3vUsK6gh3QpCEMevVphZrNPBpnNYI0NAmrkjvSzhnLSNyql+9whqw1zWdhPORQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38070700005)(33656002)(52536014)(26005)(38100700002)(8676002)(6916009)(2906002)(316002)(71200400001)(8936002)(82960400001)(7696005)(508600001)(86362001)(5660300002)(9686003)(6506007)(83380400001)(66446008)(186003)(64756008)(55236004)(55016003)(122000001)(66946007)(66476007)(66556008)(76116006)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cCURIU1MJKiqHYu6RaQ2VziOnich3x8QYxGDPcZflrZRvlrHQiqStPwl32qT?=
 =?us-ascii?Q?eC85wqT6PHzudwUFW6pVQk/XPQIOb2grhro5PsIjCcbgzNtrn5OOG1XLbnc5?=
 =?us-ascii?Q?jCd7I/jlBJhv4C6i43E71eLNJXIVuo7F85dRj2un/6kMm/llpWiGQ7erhn1A?=
 =?us-ascii?Q?HNtO7+dkP6WT/d+xwu9QfHRkiV94Z8ckk2+BKqvE8AXv/UKLXtE/8gxVs6CX?=
 =?us-ascii?Q?UUJdT13OtXF3APAyuZFb0SaD04LHIfK+JOvL6JpHeNPLg2QpDCCjd+o58r+i?=
 =?us-ascii?Q?PRZAdnpSomX1VBVKrNKVYtgvfn6VWVj9IpceXeyiB+vBswAgI+f4CC007AlI?=
 =?us-ascii?Q?LcrnTvkUN6rubhsbXWh5KtJdvwL1zNNoNcjA4WjH/7fhngwyFtS3zFeeDLAL?=
 =?us-ascii?Q?MdhPFsY/9eq49kfnT262deT7JwvlAA1XJ1M5mQipscpgk+JDH96NCrcYgf3e?=
 =?us-ascii?Q?zZjFcc0QB7cqx0PI3dk255YqRjEV6U8yi03V9tGDTLo97/G3iYZ/ecJ6Jf++?=
 =?us-ascii?Q?wuBPfb/1x7SBKRKqfi2wuEhqvdwGq63A1L3GxQ5TAZcxO+vOSnPwA6xzMqn9?=
 =?us-ascii?Q?1Ly1zPKVff4pi3aAby5MCIlVro9tv7m/4WNdsfJhcuiCwol8TE2Ks0oeXyrG?=
 =?us-ascii?Q?wMsaerqGqKklPWjuYqe3YGd8vt9m0tpXx4J+sXhYrn7+yf0oiyz/SrJWVeTb?=
 =?us-ascii?Q?UjU7o0xbLZ2nd7VOkCQfa7J3fOe8YqaYTUM0qg69za82obEu9P4EWExSioXl?=
 =?us-ascii?Q?Q06ZIgGTr6fQdW1U8P8cys6p7+ABn7kj2KBHEVq7H/46XmWWA4JmnUsrOHg5?=
 =?us-ascii?Q?mhZjFurCE36QrE+f4HdYuin2LTLduekd0iIHBmP8y9ecMZTG6NvHXKfnN+S9?=
 =?us-ascii?Q?uN/W8cOyFcJwUpbGl4O8A6/CTeZDDiO07R2BnZ866tU5K9EGdxqkAQa6nhLo?=
 =?us-ascii?Q?tcU2/TDKo9p9SPGVYKI6D3WzOr9R5l9FJOAxD7xhbjaYkYd/GcjLl9HM6HVG?=
 =?us-ascii?Q?vK/VerRfXxujtP2oI5sYuUIFphqV6U6KCvqf/mqF8BHnJz2+LzpdKL/AENB0?=
 =?us-ascii?Q?rVtmZ4qB4pUbah7CZUxh35arlkfPb5yXgpTzvm8fLLegesTG+TOPSyHTslwi?=
 =?us-ascii?Q?k9RPmgOVxGgavv65uGyLIJLwqgTEYR6t3pgyTqAHsdBu8f11g1/ua8KHFcXp?=
 =?us-ascii?Q?He0ap5PEjkRUHo8O4sY+I+M25Nne87/56HpSJzZXRoLc+IdzgZhKxSub30Ud?=
 =?us-ascii?Q?9gPOHdHPEaZm8YhhWylu9QOX2rXsJYoZ/iypP+on7f52zaPPnD0gyFrZTRJ7?=
 =?us-ascii?Q?YvwoAAKsgzHvasImZ4d0zCvICGKQiKnTDdxOUFaJgUEJV+o0Fr7v5fTilgSF?=
 =?us-ascii?Q?epVgvE2dyumxKGeRncg0WIJYJX/bsqNQDRX9uNGuGqtHaVWK2+Ce5INqw1UU?=
 =?us-ascii?Q?Gftj9X3ACkwMMeWPbbwxm909MPds36ZAEeqNhYejB6AKALFgh4EwKNUdhXR1?=
 =?us-ascii?Q?h6DEYB55a2Ni2RDCjaLRwBMY7O7ooDCqPvBpkfEBXIn9Sk5e+DS+0JUruDGq?=
 =?us-ascii?Q?2VuL2PxDfzQh1D2hGhOs97tY4zTcMtSKgiosm/OPfNGB+HIIzw/EemG5n1T0?=
 =?us-ascii?Q?kKvBqK5L1lTTesWTGffx9TWNfmNrEobwd33w+8bVKAaJR7hwN1laIIfsvA8s?=
 =?us-ascii?Q?i0GwggxQG0ASYF51hzLnbA69rrVT26LqyjqWH4A9M6U0zCLG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a19ebd0-d9c4-4b51-e7eb-08da23d93ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 20:55:16.0814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +y+ISTLPz1knB23W6uHQy+hrHUGVm7emqWj7LJOCfdy6JmnEeIm3YaBi9DXolblQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1480
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: rb_wzKczrWvaNVlGl17S9nL7NGaptoMQ
X-Proofpoint-ORIG-GUID: rb_wzKczrWvaNVlGl17S9nL7NGaptoMQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_05,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_135557_112035_813CA5B3 
X-CRM114-Status: GOOD (  20.95  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme_alloc_admin_tags, the admin_q can be set to an error (typically
-ENOMEM) if the blk_mq_init_queue call fails to set up the queue, which is
checked for immediately after the call. However, when we return the error
up the stack to nvme_reset_work the error takes us to
nvme_remove_dead_ctrl -> nvme_dev_disable ->
nvme_suspend_queue(&dev->queues[0]). Here, we only check that the admin_q
is non-NULL, rather than not an error or NULL, and begin quiescing a queue
that never existed, leading to bad / NULL pointer dereference.

Signed-off-by: Kyle Smith <kyles@hpe.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..2f7510938b18 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1772,6 +1772,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev=
)
 		dev->ctrl.admin_q =3D blk_mq_init_queue(&dev->admin_tagset);
 		if (IS_ERR(dev->ctrl.admin_q)) {
 			blk_mq_free_tag_set(&dev->admin_tagset);
+			dev->ctrl.admin_q =3D NULL;
 			return -ENOMEM;
 		}
 		if (!blk_get_queue(dev->ctrl.admin_q)) {
=20

