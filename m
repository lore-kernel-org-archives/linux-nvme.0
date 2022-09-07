Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ED0C54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t5M5fi0lPbkXfJa5zbvc/vrjUTCY9y+OkQhUP3MOH5U=; b=NY9mqvFNAacZikPQvBfaiOeGu4
	taNYlxVKwkLBSGWonR0OgPRa8Cx2mzfIV+vk3NSnP4DIWSB25P4Rz1Sl0THFSsJUPLrbldpYT11bZ
	Fd4cZtwIESUI0D0ZCfJgaYtHE/0jO83vcYP8IcPJSsptdCG9lk/FUKt1Nk5sSskR1it6/TynejdWR
	pXSrJ2aNKZJ2qLDc9tpfsoqNr8462jvtYNgzsKHWjwoLmDZYr4q/kjCCUuEdIFNmvI/NvLUPEzlYi
	k8157VQ2MoN9tGGdhmkCzYejr45AlFv/eQFSZub2jj2BpDJxretvd97NcdIXjWwivmkDZKAikWfEa
	2UYLIm0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVuA2-0065x1-Pt; Wed, 07 Sep 2022 12:28:06 +0000
Received: from mail-dm3nam02olkn2010.outbound.protection.outlook.com ([40.92.43.10] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVu9u-0065rG-Ta
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 12:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJIBGVSScam6Yni90JelPvROsJYNUJmdPHpFEAFpEET1khXYULFFA7nEB8LRYOgcxXzaQgeaRA89SMCvVDjHi8ZI57f4y1pmyfJelGRU+LlpGOoetxvVoAJ5uU7FsfBrWWS3nRcBrB8gzqFc20xQ1g1ldFVEQ8TqCV9AbcO5R7f2GDBKQ1JIc/OioUR9WRAjokz59SyZfCWLNMtAShDWDj3OGjsdAxXIIjUR10Ste6PWLYgBQYXTf4kdBH7zR9s3y0cegl7V4WnoXQ9Qx3SQYrIoxLE5Ath3QFEw3gC3wnnz8+awd3ZjO6FH+y9FcclNRCC99uh0sAH+RwSyp8yKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5M5fi0lPbkXfJa5zbvc/vrjUTCY9y+OkQhUP3MOH5U=;
 b=n/jz+50QEOsJ7AHJZTl+UsB+QmffQRc61Vmfn1blsWf/A9j+gIFWoM7/gqTrbyd4/drnTL8RKGbjeCfS6fDMD3atukAJisLXNIGCpn+d1lLJpe03MEb6k07UmxyxhWVP2njy/OHLD2ZPR1PiufsQPKPhc+/wj05Q8iAeLg2DdHTS5sxfKwb5cCMpORHtLzOAgDxcr9Ce/wtXnf0Rw4od3WJgsV0GjbCGxfkdxQBAI2FuV1oAh0sMgmItVQMeFMv9E7DIaB0iKFrAsKojmCAhmML12CGJLb5/qEeFeBVxu5iRKLK/21IptbgWLHQtnfYCCRt3Os+nQuuVcKPPeaZKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5M5fi0lPbkXfJa5zbvc/vrjUTCY9y+OkQhUP3MOH5U=;
 b=tNIhMEx3hJH2ozh/RAW4V36RGc1g2AGCmCye/77+Nec/LxTJIfpqZ7FNVDOzG5cRP0w/kLSO594f47FQsySPVfIUl8FFrR1w/iMQJUokKAmqQWUuX4KK4toWWSmN4lZyeq0H1PJBUsPhC9anFqhzssI6nFCe33ORrI8cxYtf2APWCFYFAiU2Arrf4jduDnyXoyXbaNSLrFI6YWkWWtmYR2EKyA0xCKElPiDrkiwed2JYFA/WuCVUE0MVbKRQ48NrqF31yqibH6smCovCdjdfpFJ4Zf/zk+WZrHu87yvWX0WhsjCEoeb+mqmH0zI1lm9TTkEz4nKjeSTmYHL9nInMWQ==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by PH0PR13MB4794.namprd13.prod.outlook.com (2603:10b6:510:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 12:27:53 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::30bd:d7d0:61cc:50b0]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::30bd:d7d0:61cc:50b0%5]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 12:27:53 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hare@suse.de,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH v4] nvme-tcp: Print actual source IP address through sysfs "address" attr
