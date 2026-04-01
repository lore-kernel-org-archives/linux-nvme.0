Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9B6D3515E
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PFWn93mjGKI7065FWn+8So2rCr/QqXT8/fziEYcNedk=; b=pGX8VDHRqWcXuLWVJc6kNklNRt
	EeTTdpP6XPmRhOJfYe8mQUvZbWlPLs0pf7wRC/OF2G3B/KfAzv/CHtRkKidz7LKDgzsc2gszz8faE
	JvjKiD+UbGjIU/tdS0nyKmo4uxhlFkJvABBDmB8PcXthUkmaoOtt3nQWiQOuNGx3P3/EzHB9UCrai
	L1LsUyoDKXM500e1u5TdbOZ9/5+v4CknM2/94m2hurkO7LqKb0YSUxxA5fzc1q8P1uGGXexlNSTA3
	O0RcDrIYkZwOr2kB6CR1jS4I/DHrzr8VTD7BoDTBcxce3YYWzDexCKbl6bRfLUbzImpknMhbPI+Sp
	BtH6q4/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7rIz-0000000ELbe-3eac;
	Wed, 01 Apr 2026 08:52:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7rIy-0000000ELbX-1fc3
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 08:52:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 747AC60126;
	Wed,  1 Apr 2026 08:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0234C4CEF7;
	Wed,  1 Apr 2026 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775033523;
	bh=FSHI5hR9y0B9Sh3PJSzsEZKz+BHAZYb6D7dcWb10y0M=;
	h=From:Date:Subject:To:Cc:From;
	b=iIjumVr1TmxKYFnAn+EpHkaMSm/Tk8vaAmtv44l21hWB3XcgbNiIrfC+Nm6pLfcB4
	 tJ/QiGDKnU0g7fdvcaQDaUekhvmfzYi/i5R9pivEMwLCgSz8qOQpIGFlUoV1BheHzh
	 uNdkt5FofBGUGzQPmLWLxiFJ715zdDA0rj6SP+3UCQqGu362jwh21DcHXSyJyA8ghM
	 99a4XY4QQSPwdL+szmjEX+m927PaWUbaDrpGRB5ggeBbHnyWTiiKJYZlKLwLO7ZrCL
	 90iT+3qtAviLF20QqylOSAIeuwnoWVRgh8KRI+lt58qhqAwNEC2kH87vp1Wp5sF1ok
	 37djkgiglUZLA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 01 Apr 2026 10:52:00 +0200
Subject: [PATCH] nvme: expose TLS mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrB1IJArtVUoX1fm1U1ojGVsE8
 e6muvwW761kSAqja7FSwk9N45jhy4K652McwCrZVLmqccF5xjJFA89v408UsHe9tLWE+iKBcjU
 l9Locx9v9tH3bF7r5v6Ft2wFZrpE0cwAAAA==
X-Change-ID: 20260401-expose-tls-mode-10fdb5d459d4
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.15.1
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

It is not possible to determine the active TLS mode from the
presence or absence of sysfs attributes like tls_key,
tls_configured_key, or dhchap_secret.

With the introduction of the concat mode and optional DH-CHAP
authentication, different configurations can result in identical
sysfs state. This makes user space detection unreliable.

Expose the TLS mode explicitly to allow user space to
unambiguously identify the active configuration and avoid
fragile heuristics in nvme-cli.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
I am extending the test suite for nvme-cli to cover the use case of
nvme connect --tls/--concat.

Currently, nvme-cli uses heuristics to determine whether --tls was used
to initiate the connection. With the introduction of --concat, these
heuristics are no longer reliable.

By exposing the TLS mode explicitly, nvme config can now generate a
configuration based on the currently active connection.

$ nvme config --scan --dump --output-format json /dev/nvme1
[
  {
    "hostnqn":"nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36",
    "hostid":"befdec4c-2234-11b2-a85c-ca77c773af36",
    "dhchap_key":"DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:",
    "subsystems":[
      {
        "nqn":"nqn.io-1",
        "ports":[
          {
            "transport":"tcp",
            "traddr":"192.168.30.30",
            "trsvcid":"4420",
            "dhchap_key":"DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:",
            "dhchap_ctrl_key":"DHHC-1:01:uTcIEwLZsEoVJucx7sKVvzfwOTAfJ9ZGcvYWswHwF41mMSW1:",
            "tls":true,
            "keyring":".nvme"
          }
        ]
      }
    ]
  }
]
---
 drivers/nvme/host/sysfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 16c6fea4b2db..c4b5241371d6 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -810,6 +810,23 @@ const struct attribute_group nvme_dev_attrs_group = {
 EXPORT_SYMBOL_GPL(nvme_dev_attrs_group);
 
 #ifdef CONFIG_NVME_TCP_TLS
+static ssize_t tls_mode_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	const char *mode;
+
+	if (ctrl->opts->tls)
+		mode = "tls";
+	else if (ctrl->opts->concat)
+		mode = "concat";
+	else
+		mode = "none";
+
+	return sysfs_emit(buf, "%s\n", mode);
+}
+static DEVICE_ATTR_RO(tls_mode);
+
 static ssize_t tls_key_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -845,6 +862,7 @@ static struct attribute *nvme_tls_attrs[] = {
 	&dev_attr_tls_key.attr,
 	&dev_attr_tls_configured_key.attr,
 	&dev_attr_tls_keyring.attr,
+	&dev_attr_tls_mode.attr,
 	NULL,
 };
 

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260401-expose-tls-mode-10fdb5d459d4

Best regards,
--  
Daniel Wagner <wagi@kernel.org>


