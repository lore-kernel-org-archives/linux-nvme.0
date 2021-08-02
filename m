Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E4C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 19:39:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C8260E09
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 19:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54C8260E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VLW1OIF+kMlPUJqU8nTcCcTATkh1v1yMsGrxrh+C0Mo=; b=nve3QWQdjISmwyClmS4SbnT13p
	Gzi2+ta3lcqjou9TRNgXcWfYQfpBncNkljlD67oHGE7lOMoeKacNDDHYiN6GRLokTGwBlLrL/3mad
	ddCejo7lVkip5zVoporDj16G1iAzXCAjgaHzdf1GaLt0VBtZlU960+gwpPWi6fkywOCO6ZPTlLIrO
	XLVk2wIeg+efRkEMfAU2sGmuXjHKS3TXUn1r4bWrUtoo48O+YcWHtQM+VHgdH6dSJqt6VjBZgQcl8
	28QSW6Jfcc+niqyqahcEndHPk8gjC5V40fDtofc/9XetANcbYgRoMFqkKk3mI6m0bifD5J8C5YBuB
	C291PF8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAdmM-0004EK-Mo; Mon, 02 Aug 2021 19:39:14 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAdmJ-0004DB-5U
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 19:39:12 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 172JW347005798; Mon, 2 Aug 2021 19:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zrFWPdvt6hMMSDIwrSBgeqOvVqINWuxIrrVvIfF+zOI=;
 b=dIsx/MYD9RFl2t1tRH4k71uXPJwxeuJXnhJBkGupVlUpm5hTc36iOHJJsHyobAlubVxb
 hUciDq8DKjt3PhaA/3xTLtAsOFPwuiqPSMkhkh3htq3OpjKkD0Ql3NgpKPZuXmR+SKGH
 UOkCNG6TW42c65npZ4ZNopdnS+VUEPewv6MQvL/u/Av/JcZKwT8BS7VY3fN+5ZwgC6/l
 lUjljt3o5FAG+GpsiYofnZOXjIg3JSB3Qrf0Nqe8VofSrdqLWNS/ij7joWEh9w9LDx/O
 0OQ2xVcMkLpp8HNw27uHhbwRdEx8276L3uabDCTWY9lG/Nva3+y8pTqizBxsLSIJ5b38 Zw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zrFWPdvt6hMMSDIwrSBgeqOvVqINWuxIrrVvIfF+zOI=;
 b=ADPnsfhYu5QV1+FXYOci6D8TIvcdtfGkSdaa6TTBI5KxB1cbScLi/ZdLZqkrvHppGqfx
 gOkIKZzvTnMnT8+0chkYFX52IaVc0OExnPObrBPBoiES6oG+cwjOr6wTWsiKE+K6yuf9
 Q39dDgNQlQ2jctcxxw07INOCu9bue3Ki4Fk20ruuy3J4OQ5ArI9InUXfypb1VzBSsHR1
 mVoGtYWiV3iMN7x4CscdPm+pD61gxR1Hkd8exVCr8Lc16JB4W87kwoRMovJovNOgIjyp
 wJBemWoMKDyWIIwFYZGAz6GSkO1ribSkcXPCC4lrz6lwxM68d8rhi2b1uq8o57Ezyvu5 CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3a5wy1jeb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Aug 2021 19:39:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 172JU4rI157285;
 Mon, 2 Aug 2021 19:39:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
 by aserp3030.oracle.com with ESMTP id 3a4vjcjgu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Aug 2021 19:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiROqokA9lsJwcB3EgtNH4nWUFU6JMcf26eDbb4V1sFjaBA8oKRiTovCoIdcPqODyhECk1anAGIdQ+5XapqdImXS4or9b+Rce58xulIbyy5zPAGIKifIQ8gwRXqdWMjPXjGiaYCGbxSxmqetSlkFDsA5s5Xzgy3fSrcrMhKJN5pymrKVMP8IYnDv8lDIiZsrhOL0CilfRAJuq00FsjH/k+FZnbUhxnWtYGCRPxZKblbhZXIIzo7OVi8rj+fMM04RRu5EgTBrk4qY2f/WrEE/lfDbvM+4OmwtOSli2JCGrApQykhSYjaxRYAsVMoFkzsbuyhYSvnSgtMn1hz1WC4AXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrFWPdvt6hMMSDIwrSBgeqOvVqINWuxIrrVvIfF+zOI=;
 b=Gm80X6MtPPKxx1OAX6pdSENPFXWEkxb/ckULFUuEuBsJZSJLngrH0Iqofv/uivpJ4Dm/7bpuosKciOpA1z30BrbjVtJ1cMa7DAx1g5HOUKPDe90XkQSB9irNzKzvIM3rz8sm//jB4UN1DKu/6j+sAyouhJ8qro/H+ALYpiBsS4u99EEHpcgw8pgSWn+icCbVsg94RJy0jwSF++kN3JE9QvbN1ndTw7AbBmUOFR91djhq50+o/yIufpeOD9qgvbbBhEBBaPVXmsko8fd+mL+EBj2uy5JyG3wJl5/IEXTY0UpD05eDlP6uqG0nhHnFlSRDO91wpiyNeDcFf3rfCihrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrFWPdvt6hMMSDIwrSBgeqOvVqINWuxIrrVvIfF+zOI=;
 b=kTH8+P08VNroPxTdHhRm8gj79W0OESkc7m4cDVlQVfbtcxoJS8S022LyC7DebvAaM2sEAjLidUmSLToCb1tmevLmN1hMrkwHGkHlfkgkMr1C6V0VrSVVG7gjQg3//QsLuhbMqSJhB9sWg45+cre5YGv8M+1jy8P34K5EMuDvj4g=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4604.namprd10.prod.outlook.com (2603:10b6:806:11c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Mon, 2 Aug
 2021 19:39:04 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::7c0c:7f1d:bbb2:b43]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::7c0c:7f1d:bbb2:b43%5]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 19:39:04 +0000
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, James Smart <jsmart2021@gmail.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <a2049faa-888c-af80-9401-a8ba4defec53@oracle.com>
Date: Mon, 2 Aug 2021 14:39:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802112658.75875-7-dwagner@suse.de>
Content-Language: en-US
X-ClientProxiedBy: BYAPR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:a03:60::35) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:93:8000::b52] (2606:b400:8004:44::1e) by
 BYAPR07CA0058.namprd07.prod.outlook.com (2603:10b6:a03:60::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17 via Frontend Transport; Mon, 2 Aug 2021 19:39:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59f32dd6-0f18-4ac9-d142-08d955ed2f7a
X-MS-TrafficTypeDiagnostic: SA2PR10MB4604:
X-Microsoft-Antispam-PRVS: <SA2PR10MB460453AFA897F14E8AD42F90E6EF9@SA2PR10MB4604.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38bEKlDM7bwP2IqtTBV6bMPeo8kCkMcfgeEKIjmBQXiynQsf4I02+63ixbdF1fA5GElM4lluc8R91EieSFY54T/03XAf7F7pNSHJtbRmyDIPtmGrMsAIEPs3MuEankFag0pLdo2Wvx5YtLxN+SGKIhg1QIc8O3CJNMJivqu2bIxQDD08x5uyUPstQ5iUEuXiQ02W0iYZNtwMvdKV8lz8Dw+edgPNrsDF+K7mK3ed4fwPcdVMBq5IOxxdP3NFGAKCg0pIpZJgDcVq1L3M2KYJ9p+xq3GpedFQuMtA9PpElwUb7ufeLIu0o3B0lH4Fs7sXhMvgSmUrLCxCvYdOHVyEV8CHx4sRB15WVzQvqcA59aBDZrNJhvZ/mUBRSmq/mhZRiESzuTVwwhiWnRvoZLr3OvRtozsIOznRWc8qrtmzuQS28XKJc7Z2wKNVHDV7Zb6sYwvkOA3S1Z6QQghOrVqgy1V1LII2n3qnPg/FeDa2rYMOdcK8aL49yY3qne29XSeAEro8yK50m4u+fiQODzwa5F1/bxR/dD8mAY8WY2GEcv7RRSK3lfzvULmD4SJNgdsSzgbK1f9JnaZt3Kn5Pv/ZoIGEU76fXLVRW/B2X1A4jB2CwtVcnpXvY9gKkIl1zJ84fkJztSTDIRfsaVSztGKeWmybv9TJkcN1mngYxefWnMojAFTN9xbzK+kHK0yWzMp8WLIT5YPQj1seAjFI/+7jbKy/WJ8iO9Ir7RnsRfOuDD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(346002)(136003)(376002)(39860400002)(396003)(38100700002)(2616005)(66946007)(316002)(86362001)(83380400001)(186003)(53546011)(5660300002)(44832011)(54906003)(2906002)(8676002)(36756003)(36916002)(7416002)(66476007)(66556008)(31686004)(478600001)(4326008)(8936002)(6486002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3c3YjY3clorWERzUnl6RHpOZnZ0R2RRZE9nd3E2RXg0YXBjSGZIaEVDeXFk?=
 =?utf-8?B?OVhrYWZTWHE2ZHMvM0VpSWN0VS9iTTVUUjQwL0FjZkFrOHhmWlcxWHNlckh1?=
 =?utf-8?B?SWx0NHBQbTYzeXRlNzJRR01VRjRlQ1VYbVk0MjZweFMxM3lQNzVWTVY1TjNJ?=
 =?utf-8?B?eDNaSFF0bXlTdjJmQ3hQOFRwZ2VZbE0xUmhOMm01VzhtazhnN1FVeDBkRTNP?=
 =?utf-8?B?dUg4c2MwQTRrVTgzQkdLSVBqUTZsVCtZSUlMQXZ5cHNPZi9Ib0psUHRDOUhl?=
 =?utf-8?B?amIvUDZiRjFiSkQxODltRGM5VlRJcC9QTVRrNGpwejRITTdDTFcvaHNOaTF1?=
 =?utf-8?B?azk0MGF0aEhhcHBXQTdtZFhaZHlmY0VNNkc5cUdRdjduSjRxM29CNUVqSnI3?=
 =?utf-8?B?cFVOYmRwM1NaVXVyNnYzWFRmeVVLTFYzWGJqaFpSRVJaSWd4KzR6cTdwWEZp?=
 =?utf-8?B?WHgrSFhBWFBIQnFON2pZdnY4SksrYzhMaVBsL3NvQkJyK0FJS0hWZkNrd3FS?=
 =?utf-8?B?OVc0aG1CaWl2MmtpT3h5UjFwdk1DeCtrT3VTQTFZN3p3MUpiYTVERFlmNjFs?=
 =?utf-8?B?OVYvWEtPZnRUZjluYkFsbU1sRWhKcmJaRkVhaVl1SklXaG9wNWZoSmsvWlp1?=
 =?utf-8?B?THRQUEwvR0NnYnBhdGRDTXRYQlJRbUVzTjZtOWlQTDFHUjVxUEllM1EvQm40?=
 =?utf-8?B?V2l2OEs5WjJaRTE2U3ZaOHMvaEs5Q24zUmh2MElwb3RaUDBHcDRBdmN2YlZq?=
 =?utf-8?B?V2hvYnBSY3NSbWhsZ1d0ck9ndjMyY0IyNkNNYWlWZzRUVGwrT2JSRm03NHlV?=
 =?utf-8?B?MHRYU3lEMUlJZ1BxWlZjWkZIZ2lNUHJVM0U2NFVQSVVTNmw1ODBnM2VRd01X?=
 =?utf-8?B?ZGJDNkhIbEpRcElpS0JPNFFaOUZJNjR5K29PN3ZUd1FQWjk1T05KOFlJUXlU?=
 =?utf-8?B?T3FYd2d4NDlXa1ByVDlJcXhhYXBERFEvUzdSejN1WGFaemRqci8ybENNM2Rl?=
 =?utf-8?B?aFZ0TU5sVEJ1STQzK1EvWWZOWDlBUE5Ba05raktZeFBWcXQzeDBjMytadDgv?=
 =?utf-8?B?TWlNT0tDYmpPR0tpNEY1aHExc3QvVFFXR01WeFo0MHlVR3dKVGNWK0Izc3Fp?=
 =?utf-8?B?Z0lIMXQxMDc0T0UxdkFqaDFEa1Rydm5hNEhueWlmZWU2V1pReTgyRG5EalFH?=
 =?utf-8?B?dk8veVR0Sm9lZGV0VHUwc1kvRStITkxkWHc5K2p1VWo1KzEyemFuN1IrV25y?=
 =?utf-8?B?bC9Bd1FxcGprbUlHT3VoeWtyRS93K3dkM1dVdWEyTU1jaVplTnI4Vkd3aXhr?=
 =?utf-8?B?ZHJaK3RiUmNTcGYrWDE2Y252N3M4YzlFWlhyTlplK21NYmxQRVhSRDN5NmV2?=
 =?utf-8?B?WHNYYmh0MHVub240Q3NlZkVIVFBXZm53VGRFMERKUXZpSjBnc003LzcwS2pM?=
 =?utf-8?B?eDZnRjR4VlpVbWNjU3l4WWxvKzJ0dENXOU9HY290RG5hQXpRc3dBb2NMdnls?=
 =?utf-8?B?WWZIY3ZzbWVVM2pGTk95dGltdjBjUCt4QXZmWU5BdE4xWVd4d040YUNLSXlx?=
 =?utf-8?B?VnZRaTdrN0Nnc0ZqQ3RPVFg1R0Z5ZkZyQnZSWmZ3TmkvbCtJWGpiZ1p6QnpG?=
 =?utf-8?B?WVVkZ3NmbUg1NHQvM3pUeUJBeFdNTGVvSVpBaXhGZUEvbHlRWXAxR2R1M1Uy?=
 =?utf-8?B?NWxtRWJxNHZ2MEtOdFNmZGRYb0NHSVhsL3UwWUtoZXVrcXVyQ1VGQWx1MDhP?=
 =?utf-8?B?QjRiTFpZbWljQ2xjVHU5T0xqNUtmL3AxU253anFETCtnRDE4RkxOZGNCYmtz?=
 =?utf-8?B?aURJeE1PNGxHVlNwZU5nZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f32dd6-0f18-4ac9-d142-08d955ed2f7a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 19:39:04.2773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Pxf5HjwA053vwxLzscclB72VooCq0yyQPA8gelsgMLzpPrBru8JJpkRCHes1K/nYh9clp0FuvY3pBvmWu132Pl4nbbQXvxaIi1BUjLQLOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4604
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108020125
X-Proofpoint-GUID: PAbxAIcCf7Z8lM9KtW778yGLGBVbiYoD
X-Proofpoint-ORIG-GUID: PAbxAIcCf7Z8lM9KtW778yGLGBVbiYoD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_123911_396529_DA0DF37A 
X-CRM114-Status: GOOD (  31.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/2/21 6:26 AM, Daniel Wagner wrote:
> From: James Smart <jsmart2021@gmail.com>
> 
> commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
> exposed an issue where we may hang trying to wait for queue freeze
> during I/O. We call blk_mq_update_nr_hw_queues which may attempt to freeze
> the queue. However we never started queue freeze when starting the
> reset, which means that we have inflight pending requests that entered the
> queue that we will not complete once the queue is quiesced.
> 
> So start a freeze before we quiesce the queue, and unfreeze the queue
> after we successfully connected the I/O queues (the unfreeze is already
> present in the code). blk_mq_update_nr_hw_queues will be called only
> after we are sure that the queue was already frozen.
> 
> This follows to how the pci driver handles resets.
> 
> This patch added logic introduced in commit 9f98772ba307 "nvme-rdma: fix
> controller reset hang during traffic".
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> CC: Sagi Grimberg <sagi@grimberg.me>
> [dwagner: call nvme_unfreeze() unconditionally in
>            nvme_fc_recreate_io_queues() to match the nvme_start_freeze()]
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 133b87db4f1d..b292af0fd655 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2486,6 +2486,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   	 * (but with error status).
>   	 */
>   	if (ctrl->ctrl.queue_count > 1) {
> +		nvme_start_freeze(&ctrl->ctrl);
>   		nvme_stop_queues(&ctrl->ctrl);
>   		nvme_sync_io_queues(&ctrl->ctrl);
>   		blk_mq_tagset_busy_iter(&ctrl->tag_set,
> @@ -2966,8 +2967,8 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>   			return -ENODEV;
>   		}
>   		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
> -		nvme_unfreeze(&ctrl->ctrl);
>   	}
> +	nvme_unfreeze(&ctrl->ctrl);
>   
>   	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
>   	if (ret)
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
