Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598FC33C9E
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 12:02:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C30206DA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 12:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qXGg/kJL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="SCa+5cKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C30206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ke/eQSJUDClAdOZ7HqUKcVtzcpOXcJSExyjEwVc1QHA=; b=qXGg/kJLEkkCpSeAWn1Jge7+2
	woHDBSwS7YhFLZOWJtrSBZ4zO4GDeL0ifcc2wmqjNyMwfF1ssAA5avJMHBTTCit0rvbCpJkxfhXE+
	XvekuJquD2bxjAITHs94BfK2w0GJJVgHCdpqVfA4+zo8asbmad1AmQvA4bbLzsJjHCHHzTnXZfWFi
	L1vM2XPEY/ViH3nvYwG5K/cA94+KP89hMAMi8ZN8i/gZfTahiPjEwpaJ5r583oO4S5oxnHapXn+UI
	j22JXf5wFDDKzn5as87RQowpqN6fWg2AVDX21GhKBaRxCjsd5O3brh7i67sDSyX0ErEaJ6P7IiSsj
	uvIWAKULw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipA2C-0005fi-9M; Wed, 08 Jan 2020 12:02:00 +0000
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipA29-0005f4-5k
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 12:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz2IfkHCGtCXT4d4ATWMUQCY5cO1n7NZzJtD00+jsn+oUxmQDTVGR0OzNalHNS22XEeBSvd2Wi4fDqewQ5/HNIUnMe+boy3cJgF3oOcuVdOvz1OgNCmbFxItEKOz67ZoWJR0eXXvr1RLUb+qFDoEZLHYx4y8NTWs0MtNXexiu2hNtVcUC0UfbmTZ8MM4xQuPAEH7rSVwmhsyp4mrVD15ozfYgR4CbZ6jYD7uXpvKEK4XTMfypbVc5mmOJtnl/Gdur2aaIP05FS1hrENbSlPDEHOlCl+3U+btk3SnkJ0wyA5x8ezJcr0iRxYuNORE0ZWBKLVCmhmLKVwIw/5VFLcaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN9rcVb6zta6u/ex0y/wCSpRz9zM/wqFYrlT/IEU5Xk=;
 b=dKidDwpB4diTnxnk1dEsqob7O4SC7Mlk2tcYV72sjIvKx/e/3SyTK0JmBtqKqfHZApgnKla9w84SQD2L5jHNZewERsxIHxtdgiIGWkQimMkH4+96wJp69Fz8Mj+iz8vzSny7bpO7UMUiALg2gOd6bQmDTE0mSmTzz1Dua3NkHifCJdE486dH946EianpdharzyIB29uKGEFqZI1RCvH/09osZGOP0MP3Qdk7yAUq7bG2lZ9qmsskNGJSrgftCp9pckWCKIoyurBilK7k6a4jklTt6Z/rW2+hFd7tY4mGCRJanlryjMUSxdKIVSgW+gbfAZOduMqdh+1VJZTgUnLjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.dk smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN9rcVb6zta6u/ex0y/wCSpRz9zM/wqFYrlT/IEU5Xk=;
 b=SCa+5cKvvqNmwyoXf3umh3wgiHyme9SW/l2YuXFkYEVOCUP5MyIgkUrSLJBErwyfouuihMqzpUut0UiB/jqe3bhYItmsfQho4tS4kfE6Jcj8460X69CGZ+ImcAAyn0s/Cgwg7dLuu33IR5yrc5V3zLFVW9TxjLnHeGbvzyunlB4=
