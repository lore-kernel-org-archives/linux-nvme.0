Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74D6C004D4
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 00:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0JT7GC3a5pRn/pJPR9dAN02kxXvTKC7ihZZLxtVk32E=; b=mpxdWirdJzGzS6
	nxavPtcWNITW2s2NZOyWqiz4euBZctho5S5RqCwafCTTFNfnEW1JYHZSTvdDzIl42PkgzimFrz782
	4lRk92M3j82UJktjOAlERFe9ZQ0hRVBrunMWxbPqzTKWYpBFX+s5PcKtxZJVt+s77pHPnqhhCDTf/
	2al/vUhAHDllNxJgYycFB+DPqZ5++SKD+eASlFbX8tbvCVnx1SDf7WEqGQPdrIdIy2q46p2MUPOq4
	qc/C6K6dlAx6qpPrv8Puppg0WaAjjHRvS88sEE2y4lV7LOoTf9PyMPdY9m0iYHTkS7FjyN3aa++11
	Cy1POlnNxVqyFOnnSiAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIf5o-007iJJ-4h; Fri, 20 Jan 2023 00:17:16 +0000
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIf5i-007iGU-Km
	for linux-nvme@lists.infradead.org; Fri, 20 Jan 2023 00:17:12 +0000
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JN2mMb004772
	for <linux-nvme@lists.infradead.org>; Fri, 20 Jan 2023 00:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=0JT7GC3a5pRn/pJPR9dAN02kxXvTKC7ihZZLxtVk32E=;
 b=g7fr4NoRjm1669vLrMO7Yy6oPuPI3xjBYADf9uKqNw8WnToKx0jcQTN+9dmTRuidfNDb
 s4/2rPxPhnJxAaEramoyC7RNaeXg1BNm3K7N9bkIcjGHIL4lOt4RV9AbyjN1pwePT7ib
 TNTBwzQtRZAQeJG9NlvtMutp3wQ/tdbmP6SXqN5bmklYHbENmQEOMz7Vv2oVlBAQUVyB
 OBTvwWycHzaRBySu/+yUym4gsjhKTzZn4If1tB/NmRehZoEsjnrdgpUv5TFp1bu27GCq
 o68661JgtCDBJ4D/R5IIspA0SzWyV2nx7X3pf+pqM4oe63Fw/RgTTsTf+WcHQxbK5uHy cw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n7f6hgeaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Jan 2023 00:17:03 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 87E70310ED
	for <linux-nvme@lists.infradead.org>; Fri, 20 Jan 2023 00:17:02 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 19 Jan 2023 12:17:02 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 19 Jan 2023 12:17:01 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 19 Jan 2023 12:17:01 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 19 Jan 2023 12:17:01 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZjplRhEdBZAmBDFyTO69C52MrA5fFGCgojLH8qUPphGwjCbSsY34acCozlZRGYUaoPuLafD3skR0G4cWg10vsF/l/Bpt7tOWI2wmD8Sf3Gck3yhEYMB2ReqBxUWZEluvm6lF5mGKK+wPisvxyxhCA4rkX5uCb0gK/+tclGqSTiEFwrIr7C1JgqHh/oRcfnqoOcPB2j34eAdTwqC1vSeuDnvXffuxbP3L4A1meBXwxSFiRr7s2TJctgwMsoNAvaZ3GpzE0ykXLNXxWKdyDqL6SKeOMYe5iz9P4jPervnD4b9hvElJj9QYW7WNx1Xmh26ulJXHlng8G5Au6aHWuKgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JT7GC3a5pRn/pJPR9dAN02kxXvTKC7ihZZLxtVk32E=;
 b=Msl79ypy/9kw9sj6pzklY/d5QFaVr++kGR0kEFAOjzSbty615PzK9UaDE4junEb3Bq+5H7rsLwhQzmTcODHDNDYK5YzAUJy+3czcf1nA6YXYZhSM2qukF0/2Ok9Ugv2bGav6MwxwAkq0kyxHqfeb8eCRCfM+7gdAgSKa9+ZTzdwKmFPd6PZ7/GowA55b57C8YFni7O40fuuukc8x52zKzJKffHWpomnVgXGZd8TNpt+Z+96eA791lqkiHyqaR6OIr6iMWuqxz6JzyYrm8i+SEyXsbBwLCoU4slyuM4/fSQPvRCl1s6LBG0O6qb47fpEdJSoXS3/iad0uvjr1WrnhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::15) by
 PH7PR84MB1727.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.24; Fri, 20 Jan 2023 00:16:59 +0000
Received: from DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ffc5:d4ca:c114:69ab]) by DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ffc5:d4ca:c114:69ab%6]) with mapi id 15.20.6002.026; Fri, 20 Jan 2023
 00:16:59 +0000
From: "Smith, Kyle Miller" <kyles@hpe.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-rdma: Distribute I/O queues across more completion
 vectors
