Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D10112584E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WPkbOrloYj2e5sPJVDwYdPDFwMSpsR7mt6BhM9wEq8U=; b=E4vm6IpRhi9UQEglbNirhrFqzG
	VPT425Y34CFN1UYOI1t7/V7bzaFkPSwfJ3nnGlcHLgaGrqQq8xruAMmyN2xfgHj8xenIxntRsT0np
	nQrhix5LhWIlugFrr4kY8bibXpM6pWvYueqkbyj+Jx5niJmz+kAhvUgEzgWqN6Wh8xJ48M95dWz8R
	3ibnnPwhtH1t5q2W/7tPGT0HMDEaC6lShEUZXdugx6CycwX4/h627UF5DOvMur4LULsWDcu3gSrWL
	py031JCKwBmXVn4dLUOZCPIqQnott+dd56H6jtUISL1Z5Rc49xZ5Nh2dqDUGP7KeYE/nr2UxPuLCK
	/DRKh3IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0M7s-0000000BtGn-2Pv9;
	Wed, 11 Mar 2026 16:09:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0M7p-0000000BtDK-234k
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 16:09:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773245371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WPkbOrloYj2e5sPJVDwYdPDFwMSpsR7mt6BhM9wEq8U=;
	b=R8Vq50FA5lWvQd8fj5d5kudpqIoSWXMEahxgDzHCnxMn+/hSi1Mn1/0t5/OOeH6v8JgShI
	pngtu7Fy1lFtE6aFE/dyq63jDdhUK+mIYj4eOzjyuvarn2f9zQa+uFF6R04IipTq2gvAfz
	OCLC8uwe8P2ILLrChDIWI0hiVwXgXiE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-jXyRx8CGMYGiEJeAvfQovA-1; Wed,
 11 Mar 2026 12:09:27 -0400
X-MC-Unique: jXyRx8CGMYGiEJeAvfQovA-1
X-Mimecast-MFC-AGG-ID: jXyRx8CGMYGiEJeAvfQovA_1773245366
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AE3919560AA;
	Wed, 11 Mar 2026 16:09:25 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.138])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C31EE3000223;
	Wed, 11 Mar 2026 16:09:21 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	yjshin0438@gmail.com,
	hare@suse.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com,
	mlombard@arkamax.eu
Subject: [PATCH 0/2] nvmet-tcp: fix receive path error handling and state machine
Date: Wed, 11 Mar 2026 17:09:18 +0100
Message-ID: <20260311160920.465209-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JjGu6d_dSQcos2MaHNB_KcIISWlvS0GHU_RTO5uxmiU_1773245366
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_090933_592956_35FE4A0D 
X-CRM114-Status: UNSURE (   9.67  )
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

Patch 1 fixes a potential issue where network data could be read into an
uninitialized iterator. Currently, nvmet_tcp_build_pdu_iovec() returns void,
meaning callers are unaware if an out-of-bounds PDU length or offset triggers
an early return. Consequently, callers blindly overwrite the queue state to
NVMET_TCP_RECV_DATA. This patch modifies the function to return an error code,
shifting the handling responsibility to the callers to ensure proper socket
teardown.

Patch 2 cleans up redundant, localized calls to nvmet_tcp_fatal_error() scattered
across the receive path. It delegates the responsibility of executing the fatal
error function to the top-level caller by bubbling up the error codes.

Maurizio Lombardi (2):
  nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers
  nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()

 drivers/nvme/target/tcp.c | 75 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

-- 
2.53.0


