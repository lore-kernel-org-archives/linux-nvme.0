Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80529C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:46:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B066101C
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B066101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6uIA36z459E5zjlhHGGg1MQCHBGttinpQJZMlRrXEV0=; b=p4IjD5SNOhifItxDm/UF9XgcF
	FmWWaZMU91Mmc7Ig+q1fxyzQE+gOOWPN4ac/87kk3IzgpH2S5BbLcSsKbL6d7lGmorA5vUuiocjNR
	7K3ge1zooiIAPhgV4KtEQdPWu0nhmNW7vkSKJJIYA1v5Tx33zanlONw0vlnvLthS1p7Wq3k/wdw3w
	GEdKMgMi1S8PWHXwh1IbIoOL2nFeRSqfr2tTNDG6TLUkUEcRuFLrkTjQks680cwH0402+qDuyCyu8
	/5ReIKg3iGcwxU3BJxAJx2SG+uHxFjC/8Zr1zCAtcCN5MMNG5XuigaMqxpsxkylUROiYKRx+xsHLR
	dClAVmrew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYrde-00CNqW-K4; Tue, 20 Apr 2021 14:46:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrdZ-00CNq4-0G
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 14:46:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=P/kcDxqpI+zI7toJTmvVPQj9UN5d7NBf+FcOEVJ+Bwo=; b=AUHQfisZRbnvpNneqFn7Mm7jXN
 OL4GzvN1hTzNHjI9ezjUaev6lIv24zb1ekA3wszjfl+U1bPOAkFwL+dehXKotCFFruO9KuH798X90
 rvM5xtVfwV2vqtEpS/c7qn2VXehHPIPaGnk8EqukO3LHqIaZnAw3F3vMsyoMr89lV0s/T+DOlnh12
 YDwHfQnG26cZ+v9WXdPsRARqHVhrEu5J1d1fZXXyZpO+Bv//GIRFaRoFT2e7/wnHEs+q8qfaSs3sw
 XOSrbkMSnfZuyW6Cyg2qXeWpkBKFjF5IYw/0ApBaje/mBJaD+bF9I3MKwiq1QLK3tur0y21Cqjwfr
 DKLM/AOg==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrdT-00CCl2-VL
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 14:45:59 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13KEh6PE019459; Tue, 20 Apr 2021 10:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=P/kcDxqpI+zI7toJTmvVPQj9UN5d7NBf+FcOEVJ+Bwo=;
 b=EkYNBVvCkmFoxcm25LMTTs2bz6OEezCM+wkhp6lD7DBqgDT9OCbb5B6iJ9Zcafuu26ur
 Dp6qEY993/tDQFGcux/pscujivpm3yoU4t6UMRXIIP8MoYZsGS0DbO8K0n8Mi+eXqhLB
 dA7Z1NQrYi2NWixtsp2K4y1qXWy8eGNmH6el+4zp4hr6AkT9nrL/XmtyHYFvTk9PD9T8
 7ks9EOAkcvzn7oauhbC+F67+Bv2Ev0Em43wjg8KpDd8uWzmQikGIzRIidB+qNX3GF6zj
 GA/cEsVBI1td+YlFkl5blSsF6n/R4dwHfQjulnzdOxHUkS0fdzUcqVLPqQ/sBE3AH23v 9A== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 381kdh2umf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Apr 2021 10:45:43 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13KEjhFn168542; Tue, 20 Apr 2021 10:45:43 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0b-00154901.pphosted.com with ESMTP id 381edf6sq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Apr 2021 10:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkc6HDXWqXXPR7PYzwvg5mHQb5fmeIkEVjvxvDCHX3gzQB/FZPACq3Ono62cuas7pOxKKoq42vikmibQeNlB26bBc6RyA1QIFowFVfQH97qusnG323t58P2JZBAcxLUrq6j46veO5CSITHMAB0kcr/KwODwi0mxTwdTaaMyklCz4qEwHG0jqYLWCBjyrNl1Oq4XuFiXFUkkTvFzpgiOXe9qcgoxmdSGEisTsmd/Tdr4pd4WkqoS1mmCruP96luP3zcMf0HTpCY1TjAUEQIqGMS76UIZHGLkFjhuZN8mvekwVxDIP8yxNujX4qNNrJHa+1UqolVDtSIUubzjJIhXglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/kcDxqpI+zI7toJTmvVPQj9UN5d7NBf+FcOEVJ+Bwo=;
 b=U7YIJElqQMnb2P8KeAGx2yFkUkK7jkIN6IrPXDM04qPT9GkAF8qfwV4ctZnAac6Fq5ePprOXOBb3cLoKAmH66b+GkeInUq5D9NcNmR4ieLQNL+a3GFwQmlP3r8H5ghAywuIuZ9ig6yT3IGYKHNWvMeDf3Dvm7lN6kXUbtW92+VwmT54/bhWdw9pzbQrI+mFLiSsj0nILpKkOa+ysgmQb6M3aH9Xy5kVoPGGj0gLy/fhuzG9DB59MHJ03UoxtZcAQCfPkOJ0c4VeTuMyDMOoew+jD2IH/JmPc2C2wvq9LntOlRUqFFYxxceGgDLk19NZizZwu9Ge0/cdQOt5WaY482w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB3540.namprd19.prod.outlook.com (2603:10b6:a03:1be::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 14:45:31 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 14:45:31 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] Add Host Transport Interface option (host-triface)
