Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50EAC433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 00:18:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDA6610FB
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 00:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDA6610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wJvUszv2DnPmvvWUrtAXH+RLllclzbRXQssFB3WoqKI=; b=jy1ts3OcOS8UZoYt81vsfWggj
	sRt8yN/VBNcKypwrt/YEAxyjLjnEpp6ruaaTGiOrOBTRSIjjyV+NOQkmzM65Pze39YtREJww6b37w
	ho5Bv7WBAFKjUiMFIg6fvZY/JKj6qHzYG0XgjwUYP3QtJhHZr5mgvHlLtwy6qKQm6WHbA18zeBMbf
	6bGVsgX9JHQikbkIRRA6l5q0xTKrxZ3Fwds828qzFeVEAtVTahr7k4DZfbQhRbTURhPzagQ4pl9pj
	bEXwiUX9neXrIQuY6QIukETJAdpZu6MVXWuYhIIQwsopSW+m5OIOc4MhznGITM8tmmMLU1qoMWJf7
	xU0wZLuQQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldilD-00F6jr-W3; Tue, 04 May 2021 00:18:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldil9-00F6jR-5R
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 00:17:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ugz+igUYvCk7BaSK/WNdNeraISwlgXmTyzLgvvzUbnU=; b=fq60pl+5vMv9O0uLCSwGzsMjB0
 ujSQQNCuu1LVsSTdXIV1iqbG3GDvW85XDtuYs6dxG2nmY7FUY5neblv4UWan4dA0CCzDoZ/mgSP87
 LJvoWEbQFrXkRUjg7GbXGkrrOXCFCujZ7CR8tnQ/fIfcHk8NGFiSqWl8juO43G0RlE6maVfKPkDoF
 FKP1TocYlGcM2uLth+QEI1UMp3IzpCVGU3Y0+TQ91PEVEpVKsaI1ZkGe/4B8bppJHHndiKBR3fC14
 KFolGo99vonLgF/bSYviIxymctNaCVx2T02suF9X0KXn2LZ8gzIZnkr+0iwUMrlt2cpoyphpH+L11
 FF3h8zrQ==;
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com
 ([40.107.236.57] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldil5-003Zlo-VT
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 00:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2ZNNiAO35cwyzZzHxABtDyaEHVhD+uLeqxL4UvzkrI4mBNBl9KkHWeiFxcibsk187SJYSr2dI392d8rXLQRyfnCiXk+81ZcupDYFVu/u+iQFAGSVB03zIyy4lcY1vm0+rnQut2FdsPIFBxCyqUyJniuAvGGReGX7Et8F96tf492bN+bFvWGvscAw2h1pA7+U1LBiktEHf9ZTUGyVyEzuKUh4WJFBhSZjkuSkJ6/EDo/DzrG3V3F2Iw5cEBWGRbiRvpP4BIKh0at8xY0LwdJ03rqGj54hyIQmdavwNF8ownkjTLHrGIviF92q51IODjKnPN8321Mbgv6cc+WhT7OTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugz+igUYvCk7BaSK/WNdNeraISwlgXmTyzLgvvzUbnU=;
 b=MZT7FNqTfgr0FJ4fhar13O8x1RBl+aqycXzlBgz58E9lbbx4Xi/unri571D3ggOFkHCCpptLBXuMNNPbdOAqoDj2JgqwvtD0MiXe8KAZAzFBdFMs5ATbR9v9sa70/Y07BA+MvmBcAQjAjIS9aoBKmQnySvPDzy0p3oFq2Q9N96aLA+JU+rZXfdPoySDFzvfMItk/lsNB4dnA6YGip9nxE0O39R0iKkCltlA0AKJ+4Eleu/AS+Y/BjXlr4Wq61L+idBOVTM+6L5JACS/cwdjW7K75LyqkB9cxGZ9t45aF0boJPxqHlxW7PIOajzUZwhs95hr/TZl49K/GUAML7Dxucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugz+igUYvCk7BaSK/WNdNeraISwlgXmTyzLgvvzUbnU=;
 b=OlZTKYPn79aecCTchVHZ5mWH2K7RNpU0IiJx2LQyEidtnfZ+RAf6Ub87X/NxPt5DCt4+dECELyU6CBlEn7aNj4yF0ClhABkvcIBn0soeKYckbZ6Cb379ni0CWq0mAE4ih0ek0ezSviVl39Hr+c1JkA6wExXSvdNwPW4DUX3dpndhPd3YQBwnNx3/HAj9O4kTVdOmiaKmwony6/G+FH5E9alGJlsA3ESoOmMt1+PFhjzG/Pazm0ckMVZz18XRwyFsgGrq6p0dMiFSwx67nNwApj5ycrZkcqlnKxSipS2VhdgocR8Pp0RJsSaQ80ZpDyNlkK9QOQQ4+CF4y+AfRejIwA==
Received: from BN1PR13CA0017.namprd13.prod.outlook.com (2603:10b6:408:e2::22)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 4 May
 2021 00:17:49 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::d4) by BN1PR13CA0017.outlook.office365.com
 (2603:10b6:408:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Tue, 4 May 2021 00:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 00:17:49 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May
 2021 00:17:48 +0000
Subject: Re: [PATCH 12/16] nvme-pci: Check DMA ops when indicating support for
 PCI P2PDMA
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
CC: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Dan
 Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Don Dutile
 <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>, Jason Ekstrand
 <jason@jlekstrand.net>, Dave Hansen <dave.hansen@linux.intel.com>, Xiong
 Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Ira
 Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-13-logang@deltatee.com>
 <f8bdf85c-2302-890e-7f77-e11fe6f29d6e@nvidia.com>
 <f33a9cff-82d0-7a05-070a-8c6018fbaba9@deltatee.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <db17d695-eab8-9078-4878-dcc0ece94d23@nvidia.com>
Date: Mon, 3 May 2021 17:17:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f33a9cff-82d0-7a05-070a-8c6018fbaba9@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5974555-58c3-4bc7-9f0b-08d90e920cf2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4485:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44853158E94A56267F464DF4A85A9@MN2PR12MB4485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rm8FiZXipicfTDHKIDf/22Z84PCY5NzoV4u+ZBZmuIY5xxTEJFqaoj75DHbAhL2jP6oIKBWPjBaXWNGqp6WU6ox4jVKYRcVp7RAs/UW4qLm9xUTcQdu8vnG8ov9b74WLd3Mmg5dow4iCY5nD6L6bPowK8cVxUwzMlNypkNeH/QIlAZEW0iI0ppPCFl9ad7xbCRz+sT+d17aZevApZTIMJOim4X4O5HdjrjWq7KmITiAI5dfA/Mf7s5c1kDxTMlNb5HTs+B4k4WCA1BD1QbTkuZNavoMVHavI2YuYz8493L24EldJanK90crY1cQ8/Q+K6ztIXI+uAnTbtIsIbyjChquuauupxJ3izHtCGfYGr/KSZJkrAlyO9pRJKnbvixx9XkX6wNZUkxMyPAmTR/+Q8CLJkltXBsPWlzryaeoHhmxIUNFCi9gvZ6fgG7nSpQU9dfCnpZXapHSS1CSP2u+q+7TJJyDal7/4ELvy7wKOW7wbThzOjqRrXGraM+TT8o/YX2NOF2iDic+kuBQjlGRrRQOGpzKJ5694g8K5kCH1uLlu7Cn93BSsfilT8fWphvpN56I3sC8x9REalX2/JCO50fI+zcnzqYY9AjOAtSd3e16RWM7LKTF9nUi+OYDlgFOY9RUDAX8prTqmM3QK3tKo0dG3Wn0lvKZjhqxWofTtR1Mz2WFWboKf4NochLtiZ2d+aCI5uEbjf+g6q3mi1TaIvQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(47076005)(83380400001)(70586007)(86362001)(82740400003)(16526019)(2616005)(54906003)(2906002)(36906005)(4326008)(36860700001)(356005)(426003)(70206006)(31686004)(5660300002)(7416002)(8676002)(336012)(7636003)(478600001)(26005)(110136005)(53546011)(8936002)(16576012)(31696002)(186003)(82310400003)(36756003)(316002)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 00:17:49.2598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5974555-58c3-4bc7-9f0b-08d90e920cf2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_171752_051294_29CC3DD7 
X-CRM114-Status: GOOD (  16.04  )
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

On 5/3/21 10:17 AM, Logan Gunthorpe wrote:
...
>>>    	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
>>> -	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
>>> +	if (ctrl->ops->supports_pci_p2pdma &&
>>> +	    ctrl->ops->supports_pci_p2pdma(ctrl))
>>
>> This is a little excessive, as I suspected. How about providing a
>> default .supports_pci_p2pdma routine that returns false, so that
>> the op is always available (non-null)? By "default", maybe that
>> means either requiring an init_the_ops_struct() routine to be
>> used, and/or checking all the users of struct nvme_ctrl_ops.
> 
> Honestly that sounds much more messy to me than simply checking if it's
> NULL before using it (which is a common, accepted pattern for ops).

OK, it's a minor suggestion, so feel free to ignore if you prefer it
the other way, sure.

> 
>> Another idea: maybe you don't really need a bool .supports_pci_p2pdma()
>> routine at all, because the existing .flags really is about right.
>> You just need the flags to be filled in dynamically. So, do that
>> during nvme_pci setup/init time: that's when this module would call
>> dma_pci_p2pdma_supported().
> 
> If the flag is filled in dynamically, then the ops struct would have to
> be non-constant. Ops structs should be constant for security reasons.
> 

Hadn't thought about keeping ops structs constant. OK.

thanks,
-- 
John Hubbard
NVIDIA

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
