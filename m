Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CEAECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 09:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCyXytuwy7ooUVMyx5WnOrbAHYkZ1gxiDtiDiU1YfrA=; b=DJi5AHNype6pmgVfnnQC7wtBWm
	lWKpfTguH769Qg3PzAGhl+RNNN4C67+JrRHlSX9u54KStGPxPOeyJfb0klPJ2VOaTkH1yre6p/wrW
	UthZjEXn+hmjAyb2MtFdtmZaAwEEmkga515/3yvL/EMIJIOPRWfQ/vgXg7+Uqx1pRoPeSFRT/zY1U
	otXnnfbBWIC9Uc5Wthkv2+yQUb6KqF56E+fW5DBC+lzW/QjKM9uXT9NDATxnH71ukQ53pHKIRN+/H
	I5eaybGpvfVG+NydWuBi+3G7/xkICrLmUyHSELjRQ3RZumMTt+uM6pvsUQ8R6SkxYStgYI7aFOytp
	HLAPz7MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUyU-00BtHg-42; Tue, 06 Sep 2022 09:34:30 +0000
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUyQ-00BtCO-PK
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 09:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6KIAOg+2zHpS4tXWNvDs2vyaxiRzquurBl+jrwDa5b74v/bnrk412dprzP0fsWiHm6rU6fcnzvTzXEpvhFBSQzMNgt+v3VrXDVJrOnRcPJI/cH2ABnQknNRg27XO9CWGsxU0hVQYtD6s7GhDuHb3UiakCjOUgSepYfPqFw/WrVQ1sS7XelWmfxMynal85U9Ea18UcHakmnNb5I/mpYwqBTBk331nyEqSmnieU18QX75SyhTbnXimH27Qnl3+sqpQVxpMcEVdgFKemC1f6qnffu2q4nRQ2jKu8b+iGsLFbxgCaT650eRv1k8J+i8prAmA1ZlCOg3MRHG1zwrOWomhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCyXytuwy7ooUVMyx5WnOrbAHYkZ1gxiDtiDiU1YfrA=;
 b=aR22FzhNYl+03xDGDZIwHDWbo5Ka9BDpvc9EKa1fUkpSmf1UlZMLfN88t2F18EwE2glp4SKVdTeRjXDVVnHGhjth9OEdErrYuvIpmRFV9pJFBmUZUR0ISJV7SdPXGYz4M1nKk79WZprHHl15PWoVsvnmNsQlbuF6sH3nnz6qFmcycYO4XFNguDtwIRwG6E2ATQbWhA4vhX3Y6UHHVnYb+PCiZW2MeO/QGSnIACS+jAzO6Uprl9yuOMdOzQVnAKpEu0Nk9U1A253iPwolSg0ipWrWt+mmZBvTPevJtyz3qnbOkBMNB35Qq2lalSLG/CkaAd44Qw6pUF97REqrNA+fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCyXytuwy7ooUVMyx5WnOrbAHYkZ1gxiDtiDiU1YfrA=;
 b=Xwv/7y0OifvEu2sBk90UX/YSO7EjYLkx/3O32grGWd2RIdCRH7SCLiL8If09QrC/YFhr9y3WfMG0HIfck2piVfZ6/AM3eXawHu1+Kzv4VSoowvWZQWAzizTYriy74k0CtMt5vHbgCpdPt4yUr5AbuB45WpMdvha21B9ddZzDnCAL5C0CBGVRe3ld/PHbAVQ8rGdRCjIpxYKS5pH49bVPW001aVmCDwOq5fXZucvJWNJIoBcv84uGYJVDsAmG6qWZqu5je6ktGdlVjGc3QTv8UuDndxaDfkm+xYEtaXezUSzdBkAzFiX5zpnp/AqKAQuIvm6J0VePXBbcGXtbU6n3TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 09:34:20 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 09:34:20 +0000
Message-ID: <42216010-70a0-e0ef-2b4f-b25072792f36@nvidia.com>
Date: Tue, 6 Sep 2022 12:34:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
 <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
 <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
 <yq18rn6qxgl.fsf@ca-mkp.ca.oracle.com>
 <289da5df-e988-f0a9-95cd-2c437327a043@huawei.com>
 <20220905063759.GB2092@lst.de>
 <79f9829f-3337-6582-7ea7-6de5c8afc69b@huawei.com>
 <20220906065903.GA2345@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220906065903.GA2345@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5299d44c-97a3-4438-1253-08da8feaf9fa
