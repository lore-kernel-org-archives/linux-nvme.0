Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59092C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 10:42:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD97206BA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 10:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XZ4daH/G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="r37g8Y9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD97206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hxqGcB0RvKIkWxVyp34xivqzJW0xI0caxfe1icXoU8Q=; b=XZ4daH/GKCoMO5Owm5IDB94m9
	7Qqrtmh1uX/XWVjqQ1ttPl04fVM/eBE9PzqriB6rkX9QEVLcWzY3NZS69e391yPd4HGq9QR2NTxJn
	Grd08TmA7/DvuG/fG1Ecz84AWoL5RZbT8LFWnQKfvDcq6xegSRW2keWMkp2b18lEEL5HCnSemjKpc
	trmz0YedYAWwsnJJjqGu2hfTGU56X3jyO4jrJMu3quG4w2c0LNs0+4wKzdwfVavVBzv5cpcTdPxoG
	TU4WNL9/T7mt4t1ij7V8Lzembq/ZsZONXAyFMVdWGSuT7C0A97lrjk6lqRzQCEUYAJw4dtRvAtlPp
	2EcPklogA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUTcy-0006Px-LB; Tue, 12 Nov 2019 10:42:28 +0000
Received: from mail-ve1eur02on062c.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::62c]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUTcv-0006Or-FX
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 10:42:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTIWsVS6OnMGXj+jbCxWOJWxZHhR03z7QUeABf6847p8/H2/PiaHhox4k4ZkGnUmZQp0xXnWESdD2Gw8aEaAOayIDFD2iIsv/a7Qk23k11hEU3Gldx0Ds3FqS13wbJzTFOe4/YYR9p3jjSAiIAsTVezE9KSfIUkBZcQ7/hW5+Wck0GxgEh04DtutlGNBFJqyJKluQ7wMICwjx9INNU6SPXzO3GUIpkC5txGNZ5bUJyWfZw/eTTZ8DxeXstO0CDC3B4Hm20rd7f47fzJ8jAdi4oEuOJKTlJ3Cih4kAWqYe7exeT+3slw0yXTyxROmKcZUACZGE4K61UMEOCRlMNBeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rOX1bUvlM1gz3ZZtYDOv/f2myhM03FsHFX59afHBn4=;
 b=Kv4YyVZ5B8XUjgKB+k8MSSCg384wMSxqcBDoklg8i/z4Uw7SmOdGVJTxHHsqAy6bIeB8QqOZS3iU7/SaSiOTpCaMWeZ2rMU7GW4fY7NOi3ke+nTfnDUJf8sUGlswo99LfgTA1SA1aKAqkyHWR31FSjEAIteDoVWvccZjx3H1NiipO7uOuG4v8/VtgX0MX6urmD4Cg6g3qy+k640JFmN6LUbmgJnzMD5KmOxnHrDP4K2G79e6j25lBomYkfqzfGHzRDKofWhYP7RskZF7PBSwQwAzEliSSZLd8fVhqSl7eRfbYoUsaMyLqWsoswds7TMKAxyRIGr6DR5d0upLuriEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rOX1bUvlM1gz3ZZtYDOv/f2myhM03FsHFX59afHBn4=;
 b=r37g8Y9o+VMokMJE44hdo9E+XIadwfVGJwSEKXtQbkUZuAwKW1YVSBrYHMWZ63qGNFYhsQZPT6qOk1h5GaSxZltqgEZLj81V0XnOYx7gjmGdaQB1++4sy8w694S5O7uv4rrMfC9RNOO0ba/v8LezgOE/KTR1fzZRcwV+OPUwNkI=
