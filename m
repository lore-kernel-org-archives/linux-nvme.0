Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18ADC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVc0Vn21TzOH/44rW0WS+XnxeKyidlKGKDPtfacUeck=; b=b0hfHMcUpUSIjnC9bABAEK5RVx
	8Y3MM5x61OD9UoayTByTSzWyB68TDv8YKFXVPDfNKBDBTpd1tsoa7oWi5aFLMNzY1nlIOYpqCGugK
	bEZkQ2uh9N1jkPYKN3+w3XfG9TVrJNnmGN6MVh92c7TZoEHPr1nhOEYSJd6LLPkj7tX+1ytmQMiAt
	JHXfT3qP7r4qEsbod+FYnSF/iWIw+DUDVPpBeHzEcFZbeVUHTFaKWs8UsykFMVwLrFKpBgbocHBLe
	HJG+18klEINnNKMb5pLYGr+TOJ+/g83eYif6aVScMsPCWEH/SFXuYmUy7VBCG/r54uGJZf41sUuv+
	cLFh6cfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFeHC-001sep-68; Thu, 03 Feb 2022 15:44:02 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFeH8-001sds-KF
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 15:44:00 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2139jk7C014897;
 Thu, 3 Feb 2022 10:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=JVc0Vn21TzOH/44rW0WS+XnxeKyidlKGKDPtfacUeck=;
 b=kqrK2KtirTBk01MbRd5DRxJloqgQdUagSBBZXBY+TvUHjJBfQ1ZTxCOO5NIkBvcWpJGD
 tZIQwHmWflRPqaS/oRMDqn2xwllEDHR0FfZ2+EtwrlbXI5nrorv5mHNOgKeHwkII9cOD
 +S5AVnw9Wny+Q8mA383IAvb0s0TuvVPVuZSgU+TuWIPEaPKfSNM4kjOoSOSdrFyuEhUK
 QGY10MlCcC98jLE0YTvGrriu5HP4p3/8LJRdx6N46pPlY/GOfpPlJX4vIXEH45gGjPI2
 bMHIv/m0lwzzmIxtHaMEvHTcTaadV5aO6x9D6yMxt9JX6R1XPJRRS+2GWLy7bN94mElI yw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3dyvm6cr21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Feb 2022 10:43:46 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 213FaKLe045875; Thu, 3 Feb 2022 10:43:45 -0500
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
 by mx0b-00154901.pphosted.com with ESMTP id 3e08b5funh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Feb 2022 10:43:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXHhiBOVWgZA3Cion7UCZ43zdIgmorNA9CC+aIPJ3uADucqKAwhRI9scdnkXoA/w7/1bZyavknQ5oMslAQ5Vzo8xi1gND+KeoGn6S0w3opreO7AA2k9zUAC+fHac4lJy/Uz2xUM7VrQoiW3ja+qKJVHSFWBg8PkNjoLnQxAv6t5cbf8nay6e9czzkXp9pEte7gfXj2bUfbbJNUSOPKBovr+qNG5X1sjLtMtADwA+PgiH/Fwxndlx4J4nxWfdDUYq2MnqmF38XbG8odcveSHLmQaxZk5iDqwJWr67GinVFRXqMAneBv9WvAEUbRJncWRXyN90WTVK1fKxGZVvD6qVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVc0Vn21TzOH/44rW0WS+XnxeKyidlKGKDPtfacUeck=;
 b=Wg7bH4j0hpT2h4A0tuoMGA3S4ZahdawksEADc+48EXMTUXxIPn0gyqbe+xH+ymSO5qXSwY9BL44SaFXvgkDCHyfpX5GIhz0l9iBQMtnonGUWiL7PlRZJ8ME1CwxpDYDU3T1kjaAUDRR+m9cgNuqXA96acS3UaDnt449vMp2rR7NvYM8u2GxWCIdqhYckOEXU/QAxCEfKYTbUS4SMluiRsA5bOYPW7Jar4esWQvA1K/1v8lM9vtJh3ARXB7tUroW33l/0j2h1/VWXj/YHYdNt7TLKnk20zgBM8N4eyPVKczAIIWlPVc8yNidcYs7bLNoMrouB+58dodC/EzQBcPpAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by MWHPR19MB0080.namprd19.prod.outlook.com (2603:10b6:301:6a::34)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 15:43:43 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 15:43:43 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "Hayes, Stuart" <Stuart.Hayes@dell.com>, "Rose,
 Charles" <Charles.Rose@dell.com>
