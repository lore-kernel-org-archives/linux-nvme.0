Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC39EB64D7
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 01:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jB2/8ev+7fGTcTWN1RCXOEFvIZJ3gzuJLxTlfInY+Jg=; b=Q1+iKu9V2QOkQbd4LjMkmGGAoc
	D5wDtVtL9UJZrXGPjs6oeL58nvBqPZcPzEJiBw/WSg0fdPaGGKKV28VRqf/UrkgjL9Ia9ihfQUV/Y
	88UYd9L9OLCFPiGc776sqh/4LwTjBcKWI+ilRzqLU5lii4+//qHt5K+HSzCJL+4jONu/RYYSlzbWv
	DYO1sxAy+LklP3MgPiNsm0V2cgH5bEWPPWGGNS+Wq28Vm5IYBDPIR0IvAbNVGSiMd6zR8qoR0n83L
	fhKJ0kHng2qUdktQSfe5/cxyhvE0rClYv6+uU3Pr6fok14mg2ww1/s58Ee/TGhgJltkpFqLQ+yag4
	uZKBNO6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEgIA-00HDwU-0W;
	Thu, 29 Jun 2023 01:17:50 +0000
Received: from mail-co1nam11on2061a.outbound.protection.outlook.com ([2a01:111:f400:7eab::61a] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEgI7-00HDvv-0O
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 01:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8YEPbVtk+HrMDGxj5rvaKthVK6RoYSTczEXmDxjKKYLj/9keSle5XL5/iWYWDF3z8IO/L5A2M8z4Wzc5WSu6Gg4B80VVt4g9Z0PYK8mzcEts8Bn10+hXY802V5i2w7/sn9mItXm33WS3sJ/Ell0KJdi5V7kkN3HarCDKzjJKy3IGvi7Jz1ZmPEyPmfsJ6C9zbr5rT4zVycXrs3aOtamBoLizxccvp1l8oS20cod6APet4tSDDmsFrAE+cGFhWDdLuiBvoSvnKMLtiFMxnfj8VgezL4BQ7qiXU3BnU7QRosGbpJ+xMDVRCjvqaguX9dvphsFh1EttHuC3rKKz5RT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jB2/8ev+7fGTcTWN1RCXOEFvIZJ3gzuJLxTlfInY+Jg=;
 b=Far3jJa+JoAvxi30/u1pspllkOApNkmEoiLjiSeM8oqy23l4mmo14paAfGb90Iy44OZLK8gQs64PH8vqmgQcvFfbDAeWbYm7dZwsPdxBUF1LHOLPoDAh3g8i4jOSevNhs0AcAYJHF7pI/TytJ6mDl16C8PUKIP3m/wmavJSKA5WAroqZzUMpLnKt+jUJB8mgAHrDn9UwB4I+pzjCIyQlw5QuNnjy2xbYkxvgxFeU8WEXeLHizGMp1oalWOo1dzJ18mZK5p4vYyGjwsOOjmqM9XP+VD8Vc3Z7ux2rHdAd+axkk1M5mnF3rqKuJ3T4bWiOWAk339yilsW7g6mXyIATiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jB2/8ev+7fGTcTWN1RCXOEFvIZJ3gzuJLxTlfInY+Jg=;
 b=H3UPmSzg8Qu/kjc8zH6Pt0cz+TZ3KNwy8cBwP2nwRadkWEnhYxyF5dpwbOG0egb8PNKPkWsOblbicIaUlFusrRLxnxbRPPFZ744ENJPkGYLj+/0wFcZUUyiquYra9G6/0E+ExQwmw6FxqZ8I1tbpYM9mM/ec8/9XKPsAirGxX24m4n7n5VeT3P95jp4XvcFYKtvcHfkg+YimkjbZO+XePyRTLjAWCoX5QziUBabHogRwLaFUhItWNaPE3g6vekfsn5vLN3KsW0+5zndCM/9cdUcH1xSgdGJYr3iLVgAXNIuUlqNZh2kcmLagX521MlGU8Oxfds6qEkKK2Fk1yozi3w==
Received: from MW4PR03CA0328.namprd03.prod.outlook.com (2603:10b6:303:dd::33)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 01:17:39 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::2) by MW4PR03CA0328.outlook.office365.com
 (2603:10b6:303:dd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 01:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 01:17:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 18:17:23 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 18:17:23 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<alan.adamson@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V6 0/1] nvme: allow passthru cmd error logging
