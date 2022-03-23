Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E36C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n13V/bmand45U/Hxsk8wZ1WSgF4krrqrIe4X5NVk/JU=; b=F1b9YngKTJ/wOhrTDvXJGSn5x7
	HpZl3tZ0cQfiAYNIEjmxGnqmW6j5LEmkgRWoKUrNxj6ASLm8p/fKJtoiiEczQV6dEMZtPSAZUZf+L
	j94hpMcZq2ESz6u0xNOhJ0OKS0yJq9Bo7ZBMHPAqoRUu8Pd9VhXJEuA69ZTjExJYdhZK47BS4Vtl4
	NFzdMCDiEq6RjE/ExSIKmgsKSJsDUf5WcpZlqNKkqjplYU+YKs+vmcmchomyGyhDVD3qLVXxOk/fi
	J0kmLAyT2W2q2eOjV4RGDKIw3Ihk38PoSNVo+PhnxXyUMI1j1y+sAvw5V79x42bmr9oYNfZWdXuKF
	3ChbtNeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX2wu-00E7W3-Go; Wed, 23 Mar 2022 15:31:00 +0000
Received: from mail-dm3nam07on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::614]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX2wq-00E7Uc-CR
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 15:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fedruimnkm/pDqt0/T/9Jz4iIW0rEQVBq1FhOFlsygJF7/vgAWOi5rbH7UeJS9pf/2unEy7BiX9ScuK1nt1d7YviRZhHBLMgGcLlUF2i61eGszQla5C+CqRFdctKerXyWFpDa2vHa1gAQiGuhCLw1SaiBJAYZCHkypviqXeriCdEKfZGG/vtpRfBzHmb28o35f8vS5naz55oBZxEg2kFLnCgFbO/2RUOZhVSqGlw3Onwq+ufWat4CM1Kvy0AT1wi0V6R180R5lo2DUmASQz3d1+BnHRCXaYFwHpBA58r/FmueUs1ws4mawMFb7gApKgMaIPuocR6uXaIuz4noYRMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n13V/bmand45U/Hxsk8wZ1WSgF4krrqrIe4X5NVk/JU=;
 b=IRSfSgrjwpxhT/6u1eeS2ryBHqXUCFjM5nwoRsRPDOhO8kq57ETzVW84ZP/hCynomOTcSWKQj0xAKCTqFUDPuLhqNdagHp/36aDBtFQ6O1oqW/qjjhT35Q6MgrgmDn9VD+ZPjOUd4hdN8s2Y202C7DXUnD4HIBBtDGD01hh9axgW7XIalIsRC9ww+Ftpp8jFOmWm/IouG6nj7U297s0Q/Py5LTqSsa9z0fLiG6xmJAYhBpkC6tkwus00hRQCaq73PxTZgmelU2uAejYYknINp3Um5ylu9Olv2rPwzL9hSfcyxX1X4L0sEYpf8gsx9pMo7aRYS5e8GVPWZZoiI279zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n13V/bmand45U/Hxsk8wZ1WSgF4krrqrIe4X5NVk/JU=;
 b=VP3CiFHDWxUlGrasyd+PG9ybQ0nqbKDDQnGlaQg0/a3J+rV9tJZAdpD9KP+F4fErONSf8++D0qDqojZgLhbWGTWcPa/HydGUtXg/AVwxBBLbK71TAOVSgw3ineZZqc8bd3HPIZgv0Bi2sDC8764Wfub0qt1gFmmTqU/XpeSJFLxBIY0c8jkNTT5Glmfa57wd14NVFxk22reTWCng/qj+bzE02/8FFn11CYzbTlfzRREv2CtlYYAAWfeMN8L4CZYqAJBnyOp3OWsGSehOrV5JLa0HeMQgmoOkZeCzOzvKSDKzbj8KxgJSCVFSzY0ts3IFmc2S/S/uXgk5hK3yXoVgaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN8PR12MB3153.namprd12.prod.outlook.com (2603:10b6:408:69::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 23 Mar
 2022 15:30:52 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0%4]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 15:30:52 +0000
Message-ID: <0b810d5d-a6d4-9520-8088-ae9ddfabcbc0@nvidia.com>
Date: Wed, 23 Mar 2022 17:30:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nvmet: use a private workqueue instead of the system
 workqueue
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: James Smart <james.smart@broadcom.com>, Max Gurtovoy <maxg@mellanox.com>
References: <20220321115727.774650-1-sagi@grimberg.me>
 <43893170-e958-3cdd-e01f-c766126e896a@nvidia.com>
 <154e0b40-7d52-fe58-fc56-d7c6f36b80de@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <154e0b40-7d52-fe58-fc56-d7c6f36b80de@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0191.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96047a94-3eea-41cb-5681-08da0ce21d71
