Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3182C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 22:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GgfT4MKeK6YsrJ6mt47HIDkDoho1xv2t3/FPBjBQM9E=; b=nqHu/2o5WaGC09
	c3cm+jHY3Dr0puGohPWx/0xNZVTE+D20RlyoOTXSptoyh8Ukj4a5mGwBEjFfjq0q5pCedCbDL1Uoq
	WkPw6HFQuZlhHdCg8Bch9q0DURVM04207jSW4eKKHY0wqDiKRxZesGO+feiCGLvsEyw2Zj8nlSF4G
	0lkcxShYrE/BImJYWSL1T95vIed74ypwfXaEe9G2b5yc60ecZkkej0cauOcdfqqiSbZsMOAEZuee+
	/0vv+xPywgNCPMZAexCoXq6EkDmO77y4I+ntNX34wYDoTYsT7EnmH+Gn83+BK464sweCDTGAYzVH6
	hpOAr5irlBx17tnJ1p+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tctiV-00000005tGd-2G3A;
	Tue, 28 Jan 2025 22:05:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcsYF-00000005ohz-33lu
	for linux-nvme@bombadil.infradead.org;
	Tue, 28 Jan 2025 20:51:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GgfT4MKeK6YsrJ6mt47HIDkDoho1xv2t3/FPBjBQM9E=; b=Pnywt1NnNpzVlPNgCcy3dNPfZo
	kxt9tojx5hKsBLSDoXG0QimtLfWYwaveYz4vAzwzl/sfM3es0QS8aZquHPHiX2GD3gJsjFHbdxo33
	5c+IPUhXggyxSzz4x8jLRuQJ5lPXU9VIrrX3aYHTfJtp9/PTA3bv6AJh6ySYxK4yETpdvgy0F70G4
	fgVqQxlTeOjUtNGo+GsJt8nbqffxPJjPpG4zoIWzNroX934pQX4PP3EuG+EnSQzr0bc448MHgPAlV
	hGv174nFgPn0kehcsS8D5PgadBcwgfrAe/9HOIbHkKlvRVt0Gz3NOJx81eYzimdy8aaOXDDhJI+vY
	IMJlX7xA==;
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcsYB-0000000F1FB-1UO6
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 20:51:14 +0000
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SIaGaX026150;
	Tue, 28 Jan 2025 20:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=GgfT4MKeK6YsrJ6mt47HIDkD
	oho1xv2t3/FPBjBQM9E=; b=P2HwxiZbb1m5uZk3of6DvDESfBSGyQz9tjVsEBIo
	1J2AWeb7ESBB5/sqA711DkFPqSVqnycwWZnYq7cJWNSRqpKf4zrgQbsho++gurQi
	B2Qz3CLkDlMmXg5Qy9UPIITQm4QdTOl79uEWv/6JPhSexBLt/DsAty2A0YEP2Fui
	R3NsRYQQQxmVgxDWiCGZmpPUFrbcTv2wcCvMUr2nbFBuKa/H7zC1Bm1HQC1i4Avf
	0xIgJiZC35L5W10Vc2Lv+D9pg4NzCtVDvarn0vEPsoe1NSHklQIw2kpqorWEpdEE
	9p2mle173fehPzyUVfde1JzgTk0gK9HEJITiG+cKAqU9mA==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 44f4npgwc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 20:51:05 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 085AA801739;
	Tue, 28 Jan 2025 20:51:04 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 Jan 2025 08:51:01 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Jan 2025 08:50:57 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Tue, 28 Jan 2025 08:50:57 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Jan 2025 08:50:59 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO1HsmBJ89FAegMW0jZDFWaP6Q2DJGbTI6KMqbnFS1uUpkJOG99ARx8AUZ2z/ZPGNsTXy6ZMSHJFSj0UWTK2Gvrl9iuSXH+jYoDAE0vRxi8KaidKCvZ8+U/k59m074bIwqGRlVHb58PLNxoA5K/fEFGZik5NzpAsHReXew46N96VQrZZ7FOgLTUGszvLxgR/HEgjA1yofa2za+Q2Z5tphD5kpDXR9KPEgiD78lTmC+ISUs73uUupswuXZRe8ey+cMEgcfF0DoHIax+1cwDZ7df67pgIRE4PwWWZEpS+vb9CbSoSS4IR8We6m35aJF6JXhvX4idD3SidugpZFsGKRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgfT4MKeK6YsrJ6mt47HIDkDoho1xv2t3/FPBjBQM9E=;
 b=IbM6eTTdcQn1bN3uOr1tC4RwaNJD0OqOQgVZaSb0w5Dm1w29cfO/OHCZ5uJA+CqfpdAsmB6ogB+mYgXzUUUtNlyHPODuWxLN/HV02vN5XS1Ai874IDjZfKC99dE3Ioo7uZ0dkycY2gayY6XHc1WbF2TTdYev4Z1ja4q8gelN3sDLiMlTiUWraK8HVENjtuD+M+W9VXYqwAOZL/y28XHfljKZ13d/tLPpmDzeluKCPvcy0d4UJqfABMlRM1EFA5Ns9on7y8KXQoJPy0PRBGEHzkkiEY5JUxHRfehtQ+0vsl4Lqhn39445pF5sRvLrqZSKKCniqOiAYOliVWXzjSj+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:166::10)
 by LV8PR84MB3905.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 20:50:57 +0000
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836]) by PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836%3]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 20:50:57 +0000
From: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [LSF/MM/BPF TOPIC] HA features for NVMe-oF
Thread-Topic: [LSF/MM/BPF TOPIC] HA features for NVMe-oF
Thread-Index: Adtxwmg17SP7KrF6QVmcL/xrQWElPw==
Date: Tue, 28 Jan 2025 20:50:57 +0000
Message-ID: <PH0PR84MB1358059A6504FC5D37CE327298EF2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1358:EE_|LV8PR84MB3905:EE_
x-ms-office365-filtering-correlation-id: 5152b73e-70bc-4351-9136-08dd3fdd770b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JScHoziJb/ah1BV6zedryto7xodEit/uIOHV45tAh693o3hpUfGxMN87ZjTK?=
 =?us-ascii?Q?BdpeooKEmm02Gi093BDPtZXrtDOcOSmvR2sW+/JNDTzaXaUcPWmkOUMOMv+p?=
 =?us-ascii?Q?t7l+9J9/j1oJn7b1Aj7pd5swnvfTDPHyEp+dHkQyf98HoKA9Hi+zeO2sljao?=
 =?us-ascii?Q?yQPurEdKZ/oaG0ntaDC2GPfdIW+KNkrqQ5AtgqNeHmX+IVfaVdvR5/hS6smX?=
 =?us-ascii?Q?yFOaDqetnaKtjB38sUDjoigBVsUYkdwgWYf8dpFTx31KRGx35GUkYP6uP8Wq?=
 =?us-ascii?Q?sIZQqrgfqEWzgU1gbQx63EwK+qdXaXcSJb+W3DmhofBKeaJ8kfhtN8q6x/fY?=
 =?us-ascii?Q?GYBxkEQWA8UmXCMUtwgBKzem1UDOqZUlraVmqqslYKbWWqHPSsd27t7UmikF?=
 =?us-ascii?Q?csFBQLCYz4oag/mefxKMW+G2o8IMKncQQDzGySyBnfetbOafK7HxP4aXr2c7?=
 =?us-ascii?Q?xKLNwfn9DlIAYxGH2JDVHbXn+3ZPyQX5YRKfeTmijntdyVDv1JvOm+fe9LF9?=
 =?us-ascii?Q?dihobIi26sQ5vnu9bsa1eGAmCVT7nPWkwnjqFzOmGstBkHGszlM8bH+AEys/?=
 =?us-ascii?Q?W5nKNKw2Ingv3cf2onDIcBx6jY8yHEz/2HMjCKsb3UE7zv4jWxPoVVf/ZYKW?=
 =?us-ascii?Q?4+ocyoHRbmlqhuI127PwKP8ZRoI+mpttMOSN3oT7MWufyqbzyez5EQARLKoO?=
 =?us-ascii?Q?E0Y4ZoC1PJDb7u8cNUHIube9ohMs29OxwwtU8CaknWBq81zUPA58x8ceNbj3?=
 =?us-ascii?Q?whmx7gpu6l8/LE8U1UvBJqBA77ZHSmcNoFgrI09aFpik3CWIZ+/ven7egy6J?=
 =?us-ascii?Q?Y4YGSxAYPvB4d0xlADKU3k3lnS4qyRM8Z0k8UXPXU29QpCJgNdawNwUUgphZ?=
 =?us-ascii?Q?WsxxfhDGul7Chgwxb4Gjar8Oz5hpkWv8G26HVFpGlu+gOT04H2pSfgDBFSsf?=
 =?us-ascii?Q?QSZvNN1CwJpRx8DJeqAwyJRDMXc0jKATgMLhLrIA3ZKKk9kUee98/RJmC02e?=
 =?us-ascii?Q?9ochAsZPOOUyiceViA6esvyFIPmMtNYSQYlrhm/ddresqdygBPdVXTkBrrA8?=
 =?us-ascii?Q?5MjQKYwPz4HA6piUZem1sPe+hOWyYz7KiMqV9+AbQwpXEj84+JPhXctgGHr6?=
 =?us-ascii?Q?R/78cgFcMeTjFF5wm99AEVVTe1ZplbCTHpx2kL608K1SNJQ4YD/9FblFpTiq?=
 =?us-ascii?Q?SlMqV5ayHb9juV34jP6o3JtZttYIha8B5BE2hdXlfQ8yJCW7TgQBxyZjufXE?=
 =?us-ascii?Q?Amsg7dPq95B/GEGEhPu9kD6iznPqqr6rLW3tYlne0FKYWC4Tqt+cGXTiIaxJ?=
 =?us-ascii?Q?sn0430Dl97twVglzk6M5FTG0JnCX9ViiHz/ILZMi1KtJtaz3nqlpNIW3edWl?=
 =?us-ascii?Q?CoLcmrdmCr8cUOKCtz9HcPEJqMH+bWIleOUi+yPn6DfKm6ezW6Tc0Rzixl8Q?=
 =?us-ascii?Q?0oxlEjL60DzavEo11ghVtfCqkDf9tPRV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZprKE+kdyM/SOVEyeEUK2KH18mNw1yrxZHXgje1XkNmgn+fddgG19HMPOn5z?=
 =?us-ascii?Q?A4hF4t9zxPyWrueVqRFhc5KLa843RtYys/Pn0Q5/WrQSUHvsgUACCBrK1Wuw?=
 =?us-ascii?Q?NUQ4lwUKlgCvzlKtdMQjWn3o7nEd2kbxewdaQW6nVesCr+qNLy44axiqt/2F?=
 =?us-ascii?Q?SsQCO4hyU/55Tf6ej704SEXAfkiQyzlQQhK2h/H7/IAZ+UffVz5Av3tvvCvO?=
 =?us-ascii?Q?RHHFGru2FiyXg0qJrTgQLLMyeQyraq1ZJPGnLZOj180l99brEyNyFyGU1YZr?=
 =?us-ascii?Q?tiiaZbCsudIswTVsUS65kYdzOEYIho84JZM6e9Q63pNWpQ3MqjfMgLFrh1bk?=
 =?us-ascii?Q?M9OTGLBDno2AYVH7jvdnYcGYkyu2NKraSCwXgE9OHMr0uidh9xEocazFlHWR?=
 =?us-ascii?Q?6IFWSPWbeN7vmR9kVBkF1+oEiK9mYG0e1eZ/KSQzALOHrKiJX0jTYYwj/g26?=
 =?us-ascii?Q?Ew8Zblx85BOwWyymM2MXwlN+QbtWqowN0HB7hejhKdbEa/y523lxTBB3RWSq?=
 =?us-ascii?Q?hpzOYQhA5OnkBuPd+UtJmxBaOF6SW8xKAlYWMsm6SEoO6YK/kN4wvdkYrbVx?=
 =?us-ascii?Q?duxKoykhRpzyAevv2eqlBk0nzFlSefqO4o3BqT52rmwMzDfv0Fbv1NWHwO7D?=
 =?us-ascii?Q?+sBHUNNhv4LfzBkvcUAIKRkV0/+OzVP5qHoFlcF8QogW9gDmVJCkfiX8i98m?=
 =?us-ascii?Q?ZKArYTnIe1yQdT96smgjxfn78YwvYrUVD76VUjd7KHjnBr2L6LA6HKChZ52Z?=
 =?us-ascii?Q?hy1zj+0ckBO2CV5d9uaeki/NbrcZXI9m+PkMSr0eIm4jgZm0HAB4zFEEE9fc?=
 =?us-ascii?Q?fRMb/Oz1qsDKcwpjs1fffLGeAiUcIuFl+IZbDo0W1hJYIUk8Wt4TMGcClrEh?=
 =?us-ascii?Q?J28R10uCzXQcnw/GmV8EB5sEzTau1LfStLt9eMqcjmSeseeoFS86nVnVcuat?=
 =?us-ascii?Q?cHw/BlVqivDSRZrMnPstCuKdhoKEI4Qh+Qua6ar3Gv+llun1k95GtR1xxiqf?=
 =?us-ascii?Q?VcIF4XAK62qAxfvevWIew/knWX8xcIrL6ALCcBMEJrptQCpPjltSHeS6NnkR?=
 =?us-ascii?Q?KD77k6bjIKmqratk0JUEhmqV88vigyIvImeGgkpY2zcZBqYzCeUr1Qyjalvv?=
 =?us-ascii?Q?oeNb1gplnA7HO6j8tgqmKUagww1QBEQ/vwVC5e6/jDOp3oOFdRxq0n5PGY1n?=
 =?us-ascii?Q?YoUOjFmRcIubmAph2NDeMJRmY4pLQhhcGd5kNDCJpeBSU/vjStQ8aYEpsz5p?=
 =?us-ascii?Q?x8lgQZRQby+r7I3ouEsPRu85l+TFyDhREg3Gd1WTtlLAtF0NNwxvjkpjpItq?=
 =?us-ascii?Q?d3qyp/U+52X4V9RkG7S+QKjLl3OVXU/tHeqPLru/qDsrbE8fHCHaMtuu7B17?=
 =?us-ascii?Q?aoEKWU0Tq08r1EjcX3NY1g4civFSJw6GA1pCji3nxM7boXawe8T9/2cFbTi8?=
 =?us-ascii?Q?2h7AHOb5Cyqnb/3/PhxA4ZXP5cJ9br7mOybydH+2/P6oinMJfWaDv6GTeeTT?=
 =?us-ascii?Q?O7XpXBgrKqTkJCp/dJeFrWRuJsUfTNFh17kYr7GYfM2WrhokHTUpEYKYP0qH?=
 =?us-ascii?Q?AzcWOvvRYyd/v/xmyticLagXsFNusdAD70yOJ4+8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5152b73e-70bc-4351-9136-08dd3fdd770b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 20:50:57.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XYfRqgDgPepLZdlnOhs/x7yvpD6VOW6MxKNRt5JUwPr7UJcpB1Olhkuz/V7YacMdIAwyZETwI0wwGJInFRyxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR84MB3905
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 4F6sReg0thubB0r8PuiGtQROe9rKLhPU
X-Proofpoint-ORIG-GUID: 4F6sReg0thubB0r8PuiGtQROe9rKLhPU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280152
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_205111_984683_37F8685D 
X-CRM114-Status: GOOD (  14.30  )
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