Subject: RE: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Topic: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Index: AQHYGHzVH84DVIVYUE+St1ikwYiM3ayBa48AgABM5JCAAAtkAIAACSOwgAAHLYCAACJKgA==
Date: Thu, 3 Feb 2022 15:43:43 +0000
Message-ID: <SJ0PR19MB4544CF86ADD8F3771CA9E4BEF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
 <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
 <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
 <SJ0PR19MB4544B435D22B0F19E2B7CEBAF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ea56c568-9cbe-3087-21b0-81023ead927f@grimberg.me>
In-Reply-To: <ea56c568-9cbe-3087-21b0-81023ead927f@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-02-03T15:43:41Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=0c324119-d6ab-4eaf-bb99-4f33546a0978;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf7a56d1-39d4-42a1-426c-08d9e72bf565
x-ms-traffictypediagnostic: MWHPR19MB0080:EE_
x-microsoft-antispam-prvs: <MWHPR19MB00806F108983D19E108BB2A1F2289@MWHPR19MB0080.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02Ir66i+o9FWitIASvD0+YAlnxPduHkDDClCXcRQoKSyU31LWF9VFo034PfoYnn4QtYkfo1e3BUSefeYNivwXFFNtATr6hHon+zxBhApQBSmlREKwA8HiIpl2MKvMhzy//VKeXMGHDPtn/B+3OKtNApng0A51IxRZzSthbvVwU7soqN4z9QiVxxNmi4tezPy7eEsoVZiWxSNmQrrEy/uJ+F5YbBILCBt2mY+z59t/HFzYM7OEj8bZrWQL2wwFxytJbcywjXm9sMhhxsWyniD/92mgRDH9fVcxih/MtmPvtMmBXobF9xzOOcijj9XvWqsX0wIoMfvDQNS/3voTlzgJx2MkIGSXwUB21a1/9te2v9w4lQ+rfQBrD5hfuBDwLg+O1rGHSPxOXi0F1/u9KAdnxZF+6fYr7IrRRa/nT0K5nWHpI10bzlthmXn7H1igAmuv4so7uNRi1oCP0brUfPpImXlvwdbB+mfdGpzM9IlI/s/86RO1P5Jzj0i6cXjCbAaq2VwqKkF4UCFLjia4S3n8hJCIC+iLt/1L9UZm91SpVs6AStIo7EhTeZyD43Rcmcvlyjueg5pTSfc5CgbbtK+Icz5b7hh2ODSWAZqPGqUQIn5n5G2rQihhNsWFbF/l13u7amvkx+RJgEe1HqC7rb/+dXijmLahAptZ2AEjJzEBD8KRgrpJsF8a5YUX8lQfpDsT0VEFfs/IU86W1No8ZhMKg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66556008)(66476007)(66446008)(8676002)(8936002)(64756008)(54906003)(26005)(186003)(110136005)(33656002)(55016003)(508600001)(86362001)(107886003)(4326008)(66946007)(76116006)(82960400001)(38100700002)(2906002)(38070700005)(786003)(316002)(6506007)(7696005)(9686003)(71200400001)(52536014)(122000001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVZvUms4aEJXWHA5WlB6TnpteEMwTC93dUZDNU0yMHdNVDRlTHVnbFRhY09L?=
 =?utf-8?B?OGNidGhEZkIwUkR2TVBoYlVNU2g0MmVlTEtIYzdleDFRQkhxNVFJejdadGhG?=
 =?utf-8?B?SjFQOVhCbFl6UTdZVFF3MFJGQzR0NkMzSlVMdzVWV1k2MzNoRENoS0JBM0Ur?=
 =?utf-8?B?RGV1aW0vclhKaDlXS1BGZDh6VWpYVlBGY0hTQml0MTlkYlllZ3lBWmplNG84?=
 =?utf-8?B?RVFEcDI5UDFETDV6SHo4N1lyMzJhdDdHRWN6ajg1UnlwYnVvdm8xT2phQkwr?=
 =?utf-8?B?UG5BS3lSZFJLQnpwSE5OV0NFVVI0NlBENjZlRm1JMjRhZ0ZWMExVNmtub2s1?=
 =?utf-8?B?NXZXQkN4dDhXWGVtY0lVeU1HUGxhRldad1JuQ2V1bWdPdXBkK2RvZUVJZEw4?=
 =?utf-8?B?Rm9CMThkdFZLZFRSb3pmSklMUitySGZJN0ZJTGtjTW80VVBRbGRaWnVFMXlR?=
 =?utf-8?B?U3B3NkdnTUcyenFUTWNyZmVIbUlXYkZaM2JZcUdBaUdzMGVvL2dqMVlCanlF?=
 =?utf-8?B?bHFGc3l3c1E5cjJCLzFpMFJDRHVJQ2dGZ2tQUVp3SGFaa3JHaTcyLy9CbTVl?=
 =?utf-8?B?OWxrRTlGb2MyRnNsNG9aYjk1L2liOG0yMTJmNTNsK25zMnErTzdKaFR6dWxs?=
 =?utf-8?B?SFpqamg4a3ZXcjJjMC8xbEJYeWEwTzdoYUxsOUVCdVNNRlFnOUN4aUZWS1pF?=
 =?utf-8?B?MDhhamJJR2U5b05OQUROQ1JSaksvREV1MFdBbmRER1J0M1QrbHR3YUY5WEN1?=
 =?utf-8?B?ekNDWlNMN3FvS3VOUjNycGZEbm5YWjEvcVBQSHk2Uy82Y1ZPaitzWndESlkr?=
 =?utf-8?B?dEhaL3JrVnNIaTlYQnRidmtqYk1RTmQ2dlFTdVVMSHpzRytpZUg5RzVXdWlW?=
 =?utf-8?B?YjFXd2tKZGpqRTVHWmxvcXdBNjk3bjJ1T1FMeU5ScmltdmE3aGhJYjZ2VC9r?=
 =?utf-8?B?cy9zaVpDK2k2VFpBeUZFOUorRStjTkhJME5MTEdKNjh0UnFlbXlLSmRoUEJv?=
 =?utf-8?B?elhtNGh0eHFtdFZmV0tzN0hJYWdMeE1xQVdRMENrSllVcVJoa3g3TnVYekd5?=
 =?utf-8?B?Zld3MHpJNHBZM0ZGcG8xeFBFOW5LdVRORy9lcVRSTzNMQm80NnlQYTV5N1M3?=
 =?utf-8?B?VjU1VTNpSmNZbVI0VC9BWVR5WGFMbVlRY2M4UnZ6OFhQWTh1aG9yeVNTengw?=
 =?utf-8?B?UklZd05rckR1elNYK3Z1WVdiVHVLbW5IWnBLNnFwMDlnRGp4cnRPN1ZzSmlW?=
 =?utf-8?B?ZVViRXFvK2ppWkRjVlp2UnJHVkVGUDFRSExyWDlrdDVyaDVPOHl4QlJ0SjN5?=
 =?utf-8?B?bXNraDVWUFdUNVlnem5mQWZuVGR1bnpURStuOWhUc09wQ1A5SThPWktKckJl?=
 =?utf-8?B?RGF2VHZ4cGx4K2lMUlRhejlQL0dJQnBnU0JRWUxRUzh3dzhWMU9OZVFSbFM4?=
 =?utf-8?B?UUI1L2F4OG56K2dkcCtkVHprd1lVUEZlMnY1L3dqM1k2dDZ2bjFWSmFabmZN?=
 =?utf-8?B?YXgvY0ZZSzBZYmg4VG5jRVhxM0ZsNHRFMllyMnpITlFvbHdCQWtJeDJpT1RP?=
 =?utf-8?B?M2hsemt3OFplbVN5RmpRc2tYOHlVdkRWelpSeU5Sd1p3bXN2TjJIaFZ2Q1d0?=
 =?utf-8?B?L2JvZHZ1aXNQSEpVaER5RzRwNU5tQVZGVDdUTmNoZjVrbDIwbGJlVm8yeTIr?=
 =?utf-8?B?UXFHakgwbHZGTnRuV2tXWmdPQlRWTHFIRVNyVU1SQ29NTGhXellxZ2RoOUdC?=
 =?utf-8?B?eGpJSWl6eXltWGl0WXh2NDhBamp6S3NrRklITjBUZ1VETTEwYmk5SWVDWnda?=
 =?utf-8?B?ZzNPTXpTeWJpNVJjcUJHYVM3VHMvUmxVMmlGeWpYdzQybHI5VW1wL3ZOUk5x?=
 =?utf-8?B?eFZmOTdoR3NCYVJOY1FsanJMUkdLcjM2ajUyRlkwdmFQZlRobjdISHRiWlpV?=
 =?utf-8?B?Y2xibml2dkNuRDU1OWJTZ2E4d3NBd0VVZFpXM0l1bGdBd3NzOG94bmpXR3Bw?=
 =?utf-8?B?YmVweHpBVm9VY1ljeDIzWjFPbXAxZ2x4S05EWFBWL0NYS3ZDTUFHMzU0U3hC?=
 =?utf-8?B?ZlluMG5BaVk0ZkpLMUFvaHJXT0R6SnRSeTU5OEc2clNrcWFwa2xNRnVYOXpB?=
 =?utf-8?B?MW9TclBGejZNVFljZ0N4c0phZkQrSjJNcDlpanJvRDZncVFuZkx1TWFOUVFF?=
 =?utf-8?B?Yi9nN01GcEE1OElhaFhFSDZHM1JtTEJFM2doMVdab1hYampuOVh3bHB3b2xF?=
 =?utf-8?B?bkZyU3pKUzcrNllGelYxVVFrMXd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7a56d1-39d4-42a1-426c-08d9e72bf565
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 15:43:43.5362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tscucqOFhLs8rrkvsC/Osk9Mw29xP0oI8JH2M9bXUMVB0jmsm+13G6MFgsGaMRdTO6WxCA8n80gqYmcvREYPfI49iHNyRis40wmeNOzOxm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB0080
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-02-03_05:2022-02-03,
 2022-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2202030096
