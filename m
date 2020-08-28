Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B223CC28B49
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714B0206EB
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yN0NYUGC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="qg7nfyIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714B0206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IQsEWupVRo91IJyjKmWTVl7cFO8RQ/Pv7UQP73h8gbw=; b=yN0NYUGCYbh06WFYDU6j+KGEmB
	ZtmvrbRhyrXlgTq/7rs/n8SEdgJjWEFm6nMLbAfC8SOuPSZn8hrBabfoDb66kR1w8dnMuHhdRsgAh
	XpbPmSh7WNVj4th5sbPpLlzdrHpp/7c/DtNyK2hwIomFLcIZqDV7yG/hn1psp1rQQggXekPKXgQ+w
	I9MkrFlL5M/eCsQmJV5gOW6DWQGtmJ9JibHpH9zfnh/bKmtRuL7hMfAOpdSC8ToEbCucVVmLwQKDI
	dGPEFG4hCcLj7ofvMcUXaoBXd4tCJu0pttIS9sw400f1ZE/XmadQDeQuj464I9HjJHp/47gob1BXp
	QmSMzyOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBSld-0003sG-Cw; Fri, 28 Aug 2020 01:01:21 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBSlZ-0003qB-Ec
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 01:01:18 +0000
IronPort-SDR: ZVG5iMA6OXZ4wtkhE0wq9b2rJjhBmM7uV31JlXkUtCPD9TNjYJrE4Dy5UQiVVI5RUlMX9QomnJ
 XmNEQtvzwjqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="154137624"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="154137624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 18:01:07 -0700
IronPort-SDR: W4iifC/kEma61WzSAw2XrTsL8Ac/MKcip/ZWBl6/nL5KdPrP5yxGdJFxw8Mpld6bLS3MYxKpyU
 4pG1avYGn+yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="444653413"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga004.jf.intel.com with ESMTP; 27 Aug 2020 18:01:07 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 18:00:55 -0700
Received: from fmsmsx106.amr.corp.intel.com (10.18.124.204) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 18:00:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 18:00:55 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 27 Aug 2020 18:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js29lELLbqEjWrsV7WqakLHdtnzSf8SuYXk0pBFxlG2raLHVNuSVGD+tOIV24L0gWfzhZUnhN4SoEqu12zKFTtTvbSowZCCbKN6hHurFWAbFdOM4yczwVffDhFxuIu0rP0IYzp1RC98VvnKLeForsVQ44udLRGHIX1bfTbLAaEPEGeQKri+csG7tX6/M20DimlUkqREoCYtdsP0LhZNflKfGBsxgL0IfObDjwuoIF9Rj94bjphGx7M4BVBLdewH/CMfyYcj453JiOCDzP17Y1B6z9bm8mQI7c60klB5naZusTv3D11pLTxGD0NSFPwjWcMLjvTw86lPQc7M+6IxTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPBtMaIxFF/ru6tEr4/Y0IDPc8ucPmP2tdKFUQadMAY=;
 b=GhOHZ8dQko4Hw83Znh4Yfj6CqOy7EyzfzwmmTnl6GD7RgNZ4O372rk/TeIRhjPXS2aGmD5QdMoTjQpqGmlDyJzLh0ZY2OJ1/DxFtRhAzSNkBXbRzEr96bKh0T1ywEqG2jph0v28utCitx9cIu3FSWS5r6BOT4NnF4ncdwDT02NA0b9nNcMseuthkCFhQKKlxkbxRXMzgduJ29hVEOhrTrAv5cf7VjFAB4vl3Xvzt5wuZbqPyyU88wtrLiN5niKtzyYx7qF3goAr7fSHB0aXQHvzVS/fDO6hUhli63W3lqG6A86Yn7R9g5Gb9IJWxmmhC6/mVBv7+R7clkrMmqyXRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPBtMaIxFF/ru6tEr4/Y0IDPc8ucPmP2tdKFUQadMAY=;
 b=qg7nfyIQRK6WetxDhQGBiqHsgYZCCBkmncX8g2Cj77DYoT1jaRPuJkJnH7t55D1Sk+uqHmA2uYq91WRYC2dHkhWh/bJ03XYTZnHyhSZ32DYnDerHUYMdF0oR3aCngTml+IUzKK4bAkl7/7r+GX2WH8lDywWeYT1kBJuI61Nhgrw=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB2775.namprd11.prod.outlook.com (2603:10b6:a02:bd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 01:00:53 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8%3]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 01:00:53 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 1/5] nvmet-tcp: have queue io_work context run on sock
 incoming cpu
Thread-Topic: [PATCH 1/5] nvmet-tcp: have queue io_work context run on sock
 incoming cpu