Storage system vendors developing systems that present virtualized NVMe-oF
storage, such as storage arrays, are getting customer requests for HA featu=
res=20
to support always-on infrastructures. Frequent requests are:
  * support of Active/Active where two physically separate storage systems=
=20
    present the same NVMe namespace; and
  * support for non-disruptive migration at end-of-life for moving all stor=
age
    volumes to new physical storage systems.

Since those storage systems are virtualized they are capable of managing th=
e
relationships between the physical storage systems and the NVM subsystems
reported by those physical storage systems. There are methods that can be=20
used to provide some of that functionality but there are complexities that=
=20
make the models that have been attempted so far difficult to develop, test,=
=20
and maintain. One of the methods most commonly discussed is usually
called "stretched subsystems" where the identity of a virtualized subsystem
is extended beyond a single physical storage system.

In this topic I'd like to present, in a multi-vendor presentation, on the c=
ustomer
requirements and implementation challenges for HA NVMe-oF. I'd like to enli=
st
the help of Linux experts inside my company and in the community to help wi=
th an
overview of the Linux identity binding architecture.

Following the overview of the problem statement, we can discuss ideas for
enabling improved HA for NVMe-oF while innovating within the Linux NVMe-oF =
and
NVM Express architectures. The discussion should include considerations of
making changes in the NVM Express specifications. Participants that are pre=
pared
to join this topic, if held, are also prepared to drive NVM Express changes=
 in
support of any recommendations from this discussion.

I think it is very timely for this discussion as there is work happening in=
 NVM
Express today on a technical proposal that touches on some of the same area=
s.
For those in NVM Express that technical proposal is known as TPAR4193. It w=
ould
be good to consider whether the preferred direction for HA on NVMe-oF is=20
compatible with design decisions that are made for TP4193 if that work item
request is approved. This discussion may help refine thinking on the TP4193
topic as well.

Curtis Ballard
Strategist, Storage Technology
Hewlett Packard Enterprise

