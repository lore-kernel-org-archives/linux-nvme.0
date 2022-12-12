Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1598C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gzGQCTztKjk0/QkurWT816Q9ybOUCHxC09rE8faq+KM=; b=QX2i1d58C7VWpssdVZduBLIwRI
	psykxluVEoQ8QzxAotdacxULpUpRnz0yesz3wfIWTp2Nm15hAoMvwV+SY1F6fx/THzkw1CakRFja4
	jvB3s3Pl/eAo0AOjFBgIf0sHmNFoo5wJ6eFnJQkH4FYhhItiHttlK/BAmoKwUr/+MlEAKBjzPHLGF
	I5YsayGcTlSwHljP8lYpstm7tlTnt0ScbLUYAdXhPbKWNyjNNB2NTGu9Fp6UIQaexSUHxrPdxFql8
	douKyoxBBxOmQXyjIgoELAcPKYe0++GzvtZIG6fewU6v+gwaeiuPbaFTsn8mBLHd27rY5NFOlp2cU
	w74CX0pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4igx-00GH2T-PS; Mon, 12 Dec 2022 13:17:59 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4igr-00GGsI-8Y
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 13:17:57 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCAQ65l015696;
	Mon, 12 Dec 2022 08:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=gzGQCTztKjk0/QkurWT816Q9ybOUCHxC09rE8faq+KM=;
 b=crFWU5h+MNi+B2RUstgUtMzaxNNNFIg/CkTlAa9dxMY5W9FYAle5aKlDZmI0e/Q8LYdM
 lmXgROu8JbmB0SSFmh/PmFCSxxL93xm8lkBCa4TO5ayW9aWQVgX5+Xl1hk2FERxI+tiq
 ygv47unYqlvklOqefIl5XGr4/Kv9m0ebdAMCdXHt9GxpurYezVbFlDvDMYb1swvoJTIs
 BPZvK4jeHBIfLtFaLnhzCt/pJD9xI8WcDNUiRz91eRbt9rqvr2vNZlWgZQEnX3m7sdoq
 2sJxIJW5dp0tla5t6bSu22H+x6zUWFBSNd5eBKxNMhLtxrfkJ+apAQQ0euk2anXpNN2l dA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3mcp2999q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Dec 2022 08:17:38 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCDGSq8007615;
	Mon, 12 Dec 2022 08:17:38 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3md8gt1k5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Dec 2022 08:17:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8XxKmXZkdXjH9eT9m28Ki1XRndGkeR84z5H++RYFZLPF8WS6+dLqhzE8F4CVbVzp47VfIVU+0mx0wy/GCM3HjDEsZDvNayIgAOvUPyM7RBhIVmO7URv4paHn0k1ycBFwwxi2xnSaFWgW+0cjgi01n/iAd5tDq+XAHCuVQfQvFPcN6tHf6ekIij5tJg0xdbOW18XqDizZ3Od0i0kOqBZ+svcb0r89xIzvUFU7ExBQyIqLpNxVZtDwUCmvtva3GMiJ5x5o+AncdQrezDrYwiq3WV/YwmApUnJuC5cK5VQZh+suwoFDetR2YN9hlHrOV3HVGvHMsrHai/Kf1jo0l7U0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzGQCTztKjk0/QkurWT816Q9ybOUCHxC09rE8faq+KM=;
 b=idRbLafnm3KqAdUXlrVj3V39xX1kiZXkT8AuWnxHPgZ4xd+73ueT86NZwORIw20Dd534R+r5/ENb+uWRdvr8flBLzl6AQUHnmSJWO+7uD9JnHjv9JBZhLYx4F9scq2fFZmQ6NODnBWZ8/LUCKhmw7Us4muoR6EWm+Rx2dFNkvWbXX5VssyxFXtRkQczoiZLrhOxYZphX0Pl9A3IRIFCo4l3wOLM7ovsPSq6tehLZOmYIbL+urypgYg3w4d0BP4ciq9nEPUvR+knG8rBqG9pyDgTAzvRxtefuCys4Bk+IXHHE3zpfEpnxcbMlumvWabrDBvxflfX65GWVCwWV+JIEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by DS7PR19MB5758.namprd19.prod.outlook.com (2603:10b6:8:75::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 12 Dec
 2022 13:17:34 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:17:34 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Index: AQHZCircZassPCXK70uAR/3KOBzuUq5qB8OAgAAJuwCAADJNUA==
Date: Mon, 12 Dec 2022 13:17:34 +0000
Message-ID:  <CO1PR19MB4885574C5C320E92CCAB088FEEE29@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
 <1670838149-3147431-1-git-send-email-amit.engel@dell.com>
 <62541ab8-d173-d658-9e1a-28c7ccf5104b@grimberg.me>
In-Reply-To: <62541ab8-d173-d658-9e1a-28c7ccf5104b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-12-12T13:17:22Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=25654b10-6ef5-46f2-8ed3-ce0f76fda7b3;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|DS7PR19MB5758:EE_
x-ms-office365-filtering-correlation-id: 93f160dd-e1ba-4098-4c79-08dadc433ba7
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  9fqJdfEyME6Q+q0jkamMYvdbcrwg0K1k7Nr903pKALeVXrm++M9XxtZefOR2O86jSvdbHSfeEW3AYunw/Uk7IUr5N2WWtJOActmX555C4XaO24Ncvauub7nteZJGsZNU4voRV8dRQNcirlA31ew3BaQOgYymLPkl7at47Sfp88hPJNis3avlGBzUdOXof98xFDQZB2j4Z71ViRRcfcy5cg8tAG7T3UQSitAyttyo49X11WweGGfkbvkK2WLTqMkISBo86ioJ93If7nLyhALLNnEG2qrftZBslBdEUjOOevvDwJQ82bj+m61ATajyPO7m/Vr5cPU34pAaUjzbonxQctWFvE87oMmwoZmtbP5VaRCfUzb1corpiCW1vKcoYbBU/Hx8YI5c8dRz4pu89CbCNygUImbK0gsrs7jSXup47ur0cRL1OhQkw5cHM2MKa+Y6LcBMGCeUOnP40Icl67MuaKSFFPweO11yv0mN1I5l3chJPxPuEVBZKjJPHL34OA0uRpfs0MuNgtG+GbfgScTrfhvtm8XUEIK9mTyMpgN+Y/Qrvlr7RrZ6Azj9yUF0c39gmfDWYeNyJswiS5ZFXWcU5TNsfWABqQXARLz6Fb8Klu/bcNvHZaIOgba2S7k5Gyi9FvlnYMp2Pu5TX9DefKpVTFMggyGwddIQJeOrHSfc1pbVnzEPnfSuovegZaCfq0UOh4F17KK2vx1ZdIKWVTjoKg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199015)(2906002)(38100700002)(6506007)(4744005)(66476007)(66446008)(82960400001)(66556008)(66946007)(41300700001)(33656002)(5660300002)(64756008)(76116006)(52536014)(8936002)(86362001)(122000001)(478600001)(83380400001)(71200400001)(38070700005)(55016003)(786003)(8676002)(9686003)(7696005)(110136005)(26005)(186003)(316002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Zk1lKzJaM081ME5oQmtnb1NNTUVPZ094b3lBZWd3ZUdsUElmMWo4dWxyMVQz?=
 =?utf-8?B?SlBaa0QxVk85ZW1lSmdTY3l6TmpkckxsajBUa3JQdjZOM1ZXeUtxVjhRZkl4?=
 =?utf-8?B?RDRLeCtOQmc4YnZBUFY1K0M2QXl2LzJjUWhRZ0NNYWN2OE9KdXlzT1gwV1lJ?=
 =?utf-8?B?L1NtQVIyMWhoTGo4VFZMOFR6ZVBXb2tVVnA3Uk9HL2dkVzVvaXZlclRzY3lK?=
 =?utf-8?B?b20yc1E3SWdMTnJ1OHc0OWJaZTBZNEVTcHFLc3hMYVBTaVk3NDI2NXZtaHFZ?=
 =?utf-8?B?L1FvMmk2K2JCdmVZU2puTXd4cVhFMWdyVGVtQW12SWptWlhFSUthWnFKNk5E?=
 =?utf-8?B?SzVHcDVlWHJPTURIMW5FTWpWRVhoSTAzZkJUN2o1U09oanhpT0ZyaWxiQXU3?=
 =?utf-8?B?UFJ1eldXeVc0SkhtNmJvamUvMGpXclpENXNRaWp4SU44U1daMUx4clIxM3dG?=
 =?utf-8?B?RUJhS1pBS0Y4eTdkYmZRRFhyKytxdVNVdUk3MGljSDd6NjBSbTA2VFphSS9z?=
 =?utf-8?B?dC9UOXlTZ3F5ZkNobUduUGVoZGJWWWF1YzVON013WHd2TVdiWXVGRjFrTzQw?=
 =?utf-8?B?Y3dmM3FIWFVNR2J2bG9TTHUwVC9ienpTeDM3YkdaZGxUeXh2RkJBZ1d3cnF5?=
 =?utf-8?B?WTl2SUZkMEtxSWZWbWNmL05RT1V0Z3QrTUZJcHl6WE5qdmFJbksrSmltUzdM?=
 =?utf-8?B?UFJ4WjM3bms0OVlDUGNXcDY0eEVFbzhiZTlqMVNHOEE2VEc3ZVUvSUY4SlVj?=
 =?utf-8?B?ZFhwSXBsbUpVLy9YU2tybzBWSFowMVUxbXpnZW9CRTIvUUM1NE1lWjVlQW5V?=
 =?utf-8?B?RU4zSDExTGsxZlhqbTU0ODYzWDN5bDZZVUxwaEZIMU9oSURoZVY1ZE5EZWow?=
 =?utf-8?B?bzdiZW9LWWNCSERDamlHWEpJeU9Id1dHMngxUDlzalMyNTQxeUxXaU9nbXZM?=
 =?utf-8?B?ZGNwQjRCNVpsNXBhUTR0OTY1VlFvQkNDUWNPUjkyWjRhSHZJblZxeU5Gd0c1?=
 =?utf-8?B?Tk1nNnhqbCswSVl4UFUrdzBZMURMMndLOUVIQk81WGJqVENwZDBlYlZoVXRm?=
 =?utf-8?B?Z1lUQUFnTmd0dmtBbWg0UHhYSFJyU0R1R3MxYk1vKzZna2ZOSkZWcFJrT3No?=
 =?utf-8?B?WFpIWGQzTCtmTExTOTV3Qm9SeGJqYnBjdGJGaC94Z3dZREZJYW01eEI2VkRM?=
 =?utf-8?B?S0hnWFVjdjBWbElPVWgwbXdIZ291NmlnRzJ2djhQd2tqYm5RRnZzUDMwb0RF?=
 =?utf-8?B?c1oyTUhSZ21DNngveVBBa2phRVhRYlJXODNlL3FjRkVqRHRoQjRRNGZQMmJV?=
 =?utf-8?B?a3J6WjBWenNQUDllMTc5d2VVdm5DTHl5ZUVkY1NFZ2JrNGJMM2pacWwrNHg5?=
 =?utf-8?B?M0ZXUVNKVkw0WkQwYUJJaExseSt2L1lzdnM0aElrS2pjOVkwVys4alBySUI3?=
 =?utf-8?B?MG16dFY2cmVDYUp4RDVldWRTTVhGNldRMTRHWEpGR01Od2lzcmYzc1VJbjNs?=
 =?utf-8?B?ejMrSjlDZGxCOVAwM2M1citSdittZWc5TVN0K3RLOVJQNlpTWDFwcGJCczBN?=
 =?utf-8?B?UlAzUG1iQlNuM2hGUmNtNjUrL1pMS1ZZTjRrL09Yc09HeUZzcHVHSzNNdHlh?=
 =?utf-8?B?elBVZjNRZXRmaVJqay9ZcTBHWVgzTzhUV1dvclFodStBWFdsNEQyTWI1bEtS?=
 =?utf-8?B?YVJqUGNTV1VMRENOVzl3WXJDUm5XVXA3VTZIeHJLYTRhQmZDV25VVW9GS1BZ?=
 =?utf-8?B?YkdteHUycE1naWFydk9XMkR3ZkVZR0RnMXdFRU4vTkIrZjhKajdadUI1cUs5?=
 =?utf-8?B?V0l2dHUxR1ErWkN6OEtCbi93eEE2ZkN0RWU5QXB4bVlLOE53a0NUb0x3MW9a?=
 =?utf-8?B?Q3NhR2NJaFpQY0tqeEJZUzFCV3hSZWRlYjIwdG1tajBWMTlkUkx2NG1na0Zy?=
 =?utf-8?B?b1hHREF3d1lPMXM4cEJYS3FLbFlxb0hpUEs2SFRzVThRbkx2SjR0bmR0akZW?=
 =?utf-8?B?bmRBT2FBOG0zczVyTWZBMkcxdU9ZSnlhbC9scFdrM2NEODViZ3E1R05DeFU3?=
 =?utf-8?B?eWUwNmJpNGdBaW1oNkR3Nm5zTUhRK0dVM01YemExdEwyczZpQW0wOXV6OVA2?=
 =?utf-8?Q?qXg0GdbkMNrX+FE5k36Sjkyv+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f160dd-e1ba-4098-4c79-08dadc433ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 13:17:34.7617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ui2kuRAV2VNFLNRhjNaY+0Qj5h8xt64swBh1Y0MmIVmGLZkG7W43c03MEFmX8vaWcTIsFG2aOHubmrkBzruEYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=924 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120123
X-Proofpoint-GUID: 1p0rIdUWLv6jwQ0HnVlgGjn1ZXI5PPoF
X-Proofpoint-ORIG-GUID: 1p0rIdUWLv6jwQ0HnVlgGjn1ZXI5PPoF
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_051753_361560_62FD9EDC 
X-CRM114-Status: GOOD (  13.98  )
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

T2ssIG5wDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTYWdpIEdyaW1iZXJn
IDxzYWdpQGdyaW1iZXJnLm1lPiANClNlbnQ6IE1vbmRheSwgMTIgRGVjZW1iZXIgMjAyMiAxMjox
Nw0KVG86IEVuZ2VsLCBBbWl0IDxBbWl0LkVuZ2VsQERlbGwuY29tPjsgbGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBudm1lLXRjcDogYWRkIGFkZGl0
aW9uYWwgaW5mbyBmb3IgbnZtZV90Y3BfdGltZW91dCBsb2cNCg0KDQpbRVhURVJOQUwgRU1BSUxd
IA0KDQoNCj4gRnJvbTogQW1pdCBFbmdlbCA8QW1pdC5FbmdlbEBkZWxsLmNvbT4NCj4gDQo+IFRo
aXMgcHJvdmlkZXMgYWRkaXRpb25hbCBkZXRhaWxzIGFib3V0IHRoZSBycS9jbWQgdGhhdCBpcyB0
aW1lZCBvdXQNCg0KSSB0aGluayB0aGF0IHlvdSBzaG91bGQgc2VwYXJhdGUgdGhlIHBhdGNoZXMg
dG8gYWRkIHRoZSBmYWJyaWNzIG9wY29kZSBzdHJpbmcgYW5kIHRoZW4gYW5vdGhlciBwYXRjaCB0
byBoYXZlIG52bWUtdGNwIGNhbGwgaXQuDQoNCkFsc28sIHBsZWFzZSBtYWtlIHN1cmUgdGhhdCB0
aGlzIGlzIGZpbmUgd2l0aC93aXRob3V0IENPTkZJR19OVk1FX1ZFUkJPU0VfRVJST1JTIGFuZCBw
cm92aWRlIGV4YW1wbGUgbG9nIG1lc3NhZ2UgZm9yIGVhY2ggdmFyaWFudCBpbiB0aGUgY29tbWl0
LW1zZy4NCg==

