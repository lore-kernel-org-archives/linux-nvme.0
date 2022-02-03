Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE95C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 21:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ig9bVRSjCnBJTFtLte5Axw+xZ9xKbD2UT1GMWf0Brag=; b=R0dzacTCIV0hq3kA2q8WpBx6rv
	UyWA+NAVKhBZ6ZAAXdx8A3BSCx9F+XvxJ9uBsLM6LANWygV35miJFXLDpAhehKxNtwXGhdw2HpNoq
	VuQlKgaSGhoLKvUkQFj7Rt0V610GhgB/p4UKPa8g5TGvugyWEAfKeNS+KXRbu4yElHCca9fXjoTS2
	9RLcvsKIqGuOp5yxYA8bXarhnaDLE8zECL+0GI8rRd9vBtyiGY60t/hE/9aVq/Us0W4lHClhawU74
	TbmFVAMoll/yi9jWGt/Dcd4TTPPFoRMYGNy3pOZw6PQqRxAk6XP5PuHpGNvVtUw6OLc0JlplCSgEF
	GV6UdFfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFjUw-002uk6-5K; Thu, 03 Feb 2022 21:18:34 +0000
Received: from mail-mw2nam08olkn2080b.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::80b]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFjUt-002ujK-37
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 21:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0yiGxy2seWeRxiS34CB35mNCWnI9R00GpLlDPrltURKeRlpw4q6wdg9vAVTPy819fUJX21FbgOjwn0BrWmbmAcaWcfCHI2DwG/wOtxqCZiPo1cz72UlXPDTmHBlWsbjjOJnJqCLZ/0xnY9AOYcR5KodMg/xv9Rv9e43diI7PXME0K8UOgjAndtmvqM6SVAkD2fxRfEucYxi4wABmih3qUMeZvJTKZVZyfpFVsknHyMOClQIvT95Q/7UimtsXBQFjM9w7/8lhtan49h6+c+jsTDswegcL2s/0wWc9zD8YI4LFlvDdM6rO6Pi0O+FUIbzRknT7ITl3jhX/JZ5+kNdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig9bVRSjCnBJTFtLte5Axw+xZ9xKbD2UT1GMWf0Brag=;
 b=aIMmgur04rVLR+IIbWeiCsenz2TcJIPRZCBqtE7kYt+TrvTdYgEPHc8YvjDLbgKWabuWR0pRiflqFZwq8F+r1zXVj/1CeRLgA91oE1AsB21VccLkzZ+AO5pIMkzEhrPqINmBlJfXnYd/TqEBTkVw94PZkXjiY15mi8Nx7XFkzqKZBiQG0c5vyjpTrRgpStUKlZ7Mv77gSwjXYwkfsbn1fazcbplczNti/qGXfF0FS9nZ/LiPWQT+Io00TRuNksLhx4gfVmMobMJ4BbD01EYCNvyx464dt94sShLuNKfM87jV59f4Aim5ESfbmvAgOK1WisN/F7cKnDzb0GcU8qRz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig9bVRSjCnBJTFtLte5Axw+xZ9xKbD2UT1GMWf0Brag=;
 b=qQ+lxMPBIE6bA/SylWwfpkycblG3drAppnRv5g96+4/4AxS2gvRkM0O3qv39fb3Zm2V1bMbgZrKyAtsoZRSoALJNSSDHfwSg+3QUmFN0Umu+WVCJS4+NS/gETXrarLFeQBKQDKnKDPLRHfGwXqGgP6OKlMYqlwCy1BY9nxlxFXEpvqK+H/t+1twCTAEvt8UrfJbqY4dN8hanoyQTdog3IK7WQlu2XapCdGsRC4O4vlCErGRXSbVXsmQWU2SPRzpfkgaqMNPJflGaX39Zz2WD2Kh5P0E0y+eAdMcXckSXckT3hT5m56ieORJDwAdJaa2sAOtJto4UAf6XGglA44L6Dw==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MW4PR13MB5410.namprd13.prod.outlook.com (2603:10b6:303:180::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Thu, 3 Feb
 2022 21:18:23 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 21:18:23 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, gregkh@linuxfoundation.org, rafael@kernel.org,
 charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCHv2 0/3] nvme: Add TP8010 support
