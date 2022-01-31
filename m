Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4690BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QeIZQ9Y7tACylaAwPJKwvrNq1kaKdZfkixL9eUS5A9k=; b=Ko0B6Gn6nC2z7TSxqIeAqdkb+S
	UeJr/FK+L13PQ2hZ66tPie9Wqyj1wNIS8CfK436pxqtL6VkThlxPuDOTpopMPa6A0rLvvLl1Y0r0O
	QDoitGVVQTEeaE67I3w7cJgl9lNj7c8pPQq7uPrRMfqG6ZmDRelu7dJoGrpvhtoj24ybu10/KF2QR
	cS1qZQLcRf5zeohGH6hJniEoeBg1QNGgKUpqTxlCKOahK6Ccgyflya/rPsm9OmefOKV7H10Ct1jHz
	1H+9Y1L7fbMW+0J0czGUXdZPqFin0Gdeblchwb2NwK/XFylcnOdRjK5ngGPUjYSMtj2geJdFefVE5
	1Z1Bl6tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEZMD-009oGm-Jp; Mon, 31 Jan 2022 16:16:45 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEZMB-009oFo-4Z
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 16:16:44 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VCXvf5015150;
 Mon, 31 Jan 2022 11:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=QeIZQ9Y7tACylaAwPJKwvrNq1kaKdZfkixL9eUS5A9k=;
 b=f3lvPUmIRrLmoEh3suDdQr/4sMXvCfoagSrvl+oonspQnRQxLwkV64YkSUW7BxGBt5w0
 vwGdzF/hZYPqj7RRn2gI4vNlpVBUnn8x0AwavUgDwNbjgFdHvkQSOV3X6Z9n+j63R/Yd
 Q5hCKnP6E3n1SVXTVyMlkfDz5sdg9nb3ggSv09ProCv+GZm+IX4zH0xIXFfJPDy440zM
 gS87Stguj7OaXqVY0Eqy2Jd438qccb+4SRT2GnV/yV7tlv7Dqd+a43gLSt+R7+vbggZq
 qWacK6IiGe4uHzQ7if3wvm4hsz1kjcHkULU0AWvMc+jONBsrlj9Md7hCJ8zijeCEAXnU dQ== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3dw2a1x0v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jan 2022 11:16:21 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 20VGBtxA091296; Mon, 31 Jan 2022 11:16:20 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0b-00154901.pphosted.com with ESMTP id 3dwkpc8x1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Jan 2022 11:16:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZSUzPCsPt603fwfOVqYyulU4//gxosSmTYE2zW8OZxa4fl9/60oqTdZ/lpTb8FjFzAPcrTZxXv3FR0zoF40wegF4GJVgtXlDzWh0xOnEybsznOM7oZ1I0z+kUCdgU5rB0nDlhsXU7F6tJsWFWE34JT7XEkRLoPAcMGJdWbwCDEk+mF30Yyqq3myQazWg05aU16PdZeT976HAYWOYabSW5GX64pjn4SizOYTp4C75A5kLBBoQABSoibTWpODUyg5+9Hs6s3f0taJjABq4l1r14doPkuH0mXx2UnuS99RRY4qVHUu2JeDT77LjobQyvCRQTrPmD7wnzvbHaQ4ITCPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeIZQ9Y7tACylaAwPJKwvrNq1kaKdZfkixL9eUS5A9k=;
 b=XIQ+29uKZHOCpDCYkmQsIctYucl1OZCfH/oEIGhrow7YHYoz4xAOp3VW4N/TfN6E0eithKNURB79zxNvW9vprc/9wpEJGAM9K5KdStRzYcvpFky+GppFGX5UwzzrFaZH78kklZlks3R0wS4/EYtDoZ7Km9l0PTEBfs0QhLbPzqgznWLV43ITVDhsSJ79HKvGanYBHyH67wG/LXuLgC0sDph1bsLEjWBojdUn6LEMNfapRDgY+UhaXXqe+YlYXNd7weDyt1S0lqVv8aIToOEs7CNoEN++6MsPhMBkNsv+atFxAr+ZTYzj2Sum8VVtYNSnHmUDr09rLcyYa5Jn0Ph/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by MN2PR19MB2848.namprd19.prod.outlook.com (2603:10b6:208:f5::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Mon, 31 Jan
 2022 16:16:17 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9%4]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 16:16:17 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Topic: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Index: AQHYEfxP/F7s1ilTfEGG+nDhesZTRKx2nSQAgAA92YCAAALhIIAAkHMAgAFJADCAAEaUgIAAEf4QgACk24CAAD0u0IAABt+AgAFO2wCAAciAYIAARIeAgAACfhA=
