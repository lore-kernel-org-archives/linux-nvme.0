Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE30C43458
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cduHWfRr3cNlL9+U7DXnZtRw2pQyx26+A9+h8FmzaX8=; b=SnrObro2qfm1YcCrY+/GSi2elS
	sPVe2lFT8R4rLVdP45IpkLIOOLItpH+tXxpbUQZU8T73jSRppobU5JK8bZtGodmAGZPjRRzYtnV9N
	13K5s6L8K+YkLhHOE2Uykyrq+arReZkUQk6XYRI1FjONJetNjcxOfUhbJpjk++j5lgutipcbHy9Px
	JYj3kgBSroLmYXU4tAX7oQj4bndTOlUHWS/iAniYiBZK1Q0kiri6pxaMyLdT4/DkCye2w/dOBtL/e
	5bpCT5bSlFySlxznuTickMetMFDJEEBuW0T2O80iSESRBeHp5pdCNGAtma2xiDQzSu4eszUcpWMmu
	xs946LXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsj-000000071NN-1YrO;
	Sun, 12 Jul 2026 02:25:25 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijse-000000071Kw-2HqR
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:22 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1774115a91.2
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823119; x=1784427919; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cduHWfRr3cNlL9+U7DXnZtRw2pQyx26+A9+h8FmzaX8=;
        b=PQMglN9QlcZUlSUn7nVd0XrzKs55OQhXpL4blRIAT5O6oR0Y6NmahfmU8VY9IimkEu
         3ce4nupHH1m9S7CA1TVa5DZiUUPrdg3fc4calPBUOj0Cq5qX5pHoU9jeOzD627K7CJ1e
         H6O0VmaHswh11uW8cgoyYMxraHK/ny6Cbh3/JZ3UsodrfbZHHR2NsKVaDBbZ6bw0H3if
         +pKjJkmGnwjWuUTP079WD7wOt+8lVIfwkRrmX8q3tJBc8elZx9U/CZ11evaEYPQ5Va72
         R32Pc4HbRNRkC5qkOGdE8MLnpD5mQXR5N+FCd9uJghxMzgi9Rq/c8WMRQZzCNvNXCKtC
         J2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823119; x=1784427919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cduHWfRr3cNlL9+U7DXnZtRw2pQyx26+A9+h8FmzaX8=;
        b=iiHXEklipkYFf+Kgfa+NTMqpF0UJuDhfioW9W1wgA1cC7tYy/4QWXnsFKwidnA2+jl
         5g3IukeR8dNR4xjqLVHfgf0o3vaYjdJIJia/sil53ciMVYWCE8c+LvPNgwZsBM9YFxIj
         n7XuHIf9nKRzEEdMARF1YdPBT79e0jjB6sNXJxJyzYttoi3ht/IjZAl5pYB5UMPgwxiT
         yHAVSAQk7A1ZKctZMMBTnbysr6kbtjFfraOHo6KdJ9ySJx8mT4cHq+5CmPpPt40TQaEp
         FgxLf2g+t6R65zGD0zxH6Ax4yt6ZEiU8RVnAujr1cqSh6Ddoc8ETSEyNHgZJCmnC2v5g
         XQ9w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+iRu912oz5Oy/DrsammMLEBGK0iFMfovnZSyywH55Lf0bwDtbHTBedxKks7wjVnRoVNZ8mrjzafwF@lists.infradead.org
X-Gm-Message-State: AOJu0Ywh/SOP/JW7x32yf5r84Pn67gqSuDH8f0ByN910jqoXueCPXxFp
	DasT/sPJiyQTmS4Ba5bT6SD9BLUpdPSeYVdFup4W8Cb72nL7Ri3IASESA40HJinOMtzOdPar2l0
	1I5Bl
X-Gm-Gg: AfdE7cmVZpWKYho+lZsNE72AOsUfF4FXnqtx0qQtPjT90b5cab5K8TgavceOZMy11xw
	Y3YGPMAy9vWp/xIiWOFLkcWmUwKWWPz08B8sSFpeUnyPbNNQJYfKA4/CFkOmc+sEAufQHfyK6eP
	JMIhWjXo6Pd/EqyVXhiQTUUNyliOf6c5CGiOmv5ncg/GWvx2TwYBDWi7JhDHliejg5kPciQLCYT
	XEyoj8At1deenoaNaxfpdB+5RpCs/Kmy4ldAbLPntMMY5Uk/GouuxzwLjxAwit7l7h1tI9UhnmE
	RcZtMT6etWM+b/nwnqFo4Ksd42K3UMWgyxkIXDr7qxuOw5IJgoZIux4/CYv9bszbRdllDDmH9OR
	aDUZM0QOMfLDm4oR17pQ7W8W8F0+fdqmSEf9bHbo3Smj8m01voeIJ0b944HPGijsD1XAdqYqXLe
	Zv9Lc+W4dsp5v/y2w=
X-Received: by 2002:a17:90b:2d4d:b0:37f:9cdf:f037 with SMTP id 98e67ed59e1d1-38dc7b3f828mr4594731a91.26.1783823119410;
        Sat, 11 Jul 2026 19:25:19 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:18 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 02/16] nvmet/debugfs: Export controller CIU and CIRN via debugfs
Date: Sat, 11 Jul 2026 19:23:23 -0700
Message-ID: <20260712022437.3743117-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192520_602931_AF551E8A 
X-CRM114-Status: GOOD (  11.01  )
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

Export ctrl->ciu and ctrl->cirn as debugfs files under controller
debugfs directory.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/debugfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e85fe1d4c9f8..4de460879d0b 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -152,6 +152,23 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
 }
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
 #endif
+static int nvmet_ctrl_instance_ciu_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%02x\n", ctrl->ciu);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_ciu);
+
+static int nvmet_ctrl_instance_cirn_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%016llx\n", ctrl->cirn);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_cirn);
 
 static const char *const nvmet_pr_type_names[] = {
 	[NVME_PR_WRITE_EXCLUSIVE]		= "write_exclusive",
@@ -287,6 +304,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 	debugfs_create_file("tls_key", S_IRUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_tls_key_fops);
 #endif
+	debugfs_create_file("ciu", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_ciu_fops);
+	debugfs_create_file("cirn", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_cirn_fops);
 	return 0;
 }
 
-- 
2.54.0


