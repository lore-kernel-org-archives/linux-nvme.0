Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D96C54FD0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 07:31:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AD52076C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 07:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dDj+zl4y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UdkN7Hbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AD52076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7J4AykRCJRkJzdJQTTn2EjiLXPIvO0y8qGKZgHjNyds=; b=dDj+zl4yCUGEVbdoZWURLsfWD
	ywOm575WR4aO+JEIw4juCXnHSvxIs2oihHALE8Wnq3v2yL2/k9W/Gu2BFMxpilovAFg5bK52fdOVy
	QEFipnBF7rV4HOhO7t/bCnggUKr7pp+K0tzeAoWKPGxvg7gMXKndBkl5xUcgghJQrQvZ6KyoY/0dH
	FCYRQgmsSrRWW/H7Pf8Npp/qCmfkrvTRNH1OA+5ZB9elZcKCJEzKkNAoRem/0ArrMWdvh2RAp1jRO
	62n7v3qP5cSkgAuyVCBV9SdGBmwBXEH6vVEf4UpqoB2efh8Gc/dBH3qVdBVK34UxEgJkAXhHnfueZ
	UFHKAA1Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRWK0-00022J-NF; Thu, 23 Apr 2020 07:30:56 +0000
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRWJx-00020I-Da
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 07:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L79ndzPwUqbWQwUBlg1nPHtCF6lTOI/vGB7zPjNndTcbvF4YIZjOK4Rdv9iWrH32XaUEjTWkyYEvXZ4d10/0HM9U1p8zoaCQEs47jda/eQ7l2K2F2fMHLPzTe5kqEURbeAO86iK9LlPAzJ5JdAA6gGxT58izDioMwhYSAc3wqBuJDGbDe4+sf5KhCcHtU4vspJsTRfVm8b/Hx8YRut/GqVlAgttO43Zmhmd6HLfFkeIdhEBwS+QKAbCwubYjyXUTBHqO2ZR8MNk5MIf2Hr6O0jDUHNyPldarRDPy5g6PLCCFzpqhrhygMBoKkX8uwkPGJTLdzQ6jlEOt4GBZK9aT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+aacsMhYG/cEWlpTYuql0Ipq3khdFS97Bhbd4pFGiY=;
 b=CYs2NdvW+qInl24yi/bdt9ncwZIYSkWD77VL8uBKHbIdHd1ZtP+s9wmSeH4JTjXxGGQp8n7bSrbbgxGxandS4mqtnMqiXezPEHbKq+MISnByEKB7flOEur+fW2BRw9C5egDHPGTPWuNk7B1b1Y0ejLKa4MU5Uj0Ev7b+hzc+II7GSfMvKysRQB9cj9vXgDxXocfWQAF74a2fWLODLfPtXNBF6JpMG2aX77qFiH1atnAEVVebSMh/U9z2/dzuCz6UnwlUUlR8IEvNfOnCK7uiKHWOyXcjT0EdNer7RT7UpKvOA+qK1ZLmtxAaPNTYC2SL7Gv3hb526fDy2ONpCzcexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+aacsMhYG/cEWlpTYuql0Ipq3khdFS97Bhbd4pFGiY=;
 b=UdkN7HbstBn+XMLV5s95d2iX3tvAGIO2hMHM2GTELRsWuS6FGWJwnVL462wJXeucO/KUQBiGMA6FeD9hGLULbjkH0XXQ6v1KgwRmjo2KkE9Kdjj+Io3F2/7fqcFG2yHrFd3U5oDPlRvNGycZ1QwI/wrjkLWAr2bQBq1VI2nhFrs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6163.eurprd05.prod.outlook.com (2603:10a6:208:11a::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.30; Thu, 23 Apr
 2020 07:30:49 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:30:49 +0000
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling metadata/T10-PI
 support
To: Christoph Hellwig <hch@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de>
 <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
 <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
 <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com>
 <20200423055447.GB9486@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <639d6edd-ffa6-f08a-9fa2-047ca97c47ee@mellanox.com>
Date: Thu, 23 Apr 2020 10:30:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200423055447.GB9486@lst.de>
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by
 ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 07:30:47 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc9c30fe-84f9-4a01-f170-08d7e7583ed9
X-MS-TrafficTypeDiagnostic: AM0PR05MB6163:|AM0PR05MB6163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB61630B24FBE6D743DB1C2005B6D30@AM0PR05MB6163.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(6916009)(5660300002)(6486002)(31686004)(36756003)(53546011)(4744005)(52116002)(4326008)(2906002)(86362001)(31696002)(66556008)(66476007)(16576012)(478600001)(956004)(107886003)(2616005)(66946007)(6666004)(26005)(81156014)(8676002)(316002)(16526019)(8936002)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbNMvOUVIO7NAdWkfBUUwfA8A+LSlAIeLtFfhe45HSQeJsDQY+NvRSdLTHXa1WJWVrB/rjRanK3+lm2R/KMz1wXpPgOf12ADhHAi+hnHHTAZoWTMVwuSPRVsKKRme16QN7yzEW2S2HFr0B8MazbGJvebuMLemfV8bOIe6jeNYVStTssvQVMNBz92obgT/76oNGQwk139XVGYtoAra9LuOrCeldSl9CBafOaU4OnShbtBeI72iWLFUiq45EAQ1QFho9ME7uvKpsnNWj6wfd2ordlvxWBHH7wCy3f4BjqNDIoh1LBzdOPg8Mb4KEhBhRTxe3ce92uMzEHqAd4q9nYaaqRmkmohl2XVPC15VZzE3GjwD9Z17fpYy9r/+VjruNiZG2uDT1BvI2pZ1BkniFzwrbzu9UnLD8cSYAzRs/arZgVFWhIBldRS3Jecv+qzeH++
X-MS-Exchange-AntiSpam-MessageData: hhl9StLUi2vxKhZhv53HbV3B6/IuBc9bsxPAVU6CtesZyTaEUAcxh14ErS7urn6UBZ7fdi0vZYwAtdCRUlStNngOAmtyvdTVvmWsxvt/fdgqT7JmXd8oYluTDhms+idjhNz9ZpIvPdeowMbWxf2FzKHLgkb4gtkyFWl6CvALTnGsSdQiDpOK+Zs7Bu5XiNVzZ6MjZulpJ5aPKd1S28kZ5Zr7RLogR0FDlG0UY7YMIPANO4QO81p1I090/ZgePLKmSo4GxoWNpOtlaa+2SQqm/hzEv3np8GQPAnePXjTb3jvAxNS1767a1kXB/VunR0vPcUf1C0r4/Hw2J6KlMtCn/WjI5VPDEN5iUSpicQs4DEUhwElhuI1e+LpG3SIGD78KritZfRtCUWLt3yN5FrMxi9gW6lbLlZSLsZY4duQJNgaRW7DU2DCjZ7rifdAnSqQ3fnDPQDoSiRABhh0hMQS15yEzJzKKxRE4H+Lk1lrl9oFDRNQ9NwizmOPKlrTDNiYPHd7zYKLeTaVHe352HSNuSeCACq9a+zFulJqlJ/+t/fYr5yQyngTr/gEMlpiGaMBnnj/bEHY2AWLrKTbOCRTuGs1QA4uhblTDmGQQR2UpUqX856zcP9Gqs+A+ahrxk7SbADD2/GSyGh8LeoocjqycoWFqbg5WndaTdebxuO6bz5bvdyHo7XpIydsQ7A0fQsf69KYlQRIezYQTAfM+k26BXNITKHCsWWsn/S0Wr8mCMhu/9efNOTfPtUg8+QdWEIX7FwNbwTdqjYFtf2CMhbO+KACpzRBcZWnCuQBjpPRgt2EinOECrr/+lFhXIij7l6i8
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9c30fe-84f9-4a01-f170-08d7e7583ed9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:30:49.6411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4AonDiZmVNED5MRpH1sgFlQyfau5k508hxD5y6OKZF2no4ReFczTdRXQHAqUpByDOuJXM3WoamcCoTTqyw9jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6163
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_003053_491064_E02DC0FC 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: axboe@kernel.dk, James Smart <jsmart2021@gmail.com>, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 4/23/2020 8:54 AM, Christoph Hellwig wrote:
> On Thu, Apr 23, 2020 at 01:39:26AM +0300, Max Gurtovoy wrote:
>> it's a bit late for me now so I probably wrote non standard sentence above.
>>
>> BUT what I meant to say is I would like to give the user an option to
>> decide whether use E2E protection or not (of course a controller can
>> control protected and non-protected namespaces :) )
> I don't really have a problem with an opt-out, but I'd like to apply it
> consistently over all transports.
>
>> AFAIK, there is no option to format a ns in NVMf (at least for RDMA there
>> is only 1 lbaf exposed by the target) so i'm not sure how exactly this will
>> work.
> The NVMe protocol Format NVM support is independent of the transport.

Ok, but it's not supported in Linux.

Are you saying we should implement Format NVM for fabrics ? or stay 
consistent for NVMf (and not nvmf + pci) ?


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