Date: Wed, 28 Jun 2023 18:17:12 -0700
Message-ID: <20230629011713.28554-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: f6222942-d814-4bdb-8f4a-08db783ea0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHHFFKdajOuq5iSltcJ1toseTgu5bjWBb6TL/rfbvwliMqsBf2/pjbca0spV32LFbd15ocQ+HB2P5qIfY2VUiYfenmzn/FO7vz2rTm5rVIiqPFJgO1FmvxfNotv0IUMcjbIy7kwRFfeuF8HY/JS77Ahc0vjcDkbyrc8zg16oz7UbWdi98G9tXfzc7QkztuvMZR8I28jGR5q8pMBJW0MS9gWxu8QDlp2gWIFbubyRQjfzfAg56YpPq4eXc9odpu7w37E9zGHfnshbBn1ccXiompaQHmcfh48oObohpijqaTBQo8r+BvPdjA0EPy/9FgdFrLlNbFCaFa9vFyaT0pn7EAXafm0PXx78dlBVGbGxVqArsO1u0sGHBG+pnaN9CPWkgtYrkvhgdN/U6LHw2fEbxLOBCnSUiu0Uj9eJbP5ACpWpHuU5nYNJDlQt/9XNiwdqJqFs9qL20ENtPaPX4zNl0YmLh7lTy1VNDlLtxhhRu2vHJyXPKi6aujFVU0Uup00eYn19DUCa+FJoMwCbUsukEdM+DH6gJJT9xQmhBf7yjyFupEDtecTLRTpFTiOJKtOoWFWRdE6ImIsUaUYehUGxLJZzp0VVDrSc8rvIkrwdk4QkBEhIVyvUBCeKeo98lDkTzcvBT5qrGl5oJ/HC4U8E3L5AmzYrFakJeesh+R0jgzPoEv3n9kDyPqfyahXjmg4U0TJxepL+6E5EgE4hIAvmaOuVLXCLkQaXNQ6nniuquhpN8/DNZ+grrygTl+akjHdf
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(82310400005)(4326008)(36860700001)(107886003)(478600001)(47076005)(336012)(7696005)(6666004)(54906003)(83380400001)(26005)(1076003)(186003)(426003)(2616005)(2906002)(356005)(70206006)(36756003)(82740400003)(7636003)(5660300002)(8676002)(40480700001)(70586007)(41300700001)(6916009)(40460700003)(8936002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 01:17:38.4920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6222942-d814-4bdb-8f4a-08db783ea0f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_181747_187258_039D827A 
X-CRM114-Status: GOOD (  12.14  )
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

Hi,

In nvme_end_req() we only log errors which are for non-passthru
commands. Add a helper function nvme_log_err_passthru() that allows us
to log error for passthru commands by decoding cdw10-cdw15 values of
nvme command.

Below is short testlog :-

* Admin Passsthru error log off, no errors are printed
* Admin Passsthru error log on, errors are printed
* IO Passsthru error log off, errors are printed
* IO Passsthru error log on, errors are printed

-ck

Chaitanya Kulkarni (1):
  nvme: allow passthru cmd error logging

v6:
- Reabse, etest nvme-6.5 and add test log for admin and I/O
  passthru error log.

v5:
- Trim down code in the nvme_log_error_passthrough().
  Use following to get the disk name as an arg to
   pr_err_ratelimited() :-
	ns ? ns->disk->disk_name : dev_name(nr->ctrl->device),
  Use following to get the admin vs I/O opcode string as an arg to
  pr_err_ratelimited() :-
       	ns ? nvme_get_opcode_str(nr->cmd->common.opcode) :
       	     nvme_get_admin_opcode_str(nr->cmd->common.opcode),
- Rename nvme_log_error_passthrough() -> nvme_log_err_passthru().
- Remove else and return directly in nvme_passthru_err_log_show().
- Generate error on invalid values of the passthru_enable variable
  in nvme_passthru_log_store().
- Rename passthrough -> passthru.
- Rename sysfs attr from passthru_admin_err_logging -> passthru_log_err.

v4:
- Change sysfs attribute to passthru_admin_err_logging
- Only log passthrough admin commands.  IO passthrough commands will
  always be logged.

v3:
- Log a passthrough specific message that dumps CDW* contents.
- Enable/disable vis sysfs rather than debugfs.

v2:
- Included Pankaj Raghav's patch 'nvme: ignore starting sector while 
  error logging for passthrough requests'
  with a couple changes.
- Moved error_logging flag to nvme_ctrl structure
- The entire nvme-debugfs.c does not need to be guarded by 
  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS.
- Use IS_ENABLED((CONFIG_NVME_ERROR_LOGGING_DEBUG_FS)) to determine if 
  error logging should be initialized.
- Various other nits.

 drivers/nvme/host/core.c  | 43 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 39 +++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 5 deletions(-)

* Admin Passsthru error log off, no errors are printed :-

nvme (nvme-6.5) #
nvme (nvme-6.5) # echo 0 > /sys/class/nvme/nvme0/passthru_err_log
nvme (nvme-6.5) # nvme telemetry-log -o /tmp/test /dev/nvme0
NVMe status: Invalid Field in Command: A reserved coded value or an unsupported value in a defined field(0x4002)
Failed to acquire telemetry log 16386!
nvme (nvme-6.5) # cd -
/sys/kernel/debug/tracing/events/nvme
nvme # cd -
/mnt/data/nvme
nvme (nvme-6.5) # dmesg  -c

* Admin Passsthru error log on, errors are printed :-

nvme (nvme-6.5) # echo 1 > /sys/class/nvme/nvme0/passthru_err_log
nvme (nvme-6.5) # nvme telemetry-log -o /tmp/test /dev/nvme0
NVMe status: Invalid Field in Command: A reserved coded value or an unsupported value in a defined field(0x4002)
Failed to acquire telemetry log 16386!
nvme (nvme-6.5) # dmesg  -c
[  860.013105] nvme0: Get Log Page(0x2), Invalid Field in Command (sct 0x0 / sc 0x2) DNR cdw10=0x7f0107 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0
nvme (nvme-6.5) #
nvme (nvme-6.5) #

* IO Passsthru error log off, errors are printed :-

nvme (nvme-6.5) #  echo 0 > /sys/class/nvme/nvme0/passthru_err_log
nvme (nvme-6.5) # nvme write-zeroes -n 1 -s 0x200000 -c 10 /dev/nvme0
NVMe status: LBA Out of Range: The command references an LBA that exceeds the size of the namespace(0x4080)
nvme (nvme-6.5) # dmesg -c
[73675.769162] nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[73675.769233] nvme0n1: Write Zeroes(0x8), LBA Out of Range (sct 0x0 / sc 0x80) DNR cdw10=0x200000 cdw11=0x0 cdw12=0xa cdw13=0x0 cdw14=0x0 cdw15=0x0

* IO Passsthru error log on, errors are printed :-

nvme (nvme-6.5) #  echo 1 > /sys/class/nvme/nvme0/passthru_err_log
nvme (nvme-6.5) # nvme write-zeroes -n 1 -s 0x200000 -c 10 /dev/nvme0
NVMe status: LBA Out of Range: The command references an LBA that exceeds the size of the namespace(0x4080)
nvme (nvme-6.5) # dmesg -c
[73684.208241] nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[73684.208419] nvme0n1: Write Zeroes(0x8), LBA Out of Range (sct 0x0 / sc 0x80) DNR cdw10=0x200000 cdw11=0x0 cdw12=0xa cdw13=0x0 cdw14=0x0 cdw15=0x0
nvme (nvme-6.5) # 

-- 
2.40.0


