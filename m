Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 13:31:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC603611AD
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 13:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC603611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jtEZL2lzreN+2gJGnmrVzltC18uixmfAR9bJn13CNJs=; b=YIJ3DxSB+fqZOxQqVEGRdAR3w4
	MBEgEpSn6uj5eF6jgHOT3SR7QWTxgUBVTGqDDBjDrWk/gCJEosQ6Afv7s+2TCLnjMAeyiMKV4Yu8C
	b8bD12r80pR2E00Trrn8EI5dVgkslTO3LKLDFjwd8GYGfHh6UZXvNwQGMn9Rm5/L0rUf11WosIHf1
	bc8hF7lSoVhOLzGCPAwfZBf0r0Ff1ITCKsYPH0lqm5qCrtkxJcgxacbJdFLeKb06NVmI3a0LugP27
	vRYY4Zrsyiy1aIVTYJ6YXalMiVQXpDpXuQmxzR4vnDsDaxhFK5EmXQ6jn7UBr2PimHRYbztwriAEO
	ycn/ji0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkngp-005ZOT-K8; Wed, 10 Nov 2021 13:30:59 +0000
Received: from mail-dm6nam08on2058.outbound.protection.outlook.com
 ([40.107.102.58] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkngm-005ZNa-G7
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 13:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlVwzBPthIDqG9gULFg+qPTT2redtXAJ+RGPLRNx2HK3Jm277CLiIr/fVRKLCb2uiphMyQkOdFl51dekWevBm93jajoh8idFYj/fGbqDuCA0SWaPdcAwZp9fpD6G6B2Z7ui2fu/2g1xuIYdl9+sZySsfMPVE/srAiYfPrNlH3z9ZvVaK9qWA0dFK+pySBJDmz6beBl5AvH13HMfu+x1HJELf1N4yiMO8/hiIm95tnuhpo9PRns5Ft3+CxYEI8LA0eoFLN6hznhHkAWZECuolC4L3FL4Gqz89+BFHjZQUdhz1HNts7QKru3eCUllISuwpZCs5aVBMGG8MsymSrqFmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtEZL2lzreN+2gJGnmrVzltC18uixmfAR9bJn13CNJs=;
 b=fzbkW/kKQ1XUOOcUiVz6QvPGKJODYK4RFYGTkqDxRJ0qFErrSPgLVoKwPtDk/a5QDsgn1gCkkLF0xmatZM8rOUo0yjFDdOzo9xxie0wn31BGaiQTMbGOa6EgPqvbqIEOJZ6Q8SGUq7S1sWMjoMmtf+mQwkZV6GL2PGE9tr9/Mv6wgowXYeNH8zFW+gVfzY4qv/pi+OvwIvAtciRf9IjXcKrhRvBOHzzOcGUDyNDgA2PxjvxxkNYFoR7FZdbjIOeIH3rwGefQNHpy1Yc2dNPV/enVbUglAYdNCUBRsBbC4GBcOuwr/y/DRUwpe1OMaLwiEa0zZmhRFmBBr67g+CDPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtEZL2lzreN+2gJGnmrVzltC18uixmfAR9bJn13CNJs=;
 b=nYJzgfDTySH4AZoB/vNpVv2B6MuP5reMEIoub21adOM1FiZiSIeNKhyi7QrLxa3qNxpqnZg612B9Bby1tnDLM7ig2KWPFEm/BIcAjMKXeHeCPbUU6n24JRmWoNsX4nRcRKR/DdXV/AR0bo8mG4NuQBIYZ/xMEnD+PugcUeoKIGz2rIQcVM2dOonTm4/CraC3AmZCRKKwAbV6zt3beyf4woLqKD3NGlNYtx1YQ+HH9GgiNZ8ZvINcDmIssdJo6pLamUBbriNiY/wDiQRGfFH9G+hiafUxEnGeRUKKTlGf1CFmDmIRhla+kvdtwSReWLt1gZVrM3nviMbNxF0RJXq6wA==
Received: from BN9PR03CA0888.namprd03.prod.outlook.com (2603:10b6:408:13c::23)
 by SN6PR12MB4622.namprd12.prod.outlook.com (2603:10b6:805:e2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 13:30:49 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::64) by BN9PR03CA0888.outlook.office365.com
 (2603:10b6:408:13c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Wed, 10 Nov 2021 13:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=pass action=none header.from=nvidia.com; 
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 13:30:48 +0000
Received: from [172.27.14.192] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 10 Nov
 2021 13:30:46 +0000
Message-ID: <c84b652e-9a8d-b7cf-11ff-cf872a3a6962@nvidia.com>
Date: Wed, 10 Nov 2021 15:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: sorting out the freeze / quiesce mess
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ming Lei
 <ming.lei@redhat.com>
CC: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
References: <20211110091407.GA8396@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211110091407.GA8396@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1130f85-8455-4c31-e023-08d9a44e4ebd
X-MS-TrafficTypeDiagnostic: SN6PR12MB4622:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4622B94F77B22A804F7666DEDE939@SN6PR12MB4622.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkAZh08E+Yc2zLTq7qW0mI3rcjokrfhFJxxeUmc6hLtVr52OzrWj48hh7Y2jGVJ677GVA5jln5uG0voopxu9eFoVM2HqnaZEmd9bQq/rbqNpc8CmMCSOryDSzL3NsG+aGId602HAVx5I7yx+Wg8wISsK8wVUHvNht9/w+PeosdmxRnCGGLVQGsyMyOwVDIfYzUn7hA+3lHkBcchn9x5FkmiV7v5s4IvfcTI0P240KGX3CI2fCe3Du13PqkbdDuHsmCMEtnPjOqip60dl68ogaccERpic1aX/OWcsCNDOE8hdoMG1PBr4DYKrv/vMXc8EFvwPfwjjPIXIiltiBDJ1HGF5m1thxWioZbx/DX9VmOTrAkZkrLmzdP4f1AQMffNCTWQFAOOXIqT1OcAe4UUA59kuJKbXdtW9JPlQIJFMXJ+IaI7CWF0PfQzn2M0K2lyi7yvL1G8H89fLsVap8uIpgxPz9xZN6pcovG4TjTg0jL42QiYRIJk8dhuqBdjkXkSoUxMOqdaOTdq3u20NGsAFf2em5EAUhw/NMffK5SzvgQ5Kh4toMNBtslsc0T2B0Ymf0KYpxZLy8v9ubHAT73UtG+kKCFh9z6iBDADBLRqh/tpzaCJ91Ey2WJ04eHo8FPIU1RMaw650HppHy5oqt7ktpLat2GqEMgNOLKYce1qCFP/El073i+7cgo1i0sWFB2WULMA1VGpEGdnRIoQIa2AvforQipV52gC4tS4g1vCHXg0=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(2906002)(86362001)(4326008)(31696002)(336012)(2616005)(7636003)(4744005)(54906003)(110136005)(31686004)(356005)(53546011)(26005)(186003)(5660300002)(426003)(16526019)(6666004)(83380400001)(82310400003)(316002)(70586007)(36860700001)(8936002)(8676002)(70206006)(508600001)(47076005)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 13:30:48.3447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1130f85-8455-4c31-e023-08d9a44e4ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4622
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_053056_597081_A48018E5 
X-CRM114-Status: GOOD (  10.80  )
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


On 11/10/2021 11:14 AM, Christoph Hellwig wrote:
> Hi Jens and Ming,
>
> I've been looking into properly supporting queue freezing for bio based
> drivers (that is only release q_usage_counter on bio completion for them).
> And the deeper I look into the code the more I'm confused by us having
> the blk_mq_quiesce* interface in addition to blk_freeze_queue.  What
> is a good reason to do a quiesce separately from a freeze?

I think that quiesce_q will guarantee that no new requests will be 
passed to LLD (completions can still arrive from LLD).

And freeze_q will notify that the internal request_q state will not 
change and completions will not arrive from LLD (and if they will, the 
block layer can ignore it).

At least this is what we aim to do in other areas such as Live migration.


