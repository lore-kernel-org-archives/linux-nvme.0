Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9833DC5AE59
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMYXP2obBwt0Nb/mH9Neac5Z8sPtZYSFK+WR6LiRbss=; b=2og/fwXUh+5u7Dd0jcGAa01hCz
	mbVcmUXiEWyjPV3SkORS1U1H89bGlhvTafSEOsoG+uNl8C4xhUlWYQBYkMMNzEvd7dvHpY2rWl6Ak
	a+YGRqe1pma5LZH8fc+J0FitRaFvqBU0TN+bdcPIfTTJybuAXn9ruC7Qn2b97ART4qMHJ1XegJzhQ
	YTz3rf3HdGJvbgZM+8ARtQDzarBFzIS9Y2QIGnJ21s7kgDueHBKwvaPgZTUMx+Ymi5c/hjmrkCzed
	6tx1xuU7EYpv5PGdE9bLFBc6RGKNFBd8FI+qXrVeveV2djNgQl8n1WIdFCyX92060+I0UYZj/Q9Ke
	0dt7iulA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKDl4-0000000CoPI-2QYH;
	Wed, 28 May 2025 10:11:38 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKD4b-0000000CjA4-3hId
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 09:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748424465; x=1779960465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AMYXP2obBwt0Nb/mH9Neac5Z8sPtZYSFK+WR6LiRbss=;
  b=oBRMk3R2+Nj8kNPt1qfZ2l65t0cGPTI99zLS2pRKZiBdAj4t2yEBw+An
   M2MPQTGruBXwsM3LrsWr8iqxPI5mwGT0RsLnA6gE9Ub388GDQCWDgT+wU
   hx3e1NpsxYDWnFZ0PJln3NqzG4oWmCamySLRShXgAbGR9wvKxQpRbfIfc
   YbA0gXOzbMdvwIQF6PS1Ak9OCVDkKLhUZtEe0au5/y03pzwxoVVJ+o2Oq
   r/oLfl1ZHLkfQpBtAdbXEfMESCIbqG+Z9jujk2t6S2a9K7QLd+RPzmtg3
   h2b+HJFJyeyTNO4v6wbkRt60V2IOqyINkIPDEV+v8X35P2jUILnIhbXb5
   g==;
