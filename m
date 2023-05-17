Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8B3C77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=icRZ3eA7rJBmKTqaq9oOQVrQUziM6KcCQSnGTeFYvxE=; b=iNRMoLPXDcnQ5f2Pfaj87yywmJ
	XLSVzU0I/IZ1/d+4lUWm2tZT26IOVsGZKz32iHgjGRwxXWdnkSF0nBMppyaqMvL+ZU7/ub5yVJkpT
	7pMR5ZOtzeF8O1qSMdPAjNJBi2x0eIT2wSmvKilDvPZL6zrZ+vt8r0RFMNjYhW58vxIfq/RCpFlhj
	yFNg8Tin27fuGCHsCckoivid8Guk7Doy7+rc5lx7lt/xRhUlI6Kfvnx1v31HogkMWVKpJJadA4zv9
	zEP+3FSWSmgh+F6u9k9Xl90pcY9Wnf1urCH+kxuDLBf8vMhgUo2fqRrff8451/MIb3AueFOgY3V4j
	+RVvKYTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzK0A-00AT5Z-0u;
	Wed, 17 May 2023 16:27:46 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzK07-00AT4d-0a
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 16:27:44 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HF7EUM004456
	for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 12:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=icRZ3eA7rJBmKTqaq9oOQVrQUziM6KcCQSnGTeFYvxE=;
 b=Q4SDZc2/bjBiqFhoV4GauUiYl85SwBRRJYEg1GwtYQMWj6TVswsRGOVh32hCtrK5JcK3
 QfS3RAsmIl/3E6cE7OCaDKbWgpC9YCuI0+Hqk4ad065EkhOuLahls55KihbYw+Hi2Nyz
 9362lBl+9kl2a1Qs1CQhSsX9DlbLMNql/aVQZI0HFmfReJgx+ip03yu5b8/MmGPy9RdV
 2X3Ssb8OW1EsWm14o2veyL+zLmcBcXQjnEzRVgzQWk/Ak1aVrAbU4pkigYYsuTQo1Fq5
 xNenf96APX7ifs7Hx/7E5qCXviwGDWTxK/7QbOABQ+yBtrRIr0mk3iFKLMfBts/iFkjc mw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3qj5m2jagr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 12:27:41 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HGGEEb027165
	for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 12:27:40 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3qjqsswmeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 12:27:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1zw3s46DocuxP2+5ohL2yD/QcucjaYjhSXtr7yMydEW8HuLKr410t4zLBDQnni9n7c3KxqAibE8z5aFDq5lFOVkmCh+jEwjE70E+NUg9jzocPZQIhieiWZmOXQUNTvTE0UFKj74WrgseHhLzlHqrdnwLspbqO68Od7QlJ27h1Adg1AJyI7GsJqp1E4fwM7NzBApet1P+3sz2bhYfz+ny9CkDCff/1sLIqhOCHOvpv44dbqE5zZI8xyvYBor21Y2CbrjewqVwpT2TmRRRe4XOn6MN4Y4LTr+DG7ty1xPbvoN9fMPUw5D0TlT8Gnr6JRlKc+iij/JAkslR2w+YeE/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icRZ3eA7rJBmKTqaq9oOQVrQUziM6KcCQSnGTeFYvxE=;
 b=cp8nYiBiJkERm3otam3wU9fyYusqDlVq4uDuQWdmWlK5yuXOxLqUkW3IAsugC9w6G2BHxrws6adFTcMiCWphyAvmJ+njPkp6p5UafEJqpWESLSZlB3NgBfR06NP6RX6Z07G1/BKimTflmCd5Z52AwVBRXHc8xxtgYszjraXw90ylhNqoY6BPJEhDKjpOiyb8lpl7sC2JKxpo5+tcp00pYDJkM+xUtkPwZrBEOBEksznuAz7GqW8kJnW29O4uLvp/y9V5VbtnS8Urmgy3aI0QWglJr9XRxtkMjYBkk75nx9AR4ztfDbK/9bkVfp81tO+hd7BKzCFgQiDKqPoi2To7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SA0PR19MB4254.namprd19.prod.outlook.com (2603:10b6:806:88::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.15; Wed, 17 May
 2023 16:27:37 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::bfca:5d7e:a92b:53c2]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::bfca:5d7e:a92b:53c2%3]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:27:37 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: nvme host complete request tracing
