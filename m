Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41450C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 10:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FgBtZwVtmTQHpEP4bMyQsm8Ufg0dfYXdYUmSEvDR7/k=; b=TEsXT8cIXmSVYf0ZOjqrToMP5G
	kkij2kyI9RAQoulpJ16ROcb8WtxIoi7bhAHHrB0lWp7DQpdEih7jVPeF/4BNAEly/yNUd8NQ5wnVi
	/zLiBHb7sUsGbqBSWTk5vQVCv+BSaEHzDjlyl1nDCqdg/C43KHeooUtirT0CJZ6rVnJj5t8RIvfBt
	N/etaZWsnLoHCNoHLCvVcnlY1j55NGtJTzIEWEkI1UYQltLuOy8UmjQXlgmaAsK1zH5kgi2KHIM5p
	CVd0UHKNflZ+rNiy3FeBXQPnSi/WECJqBKfzEG84YTHQHgYdXhRwA8WN8pMdW4TsXSrxxyHh6vf8i
	VHxrIpWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqukv-00DD1a-5H; Tue, 17 May 2022 10:48:45 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqukY-00DCg8-Of
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 10:48:24 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H5kZ6T027415;
 Tue, 17 May 2022 06:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=FgBtZwVtmTQHpEP4bMyQsm8Ufg0dfYXdYUmSEvDR7/k=;
 b=FWe+6wz4GpJdBv7l4Ry6ybdTjWeysDxF8E82yZkvX95AnCmNArWuhdC33PDX5Vf+mDUS
 BB1kAKEXic50MBjrjvtzMolbULaXojIw9vxqVrn+I572MNkwDaQRn3m+NsuKaxWjDgx6
 Espk9tpGW0i2hCziQTXd9is85MId63uGd+a/dr8NTrWSsmWqAaesfl5ZrYtMtsxgSkTZ
 mZjcfS8zl/M7Z7mB8QxDHDJ4U0bPyRLUXFYjqPxW4zYycnUsyu7JkJ4ChQS3Vu7RU1Wq
 QzojqF7y6k0ZMEYfFHFGpSi0KSwg40TpbDnq+fRyyhPCx5fmSHVzvuJW/mKWFmgGweNh DA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3g27na2eq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 May 2022 06:48:17 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H9gipE038266;
 Tue, 17 May 2022 06:48:16 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3g49akgux5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 06:48:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFCPrPZ65ThSR2GqTAiNu3Adw17AfWc6BXxFrllk4E8uTNs7jk9wMZBgiQRH/YhM+1RfdRZjz2amU/3D47/0USP9ErSKcDKSgl398KFRGtU/fnon18vZhQXc1HDcYZ3aqgOS3dL+uPquOLNPqnZvrfrBE11HBa4JWpFv0Ypoy53+XT9VYAYMrL2sGC7eQGyLPqnR1yPZBbSrlebIjME6gDruzM2Ju6VeqAhW2SJUFrdIOgMcOA21RPb/9zeXI9YGoSe+uic7gQBNN2F8SoGVKYlkS4uTwNoYeitlmSzr20DpfoKqVqWNjzmI//1YA7JYUS9D7oEP7zzsQ6dFmToY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgBtZwVtmTQHpEP4bMyQsm8Ufg0dfYXdYUmSEvDR7/k=;
 b=a2XNmnqQv4lFrY1PlPuYzao+MGf4YkvIQrKNUmiWwjzm3E1r4TOq5iyaqHIVwtflyHoAYTeg06LBjTn4Jmcpk2Bnmo0O9h+MSYZuIMNP1DMPf7jZAz8eqDEQXJNcEqVBRM7oom+yRFCdfSoFPw642nGhndMNEavCflvKmNGr1RkU0K6j4rzE8ZeJtWEk0lD3Hca4niaJgldxLdf4C5uqwGS5mj0s8W12GLEo8n9aIsTr+OOjzwZupR4uza65xLff3atjtt39mlyuZ5EYGfKoY/QCxoZsiIWFB0O3ETC0dv/A8gchqaFe+21AMjwe1EywClAzzgXenh6BSoWCXKjIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MWHPR19MB1454.namprd19.prod.outlook.com (2603:10b6:300:ce::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 10:48:14 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::ad61:62aa:3372:61cf]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::ad61:62aa:3372:61cf%7]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 10:48:14 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Grupi, Elad" <Elad.Grupi@dell.com>, "Engel, Amit" <Amit.Engel@Dell.com>
