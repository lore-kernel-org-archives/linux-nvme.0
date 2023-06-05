Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6969AC7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 06:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FuScJt+QksrSSRwkybAD/etR9sGQksbDEVluUbdJGPk=; b=WaOd+u5sSmnp5qpmtPj3Z/EH3h
	2DPs+WuoppEpN3tvfwMLlzntBSuSqehBIT/pGA3/rrh4I5FSjI+NDFRyOIG4gQ0AvpLIti/vaRhNr
	GzPBLXC5fgWXuWbpjCKJHVKR1s5GVzOakSsCwhzPNfrzYje7xlj9YqUbP1DTh9Y+L6uddulSz0wUK
	vsbROFJ53c5Yow0cm9j4MspHk9nWa0OUnXc/kKqFg8csnligEeDuEIDDJ10+Cd6i0t4fFTHJ4d1B3
	c3dnJ57U33LC2VSeTJaT/S5m33BEznCghZMffTpaYRVUDF6GDbK6ZNCphUI4BMsXgwcX6gRMUtpoA
	2oT7ezFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q642b-00ERHD-1d;
	Mon, 05 Jun 2023 06:50:09 +0000
Received: from mail-sn1nam02on20614.outbound.protection.outlook.com ([2a01:111:f400:7ea9::614] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q642Y-00ERFD-0a
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 06:50:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/sTOiz81AZfoz0CJ8muanCtlSCeYV7GZx3E0thKRyS0YL46QqLEGJpJq7MmFS4atF8NKTRSQjjWyXvsLv7UwwaKAM5iPQaa+bux1z+YLj0jlVka196rnFtnuHgvOi3KburAQPrimMeUNMRXvcMBsIGoPm548ShUsVrkRGy6V5D4ANeIDBfhJ0AJis65Eg7IL2BBDp3YqG9QV8IVPiWcaek60jZVyFnF8XUtixiwOUZJZGYxTmX+CrQXwr0MCH62wUvYnvNeXjlrzYUnvzA9m/DrtS5alCNLZdQDah8r05SYO3Fw3nteyxEj3tWdVJm/Wh2cYzPjyGvuZIfa7Dl9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuScJt+QksrSSRwkybAD/etR9sGQksbDEVluUbdJGPk=;
 b=JFo9t1UvCrC5KDP6YAhwiFHzIh+1XxZSY8nhC4teVdXegWL0D2oMhcRWqIaLHjXmzhQCLu2oAnEL80uWG8EsHR31ksaDI9hY4PN22a4oU8odJqtR18yXUesLxWo0SOfj6JR+VdieLQZk6mVAwZFZqxUohbt1aUFO7vVjlPQ5ZDiW2sdAvAsjlski0J8DKxwnczolUZbiTXeOTU6n3w0bODGJoZ1qYOXTazgiLhgNYpfrtQeGLhY47Dl+ews3v8Mv7bIyVcu4JVCaq2Aiexy4ROJOjJ6sJFxiydeRuQznQ6PPGArho0Jo6uZ92zHoW+K0iDL4nf7wovfJaITuBuHdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuScJt+QksrSSRwkybAD/etR9sGQksbDEVluUbdJGPk=;
 b=Z9eOeoaQhK9SWOYb9d0g0pxYO2KsBnUp1AwWoPvQofBM4G9ni4Mdbzac68SEcApYuk1hEU5yqhn3dT6fme7qAgUnG3KdwvAY0esJuenOshba6gAQvXRhplKdYajRYOSt/FdC/GXMIbOQZD1Q6xMH0OfpImjR1A2UqRd8yu1NUlPRs2L+j8ScmB5ewJEBPM8w6gBz5i+0N7B+aaiBtBt/Z7zSvGoYC6iL5xATG93e+K/J09MK5+Frf5fUZIclOJ82yiFkvfz8HWcf1nLEO3bOCTOqbHLAFf06igi/wNvloTAv+0uiTLZ0doVYi37kDiq//ijW5CaHJHpFq93fOqxUFQ==
Received: from SJ0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:a03:331::20)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 06:49:57 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:331:cafe::a0) by SJ0PR03CA0075.outlook.office365.com
 (2603:10b6:a03:331::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 06:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Mon, 5 Jun 2023 06:49:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 4 Jun 2023
 23:49:40 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 4 Jun 2023
 23:49:40 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <Amit.Engel@Dell.com>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme: print disposition on err req completion
Date: Sun, 4 Jun 2023 23:49:33 -0700
Message-ID: <20230605064933.46933-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ec9198-e694-47b7-820b-08db65911365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7CcUUSdpPaNkpq4zY11E0zEwgLcw6kLNdy7SONz1cU6RdK8CkBvaMr07blWWU0unE9dnGnigZocvMrfHL20d3bqC/67KLLK0QFjaknS2MbMh1Rtv+o6YPA7zuThzKXKzy5N4jrbpVhBpFNyFjHMxlpT9SzJGKhtcSpqedpDCrXXh/c40UYMA7Z3JzdzRP5JFhDbeSUOikC0HcANXcU/n4Nv5WtsxvzY/bDAUhgIdF9EIegLgSclVmd5ucFBnllMxueRyAmS6TlTOEH58vSTOFdHbOpb9wFEQvQkdPkVdGLtK4cmPPW7p2Qm38y3/0NQcO4EseCBdacsw/Ij+Jwbhb3ihr/FbM0/gc4vLz2ng4EPltgaMBsvfIZMMkCQ9WR1xqrgN0KKeN7emXsS2GYNzhS01xNMf3BF1jf6NhsmgT/+3Xj636Td92HkS1HLw6qUAJhZYThF1eM3QiiEZLbz7xdAB+ho1yFBsHaTmR5oyIpIyg9X6pRLSGiu7J1ayWLtOYrXl/BHqDux+appABeAmX6Xxs3mCj6HpT8eU6kRgBUh9ALPAbHpj8dPOw4UE9zrdiGCpJ7Th+a7zbWJlMsYZcYbpuKhmDuBCzSDi7t7U5DWt5VMcS4Arz9QFu17Qdhm0KsB5dSmluvqPFvGkk2LO9CVbwFZzvTbQum0MT/1V/AUVKhhMY5YDCyO8soNcKMhoCMKTycXnQHD6YXuMt4O/eZqKBEs8GXYxfG9Idf9NuF8cU/FK9JRrjt4gIxUkF61
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(47076005)(2616005)(26005)(1076003)(83380400001)(41300700001)(36860700001)(7696005)(6666004)(107886003)(186003)(16526019)(426003)(336012)(40460700003)(478600001)(54906003)(4326008)(6916009)(82310400005)(82740400003)(40480700001)(7636003)(356005)(70206006)(70586007)(316002)(8936002)(8676002)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:49:57.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ec9198-e694-47b7-820b-08db65911365
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_235006_226500_CA7FFAE7 
X-CRM114-Status: GOOD (  12.35  )
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

Currently we don't print disposition in the request completion path
in nvme_complete_rq() tracepoint, so when request fails it is not
straight forward to understand the diposition making it hard to debug
the problems in the field.

Update nvme_complete_rq() tracepoint to print the disposition when
request fails, since disposition value will always be 0 when request
status = 0.

Tested-by: Amit Engel <Amit.Engel@Dell.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
Test log from Amit :-

please find below an example for 'RETRY':
4677119.335542: nvme_complete_rq: nvme0: disk=nvme0n1, qid=3, cmdid=76, res=0x8, retries=0, flags=0x1, status=0x371 dispostion=RETRY

path-related errors simulation, ANA_TRANSITION error 'FAILOVER':

4684015.100835: nvme_complete_rq: nvme1: disk=nvme1n1, qid=2, cmdid=103, res=0x1, retries=0, flags=0x0, status=0x302 disposition=FAILOVER

For IO that was completed successfully 'COMPLET',
there is no 'dispostion' on the trace (as expected):
4677116.635057: nvme_complete_rq: nvme0: disk=nvme0n1, qid=3, cmdid=69, res=0x8, retries=0, flags=0x0, status=0x0

 drivers/nvme/host/core.c  | 15 +++++----------
 drivers/nvme/host/nvme.h  |  8 ++++++++
 drivers/nvme/host/trace.c | 12 ++++++++++++
 drivers/nvme/host/trace.h | 12 ++++++++----
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f586a4808e6e..832715676fd1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -337,13 +337,6 @@ static void nvme_log_error(struct request *req)
 			   nr->status & NVME_SC_DNR  ? "DNR "  : "");
 }
 
