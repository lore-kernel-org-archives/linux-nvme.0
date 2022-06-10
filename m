Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF1C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 00:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/e6biD2HllUiS/umLNRzcn9rY3mxBCHsZk+aPlj8Yw4=; b=YZcxefOnUqJyCGpsnGqAEEGCaA
	kNiHvyby8Yr+YLy7Zx4o4bmOkBdSznKV9qkssR+TfYiMqr26tKQO6rBQqQutrGwZx/aBSs0DLpts5
	R7+ayhec2cKwRmKvwRnbHLnLIzdNatS7S7b1PfguilOqkKAA2Dy48OMoiwCzNroyz3b312CYifQYE
	2csQpFb5VwJ5i+MSzGirnJSJKoqWrukInBkAnAhJz4wLanms9ejbF2yDxn+upLEL7wdqSTb0TORMf
	CrOTuVpsCQo/BwmWkl4CiMoY+HBAg/DDmZxv+QMblhLC2enotm6THeNjd5UgsWa5YAic9n5soLbCO
	oBMXZ97A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzSVJ-004mrv-Oi; Fri, 10 Jun 2022 00:27:57 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzSVD-004mpc-Go
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 00:27:53 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259J4N2K026668;
	Fri, 10 Jun 2022 00:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/e6biD2HllUiS/umLNRzcn9rY3mxBCHsZk+aPlj8Yw4=;
 b=JxdMMvooRCPyOc3my0JBEz+eorpy6H4YksIuhlj8ZHcSYs/T9/PPjqNMA6WsCbOd2X6T
 M2WHZ3o9njzdopjf6vk+MEmZ1hTbToTI/5bRqAUdpZ73X1/zS+I+qv9i5UXFlY12wiXL
 OM/lF5JLd5lqojcSvhT7TrvEvICoaFPBkKAzMcBFombpJKccYWTTIxgX/BNbss4+/Mql
 vDugImozEZEH3UjOgwuGBTK5QsSUD2o4Y2tc84h6KmtErEW3flqhL2c60Fvg6U1qN183
 +rfmNSvpYoETDwWarwdbDgZK8LF2Q5NI96JnhKfcEykXn/D1bPM3Rr8VWi+G4/JAhf3G Xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekme14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jun 2022 00:27:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25A0A5ZV018099;
	Fri, 10 Jun 2022 00:27:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu59qnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jun 2022 00:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guyr5BkyKZgFnkSp1NS/Wzd1kx4KLi+RcckInS5+GnmImwdtErlwYiWr1Qd3yGAaMbXvWC5NMHLLeOcw63mSnKxpl+NVWAZVdmTJxeZr8wQA0zNgChr3SyLJnsQR5TGJIKj0IhrVhqMn3rgwLDTY/rfR1bxBMYS6TmtyqkhGBQx0Wecbi5kr/lBvgAzVSgtawxVbfaFOtqlCLsN1kWYYOkqHq4rXSKUtu39xm+0uSufyDeRFnufOBJnNbwEs25jjGOJWWnc4y5+P5Nv9FPNsy8WQJFZ4wfzSn6CPIJzz7gYBaQ4K98qZQ+4R/6GEDUPPVzz20tS7NNJIV3m9EoKhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e6biD2HllUiS/umLNRzcn9rY3mxBCHsZk+aPlj8Yw4=;
 b=gY2vfZ4crIIAKH6XvEhRddGrgzwEVmWnrb5NVpShMk8jAY7MSKvOwP+PtJlb2QV609w+fOJ9AzJLHkD2OA700U2cflFGpIQpyfGT52RhirMuA3iPliMMGH4HQdrlXeqWjCWCal3aaTcFCxAvruB66fStQxqc/iTyHehjHLqTNVVTP6Qs9omz5/CXfU084bGK0vxhCLekO7Z2utDjoajCAXuMVMjXenjU7LFUm1Q2fITnBhveblxd99rcLKnejfDhMQ0gztFrZYMYHtLvnSW44zXJTq7QZhc/14Pgr+g+Vsd059w+mvfrNf1SQI01BwfKZbeBKAZ4usLHL0q6Ev/qLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e6biD2HllUiS/umLNRzcn9rY3mxBCHsZk+aPlj8Yw4=;
 b=ALWKRAS6wk56LYYtqnk8R81AuYhpf1co+7uz+Y1AaX/btf65wY5Ya+hnwnP+7HZnon1xIr53cyXh2oyAAj8KQjCeRUeZidj8Ii04paDKe+tEUrJAcFM7VIA6TbN0ka9iP75CDsRPYBwmlooe6c/HycXrS0fX/DcRbi+FvCYQohE=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by MN2PR10MB3341.namprd10.prod.outlook.com (2603:10b6:208:12f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 10 Jun
 2022 00:27:25 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5127:4537:1880:c8e0]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5127:4537:1880:c8e0%7]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 00:27:25 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index:  AQHYKbXc39T2BoiygkiETee4KuxaGazldeqAgABJzICAAB64AIAAlJYAgAAa2oCAA+JBgIAADcuAgAwnQ4CAAhongIBKtzYAgAJPjACAAKy4gIAADwUAgACTr4CAAVjIAA==
