Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9427EC38145
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I/kkB7z2aDmcp35vjcs27rWjrbTK6LbNEM8kyDOaP28=; b=YayVIQM9P/UYsylIsNpaH6jGrI
	I9yS2N/Uo8/goKSnMOtc1/RG0BQqpXNyijCD24a/D/FQ1kEotL3KnaCJfVFfnOtLk51CKNGgCwV/K
	QSxEAstzYMAbnml2TBbvBOrj9/ndcN7KAzLmjEuEto/nGsTOIj44FDbRJoHDRj/7KvMesL/xwVpiu
	PojtJz4hCYaFrmyL/OSGWER+D7177eqtlKr7GAPs2e/eh1Wa2R+vTw3jEa6tkC9vTiJAm+gC1bShm
	gvRl846rLzeKATC/4hVHvhx1QAINb3i+9QK6viUy9o4PidpAHuI0BqNilJhkBEwCWrgf2d0qecdwb
	M3OuIAlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU7aE-005WWq-Tb; Fri, 02 Sep 2022 14:23:46 +0000
Received: from mail-mw2nam10olkn2028.outbound.protection.outlook.com ([40.92.42.28] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU7a9-005WU9-Fk
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 14:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKxp4jjEAaER/IuA9BXfBcsRvt59Lq86dp1MoE0K/KJ7osJybziVsV8hK7zeK8hwbS571E3x6xf/aBcPypXkBf2fCwcq1hjCLDvk3G8JycyvzpJy6yytgRmE2Et/xQMehVspn2lcbCgWH8jfJ3k0Sw5r7wfVmeVDkTAMiQ5taKh2fLgGGHjzV6l0Dh0ogVmNnmz6SFpdVpvsZMJQKsvr2mzInmj1jF888BAUKgUIsYEU69l0IUUH9Ciw/K69IkJy/BN4FVyF8h5L6vssS7eH3DgS8qjX8h9bmJXUqwBTgoSmr2AuyF2/q2o0ij4InCLX4ejC1Lvjuy1P/eSP3Jex7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/kkB7z2aDmcp35vjcs27rWjrbTK6LbNEM8kyDOaP28=;
 b=SrdoQn+9N3cM35zDEe6NmqUIkxa61JVG6t6SPAq6Px2Of/zOiiEzL6ygI3qDlE5ZRkxCUpq8fQNEHhubqzSFyAD95PwnbcdBsOYWR8iUkOQkjRc35ErhQhT3bxGFydq6RU/WQzt5FAndZaTk/jx1iBpbfYnDf6sWJsYfnwUh11ui5xCGgDpz6GOfZt0x/cT5Vabn6sZrlguT03wZajnekZv7k3bY4nJnIIa50d2KQA2wGVqj5ryVb6C9azL+Vl4YQ2iFmvk/k8ixK4BXZdMqyqIZ7cVorkZL8896vlZ29ISEe/18iRrOyRKTK1MnywNjDSaw7mQGwD/8J1e4CFwH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/kkB7z2aDmcp35vjcs27rWjrbTK6LbNEM8kyDOaP28=;
 b=Xoiy6XU149Fzv6SuYPPk1yXf59/9CSczFPzcgirEKHuS1nsJ3cFh558WNpg+2yK9xm97Ppwgo2HhW2UoV9KmNbA+XJPzqoztlgEcvVJhJq1qEbhknK2vtf7dTh9Iup2s/YG7GLykA3kKf5SWKk5x5tHoL7l/XaIHF3F9pazHrKRiRVVh0KXSF2+GGlOoi4b1P91XNvua5wzdy3/GzacL+3MJPTrrQicEI39gBshEYivVGtuJrIiAWRmWXowVymyev1cozaNPSVVHLWgYZoNDzlSVudnzFn4jBl2JnTdY9oz3gkd+KrI686y+p0DGATWC3X3h04HJLtJJN7nhqhS9OA==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MW3PR13MB4123.namprd13.prod.outlook.com (2603:10b6:303:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.6; Fri, 2 Sep
 2022 14:23:35 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::99a0:3364:b3a8:f5fd]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::99a0:3364:b3a8:f5fd%4]) with mapi id 15.20.5612.005; Fri, 2 Sep 2022
 14:23:35 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hare@suse.de,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH v3] nvme-tcp: Print actual source IP address through sysfs "address" attr