X-CSE-ConnectionGUID: +jtHIrtxTYyBzurnBQXYSA==
X-CSE-MsgGUID: nAY+Jg3VQj2EZ5m5Brli+w==
X-IronPort-AV: E=Sophos;i="6.15,320,1739808000"; 
   d="scan'208";a="83397428"
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.79])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2025 17:27:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4vev242iE4VCa/k4pDlrM5Na08d5kmQSxvJYYuhmPJNg6IsFzwrXMy5T7aogfeIXf/E/w38haQSidgbWVOlJhDxalYxy0TIjcvmsxSQA4hCGlNY9yGVE6wNeyRfEdNP+pffiy5uJDqFP24alXKeRi0hLU4C5B9jl0kT5ZzyLjMP0/kbJmlu0krRGbCvg5S24E0cNNeULXPqjwzZQjkhMXBKPEya0eGQvYH1FDDc2tbiFACY0+g6V2fRh/tcZO/4MPFXnAMZSIMQraXrNavSboPtRuxUjvrTjgn0/o6X+LOD4jvXgV5cx+Vr9K42uYGiUGHtUXTLnZC1lG94ubOvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMYXP2obBwt0Nb/mH9Neac5Z8sPtZYSFK+WR6LiRbss=;
 b=o7Cc8M5kcO2HIDfhKSwMlIGi7fc8pgsknAaRdkH+6L2QyToVg4lm9WukxfaaM7zZsVFHu8tIZpHCx1EUD1YOcSxLUXZT/OEFZI8M+AhgeCmv520K/R7Aoty+B6BVDnBLTjUDjgZqiShHu2R0iNNxrtO8N5t3Ch90+ZpUl1cSFGM6tpyO+bACpEJF+EDNdGnHUrfN1XgwdTyiaT3HSnJayKIloMq6XIIbzxIDDiwnoMYqFGTrh7HehBrLQjOlwWJgGB4C7X/rLEMUGmFk3dqkTWWErL3HCe4NbQgDb1UizKnle7c4UwdrQRgsLLzos9OP8/VDyVXubuJUaGcEe8eDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMYXP2obBwt0Nb/mH9Neac5Z8sPtZYSFK+WR6LiRbss=;
 b=eOgyxalJv002T/Nk/wdyGppUUcQu8tRi0tMsSDNvSuvsi41gAqMRM5yD3hAKP14j5hJ00Tq9yPbRAWS/bC6LZ3ibNXL81FRI8RfmQif5w4F3G9IvJc7YB97HGGYYihmAx+d6BkfF7eG3OcJJt1/K3BrSvfqV9QEGiyj8QHnKqRE=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BN0PR04MB8141.namprd04.prod.outlook.com (2603:10b6:408:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 09:27:40 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 09:27:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: hch <hch@lst.de>, Daniel Wagner <wagi@kernel.org>, Hannes Reinecke
	<hare@suse.de>
Subject: Re: [PATCH blktests 0/2] nvme: check that nvme-cli supports json
 output format
Thread-Topic: [PATCH blktests 0/2] nvme: check that nvme-cli supports json
 output format
Thread-Index: AQHbyU8BWtkhoqYM5EyvRGMM/x4tmrPn0uMA
Date: Wed, 28 May 2025 09:27:39 +0000
Message-ID: <4q5kziksundyop3b4yql4mtzoi2yho7d6h7bm7xqytrcaghojj@grfmsw65sr2x>
References: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BN0PR04MB8141:EE_
x-ms-office365-filtering-correlation-id: dd283503-4cbb-49f0-f59e-08dd9dc9e45d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TAECrBY7+qiFRZi+R6aLQRvQ9QgXgI/PibicWjPDZczwEa/G+ggCJadJdZl4?=
 =?us-ascii?Q?pgS724xBUlu7oSJjd0Tspsw+6zlYZ7KGDlVlokUKVRu8QZ5Jef0SNYWi+8KN?=
 =?us-ascii?Q?YtZZRkxGxKIpkC5FRGx9FlLXAtObWrE/86291kc2g/RISZ+Q6kV0uT9d1E4J?=
 =?us-ascii?Q?vUGMDS6wRpEy5GA7+WTol4huFHY6Uu0kL1mPkNpaBO6qvZc7mPVrfhf4Fsep?=
 =?us-ascii?Q?p80+D7wMplrJyXG6Xbsek1wI4MD3RiSvZTlD311Eae2et0XZeBajFZOPXSTu?=
 =?us-ascii?Q?gnDTbiZJ4r6PrSqSfn6sPqDCBAsNMgnUI1A6PBd/9wELETxCHKOBT+kxTThb?=
 =?us-ascii?Q?DlGYUl7dhAE6BV6kt69fjTiMok7OhC6JFJrEPAvPgGAv/pTko4pWHqLJao/F?=
 =?us-ascii?Q?druYOXJP0teuK3h5hjA6iGu2jWndsCv9SzCntF5umM+8/sZNksDT+LZB6qjT?=
 =?us-ascii?Q?Xs2iwvaFezs7OI7CGNPfKy38NPS+T3zT40U5LIKiy/NOQ6gx1D9+VPaHaA69?=
 =?us-ascii?Q?TrCqL28WiNHPh/wNcihpmil0Ty4rVAMgIZhufb6E4PEnKEklfQKOKgbjJ62g?=
 =?us-ascii?Q?T4q72Lpzku8NgJfXT6C7cwwGTH4bZ+G4RN14oyhb9udn+VRg6mhCf6kO3b9e?=
 =?us-ascii?Q?jVjU3zJiFwMh7UBFQVtbWoQD8IiYkD07q5qwLkrIaEPzklnDaC9fSrh9YrEC?=
 =?us-ascii?Q?0HyTM3lvTvpyIp09NOcsfjAOtIPJuNOaT3OWDTcMyfYaK+aJpot2MhQNos6o?=
 =?us-ascii?Q?lh47aSWK8j7+dFH9lj6Jc3Ow/w8vbyBr5ra3vJ56/uw4qYJmUrm8Gf+CKp7q?=
 =?us-ascii?Q?3J5mgUMuNOWO0sVIGznKUezVOt/2tXry7G1wUu52MURHfrspn4RQJPU6z0fm?=
 =?us-ascii?Q?e8cYCPutj43fpAJkojKXn9dTPzDioDpObzzO3omBqcDB+1bDP0hmxm5d9WFN?=
 =?us-ascii?Q?0r6XLZr5ZI5hpeZPAKWQA+x99/VDeCePsCEtLHXCPHWuFtp+lV3X3Ysqzd3F?=
 =?us-ascii?Q?goGv6jIc0t66fQ76RqgOthH+xX1OCvuG4Zt/WqKy+ERxw+Li2/u/yZ4DtvRN?=
 =?us-ascii?Q?3nxlbbOErm4zcr5VWG1KoxlF412+T75ibsFvyJStfebkewG6f0cdlZ1JmY5Q?=
 =?us-ascii?Q?Im882Q/5MAtWxWumov03KIuA6YZbpnW/UAr0wR0Snm+Prb1uWc/di5vHUb0M?=
 =?us-ascii?Q?PDOf9CN3AqPbiJeXzCirQM0m71xrcYWwaLLRDGz3fG0jRHv6X1x5TRcuqr8d?=
 =?us-ascii?Q?4FP5QobxYBepBUaPI0EE78iqwi/hSQ5h48ScIjJ5zhLjDYqWq2bH505p9buY?=
 =?us-ascii?Q?Ji2zcbAEmWgq2/BAuFj8qzEOED9u2t5CX5d/GMBGP69iC4UsiRFU1SBe87Dh?=
 =?us-ascii?Q?wXOAdquy/rZwV4xWKZoh+mZhXfbmLvV8b2VhV0FtWKpwDqIgHkMSpsU/CnJw?=
 =?us-ascii?Q?ng2t9UdE6cKE5Q0p4u9BZcHS5E/XpH7WQOBACHGchYBpCumP/cpxX7i529L2?=
 =?us-ascii?Q?4z3wtz6qQW8tffQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?imNc9WfQB1eBuVFYG55twN+OqfxeoC6nTB6V0bH1r9H2OxBvrlWvCWLr8r8y?=
 =?us-ascii?Q?6k/r+5uqDTtZw3mf7uOHq48IYS/faRDFyFDxqdlRQ5rGdqUBjpRyVnKWA1Tp?=
 =?us-ascii?Q?O5lZYv+8CXNofMNCsoCIUoWWhAsAKpIH17whMkiqJnbfxv0vdwJgHvkurPCs?=
 =?us-ascii?Q?gpVcX4B7IymgdWVJem9yQJH2DGG15KMejeVmX6afqPiiVp3ZIN5Sqwct0g+l?=
 =?us-ascii?Q?nvduNLr7xqQRzyWPKsjZMQTXxQbfJ75YdWFs8VPnbOvPcsxYnB+1tiLxVC6p?=
 =?us-ascii?Q?Pq8DOTqFFfkjg2JKm6L/ZK+b+Am4lFcnjn6o4KQ3JJsccI7v5OM+U862ETSy?=
 =?us-ascii?Q?PwsYjXzYj2Ji6KdofTTAed6TR5zUvSysx1sDJ4FN2JuMGpR2Kp3oTGoAHxJi?=
 =?us-ascii?Q?I7kP42wy5t5Es/XBpjiYk3L14EBX8EzR4HEL27O5kCzC6bO0/r2OyS/e53wu?=
 =?us-ascii?Q?ZI9FDsu5NpJwz9vGvPg3RTXFeSEyJGBOLwYZBZ+l2Bf/Rf5PabSed6P/2DAw?=
 =?us-ascii?Q?ck8KQczQebljNhg/Yx1YExlX3as0LFH7uHUA4sJEp4I4se7zcfFBVLSmoE0h?=
 =?us-ascii?Q?LkWsFRdRL46OVg3VxhICxhFsOx/KCm9gq087/tBbj7J/tmVzRRYF/jPylW2u?=
 =?us-ascii?Q?3bM/464lyxg/w9RCSh8uHQ85sgJCCnxzI3vhhvg39++mztZxHkPS5LU5Hraz?=
 =?us-ascii?Q?uwRDQaBw7ZmTMSiwDa2O0VikZjqI9NbzFsTGl9IDGFbSIoWSz6fHucTORxOf?=
 =?us-ascii?Q?GzyjyRSHZzuyVbzh0m/C8FbKek7IFnZbr/XEbafH+woovl9FcmK/CWkJ6nyq?=
 =?us-ascii?Q?EL9TER829S/z3a9Ob/8F4SBg0ma8pj4sXwjk63x7t4MMYwHfiRnB0VQrKz2U?=
 =?us-ascii?Q?atYTj0KZ7bmRKca/1YsRl6ONqzvLlviIrErhL/Mhh0l2DIjt9I2zE/cO9zRe?=
 =?us-ascii?Q?bJo7+RuA/sYRgDieAxXRtUxN3tv2z1+dp6K8QLIlvlP/c8M6/8hfBaFKZcGt?=
 =?us-ascii?Q?+6Dri6GEmK/Y0gEfWD61MxFD7FXC/XkiVsJ/4eaF7aJhZiTxlETcVxwneKSq?=
 =?us-ascii?Q?iEgvE2o7K8wb3dKpdCDV3khC+QnbKzK3sQnerXDQhhWG0A/UTu9nb8XnahLH?=
 =?us-ascii?Q?TjGoEQKul559zw8yp1wbdgaNX3ywXfGNSEpXUHvj8WW/61l9cS1TLfrt0+t3?=
 =?us-ascii?Q?gKcEGDbAxXunNcNrF8xqHUFdSqInhBnBtncn639qAtMcRghUGUm00vKCrd+s?=
 =?us-ascii?Q?nKQCVnRuAb8KhvNEErVHEP0E28HR0fywmS8Xqr+K7X/iYP/CVUJnq0CzdzWk?=
 =?us-ascii?Q?/BZxv+6c34pUyO0tIfR+iBLnoVDTyYdw29+6h/AREwMUWeh/Xxb2+JsQZSko?=
 =?us-ascii?Q?Wf1/kJXI9hS7AMD/it2r/oy9waZnqWP70T5mPz4Z1AIDmi5ErDPrNvwBcod+?=
 =?us-ascii?Q?4gw+8Z9rNBVJJAQmBQ0CpqdX85CjJjy9J4V7kNbTt4RTPRwFca00umnI/SO+?=
 =?us-ascii?Q?APuKgL7TNpMoc8TEEyGPfDD7MKt7w7EkHQzIwAzDXrnTh0iW/WeYZzUWhbRc?=
 =?us-ascii?Q?+723Lqe4B7fPAZm/lOV885GgmJ6W6YmZLTyYZB/f3b1ZYupU/8VZBgk7SiFQ?=
 =?us-ascii?Q?fPkAQrlHJemxZ4wO9LzmzOs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34C3A2DCC4BE4843899134CE7B5EEF50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xFRMJDnMSIs2yNMPrZu62tEFUHMSBgoMmM29uBeAlvubDmxNQubTlefp5HLyXFzHiJZtxpBVm4diKeLg4FATVbDaUfiiUMPhJvOWNkqvq4f/QpZjQtn1Au7mUqLiWiNCeIquio8ATeq3fS2XosSly5d2rZ+592jmRq+QOMHY3U51vK+WdnUG9WarMtxlO1/M4VKzjbAQkJrgvnc0IQUwJF7YKlX1YV8JnnZuCYRxse5MIo6hRyuNJ/RJWmb2rQ1UbaRKCK3m42Cv/4KzNjyIkShjpr7f8HxU08EW2fQa0YNYZws9UlYd0/JeJGQ+zvGepVSCylBsqojDZvk6rXV9nWC23tqhdO/PFI27MxbAhjYmTPTj91GCr36IiP4KLEteEOZvZH++WD1QEvUgA14F+Fk36pCTG2qBHazarULe6R1/7USgUGZ/vl//Vv84pUQIlMajU/SHAKjpVYUkXcLWclqju4ci79pZSlkHT6cHrSg2oiZmjzAvyXqAkt1piaVpa1klCpkEgK63mRQ76fyG10eobGT+MOxKkGT5kyg4LlyK8CmHEOPpZiCNPQb2ii1qZMDJ10L2y3LdRVHTAe0NStYkoFj53tW5AoV1WXkbiQy5ieWPqxG+ByvQo0eH1sz2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd283503-4cbb-49f0-f59e-08dd9dc9e45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 09:27:40.1775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lm/t8pW0g8Vlqbe4G4j5jB10abjh1Owf+n3qYfguLwrUwJUPG/w/UZ2kiSTMiE+yYZNZDl8t3PwDKzBkTKKPuO1qVzU++KG2OGaiF011O3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_022745_952324_0B0F15D1 
X-CRM114-Status: GOOD (  14.67  )
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

On May 20, 2025 / 15:18, Shin'ichiro Kawasaki wrote:
> The commit 444f0df9f0c5 ("nvme: check for controller device in
> _nvme_connect_subsys()") assumed that the nvme command always supports
> json output format. However, when nvme-cli is built on a system without
> the json-c library, the nvme command does not support the format. This
> leads to silent failures in many test cases in the nvme test group [1].
>=20
> This series address the problem. The first patch introduces a helper
> function to prepare for the fix. The second patch fixes the problem by
> checking that the nvme command supports the json format.
>=20
> [1] https://lore.kernel.org/linux-nvme/20250519054905.GA6156@lst.de/

FYI, I applied this series.=