Thread-Topic: [PATCH 0/1] Add Host Transport Interface option (host-triface)
Thread-Index: AQHXMi3cXRd0eX/PLU64uVU3qFLVL6q2M0EAgAAaVryAAOb4AIAAHbnVgAYmxlg=
Date: Tue, 20 Apr 2021 14:45:31 +0000
Message-ID: <SJ0PR19MB4544AF364481B1206B42D30EF2489@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <BL0PR13MB429178ADAA0C3C8AA2AA05379C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <f693d139-2a3d-a780-9e15-9ab130cdab3f@gmail.com>
 <SJ0PR19MB4544D7B102BC3A957B57A780F24C9@SJ0PR19MB4544.namprd19.prod.outlook.com>,
 <c6fad890-475d-2f8d-dc0d-40c1c60e9007@suse.de>,
 <SJ0PR19MB4544395D3FC70AE1EC8E561FF24C9@SJ0PR19MB4544.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB4544395D3FC70AE1EC8E561FF24C9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-04-20T14:45:30.625Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Standard; 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a00c778-b051-4d0f-9644-08d9040af285
x-ms-traffictypediagnostic: BY5PR19MB3540:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB35401472DB7323560172F512F2489@BY5PR19MB3540.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6sSr1fvHiPYXwgi6I4QmbACkqZYBRizbNoqYz5fbBGwQliwu2U7bHCz11LnQOMZO37yosX4ZsGpJZSOHFJx7EhQjSxbf1IIXqMmm4IZRmIZsKrx+zEXWFKVZD3DreE/yFa5A3tyzHq4DBZNuSvrxHHXRDK74J6DPDFWKNKRqqzQ93Ok7V3h2ETi1w+TX96GGHkbZkwm0k69aMroBTt3y7rvVZ1IwqBa29+TFeOEQJfI6UNahfrAe1g0+7H2ZMM5URdCpZbQ66doigFNnCkBE8SKzSn+yB2pENrYmTMRd1lwPAk6CaiFvVBTkrQtSb2xSVJ8Unb+wb0yWeC6Yp1fbUwSEKfLHtstBLee/9OBVgcmm2gjDkUfjz0V0n/SzAmw0YGl5Ur0uJ3OGAGJ5y3M4Tgvumn13YiOIfHLE+YuayVaTNw4Wn2gL6UUHq2+ZpAdXVYkKm9GQLu5zQ/Q3f6/exrjr2K1bIT6BmBCjil920luYNbTD2bwd+joKJzew6/wORcvCLTAHUz1ScdUAeLkP4nXHSPkEuZNr69OrwvptYC/jJJjX4ZUjkKQFry2c3d9sAhdcIbNHYc5lLbnwfmIquDPXofVMRu5jgYA+cMYZNs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(54906003)(9686003)(55016002)(110136005)(33656002)(8676002)(86362001)(71200400001)(2906002)(52536014)(76116006)(64756008)(66476007)(26005)(5660300002)(478600001)(66574015)(38100700002)(91956017)(4326008)(66946007)(83380400001)(6506007)(7696005)(186003)(8936002)(316002)(53546011)(66556008)(786003)(66446008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?gZ7fxIWnoeMCAhwaTjpWRgN1vKaxyuhqKra2Y2nu5v1+bA0wR0ARS7aTvy?=
 =?iso-8859-1?Q?l4WU2bmvOTMSZ/Fbe8gjhr8wRsJn1hkBJYscebh+G2SSmvQ7OPmt4xPhmL?=
 =?iso-8859-1?Q?JXncGGQhNAapnIKKXU4GLDF0JMaag3pa+/hGxztF4iKfzlyVimMZi0wKpe?=
 =?iso-8859-1?Q?gV1w4opLide2H/+GqFJZJ1QUQFfoWjreZNgmTXm3JuOf8EBfna8uC4YKfO?=
 =?iso-8859-1?Q?aYrqz0lRKtwDUQ2kef5/m8fSiE3FpPpnLi/+hKLSsXFA73bB1IZRjMEuqV?=
 =?iso-8859-1?Q?b1YtIn1cxwybcpHN31dxmxbYyMzXG0PlngAOwgatSyV/lxtLJiZ9NgdhYj?=
 =?iso-8859-1?Q?oDQjnE5p7iZiUdhI++V9lgf+35iEnfyYE3Rw2i4f7rCY+/TO7nfOlraF45?=
 =?iso-8859-1?Q?MwHOIhWvVUulZuUVNRybeF09cCUk4kql+ENSXpZkCXdNlAcT4eF5Q7Qp+l?=
 =?iso-8859-1?Q?Yb/fYUT/RD70nG+T2CalSkwqsJMBqHFvSfUNRIMLjaPzaE85saCd0x0LvI?=
 =?iso-8859-1?Q?04MsTWw5sqy3gCKm0+Ji11wVJnNdl+GnYTeR2PeFwj3GjNYgWFKyCyuB2q?=
 =?iso-8859-1?Q?TrY+Bom2+s7DUU3Ed5sj2hJ//A+36D6WocZ7m64fSWFREIWr9a5isXf23N?=
 =?iso-8859-1?Q?sVc+QCHNxk83NgC7qBAOyqvbTs1T73e2fTRHnFVbpIe+A3vNchAD2Gxhkw?=
 =?iso-8859-1?Q?T0ktpcmCJkMCkWllLltPssoIgppMPOq5g+K9X1qwa3lgifilGEYP2BijuJ?=
 =?iso-8859-1?Q?ckhyvFUM07e/EyWAHJ3aZ0LDtCbSLzBmXGrIygUQuMS9TKiSWmYUf98dMQ?=
 =?iso-8859-1?Q?CxJzPYmigT6to7mmNadRICdkh6Ip/aOS+s1cVEL/vFIA350WmYZgcOtChH?=
 =?iso-8859-1?Q?SFxXuYJLN/z6E1fTJvYu+kCrsep2FZiqQyJymqSXum4rTSCXyijwwWalRv?=
 =?iso-8859-1?Q?qWn4XtHGoM8a/5En0JEPJ0hoTayzFqFK9yZRDDAOp7q4DKF3dDsSirc2xz?=
 =?iso-8859-1?Q?buADxLSF5fMHC2UDE/Rj/DcVw/zhGTfZBEvE7k+yuTkisDtg9UVsmwGXhK?=
 =?iso-8859-1?Q?+o2jd5z+Ycvbw81spiRa2rBXqKSpN6N8+6+V7SFwtMTWEZqBf0vt33OMfq?=
 =?iso-8859-1?Q?ZsBjTXNdWwK76iBRMaOdGSXJIRfL1arnSTbKV6CDfkJlgzt2Wx9ns6v6+e?=
 =?iso-8859-1?Q?4y8EsE1Q0RtBUVNL+7LOs2WF61Or90RkhT+N/ie8R7Br++YCYTddbxg6sF?=
 =?iso-8859-1?Q?ly3yboon00gupvLr/H5kbp6jZ5m9nD+z/c7FSiC14meBHR8UvtLOMBRu+s?=
 =?iso-8859-1?Q?l01OBz+bn4h6MOvNdYyAp3FTR0PJKMWH43XZMkPq4jXwZMaKu6OhYPC1H6?=
 =?iso-8859-1?Q?u+JvuNup+F?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a00c778-b051-4d0f-9644-08d9040af285
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 14:45:31.2311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYZ55npZWFcca5Zucv3CLP+am0Fkms+pQOl//2MmHyrcq63x6BQVOzkCHd6Zu99Pzbz3Tl56k+gEFFTHu7u6BsmgoZ7iTmK+H2QQiij+BRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3540
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-20_07:2021-04-20,
 2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200110
X-Proofpoint-GUID: --Wm7tcpeG3T_GvkrMyZnhHjHI5VLt6x
X-Proofpoint-ORIG-GUID: --Wm7tcpeG3T_GvkrMyZnhHjHI5VLt6x
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_074556_089899_F571F9B8 
X-CRM114-Status: GOOD (  30.10  )
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

Just checking if there were any update on this.

I understand that you'd prefer if we used the existing option --host-traddr=
 to specify the interface. However, this option only sets the source addres=
s on the socket. But that's ok because we do need an option to set the sour=
ce address without affecting which interface is used for the connection.

A separate option, --host-triface, specifically designed to configure the i=
nterface makes more sense. Here's why:
1) It's more intuitive to specify the "interface name" than the associated =
"IP address". Using an IP Address to specify an interface is confusing. One=
 needs to perform a reverse lookup to figure out which IP address is associ=
ated with an interface.
2) There is no "hard" association between IP addresses and interfaces. The =
IP address associated with an interface can simply be changed with the comm=
and "ip addr [add|delete|change]". Worse, the same IP address can be assign=
ed to more than one interface (e.g. ip addr add 20.20.20.20/24 dev enp2s0 &=
& ip addr add 20.20.20.20/24 dev enp2s1). That may be a silly thing to do, =
but it's allowed.

Regards,
Martin

________________________________________
From: Belanger, Martin <Martin_Belanger@Dell.com>
Sent: Friday, April 16, 2021 12:15
To: Hannes Reinecke; James Smart; Martin Belanger; linux-nvme@lists.infrade=
ad.org
Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me
Subject: Re: [PATCH 0/1] Add Host Transport Interface option (host-triface)

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
