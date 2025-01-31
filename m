Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955ADC02193
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 18:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NWv7oQwD8tcCeCnTxaoejFgbNxCqEVNhh2CKrX/BQlQ=; b=E2UVu9ZXp3eg9LzJ5s/nbkDsy1
	G158+p/y7190bm080dyJffEl4BiKIM/5tjB9ekVCPnLMLszh6U4WiVufNcXsbGamC3DSVUqQ4DYWr
	6oKYpMtxt3McFRF7ncA2OSIbLttHYvgTUvle/hDyJmSTNRENpEmy6S5vNQq08RqZJ6lrE6rsreKhe
	kLHS/8ZUnW1zti0qJRuruEMmQ/6ujiQ8UeL8t/djxM6DMI6CsJn7lPGXQcmbsCzF18iMq/Krn4xXH
	yc/KZ5Fja9FgPLTWxCNI5lVG+SnD/n83X4zGxR2cKFQsoIu652HSV29zcwVCo5u9glCIKkW43XLDO
	2X+JBEtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdw4U-0000000BFQL-1pgK;
	Fri, 31 Jan 2025 18:48:54 +0000
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdw4R-0000000BFPQ-3Hqb
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 18:48:53 +0000
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VHSa4l027599;
	Fri, 31 Jan 2025 18:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=NW
	v7oQwD8tcCeCnTxaoejFgbNxCqEVNhh2CKrX/BQlQ=; b=JP6Q6X9NuZgrB8tR2G
	+uOMaOWrDqNOAP3OBHvOhhjV0zN4j7l57bNrCCkgaL14RiccRkpwSLbH37Iy9cmw
	zZ7wODHcItL0ZuD/9bOEmNMUio3jFwDyI98ZEpkws8t1NYOT60RfShLNuA0SNJW7
	53p8DwfwCl3acRcfloLI0lkuyhhdgiPcmIHV7lkfLdKRCrPUCcU8OwaVZHq7vfAe
	1sOmVPbhSsFUyzrQKuiy/rfe2AVKrkTLnVNWoqaAfXxwG9CfjFg2ZxF50FoQ+bSJ
	AXLjXQAN3xJF+lD44kjHJQVA012NhuMA+BCBgmsY69QNjzzVcmuWEQBYtOVechly
	eVmQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 44h2y08gk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 18:48:25 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 4B307D1F1;
	Fri, 31 Jan 2025 18:48:23 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Jan 2025 06:48:20 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Jan 2025 06:48:18 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Fri, 31 Jan 2025 06:48:18 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Jan 2025 06:48:22 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyqnOrEoIG2xelhMy99Qh6qqSBeNAGT6rSUg7aVBHVju70tij8TNCDpI1KSe3wj51j88wzCNL2BM7FCMMbrDhCyVh1vRjuczUpLA70ibAEf9fbseEGBLRaCxvSgW659ln9YKfdhUKS0S2GxoFWu69/idZbT0RvO9P06sTyoG3kRWqn05YWPvwGGcrnMkzgkCOu+pEa/fdo1/ZNA8DechHXVrE4uAOQPNhQd6q1CDkFd7HVybgZTILXroIUo4hKk1kW2M2QXJCl+XN6u0+Q1MBuaQh7AH23yyh31TabZl8QHGkAsbnqKs/GLXRiVjSfQD5+8n+OgBsUJF9GnEik+nSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWv7oQwD8tcCeCnTxaoejFgbNxCqEVNhh2CKrX/BQlQ=;
 b=ZKmYOudUtjeKpLiNttzbL9Mz5Xdv8kEwXr7fphU3yjjiEKzQEGn3jkL3sfDtZB745qsHG/UbY9us9t/qgueklsjfq1eNMZO4mGpMKK85bTaA4YlQqzXyXditIZ1GoBtiv0O1oVtnF6tq7l1l1fUv1gbVOL0v5ybLvfJhwVWEr4X/oMovToX5CZN6PIREq+xIjTyDiCLrl70ERg/aqTcyAgWnQoX9AwQzSE7prffr5BZ50me2IeZ2VRVMz/P+WiIpew9zJexF4L23qFuKhqrR8vzf06NE6ZFN99jNLHxM6f/xE9NWB12f4JM0McfGpcPm2V4Flg+T5OlHonySmf3bTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:166::10)
 by LV3PR84MB3663.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:21a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 18:48:20 +0000
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836]) by PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836%3]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 18:48:20 +0000
From: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@infradead.org>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Mohamed Khalfella
	<mkhalfella@purestorage.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "John
 Meneghini" <jmeneghi@redhat.com>,
        Randy Jennings <randyj@purestorage.com>,
        Keith Busch <kbusch@kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Subject: RE: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Thread-Topic: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Thread-Index: AQHbc8Iz+czm4vBBUk+Is19CrVgMobMwnnSAgAAZaICAAFidgIAAKHjg