Received: from AM0PR05CA0063.eurprd05.prod.outlook.com (2603:10a6:208:be::40)
 by DB8PR05MB6636.eurprd05.prod.outlook.com (2603:10a6:10:141::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Wed, 8 Jan
 2020 12:01:50 +0000
Received: from VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by AM0PR05CA0063.outlook.office365.com
 (2603:10a6:208:be::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend
 Transport; Wed, 8 Jan 2020 12:01:50 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT057.mail.protection.outlook.com (10.152.19.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 8 Jan 2020 12:01:50 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 8 Jan 2020 14:01:48
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 8 Jan 2020 14:01:48 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 8 Jan 2020 14:01:07
 +0200
Subject: Re: [PATCH 01/15] nvme: Introduce namespace features flag
To: Keith Busch <kbusch@kernel.org>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-3-maxg@mellanox.com>
 <20200107180716.GA603371@chuupie.wdl.wdc.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a243f1cb-3564-d839-7a5c-44c19409ce79@mellanox.com>
Date: Wed, 8 Jan 2020 14:00:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200107180716.GA603371@chuupie.wdl.wdc.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(81156014)(81166006)(36756003)(70586007)(53546011)(31696002)(5660300002)(8676002)(70206006)(36906005)(356004)(6666004)(54906003)(107886003)(8936002)(316002)(26005)(186003)(4326008)(86362001)(16576012)(16526019)(2616005)(478600001)(2906002)(336012)(6916009)(31686004)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8PR05MB6636; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5813acb-d985-4d31-64b5-08d794328b52
X-MS-TrafficTypeDiagnostic: DB8PR05MB6636:
X-Microsoft-Antispam-PRVS: <DB8PR05MB66367A5FB2DA859AE794BA5DB63E0@DB8PR05MB6636.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zCOU22HpsBXdCPm8pQzuAUIbcNHz8QdJHPhpnu6Qo9CeneQ+5rntH1U14lRyr3fUXtstQpIHSFAmzCULf3Wy7yY6dYSIKjAfZ067zEn6fi2U11Yxj3rPkYjbSMtWPKC6l8Xehqyua4w+OrlnZPr5gomQ1qIW2WGJoRbsbga+IWXMVlpINaXEphpEM5qC+aR7ITEAbirsyw7ache+slZxGzK9nuNj15pa1a0ccJb+Nxox2Xd2c3SU/cqzwxTC/vXubHIxO47tExDDcqUr4G/CMDIe8JW07Ay1mBisYFnVt5cBby2zSVNua/AopO58J4hSN/WBiWIn6pNIcBG1Pz/ndAtwnPlo7QXhXtHDhMm1uePECVUipV51UCSRFt7DxuCYn0aIEjRGqWYjrEgJ4MXZ2wDtu5K/aQJykWcFR8kUCee9rpWrrry20WA4UKVc2tjfz791JSLZgmh2z/ixhxmBgbyLZisN9Wm9O2m9C4WRaPi17F5EZUBWcEA5q9LvC09
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 12:01:50.0594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5813acb-d985-4d31-64b5-08d794328b52
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6636
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_040157_219347_D2E87292 
X-CRM114-Status: GOOD (  17.23  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, sagi@grimberg.me, martin.petersen@oracle.com,
 shlomin@mellanox.com, israelr@mellanox.com, vladimirk@mellanox.com,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, oren@mellanox.com,
 hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/7/2020 8:07 PM, Keith Busch wrote:
> On Mon, Jan 06, 2020 at 03:37:22PM +0200, Max Gurtovoy wrote:
>> From: Israel Rukshin <israelr@mellanox.com>
>>
>> Centralize all the integrity checks to one place and make the code more
>> readable. Also add has_pi field to the nvme_req structure as well, so the
>> transport drivers could use it.
> I think the two changes should be in different patches, splitting the
> namespace "features" flags from nvme_request "has_pi". I'm not even
> sure there's a need for the per-IO settings and checks for "has_pi",
> though. I don't find any transport driver changes in this series using
> this flag outside this patch.

Sure, we can split it to 2 commits.

"has_pi" flag is used by RDMA transport (commit 7/15 "nvme-rdma: Add 
metadata/T10-PI support")

>   
>> @@ -1834,12 +1831,29 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>> +	if (ns->ms) {
>> +		if (id->flbas & NVME_NS_FLBAS_META_EXT)
>> +			ns->features |= NVME_NS_EXT_LBAS;
>> +
>> +		/*
>> +		 * For PCI, Extended logical block will be generated by the
>> +		 * controller.
>> +		 */
>> +		if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) {
>> +			if (!(ns->features & NVME_NS_EXT_LBAS))
> A little simpler:
>
> 		if (id->flbas & NVME_NS_FLBAS_META_EXT)
> 			ns->features |= NVME_NS_EXT_LBAS;
> 		else if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
> 			ns->features |= NVME_NS_DIX_SUPPORTED;

In fabrics case this will not be true...

>
>> +				ns->features |= NVME_NS_DIX_SUPPORTED;
>> +		}
>> +	}
> It's not really a "DIX" flag since we can observe separate metadata
> formats for non-DIX related use. Can we use a more generic name for this
> feature flag? maybe "NVME_NS_MS_SEPARATE".

The meaning of NVME_NS_DIX_SUPPORTED is that the block layer is 
*allowed* to send metadata to the namespace (and we later on will call 
nvme_init_integrity).

In case of PCI transport, this will be set only if the SSD use 
"separate" mode since Linux block layer only support "separate" mode and 
the nvme_pci driver pass these buffers to the drive (no conversion to 
extended mode if needed).

In case of fabrics transport, this will be set only if the user asked 
for metadata support in the connect command (pi_enable). Again, Linux 
block layer will send "separate" buffers and the transport driver will 
transform it to "extended" mode (this is a *must* since in fabrics, 
according to the spec, only extended mode supported).




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
