Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACCA10F9951
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JXquXHfXoPBP/lCff7/vAFbluRTl5qqCWMOksHxZuTQ=; b=l9mFw+TY7Ovoq9kd49WK5Y6EZa
	epq/1wot1coLbdK+56cELZ/AEDGRRillBCRJmrgOSTb1FGQzmi5I/MAneV5LmrVhYVPRXF9xzzzgK
	CxM/s871l4dxGgFuzKRV4QPG5/2tN0RPr2DJctXOh9uxUmovLy/7InOC5b8Zp38OcDAbwW4Cc8PuB
	GAFsp0zErtCoHmCL2+9uyDYwRLF0q34qURyYEpy3W6srblF84apdE9X+WlLv/qYK3EWCzcx5yEHFW
	3e/v4+yS6cFcGLUZqNwhrAPCgfR+N3UN/Kbrw/eJvEpBk+SW+Vm3v79UMfzh+J0JoT/e1YqC4yqzT
	+sVWNheg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAV1K-000000094Gt-0Mc6;
	Wed, 08 Apr 2026 15:40:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAV1H-000000094GX-2eI1
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 15:40:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 72B3C40E3D;
	Wed,  8 Apr 2026 15:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D750DC19421;
	Wed,  8 Apr 2026 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775662842;
	bh=T9eENRx8Vijbe7VUHRlA1HqOoKCLopgkVYMPovhYkEk=;
	h=From:Date:Subject:To:Cc:From;
	b=J8Bl87ZXTVzinTe4F9I1YLDGR9c95zdz64PSQfZXbLyZskTQg/XFGkPq8LCFqxdYB
	 zLD/VG/6wQ1T3Is2a0MQVjwneF0pFXabtiQB4hddbGR1JVYD1t+yGnUWCvy9BLfYbf
	 JdNXM0y60fxM8vu5l31V07t4ZsQkjbt8DqmevGnGHHThztB2+OGgsXc3PBF+UN5ogQ
	 aK8iUYXxyyrG2MY+h1yY88pAfLXHGfzqd0Aa4uxqHO2G4S0e5jlHehshXSTt9JaiC3
	 wpwsi1j+XLqKQx+rpymrZrkK4NjVf1MG9m5YcmzPi1Bx7GGZM93HUDv8i9zywoWWy8
	 NrrTxRFKfLwag==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 08 Apr 2026 17:40:36 +0200
Subject: [PATCH v2] nvme: expose TLS mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-expose-tls-mode-v2-1-17a25aa414dc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNSw6CQBAFr0J6bZv5YdSV9zAsgG5gFBkyjQRDu
 LuAa5eV1Ks3g3D0LHBNZog8evGhW8EcEiibvKsZPa0MRpmTckojT30QxqEVfAVi1KqiIiWXXsj
 BuuojV37ai/fsx/IuHlwOW2YzGi9DiJ/9ctSb978+atTorM3PljQZW92eHDtujyHWkC3L8gVWN
 zzowQAAAA==
X-Change-ID: 20260401-expose-tls-mode-10fdb5d459d4
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.15.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_084043_724862_79C8A591 
X-CRM114-Status: GOOD (  15.71  )
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
As Hannes suggested, tls_mode is only visible when either --concat or --tls is
used. This avoids the 'none' string. 

Original cover letter (with fixed example):

I am extending the test suite for nvme-cli to cover the use case of
nvme connect --tls/--concat.

Currently, nvme-cli uses heuristics to determine whether --tls was used
to initiate the connection. With the introduction of --concat, these
heuristics are no longer reliable.

By exposing the TLS mode explicitly, nvme config can now generate a
configuration based on the currently active connection.

$ nvme connect --transport tcp --traddr 192.168.30.30 --trsvcid 4420  \
  		--hostnqn nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36  \
		--nqn nqn.io-1 --concat  \
		--dhchap-secret=DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:   \
		--dump-config --output-format json
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
            "concat":true
          }
        ]
      }
    ]
  }
]

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
            "concat":true
          }
        ]
      }
    ]
  }
]

$ cat /sys/class/nvme-fabrics/ctl/nvme1/tls_mode
concat
---
Changes in v2:
- fixed the example output
- tls_mode only visible when either tls or concat is enabled. avoids 'none'
- Link to v1: https://patch.msgid.link/20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org
---
 drivers/nvme/host/sysfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 16c6fea4b2db..6590777ed71f 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -841,10 +841,26 @@ static ssize_t tls_keyring_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tls_keyring);
 
+static ssize_t tls_mode_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	const char *mode;
+
+	if (ctrl->opts->tls)
+		mode = "tls";
+	else
+		mode = "concat";
+
+	return sysfs_emit(buf, "%s\n", mode);
+}
+static DEVICE_ATTR_RO(tls_mode);
+
 static struct attribute *nvme_tls_attrs[] = {
 	&dev_attr_tls_key.attr,
 	&dev_attr_tls_configured_key.attr,
 	&dev_attr_tls_keyring.attr,
+	&dev_attr_tls_mode.attr,
 	NULL,
 };
 
@@ -866,6 +882,9 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_tls_keyring.attr &&
 	    !ctrl->opts->keyring)
 		return 0;
+	if (a == &dev_attr_tls_mode.attr &&
+	    !ctrl->opts->tls_key && !ctrl->opts->concat)
+		return 0;
 
 	return a->mode;
 }

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260401-expose-tls-mode-10fdb5d459d4

Best regards,
--  
Daniel Wagner <wagi@kernel.org>


