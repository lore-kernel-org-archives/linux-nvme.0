Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8EAC369C9
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/9JHTzlo2CtanlVkz0KSWlqpUN0MuLKYTr9I6j7v3o=; b=0bLpcDiSrPGQFiIO93+YpWgmRG
	VYGxBh7/JW3SglFXylerU5s5FVxeJ3Duia8mLVlQuCVamuDA2xLA8yYOgPx4qmZR2ec6SY08dmPxd
	s0Aim9UnRsxz9mVQeHQkKVF9TXKQ9181HgIrElQtkTE/SrT804CH1Ck4NKaHwDc2TKIMWxD4efA9J
	6Yxy9HqZkJ4uIsKQDazpF/qWem4ll1ZlzQ5tMT0vT52hgbF4UQQ4AQr0TBjgoGIvB/iZ7cvE1mwjD
	AnMkyxAdyblU0s/O4J++Iw32Eb1pnIMaDdNkJuNG0IvdfHQ9SsElDrIAHm+htWt1OipivDminKw+F
	Zg5LZhzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Sll-0000000Dmyb-3WKH;
	Thu, 17 Apr 2025 17:11:21 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5SXr-0000000DkYo-1nn3
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 16:57:01 +0000
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H9gaIa004458;
	Thu, 17 Apr 2025 16:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=4/
	9JHTzlo2CtanlVkz0KSWlqpUN0MuLKYTr9I6j7v3o=; b=KODNN/biwFQXs/VmHe
	+lY9XLtUm0QnNgS69kYPbfJW7y1C8V+YtdDqhaVvuXcWoK2UsX97pU/j/m6njezk
	KtD0ZZr3ggyrR9PuykdfDlwKouaISKnGauLCNjY8qPp0waSIXpap/MQA8SkHB739
	BEKem7WM1M3SHom51tuIR2mOymoE6HnG7fa3Idx6/D28DxRK6N+eVX5bSAtO6jEm
	H0DqTxV7jnqabeshXe32ipfCXQTq72m7BF+q5oOAapy0M831nSjLLui0Pb67fHTG
	An9o/M9B6766EQ9c9QQqRITpAW9gGFq2TAL7aYEB+G0hXVupofxqu/L02fl5TdA5
	FnOQ==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 462m2n8j5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 16:56:35 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8D95E80806C;
	Thu, 17 Apr 2025 16:56:33 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 04:56:21 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 04:56:20 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Thu, 17 Apr 2025 04:56:20 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 04:56:20 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF15DlTUrfhZ3LxtRWZmYTL/vm5atl+0v9pevm2JzPCz3F7StXn9vhaTvIhLFmaycjqe1T5c/lNl4kOnykTWaIVT7bVDR9xD5u0T+/VHEhocytpesR04LQEPW4g9oArEXe2tyXcNQp6ZzvEObXcNzjc3ZXOGxpCyaNEm0mUaGkmK3uRbyvoP/fBitXZIONWMvM4U3pNMEn33Ll9WURbQDrVZWwVpBwAX+WKO165E758toHnAAHgbsJ/VedokRzsVQYbaPBAYwJH4vhpc9N6rGUHqsP6MG0DYAFK4QckkeIA/MlF/Hh3b641zbNzizJh8eVPYvIGiWlOq6aqOGHqdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/9JHTzlo2CtanlVkz0KSWlqpUN0MuLKYTr9I6j7v3o=;
 b=N4E0bLPaRre7EH3THvybMqiLB4HY74x/rG0QZvFSUasyO01wZsCPm2GYzbhWMhuOOeYTZlwpAF1l5Dei46wpO1mjqAGaVgNZDyXOZ7kCZoZmwIG/VmUvnduQ4Yt41H+fhW9T2QnnUvRDYeL+NJCKWsThtHXrYEOrhRkNPmcYwAS9G8BEf2nzcvEuEnhYWADNvZOXdeYY6RsgN79TiRBr9aUep0fAwdAVYqmM2wyv4bGadBnuIgA6HO/soJyvx8bISIBi+eTC5iLQGBtFRvE2MIQLClpLQ7SWKHeBWvMi4HXZ8nY3s8A//ZgkyeqfVA0UL9ICNSYVq6q+aqSHCgOgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:166::10)
 by PH7PR84MB3183.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 16:56:18 +0000
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836]) by PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836%5]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 16:56:18 +0000
From: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
CC: "hare@kernel.org" <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Sagi Grimberg" <sagi@grimberg.me>, "wagi@lst.de" <wagi@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Javier
 Gonzalez" <javier.gonz@samsung.com>
