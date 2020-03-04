Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE6C3F2D1
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29AC20848
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ULRI6ItY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="eQWlPk6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29AC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J9rVO2KvkhLivVO3g+34v+dSPemphcIhHGWMkIP2q0c=; b=ULRI6ItYOJ3vq1CySIwlf9qVF
	2teHnr7QNK2nXsX9J7BlT8Yj2sgBCdMw9Yc+Oe5nVAOVpmcK4228XiWOVO8R2zB5U8/4/eaqZRKmC
	wgY4JwvysorkfDgcmh1sAgs31Rz05Xf+ir16ItpOGCPuoIFILfI03eBZLsYimFVTNlghTMzqWagIH
	PASW9wET8gy48fe5klmExXc2nEA4Ld/NmpSrBV4zPQJKkEBdi4kedFvK2lK0HhtY1gtgyWx5JTgMo
	7cqGFGeNdR5HG76Q/FK8af4OENd+HOkYLBY6SxAeQYWkHXlBsTFvxq528bdt945xjYzxUI9Eo+8kk
	pre/IsdzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9cMo-0002ts-Qq; Wed, 04 Mar 2020 22:19:50 +0000
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9cMk-0002tV-Uo
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 22:19:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPHpTS2MAvhGYDq7PfTt68YWwYI05oi/UQPHpUrRO2+H9VaCz7oKCHMwScHW9lydGqDnYtYAOE+Od9bqLzS9O8PPN9NPbofXbLyP+yDVlrVWf8mQn8mM9SxyzpcGAnZ9hOsXH5TAzkpWHhyeYmyUjqOqv702fBQBvQcrOKEmERyRTlX7H4U4Vwy9gH0+rk/sdUilyZ1bEgiCXthqO7xa8J5QaG92UrTISkFFvkS52NkWegRx4sTEHDe4KxCOrkx2EMvTyEzfp0ORU5+BaLhY8irEUlfAryX+V1RGCAHehtTsBMugsa3llcSH71n/xQNYlcUXt5vn4zJ9MrwWyC4U5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNLyPVnwDaI8kqvgKN40HJzFWLtzpviYO+cOwoejAk0=;
 b=IqA9DIPv1vDOYobIs2ZmQ4sUM1mlAGBZrJEfn7vVVch9ABlURH1zNpiiVldszw6S7evP3IjzbnmweDH3+1YA7z8S2wQcOpSUJ1SSiMHOsgjA8p6RaxnR6v2rjowj6uXrRKn0lfWShHu4bSkH8BUd+LLbhUARbAP51zqpP1s2UX4Aap5YqrE0du1H6wfGI++H6xDeWb1vmJAjN1/d4Mh82ABtTCCuGYQioo6A/FdL/vyWzTR/I5e2oqRGZ4K7EW2HbiHpAKF31ggWqJbQkbfaxvJRQJrYvnUv2c9yU3d5wbCCkdulmoP1vPEyniuFGxPPfDbCYN+BRCpkPxPv0TFa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNLyPVnwDaI8kqvgKN40HJzFWLtzpviYO+cOwoejAk0=;
 b=eQWlPk6AaQKSJtpgwUau0gRIeoRCXtZopHtdXWRHOwAYkIOrG6DwyN+ifBiArDjlLeBdXjLDR51B0MTVbKnEwi2FPLXZjePohi+SQIgS546DswlFheJKGWWLDJqfwTb/TdfUBXSwzp3cKdiW8OpQ7bven28miVHqvbCk8ZcwCHo=
