Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D77C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 06:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ujty4Xcfv9TqeuEPwQCsPPMu1k+uJn34NGKW1Z1SvGk=; b=APg53qS6s5Hf8Ej7CIMpjCGd8h
	NJGqgzeEYqS+fQM3S1uJ/FIJuV8gPiZ9LzQm9KO+H6qk6R1rB9/6pFQm9D6HgD7SF4dh5vGP9STWI
	Df2F5wUbeZBxWp099DwIkErgiWt9k8v/8N3UNKit/39oYVGANhbLCjFPdqJH0TL+rInaHZ2xzJzVV
	xNR/Wc1pV6Oxjse5vwC+QfeiTBbogsFr8xy0xP00tbEJkUgLgxv7ECSoJIeAQ72Uv/aUPmk4PQ8L6
	NjfNPnn0mW5QJSBqPsTwUuKKPgsmZprr+CCICRa5mZ4kXKyTj5sbB8fZbwZDxHG6zHHWFrPzPFfQH
	kriozoOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7X0V-001Gpo-Dj; Wed, 12 Jan 2022 06:21:15 +0000
Received: from mail-sn1anam02on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::60a]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7X0S-001GpR-Kk
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 06:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMaDrDZ2jmpTgE6Wy/j5QheNnSYjr/UAvTruotxjBxVZY6lprlybhYNXaiqPjyOyAXGSqj/MMoz47gPpun2s85yVhsTOPhS4Ks3oCwZb++BFLsDzUWXenVVE9OPHiJgQYMMQ7CN+23Ec5K7Wp9z5VzelxUkwY2phUHKRcZ3tAySkEW0touzhjztFp/6DI8ouJQjHKBfR2S9mDyibYB2IW9SBD8r2JBZUgQAWEJFrADno+jls6sBh0XRWBhMUq81h7g2mLQMo8NxneewSQ2PZzUuMbb7968VTMSahcIL4mV/DKj5sfCQxHjvpuJUHA2tuW97A/NOsEvK6MxF+SwKj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujty4Xcfv9TqeuEPwQCsPPMu1k+uJn34NGKW1Z1SvGk=;
 b=KRHGlnjV747DqJsyhCgSHvzL/lYW7xTJO4SWD2p/q5wfoB3ru0W3PcXZRoLrMvG0RAzJg4om+54S9eQCmVFxkIUHY3DEkw9/i9Vf5ndpRouHeOTvwF6VBhOlcBbJVn+2qbH7VkmATmvL0nfsS549oRCg/ZQoaYwqJ6AU1b+Iuw2zsgdFE18dpXOgKbrcDJfbG4F7N/so06T2CATK16b5FWFCggGvTWpHm3XXbt4q4gUu40x8SzGdA2d5l+otn2r1W5G+PbCRgxV/Sq+BDqyDyUicEpinqdLm844VNS7t+poTOSW5zIqePZbwd1RMypp49qoAJy56VTM7Pdo88gHa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujty4Xcfv9TqeuEPwQCsPPMu1k+uJn34NGKW1Z1SvGk=;
 b=KJQhU/tBc6+bK14YSAXuA2Vt32Ksa0LJJnCWEKuwn/uXSrjeAmgf8UCvZS+NLnTZDIu88DsJaoKuADdGMTBt/W7eBO+HCBbq9tT8kLyPk2zKXruu4Vp1SWhS1M5jRMiwZ7G7xa2LHDgENv7j6GHV3OQ8f4jdQNtOdOjpuI8J6QBcBNHQ01Z4fEaPRhFWjjcoqqifxubZlV1rAAZR/LcPWIs/niQnuNps0JA5c/Xnd8PMx3Ex7n61Da4rLiFfxo0hNBOop1EBcfLGOAxfaDCk4rA0PangExemURHF6p/G6psIi01nkoJWJ8GTQ/i0wfNsOKuj+2eK4x7eN7GzbwcLoQ==
Received: from MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 06:21:10 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::c1) by MW4PR03CA0221.outlook.office365.com
 (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11 via Frontend
 Transport; Wed, 12 Jan 2022 06:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 06:21:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 12 Jan 2022 06:21:09 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 11 Jan 2022
 22:21:08 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/5] nvme-fabrics: small cleanup
Date: Tue, 11 Jan 2022 22:20:56 -0800
Message-ID: <20220112062101.90102-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 537edeaf-4817-4516-0930-08d9d593b999
X-MS-TrafficTypeDiagnostic: BY5PR12MB4113:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4113A5BB030C530E7FB09A68A3529@BY5PR12MB4113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTFBbjdkgxWnjL/izvuWvUJx+cnXVSQtXomGS2wFPuLz9DYGZCRMYmGRpolwtYwIa8dEouinRpKVYlVcKZLbF1j0o4YDk8B9k6ufUA+lUGEWQHn93vaqPnDbWs0Oj50NwMXlWKA0FE5I80OGF6bxNL7BwsipXaTJ4FwJ+4rslEgisDx8hNWq+J/+eNNt/MPYZqEKNnROCTP9DSbx6Nznr2C9Oqd0/KVsKZIQKmuTlcKtvDlda4XbqyeNxgEwd6ojAG2RtiovTBhj9fAeljhlSTJC00NsfmWzl56dXqxTAf+rzKXYSeyNxaesiUzmPAMaxgqBVg6nFp8kWLz4yVZbjUiOv9tj4yXCnQEVubZ/PbOchEei8CGa/eW0hZqXZf+fLO1NIlcApsKDcLi+cTzc9mwXU6MzaezO1eVgpePGYcR/88hmnMqItZBypMdBfA1TArhjju9L5vaRzYEHQUrWOy1rNaIHrYEg6wT3P8ta6yMCmRoFXWPcdx1iDujFK+d5Cgt3kerPDsZPuQWGaDHL7675yD1Ed7bFhNgOrNRQqfGL+S7vAi3oBORq0i3hMJjyI4PRPW4nWoTUrmSEWrrQJNoW2dXZQCJv+TbXGUKtWoaXmcB7zgETONKR5jM1kKp13nWAYox4XrCltbbJfNLlLw9P1smac09lHq96I+yDP/OW4dmR4OyRIXKjGKZVjXf/qGaviaE/5BTebpgYT23uMtisdIWpcLIp5L98YfI/2RopSM2oQ4IfKHOx77EY98AqWMcKIP+8AgJwzy9VnGoazNxWuTvX9gSvNrZBFx+GDkE=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(2906002)(16526019)(4744005)(6916009)(26005)(186003)(40460700001)(508600001)(8676002)(5660300002)(86362001)(81166007)(8936002)(54906003)(70206006)(70586007)(7696005)(1076003)(356005)(82310400004)(47076005)(36860700001)(426003)(107886003)(36756003)(4326008)(6666004)(2616005)(83380400001)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 06:21:09.9265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537edeaf-4817-4516-0930-08d9d593b999
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220111_222112_706434_DB96DF8F 
X-CRM114-Status: UNSURE (   7.84  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Hi,

This has small cleaups and a fix suggested by Sagi for
nvmf_dev_show().

-ck

Chaitanya Kulkarni (5):
  nvme-fabrics: use consistent zeroout pattern
  nvme-fabrics: remove unnecessary braces for case
  nvme-fabrics: use unsigned int type
  nvme-fabrics: use unsigned int type
  nvme-fabrics: set ret to -ENODEV for error case

 drivers/nvme/host/fabrics.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.29.0