Date: Wed,  7 Sep 2022 08:27:37 -0400
Message-ID:  <BL0PR13MB4291260D145FAAC1B2B5C4859C419@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7DijWUgzkCOyjr87PJjCzP+xXZPUIDvh]
X-ClientProxiedBy: BL1PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:208:2be::22) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID:  <20220907122737.11863-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4291:EE_|PH0PR13MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 51188bf3-69ab-4485-ed08-08da90cc625c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	vOTOSELs0TDzGo4+VE3fkeXlafWbdvg2nKVC5L7ns6WEPPJbsGnUOMd2gFJ9iWgY836UBDT3gG6dJskdb+J+iROAgkohfSWtALCiLyYEOoagLX0ZJ3UKZ6cY4wJMYZRDQypqrxmoS+uFzixNxKpDluJ61fbUbZHudSzLT6OCpazUPGcE9ChmQ98J9nJgQkoqwgyBlaCi0GQmAt3f0CtADb9jBEcQDBE0gzxmO2rc6A4WQBJ/23TS0G/37dd6BCh90jO3QYvk1eARbaXUMfiAjy8fTrBuQgbSCxJmZaQhImexONvkKLsVjEG6R1aDQoqqWqH48ZvY+LTzMMoIYn9DNkc1DmXrRCYq9PRrewWcHA96MRygYgMqBkx3BZCGe7oTdGt183vXaxvbQHYdqONQOVz5J4bX444CPjneA9y/7VtaSbRyzXkgC1dAawjmToFCEPJFXrJNcf8u5dpqUatPKtKafhrRyoECFxl8poGBOLEkzrAzdcvN4gOFjxxuWP9fJ4Pkd90NpsOJvyKYbNnzovxhhcbuto06O5DpL7Hu4O65zRB7oUCrEZfG/9hmKGKGK65gvjx8IipZkAh5w8ciulkltI88MjR0JLIdwwvcro0zm2uZ1gn57nFPIn4/j/m2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?E6TbgXUgm+rwQvgtCZZtl+eyrZOmYMqazUgA/Bz5GaeOwTCjHEKzSW6E4wTF?=
 =?us-ascii?Q?iRyxdeotDDwf4au+wJMEZnsle+bi9Cd5/2P+OblRhqZwBtW1pk9OGRPL/6cj?=
 =?us-ascii?Q?DcO0ikAjtrq4ZOdXgZgRp/dFbe1QogqjIV4bjgm0c4zrRQ+SV0Fe1spQlUoB?=
 =?us-ascii?Q?WX/ZQyAO5ujzSMrFxThGB2jxeli82rL4rkf0A1gVOvtfo2rMc4qAvJf+e4Uz?=
 =?us-ascii?Q?3sGQL8+7mHSQCWGqKBnRtrAoIl20VV6IS9VzpPOpucgI5eso6SVxR/iq3y9E?=
 =?us-ascii?Q?wDrvIosK8uUaBoHMdUR8tQf7R09TC3/3br74bHxKVhq/jWeN+fMZL/i5Bb3k?=
 =?us-ascii?Q?tlZhSL6J8cn3pwJ9FlokgNeGbtDmpyr02bkZdeNE0MsDgBIPMITlGWReCba7?=
 =?us-ascii?Q?90KPHGPokst7ygiWbvTVorMo6s3nRZZuVLeypVLOgf6Y+6RcF9rgrEhL56hf?=
 =?us-ascii?Q?aRmJGLoYsI7XQY0cfGvEMN8D/As48mpjs94eQo9eS9GagbNrSoTBQnlN+n4y?=
 =?us-ascii?Q?6+m9w1XDEgZHBgDeQReOtZnbOh2ZnzXxoKRHKGp0xKPHplymRgGXwIOw0ud+?=
 =?us-ascii?Q?GK6qwWnH0kvnYn1GKEIXcn0CvQmyEZdm3UdYoJsUIvU1eyreTSPuiiRrged9?=
 =?us-ascii?Q?LfJzKK17Ecaa9qZMQaGB45rReMMAb47X6uRZpK/hfJS4RENLcWg0ecoLlwSe?=
 =?us-ascii?Q?4CEWH8xQfao53lNITvCTRQ9RXn4j8XFQSbMhl4NPyBQhau7KMkVuBE5RDA2g?=
 =?us-ascii?Q?sKvTnwSg8gS3d6SgzDOGn70q8jaf4uFS6Vy6IprYq9ZlE7NS+Gx/ajSRX2ap?=
 =?us-ascii?Q?8QzZ7FoJRz/XXdGIhl07ZTvh1MX0qh/BuQhucuUX+95s2M+s8+K8Ahuk7U2b?=
 =?us-ascii?Q?NnoQlR6dkTGT1b/hC7jQPtt5NnsktRTKyCdGm0O9e7sXPY6LVf5eN564S8/Q?=
 =?us-ascii?Q?8pcaNIRSFQO+UOtP805I8wF7Eeq/uIHFk6I+qoYmBAtdH5CD4imGNxEXcEYC?=
 =?us-ascii?Q?AWrliDPjA1k4MoVt4O4veUfMS45wHFIVvZbQDqRWZI0iAaVUi/0OtGTBPuHn?=
 =?us-ascii?Q?g+lzDAqbKiy+XGXe3uel8L8DdeLp/T6pQuL+IPcn3aBrHaGaT8x9MGkxwoxD?=
 =?us-ascii?Q?WqPv8caDBjpJareW3iu+xrH99Q1PNUvwBfljt3y27khEE56Xr0NkIaQ94rF1?=
 =?us-ascii?Q?Pxfpe9VCqciGhmD5PyRBRuov69pZXDc3hLTqlzukAlVnJnLsiDJbx/0/ffYr?=
 =?us-ascii?Q?4ZRdGn/U9BHiE5OtOqR2rbSlv7uzBDZ7iuRide22zw=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4794
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_052759_201782_C683360E 
X-CRM114-Status: GOOD (  18.34  )
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
address and interface to use when making a connection. Currently, there
is no way to tell from userspace where a connection was made. This
patch exposes the actual source address using a new field named
"src_addr=" in the "address" attribute.

