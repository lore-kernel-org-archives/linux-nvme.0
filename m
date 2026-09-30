Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E3DCA5FC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B2+iWMe6dPTHkeWevZifHileceuCkFyH8n8hjOnviDQ=; b=ubcWNvhdIoETPLf6tq6QfkHZCD
	TfiSmPnmjok8q9RggTG3m8adNCX7qQnCIglsG61irVhwdgr/ppVzWfm25cvA0sShoucIDM2AAJrQ0
	DKN1LMcYhZmW/HdbBJ8rnjXEFEzLsqUfpqnNS84jVk3SNGytemd1mxqFl/mXahmX729Hq6UCW7aav
	FGkumi9x/jvQlmabmuZ6moDhweKdsG/b0f618IgdWsy/x9wQ7NWf1sCoaM/n0dAvENNm/m6G1WOHP
	xowKio1M+YYt8SyG03Gz/JbgzYwx/t6eK3FibIRkZxgKrVv9OdXhvgPoU8W6WScQos0VMhtbhrdYh
	bRK0wFrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBwN0-00000006Xy5-4A24;
	Wed, 30 Sep 2026 15:37:22 +0000
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBwMy-00000006XxS-02ph
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 15:37:21 +0000
Received: by mail-oi2-x10.google.com with SMTP id 5614622812f47-4b37a36887bso3013946b6e.2
        for <linux-nvme@lists.infradead.org>; Wed, 30 Sep 2026 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790782638; x=1791387438; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B2+iWMe6dPTHkeWevZifHileceuCkFyH8n8hjOnviDQ=;
        b=PSPbL63gqz6simmjFNAK6MRjxssUMMrUJOoAz6cNq9Nk8Gp9lQ5gsmgfPi3oyPMXMp
         t6nM0KoxssYa6zIGnuuq611NF/zrpO2JdzONHbsKFWXwmuDtlFms2QzZKRqa0+0oJjEg
         ThO7WZx/Vcb5tPTm6mdIeQQwZpi02SPH+lOi8ES4awxGpLT4oYkpHp8tSQQW40YFPJOS
         Yd7YUZJA+v7VeXKT4l3DBC/xrOgxXDauldmZ1u5OhnnThst6rbb+iCd/pUImnHXdY8s7
         ek+w9dW80bV2QeVrItbZ9gwJmE7NMs+jFZ2yYltBPRz6P6ma6aXn3799JZI+MakrvHfV
         AE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790782638; x=1791387438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B2+iWMe6dPTHkeWevZifHileceuCkFyH8n8hjOnviDQ=;
        b=ZuuBf7BPCrFczAK8jq+jvTfz5z7qBIOuIXL/NcQ60JGsmz6YhxtpmEJrPxS+zC/knc
         ozzN+0I8F7P0fjaEA92ZwKr+WOBOjekappuxtPdxs9Anx4BMcfpXeW+9qjBocKVwko/p
         lYFuVuH/D2729mMA+E4M5yTICwbW6uHmONY3f5rDgmE3VnJ4IOLW8ZBclH7x1KjdBDzP
         YBqR0fxc9APCBRXkesz4y8187EBpj8EBNZ3olBvFeOXYrp62iZgBV4uJ48lON+A7qXKM
         oKCJJfnHV2RvCphWr2ekMf7SxirwyYcyPqkZTGySFnQQ/MN8fJd66GMIKDV1EqZtxkk0
         Xavw==
X-Gm-Message-State: AFuF++mmJB/2nHBQ8SkG4x1WQuy//0Q/R+Y23DL6fEhcc/9OW9rwwjpt
	dvFq8vT5GwkmFuBoZ1k9p5ZgIYTk37OCbsyzObLUJuIoDl5yYqU/112+cZ2bATJa
