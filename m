Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355CEC433E7
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55E02080C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U138fD+H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bWYhqJp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55E02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LkXK5HDgx6zZyF4EOCbUKhD/dClO1gK4keH0viW1B5Y=; b=U138fD+HQGRTVAioxuEtaOarZM
	LwyuXidzM3B9uzgp4PDzcONMowdpK4zqNcsX0YDssW5YDIO+1rsB1wOMixeJNtzpEwlktbTu6BySR
	Ds1egO1nmwzq5fHAyljVbzWTiguR1XadBkGu3LojlSgAECloTaNrwFyqPWPQj8cIqGIpIZ9fazQI6
	8ZAkGZOjIkh5e7f+DF1fm3gE05aq3Tq7beBoU0scoT2jAEOdJfZadxOhaEVSiquH16bXv4UD4wAdy
	rtWVUhkFVaAYFMVkhc/np2xj5jDRwoBS0i3iNIxoDpvPjTmBR9txgjuWvYBhlwQd4Khp4Kto1vTFk
	q9HKKIrw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBSlc-0003s3-6z; Fri, 28 Aug 2020 01:01:20 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBSlW-0003qD-V9
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 01:01:16 +0000
IronPort-SDR: xd2YqQh1V/WIYp4wSJCCjbLOJz4tG+HSedkHKhVhU4oPt+7CRBcKo7HRLuaSNGAFmluNg8PkSU
 bl8yfR9z7yaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="218140383"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="218140383"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 18:01:09 -0700
IronPort-SDR: Xf3o50e3YGegUu5mMkLNXtxxo/ZW7yFOvC+jfTlNjvDwQwah2maKeQq2kZwLPGS6Hnaet0Dhae
 hHxaHQ54H7+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="313431171"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga002.jf.intel.com with ESMTP; 27 Aug 2020 18:01:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 18:01:02 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 18:01:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 18:01:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 27 Aug 2020 18:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt4xhw/WdMlOUaYZ+/BaO3M1gf+zj5NXv/D4XyQxEsTkUMf0bcHeVVpmWOlVhVMKujkFbuSABe+p1XGVsBK15+WH3uCfVVHARoHzTrkcUk7xCiB+C2A51j+3KuzNMZsSmurXjE17tauHteuxbRTWmge8GnIapsn7OwIaSCmjsfx822ooHPPEyowj0ln5UCsrQL8yj0PWywfH8CWAXQ2ZDYY4lAiuFJY/SC1lqWvcZTNmhjiBTdkcYNyplfVFBlWc9NBBJzYWjkszN7I9fTnrwUOdX0sgUwHYL+99u2PoMjAfFnFXInedvI0O4OFqdVc6ZFFMqSf4kHP/sZ0Oan5EtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xON0TIHZey0bBpT+Tf0XrLRyRUJ1xDqMz/q04nBJL/U=;
 b=EULC2hDfCSGnw1wM52JUuCttmpNb0xLWrWnHjo2MKcz2FMqL2tVJTDg7rgdqQ+dwLg9tsOUslzhWspUEV6TAQWdDId1MJWuRM/AAAiVer6a8PWInGz9MJIN0ly5XuL9vtcAuJCVkV24dxC7G0LYoDUNK1EY4sM6gxK+WqQzpenzYzPu01nVkFWOELJpoTWjN1ysz8u2BNANfuQyBA7n9MHzUQLuINs/0QWgpRUfpGps3LwnrD88kfMa2JC0VHj2cwoHNGmZSrvrtdvZJjPfqIhyNf75WPiWRT2Yq7CkwdJmdj1Fftcx3NxWR8c0jPEhwfmnGTwbUdkArYvpX2a0nog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xON0TIHZey0bBpT+Tf0XrLRyRUJ1xDqMz/q04nBJL/U=;
 b=bWYhqJp7qKQzI9GmGbsxV3QgmEyOcSxIzaODjapPD6brJqlAT/6dVp5UnzgCE8Ml0TcSCARKGc2DNrc+zbVCF08NGlOldNNoIP/bhO0MgF1et8/P2N4Ba17nkKYY3LbH4atxZI/wBwQ2ERx59AV+crVbBrkYjG1IhbPz1s+zqpA=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB2775.namprd11.prod.outlook.com (2603:10b6:a02:bd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 01:01:00 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8%3]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 01:01:00 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 4/5] nvmet_tcp: activate new poll group