Received: from AM3PR05CA0144.eurprd05.prod.outlook.com (2603:10a6:207:3::22)
 by AM0PR05MB4257.eurprd05.prod.outlook.com (2603:10a6:208:63::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Tue, 12 Nov
 2019 10:42:16 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by AM3PR05CA0144.outlook.office365.com
 (2603:10a6:207:3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Tue, 12 Nov 2019 10:42:16 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 10:42:15 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 12 Nov 2019 12:42:13
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 12 Nov 2019 12:42:13 +0200
Received: from [172.16.0.127] (172.16.0.127) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 12 Nov 2019 12:36:53
 +0200
Subject: Re: [PATCH 06/15] block: Introduce BIP_NOMAP_INTEGRITY bip_flag
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-8-maxg@mellanox.com> <yq1y2wsxv7o.fsf@oracle.com>
 <578955b0-719e-0ab4-919f-b4ec84d1f77d@mellanox.com>
 <yq1zhh5vlyl.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0b535769-6fb1-cb34-9209-9c2c875b7a4b@mellanox.com>
Date: Tue, 12 Nov 2019 12:40:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <yq1zhh5vlyl.fsf@oracle.com>
Content-Language: en-US
X-Originating-IP: [172.16.0.127]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(11346002)(356004)(2616005)(476003)(229853002)(2486003)(65806001)(186003)(23676004)(4326008)(14444005)(26005)(47776003)(16526019)(336012)(6916009)(446003)(5660300002)(86362001)(6246003)(65956001)(486006)(126002)(53546011)(36756003)(76176011)(305945005)(31696002)(7736002)(70206006)(16576012)(70586007)(54906003)(2906002)(81166006)(3846002)(6116002)(50466002)(31686004)(230700001)(8676002)(81156014)(8936002)(478600001)(58126008)(106002)(316002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB4257; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e290a464-5785-4e49-1597-08d7675cfbf4
X-MS-TrafficTypeDiagnostic: AM0PR05MB4257:
X-Microsoft-Antispam-PRVS: <AM0PR05MB42573C56D6CE10D3BFD06566B6770@AM0PR05MB4257.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rc7W66I9qbrD/19IxlirjV9yGVc6SWb3q6Fff5WNNkkljFHd8Y1V8bhPEtNOjUVoC7AzAA+tXqUEuXjPFBxkqxX8iRxRqjakmN0QL/nxQBOiKmtTjyl1rc+e+9OnHbyW47VaVOJM2D0n50wi6G15Rd9YneU0cSYxLesU3yf+VeRiz12fkiuatpq+HAuZEZp+xrOXJdQfF7sSh8nKeKbCW9ZlSAXINlTFeFBIeN9l3RHwDno5tp/J75HUEta1jrP6yPar3BxvPeqqeot9FU9M7znkjS10JJpnoVWE6auPbe28BNDwAQc0r8V+m0ILdA/nSCvj3k8LpUSLC7AcqxBBNmW8IMbvlyAsCuGbXJsN2kKRk6kg3kTBpP1swT5AdQFbMH+c7zLCyhDO1DMDeNBBOwwAzXxbCakhvQEysToZhtWC/VfxfVK5n85PEg5iBUNA
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:42:15.5962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e290a464-5785-4e49-1597-08d7675cfbf4
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4257
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_024225_610473_B70BB66A 
X-CRM114-Status: GOOD (  12.47  )
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
 oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/9/2019 4:10 AM, Martin K. Petersen wrote:
> Max,
>
>> In the fabric solution the Initiator side is the SW controller of the
>> namespace and the target is kinda HW controller.
>>
>> The SW controller is doing the reftag remapping during
>> prepare/complete functions and it should be done only once.
>>
>> The HW controller should write/read the data from the media as is (and
>> maybe verify/add it).
>>
>> When you're using an NVMe disk as the bdev for the target namespace,
>> then prepare/complete will be called also in the "target" side and we
>> don't want double remapping to happen.
> In a typical SCSI setup you'll have remapping several times as the file
> block offset visible to an application is different from the LBA on the
> LUN. And the LUN LBA is different from the LBA of the drive physically
> storing the data block inside the disk array.
>
> To me it sounds like your 1:1 mapping between host LBA and target
> back-end LBA is just a special case. What happens in your scenario if
> the target bdev is a partition and not a full namespace?

We'll add a partition tests to our suite and make sure it works.


>
>> In the complete_fn there is no option to skip the remapping...
> Only because there hasn't been a need. Feel free to add a
> BIP_MAPPED_INTEGRITY check to complete_fn.

Sure.

thanks



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
