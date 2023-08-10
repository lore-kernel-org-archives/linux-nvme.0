Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D0AC001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/FgBE8t/orS8sGi/o8nqwTYKw/Z/H7MIwhEoWsEnMQc=; b=sz+jv/rBqvSWtzx/91GT8qvCw7
	ozkkb6pgeeKjM/3Ryj6wqRM3nYUmQfHggIfpqRxFaMiYNZCAsqJpOt69ewcHub/GwVzM8+BjGoYF8
	X2CrnpUcDQYDX2IhhTQN4Hpuo/beZAO03pO5Se40kYZ6Z+33AowAe/zlpuMUYsJC3AN5/bXwO0Gdc
	2I8UGN4tNe32pws+Kh4ajtjr9AkGX3m5qa89mCM86q6NW4JogA7XFfFYnsRvy8wBjHpOffVTFnbOD
	J5dC+PFKCCX3QnKkZoy9+csH0YHaiNILDRLD58mKIZBQ7kz0VZLTCWejXteTdNIDJIcDJ4ultCBu/
	gL9pQUJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5jN-007jZ9-1C;
	Thu, 10 Aug 2023 13:29:37 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5jK-007jXn-1I
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:29:35 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AAxWUg008795;
	Thu, 10 Aug 2023 09:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=/FgBE8t/orS8sGi/o8nqwTYKw/Z/H7MIwhEoWsEnMQc=;
 b=SVT/UuDDyTyrf6WA5skSLB/G5xCbtrUErZokv2O2LP66smOwt8lAKl1wAW+5P2WOYE+z
 7of2Yb6YgDVyz38qsWr1viLyaKLzrw4omxZCq+Lip8xdxdGQDxjJpaqmAznjgEqiSQ6x
 bE8Au815t5bhBH6VQ4/f8n+fqmNiCwGJDBnjsEvUHl8BhJu5YHEDg5FImUlf6esfGriH
 BNk3NgjtvgeUopyItJ2Z/yng5frNiEn+I9Fw9RA8JmS371A51DTpY1jMEgA6+OAtFRao
 m9Qf1fntJ07uxg1Xa36NYb1UxlRg9yQZS7KayKTTrWww4Epcx2PHwsx22Y8VN65oz5P/ eg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3s9hkdpqwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Aug 2023 09:29:23 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ADHetY021702;
	Thu, 10 Aug 2023 09:29:22 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3sd0ncg65w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Aug 2023 09:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4vJIr/u1Mb5EqS54EVlqtO7lntztES3PpZL985KRi2mbr6vIGh63LovdfBxYI87CE4RNva4CyFVDnoRPjmvv5z7DdUzt5hmh4aMDdW2jMSS1CX4cW+wsOSRrOGTNcLjN83mSOKfwxDLB9THlxS4F1v1FZlKf1QBOeh9o+YBPvwA+cDR/JdTHHqMWWuhM/rUgOhjo+NEcsmCN9UCvyYvd1FYyG7OT0AI+//fHkPlkasoqylUZy66Abh1vZEG7U2w6bjF30nopq52B+9J7dCnyKpzgO3k1EZpzmIFOVYIVbMOdNsUp3ulJH7BmEosq1yc3CuINCVLutdSiKalk+2kPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FgBE8t/orS8sGi/o8nqwTYKw/Z/H7MIwhEoWsEnMQc=;
 b=X6AUltslj7tjcDaGQ5MN7pXmsIRv5oIRWbtX/tBrJlF0KAMFVJoxwKlFsNtLEOUapjZ/hiT/Yr+TSH6sKwbYqt3dQ3USyZuGREol+1umGLyH/yx45XR/r9SUsC4Euo15vKgN+yhp2ctjLKU4p1Ar4hDsfTJ9PnBZ9hbdv/wELx8XkwPseLtinRxwVpLMto1YH47Fc4v7pZvUZAZxaREOBVBJUE5cOS6clYSV1Q9Grw07MH/e1LLvTDytsEFN5EUL4ca2XLY4gId6FK9+wXSwns5ApzAs5flpmz1v5Axa28vKoOpySpgFgo9dPJGCIu0pQ2+Ygyr9cnZw5X4QCrnzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BLAPR19MB4531.namprd19.prod.outlook.com (2603:10b6:208:29c::19)
 by PH0PR19MB7478.namprd19.prod.outlook.com (2603:10b6:510:28d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 13:29:19 +0000
Received: from BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::ca98:8623:903e:b297]) by BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::ca98:8623:903e:b297%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 13:29:19 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Daniel
 Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCH rfc 0/6] support traddr as dns names for ip based
 transports
Thread-Topic: [PATCH rfc 0/6] support traddr as dns names for ip based
 transports