Date: Fri, 10 Jun 2022 00:27:24 +0000
Message-ID: <6ACB62F8-BFC4-45A3-9886-E05DB45248D5@oracle.com>
References: <20220408161052.GA28661@lst.de>
 <YlB1E/p1uqpl3HiN@bombadil.infradead.org> <20220411050533.GB13927@lst.de>
 <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <20220608075252.GB13027@lst.de>
 <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
 <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
 <20220609035323.GA31248@lst.de>
In-Reply-To: <20220609035323.GA31248@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc7a9e76-4c70-4471-7080-08da4a77fe08
x-ms-traffictypediagnostic: MN2PR10MB3341:EE_
x-microsoft-antispam-prvs:  <MN2PR10MB3341660F1C1744482BD3498CF4A69@MN2PR10MB3341.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  DgJmnf1NNUYZ/iD5mH1rpOqWuCoaX7fnxb3B/dVPO4Kusku7MKyeZ2TgXC2BVwtB1BXi0XacuaYf5jdF2yV+2E4yrmLW/xw8vBMeP/zlwC7YR5VhCTmu7e0o2wv+q7eNcKIF4MCHchFDk+OgbCMzmgz9XuOeXQ2nZjJLFPY7jiZGSM5TuWrLuti7EE6Upx8x7fYR74OD/XtHzppBna7p6MHFajdAySqGA4o9UfBZvcV6uVza1WGSsnU5KMFs4ZSJKNLqfdUNWEoJJ9dP++uoRpWTa0VRwhD0HOF8rQRHazdRDlEmgsUIOivdPQO0BT+r829PAMQj0HsfQbiCvO4jyVwO9E9951XzL5C3Zj9a+BhnC0ZM3TxKhx/AUKEyI3aWeDroBi2NtA3Q5+8GHNa0Q4Tv1/4axUy5ADpSYFaIXInI48wL9iWnPhCQ4SvD+kjCoFOn77elraxYrm8igdn3cJw4W5OJ3+8ei41L16Z+QCAVpGfMSgflxHRfumcpBjqEX3p+qzphIlZ8WIk86zZnI+iTDiOHS+pY29Htg+nm3dlOKbbWO1XWQ8xYuS/UHQfvDSY0ep3EN14RI26d05RQbZ8z+5ryOvzn806to5Qh3kQ64RqWe6fZTTP9Dmm0fforfwdFmxIqc8aLbymAeX8Ymz3tj8AlUqbtP/DwLIxiP7priBA86HHeB0d+f2P90hq3+1UJZyAVFpyfcO4CjSuk+lHYPK9cMtCUCwdk3f0ytGbI5Pn7B9u5Vl3KzH2km6kI
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8676002)(4326008)(8936002)(316002)(5660300002)(36756003)(122000001)(38070700005)(91956017)(66476007)(66946007)(76116006)(66556008)(64756008)(66446008)(508600001)(33656002)(38100700002)(44832011)(86362001)(54906003)(53546011)(6512007)(71200400001)(6506007)(6916009)(186003)(2616005)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?MPyctFc/h7UIggsS9va8omIZksW2Boelgn7gsyulOBRiSJgdjXW3XfxkOAMs?=
 =?us-ascii?Q?CuJnWjPi5nnPyw2B1lgsfmHU6gLMM1y84ViBFH1Y1KWo9yH+6LD1+z+hNsIX?=
 =?us-ascii?Q?S9DPwyqpKuytHC2AUttXQqrj0hQR/nEk0bK2chEkqXCDDjRbSONmYMtZRBDY?=
 =?us-ascii?Q?+XJPp1Xo0D2sawLabYQoyRPXnk0k5BoLYqb8M3J828nTVd6voYzIk4CdG/TX?=
 =?us-ascii?Q?6kYeL6IHnl/ofHoiWdfPHjU4RZ9c3PQpmMxvoSQQ8kBYA463z+HNbFvHxHXc?=
 =?us-ascii?Q?6kcejMyqLEkkz9S9rO4EjBlvYSMDdvzfLD4MtBZ95hcnJT/kvBPv8NJwAHyO?=
 =?us-ascii?Q?qYlb+Tbw8M+zfH355DaYfIuiMbZc6CCcfXW5GT5CZx50V5ZNMBE/aHTGupvk?=
 =?us-ascii?Q?UOLPXHzC5Wl/9qfon4TWBGGIXCUfpNqNhNYF8xFGjqkVoTeXBdbHPRoK998z?=
 =?us-ascii?Q?l00nJkx4BO9JVJjfLbp7L1R74WPMQGqZVKt06GLEHoeW7BNlVjDa8dGJ2mBw?=
 =?us-ascii?Q?1JqcvrlxsSb/UgPm1Vwe8Yg+MW2aFPcRVcfuq+vCU8F5EnPg8bvs3AI9jdST?=
 =?us-ascii?Q?iYa59/S06jccTfQve9PXfyU8lS/wy32euZnLEy9tL1uYDbzEDFGD116NAZeF?=
 =?us-ascii?Q?7FSn7oijgFXa9CvlDsHQ3GVpEvFlzzQCBe9/8L8cUfgRF5WcLo18aVqo0IQR?=
 =?us-ascii?Q?HWMyG+yw/sGlrvCxw9JUDrQvgLv26o2nLcSf7dZPphzTH/4iX4GXMxapkMvl?=
 =?us-ascii?Q?Ur/MsbWvj1ISe/esx6YMCFTof+7EcOemilCBX1e8vPkt7SicH4/YsfyWkUY4?=
 =?us-ascii?Q?y/LkWxm/bsWe/GBGBWVHv2B2iAPeOMXX5hrkfFb0U8Owz39aSpAdaLP3CFPZ?=
 =?us-ascii?Q?Xr71RQuHhem9mD3uKaJui5MY0WzHFWGeV4U/w78T3Ubog0H2420NcNG4vkXi?=
 =?us-ascii?Q?qexMGEi8xrdajeDNJCLKYkLVMygUwy5e57sVa0fJ6TKe1mpgGxaZD55WvtRN?=
 =?us-ascii?Q?kwczlYqyIMVgOt32CUV6yZRQwpqZHfG6zM+/4oEUh8+nJ3HspZKNGa1btTJ7?=
 =?us-ascii?Q?uqBtJkRr+dHdtpv1cauGNguYIYgwTlAhHzoljNP2cK6aIzP6IXj6E8CBlmZc?=
 =?us-ascii?Q?g2hWqge8Vwf1gNYqS9Gw4z83y6rKzY/UMsvg8Oo+qgMH/fBoLXJ5TuMtYop8?=
 =?us-ascii?Q?cePtFOvXCg0z2rbOS3w8dbvI5Jm2fr7YaGEdGFrg2qFTMDq0SoQZ2nqTW/rB?=
 =?us-ascii?Q?atSoNxsU+YV4dohoCMeOh/0WbbZPcfZLHrE67qXeWRsPPamKWGJwtwUuKXe5?=
 =?us-ascii?Q?90f9Q6db/uhsyBDz+Z72YbfA/m/YCWnQY64ZFq+Bqe82jVIUiJWEAWNdbMcA?=
 =?us-ascii?Q?NOYBsohUMvUwueJq2IK4EbjUXppb7sfYMG2LeT2YRI8bTyjY5rEB7HwlGOat?=
 =?us-ascii?Q?vraqYbFdfhTIfpz3oQD+PZ9GcEkrNT09gMHrJlZa+VldFjLagETXRwa1x0eE?=
 =?us-ascii?Q?ea3t/DpMmdWTMkGRWLg02fHkJri8An5j1oobUBiJsY7ywJAZKId4f2h5xADH?=
 =?us-ascii?Q?J5AWazXhgclKasKC08NfdFVT8iE5pT6kkFbpotJb3CLHXhYAbKLGMkMrgfYY?=
 =?us-ascii?Q?zlpTnLZRnHOuEQEg92POncCYvqkmjQsPH5TvIIi99upHZg79dfCmg6M5ONAv?=
 =?us-ascii?Q?xyk0mpLhGnp5Sgh8PbwxAqfOEUBhRQw8KbieGryHI6uALeUxRa1VPQhADztI?=
 =?us-ascii?Q?TkTRfVIH8X5dLsd/kCOgcS0CkuUWtusOP0jDuv7uyYiCm/PeKdrMISHr9wwF?=
