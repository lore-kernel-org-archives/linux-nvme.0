Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 21:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6bToGQ/UAlDVZLaqEiScfsh96s0OqrQBPcKnnHOnHYk=; b=TD9tlHGMCidJeZIC/4XPO+i4MR
	i2xdmQTIPNpEbACSmTh0XQbiN7sdNmu5lxNhFnEuKd3zFIOLTpr/jkwzYNSWie+a5yFiWSoo2R/dT
	4DXYple8gIz8UlTqbWp8hlv4rxRTnKhcx2g1M1xWcptvbDlAXMQGeNM7VNdFLYLzzd5pez8mwSQwS
	M8oxaMIfixr76GrK1ANNZGRoO2xiMKs7wuPR5xoC4Ef+64njDCNX4+ITCqRKy7gR4uuREq3AyFqkc
	+ntUQOFmwHFyjLnuG/2TjJTAiWvs3cQiXDJVzubfybHuCpmHtFbWPIAvpZhuXdwnSYn7k7/4Z+KCg
	F9HDUvPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFNHs-00Gvc6-7D; Wed, 02 Feb 2022 21:35:36 +0000
Received: from mail-mw2nam10olkn20813.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::813]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFNHo-00Gvb4-Ge
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 21:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuCnDhR7nCD0GdLK0+wETgA4+FgfHlcKk0mumSPh+iL925nMLD0npDfrpeWimABWlBRei68giClYOZVuF6lISkq5+e2thZNsBpReGBLK0Y4+YuJFLwTJz/fwmp8qjUxpdEFIvKQE7Nv5zo7gfVjpQSq6DAV2ju2PwADDHobyRDizACSVKiHWgQRMYQGuF/q87FG3PupJ8LoTjjEdWV+wHPn0VgRSznwaSjcxeqGW+fxtpD9CuEZeBhKAvY32uY1seyiC85r8tzupJUPzMaazvUmNl5j3LoPNiL45OxLhPkwJxD8ZS83bxKwb0atxQAa4o8EsHiEsqPVM/CvTmAYIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bToGQ/UAlDVZLaqEiScfsh96s0OqrQBPcKnnHOnHYk=;
 b=CVrOoIQ4fzR3iMHBCZY+SV8D4hEKh7T13CmGBhP7xtnbO0q2xwIxg8XHzpoq/8xlz4+gAdX1bppoSQSDJqiiu+JK6IuXUEDaX+bscqNmi0rF8Wq2cbGKbNFMLFXFkzWU7VMxyx6LsZbjinDe8SK7i2b9skmcbg7jhEWWg1TOHqU+usUQlxDz5rSudv99LYlPPYkE73SGzmT2S4bzW6GZszWClAM8Ix/24fWvf19/K4o0hcSYxw/XSAyDSdLqHyPX9kbg7DEPqe8f9HKoYjNGXZ9dKo0BNGfqL+ZOisdWibxgB/EDIetnqcYxlpalvK5bDUOHweT0C+9PeVQASZo8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bToGQ/UAlDVZLaqEiScfsh96s0OqrQBPcKnnHOnHYk=;
 b=a2Yq7SCWnof5Q+9OGfRMpuKObsMKEtNxwA/E3tw8owsD75Hf7AWdvOtDAQve2ZsuEr1NdtFpFlSwFFUmxDwtC8blRU7Jisy8W4rCjUIyti5Ai9iF3ypw1SkeOR953B0BlXgyyzGtAhysSrCcHqy/YigSlnecW//2ab5X5ERekkUyzRMiYGiPUWqmMef/6JX+YT2leCPP2Eg/xLb8oYs5NyqkAHjCezfDQtHguDap9MXY6Yzkterd0ZLtkMX6ABMCtgBg0nZaTD9FY3lTPd/bHaXnQG0GeSwCjjQeu0m/8pZISwBesEjddgdh5BIiNsG5bU2UWB4GO47LBECurJpahw==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by BYAPR13MB2695.namprd13.prod.outlook.com (2603:10b6:a03:f7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Wed, 2 Feb
 2022 21:35:26 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 21:35:26 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 0/2] nvme: Add TP8010 support
