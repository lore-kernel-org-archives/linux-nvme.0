Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6AAC5ACD8
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 09:46:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482E420674
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 09:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KbPvC4nm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UuMcl5AV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6cTjX7IejXsnZjaRT+YoODB+qrTcDqHiboGnqx7ugXI=; b=KbPvC4nmT6IV8nhshOpy1PQfZ
	jkFvRagH6jRXE7V8K8OFobuyR6PFfE6lqYzbtGdQHljGn47Z2KHdZ0ljhJeru1DR1CnehTkmxiKbf
	OLAgVG3RDS091fl0gqHYiEJ3tPeR1IKZjh1y8pBPgu+CE5j/zcWRKgL6hnh+hSST374a+wdyAOcqg
	8T+Y7rGo4w8jlNKsJJu/JnUOTO4bUwgnNwncHmMkwRARqi3kEOsKgBrCJ2/n8VEzWfOJVNfh+PNx9
	iXD0//oFRJD68RPqYJCzP+jICNTClvrbO2uXLn9DYJ0ns/txZaxFIybCpUbOgdtWFS/q58+bAnxLX
	ueOPhgPzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEVHl-00032H-Rv; Wed, 18 Mar 2020 09:46:49 +0000
Received: from mail-ve1eur02on060d.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::60d]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEVHi-00031W-LT
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 09:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqUlehA/lc8QmatwTMUCdhxkSudNnbgk3imJiwfPcBNSq39G5x837jPNUBi/uxTDcyztw30FtW7V7SYWw7NSIfcIXBmifScATVeyrt639Yj5xWOWPsBlIK00vR5P/HvVkNzVTwHNYW8WQATdPya9cqo84hmJ1gpUGhdbRpj6TlLBccxwpChI5r8pMQwl2PHA3i3ZevMB/eG9RJ2uauPDiXITxzEVp2SBJtEPaaZOFGIr7ECVSnEUJxChPDQ4B7LHK/HZOYebHwgmWnQv7cx6s/K79xIv/P6aYaJgfa2pxI5UGSccA9BpWnvB+go5xlu6iOHecZdg3Gw9m6NMvmk3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYh0bEZhM2Cy8/mwA2njpJis7HVmDRwe+CtFCmPYDds=;
 b=mxrsrz/qeX21ytW05CECSPuIhTKCxcyUChG8kcyjq0LOkU8WbG+j7/XS2H/Hujenu/PycQNmaB1h4nPsNMNvKIva/YU5v7vBQ8fFo1xf/ThDGVUMoX6pJ17soAicplPfu0aeY+ofLkoDMiVmh4UivPy9KXFHaLHqkcRzraicRZpxZ6ACmSA++vH0r5iXuGsvWEZ9tGBQ5HKNSST4jRltrsTnfGiOxCOc2l65i0RCE5aVOMahoS3A0N8BRCa57LrqwgBpINYXVCeNL3OS4xa7NzEReUTKCybkV6fush+nW8VZioByesGC4i7zkOfpkc6N+rQmmM6uNXvxyVHrUIBuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYh0bEZhM2Cy8/mwA2njpJis7HVmDRwe+CtFCmPYDds=;
 b=UuMcl5AV7ReaJlccv7zZXFKllKTW1q6OqEYwyx5G3JBo+MbUxcEj2esTfIpCuYO9j6UbXl9vtIChX/gVVmcxqg/MAP8X7Vxk/jrrDPKn6pMh6kd/duR7SUX13Zk+X65X8BBEB7dGlBUNwuf2wnVn92AFlixvMIQsbgNW2UY1Ll4=