X-MS-TrafficTypeDiagnostic: SA1PR12MB7344:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	3mYwo41181hkYg5IC76qqxeEKzQhGFClXY/lwvtFvtJ0yQZCAjBZxFB/nkmDP24a3MZC89byUMyF7CehBA2CY0MhvPYl3OhvtimO03Zi3RbXjyTAOaDA8mKYteCG1QfCfx7gT/dQtW1mQIG8/leqzbrvgEeejezwkbSgUfOkWr52PYfSAkdVqo1OV47Uuv9sWkP9lq1PHxelH383pFR5Q9DRZ90zG8eQoPWNJBBGXAAC7CuuJITG9xjk/pPuQCeOJyw3cQyNNZVzs7iD5rwZi2dx0Wxvq9OJKAe+Yqw8kip4tsRVZcwu/unxonz6BM9+wPJU4xGaArtUbNs+b9UjswiPefIlnDyB3GzsAvNpYAv8ogV3xzkiSwBYiBgEdQCGD6mAQf+0l/CB0KlTIygH1Uw3ZFeQ3grHBtqWPI9su9pq9UDyH6OVzPdv6JwF3LwMZpWTZzlUUwuyJ65NotLxdyGCtaAtkuYGYBL32uR5u9D2aNMAfS6uE1voMlYvH5yBDdQD6JNo6QiIxhaY9rj2gVO9mmwyEDCS2VlLFxfuPk7opvnt9Lahg3IMUgFoKAt3rPHDXjLvSS9IBtLS27VnCvmHfb00f9YhjNAH2HEYf1E7xzkTddlOYj1PGQeEb9YyGlKqe60+i1D+2/axyosVSn9J5/KqEXBVdanti0dcVS1aAaKvke47H9V8S5rNSqlB6yS/dakod/hhuhO4KW/b8zBz4qw5W50jSh4lf+a82l1zDulHpbT54UjIUABPmFWoVr/312q9H+HYs4a6qx+8eE6VOmCNEtuju9a2IECs/XM=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(38100700002)(6512007)(2616005)(26005)(8676002)(66556008)(66476007)(8936002)(31686004)(186003)(4326008)(36756003)(2906002)(5660300002)(66946007)(110136005)(478600001)(86362001)(53546011)(6486002)(6666004)(6506007)(41300700001)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Z1FNbUN1bDZ6eUhlVVlHZ3lnNC9tOVFMaGtEdUNEOCs5NXpRcXVBZ1NQbDFh?=
 =?utf-8?B?c1oycXlCVEhoaTBRTHdxOXNYL1MvdnRQL2NFR3RUcW5uNko2NmViSUNiYVhI?=
 =?utf-8?B?RVJ3Sk5vYklLZFdDNktlUEY2T00rL3lkWm9mbkZOS05DUjhNdXNTMkY3THRI?=
 =?utf-8?B?VVQxWkt1d0VZTm0xSTVwbWNITjRhMWEwV0ZjM2FjaElDRzVDQUlYaDN3UTNU?=
 =?utf-8?B?dzNqdjM0WUxKbCsrUDVDSWViME9yMkk5amJGd0JrMUJkZHlGVnprTjk0OGRp?=
 =?utf-8?B?dXN2WXgxelRFWVl6eFlNakJpZ2JyK2h0R3BvT2dnWmFXdGd5Ym9QWndwa1JQ?=
 =?utf-8?B?RHpoUFl1Z0JCS29kMVY1Y3Z1NEFzSXZLR1pJTDZDTnhUWVN4QWR5UWg5bmxo?=
 =?utf-8?B?MjJwMHFPUnlHUDZHK2tqNTNVRXg4ZlhUQlJHM1hYNVNzWVBpQ21lN2FQd2ZG?=
 =?utf-8?B?d2c1bnFMeGQyWmhmRUJJTC9VbWYzZE14SnNhL2NZRXhINkhRejY4ZTJQOHhx?=
 =?utf-8?B?OTFkN0VZdGo0dS9vc2Q2YjBqbnN6YkhETjg4ZUV3UG1GNkQ0UWk3Wmx2V293?=
 =?utf-8?B?ODRWa2UzS2R0eTJpNElOUjhwNGl5K294SWdTWjZSakNYei9MQ0EzdzZXbmx1?=
 =?utf-8?B?RStEZHpIRnF3eXJ4YmQ1dDFXYmlzbXViVXBiRTVPeGtoV2Z0SkE4YWR5Tm9w?=
 =?utf-8?B?aDlkR2kzNjVvczFGN3JKenA3cmx0eXZENHdpcExINUVScVlTTy83bDZFQ0Rj?=
 =?utf-8?B?Z3pSQkhZNmRZUUtlWXhJL04veUd3TThyVGp5SU1aSXhuelBuZUQ5Vm9rOS9U?=
 =?utf-8?B?MGZnVW0xZk5TQVN2RlBhdkZQcmhuTmJ3Ri9EdWcrM216NEJjRVh0cEVSS1JG?=
 =?utf-8?B?U25hS0I5RGpFdlBUN1REUm1idjh0STlFNkxRVGc2T3dCaFdzdzhEa0k0Q1JM?=
 =?utf-8?B?QURYWUVDM3cxVFNxeEZoTStlMDEzWU54SlhzVzdac2JjUUdLS3lMQTMvQWN5?=
 =?utf-8?B?UFBUaVpQSUs5RUNxM0tvRFVsKzl6K0V4Y2dveTRnejNiMTYxRGpYM09FaWJo?=
 =?utf-8?B?MWpaQWE3dVEwMURSMlVjUCsrYzMyLzFGR2xEMjkzZjBPeTZ4eUtkVC9hWERs?=
 =?utf-8?B?YlpnQWJSWWlQdTNzRjBwMkZGSUczV3YrMk8wb0V2MC9VdVF4b2FkNWxHeG92?=
 =?utf-8?B?VnQ1eEVxcnBLU1E5S2FoWU1VM2FhSG9hSlkwME5wZ2Y0YUM3MFVnYndQQmsz?=
 =?utf-8?B?OUwzOGpGbkxIRW1KZ2ZYTlJreWg0c0VJUlFMd1dSamFWbzk4UW1Td2FCU1pT?=
 =?utf-8?B?VEZ5T2ZQcVcxakJmaWYyTktoTDFDbXpBVDBhbE01bXJCMUtxZEhGREcrZm9w?=
 =?utf-8?B?Q3FqdWM2K0RXU2pyb2NzR1pidGR4VUJGYjRWWFN0NW9ONXdXRGwwYkJiQ3Ft?=
 =?utf-8?B?MkJ6YmxEV2R0SnI1MjZqUzBnQURzcmdneGlQczlSY1grVnRJcEtLUGVmRG1G?=
 =?utf-8?B?cVN6SVJOUzVnbkQzbFFEMWpCakZtL0VobjdXUXdEWHlTQnp5TE8zMkhoVVFV?=
 =?utf-8?B?bGxUc2ROTVZPN2VSQzBNNlpNNEkrRjErSjFrSklyL3N3SmdkNXpTZHBicmdh?=
 =?utf-8?B?WXNJaHoyY2NjZXpKVnBOZDdIeHdGWEdaSG1XczFTYVpzMm9GZjVEdDhVS3h0?=
 =?utf-8?B?b1hQNi9KSlk0SUVDOHdxeWdaY2oyTXZVZmNxaXVHcjF5U0hzRnJvSURaWGRY?=
 =?utf-8?B?ZEZlUUY2QXJ0emxDcVVzM1RwZktGSUY3V2RYS1F2VzJ5eGhYOSsxMThXSU5r?=
 =?utf-8?B?Qk44eEN3RC9VQzBiQjJvcENuYU80T1ZzeHgrNkoyZEp1akhSdUhtT0dzaVpa?=
 =?utf-8?B?cDJmL2hWU3F0RDY4dzhWQVhqRzdMaU00T1orbmQwdWFSMnFrUUUxU0VsbVFm?=
 =?utf-8?B?SHJxeEEwRXNoM2FoU1NQUnRNNXJsUDFXT0ZOUktMK3JmdWNkRVNZUzdrY1V3?=
 =?utf-8?B?dmZPUEhLaSsreDh6cTkzODRtRnQ2OE5IR25DZngvYTI4UWl2WUdQaDVQK0sv?=
 =?utf-8?B?dlJBMEFHMmNqcFZYNGxpZEs4VWYwT0NrL0QzMytna2dVMjF2RldsNjE2bnEx?=
 =?utf-8?B?T3dXa29HZjVMWkhlVkUxelRpYU9qbStIdVdkM2dRRXdnOFZqdnQ4WWhpc0xj?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5299d44c-97a3-4438-1253-08da8feaf9fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 09:34:20.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1wU59T/xoVXYTNaxjSlfyxcuDwpg9P5gSV3uRv174tH73mOrOPqWPavXMrm04ZxTTQdN2oqThdPJ9z/D5yqEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_023426_919443_B78299C8 
X-CRM114-Status: GOOD (  13.51  )
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


On 9/6/2022 9:59 AM, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 10:13:42AM +0800, Chao Leng wrote:
>> Although the NVMe protocol does not define in detail how DIX should
>> be supported.
> NVMe describes how protection information works very well.  It does not
> use "DIX" at all to reference those features.  And remember that even
> for SCSI DIX is not a normative on the wire protocol, but just an
> interface for HBAs on how to allow the host to interact with the actual
> wire protocol.

Maybe we can extend the spec and say that for Fabrics only we can use 
IP_CSUM as protection for "host_buf-------->host HBA".

On the wire we'll use extended LBA with CRC as defined today.

>
>> But The NVMe base spec says:
>> Additionally, support has been added for many Enterprise capabilities like
>> end-to-end data protection (compatible with SCSI Protection Information,
>> commonly known as T10 DIF, and SNIA DIX standards), enhanced error reporting,
>> and virtualization.
> None of which is normative language.