Thread-Topic: nvme host complete request tracing
Thread-Index: AdmI3FpYoIdvP2ktTp+vpy0OIEBuFg==
Date: Wed, 17 May 2023 16:27:37 +0000
Message-ID:  <CO1PR19MB488584F51B17C06C58E8E84FEE7E9@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-05-17T16:27:34Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=407d6a27-4216-488c-804f-3a1166100263;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SA0PR19MB4254:EE_
x-ms-office365-filtering-correlation-id: cf0014aa-36e6-4686-258d-08db56f3a06a
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Z3ad9+JtmBeWHL0p8bOKBbzTjZ+RGCHHhw+tvrwudEWH2p9D1PO/kyXmYyaJHQTVQPG+UJ7mLm9tduNI2PTfjjpMIa3A5XAcAIot2PyUQ/s9KtWiLUIQu0ykLJDWn1C3y2rB7kvHSbO+u4Usi1dllzixm96VkJ6t1Blte0WuLw0f/SNRwmOPtVq+X2jEElBH0Q/j1ZWtbbMO0eaXnzLuPUdkKQGG3hDEi/oRiZu/CXEaD8z+gTw4dCmWVjk9elLmlSbn7YH7yKlU6ZQHMP2g26qSxCW4wjdNzBjQc9WznkEi0A3L4bAXcuR63NA8CIXh9RJ0NmziXGcmVEm9bH14wDPs3kxd45Z6VRz4IJ+Sf4mqOU2RqcU0tGORp5pc0GeACwf/ZYZ+c7g2zZGquqlL1gHuI3DYjNpIR83wWhY6CFnyuyCjv8oNV25ISJP2P8sJJ+M7bEpscf5Y8sUtRKjta4o0xZaPXN5SJ6qvBiMLpefuH7waCmySJ7Hbp3wMG/fiy3wg+E9Yk2rV2yFYMwGLSEX/69VfVHY1cbVW6cNxd0JoEI35Bb+i9DudBz8PB1QBIqxhPFqjZK/TqtobnMZvvQo0vgufuwmgYUYUvUaPz/iWaoFI/j/M2iIuLoK8QJUG
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199021)(66556008)(66446008)(64756008)(76116006)(66946007)(66476007)(478600001)(9686003)(107886003)(6916009)(4326008)(316002)(786003)(7696005)(41300700001)(71200400001)(5660300002)(26005)(186003)(8936002)(8676002)(33656002)(55016003)(6506007)(52536014)(83380400001)(2906002)(4744005)(38100700002)(38070700005)(82960400001)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bkt4bk0yZUQ4LyttSndzbFZ4dGo3eTNURE55VnJYWG0vOEk2T2VIRWk4T091?=
 =?utf-8?B?cDVldUVQZVFMUk9SRUxKd3BkdjZiRnFaQXdPSzd5Y0pIeTZsMUkwTmIzdFZy?=
 =?utf-8?B?aUNQTnN3cmI2dDZtM3lDaWFZSGxrVUxFSmNOblZwRkVHZ0VFdy9oZm0xUWV1?=
 =?utf-8?B?S0Z1RGUxMkJXN1pyQm95aE0zRzQyblFNcUh1QUZPd0xpY0VQZlcyaW0yWnFI?=
 =?utf-8?B?bzhIem9qM1V0WmRVMkEyMVdWQmtxQzl1TGhaMTUrbHZaVWw0c0FuV0pOb21s?=
 =?utf-8?B?RkZuZG55dm9xR1lYUnFhZGtseCszZnlRaUZ1b1FHV3VyMm1USk5iY2E3cnZ4?=
 =?utf-8?B?MitxbmY2ckZGeHVwUzdZZEhqMWk5VnB5SHpjc0Fod3dvcDNNWXRidC9aU3Q1?=
 =?utf-8?B?eWpRWGdmR2d0WlhnVkFwK09seThEU0dqVWFzUmd3T1pFczN5RGtreGxSblJx?=
 =?utf-8?B?eHhIRFdBRFNzbmJLZlNzRUp2MVU1Rm5UUnNWeDlLbTNSd05YSFVDbVc2V0pu?=
 =?utf-8?B?RHRuOGRaMnFPUWRJRzNhdnRrdWxSejZPbmlJdFVQQkg2N3FYejJWUXN6ckg4?=
 =?utf-8?B?TTFqVkxTSHZGYUQxVjJGQjRoQUtaT3ZiUkVGRU1BakNLck5ITUw0b2V5ZE9G?=
 =?utf-8?B?MGEzTzlocWZFT0JjZGFmcVNpdVcyZTdweHM3ZlNELzZ2MUZGbGlvK3hjaVFh?=
 =?utf-8?B?YmFqaDNTMGxhUStINHFtUEluenU0SG81YlZWREtZREw1OW45NEk0aUQwbWZt?=
 =?utf-8?B?MmhjdkhSZm9vUlRablBSRzF4azdpUm55V3ptdUt5ei9FdTRzMG4xQnlLa0Rt?=
 =?utf-8?B?cGV4K2VrOTJRS29LYTVjdXRrUXNwdTdLQkx5NzR1bTBPTWNHSXB2Rko3cUQ1?=
 =?utf-8?B?dDQxNEFZR3hGSzFKNE9tb3BKK1NwbHBjUXNZK2VOcittOVpYQTF1MFdDK3Ja?=
 =?utf-8?B?UDZ2b0QxQjUxd3hoajRlbG9DOVpQVGFUemNGbHduQ1RJSXVXYlFJckt0bzhI?=
 =?utf-8?B?ZTVIYVo5QUFOM3F2NWlrVGVjREpUS0Vmc0xkUEl5RThBekROaFRsWWxOVVNF?=
 =?utf-8?B?dmpZQTE1RytVdFE5d3hsNVN5cFR3RXZkUzQyS3BzODFtUm1ra3VZS2FmVDJ0?=
 =?utf-8?B?V2tNdHBoQkxZTHBUc01qR1RzZkxwLzdBemNLVXc4ZXAwNS9lWElJSXJYNGRK?=
 =?utf-8?B?ZjF1R1ROY1FHZkl5akxSWllpR2l1YjdRMFpvUnM5Y29CcmhEQ293OGJRS1BU?=
 =?utf-8?B?dmI2cy9xVGVYRE5qV2VmWVZuMUNoSmF6SnRTQ1l2aDRRdS9UTEdIaFpYTkI2?=
 =?utf-8?B?OGx0a2FmeVpUNnBJVGx5Z2Q0Qk9Gc2J2anQ4SkJoVXNtVERyeThIN2Z3bXZ3?=
 =?utf-8?B?eDFrL2RUQ2RmUHN4eW55UjU1citJenlTUWdrOExmUFdkblNCdHJwdU1wYk1C?=
 =?utf-8?B?TEczN3N5L09LQXlKTEdZdlJISHgzQ3hEc0UzTWVKVTdJQk1vKysyWTZLTDFO?=
 =?utf-8?B?VXk2dk1wRWFIdk9pVHJtUEkzQklzVmp5SnR3aGxPNGxjTkRKTGxsTkZjc1Bu?=
 =?utf-8?B?TXh0YWRONGhEM1RZSHNIaWIzd0FBdlJlb2hVS0VET3R1SStYUSszTEQ5bmNU?=
 =?utf-8?B?eTF6R2szMmpOUmU2TmRtcDl6YjMrVHpVa0x6SU96Nzc5TUg2TXV3ZndDcTRO?=
 =?utf-8?B?Snpmem92NXA0Ymg0NUxZREVJZG9PbDNPN3N6OHE3ek9OdU0yRWJVWHo0TG9U?=
 =?utf-8?B?R2oxR1pic3hzOHpDT1FrZTdSekdoUmEyZjZGNDhyU1l0TTdVSzBROTd4bFhq?=
 =?utf-8?B?WFV3TmVZN2NodEdIdjFoQldyRHhFN2RmQ1IyWVp6QXUvanVWWll4TEVXdS80?=
 =?utf-8?B?Rm56bjBRd3ZIaDBtQUx2L0hDZHRGbVpqZUNHWE1rSVIvQWFuUldwT0xleUVO?=
 =?utf-8?B?VThVNjJEandENDBGV1lDTUxDdVVkQTNvQW9lWnpmbXVySWZsUEV6NDgrK2VV?=
 =?utf-8?B?V0RRVzIvRXpyU1pkczBMcE9XeUoyOWR4OTlVN3dzaHI4QmpIZWhtbG45TzhL?=
 =?utf-8?B?TjFDcWNkcGE4MVBSUlUvK0NTc0dJT0NlNnBvMTVlZE4vTDBNYlM3NXcvelFJ?=
 =?utf-8?Q?JxYw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0014aa-36e6-4686-258d-08db56f3a06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 16:27:37.1035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hR+5s9U7uKJZ3sSCzg3nGTmBkQFc2GSnDjPjdO+mLtu4t+UMnP2hEuLuWjBN6h0frCXLScMvV/5nzh6pugZoYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=496 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170134