Date: Mon, 31 Jan 2022 16:16:17 +0000
Message-ID: <SJ0PR19MB4544AC1F430E3B025FE8D0C5F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
 <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
 <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <e4c48b97-8f79-a373-96ea-13286632624b@suse.de>
 <13c327cf-8f04-e005-298f-0e43bb39b89e@grimberg.me>
 <SJ0PR19MB4544E634C5B347F231783B20F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <9c5e4cff-2a5e-c1d2-34ed-ac7918c3991b@grimberg.me>
In-Reply-To: <9c5e4cff-2a5e-c1d2-34ed-ac7918c3991b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-01-31T16:16:15Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=cb408cce-a8fc-4ee5-a112-1a5f192a4249;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed5969f0-fc44-49c3-2386-08d9e4d502ff
x-ms-traffictypediagnostic: MN2PR19MB2848:EE_
x-microsoft-antispam-prvs: <MN2PR19MB2848A976371B5F27AF778DEAF2259@MN2PR19MB2848.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /m0P4iGL+uQJW9E99/z8Jbpk1wN16+E4UXRfVJzCud/Y3tDbNECUj9XKhOASQAdNePJahrB+mKUF93pKuiboJQc/cU6xYloDiSchgY/Xxzn3X5NHYKmLkLl8zTAKO9w7BUjUMZslgNMLq02DYiK2laWqzQQHCv8PF4e5YQMX0OoDkZ+7ekeX8A6kskBVT2VY6ZLNRyufDebwuz3AcNKyzYQzFBYOKQyLhRVaX5NozZSMjdrizmQl96j0uuwSmwdfEWtzWgCC+ngLDNq6FwP+SRZdrmuVDwPFndKd/9s+iKnT+d1bVgX68cvoBKbuZBijA3Q0RWS5nRIgvlDByuEcKep4b5QhzANO6rS0ZyerXBaPjR/s3LpaYZguR12hs0RtEPWYqeRdaz59DaRVyYJqk0Ov+Gsm3Vx5NXEnngUeDJSoRTSY202LLgx1qFiHZFnvufI/nF4Ye0xpeX1kUDReTC70CpBLfe+STvdk+ZyKzHzmIl1zgUTE8cdDetLPUzODMstFdv52fHcg2eE3eYlpKT782YTPKeGOdg//o7T1rNcOmVe6JM9MJCJ55WKYgkuyVzaVj1V9P9N9JRPpz5JpALub5mxXKiC7XmGAeV51pSKYubVrVluPX5GoXAelEpPEOwXakUyNrNjmXTnEt1vRLEdSqGCkMf4tOuIi3axLJcq6GM2bZLFsrCBUaKL4Q7LIRSwhV6JMDGAc9zF7twbfhg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(66556008)(122000001)(66476007)(38070700005)(316002)(786003)(86362001)(4326008)(8676002)(64756008)(66946007)(66446008)(8936002)(76116006)(54906003)(110136005)(82960400001)(508600001)(71200400001)(9686003)(6506007)(52536014)(186003)(26005)(55016003)(5660300002)(4744005)(2906002)(33656002)(7696005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGhvRG1VbVVCNU1RK29WRWJ6SkRoYUlZbDFLTHg3cGFDRndSTENLaUg3ZmRI?=
 =?utf-8?B?alpnZHZ2NHp3RVEydlhUYS9GYStrY3pjTjI0Q25YZVNjVHFBSlQySmtnTnIy?=
 =?utf-8?B?WDMwTWxSbi80dVZQMlkybE10Q05CdGx2LzhWZXBCMGc3Q2FSOGllR2NIeks5?=
 =?utf-8?B?VkNlS3ZBMDYvTi8wblNxekhhak5VVVExL3lxTkZVSHlwZTZOSUdPaDRWbWFG?=
 =?utf-8?B?SkljVWgvQVBMT0RBMTBDUzl1TUlWV09IYjJkMk5INXJhUllEd3F0VEFnekYx?=
 =?utf-8?B?SUZNc0taSDF6ZDRib1c0cEtYOFRIQkYvNXQvVTVKcExMQnArQlhtNVdVMS84?=
 =?utf-8?B?c3NGMkF0TUtCdi9GYStQUGNjTGtQT1ZTTW5SODNEaEZNMEhJUEY2NHlsZ2lo?=
 =?utf-8?B?RlhkRUpKbzEreDZqUXM2aERzeWNGcGVMY0VleHB4NVVSZ1RxcjBoUzloOGsy?=
 =?utf-8?B?YXcwRzZHbnZHWmpMZXBVcGcwa2lKa2UwcVBZZkh2SEtzb3VVQlJlYkRMYnlw?=
 =?utf-8?B?amtNWFA4RkI3TmwreWRkdnRENm9JQmp1Rk5YZFMrdGpJVnZsUjhSVXM0T2tS?=
 =?utf-8?B?MG5zMlBGZzl3ZnhkRkxLclFjY0cySXVzeDdqQnBORVFlWkFMM0JmcGVWZnRy?=
 =?utf-8?B?Y3ZKMnQ5UXVqbVFwR1k3aURzc3QrVCtZY3Fid0lEbUdPSEtqV0VMaG5TV1Y1?=
 =?utf-8?B?UE02ZEZMNDVzU2xXRVJ0MnNrVXo1c1VFeStIYk8vSlZIRExRNkZoVjBBZjhC?=
 =?utf-8?B?aFd5bFE0RVNOOXRQZzFHeThNdGFva1J3Tjh0VThXaW9ZT21VTm1RYUtGTGcw?=
 =?utf-8?B?QUMwbGczMEhRdFdnaFJIb041aWZ4K3hjYktJclJZaUo3Tmt0TXRKYzFwWjNF?=
 =?utf-8?B?M21wSUp1QW53UnQ3QWFFZVdNaUc2ZTQrTjZEMXpjVmh4WlpISENDU1RRb3Fx?=
 =?utf-8?B?R1ZJNEdWVU5yUC9tSDd3WlIvQzI3NU00RnJHSkFmdnpGWFFkb0ttSzNYN3g2?=
 =?utf-8?B?LzZGNGVuY3RpT3FqdDhPempRbjdRSjA1ZnRpYytsMzZQbkNBM05pVFFQbG9p?=
 =?utf-8?B?TUE2TmdxOHZNMy9hS09DcnUwTHpTZ01EVU9GYjJMVXE5MExPZHQ1QWJYMHp5?=
 =?utf-8?B?OUJ5b3Z2WWo0N0FuSmJqbnNCQ2RSTldEVDN6S25nN1N2N3RDVENCdERaT1U5?=
 =?utf-8?B?NXJpMEF0bFozOEUyMktSMGJCWXA2WnBYcmtXSzNVd0FzMzJuVGxpcitGcTRY?=
 =?utf-8?B?aHBBSlNnNlBoM29GZS9keUhWb1lVd2xzUHBxSE5XL0hHeEN2R25qMWRrK0R5?=
 =?utf-8?B?U0I0KzZZVUNZV1pmMXppc2FxUEJZM0loWTZwbCtrWUdWZEk0cGhscGFFaE9O?=
 =?utf-8?B?QnhycUxsT2hhaHdtT3lPcHM5VUFRR3QvUzVVTC9YNVAwekNVUWpsY3NtdGNG?=
 =?utf-8?B?eUpHMG92MDgrcTFSZGdPT21YYjZnMllwS3VXQjNJZjE1SXFHcGhncWp5YUh4?=
 =?utf-8?B?ZHdYa3lRQWtMZFd5KzBlVUlzc21meGxXOHMyMEoxZUNyZnFWVHVOTUZtV3cw?=
 =?utf-8?B?ZUpZa2plVkIwc1JTa1V6MTBPOFF1aVZKWC9XR3JLUDRIenp5Y0pZcTFNS3Jp?=
 =?utf-8?B?SWlwM3hSbjEvbTBsc0ZJcE9lT2YxU3gwblYxUlF3RFdqcHZIQldlQklNdmwv?=
 =?utf-8?B?RUhBTnZDankyVStRbWJQYzlmaFNpWG9tOWd1cDgyNk12WnFhZWw5bDJjVkdS?=
 =?utf-8?B?L3UrNVpScnJmQklaemdweFd4RU95b1N0V285ZFpBbnVtaWtRY2NSVk52Z3h0?=
 =?utf-8?B?cDRKVkduLzdjNjh1Ri9yN1Q1bnI2WGJTVTZzNFpyZDY0Mmh6VWJBeTZCdWZO?=
 =?utf-8?B?cEJ3RmFBd1MxbC82R0VpZkdIRklhcHY1dDFSdC9FMHpuVTNjRlNFRUo2dzc4?=
 =?utf-8?B?ZFdRNjZtSXdpbFNLQzViOHJpRC80c3JiWnJlcGNrTE1NMmFHYndCdFFXaCts?=
 =?utf-8?B?MFN4NHlmdlhuOW82ZEZ2YnVFS3NGd1NBVWJkUVoyd0N0dnZxTlB2OUl5UkZp?=
 =?utf-8?B?eE9SN0hlRUxFTFJuZlVGN2dtdURadnlFczRFUHdqbW1vSmM2eGVGcWtrYVhI?=
 =?utf-8?B?VjNyMGp2Z1UrdjRJQnlUQ3FxT3c0SEJhRnNKUkVacWNBZE9FSlFNV0daV3Zo?=
 =?utf-8?B?M29yc25UZGU1Q2ljeDAvaXlGeXpxUWFRNU1rVUhHK25ScFV1bmhFbU5IMmVR?=
 =?utf-8?B?a0ZMN3RkZ3BFRGFoaThyd21vaXJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5969f0-fc44-49c3-2386-08d9e4d502ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 16:16:17.8296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbOnuy2PPkc4bWqNGOkial6qdSBEtoe8+Ca2yLXGso73qhWGKnxSlRBjOvpbwynSj5zTQkx0SOUYrMlRSmVW0ZJSYLwUCYFkWieBXzL0qr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2848
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-01-31_07:2022-01-31,
 2022-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 mlxlogscore=797 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201310106