X-Proofpoint-GUID: _fkkWTxSGRgIXGngKgi01VyZUgq70fKx
X-Proofpoint-ORIG-GUID: _fkkWTxSGRgIXGngKgi01VyZUgq70fKx
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_074358_748038_BEAA0ED3 
X-CRM114-Status: GOOD (  25.99  )
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

PiA+Pj4+PiBGcm9tOiBNYXJ0aW4gQmVsYW5nZXIgPG1hcnRpbi5iZWxhbmdlckBkZWxsLmNvbT4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gVFA4MDEwIGludHJvZHVjZXMgdGhlIERpc2NvdmVyeSBDb250cm9s
bGVyIFR5cGUgKGRjdHlwZSkgYXR0cmlidXRlLg0KPiA+Pj4+PiBUaGUgZGN0eXBlIGlzIHJldHVy
bmVkIGluIHRoZSByZXNwb25zZSB0byB0aGUgSWRlbnRpZnkgY29tbWFuZC4gVGhpcw0KPiA+Pj4+
PiBwYXRjaCBleHBvc2VzIHRoZSBkY3R5cGUgdGhyb3VnaCB0aGUgc3lzZnMuIFNpbmNlIHRoZSBk
Y3R5cGUNCj4gZGVwZW5kcw0KPiA+Pj4+PiBvbiB0aGUgQ29udHJvbGxlciBUeXBlIChjbnRybHR5
cGUpLCBhbm90aGVyIGF0dHJpYnV0ZSBvZiB0aGUNCj4gPj4+Pj4gSWRlbnRpZnkgcmVzcG9uc2Us
IHRoZSBwYXRjaCBhbHNvIGV4cG9zZXMgdGhlIGNudHJsdHlwZSBhcyB3ZWxsLg0KPiA+Pj4+Pg0K
PiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gQmVsYW5nZXIgPG1hcnRpbi5iZWxhbmdlckBk
ZWxsLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICAgICBkcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMgfCAzNQ0KPiA+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+
Pj4+ICAgICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggfCAgMyArKysNCj4gPj4+Pj4gICAgIGlu
Y2x1ZGUvbGludXgvbnZtZS5oICAgICB8IDEwICsrKysrKysrKy0NCj4gPj4+Pj4gICAgIDMgZmls
ZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4+Pg0KPiA+
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jDQo+ID4+Pj4+IGluZGV4DQo+ID4+Pj4+IDg3MmMzODlkYzZkMy4uYzY1ZDQ0
ZmI2NWM0IDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4g
Pj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ID4+Pj4+IEBAIC0yOTkyLDYg
KzI5OTIsOSBAQCBzdGF0aWMgaW50IG52bWVfaW5pdF9pZGVudGlmeShzdHJ1Y3QNCj4gbnZtZV9j
dHJsDQo+ID4+Pj4gKmN0cmwpDQo+ID4+Pj4+ICAgICAJY3RybC0+bWF4X25hbWVzcGFjZXMgPSBs
ZTMyX3RvX2NwdShpZC0+bW5hbik7DQo+ID4+Pj4+ICAgICAJY3RybC0+Y3RyYXR0ID0gbGUzMl90
b19jcHUoaWQtPmN0cmF0dCk7DQo+ID4+Pj4+DQo+ID4+Pj4+ICsJY3RybC0+Y250cmx0eXBlID0g
aWQtPmNudHJsdHlwZTsNCj4gPj4+Pj4gKwljdHJsLT5kY3R5cGUgPSBpZC0+ZGN0eXBlOw0KPiA+
Pj4+PiArDQo+ID4+Pj4+ICAgICAJaWYgKGlkLT5ydGQzZSkgew0KPiA+Pj4+PiAgICAgCQkvKiB1
cyAtPiBzICovDQo+ID4+Pj4+ICAgICAJCXUzMiB0cmFuc2l0aW9uX3RpbWUgPSBsZTMyX3RvX2Nw
dShpZC0+cnRkM2UpIC8NCj4gPj4+PiBVU0VDX1BFUl9TRUM7IEBADQo+ID4+Pj4+IC0zNTI1LDYg
KzM1MjgsMzQgQEAgc3RhdGljIHNzaXplX3QNCj4gPj4+PiBudm1lX2N0cmxfZmFzdF9pb19mYWls
X3Rtb19zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4+Pj4+ICAgICBzdGF0aWMgREVWSUNF
X0FUVFIoZmFzdF9pb19mYWlsX3RtbywgU19JUlVHTyB8IFNfSVdVU1IsDQo+ID4+Pj4+ICAgICAJ
bnZtZV9jdHJsX2Zhc3RfaW9fZmFpbF90bW9fc2hvdywNCj4gPj4+PiBudm1lX2N0cmxfZmFzdF9p
b19mYWlsX3Rtb19zdG9yZSk7DQo+ID4+Pj4+DQo+ID4+Pj4+ICtzdGF0aWMgc3NpemVfdCBudm1l
X2N0cmxfY250cmx0eXBlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiA+Pj4+PiArCQkJCSAg
ICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXINCj4gKmJ1Zikgew0KPiA+Pj4+
PiArCXN0cnVjdCBudm1lX2N0cmwgKmN0cmwgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPj4+
Pj4gKw0KPiA+Pj4+PiArCXN3aXRjaCAoY3RybC0+Y250cmx0eXBlKSB7DQo+ID4+Pj4+ICsJY2Fz
ZSBOVk1FX0NUUkxfSU86CXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgImlvXG4iKTsNCj4gPj4+Pj4g
KwljYXNlIE5WTUVfQ1RSTF9ESVNDOglyZXR1cm4gc3lzZnNfZW1pdChidWYsDQo+ICJkaXNjXG4i
KTsNCj4gPj4+Pg0KPiA+Pj4+ICdkaXNjb3ZlcnknLCBwbGVhc2UuICdkaXNjJyBpcyBtaXNsZWFk
aW5nIGhlcmUuDQo+ID4+Pj4NCj4gPj4+Pj4gKwljYXNlIE5WTUVfQ1RSTF9BRE1JTjoJcmV0dXJu
IHN5c2ZzX2VtaXQoYnVmLA0KPiAiYWRtaW5cbiIpOw0KPiA+Pj4+PiArCWRlZmF1bHQ6CQlyZXR1
cm4gc3lzZnNfZW1pdChidWYsICJyZXNlcnZlZFxuIik7DQo+ID4+Pj4+ICsJfQ0KPiA+Pj4+PiAr
fQ0KPiA+Pj4+PiArc3RhdGljIERFVklDRV9BVFRSKGNudHJsdHlwZSwgU19JUlVHTywgbnZtZV9j
dHJsX2NudHJsdHlwZV9zaG93LA0KPiA+Pj4+PiArTlVMTCk7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4g
K3N0YXRpYyBzc2l6ZV90IG52bWVfY3RybF9kY3R5cGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYs
DQo+ID4+Pj4+ICsJCQkJICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhcg0K
PiAqYnVmKSB7DQo+ID4+Pj4+ICsJc3RydWN0IG52bWVfY3RybCAqY3RybCA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJc3dpdGNoIChjdHJsLT5kY3R5cGUpIHsN
Cj4gPj4+Pj4gKwljYXNlIE5WTUVfRENUWVBFX05PVF9SRVBPUlRFRDoJcmV0dXJuIHN5c2ZzX2Vt
aXQoYnVmLA0KPiA+Pj4+ICJuclxuIik7DQo+ID4+Pj4NCj4gPj4+PiBQbGVhc2UgdXNlICdub25l
JyBoZXJlOyAnbnInIGlzIGFtYmlndW91cyAoJ051bWJlcic/KQ0KPiA+Pj4NCj4gPj4+IFRoYW5r
cyBmb3IgdGhlIHJldmlldy4gSSB3aWxsIGFwcGx5IHRoZSBjaGFuZ2VzLg0KPiA+Pj4NCj4gPj4+
IFF1ZXN0aW9uOiBTaW5jZSB0aGlzIHdhcyBwYXJ0IG9mIGEgc2V0IG9mIHBhdGNoZXMsIGRvIEkg
bmVlZCB0bw0KPiA+Pj4gcmVzdWJtaXQgdGhlIHdob2xlIHNldCBvciBjYW4gSSBqdXN0IHJlc3Vi
bWl0IHRoaXMgb25lIHBhdGNoPw0KPiA+Pj4NCj4gPj4gV2hvbGUgc2VyaWVzLCBwbGVhc2UuIEFu
ZCBnYXRoZXIgdXAgdGhlIHJldmlld3Mgd2hlbiByZXN1Ym1pdHRpbmcuDQo+ID4+DQo+ID4+PiBB
bHNvLCBTYWdpIG1lbnRpb25lZCB0aGF0IHRoZSBkY3R5cGUgc2hvdWxkIG9ubHkgYmUgZXhwb3Nl
ZCBmb3INCj4gPj4+IERpc2NvdmVyeSBDb250cm9sbGVycywgd2hpY2ggbWFrZXMgc2Vuc2UuIEhv
d2V2ZXIsIEkgZm91bmQgdGhhdCB3aGVuDQo+ID4+PiBudm1lX2Rldl9hdHRyc19hcmVfdmlzaWJs
ZSgpIGlzIGludm9rZWQgdGhlIGN0cmwgb2JqZWN0IGlzIG5vdCBmdWxseQ0KPiA+Pj4gY29uZmln
dXJlZCB5ZXQgKGkuZS4gdGhlIGNvbnRyb2xsZXIgaXMgbm90IHlldCBpZGVudGlmaWVkKS4NCj4g
Pj4+IElzIHRoZXJlIGFueSBvdGhlciB3YXkgdG8gZGV0ZXJtaW5lIHRoZSBjb250cm9sbGVyIHR5
cGUgcHJpb3IgdG8NCj4gPj4+IHJlY2VpdmluZyB0aGUgcmVzcG9uc2UgdG8gdGhlIElkZW50aWZ5
IGNvbW1hbmQ/DQo+ID4+Pg0KPiA+PiBOb3BlLCB1bmZvcnR1bmF0ZWx5Lg0KPiA+Pg0KPiA+PiBC
dXQgbWF5YmUgd2UgY2FuIGx1bXAgYm90aCBhdHRyaWJ1dGVzIHRvZ2V0aGVyIGluIHRvIGEgc2lu
Z2xlIGN0cmx0eXBlOw0KPiB0aGVuDQo+ID4+IHdlIHdvdWxkIGhhdmUgJ2lvJywgJ2FkbWluJywg
J2Rpc2NvdmVyeScsICdkaXNjb3ZlcnktY2RjJywgYW5kICdkaXNjb3ZlcnktDQo+IGRkYycuDQo+
ID4+DQo+ID4+IEhtbT8NCj4gPg0KPiA+IEkgbGlrZSB0aGF0LiBJIHNoYWxsIGNvbWJpbmUgdGhl
bSBpbnRvIGEgc2luZ2xlIGF0dHJpYnV0ZS4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBh
IGdvb2QgYXBwcm9hY2guDQo+IA0KPiBUaGVyZSBpcyBhbHJlYWR5IGFuIGludGVyZmFjZSB0byB1
cGRhdGUgc3lzZnMgZ3JvdXBzLCBzbyBpbiB0aGVvcnkNCj4gdGhpcyBzaG91bGQgZG8gdGhlIHRy
aWNrOg0KPiAtLQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jDQo+IGluZGV4IGMxMWNkM2E4MTRmZC4uZDg2ODI4Y2Y3NzIw
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jDQo+IEBAIC0zMTE1LDYgKzMxMTUsMTEgQEAgaW50IG52bWVfaW5p
dF9jdHJsX2ZpbmlzaChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQ0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgICAgfQ0KPiANCj4gKyAgICAgICByZXQgPSBz
eXNmc191cGRhdGVfZ3JvdXBzKCZjdHJsLT5kZXZpY2UtPmtvYmosDQo+IGN0cmwtPmRldmljZS0+
Z3JvdXBzKTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIHJl
dDsNCj4gKw0KPiArDQoNCkkganVzdCB0cmllZCB0aGlzIGFuZCBpdCB3b3Jrcy4gDQpNYXJ0aW4N
Cg0KPiAgICAgICAgICBjdHJsLT5pZGVudGlmaWVkID0gdHJ1ZTsNCj4gDQo+ICAgICAgICAgIHJl
dHVybiAwOw0KPiAtLQ0KPiANCj4gQnV0IHByb2JhYmx5IHdlIHdhbnQgYWRkIGEgbmljZXIgaW50
ZXJmYWNlIGxpa2UNCj4gLS0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
YyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBpbmRleCBjMTFjZDNhODE0ZmQuLjhmYjk0
Y2IxNWZiMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBAQCAtMzExNSw2ICszMTE1LDExIEBAIGludCBu
dm1lX2luaXRfY3RybF9maW5pc2goc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAgIH0NCj4gDQo+ICsgICAgICAg
cmV0ID0gZGV2aWNlX3VwZGF0ZV9ncm91cHMoJmN0cmwtPmRldmljZSk7DQo+ICsgICAgICAgaWYg
KHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsNCj4gKw0KPiAgICAgICAg
ICBjdHJsLT5pZGVudGlmaWVkID0gdHJ1ZTsNCj4gDQo+ICAgICAgICAgIHJldHVybiAwOw0KPiAt
LQ0KPiANCj4gV2hlcmUgZGV2aWNlX3VwZGF0ZV9ncm91cHMgd291bGQgYmUgc29tZXRoaW5nIGxp
a2U6DQo+IC0tDQo+IGludCBkZXZpY2VfdXBkYXRlX2dyb3VwcyhzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+IHsNCj4gICAgICAgICAgc3RydWN0IGNsYXNzICpjbGFzcyA9IGRldi0+Y2xhc3M7DQo+ICAg
ICAgICAgIGNvbnN0IHN0cnVjdCBkZXZpY2VfdHlwZSAqdHlwZSA9IGRldi0+dHlwZTsNCj4gICAg
ICAgICAgaW50IGVycm9yOw0KPiANCj4gICAgICAgICAgaWYgKGNsYXNzKSB7DQo+ICAgICAgICAg
ICAgICAgICAgZXJyb3IgPSBkZXZpY2VfdXBkYXRlX2dyb3VwcyhkZXYsIGNsYXNzLT5kZXZfZ3Jv
dXBzKTsNCj4gICAgICAgICAgICAgICAgICBpZiAoZXJyb3IpDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gZXJyb3I7DQo+ICAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgIGlmICh0
eXBlKSB7DQo+ICAgICAgICAgICAgICAgICAgZXJyb3IgPSBkZXZpY2VfdXBkYXRlX2dyb3Vwcyhk
ZXYsIHR5cGUtPmdyb3Vwcyk7DQo+ICAgICAgICAgICAgICAgICAgaWYgKGVycm9yKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfcmVtb3ZlX2NsYXNzX2dyb3VwczsNCj4gICAg
ICAgICAgfQ0KPiANCj4gICAgICAgICAgZXJyb3IgPSBkZXZpY2VfdXBkYXRlX2dyb3VwcyhkZXYs
IGRldi0+Z3JvdXBzKTsNCj4gICAgICAgICAgaWYgKGVycm9yKQ0KPiAgICAgICAgICAgICAgICAg
IGdvdG8gZXJyX3JlbW92ZV90eXBlX2dyb3VwczsNCj4gfQ0KPiBFWFBPUlRfU1lNQk9MX0dQTChk
ZXZpY2VfdXBkYXRlX2dyb3Vwcyk7DQo+IC0tDQoNClNhZ2ksIHdvdWxkIHlvdSBhZGQgdGhpcyBm
dW5jdGlvbiB0byBkcml2ZXJzL2Jhc2UvY29yZS5jPw0KTWFydGluDQoNCkludGVybmFsIFVzZSAt
IENvbmZpZGVudGlhbA0K

