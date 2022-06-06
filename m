Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69B6C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 23:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tVlcD7bI51Aajdf6+rvBvD2RSr02PomIcvkBZu/o2A=; b=heGMqb4wuI2VDEGIWtABkf/ZNT
	jJZN7hgadxITu9g8Pz+69RmKPuIJ89mMjh1yKZC7vJX7WMPSyAE06ItkZLEdepWqzu/HUXbE+eXpO
	mtlWhm5U3J/iJIMMGOwZV7xNqitaL18ZzGjiko9aht9TlpppJxsdSZUeGNM2WQH2bHVYyDOjNBMC/
	eVJfd9ved/HAj5kJ4iM4GLEvZ5bIDTxg7TCq/Scu2F2JArLFdvgIxuq8ItcQlqv7bfpf77U4Pl4Sp
	z0qOXtWOC3GDOc74pOYcm3NSLbDKP90tL1fCtwj5MPF8Htlt89HUPNxGaH5IBwM7OnyYgWf+4s/hB
	2qvES7kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyLsw-0036Ou-5n; Mon, 06 Jun 2022 23:11:46 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyLst-0036M2-8W
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 23:11:44 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256N9NlT016103;
	Mon, 6 Jun 2022 23:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1tVlcD7bI51Aajdf6+rvBvD2RSr02PomIcvkBZu/o2A=;
 b=dYMM3Pj4Y1K729bsID5trpF6GsCOvIZGL7WV99anzANTgCc5l95uQk6IUqZrooK+kEUB
 tQ5e4QUDl9ItDPWEGBPsSkG3krXiVD1DPIx9V2oB3/9cC/w5vdDrZT0X2azjxggTw7qp
 NRLyLfnRi3dnTreFBTG0AcGp3MoJCA8qld8cappPr9VFndQJ3DXtpMvveKbF/670x2vl
 4tmS6ifqhILoFxKQ/j5nRj+WSOKKoeDBycLUoCKC6I8/dcts7UyzAtLikHqbmsPn9wbb
 oNkZzoNjAIStnEp1UOICK5Y0GN9Lhf5YREqpO2etty5dQxhrhl54UWTncKj9+yAeVtou Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexe9q2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jun 2022 23:11:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256NBJJ1028352;
	Mon, 6 Jun 2022 23:11:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu94kv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jun 2022 23:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klAFz3QSslKUoUVepmZlS5z0LaL2p61S9E1tVu4DdQyDVmS11Z0g7CymCf1HvTo04OHeCV5bWHYwOFRgksY8ix6yTBnzbrIMm+pHznu8Mxv6G9spzP7bt0U+RAyAzv2K7eOF62bPc/YSRJDWVxDXCYjkxWRaZ/9Cl4HSDJwdTOqVUfkjH964qd7QcjuPJaWF+rlGy5pMdlToP0C136gN6RJb2TRWPOQ5gmhX2sX9RLz34K4yh7wrhaHDJ+dVEt1Hw+H8XVVX1Wzm0bWv6qsMFDSZPI8FiTlqJmnDBCyby1p/sSJd8sRjxfyjcwjBG4COXe3GMCsDjUt07V2RWlpVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tVlcD7bI51Aajdf6+rvBvD2RSr02PomIcvkBZu/o2A=;
 b=a+NcB1A2B6R4X0jOTnDYMx02GC7do5m1gmtEQ9G1CeyLRljI+efwaY5HHSNPVATr8gpmmZsddFuIMnyNr2Z+nTxBspQ00dhAKveO2eulE36KcRNEEkINEGdbjiGvyWVnB4GnpKHT6m4XBLVuJiO07LrUt1EZxFFOp2KMRieoIxOcc44o4m5s6UOmIiMQmnT1uyN64l2mxOKkX6xemV7pEaGqmVCIYji6vHVnmn5mKzx9/YcRDkOZKpGyeY5j0efO/k7YrIHoZbhtZQNvbfvxx0uaVFOsqAlS9dhmIu1vHag6NPatrY7VDwzfJy+0oItwNgBLNnrk81c0SduRbAAYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tVlcD7bI51Aajdf6+rvBvD2RSr02PomIcvkBZu/o2A=;
 b=C34ocSyMBia/eX9BzPZ4A4oRXXtlMB87xCqdHS3kqny2PAyJPQO7COrr7JyRP5EpqWSrwYTxAeoDqvAeGmI8s2X1ABYWWIDrT0Y/GkKPm0s8Qffa2bfH4QfTbHQ1cb5EV3dtlDVp1RAghMusc0wE5REogVzRLOzJq8vWv2gUmT4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SN6PR10MB3440.namprd10.prod.outlook.com (2603:10b6:805:db::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 23:11:22 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 23:11:22 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
        Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index:  AQHYKbXc39T2BoiygkiETee4KuxaGazldeqAgABJzICAAB64AIAAlJYAgAAa2oCAA+JBgIAADcuAgAwnQ4CAAhongIBKtzYAgAARsYCAAAOfgIAAAc+AgAAUY4A=
Date: Mon, 6 Jun 2022 23:11:22 +0000
Message-ID: <1FC6870F-6BCA-4C9B-8F90-C14469A542AE@oracle.com>
References: <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <Yp5z8b4ec5tFt9qk@kbusch-mbp.dhcp.thefacebook.com>
 <84C629F5-BCDC-45FE-88F0-83DCDA06B93E@oracle.com>
 <Yp54fw/FRQ6KhP0V@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yp54fw/FRQ6KhP0V@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d67532a-5cfe-4e47-8af0-08da4811df2c
x-ms-traffictypediagnostic: SN6PR10MB3440:EE_
x-microsoft-antispam-prvs:  <SN6PR10MB34406316B8C8788B31A5BA1DF4A29@SN6PR10MB3440.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  LFSszUafCeAV9KU3Fh7zZaXp6Lh7vm6CteiPDgwD9NqbBnkg0bbXhoxRtwTf4qNJzRHYFk0dJmM9EFfp8wIeP3QbvHpaNTcb4KCBQ9f2whkYyrhKuyKKzFxZX2fVqFerMKo++eH+4dIrQN5vWdvWkyAB7zlGF7E+TncuXnXZXLigYoDYj75EAsBnjqQMy84/+OB+E1SvyyMdlDsez/ezIK2NpvzEJ611aqBWNe4+zUQGiWLj1ks6Vu10c/rVUW2rys5hwQOC12xa9IBa3DwChTvmSvtbwuVZWGvQ6CMp4c1w835Mxwj2xtcr1pyvWBr3AgV2bsYW46QqMJNlLrszXoui145iUmi694ZBO6po/WtrOV4LtVNbPho6F4aj2ndnPvY9KoHs+Cx3Lx0KwAzO9uyAHECQcvUMgxjWt9rwaqMit/pWD8V9aeJznqqBxOJNkVngsD6J0mWR0g4F/KH4yg8JVHkhUafOzI5bqNmbd86nWNWuttmdfJP1lG1atZIlYWordBY8e81cRt5GOagwD37Rt2S42NeP7V7FBLxoU35SFby8S6Ye4Y+6e+y/GVAGXJw9RvYKZoP/oNshqWdKGlm/GYHLhhbWnd72OTzZS19b7EgxzivN2PTLETDt57i6WrMX8hEDHsFnI+2P7Ty4bt+fmKMLXogc8I8KCO9b1O2XJTwi4CwA2vO6V6NhDliMHPoHRP+gEYzhpOUcdGayQ5uPbsLampl8Uiw6nuIG6lA=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66476007)(38100700002)(54906003)(76116006)(6916009)(2906002)(8936002)(64756008)(36756003)(71200400001)(316002)(5660300002)(38070700005)(122000001)(6512007)(8676002)(66556008)(4326008)(66946007)(44832011)(6506007)(53546011)(2616005)(33656002)(4744005)(508600001)(6486002)(186003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?cCtVa1BPcFlrTHNLeDhPWUdmc040OFJWMm5LdTkwdVJYYmxpVlFPZmU4SWVB?=
 =?utf-8?B?NFUxZHZYdis2MlEzS1pXWjdaK2d0cG5CUFR6MVBpeER3d2lKOHVSWlRTMDQy?=
 =?utf-8?B?UjJNN2tOOHN0R051cWNzdCtJOFVycDcwdDh0NDk1ZEJPZW50SDFjM2d2Qzlj?=
 =?utf-8?B?VVJUUys3SzVRb0xldEFoRTZWT0FrUjFFZ1FsY29GRGl1d1VoZzUwQzU2aFlu?=
 =?utf-8?B?dlJyRUxsSlNnRXJVVThWbGhFMFBBTTVldjliTmFrQnVrcCt2YzFWdDk1TzNi?=
 =?utf-8?B?MGcrUkNoUGt2TTRZcHl6OGNZdmg0djZhTkZaVzlPb0tHcjFkeUF6bmcxbStX?=
 =?utf-8?B?QzdJOWN2STZIV1d3WG9PaXh1dnlJZ3FsZ1N6VTJ3VjN5SCtNdEoreFNxR0F3?=
 =?utf-8?B?ZDdLa2FTSTR6QkdITkdMZ09LUWl1eEthTkR2VHg4eU9ZdEl1ZitnVTVDNi8v?=
 =?utf-8?B?cFUvaXY4bXFSNk9xclhGaVV1VHp6QzVJWEpDWk5DQkpPZTJqMThmSmRZRU5t?=
 =?utf-8?B?KzZBRVEwN3pWOWsxMURZQUZvTHhpVzMvWmdJNmEwbVBGR3J4eDFWQzFObEFi?=
 =?utf-8?B?T3ZWbWZERjlud3BBdndlMWR1Y0k4dmZObTBpMi80NUNEcFdJUWdKRkJ3bnF1?=
 =?utf-8?B?ZTRWYW1MU0F0SmxOdk1rSzNkbjd4MXF6c0QzZzlnbnFKdk54NlRUMXBBMkFJ?=
 =?utf-8?B?cSsvaUlESjZodkZLemJVbzIwYllWbnAwbzZVNjcvWWI1RUpMaG5lVk5RMVVP?=
 =?utf-8?B?M2poZlZJbVU5VmhVeS9ONmwzcVRDZ0liSGgvQTd5US9TYWdtVkZRd0pkbTRK?=
 =?utf-8?B?ZWEzZk9na0p1WUZLM2phdWRYakJpMmZML1RIOVJ1MkRMRGZDZmdndDFWQlNG?=
 =?utf-8?B?TTJacm1LeVBFMklndE9NTTkyNzhOckZvbG1nTnRscFlJN1FSbi9aQlZLbnRO?=
 =?utf-8?B?Y3d4UWJuQlU2Rk1CVHJ1bjFXdkhTdVFVSnViZjljWlVrMzF1QXZoRTRjd3dv?=
 =?utf-8?B?bm93YzdseHpHUjhnRUJndXZlUVhZMnk3OFNzMytybFo2dFVHWGRVYUZEaFd3?=
 =?utf-8?B?TDBQMEduN3FndXZ6eS83bis2NCtSQ3YxVFZKY0YvTmRWVVZncGRZTVp1cmNM?=
 =?utf-8?B?VGQyUjJndmNXT3RRRFpHZEMya3dCWEJ2SmQ4cU40NXo1UXRwZFZTL08wVnEy?=
 =?utf-8?B?Uitaa2hCTStGbkpHaGU3TDhpbGduKzEreUtWTDlZZURNNU9RVnczWnd1RXF2?=
 =?utf-8?B?OGlUY21RdWV5OHBqMUMySkxPQ2JSN2grSXVNTjdYSFhkWHJwYjg5SzQzblNK?=
 =?utf-8?B?akVWbS9nUXFTSnJHdmw1c09RVVVXUzJveGRrK21aOUZ3eTJFU3pYbmswbWp5?=
 =?utf-8?B?NmcvdTdubTh0ejZlWkppSWNDWmxSQ203TW5ZaVozZC9YcTBLVzBXR0FZVGQy?=
 =?utf-8?B?UE1TQmFEVnpJbWc5Z1ZYdXkrUWFCa1QxL2JzUzdnTHpkTFpiRSsxUHc4dUFK?=
 =?utf-8?B?dTVReUxyT0kwTTBYbHVNSlVsWlpOUEFRU1lLbnFlN3p5YTNuclJvZERkb3NN?=
 =?utf-8?B?aHFzS2dwY3RaeURGZDV0eUcvUkdicUtCdXZjOXB4cHhiVkpGWUVKNjVQTGFQ?=
 =?utf-8?B?R3NJYlcxSXA1OEhDRUx3Vm16SWo3cG1WbmVqRHFwTFEyTFpTZ3ZMNWE3Wmp6?=
 =?utf-8?B?b3FIWE5kTGtXNnRaQm5YZng3UWJmTjhMdkRuQ2lVYmM3NlZ6N0E4aHRnamY5?=
 =?utf-8?B?QnNRVmN2SEJQa21VLzFTUlh3MnA2b1RVZUwyejJ0aWluYnpxVE9Sb0dDVVJv?=
 =?utf-8?B?Z3lLVkxVYW9teEkyd0Z6dXlxWlFxWElqYzFNZzZ3NWMxa01NOE8rdDBTeDNs?=
 =?utf-8?B?THdNMFkzRW9YZGkzRXZXSDk4Znk5UUlDMnFocUJtMHZwOE5paGF2eWxxT2E2?=
 =?utf-8?B?UytsVFNaYmliY0YrRlpjckRzc2lOYnkrb1lOVHVJUDRzK0JlakRHenhLTmZG?=
 =?utf-8?B?NFNJSjBtaEFyZlNMVXd4Uy9NeTVGRWVpZUhKSzFxcmswNGNUSElUd1JvdWpE?=
 =?utf-8?B?aDN1MkJvSmdockNwMDNydXpiUDdDSWZQTUVGM3ROZ0xTZVluR0JGQVk3L3A1?=
 =?utf-8?B?Y2o5TWZXdEt2U0VpVDZJSnhGV3dKMzhtcmdLR3lubG5JODhPRGRhcGZHKy9M?=
 =?utf-8?B?QlRNWURIYVY5eGlCcnJlVloyZnFoTktmckFFMFVHNHBBTFl4Qk04b3B6RE50?=
 =?utf-8?B?ZGJDdk9Bbk9ZQ2tIc3NsS0ZSZCsybHR0c0tSWWxpa3NobmFRYnpUdTlKdTgx?=
 =?utf-8?B?L3JzZEwxc3FuUU95SlN0R0hrbnErL1RLK1ltamZ2d1VkNC9MOHMxYjBIMGo4?=
 =?utf-8?Q?4lONQQzNMiMSU4gaOWv+ovOWKwZ3qsq5V1VpEbM++qW0C?=
x-ms-exchange-antispam-messagedata-1: c2bsxc+agffoGg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C6A754802E5A645A2BB97D6B61A8636@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d67532a-5cfe-4e47-8af0-08da4811df2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 23:11:22.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkbVLiP/wui9Ax4enVYlq78tmU1Ix5YCwz6w9mBSbGNIsX0K7v0+Ms+AQDGFjLFG1HpgWCZjXG33t5uM50cdYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3440
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_07:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060091
X-Proofpoint-GUID: uAS6TRw9UVwPblXcKr7Z5vgfFMKt7-fq
X-Proofpoint-ORIG-GUID: uAS6TRw9UVwPblXcKr7Z5vgfFMKt7-fq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_161143_663631_7B38CBDD 
X-CRM114-Status: GOOD (  23.77  )
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

DQoNCj4gT24gSnVuIDYsIDIwMjIsIGF0IDI6NTggUE0sIEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEp1biAwNiwgMjAyMiBhdCAwOTo1MTo1NVBN
ICswMDAwLCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+Pj4gT24gSnVuIDYsIDIwMjIsIGF0IDI6Mzgg
UE0sIEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gU2hv
dWxkbid0IHRoZSBudm1lLXBhc3N0aHJvdWdoIHRhcmdldCBqdXN0IGNoYW5nZSB0aGUgY250bGlk
IHNvIGl0IGxvb2tzIGxpa2UNCj4+PiB0d28gY29udHJvbGxlcnMgaW4gdGhlIHNhbWUgc3Vic3lz
dGVtPyBUaGF0IHdvdWxkIGp1c3QgbmVlZCB0byBzdG9wIG92ZXJyaWRpbmcNCj4+PiB0aGUgc3Vi
c3lzbnFuLCB3aGljaCBpcyB3aGF0IGN1cnJlbnRseSBoYXBwZW5zLg0KPj4gDQo+PiBUaGF0IHdh
cyBteSBvcmlnaW5hbCBwcm9wb3NhbCBhIHdoaWxlIGFnbywgdGhvdWdoIEkgd2FzbuKAmXQgY2Vy
dGFpbiB3aGF0IHRvIGNoYW5nZS4gU2hvdWxkIHRoZSBVVUlEL0dVSUQganVzdCBiZSB6ZXJvZWQg
b3V0PyAgSXMgaXQgb2sgdG8gZG8gdGhhdCBmb3IgYWxsIHBhc3N0aHJ1IHRhcmdldHM/DQo+IA0K
PiBDYW4ndCB0aGUgbmFtZXNwYWNlIGlkJ3MgYmUgbGVmdCB0aGUgdW5tb2RpZmllZD8gVGhlIGxv
b3AgYW5kIHBjaWUgdGFyZ2V0cw0KPiB3b3VsZCBqdXN0IGxvb2sgbGlrZSB0d28gcGF0aHMgdG8g
dGhlIHNhbWUgbmFtZXNwYWNlLCB3aGljaCBpcyBlc3NlbnRpYWxseSB3aGF0DQo+IHRoZXkgYXJl
Lg0KDQpudm1lX2dsb2JhbF9jaGVja19kdXBsaWNhdGVfaWRzKCkgZmFpbHMgd2hlbiB0aGUgaWTi
gJlzIGFyZSB0aGUgc2FtZS4gIFRoZXkgYXJlIGtpbmRhDQpzaGFyZWQgbmFtZXNwYWNlcyBhbmQg
d2UgY2FuIHNldCBubWljIG9uIHRoZSBsb29wIHRhcmdldCwgYnV0IHRoZSBwY2llIHRhcmdldCBp
cw0KdW5hd2FyZSBvZiBpdCBiZWluZyBzaGFyZWQuDQoNCkFsYW4=

