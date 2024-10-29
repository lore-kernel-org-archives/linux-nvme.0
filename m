Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FF9D3A680
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OGMLBsZH8fQjh+dXGHyO6XwIeRfwUf6b2/lRGhLA77I=; b=3q2Toww4TCEzQq
	N4ocS83/lFh64gpREt/aFUu3uLzJ405/2qPI8xcFrhoIVubvuxDNXLKMyXBgX1ICDHV09KJBWshAD
	X7wy/nCY1DXlA+ZlXWUyLsGJmI7ksdf7XbRULvwn3QJSJHZMa7tbM7gOm2VdpeeWQ4zRvtb+qvl8D
	YIjbO4ObY1N25GfRg6YMlTyUOxJJOA9NSyXmOTKpxXdpTPLg8hgAksJoE8hXmbHBiDJ1zL6cxS1mx
	ir9DlNaTck3dLZ6BFeftCb4Lt0vkSwM8Cp6uGwzQnn99BwZkIanO3Y/I0jQUi70CmnXHhyTNAg0Bp
	mZV1GzveT+PCPqEmJY8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5r8e-0000000FVaX-0RuC;
	Tue, 29 Oct 2024 18:40:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5r8a-0000000FVYe-0wCA
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 18:40:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 525F55C5E4D;
	Tue, 29 Oct 2024 18:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D36C4CEE4;
	Tue, 29 Oct 2024 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227215;
	bh=i+Vf8LQzRaMP1d0Nly2QkjcRobxa8yt1nSL0ap/n09o=;
	h=From:Subject:Date:To:Cc:From;
	b=cCgPtw0fhXbw70rFFzwS1LZUAGPeFPSOsXel1esNwwf8tHuZcSATpk1FhcbAD7rq5
	 BXvVIEoQ/lLNYF9Rk9O+qzYvCeewnJDJ7LFugdNOpMvnC2M8/HbBxN1t3nrg1efbFE
	 wYStwGssNUahi05GTH98ihXKNE94G2dx5Ag9Mjszm5yHfsX9JCmFHtAF9U9WLpcV3T
	 fXgLhXU9795sphGA6mW+XrD/HhMXPCUsCery/XAvY3wUO9zv9d+6v0i/0RuEpgNHm6
	 Itm9avEhlXZAW63ZgLcJuLkljMCSI4tL9C4ybRNchNlxHwSGdSry83WKbLa+j+VeF9
	 yU3qOv1s5qfGQ==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 0/2] nvme-fc: fix race with connectivity loss and
 nvme_fc_create_association
Date: Tue, 29 Oct 2024 19:40:10 +0100
Message-Id: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAosIWcC/z2MQQ6CMBBFr0Jm7ZBOxUpdeQ/jorYDNIFiWkQTw
 t2duHD58t9/GxTOkQtcqg0yr7HEOQnoQwV+cKlnjEEYtNINKW0xrRNj51HGMDL6ecJxLgvahwj
 2aFplHcj7mbmLn1/5dhfuspjLkNn9e8oQkVWmOddE7ckgYXi7PnG+llfhOjDs+xfzQzp5ogAAA
 A==
X-Change-ID: 20241029-nvme-fc-handle-com-lost-9b241936809a
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_114016_342743_37C11014 
X-CRM114-Status: GOOD (  14.27  )
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

We got a bug report that a controller was stuck in the connected state
after an association dropped.

It turns out that nvme_fc_create_association can succeed even though some
operation do fail. This is on purpose to handle the degraded controller
case, where the admin queue is up and running but not the io queues. In
this case the controller will still reach the LIVE state.

Unfortunatly, this will also ignore full connectivity loss for fabric
controllers. Let's address this by not filtering out all errors in
nvme_set_queue_count.

I haven't tested this version yet, as it needs a bit of tinker in my
setup. So the question is this a better approach? I think it would also
be great to hear from Paul if this works.

In theory the nvme_set_queue_count call still could pass and later
connectivity loss could happen, just before entering the LIVE state. In
this case the only thing to observe the connectivity loss is the keep
alive handler which currently does nothing. I think we should also
trigger a reset in this case. What do you think?

---
Changes in v2:
  - handle connection lost in nvme_set_queue_count directly
  - collected reviewed tags
  - Link to v1: https://lore.kernel.org/r/20240611190647.11856-1-dwagner@suse.de

---
Daniel Wagner (2):
      nvme-fc: go straight to connecting state when initializing
      nvme: handle connectivity loss in nvme_set_queue_count

 drivers/nvme/host/core.c | 7 ++++++-
 drivers/nvme/host/fc.c   | 3 +--
 2 files changed, 7 insertions(+), 3 deletions(-)
---
base-commit: 5e52f71f858eaff252a47530a5ad5e79309bd415
change-id: 20241029-nvme-fc-handle-com-lost-9b241936809a

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