Thread-Index: AQHZvhAkmXpdiy+gsk+OG5qt50hsbK/jiU0AgAAXWGA=
Date: Thu, 10 Aug 2023 13:29:19 +0000
Message-ID: <BLAPR19MB4531C7650AB7205E9AE19184F213A@BLAPR19MB4531.namprd19.prod.outlook.com>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <1032f160-3307-0405-9b68-b8f6f5b028b5@grimberg.me>
In-Reply-To: <1032f160-3307-0405-9b68-b8f6f5b028b5@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-08-10T13:29:17Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=6bb1e5d3-e382-4096-84f5-f3f65cd234b9;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR19MB4531:EE_|PH0PR19MB7478:EE_
x-ms-office365-filtering-correlation-id: 16a76d27-af77-44c5-8d40-08db99a5cd25
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BvpaQs9tmNLJSUS2Tz/qJY4Sb8oMthEJ7gEHOjDA+Nz7WF2gQJlIJZVUZruCT/pFE7AtAfFHd5YDO13MzeBZk/ORalsiynlC32ChVLjjoEF8EtrZxXwlVGnRjsDR48Xj455SYbUB8hs7qy5fEnqs9ohkUuwnNgwvRdhQuWPO3XVksCgc0dAiCjUPOPz0/IBOPY1wFKp015+z7zub9GZnoWUQKbA6QFdK+yarjuSF8K/sGSXIt/AB3qCauzKGVXQqDgdqsWwi7UNo1hTpsnt50VXa7ZiyUFtPrJdi0RKxICiI3AcO5vmKUXBoYSr9K9olNweKEoZg0FHr1CCYeIxPnviBKr5Qiwa1UzQKNWP830FJqz+VGjiM6BqMZhIzDU+b+N9yWbGXadD6jXV87e+elgRrNQLeyDnI89wptrdzVA7biLnhtAvcaaUnKEXYvXB9tfGt7pagGWM3Z30NbidMb0PvQFQsclxR4h5T8gKsPnYZPRgh69cqgQB80AwzGOsnvQH4M+cIuQTOOiLn+FBfUk+Ek4D6pfjVDAz+GGl0kecn6qhcT90YeeFGnmABEEaX8dSGZd+p7hitoDf8dct55Uf/5PNEnx/dfTjCzY439eAcTqzWouOW0zaKFp76/KES
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR19MB4531.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(186006)(1800799006)(451199021)(71200400001)(2906002)(7696005)(38100700002)(54906003)(110136005)(82960400001)(26005)(9686003)(122000001)(6506007)(478600001)(64756008)(66446008)(786003)(316002)(4326008)(66946007)(76116006)(41300700001)(8676002)(8936002)(38070700005)(66556008)(66476007)(52536014)(5660300002)(55016003)(33656002)(558084003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW9ha1JBbllTZUhoK1hWQVVxRmtQWEdiTlpEMi93K1Y3T0dJcWFHcmNlRmg1?=
 =?utf-8?B?NVlpSkJ3dG9aZVVmbmxmKzJpTWZ3WG03ckp5QUsxU20zbEk0K2NSaVNrQXZ6?=
 =?utf-8?B?dGFVbE9qZ1VzRDl1UnZqRHBRYXQ4YVRvMkNZaFJ4Q1k0STFsU1lIcXhxUTA3?=
 =?utf-8?B?bnFJUTBiNndCNzROUkxtMmpOMGN4SmVuQVM5NE1DZHV6WmJVLzRHS2c2bmxs?=
 =?utf-8?B?ZlUvd1h1dlhCUFFDYVA4TnpJbHczMTVvNUVoOFBOTTJQYlhuRTBza2c4T2Rj?=
 =?utf-8?B?RWJMZGVHVUNiZkJ4RlV0VDR6UVFiS1ZjcXVxWWtTWm5ISVppVEJhZFA4TVpK?=
 =?utf-8?B?NWpPRDBHdjlXcVpmZXo1WUZ6NnAxVWFGQXZiZnhYVVFSUlFFREVsZlBtb2tD?=
 =?utf-8?B?L2FwNVF5Q2VUS3g1dmNDYjJmT04wMENUcTZoQTJOTG1wNjF6QlJLd0kyR0tH?=
 =?utf-8?B?cEVFbkRCL3M0OUJ2M0tya21sNXlaeEVENTZrVjJndUNtRnJtL2pnc01TSjdL?=
 =?utf-8?B?SVdSTnpIaWh6bHF6WTJwKzNnaTNsM3g5cVVaSVM2TDk4WTJhNjVSNHlHeGhy?=
 =?utf-8?B?OUtLTUhsTzFNWFEwdXRRb25pT0crTnZKaGlSdm9lRUIreTJjamtjTUlSKzVW?=
 =?utf-8?B?VXY4dS9ZYnppNDJuZ1pSSkJjYlRpVXFTQlVWbjF3dDlBbHZ4WU1henl1ckFI?=
 =?utf-8?B?RDBmMXBnSWMwS2JTRVRJL3NzeW84OS8xSkVmWHIxb0VZNlA1NFM0M0g5OUth?=
 =?utf-8?B?YU5YVEtqTUxNZ05RN1JQeXg2V0srVFFUUU5QVEJBVzFSYm9keldkK1hDRFFW?=
 =?utf-8?B?YUl5UDV3eVpHQXh6ZFJKamwyeEVxUVg2QlJ5N1MrYlRqQVpoSjhXWTRBdk51?=
 =?utf-8?B?TWtsaUo0UjJ0NDZnOUd6TDYzRHdUSGs1RllQaUdGdmlGWUp4cm1nd1hwZ3hn?=
 =?utf-8?B?VjNHV240MHJHOWsvUzRuQXQyV3NyWlE3Tm42ME9qU1AwOUdaRzJ4MXlFQUI5?=
 =?utf-8?B?MFBoNWtrOTFWQWx0SHNjOUkyT0E3TnRvRFN1WE8wUmxuU0M2RmRQa29kbWNR?=
 =?utf-8?B?NlhJQURIWmN6LzhPRHZBUFhFTXZsaEExK3U1dWJsQ0NNNVJtRDBMZzloT0Zi?=
 =?utf-8?B?QSttL29pVnFRMGo4eDVMM3hCZzhZQklyUVU4d3NzRXJKcmdSWnE3Y2NsbnNC?=
 =?utf-8?B?ay8rS3NiWmZ0L0taUWN0MElUbW5NeGVPYWZXZnB0WU1OMzdzRVhneHBQd0hR?=
 =?utf-8?B?NEI5Y2c1ZWMrdklvVkV0T0tZT2RTTVltTGpFcnJBRXZIa1Y3bTlGQXBLeVha?=
 =?utf-8?B?RDd0OWxiNVkxMkpySURMVXJHSEsyVlBFSjJzTmxPZFVpdEh1TmJLbjNvUks5?=
 =?utf-8?B?ZnQ4d3FTYjIvWlNxTUlTWlVjWWhsOVNNYks5UEUvYkZpaG5TekpHNlBDYUFt?=
 =?utf-8?B?ZExDRERBbWp5dkNGUUhpYjFEMFVDTGtOc3hZZ0FLVUlnOWpiN3pIWFNKU2F1?=
 =?utf-8?B?NStFRGJIU1E4VzYwMmFuTW4xamhLdkI4ZnJETGVuV2ZtSzVhNmZJZ2lWLzZC?=
 =?utf-8?B?Y0xCdXBCdVRWdWtPSHlJZ1dLbzFEK1p3dXlZZnpGakdwRUV4cFkwa0pTVHdK?=
 =?utf-8?B?L200eFB5MGZJVkdsb3VrSWVlVXlLOG1MRTQvZFgySzU3VGF3Uzh0YVY3eXQ5?=
 =?utf-8?B?OWpmWTRCTEpiUnloZm84RXY3RzdQazhCRjJjRVRuV2RPL2Q2U29MeDR4ZTYx?=
 =?utf-8?B?ckFuT3JPRkI3NlcxSG4zMUVDRnpJUEo3RWwvVVo1Z1lEcG8rc2M5TVpZOVFD?=
 =?utf-8?B?SXUzUjRLMHRHMEM1eGswKy9SdndCeGFlVzlkSEhwYTk0SlFyVVREZWxzbkNP?=
 =?utf-8?B?VU1RS005Y1BvUVR4UEtNa2xmc2N4TFROS2NENlRWOUxNd0JwUjlmazVuUzV0?=
 =?utf-8?B?a0ducTdvUkdxanRRQkRqaDFXRU1ZVzFPZ2VBTU9iTWY1TnRGVjFrc2JQUklu?=
 =?utf-8?B?M2Uzd3NxQ0hnRlBuYjhWL21iQVhVOUt3NkFHTS9tTnNOUHlTM0RRcFJXSHRW?=
 =?utf-8?B?MS94eHB6bzRuTTE1QjRFbldWRVA5dnAreVpCV3FDMG1pUThGVnVSMDJZL2N6?=
 =?utf-8?Q?rEW9GjF+dOFidBskLOEmOeFCU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR19MB4531.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a76d27-af77-44c5-8d40-08db99a5cd25
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 13:29:19.2910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejhVcrxEd6yFVvd9Qj+z3dZRcOTKSMcDAmh39lpn0/B30NTxZiiq5mwbCUP/Rq5/6L41eRfBO/4vMF/LxXpWjwHVIZRKfjwPZppP56gp270=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 impostorscore=0 spamscore=1
 mlxlogscore=226 adultscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxscore=1
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100114
X-Proofpoint-GUID: PK4Erc9hpadqP9Y-MNvVbxNXcCIlY0xQ
X-Proofpoint-ORIG-GUID: PK4Erc9hpadqP9Y-MNvVbxNXcCIlY0xQ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=269 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_062934_478809_2AA77105 
X-CRM114-Status: GOOD (  14.34  )
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

PiBTbyBJIGdldCB0aGF0IHRoZXJlIGlzIHplcm8gYXBwZXRpdGUgdG8gc3VwcG9ydCB0aGlzPw0K
DQpJIGRvIGhhdmUgYXBwZXRpdGUgZm9yIHRoaXMuIFl1bSENCg0KTWFydGluDQoNCg0KSW50ZXJu
YWwgVXNlIC0gQ29uZmlkZW50aWFsDQo=