X-Gm-Gg: AYBFou3YfC/nq7MAcWigiTvBBx1I/2UpqOGkYoRbPhjnSiBt7xRlLqcStBsdQVFxi14
	ORQqhg/kyJHTk9voVWBBckKQsfS2uBQVMSNJ0KesTfMZ9LRswXEko4MAWk/vmmhhm2sZgI2pym3
	i4RA1SBsltDB67dzrgrreoGZb2MKVSPW60UbTw+uwfJWdr5uhgvumK11y38QTHfT11KYh8GlIPh
	n2qRDk1hGByCnrUXi1paTAyM6TsSZbXGgCIOot63mDFwZyEjRnJL4q9raQsCPxkTUUk/BMInC2n
	8/O/CgI+FmHOZ44UgSkm316UrfV16WH9AbZWDQywnZ6PlvJxuaX4DmXO2YQ0OUGK6LFjy+NW1wT
	IltoWt8cU87xidWBzjgS+4i+dfQTIQ4OsztFx62nPivyPRChR2eaz9unLkVEvxb8LT6EUrdiclq
	VCNUUd4F/df4SOL0hO4faY33Ei/vstEuK5W0gd4z3FR+8CrHGAdUsYdUAs6Bnuj1rYMU6a10rEN
	/8=
X-Received: by 2002:a05:6808:f0a:b0:4d6:92b3:5c8c with SMTP id 5614622812f47-4f1badbebd0mr1848986b6e.66.1790782638205;
        Wed, 30 Sep 2026 08:37:18 -0700 (PDT)
Received: from gooner.hq.netapp.com ([167.103.88.107])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f1b43a602csm1080450b6e.6.2026.09.30.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:37:17 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	loberman@redhat.com,
	Martin George <marting@netapp.com>
Subject: [PATCH] nvme-multipath: report "none" iopolicy for discovery subsystems
Date: Wed, 30 Sep 2026 21:06:58 +0530
Message-ID: <20260930153658.4002-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_083720_059348_AC5D2B9B 
X-CRM114-Status: GOOD (  15.73  )
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

A discovery subsystem never exposes namespaces, so it has no multipath
head and no I/O paths to select between. Nevertheless the per-subsystem
iopolicy attribute is registered unconditionally and reads back the
driver-wide default which is 'numa' for the discovery subsystems too.
This can be misleading as it suggests a path selection policy is in
effect when nothing is ever selected, and writing the attribute silently
mutates state that can never be used.

Report "none" instead for a discovery subsystem, and reject writes
with -EOPNOTSUPP. Report "none" from iopolicies as well, so that the
value read from iopolicy always remains a member of the set advertised
by iopolicies; otherwise userspace validating the current policy
against the available ones would reject its own subsystem.

And while at it, document iopolicies too, which was not covered when it
was added previously.

Signed-off-by: Martin George <marting@netapp.com>
---
 Documentation/ABI/stable/sysfs-nvme | 15 +++++++++++++++
 drivers/nvme/host/multipath.c       | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index a0bb88ca1694..67795a2dd905 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -465,6 +465,21 @@ Description:
 		selections. Only available when CONFIG_NVME_MULTIPATH is
 		enabled.
 
+		A discovery subsystem has no namespaces and hence no I/O
+		paths to select from: reading returns "none" and writing
+		fails with EOPNOTSUPP.
+
+What:		/sys/class/nvme-subsystem/nvme-subsysX/iopolicies
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Laurence Oberman <loberman@redhat.com>
+Description:
+		Shows the I/O path selection policies that may be written
+		to the iopolicy attribute of this subsystem, separated by
+		spaces: "numa round-robin queue-depth". A discovery
+		subsystem accepts no policy at all and reports "none".
+		Only available when CONFIG_NVME_MULTIPATH is enabled.
+
 What:		/sys/class/nvme-subsystem/nvme-subsysX/subsystype
 Date:		September 2021
 KernelVersion:	5.16
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 11871f5f18c2..56ee25b448ad 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1054,6 +1054,10 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
+	/* A discovery subsystem has no namespaces and hence no I/O paths */
+	if (subsys->subtype == NVME_NQN_DISC)
+		return sysfs_emit(buf, "none\n");
+
 	return sysfs_emit(buf, "%s\n",
 			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
@@ -1088,6 +1092,9 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 		container_of(dev, struct nvme_subsystem, dev);
 	int policy;
 
+	if (subsys->subtype == NVME_NQN_DISC)
+		return -EOPNOTSUPP;
+
 	policy = nvme_iopolicy_parse(buf);
 	if (policy < 0)
 		return policy;
@@ -1101,8 +1108,13 @@ SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
 static ssize_t iopolicies_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
 	int i, len = 0;
 
+	if (subsys->subtype == NVME_NQN_DISC)
+		return sysfs_emit(buf, "none\n");
+
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++)
 		len += sysfs_emit_at(buf, len, "%s%s", i ? " " : "",
 				     nvme_iopolicy_names[i]);
-- 
2.43.0


