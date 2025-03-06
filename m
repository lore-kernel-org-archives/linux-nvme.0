Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4EAC28B24
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7EFhyYRjk0NmFyx9tjONYQZAshdk/5lpm7lAwyIIxmk=; b=LJWQN1/RGyw+Vh1axwmjf0pK6r
	AhJDvzliXRPWczSDZ0c7PFk50vqLfE5Bo9r/oo2r7Mc790L0a6foT8FceRzOFh1kTlBiKasAKrhf/
	vAROeD2AUZzttsEskjRMwLovUkMe5WHnm5a95IU8g9zkWXO8LbxO7A8OTlDftcsI/MDUX9IQbphK+
	LM7HqCgG6rx4fCEKtIephpdwMTwi+3BoGkYXO8+swpIgYVrAQF5i20FqniZMAPvYF/5NYFPL4VALh
	7TEPyga8SqGFKm2jxrQuSzu7BOZW1K19HQfNHadumkIGzPSfrr3TOkxxUCYYmfmXnS0XRQ+phuQbq
	UQaItCsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqDnf-0000000BQwz-3Z6o;
	Thu, 06 Mar 2025 16:10:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqDhc-0000000BPkj-3dmV
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 16:04:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EFhyYRjk0NmFyx9tjONYQZAshdk/5lpm7lAwyIIxmk=;
	b=CQ4e/7ABrfGPt2VgMTyQ60SVch5cUiIHFusaE1Zm8RvScmwueaek/0aBmSkpYieQCX+QWh
	pLxXX4AZsxY6SzEi/wusQMCcvH9U5sbLrrjLw4HpqsTi5L7nF9ah8Fp1WIUpJC4O2/NDC9
	JAr7i1Ocl8Cg1Fcff4Nlk6n1jupyPrI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-on8_AtBPPomOH-XVUEl6wg-1; Thu,
 06 Mar 2025 11:03:51 -0500
X-MC-Unique: on8_AtBPPomOH-XVUEl6wg-1
X-Mimecast-MFC-AGG-ID: on8_AtBPPomOH-XVUEl6wg_1741277030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74EDA18C0FDF;
	Thu,  6 Mar 2025 16:03:29 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.44.32.245])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DFA01801747;
	Thu,  6 Mar 2025 16:03:27 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: hare@suse.com,
	mlombard@bsdbackstore.eu,
	linux-nvme@lists.infradead.org,
	kbusch@meta.com
Subject: [PATCH V3 1/1] nvme-tcp: Prevent infinite loop if socket closes during CONNECTING state
Date: Thu,  6 Mar 2025 17:03:22 +0100
Message-ID: <20250306160322.1370300-2-mlombard@redhat.com>
In-Reply-To: <20250306160322.1370300-1-mlombard@redhat.com>
References: <20250306160322.1370300-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8_F5zbAXhojFjuTpCVM_kUhFHfS-xvhW8AQyaNTJhLY_1741277030
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_080404_985936_78296349 
X-CRM114-Status: GOOD (  11.32  )
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

There is a potential race condition that can occur if
the target closes the socket while the host is in the CONNECTING state.

If the socket's state changes to TCP_CLOSE, the nvme_tcp_state_change()
function is invoked. However, nvme_tcp_error_recovery() is unable
to transition the controller state to NVME_CTRL_RESETTING because
the controller is still in the CONNECTING state. As a result, error
recovery is bypassed, and the controller incorrectly transitions
to the LIVE state with closed sockets.

Subsequent attempts by the host to communicate with the target
will result in an infinite loop.

Fix the bug by initiating the error recovery process in case an error
is detected in nvme_tcp_try_send() to correctly
handle the disconnection in case we missed this event
while transitioning from CONNECTING to LIVE.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

v3: Do not check for -EPIPE, just call nvme_tcp_error_recovery()

v2: commit message: clarify where the error recovery is started

 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8a9131c95a3d..4e2cbad3f2bc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1304,6 +1304,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 			"failed to send request %d\n", ret);
 		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 	}
 out:
 	memalloc_noreclaim_restore(noreclaim_flag);
-- 
2.43.5