This is needed to diagnose and identify connectivity issues. With the
source address we can infer the interface associated with each
connection.

This was tested with nvme-cli 2.0 to verify it does not have any
adverse effect. The new "src_addr=" field will simply be displayed in
the output of the "list-subsys" or "list -v" commands as shown here.

$ nvme list-subsys
nvme-subsys0 - NQN=nqn.2014-08.org.nvmexpress.discovery
\
 +- nvme0 tcp traddr=192.168.56.1,trsvcid=8009,src_addr=192.168.56.101 live

Changes to v3:
Per Chaitanya review comments: Change the order of the variables
declaration. And although len can never be 0, for completeness add a
check (lev > 0) before decrementing its value.

Changes to v2:
Taken Sagi's comments into account

Changes to original submission:
Reword comments per Chaitanya's suggestion

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 044da18c06f5..e1e77de17f66 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2532,6 +2532,25 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	return queue->nr_cqe;
 }
 
+static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
+{
+	struct nvme_tcp_queue *queue = &to_tcp_ctrl(ctrl)->queues[0];
+	struct sockaddr_storage src_addr;
+	int ret, len;
+
+	len = nvmf_get_address(ctrl, buf, size);
+
+	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
+	if (ret > 0) {
+		if (len > 0)
+			len--; /* strip trailing newline */
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