Date: Fri, 31 Jan 2025 18:48:20 +0000
Message-ID: <PH0PR84MB1358752FEA88D5EF0971B27E98E82@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
 <Z5yYk7vHIhMfiPz1@infradead.org>
 <527f476b-18e3-43f9-98c3-d19a25a6488a@suse.de>
 <613065bf-ad13-489e-9d57-408684e85923@flourine.local>
In-Reply-To: <613065bf-ad13-489e-9d57-408684e85923@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1358:EE_|LV3PR84MB3663:EE_
x-ms-office365-filtering-correlation-id: 36b47b68-6cb1-473c-f792-08dd4227d526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?X42MGZGrneMwa6diHWCvtVhYvkSJ5I0wRHcGLaQ3Qxa9k7OP+NqOHDhaHhj8?=
 =?us-ascii?Q?dhr6t0uHTGkmZ9Pi3cacYm6wu4zLrqdi/xGxMoUSEWeyESzJ2DE6ECVh4MfA?=
 =?us-ascii?Q?e75fHkOgijMjo4qVV5QTozzf4X/0BACX++I0xHfy+H2vNXH/r3IpddyoLtZb?=
 =?us-ascii?Q?AkWe1/684W9TX43ZC2Hl9MiAEqXdcqJi0DObTbg8yChFBFFdTILtTTG2z/Ax?=
 =?us-ascii?Q?9WYTuRSQLCFlOWX4f8Hje/MSsr4ckWuAbz3ae/0sDIj0WMd89wU0noau308J?=
 =?us-ascii?Q?Pr4oIcmM91X6pYd3z20frYfE4Mq3/huaFJm37jp44BSRsLh2eySh+FecrRTK?=
 =?us-ascii?Q?3unLC2aOeDjcnsdB8vMA8+FljTkIzKMmjFVQ/LuJnbqoOZIjoZB3lfcsVSuR?=
 =?us-ascii?Q?TDhUOi9FGyhC12nkD0CWxoEhabntcldS8OK05gmpDwQdMMkzZtFbdyqLLc/B?=
 =?us-ascii?Q?L5eIJ8eR0TlgYJxOVHPDtJ6baECRzy+X2iIapS2stxMzvKq0P1VnkNve9EdP?=
 =?us-ascii?Q?hNce3c0W/Y0SOO+KhQFv1/KZKILrUvXQ5E1CkK2yr2lQ35+w+5+GpbgZKP+C?=
 =?us-ascii?Q?hbSV0KONMTtK8gXZ61g0oh0FANQndhmgXmrTY2JfwI1De+UaSNBRofHC19Hs?=
 =?us-ascii?Q?Z19H41X0KcjzyUOiOc1UbflQZd3LX9xrThkwZh+wbN619ZZ7kQj6KuugMw/0?=
 =?us-ascii?Q?+t5L90FS+cbUlkKy3naQ97FDxJDH1rttdcQnGgky5KycVNIHwlxDDfTkDOqf?=
 =?us-ascii?Q?smRE8ta3qz4AejrIp7gqvsZjpJH/G53a/1kcvIyqtyh0/Y26tKOnCXKWnPgw?=
 =?us-ascii?Q?B/pTjYGVvAvYRpmblNLkd1CmuHbFZ1HuEd3yDyXdHwHVRMhE2UsQ7UJqXZGB?=
 =?us-ascii?Q?XExFsw2SUgSopzzu1k/1JhxvUBwqrIff4g8SzXsBQVfNuCDmrsl0ZqbxwCiD?=
 =?us-ascii?Q?UNnBYVNJa8qI0YE3I/TwMrzFwvdt5FnDiGzK2Pe062c2K0BybJDGj/lQa3C8?=
 =?us-ascii?Q?os6f/DZ1utl0kVwDlRRGdTyDYSLDoUbZzBXc35+sP4hBRIRvZCf/tODyEaWc?=
 =?us-ascii?Q?H5yEEAPWH0cxRbn/LP80nFK7HAnlQHPHS7VLRzB4mDeIrIP5x7D93CJYbblt?=
 =?us-ascii?Q?OfbMOj8tacw9NQiC1o2axMALEnqNNSE7bojaLwIXaHkO+cj70jndL4Yf+m4q?=
 =?us-ascii?Q?ZhnoRdMWdFwj5V/KpCptyJAPNgZjb+iUTcoHrjxHGx1cCNFxeGKc1R+rDVoB?=
 =?us-ascii?Q?PtPuCBwBKXFsCpnxU5D5qSHR+eKtWog2nqyzs7VmpjJ7ZsvPZUOS9FTRLlKe?=
 =?us-ascii?Q?rQ2D33AlKejNZO/ZDkyZ3eSBR32UcdaVbTsdEohnEG3pevZI+4B+gW+3FfR+?=
 =?us-ascii?Q?nA3deKimU73/PZk7NamWo/zdGgW31MuN+LCetiG6ADPrr0h91t2jBf670CKG?=
 =?us-ascii?Q?cW0PeHd+LIyUP551jtfP3zZfRwi/2ezn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ju2PKIYBnw/ttvB6qn+J5AQG+OGaSv3R7VXJF7LeLPG8T3o1vJnGx28EzNgh?=
 =?us-ascii?Q?c1z54+uwp5lvGL9nmpMPX4TephMKWpkxrCxc9Q3tMfVA8mUBQ/P9AdhRbmKw?=
 =?us-ascii?Q?tNm99KLstHDXki06qZVntLaGP21TEtVzsQ1E0DG4KcbCPCWj+Ej6kiV5YJ9+?=
 =?us-ascii?Q?/gByrRgKeTssKdnZ7et531wb4IV67DCdb9u5d1gfZU6IY4KI1WrsZX0Polf2?=
 =?us-ascii?Q?vRZuG/ISjm/eJLZQbG/OUUTFJ9UYyW05zE1wrRAftVLSgwzqbYP+G1CMzGpq?=
 =?us-ascii?Q?NjQZQKXNHIBeRZH77/SN4Nd0yc1tB1Qy+AuXiCJHKsrSdmszvAtzfp5K+KMy?=
 =?us-ascii?Q?0zC+VK+RqAakhOuWdoB0R3PcZ2ptcJi0XqHfnr5dgPtqiOL3OIHdSllTEtWt?=
 =?us-ascii?Q?hfOhEAvKsvkZHidu9LaM1pmYaFK/Us0qay/dwJuOtJIOsND4PSWudDlwlOEY?=
 =?us-ascii?Q?wi5kuv0A33iAj/8j83SCxSa6boVC2lAtrDz7A/9R58lSCJ8eKNYc+m56nQOU?=
 =?us-ascii?Q?9QZz7bFPrDU8HTrsSJGZ5H+YjreIPy1ceDmdHnBwgfmur0/efc6KXvu2B5r9?=
 =?us-ascii?Q?jkgt5SNYWBRuAODVx0EV/nSxO4V+/xEwRD5uaWLcqiFAihipNJLDU/JIrXcN?=
 =?us-ascii?Q?mtPS7Fz6TH74BxRq3bpR2xlZOVXVQ1zJaG1zB27MiIUKoBZCEedD3foAB3CT?=
 =?us-ascii?Q?Kew426osqQE9qDn0jmGw0VfhTwSP2XXOxvo+mt2c3Zpkn7YvLt20mL5sQbdb?=
 =?us-ascii?Q?spbtzwNlWkmW4kzOIjf5pTxdQC8i6LmHZiSicoBKVbAcH69IwfIFspQ9qeHM?=
 =?us-ascii?Q?RaZmWRYge8K3huxty6iK6lrDKokWheBc7BH9ZNA8HqpSANPX+5J2cvbb/ALd?=
 =?us-ascii?Q?u+QYweDVZFJpLhSv02Z002A6y9Wm6hOcXrAp6U+uX2owyKKdu5f5EwIiR+Ld?=
 =?us-ascii?Q?8RRQ3w8wWskSURBOmqTocnrgiiOcBAr74ZockEoPNwkGZq34d8zu6Q5bv4lH?=
 =?us-ascii?Q?jvnTyfmF6DPHJ8SMBrB4ef3pfhwUEDNxyW9L1plGob9CCIgV4G4MYwJDqQa8?=
 =?us-ascii?Q?D4xaX+u8QzXiU76KlxTGxnf7k5tA1ZGvu/6+ChWr5A31N2wF6nf34lQbHLq/?=
 =?us-ascii?Q?todXSVDQfZNI7zrxgMSY0zB6PQaZt+4KglFmWxtb93ghwCtkBcUk6aX7EbC6?=
 =?us-ascii?Q?U7ZH7HX0RB2dXBpL5O2l9SSwuJpDLgSO+KoO9xm5b7PBs8fKFV9vC7E64cau?=
 =?us-ascii?Q?qiqJ02OsTnVE/yfDonPovyEjQx1U4Ksq3WaTxE2m0OCAYsNvBti/p+G9mzhD?=
 =?us-ascii?Q?tmAvWcbbvEMGkaC47lPwfT0uIbA7ldLPR297AEwPM01USgnneLwxpvkxqUPK?=
 =?us-ascii?Q?zYTXXvV4Ga+dcu2hLf3UsJFDuuy0vJItqouTTeVNM4RpxlGg06ct+F1h1ROk?=
 =?us-ascii?Q?i4eE6C1abeOJiXn6V2qE6xbIm0e24SMyemmIASlkLeVx70FT3UV6zrWYaWNW?=
 =?us-ascii?Q?I6565lRudyDUCZ+sI9m9dRVlNe3wT+ZQKLRqADvRX5pKxIpHxB940xkvPw+2?=
 =?us-ascii?Q?wOHY2+cwKGgr9mgecys7dTmi7qruNLmITKP36L2f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b47b68-6cb1-473c-f792-08dd4227d526
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 18:48:20.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBkL8lVvaJEIzigy5gFmWTAIEqLHbN99jxchXu2WxSVag0LGW+WJoTBuQsXevZVWv6aUOG2LUwtRgqdkW76wMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3663
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: Zmsb_CEGf48Ek7zlU6TO093MIHq-bZfk
X-Proofpoint-ORIG-GUID: Zmsb_CEGf48Ek7zlU6TO093MIHq-bZfk
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310142
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_104851_932862_10F06098 
X-CRM114-Status: GOOD (  27.27  )
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

