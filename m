Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F42C71135
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 07:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQngZrnClo75zJoK57i8/VKmkY5H9A0yAlUK1kA/lAk=; b=aItRnIebeJN1Trt1JHagiYErxk
	38meY+/WRtrSjXvO4BVZBKbzCu+ygZ+vkDnqrqpfsuaLhuHNyvbmuAwHU09MA5K8TJa6wKS3UWy2u
	Jd2HG+kyCAlkpfHrOUSlqPu79CFQz1I2UoIO5vBhBtsqZ9GslhS5iDTTd/0g9h1w7xYjGaII6HZ4Y
	cWVwG5IFLQds4WuYKM9wRJKQxqKSjVLKyoUsoqrs2z3EmE4mY7z2+HaKyuBW5PCzCMrRAn4S8f/nV
	jeiyW/uoxBtXbsDp9F/178As3GuvenzZ3AmNKJJNNARJONVRDquaNtG644ofqi5Nxgt7Fw53zp4Ms
	3vQNqSYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR4hN-00000003iPm-3VNW;
	Mon, 16 Jun 2025 07:56:09 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR4UX-00000003g4a-2kfk
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 07:42:55 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7ff0T009100;
	Mon, 16 Jun 2025 07:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FQngZrnClo75zJoK57i8/VKmkY5H9A0yAlUK1kA/lAk=; b=
	QMWSUr+J8QaK/5NjE0wRqdDkK3Qbp9PJ4M7ToETFuG1NQeVyGStdvlK9QgE7YL7w
	NVAdeGINLpRw5icHKba7T259mhXa9mnCwXP49gwG0pYHMX6lkl4p9L9fIOWcA78k
	AuWEEjxcfLTcGkN/9wIL7uz5BPcnu58qhzgxnLTlsICwOrrbAs0Jqz9jzPUyfeDd
	5P2HcjV+A59Fk2x6MXhA5im+/IlvSmcFXICkqFBPo1sC/8rzB3FsoA1m2bl3UfMb
	FLvuZ+pVA9aC+mfbLeZ0/vcy3qMGSpYCBj5uA36jhrHEF0BqV6ESqYQXpRNOjii5
	dY0kcrloeFt1KUwV1K/PpQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900esxh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 07:42:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55G6XZLK031109;
	Mon, 16 Jun 2025 07:42:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh7k2rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 07:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3m0N6ThfaCXeZcXk2FNuUk4HazLtF+jvuZyEuyhXr0U1/Gd0sBzT7IftnfkMv6ycr6L8A/Hoy6GiZ/VSaZZzukiZZEI7q8RSu3zw7sZVQ8sqiuC6svtqQu35zPct/J3G5/IcgHFdzi7rjQNn/fzbKrmQyZSgj4Qu0OnXDJ9Q3KfleJU9w7IG3GVLfFPoHjkckfjZZBMM2DGNiIq5m74qzau7D4sOzfzh1j9Np9eCH56l7gBJRhyjvlv0yvBKpTX4EQkZVdJVe8kFbY/VjP+HXNYb3BahXs14KBNwW485lU93ItC9/KBdxdKTCXmKqcAKcv++rUioAS6/ZNSlBQhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQngZrnClo75zJoK57i8/VKmkY5H9A0yAlUK1kA/lAk=;
 b=KatgFpz7EA2jD25CYO6HBob/qHcDFxYx2IoVwKJIZNz5hmTtMon9FyS6jd7mqcawOuvcO1Da9vihWYys59H5yBBYTGYFIXZfbuFgnVhqUoqU7kDfKXz1edqnuQLae8tMuiCUOBO1OrWxPKyEHZIWNlhGnYO9U6z8/0sI0DxzU4R0N2OxVUO8WV1eSWVJpSUTMTkJ6a5N3wZOU1kz6yV/gVCEe0vVWs8AS46vXy3DqPaV9PJaVLwApD8nIJMeBb8MIv7qRM/aPpj2xTzjsEmbn8P0FF3NhyIu/Iy2sQ4+yoaThOprrpGEOu16NvozpS9fSEndnp1cy9ptwuDwYyfBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQngZrnClo75zJoK57i8/VKmkY5H9A0yAlUK1kA/lAk=;
 b=iuarsLJ4pOmnSbl2Cd7bluhZCtV26/yOstwI0cIAwGTJLNVIfiYzKIifiUnMVtrW1LzxBV0Q1NUrJpZlreTH7kF/Wq+2JZgZKXkLkGJeNzgcj0tqVks3F5h1bhl4hSb0lO1GIYUleMTd2ei0AYoj7r/mxKo/HsH9CjCCK0Qc+oo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4803.namprd10.prod.outlook.com (2603:10b6:303:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 07:42:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:42:45 +0000
Message-ID: <58c27e85-c47f-4c88-ad74-9a7d9943cace@oracle.com>
Date: Mon, 16 Jun 2025 08:42:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: fix atomic write boundary validation
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Alan Adamson <alan.adamson@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
 <20250611055432.2401372-3-hch@lst.de>
 <f88d67d4-8484-45ba-9705-95ced325c65a@oracle.com>
 <20250616053158.GE1148@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250616053158.GE1148@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4803:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a0d071-59d6-4b76-d907-08ddaca961ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0xHRzZMQWgzVEpzWjRoUHdQcXdOTFhFOEdjZm5BdXZHdVAwK2pPZ0V5Vy9u?=
 =?utf-8?B?d2g5MGtYcEhBQ1BtaVQ1Ym1nQUlyUDliemZOYXhEaCsyQ2daeDF0emEyN1Q0?=
 =?utf-8?B?QWgvcUJWR0JOYk44STBVdW9FeW90V0ZJbnEzWmVKcW9ibGxqR1VOVjZ4clEz?=
 =?utf-8?B?N0VhSjM0c2VhalN4MTYrc05uai9zT3QyQ3RXVmVCTXgvZWswTHRkNkROeExP?=
 =?utf-8?B?TkNKR2hNa0VnMDNhNWw0TFVnSFpxRnY3UEltMGw5dGVZL291cm1EQTgrWVdy?=
 =?utf-8?B?TG5KK3ZXZ2FuOWMvbmt2emdqaUQyQ21tQndNTnpTRHpwUkJJK0NKYW0vZzVs?=
 =?utf-8?B?L25UZkgwbCtZaFdpZkZHVE1hY0hxU1NGN0wzTmhrbEpPcm05S01YNU41R05o?=
 =?utf-8?B?ZSs4eEJrUitOdjJyenZHamlaenRDdHNqZndGTTF2ZXN5MTc1UUl0cHVPM2xK?=
 =?utf-8?B?M1ZiZm4vU095My9Eazd1eDJVbk8xa2x2Z1F3SWJpZFYyQTFrSThxKzdJaVFN?=
 =?utf-8?B?TWM4NmErdEZxZHNiUEo0NEkvVEVoNzVYb3MrOVNhYUxhTEMrdGRVTGtJb01X?=
 =?utf-8?B?bGoycWlxcDFHOEpEMzlGMEdGVlZSL3hXaXpzbmlhcEtaNEpVaXVITXgxWG9Y?=
 =?utf-8?B?MHdRVDhGMGVPV3oxOGhDc3RtbmJTQXBhWVBUYnlwYlpQKzJzSXB3cVgwMWE2?=
 =?utf-8?B?anBwSEMwK2N5Z0FwK2RZVUE5RllCbHVHRmwyWDFsRkV2bW1IUk4xUldDakJL?=
 =?utf-8?B?ckpBSWh6VnBQRkh2bENORmtwMUEwQWFoWkp3OHFtZ2dGaTEvQnFMOEgydVBl?=
 =?utf-8?B?VWx5S2JIbitlc1E0S2dCWmZiZ2MvU1FSM3JVcW9jeEN1Wm0zcUhtWnN5WjRT?=
 =?utf-8?B?MXFJa1NlaXNUcnRIK01RZ2doOFQ4WGdlTHBtRUt0MFNDWk0zc0dRcW9oaGFw?=
 =?utf-8?B?LzNmQXVveGhENTZESUNuZi9vdjFpazBRTTBuaDRtWFVQN0F4aTlPMVU2RFh5?=
 =?utf-8?B?UjkxOVVJTnFNZWFLQzhhN0Rvd0tlTG5yakxSMU9TNFBCb1JLYUU0Z0NPK29m?=
 =?utf-8?B?NkRUMWM5NWJTL2M2VnFZaXVnR3kwaFo4cXBCVEM5ZThOSDNydGsyWENpWEli?=
 =?utf-8?B?VVBHNnVycFcvUE9PT0dwcE1WeEJCYzF6MXI5YldFUXVnbzhUNW9abE5aWnZz?=
 =?utf-8?B?K1JQekVpMDNzYUZ3c3N2czg5dUt1c01uaTg5cG1oWUpWRzVacmtKUk5VZHZ1?=
 =?utf-8?B?UjExekdKOEtiRDhpT21MZXIvSUxxMm43blh1SE1zSHllM3REQkRCOVJXYmlk?=
 =?utf-8?B?emtWdzJWZGJ2KzA5Z0JUV09hZkdRREZ5aTdLMjNQOHdlMHlwWUV0QnJJdjJ1?=
 =?utf-8?B?SDBDUjV0NHRxSzJzTmNFZlpWL0kwQllNM0p0UlVHUXFWV25NT1lyTEpiOGdH?=
 =?utf-8?B?UzBQeTUyZ2F2Mk1kTnM5d1hCUWlLTFEyUVRSWmFWS1IwOWZ5QW5aTGRMeFlW?=
 =?utf-8?B?YVRrbnFTTm9IQUZKVXZtUDBRZXBoV0hsa2owOFF0RERiY29ra3VTVGJFODB3?=
 =?utf-8?B?ZDNseG53T09HQkdzalVhMk05OGhDSVZYbTRBb0loNTZnTUQ3b25ZOWlob0Rr?=
 =?utf-8?B?MzZNQW5GZ0htczZpdnE5U0lwR1ZGdjVKUUZaN2YrMDlRay9KcDVUZ1pOSy8w?=
 =?utf-8?B?VFJNSlQvNDc4cHE2dnIzSGNESnpaa1l0aTZycHNVVGZXcytKTmZUZFE2VHBm?=
 =?utf-8?B?NEdGcEhUQUM0RU5lNjdYS2pZSnZUdzllclExSm45R25BWit6VUR6dEIrTjRP?=
 =?utf-8?B?dTk1TkRaOXdOR3FEdDU2WmlCbkh3bmNrRkxOcmQ3NzlnbFJieUd3MjNNOTY3?=
 =?utf-8?B?VTh4M2xmK0R0N1d2a0ZJTktMcmZqU2JSUk9sQkVjNktrT2NuK01VRnVRbDU2?=
 =?utf-8?Q?/izdGTvNjcE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2poTE9MNXBkcVV5TW1BOVhVUm9Rc2ZNaDN4eVN1TGljbTVMNDg3Y1hLcmx2?=
 =?utf-8?B?aU45TGVsbVY4MDU5V0lrbWl4KzN5UUFzRnhrT3lWYThJSnpvWjg2N0hXZ0w4?=
 =?utf-8?B?c1Rvc09OTVhlWGxqc0NIbUVYQklQdndPZ1FxdEJEZnZZUjZ4RXU1OG9RcWVW?=
 =?utf-8?B?M01pSml5USs4eXRPUkNzSGxOeUllSWZneC9LOWdWNldCcGc0NjErYlNIM292?=
 =?utf-8?B?ekswQkVSblZiT0E0L0tXblE1MzFJM0ZWT1FhL0FhL0tNaE83WmkrVXlHVmlZ?=
 =?utf-8?B?aWV2U2JiQVc5N1lnV3drRURuVGhiNk9lNlNXNk1TZTdiSmhxdUhuYmpKZjdD?=
 =?utf-8?B?bWM5NTBRTW4vZUE2RUlzb1lPMDA4Z1dNbElqOXdPK05Ld0Y5MEpWOHRhZnFj?=
 =?utf-8?B?S2RxRnNPanNSUEVKSjlBald2MmFJaStkaWpGTGpNNkd1V3NlajJHdGJQTzhH?=
 =?utf-8?B?eWZWODAvTnJvcktzc1VHejJiM3hRZVVyRUlBTTd4bjNaZGFDT01yRHlKVW5G?=
 =?utf-8?B?bXg4OVJ5TkxvdHdjdEQ5aGIyWkpHWUMvZ2R5L2o2WTJUSHMvelQwVngrWFNi?=
 =?utf-8?B?M1JaN0V5RTF3OUdYL3hjTXhjK2ZlTUlJWUJvTUtROG9PZ1h3ZDBVVUtoK3pX?=
 =?utf-8?B?RjloMUVyd1BHdjQ3aVVlbEdJSUlnVllhYjRlYmR0RGJKa3hPMHdzNTAyWWJz?=
 =?utf-8?B?K3lGZkNXb0ZIQnBpSmxDQ1lYOWM1RHVOLzFhalJzRDIzcUNocmgzQWxqNWRB?=
 =?utf-8?B?YnhLNUsvZUNkbWJ2V3dXQjByM0dDcTVmNERGaDk5WjRFdmtsWmFQdTJJOG5Z?=
 =?utf-8?B?QURHakFhc1NiMW1BVDBxU2FhL2MzczE5cW1uN2FSVkcrTEtuaS90dURPcitF?=
 =?utf-8?B?d3ZUMmZPNkJ4a2xqbGl4Z3ZrVHV3ZklkaTUvYXFiVTNrMkEwSFBVYmswUFVF?=
 =?utf-8?B?Q1pZaTU3UW9oN0E1WEFHWDlrOTJkWHBrMzYycHBTaG43d0JLUTJtTFVpZnBy?=
 =?utf-8?B?ck5GRWNhZDZtRUJCdEVoVmRwOFJkcTVtMENKcXRHYjI4b2phUEFHb3V1V0pk?=
 =?utf-8?B?OXhVZHlnQ3FtYWhuZEkwNkRFUjNOaGFic24wY01vaVJpUVF4cHNpaktqRG9C?=
 =?utf-8?B?MTU3WmRrZGJuTEgyMWZwbmRqQVBRU24vTSsyRTlrR1RIV3NrQ2cxWnJIOXpi?=
 =?utf-8?B?VEY5b0hOSVNNS215ekRDOWxXUTcrNzliL25NM0dJelU5MEtMZUwwM2hZT2p6?=
 =?utf-8?B?WHIwZXErb0NCUmUyNk1mSDh3bFZBWHFGNVRQTmYxMTRlMFZoRkZBb3ZWTWhv?=
 =?utf-8?B?R2hOV1FnQnhhU0JLNlZHUDlpUWZGYVhoQWpjVkliaHAzM251OHB3TXVmRGFG?=
 =?utf-8?B?dWN6NElwUXdhWGg3UmJYelRhQ1RxNFRLUkl6L3BqcERqZnBUN2s3bXNBZUk4?=
 =?utf-8?B?L2hNRzdYL011WTVJVlRjcDJPZktqcWd1SnVscm1welMyTkZBa1FYTERIbFE5?=
 =?utf-8?B?TnFXK3AyNDE1aGJSc0xJa0plbUs3Yi9icTd3UFhuUTBmWkxMa1NIYmlkWWZ6?=
 =?utf-8?B?T0ZPblFIcEttTmhTWkJ2b3hiVnIwUjVWUmErU3crcUFaTHB6SExJL05hVi9o?=
 =?utf-8?B?OThSNllvTVgyNGgvR3YwVytzY091VnZWYVc3eE9MUHlxdjduUzNiT2QxNmR4?=
 =?utf-8?B?WkNrSTIrSzJ4cTlQa0N0bDc3bDgzNHByMnhjU2VmUzdXdHZockNrQWpueTFp?=
 =?utf-8?B?ZHJWTWVFMjA4alJlQm5ML0lMcFFEK2Z6NjFUSUR1enk2UkF4ZFpJVmFPVDYr?=
 =?utf-8?B?UHdSWW1pMnE4RFN5K01HS1dBajRrV0RlNGxOSE5SckdqMHNNMHFxakh1dzZ1?=
 =?utf-8?B?MlJuM3c4RUM2R082MXBpRktPQ0NMMitaT2srZFBuc3RsRS9aemh6d1Frelcy?=
 =?utf-8?B?T1dSN3pOMnpsb254Z1ZLaVRxVkRPd0N1aW1IdS9hQWJhYjJ1T3dFMDFKTjRp?=
 =?utf-8?B?QzBKNXpJdDVicTc3V3YzU3hMVjZXVGducDdpVjZiMVgwcEsrQUFNWUxZUmk5?=
 =?utf-8?B?T0M4NlVDSWN2d0ZsRGhkMGlTdWlTSnh6bno3K3BEU1lJZW56YlhKY3N5NnNP?=
 =?utf-8?Q?1xDY2TaFkLpTrHHI4+NyaLvlp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TbsxkFPpLvpsAsQ5GOLJT19z25JEf+kUfGHzrFt+OoQ5zsjJRQGzNJ4r3uPAwvGR3SRTvIIP718nqoPSkO2WwUMuqC0EGCYhldEi8hxQM3mmoaSWRCbkXGC/78kedp0Ic31JbrizTWOcEQvNX0c1C8S3cEevUVn5bwCr/XJlwci9ZL6Z+eyulcJymCbTO4++lutx0lH7NdFCAVNsaLckUA0PgYLhVN5vw4j5xVOP69bbierrDnjIotEijcjQyXxQ/z1Gm0ZX3hoLN6dXaj1ZyJOWiu7Ro6/sebNusn2hy49ey7WjNbVzjrL8Or+wTueZZ6476lhB3NPxsTfd8MsaAHVS7aot1ar2vXw4dlHKWj7S5cN5lWKkJw+pwJtXRzFo0TwFatqspnXSg63cAogBryMwEFt2HCYYkkYx2ZokUD8cxfpbDB2UT1k4Mj2oPB4egWdokLMfm0Wp7/9Lbh0xmDqVbWO0wYqHsqhzf1vAVunYpv84x4n5uYwOVBdF1ijui7Cko4awyOoLJTCvp8dzrGAi8162YcFJIJv87Bcv0ot1mWeGmVzkEIL+d1HYR2Xd+3PJEzavsLi3q2uvA3B6Mv/SSdVRkqqmVFMwryqVFJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a0d071-59d6-4b76-d907-08ddaca961ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:42:45.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JY32c54Mv66XKTfQOrLJoM/WOlNRhZG7zdn+fLFevn2GdBlZ/2C34OslrNqHLEXj3U3peSwZ4GwJHaPaFmNnZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160049
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0OSBTYWx0ZWRfXzhiRaqOBQb2u iSSducCku2OaWkhRo13V3Y9hYpcD+99p5IZR0LBbux1DjDMA8+I0kc39BWjTkhUb4RehvG7f6Rx SaSXuZXllDfxHFUqqgZpsMQqYsdY/1t5nE6favJwCQ6GJ1BllrSIvkgqagseP01bLrytFcqCJ9H
 IjSVe8Q80Ri5mxFKd+UC8IbxLgcj934/8CBYOFCGlly9wdLgNi3b4lwq8n2sE+099LDbTqxr4Ey XlVghSxLvqO21wbFn6A2sqtAqj8diOUVyt4mhUQou2N+w+/ivf6WAty7LL3q3zR+Kv6JmW9Lsxo Ztr91qcMlbsfdblzwEhlQ/1oZzXUriTjcEBAAP5g8PLS/aWcLetrpw0oSisg7pgKHbJK5d2XZIw
 lKuWnD8EN8iWOl4R1SqNCK2ExRZAf7K+qkJrOIhJCtcViq8NCYvCTn09frpD9OKgYCjW2Dlw
X-Proofpoint-ORIG-GUID: i9SIwLcRVqJb3s6GUNBGS_0_9Ne66Skk
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=684fcaf9 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=GDpb2eCvN-92zcW-n_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: i9SIwLcRVqJb3s6GUNBGS_0_9Ne66Skk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_004253_703430_B482A8CA 
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

On 16/06/2025 06:31, Christoph Hellwig wrote:
> On Fri, Jun 13, 2025 at 09:03:07AM +0100, John Garry wrote:
>> I suppose that many comments in 1/2 aren't relevant any more from this
>> change.
> What do you mean with comments in 1/2?

I really mean my nitpicking, like:

On 13/06/2025 08:52, John Garry wrote:
 >> +        dev_err_ratelimited(ns->ctrl->device,
 >> +            "%s: Inconsistent Atomic Write Size, Namespace will not
 >> be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
 >
 > nit on pre-existing code: /s/Atomic Write Size/Atomic Write Sizes/

That dev_err_ratelimited message changes/disappears in this patch.

