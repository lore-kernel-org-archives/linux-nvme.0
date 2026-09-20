Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EA5C982DA
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVQz5nhnRw3JFcVZi/bpaRY30mlHvfzPq9aZRP4f2wk=; b=WEBV0PSG9R9bvN6s7DF1Rm9Yvh
	23CEPnMwWGi20IaDtifOOhXnLTraCpk5sT3X73o6MmJjK/iJ1gRmyWQsH7I1SFBvqOo6OwOXJIG56
	/ky7mXTar8we48yQXGmeQ8/i74OHX4IutFSWqavYBQiot5wNqd1IvsPSaZwTsHARnhlZHATLlkuxm
	DgjEopStgd72lGvwzwZInZHMqwdIRlE2a6vUF8xSj3rcywQQchoNPPbNG/Ao+MKBbB8zCVgghDSKw
	PjoxXJAkw+rPQ4LrB7NUZCRviP4XxDFa6k1o+aNoM6OXfqddW5TkVl2PASBOqJOG9xFZOhbKf1U4A
	mQ/aYTKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MIx-00000000DkN-1ubo;
	Sun, 20 Sep 2026 18:30:23 +0000
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MIt-00000000Di1-1U9Y
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:20 +0000
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso2338295a91.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929018; x=1790533818; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVQz5nhnRw3JFcVZi/bpaRY30mlHvfzPq9aZRP4f2wk=;
        b=Gj1pkuCfI+VRV5NiGIlLKsdcFzC44tHAlIN8HpAV6Zrs8FmiXNlfDlo4u85C6Zg3Sb
         ZZXRvepppczHtzUHqjCTpwDSySCaArkgeuYUwrvthXllbN0hVtNJtiHr6h02DF3oDt4p
         Y+JmArQmvaQXpGFiYpSSLa5jjK3oc657Fw8mko+np2x7VBpabQz45b9qtC2THcsOBq1x
         QH+oiBcJAHUy/XWe5PxDbn91tN9HqxSApILchNKO+sCKWiU1wlVdOvvDwwH27PManXoY
         h0W71yqIX6wMVBoRdoWxtvj5/WUoadiYVY2QIo862Rn7StM/i78/cJZudo3UJNUb3iMR
         bFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929018; x=1790533818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dVQz5nhnRw3JFcVZi/bpaRY30mlHvfzPq9aZRP4f2wk=;
        b=GMn9rzDx3wYd+IiMZ9DTeXPK2TGBretFfKlCxfJXm3hpOsgP1xKwETv9RQe04HrvHC
         TDSPhwha1g9+O/6rYi2qyJI5Z/bhRdKg2Hlh40bIki1DD/IXQEeyes6SxO4sZiSDlhQv
         17/pk4i8GIxKhTmyPMcPXqbl9Fqc74jy3KqW4ix8Q6GY6VpFEVjCACTMQxjVRsEW9Fpy
         K42iKsglZvCbvLegv2woUEgdQl9zXdhh1F91uECg42DjTuICdyo6K2c7+PKTzDLvRzC5
         X4UlGFVRcetUdzqYzocN4JCF8TEJkmGBlXzgdChdx1CY5Os3TT65BEGeRQqwSx/JvHAg
         ARxg==
X-Forwarded-Encrypted: i=1; AKwUvBwdBEcF9cbcsSIMqtVvSmKpeSxbZBhcUfCq2/xqYkAPo8P9+fY67oFpUvVBPdyZyaZeO2be09fasBE2@lists.infradead.org
X-Gm-Message-State: AFuF++m9hAS7KqoEPj3MJx8DCKwdfzDtnzCwpjpuWlLKjmxba/YJjI06
	0fyYmaWj/BYaH+KNWN0fB6+7mNpWnf8EHP2fqY/EWlv4UGNuNg3k4LHjjaGRgl0JmD8=
X-Gm-Gg: AYBFou1mZ4GKb3vO8hShgnBwMQPE0OZpS7ufPgFqYS04VD6ZGAF9ZmcYOs893Q+N7f6
	VpJhade+z+oTNoRd+JDIvsni6WV5iLKga3MCfqPVR+cfi7QXcTu5MXhnr5NQui2gURP9eiTi+PI
	5tm8X+ioH5AQzgjRyDCjCaebGKrbSGx6ZcDROQOq3fshbtVSqvVHtvY0falo46zAkyzq9x9HPDJ
	HTnEhNBEbGu3vzwVey8yS1u3BHvJZy0a/pc2jxvbi1DJut27AiRXt1qtEieG9+Zwy6yn8GiNRsA
	S5qrvsisdJ9p5Sv5FTMq12CNkT5JrRGX78cXG5RYByDOoUSFKTT0ln30mMRZOxp00eIRDDJ+Hqs
	0UjEgVgvPRMXXJ+/mn8/Wui3Hz5H/laO+s6Is6wl/xOi0N+ZLJHgSmlXvmOffS0Eal5Qz1qb2jZ
	d5flrkxVFsRlaVbwpmKHPJGRG6T+eLZxJYEBzq8wr9QQFNdCepZbu8/SOA
X-Received: by 2002:a17:90a:1050:b0:39e:6b01:f93c with SMTP id 98e67ed59e1d1-39e6b0213b1mr6419367a91.13.1789929018194;
        Sun, 20 Sep 2026 11:30:18 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:17 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v6 02/18] nvmet/debugfs: Export controller CIU and CIRN via debugfs
Date: Sun, 20 Sep 2026 11:28:00 -0700
Message-ID: <20260920182936.2317916-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113019_406556_CA041E83 
X-CRM114-Status: GOOD (  12.07  )
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
2.55.0


