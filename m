Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90105C7EE23
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ts6nKK5FMTMkc3yBF2eU4pzsetuUD3O1kVwixodh7oc=; b=W5J6pd9BxIrbdIxMKCGNlFqk0K
	xnsQncn4dUB8DeME0J2SG19P788XeLfCqbas7mNUlBAOWHo7vDHEe4y6rMC8eQfhVD6TKcSUgjIpG
	H52zR7ofe0ObUPgwUSLxnFNbatFzzztOMAIOlnetkW9QPfrZvcqZ1PDPYuSF16oqOqH2aQ+3EYDIJ
	O6M6I8UbU+WFyJ/wNhrpxKn91DVq6BPMQDAortuORSo9tXmIUtJqIRv2q6mpTRJQjHkMIqwCzbXZn
	DK2lLdQt+aGUDJO6PIRgBbv7/WaskmNn2DjDraerauc5RdAgE6/Ru59G4gSlYLzfKdkORj/hh0gCC
	Sy64LBJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px9ZX-009Qw8-2b;
	Thu, 11 May 2023 16:55:19 +0000
Received: from mail-bn1nam02on2061a.outbound.protection.outlook.com ([2a01:111:f400:7eb2::61a] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px9ZU-009Qth-1N
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 16:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQH1pMv3CGa+1CQRLRegqTNmoDYGWbCEf7G3ikTlCtfJeH5zi+IbeOixdB3mErNeQxYSkYyuP+gGWb7RI3S7+tZpzOeRjancoPGp+o5hmuV9/ENp2rvuafgkQgK/pgfC8f3sZv2l3meCw5NlTCjMpWNhscIscBCO9cTkGa4vAC3iVOjkQ9xhTpagswhjsaRw0rOMxspSzxDWJmFKHJG6O3P1fVBqUBbd7dYT06WosTQkuuBUBO4OHGi7Xg1RhmxXlqT1/FDgisSPuJu9ddwJBUzdiiEeJuqpxMa5xZeXPDbltDqnb18Y30ZDhjSLeCnFCuJmU4yxoqzqWxR0TtrIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts6nKK5FMTMkc3yBF2eU4pzsetuUD3O1kVwixodh7oc=;
 b=SrJeaIeS9MIBImRWliF8WiyOnctSHJhkJ7YsTWPvZqy+iF251842cfrty2l6GDgVJsXWaRl/ZM/yHUaTuIQWQenUNO7N+k3mzAZB6Z7urrc5Qxdc7GDexNm+lQpMs4vQZelaarcjclDA75WiyI3nDozCxl34KezQo8UCoHURuklFSq+48qE+qLzx8FQ4I30zukjbRRpDziffAHbMu502H13oJl56U6WXluCShtdY8zx+4IDOZuLSjTzMLfx81HT0Sr9+QgHh9rLOQiy94Y5EACUcVA6JUlXxW19eCKN+6M70Yi5Y6q04UFPFTBYel6TxN9S6RSEoV6clkvkf42+1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts6nKK5FMTMkc3yBF2eU4pzsetuUD3O1kVwixodh7oc=;
 b=KefvJtaNYK733BnYK52eDSzTt/Q5eGrF5N+2b0ormSg+JXU6X0Z5ysR2WW+ouPrTMCDzHkc15OmLi9EY6LxCMnHEKV2phFneuD9Vize9C0h/hb3k4ehjpUVU5U8J2E9NGKLfkL2Kb57HAkVpHBmtl0WyzCNXjxtJoElShkqnmGUdsqosdUkVFunbpw0uYtnhu2ShYGaRTgTWrtOqqAE+QMvIAaAKfGPZGdaNV5HmDHO4Hb4EtW+AhjNWD3pZSoAgWI6Z5ngd7een7dDsxFrYujDNENGwDhxk0lM3BMqQm4azNsmruMdC3c7NWbHpFkFBWMMenMu4SnPqnLQ+QuXgLg==
Received: from BN9PR03CA0314.namprd03.prod.outlook.com (2603:10b6:408:112::19)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 16:55:01 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::64) by BN9PR03CA0314.outlook.office365.com
 (2603:10b6:408:112::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 16:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 16:55:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 09:54:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 09:54:44 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 09:54:41 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v2 0/3] nvme-fabrics: fix un-expected behaviour related to hostnqn and hostid
