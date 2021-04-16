Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45694C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 16:16:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88992611AE
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 16:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88992611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=52vPDNjpcqfkNTyY+aRR7tpD1pu0sVfoxdgMYru/Q5s=; b=AAIQ4V2IWapjeN7V9nOx49lTT
	diE8O7OBc5gc5fSSYPGVdQfpZ2v42cubFTgHqXBE4C3XfLTjXg1rSPP4WfMYrAMMX7lFRit1mas+Y
	uAu9CHpUFX1kW47XkH1anOtlDUiPpo2/cQTReL9V5BTlDGAlQf/qURyAwp00qIeqYKsDllHHNCr3P
	kmph9BwG59YYDvHXBRYLWZZ2XFO/5l42Yr/NfRKIiNOpz/nyMi3L9zaCzl6q6zKVjH+OnCD7yY9MS
	Mmq9Zux2DnegjIpSMHRllsC2dLu/wP/kTo+OYg9Bbt8uXSGEMXxIBfW52BHxwhRQjYKCaEB+EykIF
	ohtkktvkA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXR8n-002kKb-CA; Fri, 16 Apr 2021 16:16:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXR8j-002kKV-M3
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 16:16:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=8W+BBx35hWJze5it/BRDZ99BVKjiyDILYB6KypaSwL0=; b=DiXUvkW1GS/69RIIjEAJAGmIgX
 pK6MWlTRT8d/Q8FMjfVtFbGCZ8ezJCZgrXluHwSEIy1rUjvShaFdlw5I34QOAI0AyA1ALVby05Waq
 RPXRMOaWiguDyr2EpPkPvBEOZOUkzMinO2M9xIfJmqsTWLeDHabbjQXtdP1tAxsNLR14vIbVaKum6
 UwzBCAr/tBrCiKYEwAEKKKKzL19H2g2NmCQMBAOnz6TOJDfyuNnO8O94GJynUunb4aSMA+CoVizyY
 IS3jJjTDZkvUj2jd3xlqKN0RS+PPdAM5n/MmFZjsIjOtyfSlFhQX5gncyyQuyxzPNRzwPqRuBVrgL
 5+6lH+hw==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXR8d-009Xwq-Ut
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 16:16:16 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13GG7fCC003301; Fri, 16 Apr 2021 12:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=8W+BBx35hWJze5it/BRDZ99BVKjiyDILYB6KypaSwL0=;
 b=AZ1iA6QNcIfmxqRKlRCHkoVk89Da+SGSwunWcUURi6OEb6f4DXYE8qQTeM4NjSZ/M8ws
 DAu2188bVEnmyaMUpvae18EXj1SnTjE62ZyTwy5UrbsVuf9kZI36aijhc+kElYOVXLzS
 uv0PKLhIB++SfXeiOPZsBW3zi3eGbce6T3N0GE6IudXRDW2OorvsiFQ7FMjHdpVcFQej
 oDa3Lwyea/jhdlahD7QoflcRjo/ZX6PIZmYp4JGwQ0sB7Hkv8KZ6PNPD9WGrHR+s0f26
 0oMbecYoAmVwPXYgFI3gSv9FmnGCieRQtiV7uulJXiUi43vGvoqPCXl7bE2mYfdiupav mg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 37xfrup7nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Apr 2021 12:15:58 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13GGAItm070781; Fri, 16 Apr 2021 12:15:57 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0b-00154901.pphosted.com with ESMTP id 37y4cxrj71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Apr 2021 12:15:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRsinblpxfpLxnkqwn5zW8Oxpu1zsocvg1cS5VM1qSC2+7RdA1lFpFoFH3WJG+wI1cNyxk5tOQivOhhm85nAybGADkehjGrH/j0dcyjYsDg4oJ1ueL7XvQyqgEQGKlDffc9w5S7qVjYCUoov0KMN5Ir2Shh2DUQbK65mbHy6m3dgoKtAjx9TA3jTZj0QrioFdpA98k8tM7D9s4hp5XXNwHyvaYXAHRDgzefk49+TMXCi8RhQuxHT3TU6ohCDdSioOSUusJz+MKR5/uVTAjMkS7iEzmFWuS79CzV0GPUWUBFfkabjAUas8EIO1nOsB3HttUaTEBUwaMTEv99C8jmhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W+BBx35hWJze5it/BRDZ99BVKjiyDILYB6KypaSwL0=;
 b=dK38AEHGp1j11L5iy2Vi2sM3gR09ZYfrRhpz7a0uDpIxsYwJCZhbp0y2Wojik7o3U5sfYyYRlKV7ye2YUv9VR6YyQes6oDSx7NK++LvpZ6J0vpepM5oPLOi4QNpbG/DBepKPZoEwbp5UMA3g1gHXttbKm41i/n/to53mGWGO5PSOP3vdvZrS3smcx9TBhzlv1aCTpzzig3nvqAPgCXFRu/3rvFcSWppdnhxmKxMdixxQSCajXe1F9zBiUCgtJGJuG9gsllXe1FwEf2wDPoLn3ijk8LfldW9TBAFQATHcEyK1l+bJS4Y7mVX37HPK0ALicFJ4vjN5R83hnMJbOUgYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY3PR19MB5124.namprd19.prod.outlook.com (2603:10b6:a03:356::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 16:15:56 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 16:15:56 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] Add Host Transport Interface option (host-triface)