Date: Fri,  2 Sep 2022 10:23:16 -0400
Message-ID:  <BL0PR13MB42919EA6B50B34A1A60455969C7A9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZT9muoWrXqH9dPwTdJ3v+vKgG3Vbu+UN]
X-ClientProxiedBy: BN9PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:408:f9::23) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220902142316.7225-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4291:EE_|MW3PR13MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4decca-14fd-4a1c-6527-08da8ceeb877
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	HkopJft4okiEtprHC4IyLpKuxgoV+n2ss7LnrkFbHyqK8Lbo5spykLPBsmHr6F5RCw6bGfKaL05ZVARxn7CX1TfnE0gc5E1J0rYqD5cCeK2al0lq5yJwLfqN/k5dtT4QPGvMP1Q93Col0cbvaz/djVRvxc85w8EgUpzpDVDUOSRiJu8HXtcCjiSDg+Gfi0FnwzvQHiycXyFRXGgq/GUtCrbEOh981uUwM6PSZjVDlxakMgyBu5uY6/g0VVugheLRTfFfB5B7cyvwp4Kfnku+B9nPOqtc07xp1ELQEKbAsGV5eRySiJgfV9ou/YqfjgOky4J/ndY3laBjg2KeWqTTo6qU9/0NB9fTcG6fi4rpexOvd8Ca3GDr0ZwpuksJMXC6BJVNioXi1sGx7Ws+HssQypZ6Jhc+yDMAx+oACCV7lowj9JklOhS5da/Pl50PGioUWvd5QPQAsja4zCLgFPYKDKUxE6ij0SJ18FJxXwEvuvXk1ZxHs9f5M5JAb+6SX0IwYGmmhWvOGH5kmMvqAAWxpMFMbRswMzB9wuuorlXb1+bmIJAfil1AXOY4Z1zH5h05avTH6oxDIogspZj1TZExfIoFVLfai90TS3nQAsvmW1l1IwjKKWNrJTtZv5JiNV0x
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?e5dqz6YX4UxCz53Y5zzszge7ZqbG6kiZKBFLMeCF6qOmFEeaplnitrtetwoN?=
 =?us-ascii?Q?Rgm4ctuVzS+yhsO7jXfyNNwg5Z2Rr7QV1PfWxEHX6zXAebpwLmde6w9F4kyv?=
 =?us-ascii?Q?g0U1YMSISuQ76Oah0r13LFuJtVL2FF69gweOE/z/3+t0y6hvPf+rHz9s8hkL?=
 =?us-ascii?Q?ZbZmWLvuH6VWwrQIIao5EFABYO9CyzzL7l0yYT+BsFvLmoy01WLEKOtaz3Pm?=
 =?us-ascii?Q?zh5W7S+DQyH8DscmTITbJpCCzoiI2sqHasvUVd94bJCFx/4yIGD1of6qp6bO?=
 =?us-ascii?Q?wBo6MjtzdATlMC+X99pgWlrimK4Xi4wHoWVLmSGRpdnGM/Lsa25aZR8GjzdU?=
 =?us-ascii?Q?bNNo8xoFFC8IEjUms4lQMVM23TOkyRCN3gHLVWU3docvlcCirOTXD1UUgpZu?=
 =?us-ascii?Q?kv0rcPzfWQzVr4VyRpk94hlL9L2yZK2zf9zpnh/ubqLaqrkDVmCV9JSESpZI?=
 =?us-ascii?Q?G8OANKCl1b10VV2NO8tWhpfOJ5Lsdt9Q3gSnonECvIjH71yg4N3hRY/tzEMy?=
 =?us-ascii?Q?DiLkKbTjjmfiHburqsqougjr5qRqWomtKMQoEbJ5siLZn0sYSS/+Gq9fpFIE?=
 =?us-ascii?Q?CkmI1U6sPUUWabaSBn1KPQFyj6G07ipvGdwY9hUBbc9HtRVqZPPxTKknilw3?=
 =?us-ascii?Q?PGHwKtMb+TpxGMfYYx4tvWSt8A9JdfmhZ5fr2AA5lCYTtE6zly+5n1uo+P3V?=
 =?us-ascii?Q?VIJrTWQ195dZ7AczqTAr0HxncBeEQrLxdRr7FD6g2ca8IxpDoQECiQTgRjnc?=
 =?us-ascii?Q?vP+jJdwlbe7Jnyb0vIkoBBI6x5I6O+AAASCsmCD64Z/R53lFa8Kec5HHvWUu?=
 =?us-ascii?Q?t13Q/mIB54n6VOIrqylcKTqCbcTIdDd5UC819Xq+jjuKA66XcAG7dmC6X0Tc?=
 =?us-ascii?Q?2tNmFDZYtWTBetnZoU7klQuWjy5SX8Xw0awKMDIYPhTkRrs+up1NAYiK3ezF?=
 =?us-ascii?Q?c9vJ6pPKffUtC63hB2fA1fqM2R7taXWIe4fAg2M36mfasPkY5FCS30yop8Dx?=
 =?us-ascii?Q?4HDq6Z08924Ws9p3npiyV5jSgCfHLirMb31Kmwn2vF4q+LfG/LAn2laMYXp3?=
 =?us-ascii?Q?S2xPLi7JfC9K7npgLKWew1TP2yKIYJFvDt66/I983zXRSj2ZfrbWCeSRwc95?=
 =?us-ascii?Q?2zS1kSkDVdolvF2RlCvUXGkeYrxwLAhipytsI7bTqeQM7rrE2vZROaViXf25?=
 =?us-ascii?Q?kClHbsiaMevudbGwb+dzh2JNduuUsccWVX+j/X4nzKgLdk/XY1KTh+XElUbh?=
 =?us-ascii?Q?rPtBg4tdElEqR0KIYw87hp+YbtklkRWWleci0QG7Sg=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_072341_631175_05493ACC 
