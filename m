Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F55C982E6
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DTm9qtAB3DCle9T5B2fg9qNOu3yAbfmq4DScnsd7fVg=; b=PPfzrq4K5cHLtltwgU1ZuebhLj
	4JYyFGJdegKj64ZzK7dKw56tg+5ttQK8QbMdYwS90XH1iF5LsacJLC5hpj41bziFNBOLi/Y5r1ggN
	m2xTYBFpTQnzPg4mV3Uoqda1UWQ2vNlcB0Uzh/Owvkiu4m1kYLEMLqrYYiulorfrjbJU96ivygfEl
	1B58s+kSvxZ4hUd+6GJ/y6KRLnZ03jKG3UXKU/NKkAR3dq1LT1XZjAIwpKVe5fJzMwowABOaJhJXr
	RZFuA2ZwcyN/nFAWerE/XtT8o82D/1g3GLnQNWWW2xt/6KTfD9plcl14daXcRoacbbTP4IXxDVKbP
	fCI8cgxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fS1-00000002Ux5-3i5f;
	Mon, 21 Sep 2026 14:57:01 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fS0-00000002UwZ-0AZj
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 14:57:01 +0000
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so2651163a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790002619; x=1790607419; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DTm9qtAB3DCle9T5B2fg9qNOu3yAbfmq4DScnsd7fVg=;
        b=HohlVE9cAGLDJHA/Sv309/U3gZ51qkfuWAQodHi83OXbLAgtCU3dhU2XAcku+FU5yZ
         YZa/g0rQgQo8RbgHWbNa4/mnEzmxGYM3dQcKg9LWIgnhDoenOrJtRBkdYgQp4pZ4ASKU
         An8BvORinVDv6YgNDWXLtJaF92re2iLJ/ZZYETBl/QvOh00oTc5nsExSx3vZPQqBNXDa
         p9IHf7NkNZcUkxhUgxCu1BGWgrartM0H2qHgFgJwumrC6oob+Aye3MLu7aTN6gKsyAfp
         u6TGzg+nzrwbiZtWXkAiiO9a/XvAdxqzewz7shGFLVP/CYId13tzfttObAUXhWCFYDYo
         HiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002619; x=1790607419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DTm9qtAB3DCle9T5B2fg9qNOu3yAbfmq4DScnsd7fVg=;
        b=SdRzufmyKi41swhwE1FvNoPszaiekI1eVmZ+kNhFKUXt2BwSVCAmYpyHJ+MoyGPf10
         cNDyNuc4gKir8YJVcegPe1ITaO7PZyNZpCJV2ia4vM0/rE10U01tQrDnNlRNENQdLw2T
         BCOXl0kgDQRHRfwyzlLZcnH+NaeObH1L3U4WbeYMdRKIxFphOXx4XHRs9QmmiXbu5kom
         Go2FCl89NqVoMTaW3HQ7Ka+yraFo1EByeZ9GSKX0eXr9H6DL2E6muBg/EEeGUbXZ6o9u
         8ZcNHfCdsdwbTp8RPaJ5JLE5xpDKBV9pFRYegBjBvftvPv+qTpMnNf+mt9uwhXwARZni
         5ENg==
X-Forwarded-Encrypted: i=1; AKwUvByec7hWkM/ViBSdYnY9JTXuvV8C4vlTY8xUkLIxw73Htbr++KUlIBz/tIsEiILcC1ckIYjpgzsp2prm@lists.infradead.org
X-Gm-Message-State: AFuF++neTeOXEoq3C9/Qzwqekb/DOtdvYjypsughto0db8w+D9WrVKRE
	haWowYCSPJYHOMnZ6+USfM3MOxxbhmHCJ/4j5vt8ndz8X9Mu1L5XXlwD