Subject: RE: [PATCH 0/2] nvme: handle partially unique NID value
Thread-Topic: [PATCH 0/2] nvme: handle partially unique NID value
Thread-Index: AQHbrTBKVagzv7HJeUyKD6clMAKnO7OjByaAgAACygCABQ55AA==
Date: Thu, 17 Apr 2025 16:56:18 +0000
Message-ID: <PH0PR84MB1358448342C273E7C7BA808898BC2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
References: <20250414090959.2015-1-hare@kernel.org>
 <20250414111916.GB13225@lst.de>
 <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de>
 <20250414114128.GA13822@lst.de>
In-Reply-To: <20250414114128.GA13822@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1358:EE_|PH7PR84MB3183:EE_
x-ms-office365-filtering-correlation-id: 3801484b-0ae5-44c5-d7a4-08dd7dd0c629
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GHM/lYRcQnnSGh+E/6d1auHkdTxaCAuCW8ovm/uQikPYhjmvED58Lpf0dOnh?=
 =?us-ascii?Q?hpai/0Wf9DTQVdvF6TwozX9Rtjt6FNoPPSs35/T6GwdIfwiPha+bJneO2q58?=
 =?us-ascii?Q?Wpx2v4LNx587yWGdblNWtR0TjeQCsClxoohlVwWfOGqbnMJBW+w1Lub6Zsco?=
 =?us-ascii?Q?krazBUuwYEWDfbzq3vvmIDVkaElnAFodEiO2IpYA1mFY14R9cIlNiEACykcm?=
 =?us-ascii?Q?pMGZu7UKtcXvRPbFKOxq9uHE37ehZBGTyl1e2BbbhiSRtz90LwuXtiNA5aLQ?=
 =?us-ascii?Q?9wf32OoL9Jr9DRGWmd9v5g04j3GhhS+0gTl8QK0vxj8V/vEbCw+XmiZ24DTo?=
 =?us-ascii?Q?ZMf+fDJ965yPHRSsuu6m+uWTI6zmFSz6J/XPK0TJVl+Mu9L2jl0wkIbYcw3F?=
 =?us-ascii?Q?OCnA1OoYZfhTYZEMCny13kUTsO2gSqaeMlG1ILevasH/MPecJdYBAQ6nJ/tS?=
 =?us-ascii?Q?4ywx5Uf6XFwQuGCcMLQgpVunezXTQb1Fk/GWqpbEHy6sIgqVwPrHQhlo3T1V?=
 =?us-ascii?Q?lF8Anr2Q4JoHKtBx68UcaTDwIkVg4bgqx5A8Cw9A5C9WtmjN+vpmNYuzroUm?=
 =?us-ascii?Q?fZWZvNKmc5J4ABbwLfWy57wyES/2ANymaMcF6pnRXj4vEt4omG0JlPFLupNf?=
 =?us-ascii?Q?ebMv2V+I7HUAZS08XFUrfoR8tVlWidBOmx5gVfAEkyrYUrTnrSiBhHW/CRo1?=
 =?us-ascii?Q?wre/5rEDaXaCmFqfEQLdGi3NoEZBmgViXnKvEiKygJaCTyziXQSFT3EciugZ?=
 =?us-ascii?Q?cuJ/gOL76jNOTeTnRTxJCY6ViuyE2KRv7WDWRf6aibUVf2g5Lx4s7n/P3jc/?=
 =?us-ascii?Q?8CLAmcZhIwYNlGc2Inchb6k4k+/4YpDyEdLw/9EKaSEZkasyJA1Nu6zqiC3B?=
 =?us-ascii?Q?x+cl1YhlQVG31XUG+y15rhOtdEAj8nAwPf2u0ERn8g+2oFOzYB87meZf0+dZ?=
 =?us-ascii?Q?6IJzJYprhHxo9yibZeypTf/s7+ShyitPKWjqrrildcKZfXN5uDf4412eyq7M?=
 =?us-ascii?Q?ZxFmOeTOefEPxUNrY7YW/rtzBHIacQP1FUkFCmYfndrN/pyif+emGIvdJfJM?=
 =?us-ascii?Q?wL3WP/4BTqjaVtBimGBqzrRO/O/68HjQrQYN2QJgscYOPOZOfV4gcZ/i6s7q?=
 =?us-ascii?Q?dGZz9oBjmXg+JyfLrQj+5kphkyGApYWeWk/FxBzaIPwYlZb8VpkLC7hF+Y0N?=
 =?us-ascii?Q?+7pgZuXH7My1+f9DCpKjwod5UgqC5cuiABC7dz9A47R04zKr3f8QdENNpWV5?=
 =?us-ascii?Q?Y9oF4abE+MqRCDGATf99fkIn66aMd4q5zmuZQg8lgv8DnV5MPW4KO750lCvM?=
 =?us-ascii?Q?a7VPj8XdYMBGwEChqUsnrDie65PBA+ufg9WRDfHH8fuLUGyKl/kp3neJgNUV?=
 =?us-ascii?Q?c2pEL0hVtCJNSPfN25ZQxCfrt3cW0roCpHTZ+QflS8JbIfzWTtBgeAyNYF15?=
 =?us-ascii?Q?+GnE3ZSXcDGSPBTEYKyV/IS/DqIIuaq8bQk/E/nR0DpBqpbavUjCNQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F9PixbDLcz24qeQlDtb9aNbaywKPs9hxn9sAvmk0frz/TpoV+e5DdAPO/Jld?=
 =?us-ascii?Q?ZcyyIMIcWsq3bAL+Axcyq2O5KQnhXrIsrznzMY3GdJONb5cTpJGbHDiQG4Gd?=
 =?us-ascii?Q?tnbnYP+g7+sLBFo9S5zeI+/kXgSGQNr95x/hTDqzq2BCCkvPuePCYPUTjzZI?=
 =?us-ascii?Q?OGp5Z0605HpUixtuknZscz1tJ6bpgh2Gxamc2vkZO5Vh+kScsVJFbxWPek95?=
 =?us-ascii?Q?Yql7PT12sUR4keh7rqZpwwjA93FnqIDUTR2nWcaKnUy0EOBKAdZMD57UyKjZ?=
 =?us-ascii?Q?mnWamimklZvTAh9TYSP/hvNZrTCVwL5VH6TfBbxUrCFaTqEOtt/NN8RirKGd?=
 =?us-ascii?Q?2N26Ws9Bu8el/0zyqAXCUBsrnlAdLxVjU6X1E974BwCOYnbctPW0ApWPBGUH?=
 =?us-ascii?Q?8tEMDWKdFlx2wA8q+9eMjQi6YNJqk17udG4fjCn5THNHTOmRT5e8SyTo9s1d?=
 =?us-ascii?Q?q76plF3bIftrf4MkRadI1U2l0JYDIt6b7hTLDOCp3sxmCE/8ZPA9XuTJi42U?=
 =?us-ascii?Q?fHYjJjYuseTg6zoD6fMf/CS50J/NgCJFFLxUHJy74VDSbJgeiw4iglASu3sV?=
 =?us-ascii?Q?uR2HSPlvKnoDcUwkRFCigBxMsl/S6l0Vc5sltKVbNWUsRzDHw1flZOfGJd0b?=
 =?us-ascii?Q?qHKDye/UB6m8iKVodEyjoxRba4kU7s0ONIYfWih1BQxIXzxqJ4Ed0obFwV12?=
 =?us-ascii?Q?LSQwXLa6EtjBrZr6xUxK5fnCFuvO4n9vLdB461Nv0oae+l5Lj6uNaCGwLR2A?=
 =?us-ascii?Q?N5jQUOzoEk7pPOtfD61UNtu/rkC76n7uH4gZRP4bsHc6QLZEFDY/ClqjndXk?=
 =?us-ascii?Q?QuPZV71EC632bUJyp0Dv4ZSvREk3J0/H6ALG7uSCWYK68V8NnyQN4mr3dw6S?=
 =?us-ascii?Q?AvkyiSlGfAdjMJWDjLpdP4DMWzZiINHW41CDMmZYjXaubI48/dcLnz5i3MF3?=
 =?us-ascii?Q?OC+t3IBmW27EEhSh6m1l5xQ1KhLGmRb0Vnks/U8oOky0TwqdheAjhG+51VwF?=
 =?us-ascii?Q?VqJ6spQQCpXtFyqUcxE3wdS97DWIsOkPCkFXAJ82rbsydgx8pnlxYAgpVi9P?=
 =?us-ascii?Q?Ik3lrLvEuqYa8nKYU+mFuT0p0i3Up84cho2ebJmgD2P8fCWV0DHPmrL/KFlh?=
 =?us-ascii?Q?PUqucD+7V1ZlawgWVhVjaWGYJ5m/+USSyP6YZjgnpklSn6ZeAnzjM9qQ1oid?=
 =?us-ascii?Q?2pw4zsqu8R/zjAA1pZh/Msn3d64aH1A+9z8ldm9KwyZHYM8u/0CYDnkuW1PW?=
 =?us-ascii?Q?735ooX2oB/8jAdn7qyzOtgjnGzORuYJ/Z6dKVamuqALZgQ/J82JmgdYcM31h?=
 =?us-ascii?Q?gWaWNFdmpelAgJGvSjaVINSmw5/3x+rsa1c4H6iS4Wc4OH4GUWL8akm2ZQX0?=
 =?us-ascii?Q?ODJbBCtHrX5ivf1u0nN66ihdwwHK4fxjDlGG/nc1VgTEgKT+DcXi7daMO24F?=
 =?us-ascii?Q?Y8nGCqFIxxmG+RaZwAetd4GtJ7siCESEPJE1NS+NUFeD92iBLxqBnz+23+1+?=
 =?us-ascii?Q?ZcPLpxJy+mBHc5ZxmUBwpffk0o6e5z87snabq2ytdO/JfDr8AOCgPfDOUtv1?=
 =?us-ascii?Q?0YYjSlgW6FFqnBhoW1n98TXo9wTrCh7d9lk/kTT0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3801484b-0ae5-44c5-d7a4-08dd7dd0c629
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 16:56:18.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: me5zdd5zzP4X3/cB/nZJy+HbgFw8EQG3aNkYfhDrvhgtEPs93W0Xg+dbb3/EIwI6pEPiLxKI36Doc9VYNxjaJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3183
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: Rvn0qXrcrUyiV92K6shoZz8g8Ts0fCnw
X-Authority-Analysis: v=2.4 cv=Jv3xrN4C c=1 sm=1 tr=0 ts=680132c3 cx=c_pps a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=MvuuwTCpAAAA:8 a=hD80L64hAAAA:8 a=XXwXks2GSaPK536mbmUA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: Rvn0qXrcrUyiV92K6shoZz8g8Ts0fCnw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504170123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_095659_712525_CB7B2216 
X-CRM114-Status: GOOD (  24.88  )
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

