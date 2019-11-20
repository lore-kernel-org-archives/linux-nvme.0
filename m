Return-Path: <SRS0=lFsX=ZM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2052BC432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 10:43:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F5B2243F
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 10:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qVhp/8cO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="QEPeBFlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F5B2243F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9N4iqvjjFyuAVyY8s1K6tUPap9THTZDPz4JHY6rMTBE=; b=qVhp/8cOhV2oRvi+zESHmSrVY
	G0DMeY44krIrOXMdHz8obEJqdGV+WQwi9gnHa4HcVCFHR6/cenuZC1DGsf9AdrirpfVDOq4tc2haG
	68MewP4lH8lM/9WMmZU9I2thLG0fdiV74YMFsudoIfohTT9RLhKvSrTNEYwVLElzs055MgtAhluqB
	eqvnOCX37DSwTKVBsY8izVxAsfnVmvTNp+ak5u0ecbtHqFwM4WsFIGN4NT/lBhv8VCrmydQ3ADD2a
	xfyn3deckOs19xxFeQmnqoVX9+5+kjYZlZBeUmeFVgsykg6O8W55o+9hDd4PG+iIgU5I8CflQOKU+
	bctmQG0kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXNSC-0003vn-6Y; Wed, 20 Nov 2019 10:43:20 +0000
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXNS8-0003uj-KL
 for linux-nvme@lists.infradead.org; Wed, 20 Nov 2019 10:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6/DHoYsOdFkMgfUPO7wNjXptl1dikyVSiAdY5psZHM8d/xBmsijjsv21yCU75Qvt136jOJZJuhH/Albup32Tlpplh8yVeGFy0cyJ2+ZSbz1s+T3/4Lg30J0VJObCWjlVMCjrGjy3UtpybUIl73DAQUPFHvXNBleKLDqyPMJ+B56RkPpn/RpbdVRIlH7fQ/I73/pf6uXK7VR0NhqX7lwI1dq2Y00wLJVf7LXMePmjj6IMWdxhFirhAsA1ylkfsi9Jz2QlYBvFrU/oc5popxh/xyaJrQ6RogMWXTAtYzALuihtxV+ibdOx1mZKXNXS05dHKPIIW9Qw5C5AEAKPPqZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjGQ0oNafmqL2kxwxJD1XsdLngCjEYmjIGyFKcLtOYw=;
 b=XDgrvCsBvHOklQr3+SL3kT71BsykPcoAowH5QuIo7ZtuvG2qkmbfjDCA1zR+Gy4E5WLs1uW/OwImusWu6ywP8ydDcDohepn/fqfkZxHHj3Q1jpqCwx665X32nJnJVxOFeFqJmmNmu+oDC+oLosLyBIYZuNXCvv/fnTCpjazfUsgsEaLygbBYQLXYYWYSqXiv6ESkOytNHZcwBc4OLc/lgej0ZFaTj2fnhuU5x0QLFcvOBjTKoOKhCmBM5p1tgMebl3j6+Nql0ehAn4xmrWoFHXTooFpSAUKXyUZ7xoi35MM2neXwSEBbBAnXCuPLO+V6w3fs/jeDuEx0NwfODc9O2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=grimberg.me smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjGQ0oNafmqL2kxwxJD1XsdLngCjEYmjIGyFKcLtOYw=;
 b=QEPeBFlh0moQv8DcsnKs2q855DIDzYVtVnxul8oVdBnLNPvYX3KvzMu0s99cWteSnGz5GjqlPmkTNqu6yToXgiaeIv/x/pqklssyVN1LPC4MFOCkipGE0qjcicT3HNCED4+ja0isAGkDoHm6hYYXFn8P8bG/4130m22XzenHQXE=