Subject: kernel panic due to a nvmet race
Thread-Topic: kernel panic due to a nvmet race
Thread-Index: Adhp21iJ9u9jG5zsSGGi8oBfAS1jxQ==
Date: Tue, 17 May 2022 10:48:14 +0000
Message-ID: <CO1PR19MB4885A916016D38EF6CFD07B6EECE9@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-05-17T10:45:45Z; 
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=4f992621-8c5d-49f2-87bb-14fde4ea54cd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2b867a2-2e0a-4adc-04ad-08da37f2be8e
x-ms-traffictypediagnostic: MWHPR19MB1454:EE_
x-microsoft-antispam-prvs: <MWHPR19MB145496234D81ADFD48C2C40CEECE9@MWHPR19MB1454.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTQPQWQAGrD/WDsa5Q7rSjaTVRhdhh8jpJNZ7AvyYiPkF5/wM+etyaj/pU9L1KFl5/JO2Wr0JaDHCur9xRdUyb1nbr2cZ+TubhR+bKS2a73AZVMVcIgEe+6v+peK0UrUNPoIJnBwt1uzA/bSSYQqy513DZntmv49GWA8zoiw+5MrS5jqaSZsSGXSdiBYzJopx/HiXPqOv4CERbQ8t6dk7T/lSSvfUvptKRKHmodLHliR8nr106DWGeTEP8jmmBfyxIo8TwHls9bvkJ7shET4PIieN4KaECaWzM8soLz/3si8/4wZPDOk2PRN9gD8xhwV3o1aRlZRsOrdBHD6gZ7UvL5mbD6M0vptMMAeC+95wfxDcUJ9POfVprhroRSAJxG7hDkP4v7J25CsMiVSMu0Urk28RaTvJbWX46scZL15SDxOGHS2qajxLj8iVPZHeyrNCA4d3knPpih++4Gp2g/1xTQSyC5DcaHk5DLmZ8V1TSBwoUmbrAeae79+oNqhNTAkWf1dmxyinSrXkgu+YxLV+OS5TL9KOJWVLq33hlV7O03nUji+YpLLB6KyIYa1IIm9xpcXPR+PDPZXFp4jj6SlFVFOONXQSayUSNGPPywJidzY0q9S/6UZ+xfSNa4wDX1jDbFm5WijteKXfOq186gSpkqrL1CE0AcUm53IR4S7n0zTGoTH3sAkgsrZow3z6inPxGX+n2/xusm8RQ3vGlTnAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(508600001)(71200400001)(82960400001)(54906003)(786003)(5660300002)(38100700002)(38070700005)(33656002)(110136005)(316002)(64756008)(66446008)(4326008)(66946007)(8676002)(66556008)(52536014)(8936002)(83380400001)(26005)(107886003)(6506007)(186003)(9686003)(122000001)(86362001)(7696005)(55016003)(66476007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vNzteWGSdFYOlMVSbR92oFbZyZGJb4Mliitk9IceobCRpJ3rpyAinFzoa+TN?=
 =?us-ascii?Q?5k4UTAt2s+NYFf1PCTRCuUAZdAFdw1doJ8srr/xyu0aU+cD95486w3+MAbJe?=
 =?us-ascii?Q?/Ynqrhs/uqy2x4Ls7VZbJpilDR0eTf99n8vHGKvGZ6naCkjmCGxqGQ7rNCK2?=
 =?us-ascii?Q?HlZ5pja4sk2ymGa73YmPsOzXqTIhUWzM4Fuo8CzsoNXy/7XY/Lirx1Qd3mRp?=
 =?us-ascii?Q?Uyr16OgxaD8Ro5nEi98K2DfROvCiQdumhslLQQOuzOHvvkHWf51b/m4SAyqz?=
 =?us-ascii?Q?6rGgCyKWKpfPKG/EaQTwRByOYAGkEjEoiDe7Kz73hsEi2dyUmT3u8W7vg1Bq?=
 =?us-ascii?Q?DzGm1VYNscaGcqPh4TADe8EXah9F0F3eI+kJGKqa3pcQUvCUoBGDq9eY+62B?=
 =?us-ascii?Q?LlkKgmByujGAFTF9miv+Ol7xaJSSeao2tQeBz9DzIlrVMU9573wBw2B9OTzZ?=
 =?us-ascii?Q?wBfZ/Qua6atrCT1SblW8uSSbdDhwHY9GDU0xXc99+CeHWjI35xU/e0yCa2XE?=
 =?us-ascii?Q?odEBj70zEJaxGj+YQguo1EANHsNdQMNOHBomDM4SOGy/C7OKA/kjcGOIg6NR?=
 =?us-ascii?Q?t65Fcpb2aXRU66lKI/+cCW46SE3cjHB6T97a41UIrQqopfsRI0AZwaZ0Gx9p?=
 =?us-ascii?Q?5VU2JwkoYHYhSAiL9tPoIJt56GeVqXeHC+7Dnr8a2ec/jQ/9XGTQGALpcOTq?=
 =?us-ascii?Q?gUgNPw0WPK5TBRPY8PWXR96vjWLWSxVg8unRXPxEcRiPiyc2rnfWoWoM/7WD?=
 =?us-ascii?Q?DPi66bSIorJo0CmeshZs4P+xSEiwlDCBrkqKGFxc7iR5nP2VcsdzQS3o0jBZ?=
 =?us-ascii?Q?5f+3Fv0nVdWOeez217COrQJt3m22ToQK5e3x8hfu4kBncuoqxNzaclK5d8sR?=
 =?us-ascii?Q?SRcljKiuPDUVqekWr3MYgvhOYCP60u8LFAlbJuxWZZQO2Qw6imhkbBphD2V9?=
 =?us-ascii?Q?GCvY5AHfIwguUnC6n5EMTJzE9xEGdOcv0jDORYKjweWOxQwYSwihJwviNxGq?=
 =?us-ascii?Q?iuI5T3N4DJpEnN9roLfVCB5mAXU+a4Uf+ejUOVZEjo8s3uHrQGb8OkekdE06?=
 =?us-ascii?Q?ZyaIDFXrWvWXmqmdN/y5YelKlwKFLTC+v0TAaQafThkDM6qsltf86HTyeTF9?=
 =?us-ascii?Q?lKZCclYVWdwvL8aX14ECg8TJ/007Ju/IH2EIzNKT5AjU55dJswUmbMWh/I7f?=
 =?us-ascii?Q?EWh8K8ieoC6qNBYDPuR+eyoDp2abSLAV8sGZ5Ia5H6VtsC80PGs6qkWk9qru?=
 =?us-ascii?Q?4PWIelOQoJlR5IvnIEqZw6FOt399hkVbsCfkJoVrTX2K+cISymSieRFRYRXS?=
 =?us-ascii?Q?3D57y41seqk4Z0uADmBnReZV+BQ7MQY4PuAG8IbNb+Gv17CYxF8A7qoWjHDQ?=
 =?us-ascii?Q?mObUpwKAWMuwogSNSidepVFDF/xzP224k0QXAw87bVUTIpfogGkvlpPy4ckQ?=
 =?us-ascii?Q?psTwu5JS/KQNRZjR09/wJDCR9pvalyYdXRy4toFqAPIFriNq+E/QcvGRdy7l?=
 =?us-ascii?Q?HRxETk9hYsABzJILSRoMLrB9a2dVf+sJ+mbPyezEF1ymS9vgicQFJRrJvVyK?=
 =?us-ascii?Q?I6apfRHUs97hvSdwyCsqmuNiuHSDDvBJFUcU8MGqVroQPW7jOjzS+5yfxdee?=
 =?us-ascii?Q?kOyWcX9VPBYY0DRjPmLUnMAALUNiNAFlFmyVIJxQ2fsmyzQLRRRWfA6EKduM?=
 =?us-ascii?Q?aM1+cha67HYD5S26zWk/7pswzgKSTv0e2IY/jaqlpgezuATOUqPlIu5r8JRl?=
 =?us-ascii?Q?jLHQNXb5gQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b867a2-2e0a-4adc-04ad-08da37f2be8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 10:48:14.4312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JzcpdWtIRuh4AZp/V4sOtt9GyuXvmBb/ZF75HXQv9+JLPeZdctwRlgIArnRAyh2M+D4U5+NrqvhjhUPnP0PEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_02,2022-05-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=972
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170065
X-Proofpoint-GUID: FCv-sEJFgqVham5be9UyqxEmaoY-mrXl
X-Proofpoint-ORIG-GUID: FCv-sEJFgqVham5be9UyqxEmaoY-mrXl
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_034823_103932_2B8D3678 
X-CRM114-Status: GOOD (  12.36  )
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

Hi All,

We observed a kernel panic which based on our analysis is due to a nvmet ra=
ce.
the race is between nvme connect and nvmet tcp port removal.
The scenario:
In case that nvmet_port_release is freeing the nvmet port just before nvme =
connect is trying to 'nvmet_find_get_subsys' (as part of nvmet_alloc_ctrl) =
nvmet_find_get_subsys is trying to access a port which is already freed:

nvme/target/core.c:
static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>------->-------const char *subsysnqn)
...snip
>-------down_read(&nvmet_config_sem);
>-------list_for_each_entry(p, &port->subsystems, entry) {
>------->-------if (!strncmp(p->subsys->subsysnqn, subsysnqn,

crash> bt
PID: 30216  TASK: ffff888c1e163f00  CPU: 0   COMMAND: "nt"
 #0 [ffffc90020153858] machine_kexec at ffffffff81062fcc
 #1 [ffffc900201538b0] __crash_kexec at ffffffff811273ef
 #2 [ffffc90020153978] panic at ffffffff810851f7
 #3 [ffffc90020153a18] no_context at ffffffff8107104f
 #4 [ffffc90020153a80] page_fault at ffffffff81801184
    [exception RIP: nvmet_find_get_subsys+161]
    RIP: ffffffffa0bbce01  RSP: ffffc90020153b38  RFLAGS: 00010282
    RAX: ffff888c1e163f01  RBX: 0000000000000000  RCX: 0000000000000020
    RDX: 0000000000000000  RSI: ffffffffa0bc5895  RDI: ffffffffa0bce040
    RBP: ffff88aeafc3f520   R8: ffffc90020153ba0   R9: 0000000000000000
    R10: ffffc90020153bf8  R11: ffff888cb8e97b00  R12: ffff888bb3469a00
    R13: ffff888bb3469900  R14: ffffc9000c41ba70  R15: ffffc90020153ba0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffffc90020153b58] nvmet_alloc_ctrl at ffffffffa0bbe4c2 [nvmet]

Can you please review and provide your inputs ?

Thanks,
Amit


