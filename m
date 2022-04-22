Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A7BC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Apr 2022 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=y6xwXWX2+R2cw2x7ocAx84MKmgM8YX1B7vf9EEJ5nDw=; b=JANRLAOlKJhIyK
	m7BoJAYNtVeQbKVVetUKo8Brs569I9m8rzGeASBIw/t4dkKvIZHZ2O60CZnDyLzHe+Jx1BhAqwzo0
	dgY6FYOausHrlTAsu1/EpzjrGfHVBExduvGkYrwR069qxNItT4f82e2G5djpdWQ//s8NVn8T9GCaz
	e28F7nlMqFz5UK0XRVbu7oT/TeiSagCAlIp870a/1dJjRcfnX0mRVVnhAwYzbxrM7VDJXIECp9rSh
	Fy0Aqkqjv9qCcZEWwwAw8EjFVAI6E8Di7JoIJuXda7Cf4nyEwR7zEaUVYSQ9hBLuENnLAWQbvmGfU
	4cogAov2woimI7c0kfbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhuTp-000rw2-2p; Fri, 22 Apr 2022 14:41:53 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhuTl-000rua-Ry
 for linux-nvme@lists.infradead.org; Fri, 22 Apr 2022 14:41:51 +0000
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23MEH4gn017071
 for <linux-nvme@lists.infradead.org>; Fri, 22 Apr 2022 14:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=y6xwXWX2+R2cw2x7ocAx84MKmgM8YX1B7vf9EEJ5nDw=;
 b=dGI4ppQy4LgUSyvhAb7/aNLqnmt1CkxBEDc8yRNbfqIzOqZB4S4zyZ6UR9zfGrTRj5t8
 Sa43CLA9aytSdMhqslvXYzHtURdAUihmvq1FuSugf09u/gLOozdc8OUd+B5e0JYCSQ47
 MnAcz/VU57omNMoeIICkXi/HLNWjXS/nl+0KBJPgwJEXTfPgtG07hSC/MkKmlzPWP0aZ
 MYffEY36QGsCZePTin56GUkGro2iO0LoKCTd23cMVSDEv/V39zwGIvJW2HXaQzN/zOT1
 lDgXp++vh7M+AHtYWO4kBeyWOgzRVxDDVM8y55SPpdaXByB7Xt8Um94QZxHHuGeV6jF8 Eg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fkx0406x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Fri, 22 Apr 2022 14:41:43 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9A3AF1308F
 for <linux-nvme@lists.infradead.org>; Fri, 22 Apr 2022 14:41:40 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 22 Apr 2022 02:40:42 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 22 Apr 2022 02:40:42 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 22 Apr 2022 02:40:33 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBb6rqOtRML4X82NIkfk4xjir783WvReRvOj0cfAJz4b5+WruXHldwaxc4KKfiio/y+5gwQgkvxdH+pW1xIh/pjb3GFtQTajcpM5KSTgtZc98TsMKWe9JFoTbHwHYJPSGqfbto6dJhGkeXEl1E0bE/0A+5+7/9EVigiqrMlMX1zl+gN4tG7Tw1sYSIeqQoLFnrGKBjQwhv+m/nz2L8Au0oYsvHxQnJGtWrSiSPLS5wYVBsVQKfUtoa5iNHaEmFHZX4DIL+IB1qF590e79IOy8bYTGlnGur8YtQkt8uKvwZ6t8lgVX8g2qmhL8LiSXMl1BnZPH7C2Q+cIFr8fjqXSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6xwXWX2+R2cw2x7ocAx84MKmgM8YX1B7vf9EEJ5nDw=;
 b=mBpHrqHHzWdw/EFuqs1EZ1c5UyKURX1F0AY3u4w/Ii4bUXfbuPpjJL0MdveYHo4ENkf7hFV5xQ+58yn13Kgzf6ZRoZcunpQYK8Wp8xHrK7AFET7hI3so/9EmzXaBXiWxwdHnbIpZa1lL1WY/ODPp7imBKo6n6uDM3jbqZJQTHfk1LuP5DMA++0ia/05Fh2HvReQCVtT+iOLukUUiZPwjUt+Px241wQ9EIDnRxU0Wi8NCXS++oUiC1yFMbebdTs0fL0JXxA/ynCCwmlEwnt+3C835epXBaxN2QM8oPlybf0D1w2rTeWA8VteDJz1qyWezPzIpn/AmiHvdgdnae4Hagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::15) by
 MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 22 Apr 2022 14:40:32 +0000
