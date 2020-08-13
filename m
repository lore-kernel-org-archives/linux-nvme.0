Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5230FC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 14:48:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138B320781
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 14:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BitQa8k8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZXqIDJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138B320781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=37FZ9KCWEATGTEj7+LlSY6srh5+o65+ZQ5DEwUijgNs=; b=BitQa8k8+rP3nIYQb7j3rMunZ
	Th6KPpj61bhnOMM/Am3KPg4Lr6kjW9F9Bozc9IMnHBa5iQw2BeFkiNQ+zvlMxD/1UYDrnVZ2XdX1j
	z4PuNRmHjrRpF9d0v2Kxt+5TbnJlrs8p3LNBVZwlmRScAVpm2yFXnmNMYhFdudLywtHYQXA55Kw7y
	XpbEV6lIuDkt0l4xmvAhHHJJF4Oakt7TqK/Pb6p4m9E15AgG2IBvpchGYtPuPuMZuKdogFH8TEg6k
	FrpszgOf+vYJQeTogfUrOShBRiZPAUcrCvO3m9+PJAJSN4pQyN+E+rURs7MI8vh9ab4UE7km09evk
	4ZghVxkVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6EWo-0004mR-DI; Thu, 13 Aug 2020 14:48:26 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6EWl-0004l7-6Y
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 14:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597330102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtFLtqk90hm7Trz8tx9yG9H2Uq8s9CYD4FDBZ5Dvw2Y=;
 b=iZXqIDJ99BQF7pQ09YzVK4ur7n7w9MftIT8DndhrIo1YH7A+lQ6ShB1QtvB5HKl+w8jrRD
 lnpZIVw/Ze37E63nC7VCZFnmUGo5hXq7AyCxxaYxaMG6iwBAHTdkHDeeW1pIro3ObWGx0h
 zN5zlk7KV9r2ioxjEosPs4XMFeSskS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-KUujD57GOJOIEcXQW0k9Dg-1; Thu, 13 Aug 2020 10:48:20 -0400
X-MC-Unique: KUujD57GOJOIEcXQW0k9Dg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E725E1005E67;
 Thu, 13 Aug 2020 14:48:17 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FD68600C5;
 Thu, 13 Aug 2020 14:48:12 +0000 (UTC)
Date: Thu, 13 Aug 2020 10:48:11 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: [RESEND PATCH] nvme: explicitly use normal NVMe error handling when
 appropriate
Message-ID: <20200813144811.GA5452@redhat.com>
References: <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com>
 <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com>
 <20200810172209.GA19535@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200810172209.GA19535@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_104823_274633_E14F59FA 
X-CRM114-Status: GOOD (  16.59  )
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
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 dm-devel@redhat.com, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>, Ewan Milne <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Commit 764e9332098c0 ("nvme-multipath: do not reset on unknown
status"), among other things, fixed NVME_SC_CMD_INTERRUPTED error
handling by changing multipathing's nvme_failover_req() to short-circuit
path failover and then fallback to NVMe's normal error handling (which
takes care of NVME_SC_CMD_INTERRUPTED).

This detour through native NVMe multipathing code is unwelcome because
it prevents NVMe core from handling NVME_SC_CMD_INTERRUPTED independent
of any multipathing concerns.

Introduce nvme_status_needs_local_error_handling() to prioritize
non-failover retry, when appropriate, in terms of normal NVMe error
handling.  nvme_status_needs_local_error_handling() will naturely evolve
to include handling of any other errors that normal error handling must
be used for.

nvme_failover_req()'s ability to fallback to normal NVMe error handling
has been preserved because it may be useful for future NVME_SC that
nvme_status_needs_local_error_handling() hasn't been trained for yet.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4..be749b690af7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -252,6 +252,16 @@ static inline bool nvme_req_needs_retry(struct request *req)
 	return true;
 }
 
+static inline bool nvme_status_needs_local_error_handling(u16 status)
+{
+	switch (status & 0x7ff) {
+	case NVME_SC_CMD_INTERRUPTED:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void nvme_retry_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -270,7 +280,8 @@ static void nvme_retry_req(struct request *req)
 
 void nvme_complete_rq(struct request *req)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+	u16 nvme_status = nvme_req(req)->status;
+	blk_status_t status = nvme_error_status(nvme_status);
 
 	trace_nvme_complete_rq(req);
 
@@ -280,7 +291,8 @@ void nvme_complete_rq(struct request *req)
 		nvme_req(req)->ctrl->comp_seen = true;
 
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
+		if (!nvme_status_needs_local_error_handling(nvme_status) &&
+		    (req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
 			return;
 
 		if (!blk_queue_dying(req->q)) {
-- 
2.18.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