X-Gm-Gg: AYBFou3u7g5naFRTPsnEXEKa1CWOkpSjld6/6ckKuqKlEmTC/sLR+NwrRbk4+e8Ppr9
	ukiwdOo6p8jaWyzavMWBJr4GljUgU+LW36NQlTFlDUVlQ7iQhGaeWa3iWzOdwG9C2DxUAsL5hUf
	jMdSWyRbbVzCTa8OU2s95rmO9sNNkIug0vWBCtlKqNEDo5BPM7L6vEJLjwx+ehNdoLBt+sU7WgR
	xE1Bj4+hXTkZutIlwZJi8pmA/hCmr8Gm30VMOOz4SH+pneEwLf7aPvJmFgjwgDFAkK2w25oAPLN
	wr9V4ofqmpXSY2nDrlr/TyeSBxXeMMjRbqoTKIT2/EnKZQtZA0cgzh5iy/Cu7R04EFAnAG6goxd
	9tglkTrYm71oV03gzT3lCLBiO/EP3AlMqeW09KiL/5hdfJXv5Jb9Y9OsHxeZv4wygIfv2LUt08S
	Pxzag4y+qn0D9IP79NSZKbM7xF+AH8+1F+TlWjOWBA4itUCK74AFHSrvKcX8Nls0uc3DaNeXbDa
	30tIbsQSfBgBlhT3RhUAaNmfdQ=
X-Received: by 2002:a17:90a:f947:b0:39e:6c69:34ce with SMTP id 98e67ed59e1d1-39e6c693606mr10046392a91.50.1790002618688;
        Mon, 21 Sep 2026 07:56:58 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:70bd:a3d:dfa4:3859])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a063b86538sm468175a91.9.2026.09.21.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:56:57 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+77955102efac681ec73b@syzkaller.appspotmail.com
Subject: [PATCH v2] nvmet-fc: flush nvmet_wq twice on targetport unregister
Date: Mon, 21 Sep 2026 21:56:51 +0700
Message-ID: <20260921145651.17131-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920163804.67858-1-ngocthang2710.1999@gmail.com>
References: <20260920163804.67858-1-ngocthang2710.1999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_075700_084992_002275A4 
X-CRM114-Status: GOOD (  10.16  )
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

nvmet_fc_delete_assoc_work() sends a Disconnect Association LS. If the
LLDD completes it asynchronously, e.g. fcloop failing it with
-ECONNREFUSED from a work item once the remote port is gone, the
completion is queued from within nvmet_fc_unregister_targetport()'s
flush_workqueue(). flush_workqueue() does not wait for work queued
while it runs, so nvmet_fc_free_pending_reqs() frees the pending lsop
before the completion runs, which then calls lsreq->done() on freed
memory:

  BUG: KASAN: slab-use-after-free in fcloop_rport_lsrqst_work+0x242/0x2e0
  Workqueue: nvmet-wq fcloop_tport_lsrqst_work
  Allocated by nvmet_fc_xmt_disconnect_assoc
  Freed by nvmet_fc_free_pending_reqs
           nvmet_fc_unregister_targetport
           fcloop_delete_target_port

Flush a second time so such completions have run before the remaining
pending requests are freed.

Reported-by: syzbot+77955102efac681ec73b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=77955102efac681ec73b
Fixes: bbccbf791e6f ("nvmet-fc: free pending reqs on tgtport unregister")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Changes in v2:
- Drop the fcloop change; the async -ECONNREFUSED completion mimics what
  an HBA does (Daniel). Instead flush nvmet_wq a second time in
  nvmet_fc_unregister_targetport() so the LS completion queued by
  nvmet_fc_delete_assoc_work() runs before the pending requests are freed.
- A blktest reproducing this is sent separately (nvme/071) (Hannes).
- v1: https://lore.kernel.org/all/20260920163804.67858-1-ngocthang2710.1999@gmail.com/

 drivers/nvme/target/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033..cf9fd304a2b5 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1646,6 +1646,8 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 	/* terminate any outstanding associations */
 	__nvmet_fc_free_assocs(tgtport);
 
+	flush_workqueue(nvmet_wq);
+	/* assoc deletion sends an LS whose completion is queued while flushing */
 	flush_workqueue(nvmet_wq);
 
 	nvmet_fc_free_pending_reqs(tgtport);
-- 
2.43.0


