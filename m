Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8368FD6553D
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RYHtKz85RChVYiPdXOtVbdlx0B403vdfdqO7VT3fd/Y=; b=2Wkab9HYiGKQVZCIDCotO37FPI
	WXpSQdGSGhcYAbMahm9IDFVWsBMIiUVW6ZfmrQq+4pbTXAMxAKjx9xrV0AFrO6BN2/wGB+jJjHFgq
	FNRkZkWIxetgGJwpbzOWWJpRQCoZ0oRqFB1Py3WO5f9bX33mW6pHJPKk1efQFjwS+ar9Kd0y3c0vd
	aLLvXC/gMidDBlSP+VxkmR3H/h2v7gfr8SARJaJz8fWZEIbXhKaqByj5ND3dOhTLSnDXOXh3hU0L5
	Au7BlZeySEHPxd04FThwxG0LkUoe03FXHsMgPZT5rB+dCfnD49siZbXYCqXjL79tpdBm5Rb52rpUp
	OQP1ybrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFzxq-0000000BNyy-3bW8;
	Tue, 26 Nov 2024 18:07:06 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFzxL-0000000BNtH-3276
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 18:06:37 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQDLUXR023220;
	Tue, 26 Nov 2024 18:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RYHtKz85RChVYiPdXOtVbdlx0B403vdfdqO7VT3fd/Y=; b=
	mgvT+rUW5MolSeZGGMqL+FEpKMd638QVYtx0E4M2E2JKRxrmDLEowX5/CGLT2FgR
	DJC1naKRjtZu0KyGCVaXCVrjiRxi2QvFQ4irlTUXw1UhNdLd2OYwevL/sgt2fftg
	MMILnU4XfJTEn4qR53DQD1Zhki9i368cEWtX15LOIbelBk0h0jPbz4ZO1kMcIJO7
	Uq9uoGh1ccAeulyiLaAcG7Jsi2ioAhaCutjK5pDNxyVMfmC6x7x3ADs18Opfe7K4
	VJBqCnhvPHCGwjVETDpWnh4Glm8oQRAy5a/w2+QwmDq+6M5P4lby2WODaksOwyPN
	bn1XMM5gS+MFAWDnSOfl0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433838p6vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 18:06:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQI0Z2t004482;
	Tue, 26 Nov 2024 18:06:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g99hn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 18:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM38rCgL4r21vHGfnZWQOgTgJ10kYaP4jzcxSKtsvcHSjeTc2LwE2CwSxvYZYPVjYkuTAsdUrOqhylQ5zSI2Xt3FqBOQSplrfdicjaM37w6gl0+iJonkmHK9zLNB8RCk+KOQXQFT6WFPVIPWtrNDyNXI/jF3gS8e51akK/n6gwEnLmbpOgqrQtHqNFJI87kp6d2NJ5eyVTOKmI+kOuqIWXj9rrslKUpWTMkKzuxk8usyt9PbR5RxFS2MQR/t09codKEz35pt7Fg8vSk46PziYgfgV7W9+YNoItsYR/+iuW3IbaxE74QgECl28Pbk02dsblb0snoQRRYj2meaIX/NJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYHtKz85RChVYiPdXOtVbdlx0B403vdfdqO7VT3fd/Y=;
 b=fpUBcwMQ6YlYxeDSeZhZnDcVRBRA8wzHYK6JhedoG0LKoenlZrkhr52OUmncrgg3oL12zgFLSBlsrG/wg3WdlqvOCqDrXvMg/Lt/JkNgfCPMEJrb1Fo+4cLSHXvg/6Eh4Jtt7KtBAmZJJaYRULsWmvB2D9km0As2T4KF3XaQasGWao+VMdNV9IyX+Nhs8fMMGJSh835Y6vkqluSoOJ+WuXX+guw+t/DKk+Cj7cNTA7xeMX0xSkHvCNwputTSdVHkm/Eb5h2Rlcqbzc0TWMhITAWWw+mdsikn14PJBeWd+yqNDe/j71/XVkzTbQCMa2cbfxlfkz99HIt7bxqfhQJomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYHtKz85RChVYiPdXOtVbdlx0B403vdfdqO7VT3fd/Y=;
 b=YOrV7B3mpvd1i9t+jbzAmrXUqzS2/PyRa2/RbR1rt68JQqhEo53ncA1ro6I6trUkPssdNk2K8DLvyoyyd/s3u/CIncI7h2yz6hQk5lOsyWwLBcRDn8OCpZfMxqSNlXbxl+0DJ4OjY4VJe6yiImvF87FjQwpbYj3oJTGSmSlK7Zc=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 18:06:19 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8%5]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 18:06:19 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Paul Webb <paul.x.webb@oracle.com>,
        Jens
 Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>,
        Chaitanya Kulkarni
	<chaitanyak@nvidia.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Ramanan Govindarajan
	<ramanan.govindarajan@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Nicky
 Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Thread-Topic: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Thread-Index: AQHbO5QQcHjoRAVwOUOCdWnBaPnbU7LA2Y0AgAAWUACAAKqmAIAAN3YAgABpoQCAAP0BAIAAVT+AgAATHYCAAC1mAIAEihoAgACvVoCAANzGAA==