Received: from DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d832:ef14:4fc7:fae9]) by DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d832:ef14:4fc7:fae9%2]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:40:32 +0000
From: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH v2] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Topic: [PATCH v2] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Index: AdhWVSiSpagPZ2D9Q6uv/JCTFru/fQ==
Date: Fri, 22 Apr 2022 14:40:32 +0000
Message-ID: <DM4PR84MB1590DD85EEC2B30DF55C9578A0F79@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b974107c-7dff-4438-7ca9-08da246e0df0
x-ms-traffictypediagnostic: MW4PR84MB1706:EE_
x-microsoft-antispam-prvs: <MW4PR84MB1706F06D58813381A6DE045FA0F79@MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaKMEeF2X5EPetwKvFA82oyWU9yRxQiEdr6EE1Vj+Mo0dW10cE9sQkWVn0HYPO7JECdT/ZIpeAVFBsqJ304oaf2CYSsu5lbfolK9C+OkE/Ud1NgbBkN3yMO8ZrS7EW+7ePNUSQqFxnSTmyZo4Rxc3aJPY622MGPkG1TvVR7bffivS4YMjIOCSg63QfYyPIyoCpZKJ43c7NPnFicr9KPlqbDgrW1CTWBHvVOtmJPVUwNEQhfg8cfQ2YWDBOjNCGpOWUIKZbshnBTVv/qOuXlLQ9OLm+2qVA6E+IkkYRQQZ+vWRdkq5Q0ie+ODkcUCKXo8pnt9mJNVTVXCjb6gLIma4O4Bk4vzMDykOWO8grU2vSCokohPkGmDVH8hn7DVSiDLm7xxvVjz3hOea2qWRy3CrBK/LfJjW4mWIPoG+UXMa7K8/h2pgvV6eQb2FvNQTto/mHciveoZ+/aTTr/+xGHfe438VLclIVRQHH2E1C6jI4YUm8250hRfRoOvr/4bAZ0ul+SpO38bUIMtnJa97fSWcpnR8pPpTdj7P0GBU5NHRvz8r11bbEBJatOJ2kZqzIRthuR7ZwVSMDuKDXxWcdKp4EHNajN6fDim/9/HLJRviYpYlBokrO4yfxqHsUkaXZ2XVXuaEtxgltkCxW+uDJzH1lDruQNsf1uc9vXcadrMBpj7AGDHrd2qqtgTqC9qDyFmglSnG+wI1y+E6xo3TDh1zg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(38070700005)(38100700002)(26005)(7696005)(52536014)(82960400001)(83380400001)(5660300002)(122000001)(8936002)(6506007)(9686003)(33656002)(2906002)(186003)(86362001)(55016003)(64756008)(66556008)(76116006)(66446008)(71200400001)(6916009)(8676002)(66946007)(316002)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WEljov8l8AuIpFwogLpMvMYf1DryPj2d0R43B/SfbMxnAezHIEmuj3l6d+EA?=
 =?us-ascii?Q?VHzrzX2byomlh9iw5wdt0Tg3X7+LLujGuyq8trEGMYpf9bWY0Xyp4u53IoyF?=
 =?us-ascii?Q?TBPRVnk1R6xhXnh1coO+1/HnF7RKvvNa5Oh9ojbQDJUu9gS8WLrMLJP5m+A/?=
 =?us-ascii?Q?SMQG/W69jgrmGWI5FjzMw79mhyuJYp2fi0I3OKqQEG3lMNXnmir6VapfJdmL?=
 =?us-ascii?Q?NNlEgoH3b7BQTSf9GBojCi56tdl14O2QTMWg9OWVwEHCUmB+wydUnvJDqQoM?=
 =?us-ascii?Q?nLdqLp4OzzqxFNO+cZGtRUdPWfjz2WuOVPxjTkyOdpBX7p5yaKvMEpBw8kbb?=
 =?us-ascii?Q?rrSXxVsuW+92eRSW7/DckNU6Mfe4NjxCUPY1xHdL15zg0S0mcfuT6n/sS0V+?=
 =?us-ascii?Q?LZGalSQtuA2AyfC3iGSjBHrDx38OGwO9uLVc3jJkaahccEZ7G70wXEDfGXUe?=
 =?us-ascii?Q?kYdnaUv+FtF41v7cka8IIcbsB/1yUPXJYIuPE4KOx6TR6p6sikYU0EZB7GE4?=
 =?us-ascii?Q?trQtIADlTdNaa6mF8EyRM0VqnA18vGO5JEv/zYyaftTRPv8TsRPwQqxuaav0?=
 =?us-ascii?Q?9UBnBpPEy1gLonckGto76/dM7cK9kzpdpyxMKA98aGDiBiieUMHZdyernHmg?=
 =?us-ascii?Q?RUqu68jTw5NCAEDI2f7hbfB8XAuqHt1sda2zslEfnWJqPm6MYnvjLn6QJ/dm?=
 =?us-ascii?Q?/P+I1hzsUEcggto+vH+B5m1uS4OTR+VSL4Az51Q7+RxQgPJou8qEfrBbg2QK?=
 =?us-ascii?Q?L/OHxOYpr54qkCrL/dHmOeaJZeTf4xuSHfC1h6e09DGmfI0ylGuqttGM2ajo?=
 =?us-ascii?Q?z8AY08hm1ubWSyQeSyek/EcB1WLV61/5Fxtc5SetrOt/jaWyAI0ZO4c/9OiQ?=
 =?us-ascii?Q?UfMEvw3SoTGk3z1q5vmIbj034+F0nKxTzHNCyW0FLtpk/uP2XJRVP/s0OM0b?=
 =?us-ascii?Q?MCh8WUqA7hQrbvbSXKqmlgn2DIsKftzMoJg3RF8K/oh60uRtelx0zmML4o/w?=
 =?us-ascii?Q?xbe+nklKT4P9s9X+N8Flr1MRMpgcEzY7/qwXvZg1PPftM/jSPeUxMOEm/5Vr?=
 =?us-ascii?Q?xefTRVPum18yJ2tAWEK+acXNh7ltvjlsK2K5KRiJSk7yaiKakfO/sKd5Nbn+?=
 =?us-ascii?Q?EMvZBvLWHlw2cLRagUnBrn2H68/6HY9brJ53cmqrClmRLLruKy26ahmxTjXv?=
 =?us-ascii?Q?1hQJ45zIO039nqbzyusNxmjEseBu88QS5O6tNMCdQsfABIo3tXh0Z0qhQ3hF?=
 =?us-ascii?Q?+3YuhHscgoYgW9TKhXkwIRcvh7RXd3PFQjXx0t8eMI7sOeJkycSR6RtPJuQ4?=
 =?us-ascii?Q?T/AmKHQh/bZTIxEDtU35E9pyUkzxIicUsoh7Zwqaxhod5ntUyzdgtRaFQxHP?=
 =?us-ascii?Q?jCq6oVWZbVkbQfef1bA58DPBu2+vgGevx9+qGppw9gy07PrB/AmnoUs0cxjO?=
 =?us-ascii?Q?nUzYGypXbzItsZZ+gmDwrFwOUP5jylDZwdzedfGoSmvwa6Uzpy4lNWET8c9a?=
 =?us-ascii?Q?gf9NuHfF0uq+LneqATEE1vyj9eK++NPFeVbwZSPBgCLCYrvSmXBEtboiZ1zL?=
 =?us-ascii?Q?hR5TQV01+q9Hn6l1sPWgLRghRymUI5c8cgzaq2e9J9xCXKv6YvkyHAcCXxHu?=
 =?us-ascii?Q?wHFF+zrjv4UpUwL1HGKN2u9WilHHCOasXzo2xaw17rhm7BKIiMrZGy091u7D?=
 =?us-ascii?Q?RgIfQ4eI2VLp3hO1G8UTWNJPGEcp8a0TGG/rSiKW45oxuPdC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b974107c-7dff-4438-7ca9-08da246e0df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 14:40:32.4900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UU6YvhocSzbSPssG7Ka+SuicI6a+Vr1788SQiGh31i96KwkIV6mVmVKyO7FFaPO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1706
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: lT-KaewmcHI9Uq1ruk7p4crMf0d8z_Tb
X-Proofpoint-ORIG-GUID: lT-KaewmcHI9Uq1ruk7p4crMf0d8z_Tb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_04,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=901 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220422_074150_052691_40AC0AA0 
X-CRM114-Status: GOOD (  20.85  )
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
-ENOMEM) if the blk_mq_init_queue call fails to set up the queue, which
is checked immediately after the call. However, when we return the error
message up the stack, to nvme_reset_work the error takes us to
nvme_remove_dead_ctrl()
  nvme_dev_disable()
   nvme_suspend_queue(&dev->queues[0]).

Here, we only check that the admin_q is non-NULL, rather than not
an error or NULL, and begin quiescing a queue that never existed, leading
to bad / NULL pointer dereference.

Signed-off-by: Kyle Smith <kyles@hpe.com>
---
v1 -> v2:
  - Update commit message

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