Thread-Topic: [PATCH 0/1] Add Host Transport Interface option (host-triface)
Thread-Index: AQHXMi3cXRd0eX/PLU64uVU3qFLVL6q2M0EAgAAaVryAAOb4AIAAHbnV
Date: Fri, 16 Apr 2021 16:15:56 +0000
Message-ID: <SJ0PR19MB4544395D3FC70AE1EC8E561FF24C9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <BL0PR13MB429178ADAA0C3C8AA2AA05379C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <f693d139-2a3d-a780-9e15-9ab130cdab3f@gmail.com>
 <SJ0PR19MB4544D7B102BC3A957B57A780F24C9@SJ0PR19MB4544.namprd19.prod.outlook.com>,
 <c6fad890-475d-2f8d-dc0d-40c1c60e9007@suse.de>
In-Reply-To: <c6fad890-475d-2f8d-dc0d-40c1c60e9007@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-04-16T16:15:55.356Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged; 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d0ee2cd-6b22-4c0c-f038-08d900f2ea3b
x-ms-traffictypediagnostic: BY3PR19MB5124:
x-microsoft-antispam-prvs: <BY3PR19MB51240E024C0D20698BD469A4F24C9@BY3PR19MB5124.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fcP7KO+oCCyceYDuT7ZIpWWWtbQdc7tCeMBHIac4ElGuu6e68cbSY2SKOnteAyc4GIT8pLWvNgd8CePTe1dEtm4Q+Iw6WpjIa0NDVCvHo34xadn8oa1vOgZssDjDzw5oZ/pKfMhVbVgbn7PT6Vcejogmg9sOBzqBLUaMAWMC9LqCPobwHOmli9DKmHJ56zXjjPE/BknZUI3vCkuRdF2WDy+yFdP1KWgFJ2sLRsO0aj5T4eUoyFPML2py3c0kf06eqpwm3lNf7N8g+MIRv6gZfpoT6qAeuZcIbVXrxkGvOePFH4V7LYi7YpbkBEJTIiGrpXawogyXLRi1Yee7pOpkXGewlVptTkymL2ZfZjMG0jnOGaBNHOIJSRPqw8MHDdrIqAiSLg9KuXP0HLxh2HEiSBT1th79J11LhKmf6T7axWGwQ0die3ojsx7Nm7oS5suK1fQB+76qXWPXA9JtpHQ3dLnBCoByUh6kzR4Tmj4XfdPDhxWhb8U9REqEzxnAOP9l6o6VA4ZZYgIExLZJ5CMqUDGNV38hL51P3jT8+czYldIvZRP2vbz0ELy8dkhe0evx7jigrLn6bdmZuDzxgmnNdMQGcCAIYMtqMUSWFgbg+5Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(186003)(316002)(786003)(66574015)(83380400001)(33656002)(8676002)(4326008)(8936002)(66946007)(54906003)(110136005)(26005)(478600001)(5660300002)(122000001)(91956017)(55016002)(38100700002)(7696005)(66556008)(52536014)(6506007)(64756008)(53546011)(66446008)(9686003)(86362001)(2906002)(71200400001)(76116006)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?DeQp+xQDtom0McHB3+94zFmaZND7ieHwLVtPnMyOrIIPLZtARLUjoE1R8p?=
 =?iso-8859-1?Q?J37heOmHue3JEvrIEGecS/lKN/w0sVdnL2+PdLjDXPcfGNRct6B09K/M16?=
 =?iso-8859-1?Q?VCnoxX38T+DmtT6ZWTq8SSp2a6yipfF2LSbzGWpAf3O5cNrFiz4kd3bnYz?=
 =?iso-8859-1?Q?mxi5X1QSrapGUgMXL+AoO2KIidcubBc5oz8g/fb3mTvFsQLk3mAE62huxU?=
 =?iso-8859-1?Q?kp7kGAEvfSuG5tb3j0XRA7uvzJd/A4pQymzc92s5ttoZITrU8qvGjUIWYl?=
 =?iso-8859-1?Q?ERlonDJO5XAE8uERTbBn1s2vh7rRk+3Gpnw+vSjv2A9NU80zw7O9oAYPtk?=
 =?iso-8859-1?Q?s6m6F0Asicuh6WkqFigHQNiHIZYcTcADjkDbHy6WBvBKIX342knAVZYIv0?=
 =?iso-8859-1?Q?CYzkbP9tGj/yiH3Mzkvkti8P++H2uG9FzSxMVOtKPvgiLgyCbv/Ct4P9zc?=
 =?iso-8859-1?Q?FtZF02KTYOO+6qEr6bH9/ODcJfQcbRjUNSGKtCuJBoeAKzPsuy5morUbHG?=
 =?iso-8859-1?Q?gEXJKfAsu2/8Gg6xDTNjE2xwSf/JlB0CH/KY7tEuqtt3lXcB5158B1j6xO?=
 =?iso-8859-1?Q?bKZXR6y6Gmhqmci3O/aBL3VZCb7icot+jY72SpKXWnUKbZHO7CY9pmAwkl?=
 =?iso-8859-1?Q?YSk7ielimEZhq1H0YMilH5SaL8Svyyky4vXZWZEsK+yS/5F5ge18VQEVRu?=
 =?iso-8859-1?Q?d7OJEWgrp2gI1m0EVPGFSaigOna26rfTbFGcnOgH20+6qoWLO9HpFPfWD6?=
 =?iso-8859-1?Q?dRUFfKR09FiMzv/HRRnmK7/TYDH1aSLyv+DEQfIUTLU2pN2o6VPFZMfFpI?=
 =?iso-8859-1?Q?WGW60KF4JshnjvdlRD5MMENXQ2sqNWwTnCQo052IoHm0Uud6f3fKgXVKHV?=
 =?iso-8859-1?Q?k2x5eVcXa8CNq1JAfKXGhll1gVZkHPYdqoYm4yNafFIfhTsPnty0TOp8Mi?=
 =?iso-8859-1?Q?JHythFwB0URZ5KJZy9KobaesKJIPSxmR9L3r5LbOEavoPzZu/2ojedGQIl?=
 =?iso-8859-1?Q?IqSE2tnEg9l8G8hydYA67RCqnT/+yMLY0OaONIbzlPWuooQFRiPoOIn5jA?=
 =?iso-8859-1?Q?1gfm04VRnOFshO7KnbmdhXIsIEUik9/V+ZlWzWc3jNW1wglKkiWjlvRxg3?=
 =?iso-8859-1?Q?Jl5kze4lvO4sY+2OC5prqiAnV7nlVxvkGQUx4oKAKz6eTH+fSMhEauFVue?=
 =?iso-8859-1?Q?tLQ3SZ5VoXC3GRJ2Jat+h5CwsmF2oEK0G/4uQL1XwN1hj4yQMLfhIGXdxW?=
 =?iso-8859-1?Q?myEwV9+cI5i8eBw0+zlTGUXWQrL73Pq9pQ8KPtwEShXh6F2gVubu95/Ayq?=
 =?iso-8859-1?Q?hLfy0qWKY3aTkGt8oDJ9UxftAAYPATXihNHnVU1hGjNk7Bm6VPf2tOtcg8?=
 =?iso-8859-1?Q?BiNKEsooqF?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0ee2cd-6b22-4c0c-f038-08d900f2ea3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 16:15:56.0870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9U0zorTVxp06iV7Tc+uCiyikS+OU/LxMwfSWU6CE+f28oX2X+xCpDygMqw1wCAymS8lvW8iIbLPr5ZAZdt2tEtydBL2hoXj2BSixfUGBjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5124
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-16_08:2021-04-16,
 2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160116
