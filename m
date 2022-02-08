Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3793C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 23:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TR03wA5ZSZFjSDUonvTgvqye/Mjp1OT8OpmheBCRqVE=; b=C6cY1DhIiVLtUEZO1UzPDQO/Wd
	l/GwEzFgmyY+kFiIOmvdg3aDLCY4QQb48xlNnhDlYtGq2h2n7zGtRTh8li4W2vxMIVrsxzDqwoKOR
	+aQ8JsxZ8tN9mlwJ1agnJkMsDyah9ofVwBus6sO9ASbI6GF7/BlRz80L9RKCXP1h7xbbKI6KDQtzn
	jkRRMZzAkudJH+LWaL5iU6NyEnJRWIt6twtFuVN/Vhm5NBXB5q1idZ2KMUsOe9zmyXl6K8u1mJw26
	r3pZWZla5VeXEjPZf/9IQxOWKNLtV4vWpepEPvJfRsZIKkjuHx3QAVPI/clZ94YVKh9fWOvV9B6LJ
	Tt6TdU0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHaJJ-00Fp2U-3h; Tue, 08 Feb 2022 23:54:13 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHaJG-00Fp1n-Fw
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 23:54:12 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218IMAgR011362;
 Tue, 8 Feb 2022 18:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=TR03wA5ZSZFjSDUonvTgvqye/Mjp1OT8OpmheBCRqVE=;
 b=svnyOL9gbaoZBfEq9ivjoB5sKcdOze/V8FjIq2ipWmrizJOaIcOMOzmjHKbwa9Vaj5on
 WKE24m2UeWSg+41/SLUtqWqeVolWcxsi7X5THj+sXMX8T49Lr7F90pB+xeyi7O2aXZhV
 OgzMfwKI1jXcJf0Iyx/iWK9kmNv/8EsvPMThe3+AP7cwiDz5rT6tPchnsAqGBdtq48hl
 fLeKjxk9B6+mcEpYGKI/6fgaFOLjmw1iS/jWMxU5bus4PgAp/Dv0YaXWDv6jq8vi+Qv8
 O/3+DsZkGwOQexbO3D/8JUVqhDwX4IpTjfTWEdkdP8UDIj1E3TxfRBqVEcX3wf+WxhVW vg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3e38n8eb7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Feb 2022 18:53:57 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 218NjZ3s008873; Tue, 8 Feb 2022 18:53:57 -0500
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
 by mx0a-00154901.pphosted.com with ESMTP id 3e3rxb25gc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Feb 2022 18:53:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2DIESavavExA9Xi4AkL8relQkH0460lgsSSTREXyICplCnr8fdl2/vsJwgdGFniwQUQmR/G+mV4FHyi968nXMREbHg9Jou4TpfaLYSaEAWfSbDmW7ZqdUVdmIFA74Hc0vNXUIJZvTRYqraXEpMptNZjiMogzlJ7mSN0/20gxT1qhnooQRdpQzk9TBB4rVn8wex9rZvfd+7iWWjJ4MjST1y91FH6VK0odlX0uteK15VacF5RcW5ztWSrNAsWyAS33CggtjtaJ2yQD4LgbsUyvbIG2OomZHR7iC7zvo/l/6yQ7ZavarYhV+zx3RTTPiUp4cGmCI4EwCymUc2gGZAstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR03wA5ZSZFjSDUonvTgvqye/Mjp1OT8OpmheBCRqVE=;
 b=evwehCBdqKxq3ntcqNcY8hH6nL3DMAIAICG37LBRX5L/81fKsnhx7zJ7384xXXdX5uFsyFh9C3xnjqvvWn4dSSwl3x/ENkFtLFW/hcKIB7WgUbfrQ23BkxiN1gucCgJM1SHTED0BI3y0/385VUKpt1/GCb4KuSpyNx2CJPWIvs7C7EpY5I00lOWZqY75yT5orCEN4zX7Mva9H5iB63ocAPE0DQpBPPS7eaFj1kNJPLcAatroDA++8R6bd6xU4CKD9h3fIwb77ynsk1aAV4Gro5HMzAicy4EmxYCM5/xuu5nTxkBqk9OtfyJpBO3B06+7k9Md/nsgX1qvZ6+A9zxGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by DM6PR19MB3065.namprd19.prod.outlook.com (2603:10b6:5:180::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 23:53:54 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::49f6:29e:be19:240]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::49f6:29e:be19:240%2]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 23:53:54 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Martin Belanger
 <nitram_67@hotmail.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>, "Rose, Charles"
 <Charles.Rose@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Thread-Topic: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Thread-Index: AQHYHSLjb14V1UsU8Ei+IHCa+Iyg3KyKSuUAgAAIFPA=
