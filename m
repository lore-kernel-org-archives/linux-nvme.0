Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745E606A31D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=skI8kThL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VMgRgeGC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YrHXlTj62K9347P7OmkxD9vCvcqzaK1MyEYVZ/+sypU=; b=skI8kThLn/3/JAGeHHmSP9QJ/t
	6TpcxymnIlAblPJ6NRG9SjFNuKHtxXCrYN+N2eqdqlJPD46GyuxhFioBF9t//Ua3ccBQ8qM1sE8jN
	giW+YCbZx5OUz822f1o1i5vDlgnllKiWshx0Jh+LZfZoPZIHNC7rpxriEsHphPDrwEIp1dQBT/CHR
	Yjr8ZXN0f5m6jHT7E32a1JDHeZSC0umXZoWDsLDekJs0EcM5Rw5lkTo6w9NaEVVWbUNxdMSJJavaw
	iQrSj3CiJSmczIbLY6+XZwPWUzE4pb07h6by9UaIkeu5b82aBjTI9UjS1l52Q8QGB09X7wdDS9Wzr
	6qOyzi2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIzwP-00000008k3s-3N2A;
	Tue, 20 Oct 2026 02:51:05 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIzwL-00000008k2H-0FLf
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 02:51:03 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1090783a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792464659; x=1793069459; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YrHXlTj62K9347P7OmkxD9vCvcqzaK1MyEYVZ/+sypU=;
        b=VMgRgeGC9aWpdsGyzjcRQfwrjtfJj8LUrVjk61b4iBGbD+juRMBmlGuM4GXvSIBiRI
         jkO2Y61YBWhTEOVq/Fx3xCX9ubGXF78JXStS6W9W78kPS77E1KfmFn9kV36TlH+JPOuK
         3fc/HJkt8TvihvP42DAnj8UUgxdoa1vYyqMumzN50Le1YbFLWjAtEi4GGrhmtXf7+0F6
         5V3R+xLet1yc56Q0bWfJWcku+6LZEvfOvTtyheVeFLUlN/7fqnvUfaluHEmo7zOxZI1o
         pGt+ArAD0ORoK9XzJ7ZsbQtpiDQ+/h5a4KP8R0MVO+CC3bWHbdCn3LhuzJ9ylilzU7nK
         B0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792464659; x=1793069459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YrHXlTj62K9347P7OmkxD9vCvcqzaK1MyEYVZ/+sypU=;
        b=BvnVckqfd3zu6poZw4xoelBJO5WvJkvIMmEHxOqKfASGUm7Wtm1L7Lc/37YyngQbcH
         lKxqQLsxoL2+PSlQ4hxUSWZxWOojgkw/RG1GW4hfAWwMyaTWeG1GgIVMUE6YX8qM3lX5
         kYdiDml5S4gJ66jXlqbnIgEGo87CIZaobaNA1J8tGwW5O/uqTGlv9TI8yX0HCqIi2603
         UyN1vippMb3nZ+0cNhf/pqWkM3fIGRfqF4H833SZWfr5qHGdPBDnkF08FnmLjYkP/UTI
         6wcCpGBWf6/SQCJLYI4i0jIZCiymeDb7gQ4hc0lAKNtjZPfVR880mDVeNSamGIxRUZDR
         Q/6g==
X-Forwarded-Encrypted: i=1; AKwUvByumFcKl2R4nlD95SWH+AW0ZfV3kpO+GuDevRD+LWGPrMQ2z1AaU+juJyxua/mKMRQNv1I0PdUGMYKn@lists.infradead.org
X-Gm-Message-State: AFq9FYLj17UJJt9xsGz0LAhgFc/4lwOUa10xGuoArhosESI7KwDyVwze
	wLxfmHw5rCDW8rZxE9CttUl+iu4FcdktTlw6KoTXwTJNjDjb7mrjujtd