-enum nvme_disposition {
-	COMPLETE,
-	RETRY,
-	FAILOVER,
-	AUTHENTICATE,
-};
-
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 {
 	if (likely(nvme_req(req)->status == 0))
@@ -393,14 +386,16 @@ static inline void nvme_end_req(struct request *req)
 void nvme_complete_rq(struct request *req)
 {
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+	enum nvme_disposition disposition;
 
-	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
 	if (ctrl->kas)
 		ctrl->comp_seen = true;
 
-	switch (nvme_decide_disposition(req)) {
+	disposition = nvme_decide_disposition(req);
+	trace_nvme_complete_rq(req, disposition);
+	switch (disposition) {
 	case COMPLETE:
 		nvme_end_req(req);
 		return;
@@ -424,7 +419,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 void nvme_complete_batch_req(struct request *req)
 {
-	trace_nvme_complete_rq(req);
+	trace_nvme_complete_rq(req, COMPLETE);
 	nvme_cleanup_cmd(req);
 	nvme_end_req_zoned(req);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f0a84e390a55..56e16bdd59ff 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1119,4 +1119,12 @@ static inline const unsigned char *nvme_opcode_str(int qid, u8 opcode, u8 fctype
 	return qid ? nvme_get_opcode_str(opcode) :
 		nvme_get_admin_opcode_str(opcode);
 }
+
+enum nvme_disposition {
+	COMPLETE,
+	RETRY,
+	FAILOVER,
+	AUTHENTICATE,
+};
+
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 1c36fcedea20..8793fd6b8d0d 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -343,6 +343,18 @@ const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p,
 	}
 }
 
+const char *nvme_get_disposition(enum nvme_disposition disp)
+{
+	static const char *disp_str[] = {
+		[COMPLETE]	= "",
+		[RETRY]		= " dispostion=RETRY",
+		[FAILOVER]	= " disposition=FAILOVER",
+		[AUTHENTICATE]	= " disposition=AUTHENTICATE",
+	};
+
+	return disp > AUTHENTICATE ? "disposition=unknown" : disp_str[disp];
+}
+
 const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 4fb5922ffdac..f8b33f59ff76 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -22,6 +22,7 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 		u8 *cdw10);
 const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p, u8 fctype,
 		u8 *spc);
+const char *nvme_get_disposition(enum nvme_disposition disp);
 
 #define parse_nvme_cmd(qid, opcode, fctype, cdw10)			\
 	((opcode) == nvme_fabrics_command ?				\
@@ -83,8 +84,8 @@ TRACE_EVENT(nvme_setup_cmd,
 );
 
 TRACE_EVENT(nvme_complete_rq,
-	    TP_PROTO(struct request *req),
-	    TP_ARGS(req),
+	    TP_PROTO(struct request *req, u8 disposition),
+	    TP_ARGS(req, disposition),
 	    TP_STRUCT__entry(
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, ctrl_id)
@@ -93,6 +94,7 @@ TRACE_EVENT(nvme_complete_rq,
 		__field(u64, result)
 		__field(u8, retries)
 		__field(u8, flags)
+		__field(u8, disposition)
 		__field(u16, status)
 	    ),
 	    TP_fast_assign(
@@ -102,13 +104,15 @@ TRACE_EVENT(nvme_complete_rq,
 		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		__entry->retries = nvme_req(req)->retries;
 		__entry->flags = nvme_req(req)->flags;
+		__entry->disposition = disposition;
 		__entry->status = nvme_req(req)->status;
 		__assign_disk_name(__entry->disk, req->q->disk);
 	    ),
-	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%#llx, retries=%u, flags=0x%x, status=%#x",
+	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%#llx, retries=%u, flags=0x%x, status=%#x%s",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
 		      __entry->qid, __entry->cid, __entry->result,
-		      __entry->retries, __entry->flags, __entry->status)
+		      __entry->retries, __entry->flags, __entry->status,
+		      nvme_get_disposition(__entry->disposition))
 
 );
 
-- 
2.40.0


