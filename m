Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBB4C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cMVIO/H1VP1Nr9uUCj3NCSsJ0StLorJwnsFFTkLNXm0=; b=2FkqTdEec7xoT9HXJhCJrk+zb9
	723tccWRYomsmSs4Q/JmvpVhQHr0Ua9gHKURmU63zF8A+pgQqyUCQT6WN5J29q7FS58xPfB8kBMEf
	RLPuDJY3NCWZ8kot0HDljyni2ksMw1PL8gngq8/dMl2/3afyh8U/wdKoVyw0oBh8R3dVQyy+8Px7m
	0dgVpnO3QJlTOf/cBnJxWM3XO2AzDZvlYGteJaa2qIr6lfBl1g0wi4hpFgj7x3qi4uM9ajPtl+iOV
	m/wav2XBG+AxEpe4LYjxypi6jrYgWNuL/e/Nu+oyyG8VZ8h8zoOY7qZrPDiM8D2Zomwn3kWBCqjuU
	x6iXJ+gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogukg-00AaAG-88; Fri, 07 Oct 2022 21:19:26 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogukc-00Aa6e-H5
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 21:19:24 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297HLZRJ019304;
	Fri, 7 Oct 2022 21:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cMVIO/H1VP1Nr9uUCj3NCSsJ0StLorJwnsFFTkLNXm0=;
 b=f3ETZOqUbqY5i9VVx21n9Nq9jjQrP/VUOtfOqSvpl/t59bwP0wmvf3ehi1qGgClN6t1A
 ysydu4INmY51NzO63oErw52oP60OsfJdk7AK2YK9Ts831MWG9BhcHhiTEA7NqOKQ/5+G
 oy31WlagW5w72iIf/X5dlXdl9BhEGu5gIr/kDMP6eWJ+iz7x/1oIk8JXsiqMOiFPGSBA
 aYgIseMRwZ/wkehh7pc0LqIC8q2l9/rczfyy6HPpu7JTDw3v9l/bsDvHvhYXxHxcrNPn
 86jw5DuhmAQjfcESzl/p6L0XRcKUBadsMQqkxdJ4YtnhUkLCccX0/Eho0poAGGlDWQpY aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb30b1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Oct 2022 21:19:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297J0AP6000397;
	Fri, 7 Oct 2022 21:19:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc076bhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Oct 2022 21:19:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE3/vTXgUFIC+VOOSUF4W2kXq0KRIPEJACm0/7AgzFNIiAefp16rXSEyfYGXIZu7u8CtfY29C2Up21lyhntbo06bMruk+B6Hq3hUdCAzxwLQAnN/dHHkiEfMQTkBv982zRYLnSnL+HtvIx63EKh7LznNPZ411LWYPdnDNFfpNvqCZ8feJdIq8UeiGvuIr3b7gGdg4z6CSfPHlyzsP+0MVa7A6PQhlHqZvyBJHRseAZ4Z4mTVp4ok6AjmjXcsvCPh1Jg6Q88d2sGnudFpIk9sV1fAdOzenPD1vVETbEJ5zFxZ5Q16QnmNoaRK3Sue1dtWrsPrtbpXXi0ceO+ahRRJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMVIO/H1VP1Nr9uUCj3NCSsJ0StLorJwnsFFTkLNXm0=;
 b=k1Ssmcb+0IIwbK+zEPd6LF2BftuVo9OvOoOaGqmoEIyMe2Ywo4F+za9W4u1l4UZtdxjn+ioeFgrBXpnnIgNa4BFOsyuHafJseoziT9OVhdaiLcRYE4BL3D/innj1xLdVW5DyU2ntgMP5gzt9OaJyk5TGoYZ8QNXyjLQn98p6+0yTTrBUjnXpK5spJ5jZhgRDCr6JwpXTDm81ubzuLjhHFd52sOG0IQF2CtQYY1y2hPuD96W4UETT7N9QrN6Ne3JQcSywypZgGsp2ku8ED+waUV1zwj2v2G0hAHmblYv0mSCqfDLeaONj97Kzwi5OR1/s63ghTTFrwX2NqiwJLTSpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMVIO/H1VP1Nr9uUCj3NCSsJ0StLorJwnsFFTkLNXm0=;
 b=o7XGknzYAJinEH7clmmPDOqvovmrMAZEOjajytwOlzMZSnx4uWa/bys6J6er1cNutfgzw3snmV6Ej3ZeRc1xsGMktY6f+fbQFw2SXASebm+qRksZjVsuT6OYfKVwLTg9Vr/bQgj1BAf50giQaLmsMuXf2X3/T+bs8Bdz/RjTTIc=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CO6PR10MB5602.namprd10.prod.outlook.com (2603:10b6:303:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 7 Oct
 2022 21:19:08 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5073:7685:8742:9ce2]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5073:7685:8742:9ce2%5]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 21:19:08 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Pankaj Raghav <pankydev8@gmail.com>,
        "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Yi Zhang
	<yi.zhang@redhat.com>,
        Tomas Bzatek <tbzatek@redhat.com>,
        Chaitanya Kulkarni
	<kch@nvidia.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav
	<p.raghav@samsung.com>
