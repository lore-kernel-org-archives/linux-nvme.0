Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC0FC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 13:07:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2383A6512C
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 13:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2383A6512C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Doj5KkbuMs8fZSMGpnSraC4Y2iZsLUCZugm1q0yzqKg=; b=eCe1oEdTgiU+pfUucBZIXwUir
	+31GiOF6w9NQwsdvz8UX8TE3DkUG10PTutVplnUdfCYzjfECpmQr7u+P5sR8T+MnxZ0xKhZ2GAyAh
	aHZhsdrxM/HjURzNKD32HvrHLJDyK/tB20YVeeq7Cl2lYapThX8tOm6bCUm6G6VR/SEgbSKjXQuPL
	RZnS9/XF4iT5EPC1pOFUmBvsO4LdW99/5gQyJkdlWv0V8SLz35Y5zVHv0xIZfeAeocUqjUs87KZkH
	usncFLLjgcaYOfKitfmR4lzjWN82IOeZxVTFicxUF8at+wEHwi/MeGLCyuFL5NJMMV3DLDiWeeb3d
	LM3oX6OeQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJFbX-00HKy8-72; Mon, 08 Mar 2021 13:07:23 +0000
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com
 ([40.107.244.40] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJFbS-00HKuP-0D
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 13:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUY2rzUhoYadJI9WHG7/CpZGCIY6A/mbDYOM1JMsUNmy//pr/BkRPICoIcumLUiTgD3qOk7gyOSOnChKHOXTBMh/stdGwHy5gJGhdZCehKTItD+36EPQDTbwV1s7pFMJBEWObeQBxylTUabJKVkgdARdGhAYta9xP/PCpXdbQ0Q0K6i2Se81vsr/JCNpt/zzUSkdzUu9+bjjcMHaN0iQPNVelM8Jg8pBpb+lgvIblEwEyAyyh8JVlWaiLBwRDefCuagvN40XjwgNcaRFOwcEia6xxW/rzGhAzMlEK6HFyYab5Ftw5XNzzcxsP13xSlCjHoJhqsh9eIjXdlqsf7YSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEGjr126gPrYy5QEOIiC/BR9mf5ZuwCDNc7zqDvsrII=;
 b=YW8E3FSMKaJSGAFQ+o2nyWTEZJxc55XKbkKA2XLFfFw7knwZvfdIEOvbTDglM3N438uae93rWnZCn/Q8sPq7TP5wG71ag3xjwk/dckCEvOOEoAMmn2rgODwx+g5fYqbyyoU5BU+oWeeIZ7+3LPENV5PjZEucpiw7b9Zf3TtAsFDW55WGHSKQlRw/Y/AKGELZAoPiqfgeK3I/TyFIUsIEFZJ9Oy4EgILZy2hLlgDQRe8cUN792muxWWJFPsBRLc+Jb2DYhJIaIe4yXdsxgImE9pQ1D2OBzrrxkEScCO/dOpPBnMv5GeK/vBVyIoIdrsvM1J452Oc4ROa36lddtqzYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEGjr126gPrYy5QEOIiC/BR9mf5ZuwCDNc7zqDvsrII=;
 b=UwK0CIaWBKbLo5WHK1hufjcozKyE1o70pxSExP9pW3xaWTVcrJnx9sGCtCOSqcHdWlzacFz5/Nsxm1CYlhTSt9TVRdlovjJ0kNlYyUj+HWlzBoXCca2KPWZBZB27ZKynUE4yS+Qzhw/TSHVrCRrwvBr+Hux6mgoJqv/K9m8qqX8=
Received: from DS7PR05CA0014.namprd05.prod.outlook.com (2603:10b6:5:3b9::19)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 8 Mar
 2021 13:07:12 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::af) by DS7PR05CA0014.outlook.office365.com
 (2603:10b6:5:3b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Mon, 8 Mar 2021 13:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 13:07:12 +0000
Received: from [172.27.15.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Mar
 2021 13:07:01 +0000
Subject: Re: [PATCH 3/3] nvme: add 'kato' sysfs attribute
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, <linux-nvme@lists.infradead.org>, Chao Leng
 <lengchao@huawei.com>
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-4-hare@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <9e9e86fb-47b5-0eb1-0d73-b7ce2163b95d@nvidia.com>
Date: Mon, 8 Mar 2021 15:06:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210302092644.80701-4-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fee5931-6a65-4233-92db-08d8e2331689
X-MS-TrafficTypeDiagnostic: DM6PR12MB4332:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4332B41E8401F0D1AAD3E312DE939@DM6PR12MB4332.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jT04qQNOCFR5ZR1AVS9ULz2nms9Bf78SVP/U+42Vy4EZy9lAVYvrT87DDU0Oap6OLcNVXjt1yqRzA0d5eMtT/sSFql/lgDyMLThE4KNga530EgatJ6mrBnILtzhdGbIAmPtmzFTsGBlNfOeDD+lHFVsXcPsmAL+jjN9nRqH1inJ0T26g6PQpcfkZox+MFlZcPNXN1kEoUsTmYSS0ZZvcNnFlMDH82yUlRUPBcG8hQXctEhFnt55pKL4Wi2f6Dnp0/N9mbQzDg9iVmFmr0OdohnSLhZQdvDStHXlW/YdnDZ4kbs71JATje1TdiAWHM2gGJlcLuvIOLBVYWP+ufQDm72SEFlxjN35zqhVhDHI7O3AEI1ZmBwgjT5TffzAZWZx6I5BBzDzGOSNsdgEd1plnm68aD7jjq3bVS9sGCAC2c+rngh1aM/9QAnftQXowf9Mmlhgc6bZyhe782bd42tMceUUbOpdfEV/SumW/2S/iJce0wIs9ZF0IJvvk38FcA8Ht2yUAX3T1WfYO4Jr5boNmKWtK8bmkwk3hql/VJdwGJn0TSZwuKSW2c8v423ENk82ZvbNL5TaMAL27eETBaJmyd8jm+nCAXlnTxz5p3cdC8iUk065v9UnlFFe+S04DblZLRe/ecIPWpH4iKquo+nKAXKZuf3TRHqrlYHrA6+tSVGHjyog7hmYWekYBKIb9Ch5O3M1Oyrj9twphTj5DYeURZQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(4744005)(2906002)(47076005)(2616005)(36860700001)(36756003)(31686004)(53546011)(8676002)(5660300002)(426003)(16576012)(8936002)(316002)(356005)(336012)(54906003)(31696002)(110136005)(70586007)(6666004)(86362001)(16526019)(26005)(34020700004)(82310400003)(186003)(4326008)(70206006)(7636003)(82740400003)(478600001)(36906005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 13:07:12.1050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fee5931-6a65-4233-92db-08d8e2331689
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_130718_234896_E3708410 
X-CRM114-Status: UNSURE (   8.68  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/2/2021 11:26 AM, Hannes Reinecke wrote:
> Add a 'kato' controller sysfs attribute to display the current
> keep-alive timeout value (if any). This allows userspace to identify
> persistent discovery controllers, as these will have a non-zero
> KATO value.

I'm not sure it will identify the persistent discovery controller since 
you might have non-zero KATO for regular controllers as well.

But for identification you can set special MN or SN for these controllers.

The patch is useful for displaying the keep-alive timeout value.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
