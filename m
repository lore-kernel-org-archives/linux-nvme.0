Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896DFC43217
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 10:56:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C3161247
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 10:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57C3161247
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Ssc7Gqdu4DVVDCX+Fblrr8FE2N2P+N/+buYMbpyccE=; b=rDT98Y0eF08LBlHXmPigumx+FF
	CzXw+qnZgCunidxcdvKSVJRZacM2xdc5U6gLJ7rFf6CVzIYx62AowtQ7QzjLRbn88ve+wgwNat7+/
	+7mFh3IJ9ox4V3JTbMdu6Cjw1AJCPboXL8Y7HedtGRU99m3/L9hga89k1P7fVIXfjSbz8Nx1DvMeN
	NbfOMiQ0qvr6DpRkmyAocrlpE/IXwEC4sO27Dhadq6doYQIef2I7VPM1WP3ogpzTb351nSaKURr/e
	mjHWg1PJaKjCKdBowq6PO8Sk45o3vuljSsL+LzFjYEImPmYycIA2NC6wBMIwewNQBWkuk9gXdrUL6
	TmU/Pj/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mklHg-005D4A-Bm; Wed, 10 Nov 2021 10:56:52 +0000
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com
 ([40.107.244.70] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mklHc-005D3c-Vg
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 10:56:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBvnN3/8gyH4nZxO+eIE/yfbDFwbXX0bi18HxC0/QeepjaO6GjeHT6GhMZO/IgVjDkfy/1+L/IfTyiuLeZx7veBif8H8u5oMbGOoBpdG8DrHdAciXnGddD+WCKhNMvK3ERn6ybJBwo2lFJ69or21d0hP/VWk0YOU6bZ2ARbKytFidMi7HnNShMHDHrJ7Q4XmeYQ6jxJvciCPlTAQwaybb8du2lvBz+aQGsP9nfqi/SZC7rt6iZNCrIB+0eBuhmVJ3gkB9iIF/vs79jHLDkzlGN49TABRkI5kq8K/szHzj8H+lTo72QyBiE2AB3NR31gjxa4g7+jrOw01aTwG65A/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ssc7Gqdu4DVVDCX+Fblrr8FE2N2P+N/+buYMbpyccE=;
 b=dvOVpXxM2iRM7iAS85gKIJti1bgtctDibp/wZqAFDsRz+Her2K58RgBSFWvLvJfe2C8x2iVzaziUJCAIj5AdrFjYL9Cgj5ixIWlpMksCtno95sC1k8/E1m63cl2nkuwwCMow++XsSpzdc8GRTLgU/X73NTz8g8ywghSRSYZSOK3ZG2ILdkzRPR09k4wbmf+KDlsg7zS5zjneUIb8sSKdwOKbtiWhMNKqU+VwhzMNbnH9UHbmNKRJjDMD0SDmZZW2Il0Xziazwn2QNA+mgVZ4AGAng6k1VG3nW8aYSq+Xe/BTa2fP+O88pWY9T0OiFB0O3Yly9MEcAKlXQvcVJCDUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ssc7Gqdu4DVVDCX+Fblrr8FE2N2P+N/+buYMbpyccE=;
 b=hxMBiYP33mJnxr3umlY9EzbFt7q5ca2zwF8h1zFDp5ySelVCvyX2PJi0l+iKWyIKZoP14sDvlEHx6558ZRFsUA20gRE0Xyys+Uh+4xU1cxcJPQuk+Aki7DPXpQD2ZGCivrPfMIbJ/3st4f6S+fpcNp0/rs1SscBTyMVJn6RqnIASxeHJugBIKPw7AnXkXhJe7FjXfkbdfHkxEhEzITAnKDq6dvvQFXwFZbVdOv14F/XwFVbKJAgIBt+ZNH3Wt34tGIngyaNM8qz3lGwWFaAVigI6NbsciFGcXxG/N+HnevlsPB+2MJKAsVsa9EwEEgdzHEkUWcYTBA3bbF52dB11bw==
Received: from BN9P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::26)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 10:56:46 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::dc) by BN9P223CA0021.outlook.office365.com
 (2603:10b6:408:10b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Wed, 10 Nov 2021 10:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 10:56:45 +0000
Received: from [172.27.14.192] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 10 Nov
 2021 10:56:41 +0000
Message-ID: <917d7535-9749-2738-6162-4d2d390e478c@nvidia.com>
Date: Wed, 10 Nov 2021 12:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211110103247.i7jnkg3bpbet42wm@carbon.lan>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211110103247.i7jnkg3bpbet42wm@carbon.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47254632-0863-41ea-1b9a-08d9a438c9b1
X-MS-TrafficTypeDiagnostic: MW3PR12MB4410:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4410F7BBA7EAF0D04FD1AD8BDE939@MW3PR12MB4410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzQSzMW2XwJODdynQPppv59Yk49ZJtnTIE8887fBbYff7X0400vMnKigVc9cp/Ekc6G4rGsHEsHgMCdxmyqqnUtrqDdruievits/5INDWTeRsjPqqEmoaNE2kGqPd4j9o3Di74aMUcMOflVrfYFzlrqQ5XmLlW5HracEYwDP8OYbowFn3y2+YlCCB/m0Hd/yBJ9g7EqX+whThnjZL1PdQNK3ceMJ/Uukl6UJocwOyWtlcxQG3s5QA/TPMGuRLSFAP40X+TEm3BUYANhmAgOPN0Cf6UAtzQromDlyz6kifInpXChToTzB3mF4NzSTofqqZj4vXTjg5ovRhJng9D8E2plxrqECpqz9KbmXU8GN/RtjJwxHyFrsKiBv6zwRuVuSAKdh/dxPKiXw5QpZEqcRwB/8PR/J940AAC+ymIUPprttdwNhQyrP28NwtwLYnbpBLmcjFjX+5sJvl3J/dis9B8Ybdouadr62E1MgbgA16lJ+TOhfF9urltJKgQ+ja71dDNe2jn2JpkLWari0tgndaqjiB8O6WXq7peIqYwH/Fbr5cGfmX8rliRUb5OZRHA2L/9pkfLs7lVUnd2Vc0sgFhIFLxhoxxucKHqJZFcabVJPVgvq1xy2wsEc01/L6jSHin8JEjCfO1WsDFe8wmycPJUJqz6u/ogoRKEOq2i10Vy+THCno5G0K2pKTZB4+IGIyOm/n0E8IouNGkB71zGcE+X6PQDKkDzfxKDl6SeQBidc=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36906005)(316002)(26005)(36756003)(53546011)(5660300002)(4744005)(47076005)(16576012)(54906003)(508600001)(8936002)(86362001)(2906002)(186003)(31696002)(6916009)(426003)(16526019)(82310400003)(6666004)(336012)(36860700001)(4326008)(7636003)(356005)(8676002)(70206006)(70586007)(2616005)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 10:56:45.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47254632-0863-41ea-1b9a-08d9a438c9b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_025649_054410_D718BD1B 
X-CRM114-Status: GOOD (  10.65  )
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


On 11/10/2021 12:32 PM, Daniel Wagner wrote:
> On Tue, Nov 09, 2021 at 02:08:27PM +0200, Max Gurtovoy wrote:
>> We also don't know the target that cause the bug in the initial genctr
>> commit..
> As I was the one asking for this feature: During development phase we
> saw invalid cmd_id from a (buggy) target. The target has been fixed. It
> never got released to the public.

I see.

It's strange that we need to add all these if conditions and logic in 
the fast path for RDMA/PCI/FC and even for TCP for some non existing 
target that was buggy in the development process.

And all of this is the default behavior for all transports.