Date: Tue, 26 Nov 2024 18:06:19 +0000
Message-ID: <D00AC7C8-8371-4629-BA39-E0BFB9975195@oracle.com>
References: <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
 <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
 <20241122121304.GA25877@lst.de>
 <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com>
 <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com>
 <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
 <CD26086B-67EE-4A62-AABF-3068252B158A@oracle.com>
 <20241126045557.GA31032@lst.de>
In-Reply-To: <20241126045557.GA31032@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|SJ1PR10MB6001:EE_
x-ms-office365-filtering-correlation-id: 2ebe3922-2596-4b61-a9c6-08dd0e450756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N0I5YVVVSE4xaGtuNDJjVmY3VWVnT1ZhZEd3OVB5RU4wcm1GK2krRWdXRXRB?=
 =?utf-8?B?ZkFOdXZhSk51Wk9uZnMwRUYzQWR1Nm9wMDdLRkpMckxCK1ZtdUU4blJPMkM2?=
 =?utf-8?B?NERHMlJtUy82MWFOeWVGdUZSTGdPZGRNVWlLeVlCaVJDN3R3V05PRWtOempt?=
 =?utf-8?B?U3BDbUpsK3REMlp5YTBWdWRucFlKTE56RnNTcDd6b0NiUHhyY2RraVNzb2dE?=
 =?utf-8?B?WXhKUm81bHNqeHFPdmRaMnlYVG1CdmlDSlZzbHJzN2VCeGJ3eUttaENwbTJF?=
 =?utf-8?B?L1J0Qm4wZ1NTeWY3bExpeldvajI3VzBBOVA4L1hyV3Q5QmNYeDdPV2VyWVpq?=
 =?utf-8?B?RjJnL3Z3UUZLblJjSEFUOVkxczRxaEN3ck55a1lFb3cxeFRwT2pRd3FMMmVW?=
 =?utf-8?B?MmpnbjVrdlN5a0pTOGlpaGg0TVAxSWNCc3huYm9OSUtTSWZ3ck5zSWsvTmY4?=
 =?utf-8?B?OVptMlBCQmozcHlUUDdDSFdXUEQ2cjMxZHg2cDdrVGhYNTBIcEpydzMrYlhF?=
 =?utf-8?B?alRGVWg3akI3d21YaHNpdFlhOG51QXFGSXZHZHN4QjcrMDBWMGpNS05VZnVH?=
 =?utf-8?B?QktOQkQ3SmFpT3ZPYU5DdWx5Z0RiZERURVVIYXA4TEtSVFhoaXhZcmVMWkdG?=
 =?utf-8?B?V0p5TEpHeGxZaHRtZ0p1WUhXNlZkQkRCdzlIUm84ZGx5bTh5WW9QZTgxeWVC?=
 =?utf-8?B?SUxMeE1ob2g5ZGxWT0NiOXF4dTJ5elJ2U0tseWZ2T3JtMGc4TDlCQUNLRWhH?=
 =?utf-8?B?ZjFiV05iYnFUR0prNE1wR3BZTnAzVUxCU1htT0dXSTZ5cDE2RGJyTnc1ZVFV?=
 =?utf-8?B?RkN4VC81d1g5bkNNRFpPZ0p6ZENXOUZRSkVYOHNlNHducEh0R3NjNU50cExV?=
 =?utf-8?B?d0RVUlIxQUk2SkM3dnM0emZDZFpua2FuRVVLMFRkT09YUjZybnBkVWtBTk9E?=
 =?utf-8?B?aGpnVFpVNVNCRURQYUVaQUhGeVJsci9JTVlqWWp0VWNnanBDOWtWTllIUnNt?=
 =?utf-8?B?bWF1anM2TUk5ZE9rNnppcnN4MEFIUGpuNFY2VE41cE1ZWklNeWhDV0toZUhs?=
 =?utf-8?B?eU9mWjBHbGlmaGgwU3lIdzlwa2NYUFJTWVVLVmJmRlJpcS9KQ0ROY21WM1Uy?=
 =?utf-8?B?VDdtRmU5UUM1Qyt3VXZ5T1lGOFMrb1JMNTM0SE1ULzJDVDB1OW8zcFVienRO?=
 =?utf-8?B?TVlMYWozdXJOTTVib3BINGtxbFNMa3pzK3Z0cjlvYlJnMWMwV0FXellsUDIy?=
 =?utf-8?B?eUhCOVFOSHdWbUgxcXQ0bHRkYWRwdTkwSlhybTFoTWc5UG1IWS9zRkk4SHZJ?=
 =?utf-8?B?a1cxakhnZ2ZaYVVUbE1kWCsyZVpmVDFSTDRaRFlTOFhJYTFobHFCS05uaFFY?=
 =?utf-8?B?bXN5ajRGUCtpSXgxR0hPMGorbGlySlZEcmQ1N2hGM1NWSSt6cUpSRFY5SXBi?=
 =?utf-8?B?RllsMnFETUJKYmFENVY5U0J0SFFpeVo2WUZ2My9ZRE81ZXhvVlE1d2ZYb2Ux?=
 =?utf-8?B?VnB5Z1dUMHFHLzdaYkZvc3pvRmYxb3N1K0FLOW1oZE41MFJJMWkrUThGQ2pn?=
 =?utf-8?B?QUhMZXJFemE2THZvbmt3aFY0NHV5cFV3M1RHNEw4bXJVTkE1dGt5TUpQZzZ1?=
 =?utf-8?B?V2hjSnJEK3l2U0FWQ3ZBNUtRWGNKYjBhY2RaaFR4R25TK0VQUjR4UEQ2NS80?=
 =?utf-8?B?TUN1UTFWNTRZa1NRa2FEM3NDWTgwS2NjWmFOTy9ncDdkV3NVam5hN2FXM1hq?=
 =?utf-8?B?NndKSGVSUHhpNmVJOEU1OERlQVJBay9ibkZvMXU1bHpzNTJ0OXVvZjZJdGhB?=
 =?utf-8?B?NnVkZ2lVSDhmamtEUkVzU1c0VFVSVzRSNnFnb3BXY0VTOU04Z1RXd1FMd1N0?=
 =?utf-8?B?YTc0b1VTTzd4bXhYNzRLK0hkTEpyYWFtRVQvSmY1NUVoWWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0xEL3VNdGduaW1sM1lJVE5RMW1VZkxPSlovVDhOQWd0bnBNTkdHNkZ5UldC?=
 =?utf-8?B?aDhkRE9xSXY3WkxPQStLWjN1NjZXYWF4bFlxSWJGL1pTNTJFcjNQWVkxbktT?=
 =?utf-8?B?OHVuR0lzMGJPN3ozNEJHYTRrcXBhSU9od0VHdjVmNTRVZ05WeXpiQU12ZkhW?=
 =?utf-8?B?S3hGZUZoOHVBTWdpSGRJTUozMXlrcEJ2QmVWNm9kM1pVUXBTWE5iVWo3V0x1?=
 =?utf-8?B?YWNaekNoeWp6UjhDZWJ4SFpaZDBqVTJkdU85Y3MrY29kZDFuK0RHcTE0TVpa?=
 =?utf-8?B?YnBIZkFqbkZrYnpLS0NTdXBJaWpVcEtNaS9qMXNoR1N2d2FkblRyaStEQzhT?=
 =?utf-8?B?WVZRbDk0NW05dTVRbXhjTzA2enRKYVQvcThyMzRrRXNRQUJXVTFzbDdzWUNo?=
 =?utf-8?B?VG5CQnhWbVJrQlprZDJCcjBsUzAyNTdSbGlUV2JvRWdLZlE2YVZhRlJ4SFhT?=
 =?utf-8?B?ekNOWEoxYUl2alU5UDhNbkQrQTNxNjdsMkhiVSthWm1WeHRIeS91UWtzMFAr?=
 =?utf-8?B?akEyWDFWNGlQV05ZN1BqbkkxcmZRd2dGM3N4eGh5dDFLczdlZVFWTWhOZWJB?=
 =?utf-8?B?Sy9OTGphT1NPYUNGM2dxSm1tSHV4VWFoNXRPdVlqSmxFUFBNM2hpYWJFVzZG?=
 =?utf-8?B?NDArekZhSjIvZGpRVlI1NWJFZFhDZ1B0eWxma3czbWM0MW8rQWtDVWtvbTV2?=
 =?utf-8?B?UlUwaTVQMVF0dG5VTlAvSmJ5TVduRmJ4M2prbzFib0tnRUpVT0xoT0RrUEsx?=
 =?utf-8?B?NlE3R0VTcVE2dUZCbUROc0R0REh4OHRGRnpzYSs0WENkUWhMWkpveG0zQnpq?=
 =?utf-8?B?blZjUHRCa0dleEpYVDYwL0EvTjZpY2V5UkJ0bC9HUDlueGNjNnovdXY2TWRS?=
 =?utf-8?B?bDVwZDhYaUVxTURrY1BacXhPZEhmc3FRT1MwTmZiSFpjcENkajFwd1ltb1o3?=
 =?utf-8?B?YzJxdkhHWHIwSGNiMlpRTXBaK3JrZllZdlk5NlQ5TjJSOWVVL1B1ak5nWTdq?=
 =?utf-8?B?TFI4VVorQk9Ta3VCT25VUDI1eVBCVDdnS3hOYXErdEc0ZjUvd29PZXYwbGlz?=
 =?utf-8?B?bjNtaktTVTZjMkV0RGZ0YjA1WHg3em5lYWJ5cCtvN28yMUE3L1F3QjJOQzZP?=
 =?utf-8?B?SStOL3V1ZGltVU8wZzgwM0tRWThhRFRmSmZCZjFvcXgvVHoxQTJPQlRPSFZa?=
 =?utf-8?B?elZ0WVJzczZxUFU0Tm10YmVPRTVqTUNxN3F1aE1rQjl1MDZLQkxjd3djaE1n?=
 =?utf-8?B?QlJQWTExQ2czWi8zODk2YVhWV3QrQllwd2o5Mkh3WlRYd3JjTnkwa0h4bEps?=
 =?utf-8?B?WE5BcWZuTTRxamVaZXl4R1RsaGR6aHZDaGM0YnJITHNlcVFaODducjJCZkZ0?=
 =?utf-8?B?emZQVkh6OEZuWjluMjdIcS9XanJjcTBhMWpMblhMK0w4alg2d2NvVUhWay9J?=
 =?utf-8?B?M1VzWVRuTi9QSU1hempiV01DcDBsbisrdHJ5czZuU0MvZXRoQlBzNTVsTEhN?=
 =?utf-8?B?bVJPSzEzTVB6TmhBaGg2d1NrL08wa2htOUt2Z1BFU1lZTVZuSVAzelVlK2Nw?=
 =?utf-8?B?QjZZeHNTblRZYWlHNzNqWjZBdlJqbVFOVnF0ckVWMkJqdDdqT0ExbU95c3FM?=
 =?utf-8?B?SVZMUU1FRW9LTGh5NllLMHRoV0hZZm41RWYrbDh2VlE2RlJ2N09lMXE2OGNn?=
 =?utf-8?B?Mkc4SFJid3Zhb2UwLy9BcWw4TTEwK0czSk4vbWtEVXJQMUFPU3BtcFA2YzRH?=
 =?utf-8?B?R0RBeWs3L2grcmxjRnpXSGs5RVRsZ1RnNDVpZFlwdFE5VzlxQzk3dC9mTnBY?=
 =?utf-8?B?Wk9LWWRDdnhHKzhHSm1lZFVnbUtxb3h1TVlRSStZSU9WbVNNUSswS1ErSzZL?=
 =?utf-8?B?SU5KNG5GU29ITDE4QVBpcmFxQVFLUUNLSHdGUnZUVFpCWHdrMmhkcDZ5M1dt?=
 =?utf-8?B?cUdGcHVyK1JrZFMxbG9DOXRoYTI1cnBsYjN4aTZjUmd2S0ZJS09STVRMKzlE?=
 =?utf-8?B?dENlQVJVcG5wb3V4eFVlbm9Wd3JvOUNucjdySlhxUGxqeFZmSEJUMGFneG1K?=
 =?utf-8?B?bU52eVhrbloxSlBIdUs2MjdORE1zaWRqeEJXcG9LV2tyK1VxMkc4ZklJNGVh?=
 =?utf-8?B?aWZGVHl1QmQxbTE2Zm5MQUJpVDZvWkhPUm9aSURJK28yWWhNWmhKZU1hNS9k?=
 =?utf-8?Q?pqblICMKsepKXMOZ6GOXmLI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5C8258EF2F078469D7435C0E9244D34@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZPMiLPnt4vUTXEj2gFtcJPHvZXp3YG/66HhEuTkBOasJMCeAMSL7vf/PcJXy39ZjzLsmDZHMaLEc7UPVfctWDFKY6DMelzwhQpoh7f7dLA2BWVjTh8A7vyJGh9nOD/zQeNg80ZYcDsBr6P5XVtKfXimP0ypHpHsX2ick3WGBONPgLXvMzflCmxRGE+emI0SK4zVK6Dfakq7CO0/ho7/4ktD6jzTIAnHpsNgszBoe4WEno3y0ewb39gHmkNBSMi1EOgx8/PVxTLbaxwzVR4xbKvlBqHMKciUskkj1xgwChfdJqJeSVcFO7CIlGK2L8zzqHQAAA4Wkl1GNxSCkQj1CpHqVhSblZ869olfOhW3ssOVFaZWU6yxTbcUOASBRiJlJqyF8bN5uX7n24NCPR/DIBsxhhH+1Ut6A4KTiH2Re5l4O3ly750zBgajubOL/KTKX73gPYn9Bxexx0O7OdUepikh7yakvm7bp4LrdNe48iQOLJRrfQVsgZH+sJGB/2InW5u5tKBRJkjpT0sizx71xnpQAE2f0wvl8iWDmlMl2h55trytabD5hNfNDz1KHk26NNobk467oKWQO1eHJ5HiuQike4CRixAkMUfTRpFWD6Gk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebe3922-2596-4b61-a9c6-08dd0e450756
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 18:06:19.4689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qO4dE2RlQJu674vRBFn0MQHh7iyVqr+b5yO9pozo4CVIU7U36NkxTnMkaLbakd3EJwGoMNwY8TSdjOk4L74i86uislMxVlK4kbrNHQbVJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_14,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411260143
X-Proofpoint-ORIG-GUID: qioAyKfbNbmLYchQMT8tpD4ErtT7x8m7
X-Proofpoint-GUID: qioAyKfbNbmLYchQMT8tpD4ErtT7x8m7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_100635_927051_953D720E 
X-CRM114-Status: GOOD (  15.75  )
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