Subject: Re: [PATCH v1] nvme: do not log errors for user commands
Thread-Topic: [PATCH v1] nvme: do not log errors for user commands
Thread-Index: AQHY2WchbFAzwvMd90+50EbWjPLAZ64BSCWAgAAUw4CAAhUngA==
Date: Fri, 7 Oct 2022 21:19:08 +0000
Message-ID: <35A47E59-90E0-4F6C-80EA-A98F59213FA0@oracle.com>
References: <20221006093628.22089-1-dwagner@suse.de>
 <20221006121635.awoafzxyu6nkrqfj@quentin>
 <20221006133053.mmzw7m7wbfsapqbx@carbon.lan>
In-Reply-To: <20221006133053.mmzw7m7wbfsapqbx@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5550:EE_|CO6PR10MB5602:EE_
x-ms-office365-filtering-correlation-id: 56149206-ecfb-46ab-97a9-08daa8a9922d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  +Gd1y8RJ1AfUPk2keYawFQfB96w0MZBt4fWFCFQYTtVWWwtQkbr7Bc0EGusiL76Zdq21zbIYkaRQKDjtTF+j1WTZ0yx5iPWNOTc1dqab6Jeg5KmJddk6H50p27XSEwy8WXAEiZgQASRxObol2iAmkVsDaWrbR+UWb6jr8IPtyC2eEVsPqy5b6+2rFzf6pNaXA6dB55LIyVuie12f5ifJooZeWidfS1yREDC+ASqwBkqt8o7R1NDm7F8mw1FmaoiI8x5A216zkeTYSYi1MvYkAOzjaXA9A9AaHEdw1gA7ghC+MUsDzR06CcW6PjJqbpI+lp2UantX8eqY2C7z5uYYrDZUeyJ5z+jm3QtGyT5NLaZRfSitwZLoYvNEuFLLtsHpAcJtPiDhBTSYEnSYcuLtkzzn/00bcmpKbnTVjKfk9zxwYazAadCx5yZpm1fm4rtuDKL7XHoYyxoe6BBow6KcN0i5nA1bVedYozLb3LYPd1EJERZVlygGFKmERLdQakwoujcS2enhg9Vfdiaxl7unjoyqnB5wvV9UUPWmuJjvrbpzGu5RuePmLtvqU+f1CXCNtgOa2VW7y6LHp6Gl+VsygMEu5J+AyLQ5lqyRumqO7V/0/0TE+1GI65cEO+uaYIyIf0ZFYWKEQR+XtVa1tmj56fsdVO1f7KgShhEm9ZGW4W+DQuxvscxdTFskrhZfqO0o0TRsM47HcNHrh7ITmAda3s7I9/ciWR/TFZ4vR9vgfDchSFs/B2wWjsHqtc/2p3kYVP+q8S7hMNKVNgIMQJBeMZHEBQ1TJau9eCSMdpw1pBOcgKr0B6af3KDN9U4EfiiUZjdAxPKsbdzJRFNzjcUa0A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(66899015)(316002)(36756003)(5660300002)(66446008)(66556008)(66476007)(33656002)(64756008)(8936002)(66946007)(41300700001)(6916009)(71200400001)(478600001)(8676002)(966005)(44832011)(6486002)(76116006)(6506007)(83380400001)(53546011)(186003)(2906002)(4326008)(38070700005)(86362001)(38100700002)(54906003)(6512007)(122000001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UXNBcWpDM3RGeWpKOGVYU1A2ZGtIT2hPTndjMVhTSnFkQkRQc1Rlb09NZTdv?=
 =?utf-8?B?eHhPS2N5SzMyREtiZHJjdElGVkczNG1aU1I2SVQzUCtPOEhpM2c4Sm13c2F4?=
 =?utf-8?B?VzBkQWhFMnNxbm4wb2dTeFZUanFDRTA5eHBadjFsaU1ZblQwejJodkZIYStz?=
 =?utf-8?B?bTBrUDh6RVJwOWpOZWFvSmt1akxzcVJJMnMrQzJCREpkU29xYXJCZ014OSsw?=
 =?utf-8?B?WUllRXVJRXBoTEZGVk1DZDJ6SHNUdU9yeWNaSDZLS1RJR01QVTVMb08yU0Iv?=
 =?utf-8?B?QnVRV3o4ZUVvNTR4RkMwdGFIbG41b0lFdUxCRVFibE1YamJrQ1c1cllEY1ND?=
 =?utf-8?B?Q21TT2J0Wjg4UHZYblBZTUVKNmh3QzN2N3pzanBpNUVaOVhBSXdKdDlRSHla?=
 =?utf-8?B?QUFYYkw5ME1aekFqT2QrSzVKeXdOaUtwL2E2UGhhdng2R3o0bUM4WlhCNUdi?=
 =?utf-8?B?cjduTUtlQVd0Ry9KUDZxSnRxNkRjZE9WNjVybEo1VUxWWElYbGljR0NoVW9N?=
 =?utf-8?B?eXR0VHo1ZHFYbUVNNURPcnh4UEFHY3RuQWxPTnkzalRrc0RWYTJoR2x3VGJJ?=
 =?utf-8?B?RjJpNnBFbHd2RlNSNGN1Z1VNczA0VVBoV2s0M2srYzNVUWZWb2x4bCt4c3pL?=
 =?utf-8?B?REl4ZTdJOTEwYmtHa1hpaXVkOVJzOTNUSXRGUmFSZ3c4UmxhMGhVaDdPTmhP?=
 =?utf-8?B?WkttcU1yUXlJRDZEUWRDbUI0bGpmK29PZWpYMmp6VlFGUG9mVWgxZW03K2wy?=
 =?utf-8?B?RldYb0RIVkFvVnJobjlvWlAyNFFvVUwrSFcreFZjb1NzNzhUSzVnYjZCeWhk?=
 =?utf-8?B?NVA3RTBvRllhLzhKTkFDSHhYZEdOd1FSbmpLQjlwYjVjS21TbWJ2Nm91N2FV?=
 =?utf-8?B?YTArSFlRc1I3bVQzTE5wUUdwd0dsV0IwM1FyZ1p5YVBzbTRDVVovYkJ2UzlZ?=
 =?utf-8?B?N2hEaFpjZVkrVGJVU2N2NVdPWFQvYzJmVS85TURXSHpGMnI2S1dPRXQ2eDFu?=
 =?utf-8?B?MmlQVmg2Z21qVzdJRzZNbmdkOTNON1FpQ2dpSFNxUjRrTGRxZU1oSnBORFEw?=
 =?utf-8?B?WHV6U1FzK2l0SitnOU9YNTQ5UFJZTzZGemczN1JNd2d2dDJjazhpUnlRUkVT?=
 =?utf-8?B?dTVZTFJsVkpFWW5vZUF5UExRQWdtelR1Wk0zNkREeFpueW5VbVVBQmJBeERa?=
 =?utf-8?B?aEgvVnNQL0ptbGpmVHNXZmRDdEdrYzZYME9kd0xTRmhMSm5UNE1IZUwremw1?=
 =?utf-8?B?aVZKVVFNMlhEV3crRmVnd20xUkthQ3RjQjdvQUgzZW9lSUtvSlpZcjJkdG44?=
 =?utf-8?B?VzFBc1JuRGQwQmhDenhQQ2g2bHllWDZBUzRxdUZyRE83dlg2a1lDZmQ1d25o?=
 =?utf-8?B?Q0dSRis0NjUyRy93cVQ2QkEzcks5WWlrdFZBbXd0YnlWYk5mbWs2cWx4bzg0?=
 =?utf-8?B?RVVXWEdOd3RNRFQyVWxDZmJYMUVIbUZHcTQvQVVFczEwY1p6YlRkZGZBTnR0?=
 =?utf-8?B?SWc4aXNMUVhQM0lmRUtiM2hxMXBVNlA1RVM0Y1NjSllDTGVqdEh2K1FGQ2Vl?=
 =?utf-8?B?dWRzbm1CcEFVemZDTEpxWFFuWGRvRWVMVmxSRHVnanVPdUVWMjZpeVJ4Y1c1?=
 =?utf-8?B?ZHVuSFZyRDJSVUF5ZmM1VXRDTWplZEJ5M3hIZUtXZ0lKV0xrT0FzSWVId0kr?=
 =?utf-8?B?TmM5QWtON2dzQ3UxUXpUTVZPcDRES3l5ZllBSTRNcmlHeXE3OEpLdHpxc0Nu?=
 =?utf-8?B?WFlPbld1bzFDbDM4OUlIdHJYdDQzY256Mm5tek5qeEM2bXp4R3FVcVVORHVa?=
 =?utf-8?B?WS9NTnlKcVBCekppSEVyeEhBLzhHYVM2aVVPQUpWeWxRQTJ2M1hsVFE0Rnh6?=
 =?utf-8?B?MHAzcEkrdmpBbExmRmpGbTFOanhwL1ZvbGZ2eGpJeUVjUmtZbnQ4eCtWQVBJ?=
 =?utf-8?B?cDd3QThlaFBVSUNmck5VMi96ZWJhTjh4S0dYbUIyUEJWRkpZaFNnY2RRall2?=
 =?utf-8?B?d0ZsdSs1bERBd0h2aEhsQ1d5MVZYT2w0Rzg3djJBUEFrcnlwWHN6Zys5L1pG?=
 =?utf-8?B?UFdHcDI2anBUWGpoRXRybmZEdFhQSW5wYmFNbW9sRlhOSmtyTWw5STVvWDkv?=
 =?utf-8?B?Z0hwcjhSUHpZUElmN2VOTG1KTCtMaEwwaGU0UTZWd0lVN1FyZjlXMXd4R3k1?=
 =?utf-8?Q?fUMlBDosUgd+dj6ALYwAJB/cAsSI/AMY4TaHwSH3HMPr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52522488379EBD4EB801059D37F5181C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56149206-ecfb-46ab-97a9-08daa8a9922d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 21:19:08.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbBKax6iRGzal47pA3WBE8sxzP442uGA85CdPYh7QxYi62gAQsI/npd1YozR6bVloAVT/00AsTmsjuVbCW8vdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070127
X-Proofpoint-GUID: gyekHTSSBIOWgJ33IGgmQs4DqCchd1Dg
X-Proofpoint-ORIG-GUID: gyekHTSSBIOWgJ33IGgmQs4DqCchd1Dg
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_141923_195425_82693A14 
X-CRM114-Status: GOOD (  25.29  )
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

DQoNCj4gT24gT2N0IDYsIDIwMjIsIGF0IDY6MzAgQU0sIERhbmllbCBXYWduZXIgPGR3YWduZXJA
c3VzZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE9jdCAwNiwgMjAyMiBhdCAwMjoxNjozNVBN
ICswMjAwLCBQYW5rYWogUmFnaGF2IHdyb3RlOg0KPj4+ICsJcmVxLT5ycV9mbGFncyB8PSBSUUZf
UVVJRVQ7DQo+PiANCj4+IFdpdGggdGhpcywgd2UgYXJlIGRpc2FibGluZyBsb2dnaW5nIGZvciBB
RE1JTiBhbmQgSU8gY29tbWFuZHMgdmlhIHRoZQ0KPj4gaW9jdGwuIElNTywgdGhlIGVycm9yIGxv
Z2dpbmcgZm9yIElPIGNvbW1hbmRzIGNvdWxkIGJlIHVzZWZ1bCBmb3INCj4+IGRlYnVnZ2luZy4g
QnV0IEkgZG8gdW5kZXJzdGFuZCB5b3VyIHJlZ3Jlc3Npb24gYXJndW1lbnQgaGVyZS4NCj4gDQo+
IEkgZG8gZ2V0IHRoZSBkZWJ1Z2dpbmcgYXJndW1lbnQsIGJ1dCB0aGlzIGNsZWFybHkgcmVncmVz
c2VzIHByb2R1Y3Rpb24NCj4gY29kZS4gSWRlYWxseSwgdGhpcyBjb2RlIHNob3VsZCBiZSBvcHQt
aW4uIFRoZSBvbmx5IHdheSBJIHNlZSBob3cgdG8gbWFrZQ0KPiB0aGlzIHdvcmsgaXMgYnkgaW50
cm9kdWNpbmcgYSBuZXcgQVBJIHdoaWNoIGFsbG93cyBlbmFibGUgdGhpcw0KPiBmZWF0dXJlLg0K
DQpMb29rcyBsaWtlIGEgbmV3IEFQSSBtYXkgbmVlZCB0byBiZSBjcmVhdGVkLiAgSeKAmWxsIGlu
dmVzdGlnYXRlIHRoYXQuICBXaXRoIHlvdXIgY2hhbmdlLCB0aGVyZQ0Kd2lsbCBuZWVkIHRvIGJl
IGEgYmxrdGVzdHMgY2hhbmdlLg0KDQoNCg0KbnZtZS8wMzkgPT4gbnZtZTBuMSAodGVzdCBlcnJv
ciBsb2dnaW5nKSAgICAgICAgICAgICAgICAgICAgIFtmYWlsZWRdDQogICAgcnVudGltZSAgMC4x
MjBzICAuLi4gIDAuMTE4cw0KICAgIC0tLSB0ZXN0cy9udm1lLzAzOS5vdXQJMjAyMi0wOS0yMSAx
NzoxNDoxMi43NjA4OTA2NjMgLTA0MDANCiAgICArKysgL3Jvb3QvYmxrdGVzdHMvcmVzdWx0cy9u
dm1lMG4xL252bWUvMDM5Lm91dC5iYWQJMjAyMi0xMC0wNiAxOToxMTo0NS44NDY4Nzk5OTYgLTA0
MDANCiAgICBAQCAtMiw2ICsyLDQgQEANCiAgICAgIFJlYWQoMHgyKSBAIExCQSAwLCAxIGJsb2Nr
cywgVW5yZWNvdmVyZWQgUmVhZCBFcnJvciAoc2N0IDB4MiAvIHNjIDB4ODEpIEROUiANCiAgICAg
IFJlYWQoMHgyKSBAIExCQSAwLCAxIGJsb2NrcywgVW5rbm93biAoc2N0IDB4MyAvIHNjIDB4NzUp
IEROUiANCiAgICAgIFdyaXRlKDB4MSkgQCBMQkEgMCwgMSBibG9ja3MsIFdyaXRlIEZhdWx0IChz
Y3QgMHgyIC8gc2MgMHg4MCkgRE5SIA0KICAgIC0gSWRlbnRpZnkoMHg2KSwgQWNjZXNzIERlbmll
ZCAoc2N0IDB4MiAvIHNjIDB4ODYpIEROUiANCiAgICAtIFVua25vd24oMHg5NiksIEludmFsaWQg
Q29tbWFuZCBPcGNvZGUgKHNjdCAweDAgLyBzYyAweDEpIEROUiANCiAgICAgVGVzdCBjb21wbGV0
ZQ0KW3Jvb3RAbG9jYWxob3N0IGJsa3Rlc3RzXSMNCg0KDQpBbGFuDQoNCj4gDQo+Pj4gCXJldCA9
IG52bWVfZXhlY3V0ZV9wYXNzdGhydV9ycShyZXEsICZlZmZlY3RzKTsNCj4+PiANCj4+PiAJaWYg
KHJlc3VsdCkNCj4+IA0KPj4gV2UgY2FuIGFsc28gc2VuZCBhZG1pbiBjb21tYW5kcyB2aWEgdGhl
IHVyaW5nX2NtZCBpbnRlcmZhY2U6DQo+PiBudm1lX2Rldl91cmluZ19jbWQoKS4gU2hvdWxkIHdl
IGFsc28gZW5hYmxlIFJRRl9RVUlFVCBmbGFncyBmb3IgdGhlbT8NCj4gDQo+IEdvb2QgcG9pbnQs
IHRoaXMgcGF0aCBpcyBsaWtlbHkgdG8gaGF2ZSB0aGUgc2FtZSBwcm9ibGVtLg0KPiANCj4+IFAu
UzogSSBzZW50IGEgcGF0Y2ggdG9kYXkgdGhhdCB0b3VjaGVzIHRoZSBlcnJvciBsb2dnaW5nIGlu
IE5WTWUgdGhhdA0KPj4gc2V0cyB0aGUgc3RhcnRpbmcgTEJBIGFzIHplcm8gZm9yIElPIHBhc3N0
aHJvdWdoIHJlcXVlc3RzLg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS8y
MDIyMTAwNjA5MTA1My4zNjYxMS0xLXAucmFnaGF2QHNhbXN1bmcuY29tLw0KPiANCj4gWWVzLCBz
YXcgeW91ciBwYXRjaCwgYnV0IHdpdGggdGhpcyBwYXRjaCBpdCB3b250IGRvIG1hdGNoIGFmdGVy
d2FyZHMgOikNCj4gDQoNCg==