Thread-Index: AdZ80aP0uFfLn9VvTWu1xc/l8TvFwQ==
Date: Fri, 28 Aug 2020 01:00:53 +0000
Message-ID: <BYAPR11MB28697B878F8E60343BB9EE91E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 15af129d-cc83-40ce-bd1c-08d84aedd082
x-ms-traffictypediagnostic: BYAPR11MB2775:
x-microsoft-antispam-prvs: <BYAPR11MB277540D436BD9A7950FDD059E5520@BYAPR11MB2775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H4cUO0oxRaOF2O6rUvhnq5x+X7RhHe0H/5j3nrTW0j6QpIVz0CpBb2hMzeg4ftxrqkT2f1NWcRC7j683Z8oG+9MjBzSyX5gSc68sEPanzF2L1+1QvrZj4qjxIA+g0mWgGXpzEBdpvHrpgSPZyxvSjntu9gM5+PzveU9WIFrUlqzCRe22H311AreuDMDcPodFoYjJCqQMZPUqzhfggzXyviC40Y1ABNdoMmtmAuv2VBiUGI9CtbhjBYsXJzBXP0o0Vsg+LE9/qDQw3G1OJaKKVubRKbiwIBWS72FaUyikd20BvIHkhO1OGHSe11uBS0tm8mpm9bwjIG4RIB9hL8ZeQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(2906002)(7696005)(316002)(86362001)(8936002)(52536014)(5660300002)(6916009)(8676002)(33656002)(26005)(186003)(4326008)(55016002)(66556008)(64756008)(66446008)(76116006)(66946007)(66476007)(6506007)(478600001)(71200400001)(9686003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: G3fuc/zp1hSDJQXri1xTi7hC3XQV6Eb0peDpndEVcP5NsNzk2epLnuz9gEgHQvjwzaGqbcaoHLH+g3XiUW0SNOLg3ECCqUxQtAinKI82nYd2BcNpq3lXZvzBMq3FxTzv3qCNovFqrAXxRxEgog7Ua83irYruAFIxiCn+3JhRfE+FW+WZ4IXW7PL0TEIWuLUF7PgjVL9PO4tiL4kKXB7zSogv1SyAvbwloBzWGVS+JPpWIFctKWdxqIHJHZwMcNS2/LOT1R/8FP8Oe6Myx9ahc4+R8ceBj6KL0tlgsWDo6XcQg8J+R2FpTUXPnjz1T18YW35ZjS4RhiOPlhn6eYu3TZ+gAR9EhaZOI677UPnIpjYXyD47SexjhWsNc1YaDUvSexjUO3ipcsI7giHZGbVmp5+70e8qd3JWoTo4PmyPBZ9lFGCKPGlsvrejBLMNRNt1kh3phgSUTtJRYhgRRLu5jbSPVnuybUXZAjsjdixMG/iDZx1atflZ2XlRoo4srD4js3JAIv7urbS/fB+JTDg77+/xSURb71j0DxFE+ba4CXNNvbHUdRxYTUIC6DGbV1czfnmWNhg2o9u0xNRfDxvjvgBvoMkTPohwBJQZzErJrGRRm8AJ/ngMTy3h9ArHu+aSviMTbDEwaiQFVPT0dWx2Jg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15af129d-cc83-40ce-bd1c-08d84aedd082
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:00:53.7359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3Ahd96MUKVMqnSIxwBh4PnYSDSdVlUFbJno3J6fuaGzuQA1rdqMurFPQNO3PWVwKq9zo6MlBz8uGGlD5B2lH0ZNscNmg/YzAWO8gtyYrJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2775
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_210117_659036_F36F1A67 
X-CRM114-Status: GOOD (  15.84  )
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

nvmet-tcp: have queue io_work context run on sock incoming cpu

No real good need to spread queues artificially. Usually the
target will serve multiple hosts, and it's better to run on the socket
incoming cpu for better affinitization rather than spread queues on all
online cpus.

We rely on RSS to spread the work around sufficiently.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 9eda91162fe4..911db3f170df 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -94,7 +94,6 @@ struct nvmet_tcp_queue {
 	struct socket		*sock;
 	struct nvmet_tcp_port	*port;
 	struct work_struct	io_work;
-	int			cpu;
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
 
@@ -144,7 +143,6 @@ struct nvmet_tcp_port {
 	struct work_struct	accept_work;
 	struct nvmet_port	*nport;
 	struct sockaddr_storage addr;
-	int			last_cpu;
 	void (*data_ready)(struct sock *);
 };
 
@@ -214,6 +212,11 @@ static inline void nvmet_tcp_put_cmd(struct nvmet_tcp_cmd *cmd)
 	list_add_tail(&cmd->entry, &cmd->queue->free_list);
 }
 
+static inline int queue_cpu(struct nvmet_tcp_queue *queue)
+{
+	return queue->sock->sk->sk_incoming_cpu;
+}
+
 static inline u8 nvmet_tcp_hdgst_len(struct nvmet_tcp_queue *queue)
 {
 	return queue->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;
@@ -501,7 +504,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_queue	*queue = cmd->queue;
 
 	llist_add(&cmd->lentry, &queue->resp_list);
-	queue_work_on(cmd->queue->cpu, nvmet_tcp_wq, &cmd->queue->io_work);
+	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
 }
 
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
@@ -1215,7 +1218,7 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 	 * We exahusted our budget, requeue our selves
 	 */
 	if (pending)
-		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 }
 
 static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
@@ -1375,7 +1378,7 @@ static void nvmet_tcp_data_ready(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue))
-		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -1395,7 +1398,7 @@ static void nvmet_tcp_write_space(struct sock *sk)
 
 	if (sk_stream_is_writeable(sk)) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 	}
 out:
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -1504,9 +1507,6 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_free_connect;
 
-	port->last_cpu = cpumask_next_wrap(port->last_cpu,
-				cpu_online_mask, -1, false);
-	queue->cpu = port->last_cpu;
 	nvmet_prepare_receive_pdu(queue);
 
 	mutex_lock(&nvmet_tcp_queue_mutex);
@@ -1517,7 +1517,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_destroy_sq;
 
-	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
+	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 
 	return 0;
 out_destroy_sq:
@@ -1604,7 +1604,6 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	}
 
 	port->nport = nport;
-	port->last_cpu = -1;
 	INIT_WORK(&port->accept_work, nvmet_tcp_accept_work);
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
