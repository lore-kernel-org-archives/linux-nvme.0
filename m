Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15006C5CFC1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDsc1xS4FWzL2UlZko8rXMKKZH8FnkzYTI+gpvfXX+U=; b=uh8dYxTY6n0kIhjV+StEl634cb
	72b5NfXiMivOGsu8eWLmvPNKK/uHiW3TL1X8GzQPwvBL+bTQlwtvEAV0ISyvWjwd8toK4f8C3bC4k
	DS9ZCfWs8aqu+pMcN8qIucz134YCJZlNNQA9CrXBaHqNY+3611ET89ZLdnYUgAP5EuBHWnPiGB1zy
	/6kg1xBHMo8E2sVYFOWKA8diwF9PptTwg5/L9dgEQQd264OSszmMjPNJnL2cKE/WypqnG8iRT52/r
	2VtAraiHz6HBt7wU/J7rtC5uSc7moMvs4Fid5FLNXrl7AQ0sZ78tn6NWdACwdCnS8czWfrrtryfOm
	QMk5go0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wux8v-000000034Pk-3tbM;
	Fri, 14 Aug 2026 19:00:37 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wux8t-000000034O0-1Aa9
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 19:00:36 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-92e5b048375so79878885a.1
        for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2026 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734031; x=1787338831; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDsc1xS4FWzL2UlZko8rXMKKZH8FnkzYTI+gpvfXX+U=;
        b=FDPkQGOnyntaQ4l/x5zZsLyVuJ+cs9hbuwqbQ0oATZUPNBy48bGVgOCBKUJidf0+op
         bYki1jdJWEJjI8nLRU/MwZfqrfYxGb/msTRwQxXsEbIM8B/kfv6O/r4U5GtRBHg2MaGm
         kgArfXlDireaSrbPECJcmCG2wve808ELIRgpS6mvpLO3sorwVMM08CwklyyU6MIRlu7T
         8dIb/lo32Rc1DxxQIhqG0lVL408MLqVup6HY3YZpCOEtHQQBfG0ExunJNtwEylKiPCwd
         C+iLBcoF8hXMtcVzddqqPbUZm5Hrii9jUZYSv7+hRjgZ4nNeRxL0CpOhUncJIVXZhJjV
         8ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734031; x=1787338831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZDsc1xS4FWzL2UlZko8rXMKKZH8FnkzYTI+gpvfXX+U=;
        b=cO49wzGVUo+L8vxdwAglalwrESenznYAu90w5U8UuXj9ICSCXmOx2aKgvICQimFBo4
         S6yO6zFMUHpqe/OayCLf0gYaL8QFOm1zvluL99Rhy7WkMvlBKW08L74NMsNf0su7Pj5O
         qIB2rRGjvdbKle9YFDZfbkPiHd/+tnrK9tYWU9TyVywjSK2pNJX+B3SOgOlsfbgSaXT8
         CDkSRfJUgpDISfusFE6lEgus9lZ5B0mRY9IFcfmJDlDuZnLLFq5M92M84ros55Z+l155
         KOq9kJdfGkAwIzUYOHqrZ0eHRAx4bGof2NGOkgwHaf3aVENkfmD+y6xXx2fH+S4IE212
         YUiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn9SV8WKyYyxVhkqIepe6igvM4lIhWVS0Mca9kKSjsjkjv4x8POF/ySZM1UrtNSqdDXDV8KGEt0//4@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4ir0HyvZljBlpv8nsp/WBLTK0y0UhwQYzgULLALFA5MSw0CBE
	eo0G843jI+uc8mOOQRuFYcMSiHEiOB8rxjiw7GrUDVeOG6icSDQlVqAf
X-Gm-Gg: AR+sD13XZ98xahxznzgw2qECE4s9Tmj2TyB9yNMoL8ZVamxhk53AKFqP3qhlu0BSKo8
	SKJSQ6zFF+8g60B0huVdbzJF3FH5F1yU/yvh/paK21EmxhDIrX1C+nIVV3z4R506ir2Yeqzfy0N
	n+oB8TysmFbL864vDiV0XgFl+MrXYwPeOyKKcqkYMsXyCfleLPCldCyUo0Q4PiykU7VTu4Yb28J
	38roCXtF/0zaD48MgtvF4sk0+pgJqFLlJvFOawXiuOzYZai3Qu5KO/praTyLlb+oCaWWo3Nt9J0
	XSVmVTiPXwsCHwz8mGcJVH+JTdF51wK0AQlLqCmGo8xph4weJASTfQyx32PHMFaJQgNeTPU8UNO
	IyJP4TGIMz/f83ogFJMKAJ0/gn9MA9PcM/6sPzBVChOUUfNfvQ6v2KopU86ynmzutKVmwFSJTNg
	Yu1Fiw0VnTt3vmm5kc9W5qegYZw3go0OeSsSiyTzFvGRLyfqUdGTN0ho1lfssCTyhFBoYvfhpUG
	MS1EjHjFC7LJwVd0eNZXjU3VQ==
X-Received: by 2002:a05:620a:3998:b0:92e:4859:49dd with SMTP id af79cd13be357-936d235fb5dmr604811585a.26.1786734031224;
        Fri, 14 Aug 2026 12:00:31 -0700 (PDT)
Received: from shivam-EliteMini-Series.syr.edu ([128.230.213.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce0b23d6sm328700285a.18.2026.08.14.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:00:30 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: security@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kumar.shivam43666@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-tcp: fix NULL pointer dereference in nvmet_execute_identify_nslist()
Date: Fri, 14 Aug 2026 15:00:22 -0400
Message-ID: <20260814190022.1531236-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081423-enlarged-dribble-10bb@gregkh>
References: <2026081423-enlarged-dribble-10bb@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_120035_354641_6AB3903B 
X-CRM114-Status: GOOD (  14.10  )
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

nvmet_execute_identify_nslist() handles the I/O Command Set Active
Namespace ID List (CNS 07h) with match_css set. The per-namespace
filter in the iteration loop tests req->ns->csi, but req->ns is NULL
for this command: nvmet_req_init() clears req->ns for every request,
and CNS 07h uses the NSID field only as a starting filter (min_nsid),
so no namespace is ever looked up. The intended value is the loop
variable ns->csi.

A remote host that sends an Identify command with CNS 07h to a
subsystem with at least one enabled namespace dereferences the NULL
req->ns (at offsetof(struct nvmet_ns, csi)) and crashes the target.
Use the loop variable ns instead.

Fixes: 61c9967cd634 ("nvmet: implement active command set ns list")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 01b799e92ae6..ab6a0a98dd5d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -958,7 +958,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_nsid)
 			continue;
-		if (match_css && req->ns->csi != req->cmd->identify.csi)
+		if (match_css && ns->csi != req->cmd->identify.csi)
 			continue;
 		list[i++] = cpu_to_le32(ns->nsid);
 		if (i == buf_size / sizeof(__le32))
-- 
2.53.0