Christoph,

There is no debate about whether the NID reporting behavior is incorrect an=
d
has to be fixed. It definitely has to be fixed and is getting fixed for new
drives.

That behavior was a defect, not a request, and I have theories on how peopl=
e
that probably knew better missed realizing that.

Unfortunately the incorrect implementation was missed for quite a while and
there are drives in the field that have a correct NGUID and an invalid EUI6=
4 in
some specific configurations. There is no simple fix for the drives in the=
=20
field.

I've seen some reflector traffic that suggests that similar behavior has be=
en=20
seen in other drives.

Since the NGUID is valid, and is the value used as the unique namespace ID =
(when
present), the issue didn't create problems in the environment where the dri=
ves=20
were being used until a uniqueness check was performed on the EUI64.

It is a very serious error that the EUI64 is not unique and it is completel=
y=20
appropriate for that to be flagged.

Having a quirk of some kind that allows the drives to be used, when they wo=
rked
perfectly previously, seems like the right thing to do.

A discussion on how to appropriately flag this serious error seems to be in=
=20
order if the method proposed by Hannes isn't acceptable.

Curtis

-----Original Message-----
From: Christoph Hellwig <hch@lst.de>=20
Sent: Monday, April 14, 2025 5:41 AM
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>; hare@kernel.org; Keith Busch <kbusch@ke=
rnel.org>; Sagi Grimberg <sagi@grimberg.me>; wagi@lst.de; linux-nvme@lists.=
infradead.org; Ballard, Curtis C (HPE Storage) <curtis.ballard@hpe.com>; Ja=
vier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value

On Mon, Apr 14, 2025 at 01:31:29PM +0200, Hannes Reinecke wrote:
> We have discussed this at LSF, and the involved parties (ie
> Samsung as the vendor, HPe as the IHV, and us as the OS provider)
> are happy with this approach.
> And we have paying customers for which the cited patch caused a regressio=
n,=20
> so ignoring it is not an option for us.

Tell them to fix their broken systems instead of shifting this broken
crap upstream.  Really, we bend over backwards for consumer hardware
that doesn't know better.  We don't add crap for vendors that absolutely
should know better participate in the working group and only provide
expensive enterprise hardware just because they pay you.  If you have
so little spine that you want to accommodate this intentionally broken
behavior do it in your tree but don't force the burden on others.


