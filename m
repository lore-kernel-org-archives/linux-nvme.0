Return-Path: <SRS0=OivJ=GG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82A9C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Jan 2021 08:41:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116EA207FB
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Jan 2021 08:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116EA207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Bg6S0MOPPwLqb9FEwluwS0wrFYATRU5f85IsglqT4ps=; b=kh7diVbIpXxiC+8/5zj+xAFFZ
	OkXS87Fy1lh/B73U5k58BFZ29OJTvFkqAZxY4zP/641HEn/cKI12n6iPEUIWwq3b0Q9+v82GRs4u4
	hld4T6sOQmsIMuHC+XNWXXcoavCyb27lOuX7ke6QaetgetChDAAmhz4Oy0+ex46O2mQqE2+KDTBYZ
	cWOh0PXK2sMp7s9wQwGdOeiUboowJDvDAEQSBYsRv6d6jW5OpnqfgZbn5nlAHdJApX98cc46e+J7B
	HV3OLaRluGs2KMEn0WVUHpn9jFB39jaHChjj9/eL9XCd+wRvWyqv/7hjsHffYKNWIVF8J5ZEciHvd
	mFN5+p2rw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kvywZ-000325-2G; Sun, 03 Jan 2021 08:40:55 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kvywS-00030n-Sj
 for linux-nvme@lists.infradead.org; Sun, 03 Jan 2021 08:40:50 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1038asm1029174; Sun, 3 Jan 2021 03:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=7psYsiEg3PK/i9jVk8DlzWKFxkx+hmsB3VbOteT678k=;
 b=dALKMHr+sF8Bs1czQf5d/PeWpvp7wHIbVInMLJmkOGBYmQseuX7urPYJ872pe4Jezi6T
 iaAIwtpWCl2MdSDJLl+ZgRpVTELy8fYgyr0XYaiBM0a5Hpw2lIZVguEdU4n+MGKfNYqx
 qlw4+KrQzGkAQg5SBisBwUU+DWw717nl7H0kkM1nIadrVKM4lImk3cVDkR4uNbBpzlya
 yOWs58KLCQj5rO53fqvus+Pr/TSxf0SxBox4YWR7scdYC24DPh5sxjzXTTQnRb2r974h
 cjAFvNVpuBDz/X7yxElRTfgA9YuYJRq5gQXd7Wp1Lb6jCizM/lW/iQ2WqtjniVcrFaY/ kQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 35tm9a1q22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 03 Jan 2021 03:40:39 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1038UuYZ051778; Sun, 3 Jan 2021 03:40:38 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 by mx0a-00154901.pphosted.com with ESMTP id 35u79g18v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 03 Jan 2021 03:40:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxBrA/GX7WN+cwZ6iqm2EwvKadveVkJpdhba0o1+GOgk/N5Yu5fiT0OUBkIIAwSj+qois/oP3kuu8L9i3mD8p3Gf7YMVJoPq1xmn0I6iKfwltpw7p6p2tkZ+oYXW0UlHXI7UyTfQ3ETN/TKnE1Kg34X3tr1mRB08gNO7qbfOfL4favVW7LUIXjf4AWYSj9oaphH/YRVlrHD86kvxdfMTuabijpm3m75sOuV0+y9wIQtTHQPz1R6nopjnxdQmpfnR7/TxAqasYyIKmYQBOGjp9WMXj+NvzirK0q9wsV/5TdqeBL2RmY4U5M/MRZH1v8qPt3ekjQtgnRHQDZ7AVkp9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7psYsiEg3PK/i9jVk8DlzWKFxkx+hmsB3VbOteT678k=;
 b=R0CT7uBPGWsOWAzgxCOwmh+QPfIMCPPD8OyaymSDDmAU1Y1Z7uqrFCT+VUrVfMC50uDddaF/G0BCuLaYFIIWlur5DviXnvmAXHd5j3IqsKrhZfJKo0rMq60nIrN+Gi+l6n09Yi/b1UWvjWiiUexhv4FKp/qMugAYuCz9/NxByqIjwzSFerMLfufI8ymuuH6C2AlflbE87Mn5sgEzRlo0iB2fLe06Y3VID0X3sahauvp3hjWEGt/QKDnsdO7q95u66tKshLWsgGsQ0b+kGvP8y9gyu6FztNzzTmZSt1Vdmk9xLSvoaPYWdC3O3A1mqJP0crWKg5YoP7TbMybr12n8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7psYsiEg3PK/i9jVk8DlzWKFxkx+hmsB3VbOteT678k=;
 b=VZ/jjZj1hcbiWYpp2zuG6zfF4bMzRJ5G5X0DdbbfN2isbl8xhQwgUaZVqeS29MMaVRADEWpY2ZNgnv3IKoqtkQ3brkWEjP4fXtmmSl98Itv6YMn/fPGr2KJqkdjujYTzUT0sRXEf65KAZ3/1VCrWPjLuAb3gIbIDErZV39DwQq4=
