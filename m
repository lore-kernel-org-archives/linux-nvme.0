Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E17C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 11:19:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5871C61A3D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 11:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5871C61A3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pn2VRcoaYnxQDo40DUhe1RpedND5Yk7vVijnVWQNtc0=; b=TDdGf5/ZaEctBfHnvmV/9c5cZ4
	THk2CPZycId+MsxJujicD1XfDFdYncltrEH3Squ5IkkawHT/gmyOr3W/d1S4HnwfV5gVCg9i1yj14
	bqoSsAn+HuW6dOqulVjp98dV1K4eyUGPeGeTC/WCEdQUHdieT9XJ6efC6LieTUo81q3sdtyR8SNXe
	MnZ51kqM3GVbqEMcZfFsXlPhPc58ESPWmCUCU7LSfv+dgr/I6sN/hA0ofrj+gb7BmuImWVUe3CuyC
	uTPizWus6KfhSr2wRWGkDoI84eS9ZRjCU6flBDFmSnuUqvFLg0gttY+UwifAIaqxPEN+2d2R0YO9T
	ZMhIrYMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnfSA-007Xdo-OT; Thu, 18 Nov 2021 11:19:42 +0000
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com
 ([40.107.244.84] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnfS7-007XdL-BV
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 11:19:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY5hrZstBR4x2DEtbJdFP2oUQBvurw9Ce1kfmfn/UiLHXz0MDImOXb8GzVCjBESSDmskhg+hTqJ/tPNzpaTR8x/0MYHURsbdRhX8RPOgSacITJJ44GSs5s/QDVdROnpJBg3nOjELODc+Fe85G3w/Ug8TUNG77nSxyjoopydrOUHec/ck+RykxzfCoAlotrRoxe7LHB2iLFRAsL7GmShsBD23DTHmg0WE4vrVomK8cFbjc2a/Uahms/G8K0CF4P5m+VtM5F7Xv9EfaKYe5rF244hULMv1hh9F37/jvhDqpjqIg0vpcHmCs0eVP0TWrK4Cyf6uLsAAcFvXaNQvVfuwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn2VRcoaYnxQDo40DUhe1RpedND5Yk7vVijnVWQNtc0=;
 b=IJvnLYgjDzFF0PAbFtNnCFVmL9UVoXlflmb+XdLGUHxPHf7F6vABdNg5MUzLdtT0tEYcz7udiB+0ql81Lolyv73eJevckqu/hu+w7H422Wea9dOnZ2Kf/5n48sFLz26bI65TWoMvEuS7sb1XxZtAmwXu3ypjkVIenMi3QPD3I40joaj4I+Q4kfgMknVnxdnqq8t23drZp3LIszqCopxxi/vhJfajTC+KSRIBEemJ41Q5r33cR5n/i9CfY+Yojn0OQwTnsd5tRhYPfpZDCrkJyhIVbJ3XOJh5VCEE1a1gKeehFvabDk61RlC+5pvKusEmUp/NFtgZcJg6nYgAmBu8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn2VRcoaYnxQDo40DUhe1RpedND5Yk7vVijnVWQNtc0=;
 b=Y4AtGvXEZJI8pFsykVjkEwuAMzDBOv67tXx3baE352IYngzbzIGBn6s4c3Kif086yloylQVPgokDkZ+7ZfFctbpUnIYif6hS4LsOsy+PL81V1cHBe45zbukW+LoAc3gQZ6KxkfVr2TMjEA8iKnH3wBxQMVcSFD/g6rvuCEwrizRtkrVFIgn1Wm7703nWvOtkcdmSAjZCibg9GlzPfLworP6+JolAiyowRs9j7yzAVChszCZ1+K5vcEAph8P1vZi2bYuWxLJ86CwZ+SKxpvUpbF+4Y1kQXQUDY775cVakNq9gFoQmQgdL4243DdwXW07cZn4ky1FIcOer7g9rk8+Ezg==
Received: from DM5PR16CA0015.namprd16.prod.outlook.com (2603:10b6:3:c0::25) by
 CY4PR12MB1864.namprd12.prod.outlook.com (2603:10b6:903:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 11:19:34 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::ad) by DM5PR16CA0015.outlook.office365.com
 (2603:10b6:3:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 18 Nov 2021 11:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 11:19:34 +0000
Received: from [172.27.0.227] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 18 Nov
 2021 11:19:29 +0000
Message-ID: <609a6156-8705-7bbc-6be2-ca940c8a3c79@nvidia.com>
Date: Thu, 18 Nov 2021 13:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>,
 <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>, Or Gerlitz <ogerlitz@nvidia.com>, Liran Liss
 <liranl@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
 <20211109143102.GA25263@lst.de>
 <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
 <a70fd129-d69d-2905-c43b-41eae0b3b8f8@nvidia.com>
 <20211109190432.GA2661484@dhcp-10-100-145-180.wdc.com>
 <e2d589ab-2457-a3c8-ba2a-9e4f813d9a72@grimberg.me>
 <fc27faf4-c876-ced5-c9cb-2d6730e07f2d@nvidia.com>
 <53205a07-1af6-38a5-c60c-ca7d12226202@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <53205a07-1af6-38a5-c60c-ca7d12226202@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5491ce31-a74c-4ff9-f3fe-08d9aa854caf
X-MS-TrafficTypeDiagnostic: CY4PR12MB1864:
X-Microsoft-Antispam-PRVS: <CY4PR12MB186400433048B304902EFB4EDE9B9@CY4PR12MB1864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AD5nEoVGAWYNSfkAdNSHT9xSZ8mL2TDiHGPNE7ZxJsWaQGtmvMsON7gQYKZ9speTIqJJojMndrKUk+p3tJgtnmczVC+W9miUOaMNA+u2kWjnyakMkX6IwvweP0f1CdmFvZLWcUoDLRZLBkrj0hE4JvB2TfCbYyNaLBaa6cmo7Teo5dziP0V4E0i3JbNCOrzqUioIRRjCRYEwrFnehGB5nbKVpeX9h70ev9bBR6LIH9FlBGDtwmx4oWlLV8T46dietSjcjG2/kKBuJ94Tc3novWsGbVeGr1q1yKBeGTa2PaBhuLWW4FrGTZEDh6LFXJoiUFGj8+nO8Ddi8IFZMljY/eDxQy2jepxJn4LgBvV7u4tW5gP9iSuF1J0BdBZOgWJJrk3oKSI/83XYr6SSDCKhnsYAVh/AGzWQ8fWFbVykaZ/abP9NRHd0Nmo2/bGQzHeWGj0zEydy6FLspPA+3EtfwCnF4AQgL1ozDMiGjtJ3NffOn3lw9TCNVblUVJvmiSmbdgqe5nePEAxsI4dZpkitZIkKeuMtP3PP54/HDhU6PwYRJjEIWYsEDltnC7qSl6qvOWMAD7jiWJmrIGiQ5qXYzRf6DZExA/hV0GpQbdUSjxq0CaE9nhk/mx57wvig/9Ld+mxauzZIKL1BGm9w/I1J/2Z6rf10kRcfRypZZdHenDajF5ItlXl2VqYFF/eIEyF1nmHVjQg1hrm4V+IjLBTR2pFoNIoVYw+MTnK9TTe7b0c=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(5660300002)(107886003)(53546011)(54906003)(6666004)(16576012)(110136005)(316002)(2616005)(186003)(83380400001)(426003)(82310400003)(36756003)(47076005)(86362001)(16526019)(4326008)(356005)(70586007)(7636003)(26005)(36860700001)(2906002)(31686004)(70206006)(8676002)(508600001)(31696002)(336012)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 11:19:34.2628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5491ce31-a74c-4ff9-f3fe-08d9aa854caf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1864
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_031939_455100_1FD5652A 
X-CRM114-Status: GOOD (  13.52  )
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


On 11/12/2021 6:07 PM, Sagi Grimberg wrote:
>
>> 6. This series just extends this quirk for fabrics.
>
> I don't think the patchset got rejected, the ask afaict was to document
> known broken controllers - exactly like pci quirks.
>
> Here is the original question from Keith:
> "Are there really fabrics targets behaving this way, or is this series
> anticipating they might exist?"
>
> I don't think there is any desire to keep any controller that got the
> spec wrong in this particular case unusable.

The example I have is the new mlx5 offload for nvme-tcp has HW design 
that, unfortunately, made an optimization that relies on a indexed CID.
All the testing was done with Linux kernel's prior to the gen counter 
change using internal tools, so chips now exist with some performance and
memory foot print implications when the gen counter is operated.

NVIDIA is committed to NVMe standards compliance and will fix this 
design in next silicon so no quirks will be needed to get the best 
performance.

I guess we can put this discussion and patch-set aside until we come 
with some performance impact measurements with the mlx5 offload HW.
All we know right now is that the new CID algorithm triggers bad 
performance using our internal simulation.

Thanks.