X-MS-TrafficTypeDiagnostic: BN8PR12MB3153:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3153BA4B96306AAB3E2D9830DE189@BN8PR12MB3153.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQTm8pX5xPZmbE7uxmHOUZY78QNizyloTwYvFGLGgIA0Lu9qT+cGRlwiOWbRT1ZP8odiR9zOrC8ASzKzGm/sp0RenIeCyB/GNd2aA2c2thQ0i2vDh/SUnnghZpdMK1F7f9fKJzb4gXXdAmRwj0JX4ueB+W3R3V/QrFWWCtBEVTAaurPVOdSrc0JwcirL0Q3WaZTkSiMy/eAZryLDuJHJiosX/GmjXIAvwXY/k4Qyy6+EzmJIphmzUGgyBZ5g3yJBStPty3UavElWNdGp86SGGcJT/7q89QbT6XIiDcUmkEo6dp7CG+3hemp+a845e4U72GiacuxxtHkARPmsXWg8PWtpIOBOykd3vxcEF9K/y+QrjrE/FJ8rFLTA4gX7h5m8sRdJI0lwCMCxCJisBxhBMSabkyHIqEfY4snuRvKv6IDRM2FLyIqRFa35DZmmkKeC/yrm+L1AlXriBHQRP5VruDLry55Sr94otnB6hO9dbRJsjShYY51Ym3EGV+0HTag2fFU8SeBdX4JDlx/o9zPJo0W4mMyr8pRv4VICyJ//Ie2W1aSDbhKkB9sQg7HmbxHg1p1/ekpg4Zcx5j+Z3lIo65/EiHME1tcBcnhMRpmzgDxkWipzqHyUeu++IZPm0QlY4th8IrJt3lvxLXiJcQN2P8c4z12IgS6Sb9/0NsMhESphdK8x4Jnfw0hvVIke5R7mP/YP7B7BBbaxIk23ANvXVEGpPBmTV/j6DqRCSqJsspw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(6512007)(38100700002)(31696002)(86362001)(53546011)(316002)(2906002)(186003)(26005)(6666004)(6506007)(54906003)(36756003)(110136005)(508600001)(6486002)(4326008)(8936002)(5660300002)(8676002)(66556008)(66946007)(66476007)(558084003)(107886003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThIRzNNSEE1N1hBU1ppNFNoaUN4YzFHZ1YvNCsvaklvTVBwaXRQU0h5VFNk?=
 =?utf-8?B?ME1ZeGZLYVAzbElWeGRUZXpKYmRVWHB3aVpQeUg2ZFlwMHFydGtISFBjbFNx?=
 =?utf-8?B?Rm5YWDU4RzFOWWVIMlVLeVRZNGNGbXFYTkhCOHlCajBqamZYUU5CQUpVUDJF?=
 =?utf-8?B?Yyt4M1J5ODVLU3VIREdtRzMyTVVNbGRHMlB4WVY2LzYzZWNaS24xM0JoekxI?=
 =?utf-8?B?VDNzRHFFWXpDMjJzcmNmTTFWS0R2WXhTYkYvZFRkaWd0Z3ZZYmdtOWQramJi?=
 =?utf-8?B?VXBmK29hTVowT1VSZm9Pb0piZ2N3SWVER0dOdjZMYy9aelhndkwwV3VEUzMr?=
 =?utf-8?B?L2k3eU54Zmd6dlAvekRvOGltcURBbHQ0cUxEVk5QbnNNUUdZb2pZVi9TcWxE?=
 =?utf-8?B?aURVZWpZWEhlTy8vVFdUc01SejFocGpJUDVHOXVRUjF0RXY4STlrQnFrRkVi?=
 =?utf-8?B?VkRtOW12ZjhiZVJnd0ZaSDFnTFA4dXZ5bm95T294ekdtdm1zRkVjWGJyYzNr?=
 =?utf-8?B?ci8zQ3ZNV0pjYW5BZDlTV3A5UFRFQkRmdHdaa0g2WXB1dW9iU1o3d3A5TGFT?=
 =?utf-8?B?VXJXc3RLSUVRYVhtWE1DRUFxMjNGdEJiTUwwNzE2RXI4eC9KRWxwMVZyMGJu?=
 =?utf-8?B?dk85aENxWDNIOTFodndQM1VLeXdiSWhtbDAwTHZVdEhsQTJiOVRIUmVVQ2th?=
 =?utf-8?B?NWRrcSsxOWx4NDB2bVNIK0FjMENSTVkvUXpDQWZLb3prcVFMR0JvbTF6QnZJ?=
 =?utf-8?B?bTBYYjhvK0RKdGRwazh2OVZKQ1F5U3luZWtIR25VVkdTMmp4MjNWM0Z1Ykww?=
 =?utf-8?B?cDZOU1J5TXZneHplKytJeHAyTXdXeHlCMjk2clBrc0liZk1CTE4zcDBrTUpk?=
 =?utf-8?B?TGFSVjdWdGw4bThXaWEybEV1UmdvbDNiczRUZ3NKenVMWWFqTlYyeE9velVF?=
 =?utf-8?B?UU16RC9mZ2IxK1NRdDQ5cnV5NlBzbUFFblpuYkNjaFpXa2JVajUvdzJ0TjF0?=
 =?utf-8?B?Y3BXMjZiTlR4ci84cWdOY0FkUFh4S3lqNVg1V1M5a2hBQXdGclR0TkFEbjJ6?=
 =?utf-8?B?UmtUSnVhclE0K0FSaHFoazc5RG1JNk8xR2xnRlBBeW1IRGp0YktWc0RvR0lu?=
 =?utf-8?B?cW1yMTRFVW1xUHl1TlgwVjVNbUFZV2hFa2tIempYWTl5b2EzZkpuRkJiWDJW?=
 =?utf-8?B?UlA2ZXBFSkUzdFZIQUthc2liNHA0OFA5Vmg3dzlQK2UyeTFkQ2xzanpFUjdP?=
 =?utf-8?B?S21hQWs0cmdMTWRhcm9UTTkxR01CM3piK3c4VGF5ZkUzQmNETHdST0wvblN3?=
 =?utf-8?B?SGhRV3llVElXWHFDTk96ZEFaMnE5SytDWkF2UTdBSlI3SGZFeFVyZFhESUhs?=
 =?utf-8?B?VnpRY1B2YU1zejV6REFWMTllbUdtK05xTDA1YjU2dkVvT0Q1NXM1Z1F3eDJH?=
 =?utf-8?B?RmJXaHpTZFVvVDg5aUdyNzhQVnU3MlZxMk9ZV2pBUnpqWmdQVjVBR2RQNWFx?=
 =?utf-8?B?dTk1bmJ1bXg0ejBWUkxOcENPSWpkK2pRY1l4VU42dXNXZHVQKzVsVnlNd253?=
 =?utf-8?B?bWNmVEw3OTAvTXlSWGx4N3Nic1RJNDRWc3JqK090NVAxRkFQQWJSSHp5bkFa?=
 =?utf-8?B?d1FTNHRRbm43bE15QXo0NU52MGVWZ3dEMjl5MDRnQnR3OWx0WTM0MW84WUl3?=
 =?utf-8?B?Q244R0RJNFN2RG9YakZ3MXR3d2JQVVVmeXlha2xHOFR0Y2JKbEdnL3NiWElC?=
 =?utf-8?B?MFkvbEVZWVlIN2lLemRYb3ZPUkFxYUhub2lWNlk4WVBvbnVFcGxwekVZN3l4?=
 =?utf-8?B?VUhtUFRxeFBzVWxYUGp5dWx0TENheHh6SkJQWGRCTFdZSUp0cmcyNUcxUDBu?=
 =?utf-8?B?Ny81Yno2SEhzTkdMVFUyWHZoK3RudEg4cTNkNENrdVpHbmVIelpRakZza2ZW?=
 =?utf-8?Q?CrLElmXvSOiNp0qnpk/71LpddafiqCtx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96047a94-3eea-41cb-5681-08da0ce21d71
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 15:30:52.5748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPleFGd4jPc99PFVSDajAbyKaNN0rRD1LTs+30iMuUj28KurbEgivDkOUuR/2LafKdWGFNDpEwXS1d15mhvu3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_083056_625882_2894C6CC 
X-CRM114-Status: UNSURE (   8.13  )
X-CRM114-Notice: Please train this message.
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


On 3/23/2022 12:49 PM, Sagi Grimberg wrote:
>
>> should we have the same commit for iser Target ?
>>
>> it uses schedule_delayed_work & flush_scheduled_work as well..
>
> We should. Can you send a patch? Or should I?

I'll send a patch.