Date: Thu,  3 Feb 2022 16:17:45 -0500
Message-ID: <BL0PR13MB429198A1CFD5C26852E35D7C9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BGSlRLx2x5honhR5pLd80ruFVkZMfcWB]
X-ClientProxiedBy: SA9PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:806:27::28) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220203211748.27542-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 216af154-2504-47c3-54f9-08d9e75ab518
X-MS-TrafficTypeDiagnostic: MW4PR13MB5410:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxrJ6rBFV5eqFofrIon44kTSV8y4N2AYsqdpcv5hszugTZ/FZumUKDcx54miBBuLsxB3/eBwDWrw3RHRdbpdvAhLyBf0sOmwfxmUYJBXOsRojXDL1cxSMflZfl3OUMiYUZlYiKiHZdOzY0bY8UnSYezVWwTrcknSauENXYA9q1p2zOec+301md1HDYb6qUOBWI6zKdWP94DC03ysUrnxUImBDDZu1xWLhrOb+FH0TBrieS0ZZTaetpsp0ECHJUvsEJe01AfP/Ue2uuEo/XPWkuH1iUcuyQBbomoC7PDeADuKwPB4+UskCDmJJC5xit3muVr4BqgN7EFb7qImb2rWPFiirkw14GihLV7qWgS5+AvGLktZiWm2iA6mNOkL0gJwdr1R6wHdfM0QoqKkQefnuZn6WJB82ij5oka0iivXi2oYls3geGPTnzaywos96J08rY/L80L+xxtewpmJ+9CuxiSwBLuM6bz7oywE2Iql+SiAmi4THYVM5jpDt7B6J6oQyOY7t6lMkq5Zfh+qOhvfI+XVTRMlLvFIi1ZNXjLiBW3khVO7W2bwrATazWtH7jYK/BMnsXo/NmcDv/zsrBiPdA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GWdE0JiuDF87zdifd/VIJGw5vr1IvktHzSFfFz3vt5+A2iadXugKjT1sB/fR?=
 =?us-ascii?Q?ZqJF/aIROXgBIXL2HhBTYzHNYY+ktd8HyeU5vPGxVFjIMXGy/7g+yqQG/xVK?=
 =?us-ascii?Q?9+kblagMWP7tpxpxvPrc/zy/f3p06DIPfyh0XDuu++cVr5W3eUl39pciZYat?=
 =?us-ascii?Q?BrlQgVhhSbxe9ROgzAV4A15dDK9bZX5TAdHakLCN68wMYpFPutj3vEdUSWj0?=
 =?us-ascii?Q?E9nAAl9P0vu4hvDFLVKvpgmraOwnU5u7aMqi6Hohs2uAqvMD2n0RO1PmelCu?=
 =?us-ascii?Q?XeD62RSGnNGTNFJm6ANSBKjosu1a0jX/3+zCxg0gMWRBxdhJF5uVtWK+S1IN?=
 =?us-ascii?Q?Q80VnDIU5l5FtyDyOF7XSobK7NWHxJjPNx3itMND6+8wUW336xv6tSk5IfT3?=
 =?us-ascii?Q?3VMe2heotWK00TFtEqTlDQY6PsUtTPNOL9R5uJ175qBmB5UxDTSdg17POe6i?=
 =?us-ascii?Q?CT9r2J2WQ8W1BZED82ZXKAWMIxdcZ2DyDhod1EAGSOMCUB2k18HKeZ06/VSu?=
 =?us-ascii?Q?LtcnI7FM91/PAQHRtzwZEwYRATPlWYw9vYZhYU1sJU5IL9qiyGvZgL3Wsgfz?=
 =?us-ascii?Q?71T8wtQZvERIAFJE6fzPjicyC98qo4mXLQjR3a12pl1dkYi+8f9dvIUDNC16?=
 =?us-ascii?Q?zMFF2+V/dACy0FxweBlCylaFU656zyGQ7UBPFo1ZxC/8h8xxT9yAporhXeRI?=
 =?us-ascii?Q?7X/theU8s1miN2DhuThGx7cayqDVLIiaQIid/hdj9z9cs2fvZum+o/a1H6i5?=
 =?us-ascii?Q?r9EX7nEtTPolVk+qAiTvyPrD5u4WBbwiSCgzsT9ZIUoRhX1ePCcHV2BJpecU?=
 =?us-ascii?Q?f/kO/kCGP2evVAEXkzF4E7GDUtQ7Q3ycuZDNWDOpfJIfo+TSs2nLu8Y5nEW8?=
 =?us-ascii?Q?ceBo0va1bJYpb1fMdIonKgT9Q2tycFG/6efN/p7Uo6kyKSGKQkJvd9xeIk+4?=
 =?us-ascii?Q?ZEky0JsXiQ5iuahtmO1WdQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 216af154-2504-47c3-54f9-08d9e75ab518
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:18:23.0353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5410
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_131831_168738_3E7DD04C 
X-CRM114-Status: UNSURE (   9.22  )
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

From: Martin Belanger <martin.belanger@dell.com>

TP8010 defines the Central Discovery Controller (CDC). To tell a CDC
apart from a DDC (Direct Discovery Controller), the response to the
Identify command now carries a Discovery Controller Type (dctype)
attribute.

TP8010 also defines a new Discovery Information Management (DIM) PDU
which is used to perform explicit registration with CDCs and DDCs. This
new PDU carries extra information such as the Entity Name (ENAME), the
Entity Version (EVER), the Symbolic Name, etc.

After review from the Linux-nvme community, it was decided that the DIM
PDU would be sent from a user-space application. Since the DIM PDU must
be sent every time connectivity is established with a DC, it was
decided that a new uevent was needed to tell user-space application
when the driver establishes connectivity with a DC.

Martin Belanger (3):
  nvme: send uevent on connection up
  nvme: Add device_update_groups()
  nvme: Expose cntrltype and dctype through sysfs

 drivers/base/core.c      | 28 +++++++++++++++++++++
 drivers/nvme/host/core.c | 54 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 include/linux/device.h   |  1 +
 include/linux/nvme.h     | 10 +++++++-
 5 files changed, 95 insertions(+), 1 deletion(-)

-- 
2.34.1