Received: from DS7PR19MB4439.namprd19.prod.outlook.com (2603:10b6:5:2d2::22)
 by DM5PR19MB0985.namprd19.prod.outlook.com (2603:10b6:3:33::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.22; Sun, 3 Jan 2021 08:40:35 +0000
Received: from DS7PR19MB4439.namprd19.prod.outlook.com
 ([fe80::3c1d:1e44:1934:233f]) by DS7PR19MB4439.namprd19.prod.outlook.com
 ([fe80::3c1d:1e44:1934:233f%6]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 08:40:35 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "Anner, Ran" <Ran.Anner@dell.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: kernel panic in nvmet_tcp when receiving malformed admin command
Thread-Topic: kernel panic in nvmet_tcp when receiving malformed admin command
Thread-Index: AdaWdvf+7tpUpYyWRD2wZy6V/04JWAAKtLKAAB62/8ASo86R4A==
Date: Sun, 3 Jan 2021 08:40:35 +0000
Message-ID: <DS7PR19MB4439372515F931BA5A1578ABEED30@DS7PR19MB4439.namprd19.prod.outlook.com>
References: <BL0PR1901MB2067C827A2D826C0FBFE985591320@BL0PR1901MB2067.namprd19.prod.outlook.com>
 <cee26269-c9c3-7ce7-8486-4ed16a632e44@grimberg.me>
 <BL0PR1901MB20671CF789D8C246AF911B4D91330@BL0PR1901MB2067.namprd19.prod.outlook.com>
In-Reply-To: <BL0PR1901MB20671CF789D8C246AF911B4D91330@BL0PR1901MB2067.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Ran.Anner@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-30T11:28:05.6516527Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=353620e3-684f-40d4-ae7e-27c3df5807d7;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbeeca2a-540c-4eee-2854-08d8afc33d41
x-ms-traffictypediagnostic: DM5PR19MB0985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR19MB0985D5E9E75D0A20541A301AEED30@DM5PR19MB0985.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lW4XHlyd4eIz9MN4ZajvDzlH7iPjdJc4HpguyClfgcnTIGKGXeynjT/ETE3A5jgfaes8d+NN1MHtsCy4w7SbckgP3x7b8ghMHizpovLbCwLVwT/ojiBX1Dkt9MRtnmaPWJSW+QTTkblthmaNb207SdLDcnDxxcUN1VeskYWRkuH34a+x7OCFKXqH6b14taqhIXIzTiv1ROff6O1ZbsLGrHJQ5UZqgpeDpfY44fHVBhUc/J3m9w1HY3glQxjdN6487KQRGDKeqCPTiLDsRebAOsToytnmvijQurZ4Dj37brp9dN74Ps5ia04hxoM2fZU+q+vRwQfenCKvF9GBtqDY+YSXN3yvMOhtukbL2+xdA9BPLmMhy0jdt+CkMjLcsrgl1uDOiUXyl7Zk7Z9QcTGDTqbQ4YTQYvDoqCgt0UA8X3LwSBPaIZwOqVLgT2gBgbrBqEyUt6MgStnWH0jHh/Zsbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR19MB4439.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(26005)(9686003)(55016002)(66946007)(76116006)(66476007)(66556008)(64756008)(71200400001)(66446008)(107886003)(4326008)(786003)(316002)(8676002)(33656002)(2906002)(7696005)(186003)(110136005)(54906003)(52536014)(966005)(53546011)(478600001)(8936002)(83380400001)(5660300002)(86362001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TmxnNURQZ1RScmZZeGZoRkl4NWFQMWJzTnNTYXAvQ1c5Rmp4MmlhMFEzNzZH?=
 =?utf-8?B?QkZHNmhnb1MvcDF3TGpaMFVHYW12QUVMMmcyRjlQQTlnMUdzWmxpeVV4NWp0?=
 =?utf-8?B?VmprbHplN3NDUEF1UG50TVVPdTdSY0hSWk9OWGIwY1NjYzJWOS9qUG12aTUr?=
 =?utf-8?B?akN1dUZpRmNTU2Z1QzBYcUZwRENSQzM5OVVXekROVkZ3Wis2djNZbkNUN0FQ?=
 =?utf-8?B?VGhIS0xKZWM5OXlZdC92czhlNDR4ZXNTcHhKRGJlQTdCU2dJcHZHeVE2amZo?=
 =?utf-8?B?T3pNcWVpaU1CSXpSTWRVS2NSSStrU21jbnRHVEdNcVZLVGc3OEJub1dSL1I1?=
 =?utf-8?B?WGwzNW9qOHV0TG5QVGtkVHA2a1JkcHlJUklmcGpXQlpaRFlJek1KU1Jxekww?=
 =?utf-8?B?aGo2UEQ5UHp1MlZqVW1uakt1ejhpZ25HdGpOSGpSbWZrb2dxbmt1TFB0d3d6?=
 =?utf-8?B?U3U3ZThDRVBsejl5c09rOGFYOTFEaUpzZzRId0E0ZHNkWnhyMWRRcEp0Z1Rz?=
 =?utf-8?B?MjRZVnFUNTMyeVBiRTZ0RldXRWJ3SStLMGdEWnRpSm81N210S0U3R3lyenlT?=
 =?utf-8?B?SDNFSUdsb3BXcy9aL1cyUDlCRG9uTXFVbzUweG1hT3dHcm8vUndvZUJoV0hK?=
 =?utf-8?B?MWxXNTNmT2FBZ0k4UUxrMSs1YmpML3dmKzNMWGJiaERHb2N2Rkl2VFpXanFv?=
 =?utf-8?B?R3d0TDd2UnM2ZE1JRnhwQ3Voc0NNeXlYd0tsUk5GQXZ6RlE2Q2lQanlmblhB?=
 =?utf-8?B?OEtGUEJhbWxSbERFSWpNdzh1L3pqS2E5QUxFVDB0RFhCS1ZacmF4dURoR0d2?=
 =?utf-8?B?N2dOeGRxRHFGN0QybEdtNmpvaEp1ZXlqaUpxWFozbCt0RXFuWlk5Y2pLeGRs?=
 =?utf-8?B?ZnlIOXl2bStsOFFpTHI0bDdRN2lVQzdJU1h2bWVwQnRJUFpYanFBMjEvczdL?=
 =?utf-8?B?a1lSZXVRTHhIYkVCRFc0QmIzSE84MlZ4S0pqVnhaQlZZbVhYN0g3c0hPSjZF?=
 =?utf-8?B?NGUyRWZRTnZLZ3dzTjl5SGFaaVp1eFozSm01ZFBRUis1Tm1hZTRjc0dxUUxt?=
 =?utf-8?B?bml5NVYwWEdlOGR0WU9KWmVlNSt1ZEUzODZuNENPZ1VWWXM2K1VVQmUzaHIw?=
 =?utf-8?B?SE9CdktvTnY0dkhia1JKUnlGOGl4dzBLUm1TWjRldFV5M3hJYXlpYTN3NVNR?=
 =?utf-8?B?dk5lbFp4WjlZaHhUUE1aRVBMTVhkc3FJaXpUSWR4OTQxUzdmc2JDRzU0SU8w?=
 =?utf-8?B?cUIxUU5udUFleCtZZ1ZCSFFDSmw3VWlqUWRwMFhBL2FHcFVJMVovTmJDT2RE?=
 =?utf-8?Q?5f3wL5CN4ev3Y=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB4439.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbeeca2a-540c-4eee-2854-08d8afc33d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2021 08:40:35.2949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WW7Y3RYu9pFDwjj/U+ZIVzQFYHf2/plhQSzQyT53PT4Prdw4N4xGTDnp2XbGuSIixLIbzGpttQTvAL7rhtTVoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0985
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-02_13:2020-12-31,
 2021-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101030053
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101030054
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210103_034049_204460_FEE38F0D 
X-CRM114-Status: GOOD (  28.83  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "Zinger, Eldad" <Eldad.Zinger@dell.com>, "Grupi,
 Elad" <Elad.Grupi@dell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgU2FnaSwgaXMgdGhlIHBhdGNoIGFkZHJlc3NpbmcgdGhlIGJlbG93IGlzc3VlIGlzIGFscmVh
ZHkgb3V0IHRoZXJlPyANCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbm5lciwg
UmFuIDxSYW4uQW5uZXJAZGVsbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMzAs
IDIwMjAgMjoyOCBQTQ0KVG86IFNhZ2kgR3JpbWJlcmc7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KQ2M6IFppbmdlciwgRWxkYWQ7IEdydXBpLCBFbGFkOyBFbmdlbCwgQW1pdA0KU3Vi
amVjdDogUkU6IGtlcm5lbCBwYW5pYyBpbiBudm1ldF90Y3Agd2hlbiByZWNlaXZpbmcgbWFsZm9y
bWVkIGFkbWluIGNvbW1hbmQNCg0KVGhhbmtzIHlvdSBTYWdpLg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4gDQpTZW50
OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjAgMTE6NDggUE0NClRvOiBBbm5lciwgUmFuOyBs
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNCkNjOiBaaW5nZXIsIEVsZGFkOyBHcnVwaSwg
RWxhZDsgRW5nZWwsIEFtaXQNClN1YmplY3Q6IFJlOiBrZXJuZWwgcGFuaWMgaW4gbnZtZXRfdGNw
IHdoZW4gcmVjZWl2aW5nIG1hbGZvcm1lZCBhZG1pbiBjb21tYW5kDQoNCg0KW0VYVEVSTkFMIEVN
QUlMXSANCg0KDQo+IEhlbGxvIGFsbC4NCg0KSGV5IFJhbiwgdGhhbmtzIGZvciByZXBvcnRpbmcN
Cg0KPiANCj4gV2UgYXJlIGludmVzdGlnYXRpbmcga2VybmVsIHBhbmljIHdoZW4gYSBtYWxmb3Jt
ZWQgYWRtaW4gY29tbWFuZCB3aXRoIGlubGluZSB3cml0ZSBkYXRhIGlzIHNlbnQgZnJvbSBob3N0
IHRvIHRhcmdldCB1c2luZyBudm1lb2YgdGNwLg0KPiBGb2xsb3dpbmcgYSBjb2RlIHJldmlldyBv
ZiBudm1ldF90Y3AgZnJvbSBsYXRlc3Qga2VybmVsIGFuZCBhZGRpbmcgZGVidWcgbG9ncyBhbG9u
ZyB0aGUgd2F5IEkgY2FtZSB1cCB3aXRoIHRoZSBmb2xsb3dpbmcgZmxvdzoNCj4gDQo+IG52bWV0
X3RjcF90cnlfcmVjdl9wZHUgc2VuZHMgYW4gSU8gd2l0aCBpbmxpbmUgZGF0YSB0byBudm1ldF9y
ZXFfaW5pdC4NCj4gbnZtZXRfcmVxX2luaXQgc2VuZCB0byBwYXJzZSB3aGljaCBmYWlscyAoZXgu
IGhvc3Qgc2VuZHMgbWFsZm9ybWVkIGNvbW1hbmQpLg0KPiBudm1ldF9yZXFfaW5pdCBjYWxscyBf
X252bWV0X3JlcV9jb21wbGV0ZSwgYW5kIGluIHR1cm4gY2FsbHMgcXVldWVfcmVzcG9uc2UuDQo+
IG52bWV0X3RjcF9xdWV1ZV9yZXNwb25zZSBhZGQgdGhlIGNvbW1hbmQgdG8gcXVldWUgcmVzcG9u
c2UgbGlzdC4NCj4gbnZtZXRfcmVxX2luaXQgcmV0dXJuIGVycm9yIHN0YXR1cyBhbmQgbnZtZXRf
dGNwX2hhbmRsZV9yZXFfZmFpbHVyZSBpcyBjYWxsZWQuDQo+IG52bWV0X3RjcF9oYW5kbGVfcmVx
X2ZhaWx1cmUgY2hlY2tzIGlmIHRoZSBjb21tYW5kIGhhcyBpbmxpbmUgZGF0YSBhbmQgd2lsbCBh
bGxvY2F0ZSBwYWdlcyBhbmQgaW92cy4NCj4gbnZtZXRfdGNwX2hhbmRsZV9yZXFfZmFpbHVyZSBy
ZXR1cm4gYW5kIG52bWV0X3RjcF9kb25lX3JlY3ZfcGR1IHJldHVybnMgLUVBR0FJTi4NCj4gbnZt
ZXRfdGNwX3RyeV9yZWN2X3BkdSByZXR1cm5zIC1FQUdBSU4gYW5kIGluIHRoYXQgY2FzZSBudm1l
dF90Y3BfdHJ5X3JlY3Zfb25lIHJldHVybnMgMC4NCj4gSW4gY2FzZSBudm1ldF90Y3BfdHJ5X3Jl
Y3Zfb25lIHJldHVybnMgMCwgbnZtZXRfdGNwX3RyeV9yZWN2IGJyZWFrcyBmcm9tIGxvb3AgYW5k
IHJldHVybiB6ZXJvIGFzIHdlbGwuDQo+IEluIG52bWV0X3RjcF9pb193b3JrIHdlIGNvbnRpbnVl
IHRvIG52bWV0X3RjcF90cnlfc2VuZCBpbiBjYXNlIHRoZSByZXR1cm4gdmFsdWUgaXMgemVyby4N
Cj4gbnZtZXRfdGNwX3RyeV9zZW5kX29uZSB3aWxsIGNhbGwgbnZtZXRfdGNwX2ZldGNoX2NtZCB3
aGljaCBjYW4gYXNzaWduIHNuZF9jbWQgYXMgdGhlIGZhaWxlZCBjb21tYW5kLg0KPiBudm1ldF90
Y3BfbmVlZF9kYXRhX291dCBhbmQgbnZtZXRfdGNwX25lZWRfZGF0YV9pbiByZXR1cm4gZmFsc2Ug
c28gd2UgY2FsbCBudm1ldF9zZXR1cF9yZXNwb25zZV9wZHUuDQo+IG52bWV0X3NldHVwX3Jlc3Bv
bnNlX3BkdSBzZXQgdGhlIGNtZCBzdGF0ZSB0byBOVk1FVF9UQ1BfU0VORF9SRVNQT05TRSBhbmQg
cmV0dXJuLg0KPiBCYWNrIHRvIG52bWV0X3RjcF90cnlfc2VuZF9vbmUsIGNtZC0+c3RhdGUgPT0g
TlZNRVRfVENQX1NFTkRfUkVTUE9OU0Ugc28gbnZtZXRfdHJ5X3NlbmRfcmVzcG9uc2UgaXMgY2Fs
bGVkLg0KPiBBZnRlciBrZXJuZWxfc2VuZHBhZ2Ugd2UgZnJlZSB0aGUgY21kIGlvdiBhbmQgc2ds
Lg0KPiBFdmVudHVhbGx5IG52bWV0X3RjcF90cnlfcmVjdl9kYXRhIHdpbGwgYmUgY2FsbGVkIGJ1
dCB0aGUgaW92IHdhcyBhbHJlYWR5IHJlbW92ZWQgYW5kIGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVs
dCBpcyB0cmlnZ2VyZWQuDQo+IA0KPiBJIHdhcyB3b25kZXJpbmcgaWYgdGhpcyBpcyBhIGtub3dz
IGlzc3VlIG9yIGlmIHNvbWVvbmUgZWxzZSBlbmNvdW50ZXJlZCB0aGlzIGJlZm9yZS4NCj4gSXQg
c2VlbXMgdG8gbWUgYSBmaXggZm9yIHRoaXMgd291bGQgYmUgdG8gbm90IHF1ZXVlIHRoZSByZXNw
b25zZSBiZWZvcmUgcmVjZWl2aW5nIGFsbCBkYXRhIGluIHRoaXMgc3BlY2lmaWMgZmxvdy4NCj4g
QWRkZWQgYmVsb3cgc25pcHBldCBvZiB0aGUga2VybmVsIHRyYWNlLg0KPiBBbHRlcm5hdGl2ZWx5
IGlmIHdlIGRvIG5vdCB3YW50IHRvIGRlbGF5IHRoZSByZXNwb25zZSwgZnJlZSB0aGUgaW92IGFm
dGVyIGJvdGggZmxvd3MgYXJlIGRvbmUsIG1heWJlIHVzaW5nIHJlZmVyZW5jZSBjb3VudGluZyB0
byBkbyBzby4NCj4gSSB3aWxsIGJlIGdsYWQgdG8gaGVhciB5b3VyIHRob3VnaHRzIGFuZCBjb21t
ZW50cy4NCg0KVGhpcyBpcyBpbmRlZWQgYSBidWcuIFdlIGRlZmluaXRlbHkgbmVlZCBhIHJlZmNv
dW50IGhlcmUuIEkgcmVjYWxsIHRoYXQgdGhpcyB1c2VkIHRvIHdvcmsgdGhvdWdoLi4NCg0KV2hh
dCB3ZSBwcm9iYWJseSBuZWVkIHRvIGRvIGlzIHRvIGRlZmVyIHRoZSByZXNwb25zZSBzZW5kIHVu
dGlsIHdlIGNvbXBsZXRlIGZldGNoaW5nIHRoZSBlbnRpcmUgaW5jb21pbmcgZGF0YSBhbmQgdGhl
biBzYWZlbHkgZnJlZSB0aGUgY29tbWFuZC4NCg0KSSdsbCB0cnkgdG8gc3BpbiBhIHBhdGNoIHNv
b24uDQoNCj4gDQo+IFRoYW5rIHlvdSwNCj4gUmFuLg0KPiANCj4gWzEzNTM4LjA0NjM2NF0gZ2Vu
ZXJhbCBwcm90ZWN0aW9uIGZhdWx0OiAwMDAwIFsjMV0gU01QIE5PUFRJIA0KPiBbMTM1MzguMDUx
NzYyXSBDUFU6IDEwIFBJRDogNjAzIENvbW06IGt3b3JrZXIvMTA6MUggS2R1bXA6IGxvYWRlZCAN
Cj4gVGFpbnRlZDogR8KgwqDCoMKgwqDCoCDCoFfCoCBPRcKgwqDCoMKgIDQuMTkuMTM0LWNvcmVv
cy1yOTk5OS4xNjAwNzc0MDk1LTE2MTAgIzEgDQo+IFsxMzUzOC4wNjM1NzRdIEhhcmR3YXJlIG5h
bWU6IEVNQyA5MDAtNTMyLTAwMi8xMTAtNTUxLTkxMEMtMDEsIEJJT1MgDQo+IDE2LjM1IDA0LzA4
LzIwMjAgWzEzNTM4LjA3MTA0OV0gV29ya3F1ZXVlOiBudm1ldF90Y3Bfd3EgDQo+IG52bWV0X3Rj
cF9pb193b3JrIFtudm1ldF90Y3BdIFsxMzUzOC4wNzcxNDJdIFJJUDogDQo+IDAwMTA6bWVtY3B5
X2VybXMrMHg2LzB4MTAgWzEzNTM4LjA4MTIzN10gQ29kZTogOTAgOTAgOTAgOTAgZWIgMWUgMGYg
MWYgDQo+IDAwIDQ4IDg5IGY4IDQ4IDg5IGQxIDQ4IGMxIGU5IDAzIDgzIGUyIDA3IGYzIDQ4IGE1
IDg5IGQxIGYzIGE0IGMzIDY2IA0KPiAwZiAxZiA0NCAwMCAwMCA0OCA4OSBmOCA0OCA4OSBkMSA8
ZjM+IGE0IGMzIDBmIDFmIDgwIDAwIDAwIDAwIDAwIDQ4IDg5IA0KPiBmOCA0OCA4MyBmYSAyMCA3
MiA3ZT4gWzEzNTM4LjA5OTk4MV0gUlNQOiAwMDE4OmZmZmZjOTAwMDc4MWJjNzAgDQo+IEVGTEFH
UzogMDAwMTAyMDIgWzEzNTM4LjEwNTE5OV0gUkFYOiAzMWQyNDdjYTE5NThmNjNmIFJCWDogDQo+
IDAwMDAwMDAwMDAwMDA1MTAgUkNYOiAwMDAwMDAwMDAwMDAwNTEwIFsxMzUzOC4xMTIzMjJdIFJE
WDogDQo+IDAwMDAwMDAwMDAwMDA1MTAgUlNJOiBmZmZmODg4NjQ0NWY2MGNhIFJESTogMzFkMjQ3
Y2ExOTU4ZjYzZiANCj4gWzEzNTM4LjExOTQ0Nl0gUkJQOiBmZmZmODg4MzA4YzQxOTIwIFIwODog
MDAwMDAwMDAwMDAwMDUxMCBSMDk6IA0KPiBmZmZmODg4NTBiOTZlMmJjIFsxMzUzOC4xMjY1NzBd
IFIxMDogZmZmZjg4ODUwYjk2ZGU0OCBSMTE6IA0KPiBmZmZmODg4NjQ0NWY2MGNhIFIxMjogMDAw
MDAwMDAwMDAwMDUxMCBbMTM1MzguMTMzNjkzXSBSMTM6IA0KPiAwMDAwMDAwMDAwMDAwNTEwIFIx
NDogZmZmZjg4ODY0NDVmNjVkYSBSMTU6IGZmZmY4ODg2OTAyZGRkOTAgDQo+IFsxMzUzOC4xNDA4
MTldIEZTOsKgIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4OTdkZmU4MDAwMCgwMDAw
KSANCj4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMCBbMTM1MzguMTQ4OTA2XSBDUzrCoCAwMDEwIERT
OiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMyBbMTM1MzguMTU0NjUwXSBDUjI6
IDAwMDA3ZjU0NzE2OWJlYjAgQ1IzOiAwMDAwMDAwMDAyMjBhMDAxIENSNDogMDAwMDAwMDAwMDc2
MDZlMCBbMTM1MzguMTYxNzcyXSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAw
MDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMCBbMTM1MzguMTY4ODk2XSBEUjM6IDAwMDAwMDAw
MDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMCBbMTM1
MzguMTc2MDIyXSBQS1JVOiA1NTU1NTU1NCBbMTM1MzguMTc4NzI2XSBDYWxsIFRyYWNlOg0KPiBb
MTM1MzguMTgxMTcxXcKgIF9jb3B5X3RvX2l0ZXIrMHgzMGUvMHgzYjAgWzEzNTM4LjE4NDkyNV3C
oCA/IA0KPiB3YWtlX3VwX2tsb2dkLnBhcnQuMjQrMHgzMC8weDQwIFsxMzUzOC4xODkzNzJdwqAg
DQo+IHNrYl9jb3B5X2RhdGFncmFtX2l0ZXIrMHg3Yi8weDI2MCBbMTM1MzguMTkzODE1XcKgIA0K
PiB0Y3BfcmVjdm1zZysweDIzOC8weGM4MCBbMTM1MzguMTk3Mzk1XcKgID8gDQo+IG52bWV0X3Rj
cF9pb193b3JrKzB4NDAwLzB4YTgwIFtudm1ldF90Y3BdIFsxMzUzOC4yMDI3MDddwqAgPyANCj4g
cmVsZWFzZV9zb2NrKzB4NDMvMHg5MCBbMTM1MzguMjA2MzczXcKgID8gdGNwX3NlbmRwYWdlKzB4
NDEvMHg1MCANCj4gWzEzNTM4LjIxMDAzOF3CoCBpbmV0X3JlY3Ztc2crMHg1Yi8weGQwIFsxMzUz
OC4yMTM1MjJdwqAgDQo+IG52bWV0X3RjcF9pb193b3JrKzB4ZWEvMHhhODAgW252bWV0X3RjcF0g
WzEzNTM4LjIxODU3MF3CoCANCj4gcHJvY2Vzc19vbmVfd29yaysweDIwNi8weDQwMCBbMTM1Mzgu
MjIyNTgwXcKgIHdvcmtlcl90aHJlYWQrMHgyZC8weDNlMCANCj4gWzEzNTM4LjIyNjI0M13CoCA/
IHByb2Nlc3Nfb25lX3dvcmsrMHg0MDAvMHg0MDAgWzEzNTM4LjIzMDQyMV3CoCANCj4ga3RocmVh
ZCsweDExMi8weDEzMCBbMTM1MzguMjMzNjQ3XcKgID8ga3RocmVhZF9iaW5kKzB4MjAvMHgyMCAN
Cj4gWzEzNTM4LjIzNzMxMl3CoCByZXRfZnJvbV9mb3JrKzB4MWYvMHg0MA0KPiANCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QNCj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQ0KPiANCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