Date: Wed,  2 Feb 2022 16:34:49 -0500
Message-ID: <BL0PR13MB42918026790456179073D8039C279@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [G1ZaiolIvk0KUGY+DcW7nI6Nr7uUgWmo]
X-ClientProxiedBy: SN7PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:806:120::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220202213451.33599-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbb81d64-5598-4054-7911-08d9e693ed54
X-MS-TrafficTypeDiagnostic: BYAPR13MB2695:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slXFPtOt8dxBsBGJdXhyysRcO43hwpTQAtRUCvoHk1m/flJbtV9Y6pDEddTd7GrH82oX+WXiuxYm1Rg1ChL/3fWvzch1C0WgR8xZeO7ZNPIDU/nLRBHpnF4+aWPKaVJs/I7coYjZbUrWpN+VFnxVZC5Eclu3jIHXgNA93Q1TG6r2g/0qGlcsxgCjzUoqgaNbuj/Zz4cjylY2w3UTeipxv4wUM8wNcZ6yujRZRZyHLZV1RO9eLpGOZuCotI9Ydc9PoOny46pqZLIab5Ou3lxUdBHzJMhIBNj4vrTb/TPxsSaX/6IT/R9Ms7ZweFFz1UIea/CBXxgqa2awNryb+PsZRRjS2VnialzBydmDMZh2fcSNXg6wYhifd2K9cNXtMSfper51lXbApFMpz7H+VKxkV8qMgGkmibW2yG8eqvpX3ZFkjSF+oPWIFXhP1t2vTggu0yeI1u6FuejLu2xDgbVBb2yYOmtsx5HH2RyVhwObUDV4NzMKpf90MWGVVRCHkTbXJYJLCfetxZlBvZYhMSf/Zc4kTFHy0vu0/6YNQNPPHqQRRJ9xkKhAoneUj/LG4PvM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8U2AOfFTn2MW+5iG12Rc8ZMVo38fAWyMAUvIHCSnpUdpLhN5ufSPPaLOh1U8?=
 =?us-ascii?Q?DMRK8q7EqVArxBOKQUk0bfTmPWzHFZ49oGY0fnKrS8HVSsWpUi8mLoB6atba?=
 =?us-ascii?Q?iAin3JusToOIfqaGBhGSBxqiRx8Imsfz907OsQSM8tiKeMzfHfw90eGOjqBi?=
 =?us-ascii?Q?FoCxubpAmvix+7ZNAH2DgKx7Cp2EEgygkCMYqX1KRDQq8KIqb3oDoczAzT28?=
 =?us-ascii?Q?T1vwVtZs8opESGwLzdOtGzWM9bHaFdnwPyVUp/qAKxqbpKrfYHtCWx5Wx5UT?=
 =?us-ascii?Q?F721Npb7H3k/e4Q/yOoQX0LsstdajOFAXyd2dgiVW07+lQHqQGSKbUxn0eQ6?=
 =?us-ascii?Q?VipyZIVuHNkovgwAeDeoiwWLWTbAIDNOC3fQsqgQrZyEjIHKsbJe4uxcO+mt?=
 =?us-ascii?Q?ZWGuMp4vqk+NxSV7Yqwsbyg/5yw89U4X/jcn1NCGqmz8daDrAcgsecpL4rd8?=
 =?us-ascii?Q?XeFuT/6Nt6wi6F0eAUEw0PEa9ZUP+IfZI4lysSLiN8fpZgnyBFBo6U+3vm9Q?=
 =?us-ascii?Q?xpnPIG/8dPa9Thzn3frxT1VraN7F6bgNS7e7Ai9m+xVx4Ku9foh+SMTmznX6?=
 =?us-ascii?Q?/11MOq7kfKPiWRqQR3+lmR3JN3ikcATJS51NZ8p1X1ShejqpUJM4LbnLEosU?=
 =?us-ascii?Q?Hs6C6246S24sG25ASKpCyYHDSN+Es+7QdhyohaAmU/oj3Z+fNvLPNQmwlcu2?=
 =?us-ascii?Q?M1r8wQGLqooUJDUqW3CW7hNhsWiBPu/cRArmmGs29xqmFD77NVUenP4W7EWp?=
 =?us-ascii?Q?Q36ASHjQKOpNyzgrMCx6Ajgl4k+HqFvSp1MC6KzZ+UWgeiSYvAkcmt+73+tr?=
 =?us-ascii?Q?UYnEBzwXftvfrriQROj1+HJQhvXfl5ly1ynCbVwsc34TGHwRzsLsSap1zF4n?=
 =?us-ascii?Q?Q99tzo/phBS7qnQyqHfQxNANsEsZt5VBHHGCmeatUhQeYunogbhVB5Pp946n?=
 =?us-ascii?Q?d0qRUcMmbNEDX87w4TDCaA=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb81d64-5598-4054-7911-08d9e693ed54
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:35:26.8452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2695
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_133532_600785_D7E99FBE 
X-CRM114-Status: UNSURE (   9.56  )
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
which is used to perform explicit registration with CDCs and DDCs.
This new PDU carries extra information such as the Entity Name (ENAME),
the Entity Version (EVER), the Symbolic Name, etc.

After review from the Linux-nvme community, it was decided that the
DIM PDU would be sent from a user-space application. Since the DIM
PDU must be sent every time connectivity is established with a DC,
it was decided that a new uevent was needed to tell user-space
application when the driver establishes connectivity with a DC.

Martin Belanger (2):
  nvme: send uevent on connection up
  nvme: Expose cntrltype and dctype through sysfs.

 drivers/nvme/host/core.c | 44 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 include/linux/nvme.h     | 10 ++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.34.1


