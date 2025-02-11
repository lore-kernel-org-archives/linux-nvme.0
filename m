Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E495EC0219E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 03:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UvpiRSLiO3MeSQ5CJ1Ne9ZmcA811vqn6kLoWBP4wFds=; b=otUjEpKmK06HkW9GAUzL131MaJ
	OdwUjlg26LtNWQ9wMlt1zcCZUAwH3bs5SchIAI48IEQ+Zq6aHvUOfLgWpfdBLVTgfz3RwcRItO4eV
	NzWE6drRMdHUO+az04cqNZiKm3tgM3yL7M/JbWfSLhFEz9D5bM7XVmzNgOFHGiDnpJh4sGtRymkIU
	JmvUJtgMKK7DoJ/MU/HuerfXkQFdSmWGKCa1wegQ1Dz7ptt95JO6bN4JZvjOdAfqGvu1KDbY3mFps
	v+q6os2VyODsSj2Vq0k4GdRckjzUh/vHsV38KW7TA3eAbTj1jX4ZgBehBthix4XUVtisIwppCimAf
	UGn+ZJwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thhEf-00000002QVi-3fMb;
	Tue, 11 Feb 2025 03:46:57 +0000
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thhDx-00000002QSu-1yZz
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 03:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLajs50VWxAN8AvD+fSbh/tSJ9ixWGNNYXBuBw5J7WrIlvIXXLVjT3yyNycGkYFWU9jR97Ps6EjDFjVQSL6A3JlnBRNYwY6Dz0xDeltJuFqCdIZ9w7ubl8Wg6G2dBdTvjMMW6sC6LY3QMgyEJeVk4PtJE1QGxIjng7NmwraR+gwnK5zBc2KCjRlf6ax9DcqLvK7xLDb2zeNSYz1V0i5qtOvC4VhFKkn7ErtVzWDCGmlHFQaa9yXrj6/8uSq4R0zo7/0K48BHl0We02tbqbRHPvb08tww8ydlkSmDkBnvW2H+53qEiUI9bGY6uAIK0RiG9uztM13vDRurwYAau+EMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvpiRSLiO3MeSQ5CJ1Ne9ZmcA811vqn6kLoWBP4wFds=;
 b=vFO5K5Vt9FYmhlfRAA839tBvnIycj1tDi0RZRtnC/z1gHkrRX7VlQaLtTYZuIlG6sDoBdyLHRosuCRInpCVDxMH5GwJ96UDWWHlpEDa+oSMgRf8urUXvhYvgz5iupEvPW01cZctoDZDNIel5ydupLEdcR0T6wpgaxEbQkg2Jei8ManKsCUCbEQBs0e8KTnbJnFKXlLzB0+Yj7ofMM5oZH/4sHumDDsEWKiaSFLlFiBfPfWX5GWRAGDldKQhhRZOHPaeNkQJGGujKRfcW15Jq9r/5cfKrfWKC1bBVlotsSB2GPj8DkPWToQ0FRC+DLqi33IjJZR63NR5ZN9yRJwVr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvpiRSLiO3MeSQ5CJ1Ne9ZmcA811vqn6kLoWBP4wFds=;
 b=cmWdOsMupjraU0TadXJc2yr3w9Ky842tjgpeX87ir0SY3FdlTIvx3DekMoEMfO5iZ/CCinWDtFqh3zZbEoToCNteTKtAqu1sxqb1MiPp0UxDb6ASrrLfhMXBhyVtnvZBveIiIiC4HYdf3h6yJepQDTH7+kjWBWjWQOGJK3n/nnIAOSlo+CtVmCGzWf+ljAqPwWTnIPz0b8gFwHBiP+Hh8viV/MPxkk+vh+HzHe+xngkYalVk8bJcv0BylRHJIctZdPpSjIQ1HKRftM1gRUOZfXqOXXtxx9ursIH9ZNYslEWCwwQpJWLvGu5Wd4yUcJgWsNxfeHa31ua8UixZ/bvBJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYUPR06MB6269.apcprd06.prod.outlook.com (2603:1096:400:351::13)
 by TYZPR06MB5348.apcprd06.prod.outlook.com (2603:1096:400:203::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Tue, 11 Feb
 2025 03:46:01 +0000
Received: from TYUPR06MB6269.apcprd06.prod.outlook.com
 ([fe80::a1ea:44b:a1ff:1bbe]) by TYUPR06MB6269.apcprd06.prod.outlook.com
 ([fe80::a1ea:44b:a1ff:1bbe%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 03:46:00 +0000
From: Ruozhu Li <david.li@jaguarmicro.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvmet-rdma: recheck queue state is LIVE in state lock in recv done
Date: Tue, 11 Feb 2025 11:45:43 +0800
Message-ID: <20250211034543.808-1-david.li@jaguarmicro.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To TYUPR06MB6269.apcprd06.prod.outlook.com
 (2603:1096:400:351::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR06MB6269:EE_|TYZPR06MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f086af-6cad-4595-cdae-08dd4a4e99b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EghGGoAx4L8I9mnQ7hFsmK6VpZbYdTtRGBGuwckKduZterQcRAXgxHnH9oYV?=
 =?us-ascii?Q?qp/9n2CpTex3/CLO1f5UkJwO3yT1DWitMprIv+uqOUA1bDKeGkXt5uZtXwS/?=
 =?us-ascii?Q?b2htQDXaN8Vj8iT1HSMRdl0xwwjTVi5aKRcQQIF2ABtR9EqJxUWDKd/bZtLp?=
 =?us-ascii?Q?NBaqTQ2u9z6tmpkDCuFspp1znNODWxzz3jC15cgCmlbWpV70QDK2loyy10yV?=
 =?us-ascii?Q?YdNg8tbc41Ux9ivu1tPjK96BTh7B4uCXbO70VKisijyQPReZRFhLznKH3mxw?=
 =?us-ascii?Q?XYggMU+Jyx6kokaVKLmcJpw6bh81AVekQR8aG6xUCx2vK+YpB6dCFd6+PobZ?=
 =?us-ascii?Q?8XmF3hVfHEGatSPV0Fq+B7tuEF8aG4GsurWov9QbWTN8/+Fi3awffOVqCZwP?=
 =?us-ascii?Q?TyR7ww5Ccx4jII2HwTtuqKNBhM3rPwjKY2oqynsNk22BcP7xiSx23p4XJtIj?=
 =?us-ascii?Q?MV8x2+JyjzPUaYvDMh63LJS9EV5Z2g753s0YFjRTXihLopJWmfnvEezbyvrD?=
 =?us-ascii?Q?GpmUshBMGJpwyyrkoCuVtz+khxv0UnnKifxibfaUch7tyvfZE+lvYmAKIGDq?=
 =?us-ascii?Q?sYiZVV3kk8EUsVs7mOSLbqxXDq1dKiWVRHjJt4RF5PyZNlsyXyiMcukAX3Wp?=
 =?us-ascii?Q?Y89UZkjgjF7fPi3bMSAiJXjcIvHgV0MkPUqs9XVAjxABdbumxCmTts29PrCG?=
 =?us-ascii?Q?26F2FXzAHprHJVPYVD1nMIxvjkBVhqfGeUdN0VD5RJO/w+ZXbvX918j/xbjC?=
 =?us-ascii?Q?WQ+3r3QIfdlkWAtooqrf4+414Ke0zvMRU0qJdIT1qHDJIwnQEzANiWwKxriN?=
 =?us-ascii?Q?g77oP5MJpBtSdkCalegGs2Z7l9E+hkkprfJzYgSjlW8B6cdrvTyfjRYOhoF4?=
 =?us-ascii?Q?2bZ0HyJhxy7NBS5gmwiJYxJeQzrkkeUZI1GrbW3yAp3nYbPyYgyy0ytyA5Yd?=
 =?us-ascii?Q?Eq1oCnHvclbgh2Bows4hjJvJKNbA689uFaNOqxKIqVDwyIY7iDCDa9ZDLLlT?=
 =?us-ascii?Q?ko3+6apFC7Gl5YTzZQsJSWFZ7cC8ts+NPOMMZ8KYpk1tIXEV6L64L4R2f5gW?=
 =?us-ascii?Q?OvOEI6TDxQZOxm5qyIBDoFjC8dngd5RyL8eHROVJ8+WuaCmFDSDhPIRn6ymK?=
 =?us-ascii?Q?6NsTA4esFVpLVXl+MOKOJXUe4QCBYll0pwr2UwnUaoQ5vG1Lk5qf+8hq55LT?=
 =?us-ascii?Q?8/BWNZNyVv3tgxRp6G+58wynBxRN3y9C8ItJItyWHBolWgGho3CS3r+JnTU7?=
 =?us-ascii?Q?3VniTjoMTaPGytJE8Hem4Q+/KL15jGCOzmw1SylmyInjKjCH9tcvmq5kTfAS?=
 =?us-ascii?Q?991uiP8hS2mvjVdP/jXw2520SCFHvKuTd/qJF1jIA1qMfdSpzn3N4OQ5NYD3?=
 =?us-ascii?Q?VrH8s/huE64NJwu3qNbQdxsWlDgo8o4ygk+/RdcppoX7yna5PLCXtO3PXDzp?=
 =?us-ascii?Q?Q0WMHVg3eYgHNN4Dxm6caIiAG+B5c6Y7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+UVYvPW1fn1thOO4E32HsT3XQJYIxGsVnKMvIOdY2SzugTlovNeBxO+X/Zaj?=
 =?us-ascii?Q?dUtunY3XFvgPZ24jix9bGMg6uWe7uGzChRhA1hvHGSRtbf8/PqxEXs+pNtPE?=
 =?us-ascii?Q?XSf17r+oGTOziDM1z9kt2yIVXbVxq/1+fzoVhuNDZzdf5yK0/tWQSkYhYh4g?=
 =?us-ascii?Q?D/wNLU5B4Hp81MyZeDQyKmeNpJltJLvMSkfAUuBw5p6GTR1UmllutJGpnj5U?=
 =?us-ascii?Q?DPb7RJtlvso4jbqYZrLDyloj1GAVl/stRIDDcgmbCnUq3KN4wYioC3R5saem?=
 =?us-ascii?Q?DpH0X/VPrIeFGHzX6YlscGIiDjFvvYK9S3QmQrjx8QuPC6W7S9OJIAe9vSaf?=
 =?us-ascii?Q?5Ih2ZL95SIfHhCn+eZhoZmPmz8Og6+Jcdpjyf18xUMyOeL87bmyGhVUPebNh?=
 =?us-ascii?Q?V02iVWazwYIkgYWQja+R86VpHLks3iPSTpZeN/l4txlM1ZqkeM0jM4apF1hS?=
 =?us-ascii?Q?Pzl/P2Ph0iLXwlPtcZiTmz+Q7Lz9CY7ejpjh3FS8F6KzeHON8s7475qhURdl?=
 =?us-ascii?Q?dSWlz3lj84tA5cW2fWtIO8F8vT5ASNKm9lT+/SZussaSyw5eFjLid0YPUqZv?=
 =?us-ascii?Q?i8s53UDCK4kT/+3uNcX/W8QtmAeBIaGhChIGqQCKjR1Uyo7BvteYmG3h6aF0?=
 =?us-ascii?Q?Bd8/3hvaI8Biu9Ibb6ukWoodWKbMY8gzgKyXItRsthHMlw2bHpAH2UvME2kc?=
 =?us-ascii?Q?VJJMvf1pByGxVgp/5lZjaGTx+I4BS2tQxpdJ5sLByrcWKeA7/m9F+0MIbf+E?=
 =?us-ascii?Q?AIgZbaUAjGl9Z+ouZ6wBkEK/Hkl0EcN5kVSnjfb0tqS8YdLL9W5OsykDoQCr?=
 =?us-ascii?Q?k1KG8uoXOjS9T9uhMuFFGpCP16nlAxouKv0sPvxc5zMJ3dNFp3gLrwz82PEc?=
 =?us-ascii?Q?/McOlg6NOn4xt22MucHw/wKLMSh2TiDMKZdgwBkgiXCy9y6SYS/MjA1uW3WW?=
 =?us-ascii?Q?LJ3qTNt3p0xn8fxVY8knijOApV33jBd/ZZPu64kaEY86UXIMugeBNaVgbLg9?=
 =?us-ascii?Q?uM99zCF9KOmbz3+5vqEpBjgrm+CS5Bj08Dx6Z1PVdFiQ7fsPtOa+W+57UFDC?=
 =?us-ascii?Q?Jy0kjSflE3xRt1UAbg2rvrT+LLuXwx/RrR4Mahu79h90RhHlAVA3+uAx+7us?=
 =?us-ascii?Q?SAYay8mqNmdtLGX/2P82dryGxLmfTQEGie+SWyyRqZsISgQxEvSLpO6fnbI3?=
 =?us-ascii?Q?kmdbH0RFuKE4tP7PmlqZetXR6Jy8Jjx56BSpHCQnnMrxDZ/HSt6GOUrqYuby?=
 =?us-ascii?Q?XM6yCmBRcR2wcHtpfLaIrJ2x88JWh2kyuw00YFWo+Duscofno0qAsgec5atE?=
 =?us-ascii?Q?SnLPoZRw24zu0XrfgomDeOLEP8A67QdwMZiMVdO7SimgzZw3yW0BPLmBdPbr?=
 =?us-ascii?Q?HOBsUoV187EhJS9MaZsSuhvbFsq0KItIYrhI0ZWkWPwy27dyILE94/Ag5/lu?=
 =?us-ascii?Q?aJtMEPy7/URVujOWIcMZzBlLO36UfCbdDZmeZNpnXmQ3YsYnAg4H04W8Adbq?=
 =?us-ascii?Q?XntAZPoTWoRef2g/jb1upqEfqLCbpXMLrKY6+b9YZe8F1o0vb0RKk6Y3lkF2?=
 =?us-ascii?Q?ibYMwwqN/SeN3jmWzU7OlTqxdTUrSpgSSpEMxGFRjKSrIQ8l1c9ohFo0nPb3?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f086af-6cad-4595-cdae-08dd4a4e99b1
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 03:46:00.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzekC6XYQ3ixT+UnDYFIbl8U/7tmXyQBfpXabxoz+rj9xr2/te6raP94bJ4fYoe4fkD6c0hnk+sSuM5qKLRhYdEQhA+nHmP1yBmwVQYpaHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5348
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_194614_017482_9B69FC39 
X-CRM114-Status: UNSURE (   8.81  )
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

The queue state checking in nvmet_rdma_recv_done is not in queue state
lock.Queue state can transfer to LIVE in cm establish handler between
state checking and state lock here, cause a silent drop of nvme connect
cmd.
Recheck queue state whether in LIVE state in state lock to prevent this
issue.

Signed-off-by: Ruozhu Li <david.li@jaguarmicro.com>
---
 drivers/nvme/target/rdma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1afd93026f9b..9f9e51fbfe49 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1042,12 +1042,16 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		unsigned long flags;
 
 		spin_lock_irqsave(&queue->state_lock, flags);
-		if (queue->state == NVMET_RDMA_Q_CONNECTING)
-			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
-		else
-			nvmet_rdma_put_rsp(rsp);
+		if (queue->state != NVMET_RDMA_Q_LIVE) {
+			if (queue->state == NVMET_RDMA_Q_CONNECTING)
+				list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
+			else
+				nvmet_rdma_put_rsp(rsp);
+
+			spin_unlock_irqrestore(&queue->state_lock, flags);
+			return;
+		}
 		spin_unlock_irqrestore(&queue->state_lock, flags);
-		return;
 	}
 
 	nvmet_rdma_handle_command(queue, rsp);
-- 
2.43.0