X-Proofpoint-ORIG-GUID: aDREKsrrusTqxFH2-PCfKjf0gq4HKiw3
X-Proofpoint-GUID: aDREKsrrusTqxFH2-PCfKjf0gq4HKiw3
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_091612_871460_DD7735B7 
X-CRM114-Status: GOOD (  24.24  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Hannes,

For our use case, we need both features. We need to be able to specify the =
"interface" and we need to be able to specify the "source address". And we =
need both features to be controlled with separate "knobs".

Regards,
Martin

________________________________________
From: Hannes Reinecke <hare@suse.de>
Sent: Friday, April 16, 2021 10:26
To: Belanger, Martin; James Smart; Martin Belanger; linux-nvme@lists.infrad=
ead.org
Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me
Subject: Re: [PATCH 0/1] Add Host Transport Interface option (host-triface)


[EXTERNAL EMAIL]

On 4/16/21 2:41 AM, Belanger, Martin wrote:
> Re-sending in Plain Text mode.
>
> Hi James,
>
> With HOST_TRADDR, we use bind() to bind to an address just before invokin=
g connect(). I also used
> to think that this was the way to force packets to be routed onto the int=
erface matching the address
> used in the bind(). But that is not the case (I tested it). bind() does n=
ot control the routing
> of transmitted packets. The only thing that bind() does is to set the sou=
rce address on the socket
> so that when a remote process queries the peer address (getpeername), it =
will see that address as
> the source address.
>
> It's only a setsockopt() with SO_BINDTODEVICE that can force packets to g=
o out on a specific
> interface (I tested that as well).
>
Hmm. But arguably this was what 'host_traddr' was supposed to achieve.
If you compare commit 8f4e8dace3d1 ("nvme-rdma: add support for
host_traddr") it clearly states that the request should be _send_ via
the interface specified with host_traddr.
So in the light of this I'd rather modify the current handling of
host_traddr for tcp.

Unless this was intentionally coded this way. Sagi?

Cheers,

Hannes
--
Dr. Hannes Reinecke                     Kernel Storage Architect
hare@suse.de                                   +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 N=FCrnberg
GF: F. Imend=F6rffer, HRB 36809 (AG N=FCrnberg)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