X-Proofpoint-ORIG-GUID: atkm2m4VsLzvrxXjkrqNOTJzDTfjFq9F
X-Proofpoint-GUID: atkm2m4VsLzvrxXjkrqNOTJzDTfjFq9F
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=557
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_092743_528977_029E33B3 
X-CRM114-Status: GOOD (  14.01  )
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

SGVsbG8sDQoNCm52bWUvaG9zdC9jb3JlLmMgdHJhY2VfbnZtZV9jb21wbGV0ZV9ycSgpIGlzIGJl
aW5nIGNhbGxlZCBpbW1lZGlhdGVseSB3aGVuIGVudGVyaW5nIG52bWVfY29tcGxldGVfcnEoKQ0K
QXMgSSB1bmRlcnN0YW5kIGl0LCB0aGUgaWRlYSBiZWhpbmQgdGhpcyB0cmFjZSBpcyB0byB0cmFj
ZSBldmVyeSBzaW5nbGUgbnZtZSByZXF1ZXN0IHRoYXQgaXMgYmVpbmcgY29tcGxldGVkLg0KYnV0
IHRoaXMgaXMgYWN0dWFsbHkgbm90IGFjY3VyYXRlIHNpbmNlIHRoZXJlIGFyZSBzZXZlcmFsIG9w
dGlvbnMgZm9yIGEgcmVxdWVzdCBhcyBwYXJ0IG9mIHRoaXMgZnVuY3Rpb246DQpDT01QTEVURSwg
UkVUUlksIEZBSUxPVkVSDQoNCkluIG9yZGVyIHRvIGJldHRlciB1bmRlcnN0YW5kIHRoZSBzdGF0
dXMgcGVyIG52bWUgcmVxdWVzdCBJIHRoaW5rIGl04oCZcyBiZXR0ZXIgdG8gaGF2ZSBhIHNlcGFy
YXRlIHRyYWNlIHBlciBlYWNoIGNhc2UsIHNvbWV0aGluZyBsaWtlOg0KdHJhY2VfbnZtZV9lbmRf
cnEocmVxKSwgdHJhY2VfbnZtZV9yZXRyeV9ycShyZXEpLCB0cmFjZV9udm1lX2ZhaWxvdmVyX3Jx
KHJlcSkgZXRjLg0KDQpXb3VsZCBsb3ZlIHRvIGhlYXIgeW91ciBpbnB1dHMuDQoNClRoYW5rcywN
CkFtaXQgRQ0KDQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0K