X-Gm-Gg: AYBFou3jg7K7q/eNtvCTjzOwO8/h7dKAd4Gw9bNnLM34aVsJE8Jfe2JJHVJs5ov+ESq
	eW89gPbRRxZ0rXVGYowsusumdJcTNOYcvCA/mwjim48xNyTluc3Hv2iorVY7j/iNnn40KB0cPoY
	oY75naVbUxDaZEQ40ronhoW44TNpFIiOlO0VrGXI4ECtm8AQltEuQCNdEJsftvraWcq6lZl5IIB
	gbLSsMhIMSPKCLo7lNFDjtNTYuuHAskUOWJYNniCanwKaNxIDoVI/oudXMPoa1fLbdeHWZlSM8V
	9RFn/nYKAIe8xuiW6DU86FCRgV9a/bul+t2H60kCHhEBe1QeWvhLptaFUT+FLE8wyPFityU4h3e
	kJpVt5SBoOV7qsEeb+bhhDNvNInBdQL3qIrs7zPRtdzrYzejTDHUJof8qQoPz+CburL9NgwrymL
	WkORT08jXievvNh10UlO7SY0pS8GvgTDRUnn2B2h/3atBmMiHtKyYSsIbcGdNW8FLGbkI+IEA/G
	JDtkMs+NKvoq8BXPhefHqBlehZ4p+n7vSR29uhmXT9m4zPu598zDWta/lSbHN5Kc8WnWtnYhJd0
	VGJUsqtSxpDYj2q1Ij9NvquRCyjClhIA7o79aF3UNnoyszCX
X-Received: by 2002:a05:6a20:a121:b0:3de:76da:6b9 with SMTP id adf61e73a8af0-3e226057ab4mr8478461637.68.1792464659552;
        Mon, 19 Oct 2026 19:50:59 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f579464besm4613442b3a.34.2026.10.19.19.50.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 19:50:58 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()
Date: Tue, 20 Oct 2026 12:50:47 +1000
Message-ID: <20261020025047.88297-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014054727.53183-1-yuz08559@gmail.com>
References: <20261014054727.53183-1-yuz08559@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_195101_137885_717162D2 
X-CRM114-Status: GOOD (  11.05  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_subsys_attr_qid_max_store() sets subsys->max_qid and then walks
subsys->ctrls to force every controller to reconnect, but it holds only
nvmet_config_sem (for write).  subsys->ctrls is protected by subsys->lock:
nvmet_alloc_ctrl() adds an entry under subsys->lock, and nvmet_ctrl_free()
removes it under subsys->lock with list_del() + kfree() (not kfree_rcu).
The free path takes no nvmet_config_sem, so the two locks are independent.

A controller teardown (host disconnect, keep-alive timeout or fatal error
-> nvmet_sq_destroy() -> nvmet_ctrl_put() -> nvmet_ctrl_free()) can
therefore list_del() an entry while qid_max_store() is iterating the list,
corrupting the walk.

KASAN, concurrent "echo 128 > .../subsystems/<nqn>/attr_qid_max" racing
nvme-loop controllers connecting and disconnecting, panics in seconds:

  BUG: KASAN: null-ptr-deref in nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
  Read of size 8 at addr 0000000000000090
  Call Trace:
   nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
   configfs_write_iter+0x1a7/0x250
   vfs_write+0x5df/0x940
   ksys_write+0xfd/0x1e0

(also seen as a general-protection fault dereferencing a LIST_POISON
pointer at the same instruction.)

Take subsys->lock around the list_for_each_entry() loop, matching every
other subsys->ctrls accessor.  ->delete_ctrl() only queues asynchronous
controller teardown, so it does not re-enter subsys->lock under the loop.

Fixes: 3e980f5995e0 ("nvmet: expose max queues to configfs")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
Tested-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/nvme/target/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2b69ffc..23418fa 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1684,8 +1684,10 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 	subsys->max_qid = qid_max;
 
 	/* Force reconnect */
+	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		ctrl->ops->delete_ctrl(ctrl);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
 	return cnt;
-- 
2.43.0


