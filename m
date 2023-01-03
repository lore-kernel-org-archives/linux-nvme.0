Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E0CC3DA7D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCLtlSXCl7lDXrhHUQ8tV7IpuPIIXDT8xOhCFB67kKg=; b=IDbMoQRj+TFzLTl4KPVTBgD0eY
	hrsk1ROORmf4ylbrkGETLK8FYbzkrp6EILltWqQp1Gv0aFBmLy4v5mTEo44pIf9D0a2K7hZUeCZ3c
	uV/xoEhaiSJE6fn0cihFCjJaRx94rQKjyP1TLQiyaxC27zGk9CN8NNBjMMYu/KfgUJUNUGsZIpCl5
	U3jX7nUxydpXApfIhnD6m8lY3rKqn79xBJ2tsfuNzjbECGX4HC+6FQU/9pzNi6ljBokRBedf9QnL9
	0Y5achIbrN8XVLPX5FsleoSngpWBk3bJEAouKfsD6XJfoIhmPpUWH85mSFq6drkum81LqptPOuCOl
	+2Sv7WOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCkGK-002ypK-Ep; Tue, 03 Jan 2023 16:35:42 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pChDc-001UU8-EF
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 13:20:45 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3038wVQu001323;
	Tue, 3 Jan 2023 08:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=PCLtlSXCl7lDXrhHUQ8tV7IpuPIIXDT8xOhCFB67kKg=;
 b=RphEJBBk4uZ2GBtg+MXbi++F2LspU6ERkgAm802zHw/u8Ufu+07ylY0Wi1zR9+ce371l
 G72LQa54P60XBCUg/8ocnzS6sj+vXsuVb457Ifa93qVazC5hs1lQM2H5bKPHloP2+zmh
 HrhvCw4vxfH/AUhypM7WElWa4b2Zzo0y2rq0tcgdcVTXXosM7jFIC7CqwX9XOIn/ZX95
 Y5TtsvdfVCiNzlC8aa1PGJnXAcVNSigqvRGlZtkiyxryApNXo44oet8l5wv+ka9l3pyl
 W3ri4+BVNuqX+ah8BhpXEzizTf/umOH5Df0aHUhkTyYeXLNfP1bz61IA5Lc1tYBS1IcU mQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3mth6fd35p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jan 2023 08:20:34 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303DADhu027378;
	Tue, 3 Jan 2023 08:20:33 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3mvfd8nejq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jan 2023 08:20:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLy3BV06K3PsYN5zCWdqlbEQ8Lw87q5eCKKT1bdcg6e5sG1FmmySOQZMhGdR8cq7E3R/K8ivVgKPn1klh/usL5Kz7Rl+dEnM7aBmA1kAiEOKvrtQrzevUeyQa3dAPHBpzq2HHY2VyAvmE2bOD7uuRfjU1t4IhMqqvvMiIiBo+UhTQugcT62PymJvO7P5uZSj1/BJRJUuV1bYc4Qp6yu/FsXnSf6GPfrzSzFqnlMnNQACd7rciYYR1g7Usz7M+/u6hSZ3pSQcQilzNj0YNBhFO3hdXN6H9wUeim0EoVGzIjmIMUyIOVO7Sf4bpN/ftm02GxcVud387ZIb3TbQCqRScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCLtlSXCl7lDXrhHUQ8tV7IpuPIIXDT8xOhCFB67kKg=;
 b=T4JvlnChcJUPhTSlzEaqkflXt6tCLGXCOgJbfArPq4Y/Deq09gKIFuPWRMMKtiTIRwfi/rbH4H4S80JZrnd83DEyfVaFL39TuPaW0Vvhc8HIegVftqXyc4f6lljv4wn2JdnbPZBsg6VkhcI/WNeUSKHh8erPLp4wZbQnF0f/lvqNFIRk4zoZQZvVDd2hXh6QpNyQIpJqZR0EPKb4ytoI0+ql7WjD6EspZ4a9MzafoYcj1qSVfCY8mN5Rky7Bg2WD2y87/nvH+IQjjx7jxSp/ciHXEM166y7+xJ1VojOXov9FLPCRXkHHvveoRSkMSM8VN4B4qUxMVRI8uZRrJw0qIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by PH8PR19MB7807.namprd19.prod.outlook.com (2603:10b6:510:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 13:20:28 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 13:20:28 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Grupi,
 Elad" <Elad.Grupi@dell.com>,
        "Zinger, Eldad" <Eldad.Zinger@dell.com>
Subject: RE: nvmet_check_data_len() wrong behavior for nvme admin set features
 cmd
Thread-Topic: nvmet_check_data_len() wrong behavior for nvme admin set
 features cmd
Thread-Index: AQHZH3Qek1Bkt4f4YkGpY8Ga9cAU0a6MrPtw
Date: Tue, 3 Jan 2023 13:20:28 +0000
Message-ID:  <CO1PR19MB4885EF6A9AE5135487F853BAEEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
References:  <CO1PR19MB48850262EAB600869034D420EEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b8154d21-d009-1077-e07d-980b249a56c3@grimberg.me>
In-Reply-To: <b8154d21-d009-1077-e07d-980b249a56c3@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-01-03T13:19:09Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=a4335766-f0ca-4e08-b277-f6b1f1f8f62e;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|PH8PR19MB7807:EE_
x-ms-office365-filtering-correlation-id: 9eafa985-ec21-4d2d-d669-08daed8d4872
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  LQwbaQOvoO5/r8MbF94m7LKpjP78tOd+cmtQ9UY232+j/BNqT753Wg+SXfByoSGmuy/HbmgK7Q9i0p25pyfCWT60dMWYpUSl9U8qiT5izliblJu/PTsSgWYky6ytPxmfALw2OMjxnh/clxIkbJyib4GT5JgZz3wqIwRdrf3qWrFFY/SdCe2I1SUzoVn/H7zRaSZvSCTpYXj5D67AQG2gXkAMccSl3vihNecutH6n7JBqbVbulrCV9DlKIQLRWsNBLCnXQmoq5xuOOm97JsLJl5FkWHy0tPDDMruXGm2WVT66AlrPHuAmAOLzeucc/L8IdSKbSOah3he7AAib21WjFRDZ4AhiQdDpoeDGYNydGkPdTMopuZWyH67UjdJ8H6BMSlqyRFy0P696gs0uP1WP4l4uKnsFm4n6eQO2xYJtExWTvt0i0/8uP9yeSd554Pakz0ga9dFge+JGXZaWdR1A9o8j4d8lim8Xe0b05dsSpG4r/KoGIvEJ3UU+c4H2ZSyYYvgKUFje7BxTKB9eOIU/9xKAPTfHgSpoWVJPq5AoEJiBUAfiQBQJTBmQWJgYqyx0qRJffPEFwkWT0AqRosj0nqV5pMVHPSo5VT2ATjXD4/PIltKu6C5u8OL3+LfDJMl1W2MKIs7zSzFFozrDTv9QaPKlYFj4ZNbS3CF83CRXzkHoSEU/zeHW1yLo70EGfnInntkoHUJjp8/ySz/OFRMjyNVfUs+7pr7F5Mi8iLglPCI=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(26005)(186003)(9686003)(53546011)(7696005)(33656002)(107886003)(83380400001)(55016003)(86362001)(38070700005)(82960400001)(38100700002)(122000001)(6506007)(8676002)(52536014)(4326008)(41300700001)(2906002)(5660300002)(8936002)(478600001)(71200400001)(76116006)(66946007)(66556008)(316002)(786003)(66476007)(6916009)(54906003)(64756008)(66446008)(22166006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?aXNBaU9RZ0dDRWN1N3hnSzBwMmk0MWw4T3I4M0ZZRTR0SERIcXJPb21NQjhv?=
 =?utf-8?B?OEhhTS9VVzNvVXRodWhyUFBxWXd3cXlLVUV6WmJDelY5OEVTZmxaczhqV0kz?=
 =?utf-8?B?SHVldFZaVitHTmtSQWJVU2poVGhwSnNSUEI1SXNpdFQ2dXM3TG1IY3VOWkpZ?=
 =?utf-8?B?SEQyN3lKMzRRS0tDUWVIRyswbWNhMUtCUFVtVG9rMVhPYlRTR3IzWXhiemRX?=
 =?utf-8?B?T1JKRXYvUVRwQXVpUGlPaU1ZNzVsYkpwclBCRjlCaDdwYXI3MXV2aUNBajk5?=
 =?utf-8?B?VE5waW54SDVsVEY1SW5mZ1d6Z3pWMGRQeHJkdXBXR25naUxGVjF6T0dPQlBj?=
 =?utf-8?B?akZBQUhkUmdacjAvQXpESzZEa2txem85NGFVUGlQWFk2R1k0UE1rcG9UZVBa?=
 =?utf-8?B?R0xxVmJ5Q09JYlpzSENhRFZjb0hjT2VUeVJFSGpyV045TURsdG4zRldpaklh?=
 =?utf-8?B?ekhicFpFODdQU21hR3pYYjJ6ZkVHSXB0d0kwSzV4UjhaOVVMUlFGc0FRSUNS?=
 =?utf-8?B?VXI1bHE5cjZRcTRLVWt3UWRFc0gxb3JwRmVqOGhjby9tWitiVy8wK1ZEWWZz?=
 =?utf-8?B?Q1k1Tmo3OHdQMisvNlBvS2pCSFpJNXdPUTU5Y0E5SzFDYldwdnovQ3A0c2RH?=
 =?utf-8?B?KyswQmMycGlGNnpmSWJ2QmNCaHpIOVAvRE83S2srSnI2VkN2NXk5NTRpcHlj?=
 =?utf-8?B?TGtBVTRGUjhJSmRkaEtFUzhTSDF6TXhJSDE3dE1sR2Qwd3ZHS2QwZENtaWpU?=
 =?utf-8?B?MHNUdXdsTjAzZnVMT0RqVDZIby95dkdNNysydFUvcTlMRzc1VWcyMWQ3ZUp0?=
 =?utf-8?B?dDVOMDh4SFNOa3VmN3Q5ZE5XV3l0UmZZMlBmRGRvekVkNDBOUUg1UFhuTTBl?=
 =?utf-8?B?ZSt6THdNcWUrQlpJaExkdmNJTUNGVXkzRTNsRnBaM0l0eUE4RnB0QkF3TGFM?=
 =?utf-8?B?ZlNEZWlRUGZDL1NVQjg0ZmNrWko1SDlPMDY3WDNGckZNT09ZNmQraTBKTnVs?=
 =?utf-8?B?NUR6VFB3L3FaWGUzUDVBbmlrY05aRXhwdGhPZjFPazMxeVZYQTB6eDhQL1g5?=
 =?utf-8?B?UndCVDMyS2pPaDk2QmFycE44OXNuRTd6OVdIb1pYN0M4ZnJFRkhidW81Tzh2?=
 =?utf-8?B?NWRDUzgyL1Rvb0ViK3hPWlVUZGFqcmR3N1dOOFBKb3RleExiYWxTUGx2RzBV?=
 =?utf-8?B?V08wVlpuQTZTWXFrRDhpRkYrU2E2T3E4SzJlb2R4TkptMGM1ZzBVUUFScmVM?=
 =?utf-8?B?N0VJMDArRzQxRkhMblZiRGlkeVJ5YVlVakszMkdRVXBYV2sxS3hvdGQxMTZs?=
 =?utf-8?B?Z3VUOVFhbkVxTkRrSnZYRU9acFBrUXJrajJNaHVLNzZCSm5USjZpdWtrRHkv?=
 =?utf-8?B?RWMwNWxGNU9MUVlzWnA4UWlCbFhBREhvWVFLT3Y3bWcxMVd5TGJLOElWd1M2?=
 =?utf-8?B?UHRqK3JMRFRZSnhVY2s2M2ttTTcvWkpCeGFBejkvMGtJekw4RWhUYmR4SFM3?=
 =?utf-8?B?U1RGdWE2bXZ0OWcwOXpadlBrdTQ4Z0Fja0w2R1BBeTB3bjVJUUVvRXBkOXlL?=
 =?utf-8?B?cWQ3TEhwN1VOUFErT1JwTUZnOGNuQ1B4UkFOYjB1OGdoOUxvTWhBUVh3MXhV?=
 =?utf-8?B?U3hIK25CbXI4Sy9HTmxuSmkrSlBsZHdaV1lMZUE4dWFHYUVCcE1mZDhUVzkv?=
 =?utf-8?B?OFAvQlB4MlRYUE5iL1JjYnVqdDdnK0NaV3FTZE1oUXNjc1o0V3ZSRmEyeFBD?=
 =?utf-8?B?SUhaOE9PaS9IcndMTkZKUWp3aG5aekdSV2V6M3kzT3lGTHpDTXlwT082U1lT?=
 =?utf-8?B?V2tWYnpiaDlPV2hBdEFuVnY5VjArVG5aZlhzRm0va0srNnhHQk9jRDh3YkdY?=
 =?utf-8?B?cEdQY3BTVjB4R2FYSWlnS25BRHROMVhNbXBtTjZKSmFsdlE2bER3djd6b0FZ?=
 =?utf-8?B?d1VIQVZzcnlzMEdMRkt2MndJWFpIdzJaV3VORDIxS1gveG1XcHltMk9IYkE1?=
 =?utf-8?B?clY2TlFxNWhwOWxlK0NxbWpIa2ZiS3lmd2VBNHcrUGV4YkpBMkNWNTRhS2pj?=
 =?utf-8?B?N2hlbWV0VHJjWmdOQWRWcElnM3FIL0FpTHg3ZWFTUEFmZm50bzdoUjJIUkRq?=
 =?utf-8?Q?sHMQ0GHJmsydpMCwtMPZiiic8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eafa985-ec21-4d2d-d669-08daed8d4872
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 13:20:28.7378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWbKZCxLnMUL2/fp80VG5GLBmm3woDBuAfPwB9N8cPeQGl4WaPODmP7hXEIPSzFX37aaXe1XWo2Z0zL1ArQcJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030116
X-Proofpoint-GUID: ECFhWMyXKz8j6lEzWX1jVBoL66k0BSkD
X-Proofpoint-ORIG-GUID: ECFhWMyXKz8j6lEzWX1jVBoL66k0BSkD
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_052040_830423_69662BFE 
X-CRM114-Status: GOOD (  21.13  )
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

T2sgSSBzZWUsIHllcywgdGhpcyBpcyBleGFjdGx5IHdoYXQgd2UgbmVlZC4NCkkgd2lsbCBhZGQg
aXQgYWxzbyB0byBzZXQgZmVhdHVyZXMNCg0KVGhhbmtzDQpBbWl0DQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPiANClNl
bnQ6IFR1ZXNkYXksIDMgSmFudWFyeSAyMDIzIDE1OjA2DQpUbzogRW5nZWwsIEFtaXQgPEFtaXQu
RW5nZWxARGVsbC5jb20+DQpDYzogbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBHcnVw
aSwgRWxhZCA8RWxhZC5HcnVwaUBkZWxsLmNvbT47IFppbmdlciwgRWxkYWQgPEVsZGFkLlppbmdl
ckBkZWxsLmNvbT4NClN1YmplY3Q6IFJlOiBudm1ldF9jaGVja19kYXRhX2xlbigpIHdyb25nIGJl
aGF2aW9yIGZvciBudm1lIGFkbWluIHNldCBmZWF0dXJlcyBjbWQNCg0KDQpbRVhURVJOQUwgRU1B
SUxdIA0KDQoNCj4gSGkgU2FnaSBldCBhbC4NCj4gDQo+IFdlIHNlZSBhIHdyb25nIGJlaGF2aW91
ciBpbiBudm1ldC9jb3JlLmMgIG52bWV0X2NoZWNrX2RhdGFfbGVuKCkgZnVuY3Rpb24gZm9yIG52
bWUgYWRtaW4gc2V0X2ZlYXR1cmVzIGNvbW1hbmQ6DQo+IEN1cnJlbnQgbnZtZXRfY2hlY2tfZGF0
YV9sZW4oKSBjb2RlIGlzIGNoZWNraW5nIGlmIGRhdGFfbGVuICE9IHJlcS0+dHJhbnNmZXJfbGVu
Lg0KPiANCj4gVGhlcmUgYXJlIHNvbWUgZmVhdHVyZSBpZHMgd2hpY2ggdGhlIHRyYW5zZmVyX2xl
biB0aGF0IGlzIGJlaW5nIHNlbnQgYnkgdGhlIGhvc3QgaXMgbGFyZ2VyIHRoYW4gdGhlIHBheWxv
YWQgaXRzZWxmLg0KPiBGb3IgZXhhbXBsZToNCj4gZmlkIDB4RSwgdGhlIGRhdGFfbGVuIHRoYXQg
aXMgc2VudCBieSB0aGUgaG9zdCBpcyA4Lg0KPiBmaWQgMHhDLCB0aGUgZGF0YV9sZW4gdGhhdCBp
cyBzZW50IGJ5IHRoZSBob3N0IGlzIDI1Ni4NCj4gDQo+IEluIHRoaXMgY2FzZSwgdGhlIGVycm9y
IHRoYXQgaXMgcmV0dXJuZWQgdG8gdGhlIGhvc3QgaXMg4oCYTlZNRV9TQ19TR0xfSU5WQUxJRF9E
QVRBIHwgTlZNRV9TQ19ETlLigJksIHdoaWNoIGlzIG5vdCBhY2N1cmF0ZS4NCj4gIEZyb20gb3Vy
IHVuZGVyc3RhbmRpbmcsIHRoZSBob3N0IGlzIGFsbG93ZWQgdG8gc2VuZCBzZ2wgZGVzY3JpYmlu
ZyBhIGJlZmZlciB0aGF0IGlzIGxhcmdlciB0aGFuIHRoZSBwYXlsb2FkLg0KPiANCj4gV2UgdGhv
dWdodCB0byBjaGFuZ2UgdGhlIGNvbmRpdGlvbiBpbiBudm1ldF9jaGVja19kYXRhX2xlbigpIHRv
IGNoZWNrIGlmIOKAmGRhdGFfbGVuID4gcmVxLT50cmFuc2Zlcl9sZW7igJkuDQo+IE9ubHkgaW4g
dGhpcyBjYXNlLCB0aGUgZXhwZWN0ZWQgc3RhdHVzIGNvZGUgaXMgSW5kZWVkIA0KPiBOVk1FX1ND
X1NHTF9JTlZBTElEX0RBVEEgfCBOVk1FX1NDX0ROUg0KDQpXZSBhbHJlYWR5IGhhdmUgYSBoYW5k
bGUgZm9yIHRoYXQgaW4gbnZtZXRfY2hlY2tfZGF0YV9sZW5fbHRlKCkgdGhhdCBpcyB1c2VkIGJ5
IGRzbSBoYW5kbGVycywgaXQgc2hvdWxkIGJlIGFkZGVkIHRvIHRoZSBzcGVjaWZpYyBwbGFjZXMg
d2hlcmUgaXQgaXMgYXBwcm9wcmlhdGUuDQo=