Thread-Topic: [PATCH 4/5] nvmet_tcp: activate new poll group
Thread-Index: AdZ81Fo6SrUTKgUYQpaEQWpZBPJkyg==
Date: Fri, 28 Aug 2020 01:01:00 +0000
Message-ID: <BYAPR11MB28692AA93B874FE991ECC2C6E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [71.238.29.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 230be4bc-fabb-4dc6-1dea-08d84aedd488
x-ms-traffictypediagnostic: BYAPR11MB2775:
x-microsoft-antispam-prvs: <BYAPR11MB27754C55CBF88DB702876EC3E5520@BYAPR11MB2775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: juQzmpNRkpEtNOqoNOcyv1NlLiawQeF6vPH2pKGhi1K0hxDZkufKHhYfbbaQV5tYkaNJkjCUmETSBBhA5W2hTsfcOZgDSImyFhgMM4jeVN9Py5gM7tlDB1S9KQYDPQqd6nxc7VZkzDRSPutMUkyragXuCbE44n1zUM04yl0HXhemh+6XOki6KM6O4kn2fT11y271Tow4w+XDRCobl2r9oEUAbSdIjkQBX34RY0xJj3akDDcgCYmQokT0daXIahTV8y8q9DHtPivB3jVOWGMKf+ymriRezs+4bTY8z5UygJUKLYjcIY/wM4n227pNy5s1sgdmSeOzCm7a4kKyNFAU8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(2906002)(7696005)(316002)(86362001)(8936002)(52536014)(5660300002)(6916009)(8676002)(33656002)(26005)(186003)(4326008)(55016002)(66556008)(64756008)(66446008)(76116006)(66946007)(66476007)(6506007)(478600001)(71200400001)(9686003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vvc0aoIjSxVekxtdfg25z4xAx2v8xonlpi50E/mOMZpLsBN+i5flfJY35N+1Si+1U4AILAeYAG5aFpXRwSNgaL87Ke9X5CuAJix5sLHGT4ZVnOt8Usx67WZXMdyLOVXSoISBYP5QjUSiMkeOUmUyMI3QtPoU8rXsshvgc+QRty9/mYGFLGNTHBysHEe27UvYTUN/hIKqo9I2b9NyWZzvTcRuYbfbLUHDs48BYowwb7PywIHe5/CiNmKis3QQEExAhVCg3TSu/U18/WT3lXT8BC8qd0EAwnF6zeq2sspOULMfxyxh1qcRLmC9HjFJNWD0vpu44PR+frgEaVHr9G2Zvg8LqYGc+U5JDjPrWfAYfyXz4aLPsyfachp4LgSzxf/uPDy9ObTnm7lJqyhTFh1WYhii/8gEFv+MfMgS3fVQi7e7TyNxYH9bLZUX6f4cnLdglw7iLEVa/Hy1Txts9fJJTFZtL+OdRBuBak1ytHZ6Jixj7hvjw2THa5I64FqCK5ScExqYcNc6qwLMlVzVjwYNtC3tJyJQfitCL0Cp8HS6RrSOnwwAJmtRycghhJqblfvX2Gui0tnHAc08c0Kw29UoHeE98y4+RSEmlzFgg8F99kExcly/NPKK34sByD7Qrz6OYiUU1F0ZQqenNTddnhIKjg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230be4bc-fabb-4dc6-1dea-08d84aedd488
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:01:00.5610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MEUXwwwT1dAx+VaQyJEOO4GJqFfeKndKtmJ43nvu957k+N8V0KwATn4WuIs/qQQR25rkpaOpMOLzhIklOTZt89pFja8K+g6zoy4iHt9eqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2775
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_210115_345804_3C192D04 
X-CRM114-Status: GOOD (  22.61  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_tcp: activate new poll group

Shift worker focus within nvmet_tcp_io_work() from an
individual queue to the poll group.  The function will
process the group's active work_list for a bounded
time period. At the end of this polling time period.

Early exit from the polling period is tracked across
multiple iterations of the worker.  The worker will not
re-queue itself if a complete polling period has been
performed with no recorded activity.

A module parameter provides a means to set alternative
poll group process time periods.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   94 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 84dd5b300a1d..3955dbe38f0f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -29,9 +29,17 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
 
+/*
+ * Define an alternate time period (in msecs) that io_work() shall use
+ * over the default value.  Changing the value may benefit high group
+ * queue count scenarios.
+ */
+static int io_work_poll_budget;
+module_param(io_work_poll_budget, int, 0644);
+MODULE_PARM_DESC(io_work_poll_budget, "nvmet tcp io_work poll time budget");
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
-#define NVMET_TCP_IO_WORK_BUDGET	64
 
 enum nvmet_tcp_send_state {
 	NVMET_TCP_SEND_DATA_PDU,
@@ -93,7 +101,6 @@ enum nvmet_tcp_queue_state {
 struct nvmet_tcp_queue {
 	struct socket		*sock;
 	struct nvmet_tcp_port	*port;
-	struct work_struct	io_work;
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
 
@@ -128,7 +135,10 @@ struct nvmet_tcp_queue {
 
 	int			idx;
 	struct list_head	queue_list;
+
 	struct nvmet_tcp_queue_group *group;
+	struct list_head	glist_entry;
+	struct mutex		activate_mutex;
 
 	struct nvmet_tcp_cmd	connect;
 
@@ -157,6 +167,7 @@ struct nvmet_tcp_queue_group {
 	struct nvmet_tcp_group_napi napi[NVMET_TCP_GROUP_NAPI_LIMIT];
 	struct work_struct	io_work;
 	int			cpu;
+	unsigned long		deadline;
 	struct list_head	work_list;
 	struct list_head	release_list;
 };
@@ -202,6 +213,16 @@ static inline bool nvmet_tcp_has_inline_data(struct nvmet_tcp_cmd *cmd)
 		!cmd->rbytes_done;
 }
 
+static inline void nvmet_tcp_queue_work(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_queue_group *group;
+
+	group = queue->group;
+	if (likely(group)) {
+		queue_work_on(group->cpu, nvmet_tcp_wq, &group->io_work);
+	}
+}
+
 static inline struct nvmet_tcp_cmd *
 nvmet_tcp_get_cmd(struct nvmet_tcp_queue *queue)
 {
@@ -521,7 +542,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_queue	*queue = cmd->queue;
 
 	llist_add(&cmd->lentry, &queue->resp_list);
-	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
+	nvmet_tcp_queue_work(queue);
 }
 
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
@@ -1209,33 +1230,50 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_io_work(struct work_struct *w)
 {
-	struct nvmet_tcp_queue *queue =
-		container_of(w, struct nvmet_tcp_queue, io_work);
-	bool pending;
-	int ret, ops = 0;
+	struct nvmet_tcp_queue_group *group =
+		container_of(w, struct nvmet_tcp_queue_group, io_work);
+	struct nvmet_tcp_queue *queue, *next;
+	bool pending = false;
+	unsigned long deadline, bp_usec = 10000;
+	int ret, ops, grp_ops = 0;
 
-	do {
-		pending = false;
+	if (io_work_poll_budget > 0)
+		bp_usec = io_work_poll_budget;
+	deadline = jiffies + usecs_to_jiffies(bp_usec);
 
-		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
-		if (ret > 0)
-			pending = true;
-		else if (ret < 0)
-			return;
+	do {
+		ops = 0;
+		list_for_each_entry_safe(queue, next, &group->work_list, glist_entry) {
+			ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
+			if (ret < 0)
+				return;
+
+			ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
+			if (ret < 0)
+				return;
+		}
+		grp_ops += ops;
+		if (!ops)
+			break;
+	} while (!time_after(jiffies, deadline));
 
-		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
-		if (ret > 0)
+	if (grp_ops > 0) {
+		pending = true;
+		group->deadline = 0;
+	} else {
+		if (!group->deadline)
+			group->deadline = deadline;
+		if (!time_after(jiffies, group->deadline))
 			pending = true;
-		else if (ret < 0)
-			return;
+	}
 
-	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
+	cond_resched();
 
 	/*
-	 * We exahusted our budget, requeue our selves
+	 * We exhausted our budget, re-queue ourselves if pending activity
 	 */
 	if (pending)
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		queue_work_on(group->cpu, nvmet_tcp_wq, &group->io_work);
 }
 
 static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
@@ -1376,11 +1414,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
 	nvmet_tcp_restore_socket_callbacks(queue);
-	flush_work(&queue->io_work);
 
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
-	cancel_work_sync(&queue->io_work);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
@@ -1397,7 +1433,7 @@ static void nvmet_tcp_data_ready(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue))
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		nvmet_tcp_queue_work(queue);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -1417,7 +1453,7 @@ static void nvmet_tcp_write_space(struct sock *sk)
 
 	if (sk_stream_is_writeable(sk)) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		nvmet_tcp_queue_work(queue);
 	}
 out:
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -1569,7 +1605,6 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		return -ENOMEM;
 
 	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
-	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
 	queue->sock = newsock;
 	queue->port = port;
 	queue->nr_cmds = 0;
@@ -1599,6 +1634,8 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
+	mutex_init(&queue->activate_mutex);
+	INIT_LIST_HEAD(&queue->glist_entry);
 	if (!nvmet_tcp_add_to_group(queue))
 		goto out_destroy_sq;
 
@@ -1606,7 +1643,10 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_remove_from_group;
 
-	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+	if (!mutex_trylock(&queue->activate_mutex))
+		goto out_remove_from_group;
+	list_add_tail(&queue->glist_entry, &queue->group->work_list);
+	nvmet_tcp_queue_work(queue);
 
 	return 0;
 out_remove_from_group:

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