X-Proofpoint-ORIG-GUID: U52iR2Tb-BxgAt8jdDqvvLGCl3BjV_Nm
X-Proofpoint-GUID: U52iR2Tb-BxgAt8jdDqvvLGCl3BjV_Nm
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=889 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_081643_369992_19135CDD 
X-CRM114-Status: GOOD (  25.80  )
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

DQo+ID4gSGkgU2FnaS4gVGhhbmtzIGZvciB0aGUgY29kZSBzbmlwcGV0LiBJIGp1c3QgaGFkIGEg
cXVlc3Rpb24gYWJvdXQgeW91cg0KPiBjb21tZW50Lg0KPiA+DQo+ID4gWW91IHNheSB0aGF0IHlv
dSBkb27igJl0IHNlZSBhbnkgcG9pbnQgdG8gc2VuZCBhbiBldmVudCBvbiB0aGUNCj4gPiBkaXNj
b25uZWN0IGJlY2F1c2UgaXQgaXMgYXN5bmMuICBJIGRvbuKAmXQgcXVpdGUgdW5kZXJzdGFuZCB0
aGF0IHBhcnQuDQo+ID4gRm9yIGV4YW1wbGUsIEkndmUgb2JzZXJ2ZWQgdGhhdCB3aGVuIGNvbm5l
Y3Rpdml0eSBpcyBsb3N0IHRoZSBrZXJuZWwNCj4gPiB3aWxsIHRyeSB0byBjb25uZWN0IGV2ZXJ5
DQo+ID4gMTAgc2VjLiBBbmQgaXQgd2lsbCBrZWVwIHRyeWluZyB0byBjb25uZWN0IDYwIHRpbWVz
IChpLmUuIDEwIG1pbikNCj4gPiBiZWZvcmUgZ2l2aW5nIHVwLiBXb3VsZG4ndCBzZW5kaW5nIGFu
ICJvZmZsaW5lIiBldmVudCB3aGVuDQo+ID4gY29ubmVjdGl2aXR5IGlzIGxvc3QgZ2l2ZSB1c2Vy
IHNwYWNlIGFwcHMgYSBoZWFkcyB1cCB0aGF0IHRoZSBudm1lIGRldmljZQ0KPiBtYXkgbm90IHJl
c3BvbmQuDQo+IA0KPiBXaHkgZG9lcyB1c2Vyc3BhY2UgbmVlZCBpdD8NCj4gDQo+IFdoZW4gdGhl
IGhvc3Qgd2lsbCBkaXNjb25uZWN0IGl0IHdpbGwgc2VuZCBldmVudCBhc3luY2hyb25vdXNseSwg
c28NCj4gdXNlcnNwYWNlIGNhbm5vdCByZWxpYWJseSBkbyBhbnl0aGluZyBiZWZvcmUgdGhlIGhv
c3QgZGlzY29ubmVjdHMuDQo+IE90aGVyIHRoYW4gdGhhdCBJIGRvbid0IHVuZGVyc3RhbmQgd2hh
dCB3b3VsZCB1c2Vyc3BhY2UgZG8gd2l0aCAib2ZmbGluZSAtDQo+IEkvTyBpcyBnb2luZyB0byBm
YWlsIi4uLg0KDQpJIHdhcyBqdXN0IGFza2luZyBmb3IgY29tcGxldGVuZXNzLiBTb21lIGFwcHMg
bWF5IHVzZSBpdC4NCg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQo=