Received: from AM4PR0101CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::31) by AM0PR05MB4500.eurprd05.prod.outlook.com
 (2603:10a6:208:63::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 18 Mar
 2020 09:46:40 +0000
Received: from VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:200:41:cafe::47) by AM4PR0101CA0063.outlook.office365.com
 (2603:10a6:200:41::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 18 Mar 2020 09:46:40 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT028.mail.protection.outlook.com (10.152.18.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 18 Mar 2020 09:46:38 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 18 Mar 2020 11:46:37
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 18 Mar 2020 11:46:37 +0200
Received: from [172.27.15.134] (172.27.15.134) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Wed, 18 Mar 2020 11:46:20 +0200
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
To: Leon Romanovsky <leonro@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com> <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200318064724.GP3351@unreal>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ec3ff6af-dd68-d049-5ff3-0c01320117e7@mellanox.com>
Date: Wed, 18 Mar 2020 11:46:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318064724.GP3351@unreal>
Content-Language: en-US
X-Originating-IP: [172.27.15.134]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(199004)(46966005)(8936002)(2616005)(5660300002)(26005)(81156014)(37006003)(186003)(478600001)(54906003)(8676002)(16576012)(316002)(36756003)(47076004)(336012)(53546011)(36906005)(2906002)(31686004)(70586007)(4326008)(31696002)(70206006)(16526019)(356004)(6636002)(107886003)(81166006)(86362001)(6862004)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB4500; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73dc4955-0f3d-4152-718f-08d7cb214251
X-MS-TrafficTypeDiagnostic: AM0PR05MB4500:
X-Microsoft-Antispam-PRVS: <AM0PR05MB450079686C3B53471702C485B6F70@AM0PR05MB4500.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03468CBA43
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urux1ov2shGcrSuKz4aCBaoN+kJyZalsiL+J35T70bR1XeCkJXyqnec8QFoSerJU6bxNrx51L/aVttVHwW8QoIywj0FvH0dK9hTpl/3ZwgI/J+b1ecJF1Kyd4GZRFy8X0tK/mdhxtLv+3KN9wDHixlEnXiBLLHXCpaclDSpmUkG1Y4DyHnwkxcnFzOzMn6WUdVS5u0zQ0FhPLrk3cYDRhoB/ObrlsgPuXId6bjrF7g0yDPB2MHZ0yjciGM6hZW7Nllr2HJL93r7gtgth8hSHyOtgfHnxCnDP6f3cl5CssAkktHg6UHV54yyX0evSjPq8HRHIijmFG1/5tGMVWDxLXMeNhfKJsWyoP8YEzV6yLkK/yxPOVpTpCqZAkuNzf8ysdjuqQtrE+Zb7EfLp7OKce8GP9JKI+OPbbZOODh/znHnaHW0ih+FYEF1rnNRwY/0uEMCheshmxkfY1BpgotL9KxA4UbDmUuN2AZ/4tmcmKspkhOUhkZIQ2XyF/1Z+NK7m74yuP1U0w4JT+wcLn8JC/MP+C2egczOY1UPqysuYoOc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 09:46:38.9566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dc4955-0f3d-4152-718f-08d7cb214251
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4500
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_024646_708102_7723A287 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: loberman@redhat.com, bvanassche@acm.org, vladimirk@mellanox.com,
 shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, dledford@redhat.com,
 jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/18/2020 8:47 AM, Leon Romanovsky wrote:
> On Tue, Mar 17, 2020 at 06:37:57PM +0200, Max Gurtovoy wrote:
>> On 3/17/2020 3:55 PM, Leon Romanovsky wrote:
>>> On Tue, Mar 17, 2020 at 03:40:26PM +0200, Max Gurtovoy wrote:
>>>> ULP's can use this API to create/destroy SRQ's with the same
>>>> characteristics for implementing a logic that aimed to save resources
>>>> without significant performance penalty (e.g. create SRQ per completion
>>>> vector and use shared receive buffers for multiple controllers of the
>>>> ULP).
>>>>
>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>> ---
>>>>    drivers/infiniband/core/Makefile  |  2 +-
>>>>    drivers/infiniband/core/srq_set.c | 78 +++++++++++++++++++++++++++++++++++++++
>>>>    drivers/infiniband/core/verbs.c   |  4 ++
>>>>    include/rdma/ib_verbs.h           |  5 +++
>>>>    include/rdma/srq_set.h            | 18 +++++++++
>>>>    5 files changed, 106 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/infiniband/core/srq_set.c
>>>>    create mode 100644 include/rdma/srq_set.h
>>>>
>>>> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
>>>> index d1b14887..1d3eaec 100644
>>>> --- a/drivers/infiniband/core/Makefile
>>>> +++ b/drivers/infiniband/core/Makefile
>>>> @@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
>>>>    				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
>>>>    				multicast.o mad.o smi.o agent.o mad_rmpp.o \
>>>>    				nldev.o restrack.o counters.o ib_core_uverbs.o \
>>>> -				trace.o
>>>> +				trace.o srq_set.o
>>> Why did you call it "srq_set.c" and not "srq.c"?
>> because it's not a SRQ API but SRQ-set API.
> I would say that it is SRQ-pool and not SRQ-set API.

If you have some other idea for an API, please share with us.

I've created this API in core layer to make the life of the ULPs easier 
and we can see that it's very easy to add this feature to ULPs and get a 
big benefit of it.

>
> Thanks

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