Received: from DB6PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:4:29::13)
 by VI1PR0501MB2336.eurprd05.prod.outlook.com (2603:10a6:800:2c::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 22:19:41 +0000
Received: from DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::67) by DB6PR0202CA0003.outlook.office365.com
 (2603:10a6:4:29::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 22:19:40 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT053.mail.protection.outlook.com (10.152.21.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 22:19:40 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 5 Mar 2020 00:19:39
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 5 Mar 2020 00:19:39 +0200
Received: from [172.27.0.112] (172.27.0.112) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 5 Mar 2020 00:19:01
 +0200
Subject: Re: [PATCH 3/3] nvmet-rdma: allocate RW ctxs according to mdts
To: Krishnamraju Eraparaju <krishna2@chelsio.com>
References: <20200304153935.101063-1-maxg@mellanox.com>
 <20200304153935.101063-3-maxg@mellanox.com>
 <20200304191848.GA30485@chelsio.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <5bef57b6-aade-f074-c1e1-71a1cd93acce@mellanox.com>
Date: Thu, 5 Mar 2020 00:19:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304191848.GA30485@chelsio.com>
Content-Language: en-US
X-Originating-IP: [172.27.0.112]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(356004)(36756003)(16576012)(26005)(316002)(186003)(2616005)(16526019)(336012)(4326008)(31696002)(8676002)(70586007)(81156014)(70206006)(86362001)(81166006)(2906002)(8936002)(45080400002)(6916009)(53546011)(478600001)(5660300002)(31686004)(966005)(54906003)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0501MB2336; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2207015f-c4e3-47e7-0364-08d7c08a223d
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2336:
X-Microsoft-Antispam-PRVS: <VI1PR0501MB233606EBAA1C0413AECCE7CEB6E50@VI1PR0501MB2336.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RiFtPyGUhTq2jUU3n8HWUxTirSZcKUt0eyBW08syCy2HRxZG5ALKTHv9v7hOqr8FIkbQXSvOiX+QiRGVUsfS3zDJnQryO6Yasb4mMiisZ1tgn6Bc6/MigKWTl1nfB7it9Qq4fjmZtNfQ5NO8jbIVzndZUE4pJei6iNAYXdflR4NzCMvflcEqj+29H09aGupFIVdsRPaxhpEw7uPZsW6KO726XoAA/ienX9PT3JthSsgesJlANMIrkCOddvwjSTMWG3GPN0iZsqVspmCONKt/vVHjNsXtPVMdHvrENkwt2gcy67/lwp8CZKDcHhG+EFwxuZ7Yp07NLy8wGHY1GLVOXHggHM3t7XJ1vrzqzZrFtg1meagdgcPuhB1nZPLyGLS00MdtYQGXjp/M05JLDVqghqcHh2b27m/5P+rI5GoC8vhzYG7oeuxrEvsx8kkY+g/52c6VIpWNvQOj6k38VyBzx4VkKrBSGCKMQsvDuNF/Guz1Lyll4jXgwWWlcd44QihYRwV491Z6VekJxNgl7ilvJnD96WpxxgzravvgaO9dG2+LVeKAndtlKvaVKSb+OeDpCJ3Kj5j6gAbqnTLFpa8ODg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 22:19:40.6536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2207015f-c4e3-47e7-0364-08d7c08a223d
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2336
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_141947_067893_26214911 
X-CRM114-Status: GOOD (  28.82  )
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
Cc: sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, bharat@chelsio.com,
 nirranjan@chelsio.com, linux-nvme@lists.infradead.org, jgg@mellanox.com,
 kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/4/2020 9:18 PM, Krishnamraju Eraparaju wrote:
> Hi Max Gurtovoy,
>
> I just tested this patch series, the issue is not occuring with these
> patches.
>
> Have couple of questons:
> - Say both host & target has max_fr_pages size of 128 pages, then
> the number of MRs allocated at target will be twice the size of
> send_queue_size, as NVMET_RDMA_MAX_MDTS is set to 256 pages.
>
> so, in this case, as host can never request an IO of size greater
> than 128 pages, half of the MRs allocated at target will always
> left unused.
>
> If this is true, will this be a concern in future when
> NVMET_RDMA_MAX_MDTS limit is increased, but max_fr_pages
> size of few devices remained at 128 pages?

for this I suggested a configfs entry so a user would be able to 
configure the target mdts as a QoS and/or to save resources.

Currently this suggestion is not accepted but let's re-think about it in 
the future (I think adding some configfs entries for saving resources 
such as q_depth, mdts, num_queues, etc might be helpful for some users).

On the other hand, I didn't limit the mdts even for devices with small 
amount of max_fr_pages in the target side so it will be able to work 
with host the can send "big" IOs (with multiple MRs in the target side).

I think this is the right approach - better support capable devices and 
sometimes allocate more than required from host.

The target acts as a subsystem controller and expose it's mdts, exactly 
as the pci ctrl expose it. Sometimes it's bigger than the max_io_size we 
actually need and it's fine :)

>
>
> - Also, will just passing the optimal mdts(derived based on
> max_fr_pages) to host during ctrl identification fixes this issue
> properly(instead of increasing the max_rdma_ctxs with factor)? I think
> the target doesn't require multiple MRs in this case as host's blk
> max_segments got tuned with target's mdts.
>
> Please correct me if I'm wrong.

Linux host max_io_size is also set to 1MB (if the device is capable for 
it) so you actually won't be needing multiple MRs per IO.

I don't know what's optimal_mdts since some users would like to send 1MB 
IOs and not split it to 4 requests of 256KB in the host side.

And since we use RW api we always need the factor because it might be 
limited by the API one day (today the limit is 256 pages in RW api).

 From your question, I understand that your device can support upto 512K 
IOs but I think it will be good idea not to limit hosts that use other 
devices with target that uses your devices.

>
> Thanks,
> Krishna.
> On Wednesday, March 03/04/20, 2020 at 17:39:35 +0200, Max Gurtovoy wrote:
>> Current nvmet-rdma code allocates MR pool budget based on queue size,
>> assuming both host and target use the same "max_pages_per_mr" count.
>> After limiting the mdts value for RDMA controllers, we know the factor
>> of maximum MR's per IO operation. Thus, make sure MR pool will be
>> sufficient for the required IO depth and IO size.
>>
>> That is, say host's SQ size is 100, then the MR pool budget allocated
>> currently at target will also be 100 MRs. But 100 IO WRITE Requests
>> with 256 sg_count(IO size above 1MB) require 200 MRs when target's
>> "max_pages_per_mr" is 128.
>>
>> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/nvme/target/rdma.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 5ba76d2..a6c9d11 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -976,7 +976,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>>   {
>>   	struct ib_qp_init_attr qp_attr;
>>   	struct nvmet_rdma_device *ndev = queue->dev;
>> -	int comp_vector, nr_cqe, ret, i;
>> +	int comp_vector, nr_cqe, ret, i, factor;
>>   
>>   	/*
>>   	 * Spread the io queues across completion vectors,
>> @@ -1009,7 +1009,9 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>>   	qp_attr.qp_type = IB_QPT_RC;
>>   	/* +1 for drain */
>>   	qp_attr.cap.max_send_wr = queue->send_queue_size + 1;
>> -	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size;
>> +	factor = rdma_rw_mr_factor(ndev->device, queue->cm_id->port_num,
>> +				   1 << NVMET_RDMA_MAX_MDTS);
>> +	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size * factor;
>>   	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
>>   					ndev->device->attrs.max_send_sge);
>>   
>> -- 
>> 1.8.3.1
>>
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C9d945a2bb54543630a1e08d7c070ee88%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C637189463598411223&amp;sdata=xBgbsudv9jqJ0mSOYW37zLFvRbxSQ2cyzyFmWCVMSVQ%3D&amp;reserved=0

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