If there are specific aspects of TP4129 that are broken, I would be interes=
ted in learning more about them and how they are broken. If this topic were=
 to be discussed at LSF, that could be part of the conversation.  What part=
s are broken (or cause concern), what the issues are, are there any ideas o=
n how they could be fixed?

Curtis Ballard
Strategist, Storage Technology
Hewlett Packard Enterprise

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of Dani=
el Wagner
Sent: Friday, January 31, 2025 9:20 AM
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>; linux-nvme@lists.infradead.org; =
Mohamed Khalfella <mkhalfella@purestorage.com>; Sagi Grimberg <sagi@grimber=
g.me>; John Meneghini <jmeneghi@redhat.com>; Randy Jennings <randyj@puresto=
rage.com>; Keith Busch <kbusch@kernel.org>; lsf-pc@lists.linux-foundation.o=
rg
Subject: Re: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification

On Fri, Jan 31, 2025 at 12:02:59PM +0100, Hannes Reinecke wrote:
> On 1/31/25 10:32, Christoph Hellwig wrote:
> > On Fri, Jan 31, 2025 at 10:24:31AM +0100, Daniel Wagner wrote:
> > > Hi,
> > >=20
> > > The KATO handling in the spec got updated via the TP4129. In short it
> > > mandatas that failing requests should be delayed by some value before
> > > retried on a different path.
> >=20
> > TP4129 is broken and the TWG has been told that.  There is absolutely n=
o
> > point in either implementing it or rehashing the discussion over and
> > over again.  Concentrate on making 8028 useful instead.  And if you wan=
t
> > a discussion, "why do people people push stupid things though the
> > NVMe TWG and then comaplain later about the lack of implementations"
> > might be more useful.
>=20
> Okay, let's rephrase that to 'Improve NVMe-oF error handling'.
> We are trying to get TP8028 out into the open until LSF,
> then we can discuss that and also how to fold in the
> 'command cancel' patchset into the overall picture.

Yes, that basically was the idea for this proposal. I should have called
it differently. 'Improve NVMe-oF error handling' sounds about right.