SSB3YXMgd2FpdGluZyBmb3IgdGhlIHJlc3VsdHMgYnV0IHllcyB0aGF0IHJlY292ZXJlZCB0aGUg
cmVncmVzc2lvbiBhcyB3ZWxsIChzbmlwcGV0IGJlbG93KSwgdGhhbmtzISBJIHRoaW5rIHRoYXTi
gJlzIHRoZSBiZXN0IHdheSB0byBnbyBoZXJlLiBTaG91bGQgSSBtYWtlIGl0IGludG8gYSBwYXRj
aCBhbmQgc2VuZCBpdCBmb3IgcmV2aWV3Pw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQppbmRleCA5ODM5MDlhNjAwYWRi
Li5kMjUyYzk2NTFmYzk5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQor
KysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCkBAIC0yMDQ0LDcgKzIwNDQsNyBAQCBzdGF0
aWMgYm9vbCBudm1lX3VwZGF0ZV9kaXNrX2luZm8oc3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1Y3Qg
bnZtZV9pZF9ucyAqaWQsDQogICAgICAgIGxpbS0+cGh5c2ljYWxfYmxvY2tfc2l6ZSA9IG1pbihw
aHlzX2JzLCBhdG9taWNfYnMpOw0KICAgICAgICBsaW0tPmlvX21pbiA9IHBoeXNfYnM7DQogICAg
ICAgIGxpbS0+aW9fb3B0ID0gaW9fb3B0Ow0KLSAgICAgICBpZiAobnMtPmN0cmwtPnF1aXJrcyAm
IE5WTUVfUVVJUktfREVBTExPQ0FURV9aRVJPRVMpDQorICAgICAgIGlmICgobnMtPmN0cmwtPnF1
aXJrcyAmIE5WTUVfUVVJUktfREVBTExPQ0FURV9aRVJPRVMpICYmIChucy0+Y3RybC0+b25jcyAm
IE5WTUVfQ1RSTF9PTkNTX0RTTSkpDQogICAgICAgICAgICAgICAgbGltLT5tYXhfd3JpdGVfemVy
b2VzX3NlY3RvcnMgPSBVSU5UX01BWDsNCiAgICAgICAgZWxzZQ0KICAgICAgICAgICAgICAgIGxp
bS0+bWF4X3dyaXRlX3plcm9lc19zZWN0b3JzID0gbnMtPmN0cmwtPm1heF96ZXJvZXNfc2VjdG9y
czsNCg0KDQpTYWVlZA0KDQo+IE9uIE5vdiAyNSwgMjAyNCwgYXQgODo1NeKAr1BNLCBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGxzdC5kZT4gd3JvdGU6DQo+IA0KPiBIaSBTYWVlZCwNCj4gDQo+IGNh
biB5b3UgcGxlYXNlIGFsc28gdGVzdCBJIHNlbnQgeWVzdGVyZGF5Pw0KPiANCg0K