Received: from AM6PR0502CA0056.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::33) by AM0PR05MB4577.eurprd05.prod.outlook.com
 (2603:10a6:208:b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.27; Wed, 20 Nov
 2019 10:43:11 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by AM6PR0502CA0056.outlook.office365.com
 (2603:10a6:20b:56::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26 via Frontend
 Transport; Wed, 20 Nov 2019 10:43:11 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2474.17 via Frontend Transport; Wed, 20 Nov 2019 10:43:10 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 20 Nov 2019 12:43:09
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 20 Nov 2019 12:43:09 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 20 Nov 2019 12:37:42
 +0200
Subject: Re: [PATCH 05/15] nvme-rdma: Add metadata/T10-PI support
To: Christoph Hellwig <hch@lst.de>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-7-maxg@mellanox.com> <20191105175812.GE18972@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <40d486aa-756b-bc28-9ac9-5a486dadc07a@mellanox.com>
Date: Wed, 20 Nov 2019 12:41:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191105175812.GE18972@lst.de>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(31686004)(50466002)(478600001)(14444005)(86362001)(58126008)(70586007)(70206006)(8676002)(5660300002)(16576012)(4326008)(47776003)(81166006)(81156014)(230700001)(7736002)(316002)(6116002)(3846002)(23676004)(446003)(53546011)(11346002)(2906002)(26005)(2486003)(76176011)(476003)(336012)(6916009)(305945005)(36756003)(2616005)(6666004)(126002)(356004)(486006)(186003)(8936002)(65956001)(54906003)(6246003)(106002)(31696002)(107886003)(65806001)(16526019)(229853002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB4577; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f5adbb-325e-4e32-c746-08d76da67041
X-MS-TrafficTypeDiagnostic: AM0PR05MB4577:
X-Microsoft-Antispam-PRVS: <AM0PR05MB4577FB067E1EE9972D12D1BEB64F0@AM0PR05MB4577.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJDWWhwBVo7fexqhZxUSXKjxA2YE6sG0ONMB+lB4uR6gn2qtOVvGUpEexw+KhU26Dexk65R4EcMBRP/qtMwcEUs2K0z/dy9dcOxNSMdiXy/vaN3mcn/80e+jjrEhzcPqgtgtdi1hYsdKrIlC/NSlQ1LHbM1HZmw/aiC09vAPYBjd0EOK/2rlaj9PfALWTYjTmhrPczTmTdnEr0+4FguHDUjAh1kZyx1JFgjEs2XG5R9y0Bq9tAMyfDez3ens9rVodPe2VSjxFe8Xo8aGkJtX7uTW9xqsrk2DhfPhM8t9GoMa54gsEGMFcTr2wjivuIuI/LoJvc1rqEHOXm5be8mkan3TrH5/+Ghq8QR7d2vZZFfupmr9vHu6cTK/4icpkNEAJjSWpQRdDI/1cx2ZrU/I7B7hErQO20seeb79GWpsZZ91MItS2t2FOsbdgkO5GHXj
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 10:43:10.9700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f5adbb-325e-4e32-c746-08d76da67041
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4577
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191120_024316_809615_0E50F144 
X-CRM114-Status: GOOD (  17.49  )
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/5/2019 7:58 PM, Christoph Hellwig wrote:
> On Tue, Nov 05, 2019 at 06:20:16PM +0200, Max Gurtovoy wrote:
>> For capable HCAs (e.g. ConnectX-4/ConnectX-5) this will allow end-to-end
>> protection information passthrough and validation for NVMe over RDMA
>> transport. Metadata offload support was implemented over the new RDMA
>> signature verbs API and it is enabled per controller by using nvme-cli.
>>
>> usage example:
>> nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> ---
>>   drivers/nvme/host/rdma.c | 346 ++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 298 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 05f2dfa..16263b8 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -48,6 +48,12 @@ struct nvme_rdma_qe {
>>   	u64			dma;
>>   };
>>   
>> +struct nvme_rdma_sgl {
>> +	int			nents;
>> +	struct sg_table		sg_table;
>> +	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
> I think this needs some rework.  Kill the first_sgl pointer, and then
> just set the pointer in the table to address found by pointer
> arithmetics behind the nvme_request in the allocation.
>
> We also have an open todo item to not actually allocate SG_CHUNK_SIZE
> entries, but a much smaller value like in SCSI.

do you mean to use "real" SGL chain in NVMf/RDMA code ?

We can do it as a separate preparation commit. But we need to make sure 
that the performance will not be effected from this change.


>
> Also the whole switch to use struct sg_table should be a separate prep
> patch.
>
>> -	struct sg_table		sg_table;
>> -	struct scatterlist	first_sgl[];
>> +	/* T10-PI support */
>> +	bool			is_protected;
> This is a bit of an odd variable name.  Why not use_pi or something like
> that?
>
> Also all the new code should only be built if CONFIG_BLK_DEV_INTEGRITY
> is set.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