Date: Tue, 8 Feb 2022 23:53:54 +0000
Message-ID: <SJ0PR19MB4544A98CC3684F2421BC7220F22D9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
 <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <890f6817-7880-79cd-3651-2f91e4454e28@nvidia.com>
In-Reply-To: <890f6817-7880-79cd-3651-2f91e4454e28@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=true;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2022-02-08T23:50:31Z; 
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ActionId=bbe0b96b-c410-4078-b76f-49c2d5bbe782;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 765862b5-db54-4634-67fb-08d9eb5e4386
x-ms-traffictypediagnostic: DM6PR19MB3065:EE_
x-microsoft-antispam-prvs: <DM6PR19MB3065E8556E605F7A5534F04AF22D9@DM6PR19MB3065.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tykIW32IbFOcTZkTye21MrGEXrfCTmkvjr5QtMLtxMwdNlSv+8pb4aBjBHKK43XJB+xdM/oxRUxBNGXa1xe+YQ1ILrn6WB/P0F66FmgE2eeiiwZYz/7jX5uBUzdQcmtSmcbAWm6h+RWDPJ5Au/y76399WDtOxIA/GsjMhHaC4lhUp5Bpu8SvONRQ5T1sJFTvZ2Jhu5F2xKxYfr/PF375HjqeWO99HIXAZKjqrwO41qQO0tyjQ7a5vya4BokoyDSUO1ODGPsTz4IlbkBTqo7otlqO0rM0lDlIYlfWjW9K5akfqYVO8WNTxrXHrsyj5g6w9PoLuWrqg/Y6W+yqfPIwvHxCUZ+dolShHFeorVYS9El3AMMMQ72TLn71JT0Cnnwso58g7HPNDZqfYOE71ZcuVLZ8vywVyqG0wuaGZsWOQ9+pX+lw38Oa4pXQld/tVEDyC/eHApr+BcKZHvea9TXlXMj7NNJDH52H2hd+dxe3jmN061gWjW2sKl5oV+0FSkRFqbbajDgkrSgcxZSMAwZEnON5U3hrXNDeltK5U417TWqdcZTb63VqjTJZUeLbUbKXBwRFv/I2pV/Parhm+ass9H5OOCn9D93sczpYpN6QqjZNrP0NSg8h2l6e9XP21usD1asfsK2tNii+oXCjjVr5ucKpomax/FZADzfF5isaYDzPJCQ8V2LCc5wE3gaKEJxDbUdjB6yLhkAFLfTs4wg1Bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(76116006)(55016003)(66946007)(38070700005)(5660300002)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(8936002)(52536014)(71200400001)(786003)(54906003)(2906002)(316002)(508600001)(38100700002)(26005)(9686003)(7696005)(6506007)(122000001)(86362001)(82960400001)(110136005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0ZGS0prQXpoMjUrNEJEVXVIT0tHQTNrV2gvUFp6RHFMckl6NERwdnZKZzdH?=
 =?utf-8?B?RlAzdDhIK1VGM1dIeWZwcDg5cmpCU3ovcVVBOG1aZXhFVU13SUhjSFAzWHdr?=
 =?utf-8?B?eUxSckRwYUhmekkxc21oditBK0pEdnB6Y2hqcUtxWk9DcjU3bmFXS1N2S2RB?=
 =?utf-8?B?WVNwa3J2dzI4MjFxMnVOU0dHN0cwdllSc010OGVyU2dLQUoyWnUxd0tBdmpR?=
 =?utf-8?B?VW1MU1E5Y2N1RldyRHk4cGVBQnFrUWpiVXJxamhBcWVCQ0FHeUNxdnZFVU9E?=
 =?utf-8?B?elpadWV0Q3JVOVNJV1NRckljNHlqSXVKVEJ1SEZGLzRjV2tRV0w5MnBxWFBx?=
 =?utf-8?B?VnFuRVlTVnU0NFlhMitQU2MyYTB4WExpdWNtTUw2dzhxYnNLZVp6ZXlOM1JJ?=
 =?utf-8?B?azE5eFpzTE0ydS9SamVHZUxPanF2bHVlcFpOUFBiNmlUMDNjbWZ1TGoyUEV0?=
 =?utf-8?B?NldxSDJ0TkFPa05QMDJaTlp4dEp1L3Z5OEJGMWJMMmZSMDcxbzZKVXBPNVVk?=
 =?utf-8?B?d3BOY3FlREFOTTV6cDQ5MXRLdGpJTGo0NnVlNmFTT1h1RCtBaWpxb2JTeS9u?=
 =?utf-8?B?MVJwMTZ4TGUxRXRMVUdjY0xLQXJOais2QkpBTTFwajhVMlZhOVQ5UE82SGxO?=
 =?utf-8?B?ZTMvYXgydmdxSHZCMitPNE42V1hJREtkRXhDaGx5Mm1JN1p3dDZuTnJCZVhi?=
 =?utf-8?B?clhsRWRvNmtTMGZvOVZmSkJPZkpuazNSWVJ4NWRpVDl0b0s4TWRwaVJCeTdY?=
 =?utf-8?B?QngrVFMxNU9xVitpTGFQKzZ2WUl0RUlJQU0waVBwQzVIbUdLTU5VRWloeXRJ?=
 =?utf-8?B?VDlaRWttaFBtSnNXTTVxd2F1OExFTDJDOEdnWDQrdVI4cWdCWnpqaEQxaEJ5?=
 =?utf-8?B?eHFtZ3NHcms5UXVicUIxY2dXL2lLV3FKN3FBcXYySHNZZWI1OTB1Z3Ryb1BG?=
 =?utf-8?B?UE1IU0hZRXVHSVdzZ0gzVmtyVjZuUmg5OVlOL21leit4ZVlRamtXTXg0ZlBt?=
 =?utf-8?B?K0hTKzF0dGZBZTZhZFB4N2psekltMjJPM2ZaUEg0Tms4RDdsZmJORzZFK01m?=
 =?utf-8?B?OVFBaGhwTTU5dFFZQ2NPREV2cHZmZFd2YUt3NzY3c3FLR3g1eUd5b2d1eTBG?=
 =?utf-8?B?UXpWM05xc2ptRzBxVlp3WXpMM2pNR2RPQlE5SnU1Z0czM283dlJpeVFSOEw5?=
 =?utf-8?B?VHdzdG9NMWpNNE9tV0pUU2lVckpwQW5QWWo3Y2VmU09aVDZYUG4rM2IxY1c0?=
 =?utf-8?B?bDZwNVF6Tkp4SkRtaENTZGpsRXJ3dlpTZU9CR3FvSnIzOE1XaDI4azlQbTU5?=
 =?utf-8?B?VEVjMnF6b3EweWEzSFlrTHltbC9QamJPY0VjaXZ6RnJodDN4ZllaT2lsalZN?=
 =?utf-8?B?WjliL3ViQWFGbDZOTVBRMUxuK0tqcnBVYzIvTzYzMXpyZkxBb2hWWjBmZHZM?=
 =?utf-8?B?NGdqUUxzWGZDb2liYkxjSjUxeWowWUZLY3U1bDdYUTIzVU8rT00xVjlDN0tz?=
 =?utf-8?B?QWszdzdGbWQxUk01K1hhSE5EcHl5bHhsVDUxc1lrY1Fjc1d2TTUvQUNEa3k1?=
 =?utf-8?B?WVZzdjR6TkdSZHcvL3llUGdRWmpvZWhtMlZjTW83Sm1vMnorTEkwYlZFSksv?=
 =?utf-8?B?MXZQWGw1eW9WeUVYVEdwTXI4S3VTU1pnT004R0hPTmM0UGJCeVBiKzJPSm1r?=
 =?utf-8?B?Tk9FcTBmTlJJRFNiT0ZYSWNiYmFaNVlXVVAzWjNMSkt3akNSdVBaRmowd01r?=
 =?utf-8?B?dUloUkdjbDFNVWY4YlJGZElwNDJ0V0huSjhBSEtxckM0WUYvRDVuKzlEeHY0?=
 =?utf-8?B?dnB1b3VFMDBmOE5JOHY4bG9xcWFVb0lyeDlJVmRpZ05YR1F2QkE2YzdZOVZF?=
 =?utf-8?B?RnpIeno2WDVKaGI1Yi9NSTM2d1RrY2dIOGlZYXNTaE1HTGNieHk2ZFc0RTJU?=
 =?utf-8?B?cXFNc2VpWjVnVDRWcm91V1JneW9RNFJ0Zkh4Nk0xZ25pVTlvYUtiU0wxbzlT?=
 =?utf-8?B?a0R6QVMxT2RBak9PbDlrNXQ4VlcyaG0vbFdQRkVKb3RJSEtJeERZZzNPRnRq?=
 =?utf-8?B?WGU3ZytSUmxEL2x4OUJoSUhMVmo3cFFzRWFmNkF4dXluaURhYllFbHplN1di?=
 =?utf-8?B?dlFXckhIblUxeitOSENRTExtU1VNUDVvQm85d3JzY1dHQm5Nb3pOeVo1dVZV?=
 =?utf-8?B?d1JTek4xWnZKTnBTbTBRZnBRM0tVdVkyUUQ0eUt3UDg3UXhITStIMW5JNHY5?=
 =?utf-8?B?OTUvOGFGMEM3TFp5NzhVQXdjMy9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765862b5-db54-4634-67fb-08d9eb5e4386
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 23:53:54.1346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGWzSUQ/aWfzlCqRwMkEXY3SzssHt5WOuFQ7megSlewXDUZmd89oE4y5o4C8biMCtFEEFl2viRbPAtRukSn4aaYysG/YqxI1uS7eFmQ1Jyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3065
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-02-08_07:2022-02-07,
 2022-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=841
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2202080135
X-Proofpoint-ORIG-GUID: q5h6mJBIHaN3RlnFsp5lzshXqfeRYGAI
X-Proofpoint-GUID: q5h6mJBIHaN3RlnFsp5lzshXqfeRYGAI
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=925
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_155410_608547_9C0DC9C2 
X-CRM114-Status: GOOD (  20.43  )
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

PiA+ICtzdGF0aWMgc3NpemVfdCBjbnRybHR5cGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+
ID4gKwkJCSAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpIHsN
Cj4gPiArCXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdHlwZVtdID0gew0KPiANCj4gbml0Oi0g
c3RhdGljIGNvc3QgY2hhciAqY29uc3QgdHlwZVtdIC4uLg0KDQpIaSBDaGFpdGFueWEuIEknbSBh
ZnJhaWQgSSBkb27igJl0IGtub3cgd2hhdCB5b3UgbWVhbiBieSAibml0Ii4gDQpUaGUgc3ludGF4
ICJzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHR5cGVbXSA9IiB3YXMgc3VnZ2VzdGVkIA0KYnkg
dGhlIGNoZWNrcGF0Y2gucGwgc2NyaXB0Lg0KDQpSZWdhcmRzLA0KTWFydGluDQoNCj4gDQo+ID4g
KwkJW05WTUVfQ1RSTF9JT10gPSAiaW9cbiIsDQo+ID4gKwkJW05WTUVfQ1RSTF9ESVNDXSA9ICJk
aXNjb3ZlcnlcbiIsDQo+ID4gKwkJW05WTUVfQ1RSTF9BRE1JTl0gPSAiYWRtaW5cbiIsDQo+ID4g
Kwl9Ow0KPiA+ICsJc3RydWN0IG52bWVfY3RybCAqY3RybCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
Ow0KPiA+ICsNCj4gPiArCWlmIChjdHJsLT5jbnRybHR5cGUgPiBOVk1FX0NUUkxfQURNSU4gfHwg
IXR5cGVbY3RybC0+Y250cmx0eXBlXSkNCj4gPiArCQlyZXR1cm4gc3lzZnNfZW1pdChidWYsICJy
ZXNlcnZlZFxuIik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCB0eXBlW2N0
cmwtPmNudHJsdHlwZV0pOyB9IHN0YXRpYw0KPiA+ICtERVZJQ0VfQVRUUl9STyhjbnRybHR5cGUp
Ow0KPiA+ICsNCj4gPiArc3RhdGljIHNzaXplX3QgZGN0eXBlX3Nob3coc3RydWN0IGRldmljZSAq
ZGV2LA0KPiA+ICsJCQkgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVm
KSB7DQo+ID4gKwlzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHR5cGVbXSA9IHsNCj4gDQo+IG5p
dDotIHN0YXRpYyBjb3N0IGNoYXIgKmNvbnN0IHR5cGVwW10gLi4uDQo+IA0KPiA+ICsJCVtOVk1F
X0RDVFlQRV9OT1RfUkVQT1JURURdID0gIm5vbmVcbiIsDQo+ID4gKwkJW05WTUVfRENUWVBFX0RE
Q10gPSAiZGRjXG4iLA0KPiA+ICsJCVtOVk1FX0RDVFlQRV9DRENdID0gImNkY1xuIiwNCj4gPiAr
CX07DQo+ID4gKwlzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ID4gKw0KPiA+ICsJaWYgKGN0cmwtPmRjdHlwZSA+IE5WTUVfRENUWVBFX0NEQyB8fCAhdHlw
ZVtjdHJsLT5kY3R5cGVdKQ0KPiA+ICsJCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgInJlc2VydmVk
XG4iKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsIHR5cGVbY3RybC0+ZGN0
eXBlXSk7IH0gc3RhdGljDQo+ID4gK0RFVklDRV9BVFRSX1JPKGRjdHlwZSk7DQo+ID4gKw0KPiA+
ICAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKm52bWVfZGV2X2F0dHJzW10gPSB7DQo+ID4gICAJ
JmRldl9hdHRyX3Jlc2V0X2NvbnRyb2xsZXIuYXR0ciwNCj4gPiAgIAkmZGV2X2F0dHJfcmVzY2Fu
X2NvbnRyb2xsZXIuYXR0ciwNCj4gPiBAQCAtMzU0NCw2ICszNTgxLDggQEAgc3RhdGljIHN0cnVj
dCBhdHRyaWJ1dGUgKm52bWVfZGV2X2F0dHJzW10gPSB7DQo+ID4gICAJJmRldl9hdHRyX3JlY29u
bmVjdF9kZWxheS5hdHRyLA0KPiA+ICAgCSZkZXZfYXR0cl9mYXN0X2lvX2ZhaWxfdG1vLmF0dHIs
DQo+ID4gICAJJmRldl9hdHRyX2thdG8uYXR0ciwNCj4gPiArCSZkZXZfYXR0cl9jbnRybHR5cGUu
YXR0ciwNCj4gPiArCSZkZXZfYXR0cl9kY3R5cGUuYXR0ciwNCj4gPiAgIAlOVUxMDQo+ID4gICB9
Ow0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZl
cnMvbnZtZS9ob3N0L252bWUuaCBpbmRleA0KPiA+IGExNjJmNmM2ZGE2ZS4uZTMwNjI2YzAwNzkx
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiA+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiA+IEBAIC0zNDksNiArMzQ5LDkgQEAgc3RydWN0IG52
bWVfY3RybCB7DQo+ID4gICAJdW5zaWduZWQgbG9uZyBkaXNjYXJkX3BhZ2VfYnVzeTsNCj4gPg0K
PiA+ICAgCXN0cnVjdCBudm1lX2ZhdWx0X2luamVjdCBmYXVsdF9pbmplY3Q7DQo+ID4gKw0KPiA+
ICsJZW51bSBudm1lX2N0cmxfdHlwZSBjbnRybHR5cGU7DQo+ID4gKwllbnVtIG52bWVfZGN0eXBl
IGRjdHlwZTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgIGVudW0gbnZtZV9pb3BvbGljeSB7DQo+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbnZtZS5oIGIvaW5jbHVkZS9saW51eC9udm1lLmgg
aW5kZXgNCj4gPiA4NTVkZDliM2U4NGIuLjIxZTkyZTk3Y2E4OCAxMDA2NDQNCj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L252bWUuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbnZtZS5oDQo+ID4g
QEAgLTQzLDYgKzQzLDEyIEBAIGVudW0gbnZtZV9jdHJsX3R5cGUgew0KPiA+ICAgCU5WTUVfQ1RS
TF9BRE1JTgk9IDMsCQkvKiBBZG1pbmlzdHJhdGl2ZSBjb250cm9sbGVyDQo+ICovDQo+ID4gICB9
Ow0KPiA+DQo+ID4gK2VudW0gbnZtZV9kY3R5cGUgew0KPiA+ICsJTlZNRV9EQ1RZUEVfTk9UX1JF
UE9SVEVECT0gMCwNCj4gPiArCU5WTUVfRENUWVBFX0REQwkJCT0gMSwgLyogRGlyZWN0IERpc2Nv
dmVyeQ0KPiBDb250cm9sbGVyICovDQo+ID4gKwlOVk1FX0RDVFlQRV9DREMJCQk9IDIsIC8qIENl
bnRyYWwgRGlzY292ZXJ5DQo+IENvbnRyb2xsZXIgKi8NCj4gPiArfTsNCj4gPiArDQo+ID4gICAv
KiBBZGRyZXNzIEZhbWlseSBjb2RlcyBmb3IgRGlzY292ZXJ5IExvZyBQYWdlIGVudHJ5IEFEUkZB
TSBmaWVsZCAqLw0KPiA+ICAgZW51bSB7DQo+ID4gICAJTlZNRl9BRERSX0ZBTUlMWV9QQ0kJPSAw
LAkvKiBQQ0llICovDQo+ID4gQEAgLTMyMCw3ICszMjYsOSBAQCBzdHJ1Y3QgbnZtZV9pZF9jdHJs
IHsNCj4gPiAgIAlfX2xlMTYJCQlpY2RvZmY7DQo+ID4gICAJX191OAkJCWN0cmF0dHI7DQo+ID4g
ICAJX191OAkJCW1zZGJkOw0KPiA+IC0JX191OAkJCXJzdmQxODA0WzI0NF07DQo+ID4gKwlfX3U4
CQkJcnN2ZDE4MDRbMl07DQo+ID4gKwlfX3U4CQkJZGN0eXBlOw0KPiA+ICsJX191OAkJCXJzdmQx
ODA3WzI0MV07DQo+ID4gICAJc3RydWN0IG52bWVfaWRfcG93ZXJfc3RhdGUJcHNkWzMyXTsNCj4g
PiAgIAlfX3U4CQkJdnNbMTAyNF07DQo+ID4gICB9Ow0KPiA+DQoNCg==

