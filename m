Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F33CD3B7FA
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+w5IQBF9729JH5HNp6AlOJRF6S7LeY4KtKF3IpYt9RM=; b=aRkbkYWW1E9dyo80UeEBKqgy5r
	be3ofWDpQbivUeuhiFCUObcN4EOc99mQR3feZPzKjPrJ9AprXXVbuv3avFjtL2WCNOa4dxC4RmvKt
	gXDQIX/zlaWJ7urpKj2XnjJHcRG1PkUNPib78jTQXtri1VspXcZJEdnx6R/PK1eXOOnH4IrS1LVAM
	KYHQi51VLP6ViLCFNYUrF2Nu6LLg5cmv/bdvbTitWVDFN/N3WeKsUdUpHvmd3+1mzbJMORaFdORz1
	5vZWIUNdrUg3xovDXP8PNdcMGjNEt/9wHHu7vunB7czghm2/4gQFWebh9wmRcTOCkXQUmVVTMhLlF
	BxrxMjWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAlw-000000077E7-2MTC;
	Mon, 02 Dec 2024 18:03:48 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAlY-000000077AF-3mKc
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 18:03:26 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Hfg1O027908;
	Mon, 2 Dec 2024 18:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+w5IQBF9729JH5HNp6AlOJRF6S7LeY4KtKF3IpYt9RM=; b=
	DzFgUf95iowL5Hr2gB6WFyEtZ7qa2noSapiHbfNDx05alFHlOe27cGsU7E8X6WQ7
	ljLl1KiMWyqgsmg+W114hfaXjTH2TRrKJhMhZ3UO1B0xyHESWP/J1LwPFqEIbIrk
	+rj+RBWqmTXMCA8sQPEb3vJiavS1EYVJI9ro/vJ2VoraBuWy1y+N5q391S1oMArH
	BMxQaCFZenoNCaiSYjPOYoiQ0wY/YsXJhEjku+8RfM/HUwNMpybrqt0xtSqP9p9G
	Jdi77B/O9iWzd8tyx4WS9HZcTa+KPQ4dIKwD/1xhJ5TTxtn7VjDmhQGOIbdoaL8d
	LWgZLMQXbh0xSNVmfNPdxQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437u8t46h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 18:03:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2HYPAW037938;
	Mon, 2 Dec 2024 18:03:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5793bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 18:03:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnyQZBmhVjyVtHo0MjdlCim9Ge1iaidwGSiVdroibO2DlgL/IVfwPVQUfxqUS+kueVhPgnHZnUUcknWeFt5bXZnUM/kUmxdA5cp6ybHoHHBefNhKBHjtc38xjdbBTOleuvO7vSMpHoElgbKjtbBO3h4MwA66+TFHdAslG6leVBMm24HqHeI7l4GDq3w6dBKU6r75h5eqzB5c0YTbmULdL4FVUqrhB2BLpq+N/29yXDfzmKEf+KEEdqkVkhnW3G07N9rotOvZnVfuABpwmpjs9Q6O0/UalsOC7zdDCvzzOWGy+0wKcTd7sX7BBWt80xaGiL9n9oA1Qwf2npqgo+qHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w5IQBF9729JH5HNp6AlOJRF6S7LeY4KtKF3IpYt9RM=;
 b=V0O2W4HPyJ1sMqA3BY0uQySq3Ll5uXceceLVMyC+t6H654niKfPQHdI5eIIL8oZGcMVm7ijl8s/OYOERfEICYtOL7TXTo+oqRlvhv8N4Gx2w2cNuLiEm0f+S4OqSck078Vx4Mbu3XvOby4dYC1a3HTQyWUJOeLV2cIJmPfzEf9Tw31plHfTpSdTbKMEKDQSthjL6aN+swL7LduaJbMilfj8IgBaut1DHeMsTHqfFNO9eYx1rvdF2SQwTAcrjTlyvs3wq2XPmgZl+1z9uKxLZmaYKyZvtzhekbBaqcFBfXiJHbDAiqiwYIKFVsI0+JZuJIq73NoLdQrV3i5d8ffcs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w5IQBF9729JH5HNp6AlOJRF6S7LeY4KtKF3IpYt9RM=;
 b=LCEmvw62+T/v2r3j+p4UWvmAZDm2YCa0UxH3cTt9brgVA8RrUr1pdS1lMRGqYGeNAz0oEudDjsFrDcjcwcGvI/MO0fe/I9dEZdGeZICHrXhmDNIXVVqZ27hfA91laghajfOu9MTGeqyeIs41fXOPssPhyB3iEdmUXDoZkj+a0qM=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by DS7PR10MB7190.namprd10.prod.outlook.com (2603:10b6:8:db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 18:03:02 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 18:03:02 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens
 Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM
 is not supported
Thread-Topic: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM
 is not supported
Thread-Index: AQHbQJeMuxmFoIb+J02vUUNmdRXLiLLTRWsAgAACNQA=
Date: Mon, 2 Dec 2024 18:03:02 +0000
Message-ID: <843B01FE-5121-4BF4-A305-65F38A1C05E9@oracle.com>
References: <20241127064218.42688-1-hch@lst.de> <Z030cuQOvjtLm-hT@kbusch-mbp>
In-Reply-To: <Z030cuQOvjtLm-hT@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|DS7PR10MB7190:EE_
x-ms-office365-filtering-correlation-id: 3081dfd6-6ee8-4273-943a-08dd12fb9086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVQ0OGN4NkdROVNyNmIxMFpQdFZWb0VYeXVGV3ZndGRSdHEwZVdkOW8xUW5z?=
 =?utf-8?B?N3NKUnZma1Fiazl5SGc3aVoyYWd2NUlMZk9UMjBBZm50T2loU0hRTWJQVzFV?=
 =?utf-8?B?bHdCeGFjQThNOTQ2UXdxQVREYXhvUHNnMmJLWlcrM3AvYWZhenVwdTVrNXJF?=
 =?utf-8?B?b29WODhrU2ZrQ0IyWjBkVTREQmJVckMvbDFtb3YxRXMwRGs1VDVuOXFVV2t2?=
 =?utf-8?B?T3RxWXNjeGF4UmxHTnpsTXJUMzIrWWljb2F0RTQxRHVXR1pGU2owajZvcWhm?=
 =?utf-8?B?Q2RMczhnWHdTY05HOXJaSmZvenByUTZoUWM2OTY1Si9lcmpMZDZxY3BWeUc0?=
 =?utf-8?B?T2FTRStqZkpXVy9rOE01M2xiczhzdTFETkZ4TUp5QnVFb3NGVmFER1UvUXpB?=
 =?utf-8?B?d3VicWt5NUtMWmgwR1ZMZ3N3V1ZFeXJ3cnZtZkhxOFVpcWNibGlrWkMyYXBE?=
 =?utf-8?B?NHgwLzl1TUxqdkZKejZVRGwwa2VNdHc0WkNSTUFjN0hianJWckdwd29LNVhz?=
 =?utf-8?B?alg1dXhpRVVSVm1WaEVsWE5PQVJQVlQrUU5ZRTIxVWFWekRYTHlNQkQ3bElq?=
 =?utf-8?B?bVNrUFREelU3VXEvMlJ1OUVnYksxbnc4M3JDZjRPcVlTdlk2NHo5Vk1MRHlZ?=
 =?utf-8?B?aTVOZnVJL3pxaEFIRUx2azk3ZEtDdkJCalBEbmQ4MmhJZWpUZEEzUXg1alF5?=
 =?utf-8?B?QmRzYU9GRWJMZFR6Y1F6SlFQUFgyazZSKzlHdU9nczhTNmp6N2VxemhHNXV4?=
 =?utf-8?B?azFVdlRQV2E5MUVBS3JlVDNFS1pSdnB1RGxqOEZ5Rk5lRm9kSjN5aGQ5a1Mv?=
 =?utf-8?B?U3lHa3dyUTJhWlJGcDVHa2JqSGxleUhFcm1tK1o2T0NlbzJlVFdFUHdVdDVl?=
 =?utf-8?B?KzBIelhCRTYrd0t2a1c3L1NmUlNZenVmdnkwNWc3NGltbGtRNEROM0hndHQ0?=
 =?utf-8?B?ZzhIcCsybEJTNEpHSnVkNWwxT3luS0MwNUlWVzVyY2NUeCtzZklqSkIvbGV2?=
 =?utf-8?B?SVRiZmM1bFF4TWVsL1BVbW1sYjh0UEJHV1VFQkN5UWMyZHAwMWdQUUFTUjdi?=
 =?utf-8?B?UDZoYVNLMitRcTEwS016bzJlWWFjRU02RE1IazJvVmovMEZaVUt2Y1VVUDd3?=
 =?utf-8?B?NUduU3ZOSXZrQWNFcEJobnFVSzB6QitESlJ5amFlZVgvOTR6QmEwWGZWYVhy?=
 =?utf-8?B?d3V0bGxIMlY5aVU2YmI1WFQzRmpsUE9VUkl0Mzd2ZjQxZWI4bXZZTGpscWFF?=
 =?utf-8?B?WmxSbDQyUWdtVHNZMWdiZXl4V1RPU0RsMEtLU0hyZVZia3k5cTU0dm14WGt6?=
 =?utf-8?B?MzVjNE5MK1VtYVdqQ2o3Z25FTEtSeE82Qmd5MkJMZ0pkS1pmc2hLNDVTbzNR?=
 =?utf-8?B?aERXNlExdTVScVVsOXFMUTU4QXg0S0hNSUZUeTM3SlRJZEhJaFd0NjQ2cWt0?=
 =?utf-8?B?V2JnZll5OWFUTUhZQnB5eHg1RmQrdGJCS2UzamxZQ0YzTzBPNmVaYUF5WWR6?=
 =?utf-8?B?OXp1Z3VsRWIwMHVZc3dxdVVDek84MHA3ZFBkVm01Vnh2cXk3aWRSYTdGL3dn?=
 =?utf-8?B?TEZhOVU0QU8wc0h4NlQzWnhBZUlxUk5JMUVQRWlodnIvL3ZsM2xJYi9mUk1o?=
 =?utf-8?B?aWtWV2RnV0ZldG41L2U4N1J5T0o4MXlid2haTUh3Ukxpa0RmOGczOENOUE0z?=
 =?utf-8?B?TGtHVG5xV3lBcXZRenU2QW42OFpXd2MydXl0Y3FScUhtS0lTOHE2cTMrdzd1?=
 =?utf-8?B?NCtwWGZVamZJRTlDbS9Ua1JzNXkwajNRd2Z3cGVGaStyQmdSRHZ2WTlCQXZN?=
 =?utf-8?B?VGJ4OWJjVlVMNmV5aTJRbURCbjE2WC9pRTNtRnBmVVV0VzlMOGxjQm9Ub2kw?=
 =?utf-8?B?MW5XS2NrRlFtd2diR3I0N1dma3FwZDA0dVBudXlYUnd0Wmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTdLT3BoeDcwSVlqNzBES1JBVWVWTHVRQnNmQW5pREpKcDVkWno1bVBQUlQv?=
 =?utf-8?B?YVF4MWNqUHl6djNXQjlWTU9RVTYrM042dVpJc3NxeHRrd1lZNHNSYUpvQ2ZV?=
 =?utf-8?B?R3R3d1Noci9KZ2dzQnUyNGkrWkttMEJIRU13dm5wRXVjUmxjNU91RUhrd0N0?=
 =?utf-8?B?Q1poby9NQUxZMm5yV0FjclJvZ0dhK0lCU3YrMEdLeDhPeVBqVGhLaHEwdUUz?=
 =?utf-8?B?YVE4QU51dzNKOTlFcVdBeGlkSXM2RlVrd2w0Z0x3WVF4WStnTWN4S0xUS0lB?=
 =?utf-8?B?NnB6dWdlWWFYVk5jbFVCMUNKMUYyblJiNncyZmp4NG5DZkVyWi81U0xzNFZ1?=
 =?utf-8?B?WmZvT0xiYmV0Q0N3dkVQOHo2Q3JjSzZ3RXh1QkRHQ0FJcWphcnlRRkh1ZDFy?=
 =?utf-8?B?ZWxvWWpnTDFYYWcvNUJhdDFtRDZzNFY0Wi9mSGtKMmQyQVloWFNBajh4Z0o1?=
 =?utf-8?B?MnFlQkVBUElkYlNNVkRmWStkVHpmQWNsRUhFd2lhcGQwNW5Jd3JDeU02TG03?=
 =?utf-8?B?S1Vrd3c0ZFlaZytib3oxay9xZU5RYS9vZDdRd25NQU1jNXh3Q3J5bHJlZnJu?=
 =?utf-8?B?R1gxQXlIKzRxOTY5RzQwdWI0KzJoNnRRb2JjT0xPQ1lkYVNDbU5ZTmp6Ykdi?=
 =?utf-8?B?ajdpYWFRQUlWUVJTUy9SbmRIL0ltM2dDUUtuTmpQcVYya0t3SU5BOGlpZzdh?=
 =?utf-8?B?Mis1ZkorTExISThBQ0ZpSVZjSjJ6WGM4M1JLZUtBVGhTMm1VNGN5OU5qS1U2?=
 =?utf-8?B?S3p6RnBaaEh6ODZoVEtBYkMyc1FzNlVwSjNKWUNvK2Z1QjFXdkdLejV6ZTZE?=
 =?utf-8?B?Q0hocEFCQjF3ZVJXdHRIOUk2TllvcEdPWmY3THBYNFZNU0ZpSGtJenV2aGtT?=
 =?utf-8?B?RnF2cXhDVXMwSFYxM0NTZDJpVHMvamkvTVNabHdNZEV6M1JVd2E4dW51MGhE?=
 =?utf-8?B?c3ZVSDRTdGJSTTB3UUx1S1UxSndNMWNVdk8wM1FLYlhlQlBqUCtlSWo3cGZW?=
 =?utf-8?B?MnRjbDdVWnlPbzdjdWlXSUIxTE5KdjUyNXF5ZXhMb2N2UnMrci9MU0ZFcFdm?=
 =?utf-8?B?eG9vSEFDTDBGWFJlS1BZd2VHOThEMkVKS0NUUXJGQytoaEdPVFBzdEptVUtq?=
 =?utf-8?B?bWo1QmhKc2JFMjRGNjdNTWdlQURHVzA4dlcrMzBFdDFqeHh0UnZLeUVVUnRW?=
 =?utf-8?B?MzZDbk5BOW90bnUxUlEwcnN4VHhDUGdjN0tXcGNrRnA3UUt6d3dHalY5NXJS?=
 =?utf-8?B?TlZaSEFmRVlIclBHSE44NkJFTWl3MHBOWGxablZVZGh2RGJzRGRobnFpSSti?=
 =?utf-8?B?SHpZNHFnOWs2MGFvaU84UlVtOXk4WnlZRE1hK2l0K3VHWEJTSzZiK3V1cmxp?=
 =?utf-8?B?am9HT3dMNnZzclA0dG4zQWpCcE5hMU9weWNnSXp5OEcwRXBtWHFWbWZ5THA1?=
 =?utf-8?B?Q3d0bGdTYTdXcTFSQlJwcXhpODIxelVXNGE3ajg2akxydXhMNDVPMzNqZXZK?=
 =?utf-8?B?ZGZOZndJR0FDQWhRekV3aDQ4MEhOa2FhN2NNaGU2UG41OXJoTkFnTTc0MDlW?=
 =?utf-8?B?S1FmQXlwZS80cm9uREdLT3BFVUpMei9GcEdlUThtcmJXYkpvQ1JpaEEySGor?=
 =?utf-8?B?ZE5nRHpOVUJRc1kxRTBVM20wZDdsYVVxQkVIeloybXkyUDYzZzhUTU5aUU9k?=
 =?utf-8?B?WTd0UFhlNVRjS1VTcnV3Qm1rVEJuY05HUzNWaElwR1lOc0VsZys1dTl0Mzhj?=
 =?utf-8?B?TW54OU5OTmFkZng1T3pPOUYxL0E5YllFU3c4N0o0Z0pvTk5OVVdUNzJYaEZI?=
 =?utf-8?B?Q1FrTDRjeUtBMFExdlphYXFCZHQzZm1aRm4yZWE2TmRFblBFUVJRVHI1Rm84?=
 =?utf-8?B?QVE2ZERBTk8zNkZMTGI1TlRCUlhuZlFnVHV4QjB5QXRkZXNMazZJOXNyM2tY?=
 =?utf-8?B?NnlMWjdHSytjR1NhQ00zV2g1Ym9HaWpMYTdQdURZQVRzWmFHS3pVVnhQU2FQ?=
 =?utf-8?B?YjhnNitXT0Z1M3JsenhTMEphaDJCRnBpZ0VCUnVKRDB3R0NNZTBXK0Zobnp0?=
 =?utf-8?B?RUZSR3crSDJ2U28ydEtWN0dzNlI2dytWd3NvVmhWamxwdE5KMXFGVk9yZ1pS?=
 =?utf-8?B?U2wxbHBzMTlQMlFHYWNneDlsV0ZXOTNkbnZ3UXhQRFlFUlJ5YTNkV2lQd1lJ?=
 =?utf-8?Q?zaWEqA1J6t2BfJ6G75nKo8I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F4D7E46FC6A974CABB6EA9E57ABB518@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FRnJGuFZHIjLlvDvLsajuS2OGwEiQ4SpYXKcgt5jE4D5GYCN9IX6DRQt2S/Xjmd5k2/7/TmMiqOsJq92mNG9HP6A/E+SnaA6dVM7IzphwpukpD7X549/yoTAJF4ZaofKnVNCMXZZbDTUcCnzzjxaVYEezBB7k2ihlt4rdyLn1//L9ds8BlaTes57VtVy4IfMn27MwBBizO6FLBUa4yORahEfOLR/S01JREtwc1omD5eUmDkJVfseNnu7TkebHxC4E2PYMto/GKv0HArwbgE3oVW0cR79f1ZO4KS3fYV4KVf61on7xtgLlTOy51l1KEdz8ZGVIUV4Fk6CMX07DJwU7kl7YciFDUSmgYSxyxLEJGdHi3q93Sl/2Aywz6TKHrcBxciAxQV5JFiNcI2h6PDyRjvD3KQTB4tY4kXrXPmz1jDod84oKwWFN+AKRMhPyoVPX4agB+qdVdzxOumgLvdmIRNNtVJoweSJ0VKH9Q7abyQ0193H1l0qZiX/YA4sx4l0np2YrMZwmR94+y0EQAZw4sYJr1gkR4jMptD3rgKHhl1kIwCThcdWr6u7QXWyH17W2LwjLboEOqkAKkTvMHWL6kK7Okegyyq+IVOp/Jhl6CY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3081dfd6-6ee8-4273-943a-08dd12fb9086
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 18:03:02.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K96C4yqVDzGL3Xf9kpHORRF+Y1B7JY0217yeDV/o32wYXg+tf0z3zFAtdtQ4kQJNyRYG4oiMrU2OeYCYecwfhI559AfQrev1D2baw/TlchE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_13,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020153
X-Proofpoint-ORIG-GUID: wzzGM2nXnnM53-785bGpjJvQMnuDyySR
X-Proofpoint-GUID: wzzGM2nXnnM53-785bGpjJvQMnuDyySR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_100324_941664_57EE2BF6 
X-CRM114-Status: GOOD (  17.41  )
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

VGhhbmtzISBDYW4gdGhpcyBiZSBhcHBsaWVkIHRvIDYuMTErIHN0YWJsZSByZWxlYXNlcyBhcyB3
ZWxsIHNpbmNlIHRoZSBicm9rZW4gY29tbWl0IGlzIGluIDYuOS55Pw0KDQpTYWVlZA0KDQo+IE9u
IERlYyAyLCAyMDI0LCBhdCA5OjU04oCvQU0sIEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE5vdiAyNywgMjAyNCBhdCAwNzo0MjoxOEFNICswMTAw
LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IENvbW1pdCA2M2RmYTEwMDQzMjIgKCJudm1l
OiBtb3ZlIE5WTUVfUVVJUktfREVBTExPQ0FURV9aRVJPRVMgb3V0IG9mDQo+PiBudm1lX2NvbmZp
Z19kaXNjYXJkIikgc3RhcnRlZCBhcHBseWluZyB0aGUgTlZNRV9RVUlSS19ERUFMTE9DQVRFX1pF
Uk9FUw0KPj4gcXVpcmsgZXZlbiB0aGVuIHRoZSBEYXRhc2V0IE1hbmFnZW1lbnQgaXMgbm90IHN1
cHBvcnRlZC4gIEl0IHR1cm5zIG91dA0KPj4gdGhhdCB0aGVyZSB2ZXJzaW9ucyBvZiB0aGVzZSBv
bGQgSW50ZWwgU1NEcyB0aGF0IGhhdmUgRFNNIHN1cHBvcnQNCj4+IGRpc2FibGVkIGluIHRoZSBm
aXJtd2FyZSwgd2hpY2ggd2lsbCBub3cgbGVhZCB0byBlcnJvcnMgZXZlcnl0aW1lDQo+PiBhIFdy
aXRlIFplcm9lcyBjb21tYW5kIGlzIGlzc3VlZC4gIEZpeCB0aGlzIGJ5IGNoZWNraW5nIGZvciBE
U00gc3VwcG9ydA0KPj4gYmVmb3JlIGFwcGx5aW5nIHRoZSBxdWlyay4NCj4+IA0KPj4gUmVwb3J0
ZWQtYnk6IFNhZWVkIE1pcnphbW9oYW1tYWRpIDxzYWVlZC5taXJ6YW1vaGFtbWFkaUBvcmFjbGUu
Y29tPg0KPj4gRml4ZXM6IDYzZGZhMTAwNDMyMiAoIm52bWU6IG1vdmUgTlZNRV9RVUlSS19ERUFM
TE9DQVRFX1pFUk9FUyBvdXQgb2YgbnZtZV9jb25maWdfZGlzY2FyZCIpDQo+PiBUZXN0ZWQtYnk6
IFNhZWVkIE1pcnphbW9oYW1tYWRpIDxzYWVlZC5taXJ6YW1vaGFtbWFkaUBvcmFjbGUuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IA0KPiBU
aGFua3MsIGFwcGxpZWQgdG8gbnZtZS02LjEzLg0KDQo=