x-ms-exchange-antispam-messagedata-1: pVEZpbQ543NTOg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A221156E578704E8A6B662046737385@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7a9e76-4c70-4471-7080-08da4a77fe08
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 00:27:24.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDJti2/0/pRzHAQT0lgnhPCWKeZiV3b3t/fwu82NhYZ3PEEsy9RnsnBwd1aMJPzc5Y/A93l5gxKajy4yLA4C2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3341
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-09_16:2022-06-09,2022-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090090
X-Proofpoint-GUID: IMqRCt3YBJLuO37BkMtDrt_WtAfOz6Vj
X-Proofpoint-ORIG-GUID: IMqRCt3YBJLuO37BkMtDrt_WtAfOz6Vj
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_172751_711107_5DB420CE 
X-CRM114-Status: GOOD (  29.15  )
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



> On Jun 8, 2022, at 8:53 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Wed, Jun 08, 2022 at 01:04:48PM -0600, Keith Busch wrote:
>> On Wed, Jun 08, 2022 at 06:11:04PM +0000, Alan Adamson wrote:
>>>> On Jun 8, 2022, at 12:52 AM, Christoph Hellwig <hch@lst.de> wrote:
>>>=20
>>> How do we get the clear_ids setting from the connect to the target?
>>=20
>> I'm assuming something like this (untested):
>=20
> This is a good start.  I think we still want to allow setting it
> in the fabrics opts to allow clearing it for say a local passthrough
> tcp connection.
>=20
> And of course clear the identifiers in Identify Namespace as well.