X-CRM114-Status: GOOD (  18.29  )
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

TCP transport relies on the routing table to determine which source
address and interface to use when making a connection. Currently,
there is no way to tell from userspace where a connection was made.
This patch exposes the actual source address using a new field named
"src_addr=" in the "address" attribute.

This is needed to diagnose and identify connectivity issues. With
the source address we can infer the interface associated with each
connection.

This was tested with nvme-cli 2.0 to verify it does not have any
adverse effect. The new "src_addr=" field will simply be displayed in
the output of the "list-subsys" or "list -v" commands as shown here.

$ nvme list-subsys
nvme-subsys0 - NQN=nqn.2014-08.org.nvmexpress.discovery
\
 +- nvme0 tcp traddr=192.168.56.1,trsvcid=8009,src_addr=192.168.56.101 live

Changes to v2:
Taken Sagi's comments into account

Changes to original submission:
Reword comments per Chaitanya's suggestion

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 044da18c06f5..85b767a01402 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2532,6 +2532,25 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	return queue->nr_cqe;
 }
 
+static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
+{
+	int ret, len;
+	struct sockaddr_storage src_addr;
+	struct nvme_tcp_queue *queue = &to_tcp_ctrl(ctrl)->queues[0];
+
+	len = nvmf_get_address(ctrl, buf, size);
+
+	/* Retrieve the actual source address from the socket */
+	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
+	if (ret > 0) {
+		len--; /* strip trailing newline */
+		len += scnprintf(buf + len, size - len, "%ssrc_addr=%pISc\n",
+				(len) ? "," : "", &src_addr);
+	}
+
+	return len;
+}
+
 static const struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.commit_rqs	= nvme_tcp_commit_rqs,
@@ -2563,7 +2582,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.free_ctrl		= nvme_tcp_free_ctrl,
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
-	.get_address		= nvmf_get_address,
+	.get_address		= nvme_tcp_get_address,
 	.stop_ctrl		= nvme_tcp_stop_ctrl,
 };
 
-- 
2.37.2


