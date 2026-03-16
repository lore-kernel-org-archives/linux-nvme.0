Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AC9F506E0
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eMUbU9wbgDtkM2kXHiNa4KkbZObk5SLEsJvJpTbcqcg=; b=yFllrC9jcWW6OuP9Fy1xcaIQap
	QgBlVZ51rJ5quXqJigDfoU3iit2mmrWXpoCkTtQpEU+0Pzi+j6FfwQ8emKOgKakfX4YcIJKVRFaxt
	rrdQ5THDfiO5hTvofcF/72VupK0mZosoxw6R8vBJNDkBMAx4hKDJpiTiJrRJWUjzsTZxSr1HQ26Ey
	+IBl4vQSkSDNgV8nA5NIsKmTjbPhwyYW8Ib7S+qW64ySBqW6Q6mccqn1SYArrNCX4y1FCO0A8KgE1
	DIfs9BIjlToh61iD9DK+ekEWLJ/rJwnKXU+kBd6tC9zuRyENdTPMlpa6MFVxJBfcdsu5703ws+vCn
	qf9IRgVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w296p-00000004Cco-35Oq;
	Mon, 16 Mar 2026 14:39:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w296m-00000004CbA-3nw6
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 14:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773671990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eMUbU9wbgDtkM2kXHiNa4KkbZObk5SLEsJvJpTbcqcg=;
	b=gEhEgHkOVrj1GW/Iry/vOhcsKhVIFgSxIFcK51fC/qOUqyeamyttDN37pQ6StXWDPzPdg3
	GP1z76ARUq4+wb/p484rJP8UbLzdrGLtfGgSDsADl4GTYCPtAAl2w2tDOGze4W6y42xLsT
	I1LuQItqFnZ+m8u8c8JQzPlUrjp5RKE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-uqww2-pwPe-4wpvHOeTXRw-1; Mon,
 16 Mar 2026 10:39:43 -0400
X-MC-Unique: uqww2-pwPe-4wpvHOeTXRw-1
X-Mimecast-MFC-AGG-ID: uqww2-pwPe-4wpvHOeTXRw_1773671982
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A37D1800365;
	Mon, 16 Mar 2026 14:39:41 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.106])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0177C19560B1;
	Mon, 16 Mar 2026 14:39:37 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	yjshin0438@gmail.com,
	hare@suse.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com,
	mlombard@arkamax.eu
Subject: [PATCH V3 0/2] nvmet-tcp: fix receive path error handling and state machine
Date: Mon, 16 Mar 2026 15:39:34 +0100
Message-ID: <20260316143936.120999-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9ML5h7JbkJhMinPar7-6UTp04-LFBmai7lOwaGaNyQM_1773671982
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_073953_073167_232C1565 
X-CRM114-Status: UNSURE (   9.64  )
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

V3: remove nvmet_tcp_fatal_error(), fold it into nvmet_tcp_socket_error()

V2: some cosmetic changes to Patch 1, no functional changes.

Maurizio Lombardi (2):
  nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers
  nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()

 drivers/nvme/target/tcp.c | 88 ++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 52 deletions(-)

-- 
2.53.0