Thread-Topic: [PATCH] nvme-rdma: Distribute I/O queues across more completion
 vectors
Thread-Index: AdksYgZ9ti1nWvlARlusVFoHAFR9KQ==
Date: Fri, 20 Jan 2023 00:16:59 +0000
Message-ID: <DM4PR84MB1590221B5B3C6DFA34815D03A0C59@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1590:EE_|PH7PR84MB1727:EE_
x-ms-office365-filtering-correlation-id: ab00c19a-ae76-4db3-1488-08dafa7ba599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tIqp8noQ1FLVnUHSOeYemwOXUrzAdgDVsTVmfoQ88449+xuHKn/tRPySIeaxdGjUKDyXXEaSdJEPI41WzRuliEkWEm3bITKjsfMKoOYkZ82nYlt3HkDZV51PBbr36qmgCQFuTRtSjUyKmlxzPe69xKwiORopgcSX8HsWJh6oMzSX9hKDGYyEI2/7icp3Me8FbtVUuT1w1ZnXdXnMyw7tMiKtj671l3fRfTEP0Jr24PZB7PokajDDyVW+xCTSddbSdodnFiWRJns4hnxX3kBQ3uz4byHVM1hw8QvOQlMxW+LteRUzOIJsnCxuzh0nGfjUYxHDlsY76QbRtIFh9NztSxxobb02HbauzM0PGEX7X9X3XsiC3FFuZwHZ9xatxK1WTmxqhOk3vbJyATZyn4SG3tiaVkD6OlZSJZFr/YoSU1ZUQqM4FGVoHMSKMk4Yq5O/1/YpU7VY7ACv1AvgXvDutfuHRWzfoA+5dgm5uCXUgMMRW1K4leMHvuVQFgaM5q3V9t6UhffyIN4IPOUy/aF0ouDSv2L7CJBhgWToBq6VlfOQ4X14G+Cmos+VbCzXaYZDlMIkxsT307nbxWVbkqz3yH5pp7/8zi9UQFGhl623XsuJnVKkrvmAouifYqsR9EJmRwllZN25is6KmCPhF/3O3B+LBNyrhGKYC03nTsa4wWthbNv8eH9MAoXspZqVJ2IlYm4ir5HJtTj7DviJNfjwig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199015)(38100700002)(38070700005)(122000001)(33656002)(7696005)(82960400001)(55016003)(86362001)(71200400001)(9686003)(26005)(478600001)(186003)(6506007)(5660300002)(64756008)(2906002)(52536014)(66476007)(6916009)(66446008)(66946007)(76116006)(8676002)(8936002)(83380400001)(66556008)(316002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YWjS00tVglesjNgGFPLm86+8gSBe6ww5HkErbdypBUn3IphYIABvEXViCHZV?=
 =?us-ascii?Q?ud/EcG2/yVt12DO49XM/WMZOEkUvZdM+VTVHtUeuD964m7sGQi7iayiZnuGT?=
 =?us-ascii?Q?tvli8NqhhoEHE3q9dJxiariK3xl4IfY22NKpaRRAv0mkgFP1wpvvZCltRVhj?=
 =?us-ascii?Q?ZDqTgciS4DIDsBHmYxTQoUqMRCWQYJG9x4GbydcnR3jhkUQyLOHBv/nA6ts7?=
 =?us-ascii?Q?46dnDD8N1iNohd5EUskCODFQ2DwqL7kkD9qPMIWzn6ws5H6OkgvaoyiunTrU?=
 =?us-ascii?Q?pSc61Vh48uCJrnWRgLwbKyRmUXmHo2dduIkqp1qysLlNndZeYF9OIy4XL6bz?=
 =?us-ascii?Q?tNLJ6qpPLLT4WxGY99rqRpynN/P7KKmIe55GxQG0HCatGkt8pgrHVwXfwpBg?=
 =?us-ascii?Q?ng7aK/Lk+Cu0OSEVr05q0hv03w4HbADguPMAXrGUNl43Dw0xmmeBOoSpcqwG?=
 =?us-ascii?Q?zd5zzZjsoMj31S+uDE/BqjCLoy7nHpGX+a8q65ObV/MYaXgQ1nWkWKu8z0rx?=
 =?us-ascii?Q?hs2qxBO4jXvvF5DDHdXjUdjORw04r9TjEvzNs+1SHwCB1PDKOnu0WTgiPZzK?=
 =?us-ascii?Q?L/kRxMxtG30WWQPat/WcbVOWqiEoPOmgDHRtb0w+BUxXPSf4YkzR0gr9F6fX?=
 =?us-ascii?Q?dRUARYNDhBzICEdR1GZ1PLkypOjxOVqT3k8kxXAS4pbQILmRWZh/LdRgYhjE?=
 =?us-ascii?Q?dNNV88rZtQgumgMjwQavzkQ4fAdKbfPblQ3+1YFY2u9m0t/O9TW6ofVnIelj?=
 =?us-ascii?Q?5A/ZWXikga7RMKY8QP8FdiQ8iqnaD5RZrYrR3T1Y81ckWV+tlnC79cQq/tfd?=
 =?us-ascii?Q?dyKwWxdgJdFpNb6ALRmkooaXmVvm9SFq8ho3ii9wvefBmxwUmUWnb1GW1XKK?=
 =?us-ascii?Q?Uz2HugSq6B0B6B96VFs8PRaIGuIg1KxGx0JIL81yM7zvSWYTAdbyWS5cCpo/?=
 =?us-ascii?Q?jc+B1zu1alu3tEAV+PAycNMCTK2az6esA6KDvXhhznaN81GgIgClHp8hwfmR?=
 =?us-ascii?Q?lOR83CmQp8dEwtZaNChcQ9R+vk9rj9wJO66+hAlB+2yzW6PUnzFkF8FC82NB?=
 =?us-ascii?Q?gNR25TAXKaaPYUrtOHqKzLkV75SqDv9oLwBEmtx7ETAx8gcMYLtnWtx0PTBd?=
 =?us-ascii?Q?+wDUjpxMf2ydJW1gVN49Xv6fnsXEstyHRI5DzlqKJZ1Fsb4anX27ypAKSQ9i?=
 =?us-ascii?Q?kA3DAOdyD7YyP6Tdf3skT0fz1g76ru/uc7m8OzInyYXPWhmaS25tYipGIIAk?=
 =?us-ascii?Q?x40gY9QD2HfnfUvzGUvsDfoRD1kppoef5NfIfPvz0x4UdMFJGJkdQQli8xS5?=
 =?us-ascii?Q?KzdYUMFMFH6Ns0EkoEUKEYtSzdibqk10Hp1WR7G+ByrTf/xtE45Nyc5LmLjA?=
 =?us-ascii?Q?HXSO+7QUzn+ov4Y1vt1dRRHss2SBRmZODsrc/wHXo4ZDf9yoc1QLoBccYqee?=
 =?us-ascii?Q?j1O91XOtbueooptMfOeq6mPJiRv8psFZ4PKKkpuY6gLE3SiVMazoNzJ+Th3p?=
 =?us-ascii?Q?Gf6NKhCAFXRwKlzQbpawhTuHi1v5EfnH5e9L0g2c2/KhVeS4fMeht8+NiYe+?=
 =?us-ascii?Q?7V1+tjeihmjCWROXm38=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ab00c19a-ae76-4db3-1488-08dafa7ba599
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 00:16:59.1915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bmr1/6axSzV3OqXtynn6P90KtnfwLz1wEF0y7RkXvXeJszV34FCOoVC2y13x3VON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1727
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: NwVTa_1nJWV6aLiS8GUeIKzk4SttmXmV
X-Proofpoint-ORIG-GUID: NwVTa_1nJWV6aLiS8GUeIKzk4SttmXmV
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_16,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_161711_016350_8CBF7476 
X-CRM114-Status: GOOD (  20.27  )
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

Currently, nvme I/O queues are assigned to rdma completion vectors by
their queue number, distributing them from vector 0 to (max I/O queue-1),
assuming a large enough number of available vectors. As a result, work is
distributed across a number of cpus equal to the number of I/O queues,
assuming the number of cpus is also large enough. As the number of devices
grows, the number of used cpus does not, eventually leading to avoidable
resource contention.

This patch implements a simple I/O queue distribution method that reduces
contention in the average use case by assigning I/O queues to all vectors
or cpus available.

Signed-off-by: Kyle Smith <kyles@hpe.com>
---
 drivers/nvme/host/rdma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)
=20
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bbad26b82b56..116616510a6b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -463,14 +463,20 @@ static int nvme_rdma_get_max_fr_pages(struct ib_devic=
e *ibdev, bool pi_support)
 static int nvme_rdma_create_cq(struct ib_device *ibdev,
 		struct nvme_rdma_queue *queue)
 {
-	int ret, comp_vector, idx =3D nvme_rdma_queue_idx(queue);
+	int idx =3D nvme_rdma_queue_idx(queue);
 	enum ib_poll_context poll_ctx;
+	static atomic_t counter;
+	int comp_vector =3D 0;
+	int ret;
=20
 	/*
-	 * Spread I/O queues completion vectors according their queue index.
+	 * Spread I/O queues completion vectors across all dev vectors / cpus.
 	 * Admin queues can always go on completion vector 0.
 	 */
-	comp_vector =3D (idx =3D=3D 0 ? idx : idx - 1) % ibdev->num_comp_vectors;
+	if (idx !=3D 0) {
+		comp_vector =3D atomic_inc_return(&counter) %
+			min_t(int, ibdev->num_comp_vectors, num_online_cpus());
+	}
=20
 	/* Polling queues need direct cq polling context */
 	if (nvme_rdma_poll_queue(queue)) {