This code works for nvme_trtype=3Dloop.  Like Chris said, we should still h=
ave a nvme-cli
option to allow tcp to work.

Alan

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 46d6e194ac2b..c7448c11c87f 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -68,6 +68,7 @@ enum {
        NVMF_OPT_FAIL_FAST_TMO  =3D 1 << 20,
        NVMF_OPT_HOST_IFACE     =3D 1 << 21,
        NVMF_OPT_DISCOVERY      =3D 1 << 22,
+       NVMF_OPT_CLEAR_IDS      =3D 1 << 23,
 };
=20
 /**
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 59024af2da2e..6ba9e4bb011c 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -687,6 +687,7 @@ static void nvme_loop_remove_port(struct nvmet_port *po=
rt)
 static const struct nvmet_fabrics_ops nvme_loop_ops =3D {
        .owner          =3D THIS_MODULE,
        .type           =3D NVMF_TRTYPE_LOOP,
+       .flags          =3D NVMF_CLEAR_NS_DESCS,
        .add_port       =3D nvme_loop_add_port,
        .remove_port    =3D nvme_loop_remove_port,
        .queue_response =3D nvme_loop_queue_response,
@@ -697,7 +698,7 @@ static struct nvmf_transport_ops nvme_loop_transport =
=3D {
        .name           =3D "loop",
        .module         =3D THIS_MODULE,
        .create_ctrl    =3D nvme_loop_create_ctrl,
-       .allowed_opts   =3D NVMF_OPT_TRADDR,
+       .allowed_opts   =3D NVMF_OPT_TRADDR | NVMF_OPT_CLEAR_IDS,
 };
=20
 static int __init nvme_loop_init_module(void)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69818752a33a..facd9706d67c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -300,6 +300,7 @@ struct nvmet_fabrics_ops {
        unsigned int flags;
 #define NVMF_KEYED_SGLS                        (1 << 0)
 #define NVMF_METADATA_SUPPORTED                (1 << 1)
+#define        NVMF_CLEAR_NS_DESCS             (1 << 2)
        void (*queue_response)(struct nvmet_req *req);
        int (*add_port)(struct nvmet_port *port);
        void (*remove_port)(struct nvmet_port *port);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.=
c
index 5247c24538eb..2f182c7f35f5 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -30,6 +30,37 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl *c=
trl)
                ctrl->cap &=3D ~(1ULL << 43);
 }
=20
+
+static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
+{
+       struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
+       struct nvme_ns_id_desc *data, *cur;
+       u16 status =3D NVME_SC_SUCCESS;
+
+       if (!(ctrl->ops->flags & NVMF_CLEAR_NS_DESCS))
+               return status;
+
+       data =3D kzalloc(0x1000, GFP_KERNEL);
+       if (!data)
+               return NVME_SC_INTERNAL;
+
+       status =3D nvmet_copy_from_sgl(req, 0, data, 0x1000);
+       if (status)
+               goto out_free;
+
+       cur =3D data;
+       cur->nidt =3D NVME_NIDT_CSI;
+       cur->nidl =3D NVME_NIDT_CSI_LEN;
+       cur++;
+       cur->nidt =3D 0;
+
+       status =3D nvmet_copy_to_sgl(req, 0, data, 0x1000);
+
+out_free:
+       kfree(data);
+       return status;
+}
+
 static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 {
        struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
@@ -127,6 +158,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet=
_req *req)
=20
 static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 {
+       struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
        u16 status =3D NVME_SC_SUCCESS;
        struct nvme_id_ns *id;
        int i;
@@ -152,6 +184,11 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_=
req *req)
         */
        id->mc =3D 0;
=20
+       if (ctrl->ops->flags & NVMF_CLEAR_NS_DESCS) {
+               memset(id->nguid, 0, NVME_NIDT_NGUID_LEN);
+               memset(id->eui64, 0, NVME_NIDT_EUI64_LEN);
+       }
+
        status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
=20
 out_free:
@@ -176,6 +213,9 @@ static void nvmet_passthru_execute_cmd_work(struct work=
_struct *w)
                case NVME_ID_CNS_NS:
                        nvmet_passthru_override_id_ns(req);
                        break;
+               case NVME_ID_CNS_NS_DESC_LIST:
+                       nvmet_passthru_override_id_descs(req);
+                       break;
                }
        } else if (status < 0)
                status =3D NVME_SC_INTERNAL;