Date: Thu, 11 May 2023 19:54:38 +0300
Message-ID: <20230511165441.30005-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 256c24b3-fc13-49ac-118e-08db524075b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	AN7hmmL0kodDG86VmrJCq5+9f5LXBKIA8b7bgDcpOCxdjkpuOqGy2HXbA8O7PIGxjzNfvev24vBhsq4wjmVUIjTdiXq/dotnNLAjsOqrOMIaIWiJJcHZPv72XT5O5ZpIjp6urSot+1NaGHu9Uc5GA2M/5Y10HiocteUKUIj3N0+Kyr+Mp0i1c2Zd4rq/eoaN2leKeY6R94Nkntoc5cRX0akc9238CV4oCr9HlJzj4uRxlUcB3gRtMZSBkuv8fIt4DRtl7Uz8Jj0KxBW3+YcHyFEfdSZv504ZvGnPvEqp8d9IuYEpnndqFpXgs0j2mS9chUFgXHZvxU9qQgWcYeOJVFPPINzZ9bhXFvNf19NHyMS1RrsEDivzZClUyC8CBXSnzJSqBiai6W5bkjkd+K53UkTbf6DLQkk6JKzXp1OCP/1tYg4/kxDNsEJXYKBHGm0OvdBFKP9SJyF5LXhxLaIKOY8zbfkFrnrEMDGGCw/pecfG1dRzQIZgh5aRCZAsP8S2v8nI0hXk3bSbbbNGxsiXsQxlt5Z7X5teN6zzfz8YjmP0+2uxMc+xsW8urR8eIN813crb9fixctLrFd6ceQw/F6RqZUSDB8LfZiLf78oxcQLk54grvCVTUzRJxFkK9KWHG+wSfO2LQpHzU3KtanISGZayOe6yiO80Qj4kKumWiRmuk1XSUilorpp6uqYKM9L3RNMoRqBYlvS2+r56QlNXrmSQ0aO4N1RkJYED9IMr7ZWSXWAiaiZORAzCYIFDNbVk
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(5660300002)(41300700001)(8936002)(2906002)(36756003)(82310400005)(8676002)(40480700001)(86362001)(6666004)(36860700001)(478600001)(426003)(336012)(54906003)(2616005)(186003)(107886003)(26005)(1076003)(47076005)(70586007)(70206006)(316002)(356005)(7636003)(82740400003)(110136005)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 16:55:00.7367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256c24b3-fc13-49ac-118e-08db524075b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_095516_463898_26C8B5D9 
X-CRM114-Status: GOOD (  12.13  )
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

Hi Christoph/Sagi/Keith,
I've noticed that we are having some un-expected behaviour in some of
the scenarios of connection establisment related to hostnqn and hostid.
This is specially around overriding hostid for a host.

For example:
-------------
1. Connect to a target with default hostnqn and hostid (after removing
the files from /etc/nvme):
    - # nvme connect -t tcp -n testsubsystem_0 -a 1.1.1.1 -s 4420
2. Check hostnqn and hostid
    - #cat /sys/class/nvme/nvme0/host*
       1791bca2-af3c-4e17-a310-6fbdde3b59cb
       nqn.2014-08.org.nvmexpress:uuid:fc4e5383-ce5c-470d-9889-4adbc2dbe969
3. Connect to a target with given hostid from cmdline:
    - # nvme connect -t tcp -n testsubsystem_0 -a 1.1.1.1 -s 4420 -I 77720af2-ce59-418b-82ff-7c9df0cea35e
        Failed to write to /dev/nvme-fabrics: Operation already in progress <--- failed on duplicate connection check
4. Check hostnqn and hostid of first controller
    - #cat /sys/class/nvme/nvme0/host*
       77720af2-ce59-418b-82ff-7c9df0cea35e <--- hostid was changed !!!!
       nqn.2014-08.org.nvmexpress:uuid:fc4e5383-ce5c-470d-9889-4adbc2dbe969
5. Connect to a target with given hostid from cmdline and allow duplicate connections:
    - # nvme connect -t tcp -n testsubsystem_0 -a 1.1.1.1 -s 4420 -I 77720af2-ce59-418b-82ff-7c9df0cea3bb -D
6. Check hostnqn and hostid of first controller again
    - #cat /sys/class/nvme/nvme0/host*
       77720af2-ce59-418b-82ff-7c9df0cea3bb  <--- hostid was changed again !!!!
       nqn.2014-08.org.nvmexpress:uuid:fc4e5383-ce5c-470d-9889-4adbc2dbe969

This seems like a wrong behaviour to me since in case we try to
reconnect the target will see that a different values after
reconnections and this change the expected behaviour to keep hostid.

According to the spec:

"This feature allows the host to register a Host Identifier with the
controller. The Host Identifier is used by the controller to determine
whether other controllers in the NVM subsystem are associated with the same
host.
"

Also:

"
A host that uses a single Host NQN may employ multiple Host Identifiers
to designate elements of the host
that access an NVM subsystem independently of each other (e.g., physical
or logical partitions of the host)
"

We decided to implement 1:1 mapping for hostnqn and hostid to have
unambiguous host identification even though the fabrics spec allows it.

These patchset fixes the current behaviour.

The first 2 patches are some preparations and cleanups and patch 3/3 is
the actual fix.


Max Gurtovoy (3):
  nvme-fabrics: unify common code in admin and io queue connect
  nvme-fabrics: check hostid using uuid_equal
  nvme-fabrics: prevent overriding of existing host

 drivers/nvme/host/fabrics.c | 172 +++++++++++++++++++++++-------------
 drivers/nvme/host/fabrics.h |   2 +-
 2 files changed, 114 insertions(+), 60 deletions(-)

-- 
2.18.1


