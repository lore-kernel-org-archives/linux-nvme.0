Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82E5CFD2F6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 05:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkfzFCqvKfKCOi7aU1lQGP/DDPeaMGwVzW+1nIy6MqE=; b=xCPIMbxtVj7bd5V8y4KGZ1MwAK
	Uf4KzzT+lCr9kl8T4eMbwvJzMMIztco+Dz7rkfVuT64Skm6gAoI2x4xCAzyx6LnSAprUJpXHaVhCQ
	a9lzMQdGxV73j9HH2gIcbu5NM0vrVM1mtYhfVdrNHs137CoCj60s1xO9QwQ2ummMPmLayTBIdOt4l
	SB+3h/KJ/JALxXGcTPH43/hRObpsDQJ3nHdT7BaaGkfX+r1yA6vfQ8OsiTaDwqspq/JoXPZG4QouO
	4ysyc3XM5as/Ob5XIW6NKZT7NlasXk1SmenOUvkoVCk5xyF63YuAqRTgTJVYDm8uV45JZE90/kXm4
	NH3BONjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQIn2-00000004oyJ-11T0;
	Tue, 02 Dec 2025 05:19:04 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQImz-00000004oxU-3L6Z
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 05:19:03 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso3004047b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 21:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764652741; x=1765257541; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkfzFCqvKfKCOi7aU1lQGP/DDPeaMGwVzW+1nIy6MqE=;
        b=AkIBl0jlZga4n4BjEaaFbPaHh8fgzNyMcO/a0eA/WydTwPBAbt5c5mSqtw/CkPELzQ
         Q1V20zV2rEgvDt/JfqWRNEwZpDCI00AqzQVoyWsh4u4d1FEAPzMcG/2YS7W090hZtDgG
         ThamsblQFCaI+WUH7NMVXN/tpyvmqTuoeeHz4Eu/U0h1lwwj2vjmxos2R++WJjbxd8oc
         94GjOqnbBFU3Y7yY7l6/6urqzktDy8hpYyBk8v5k9Yzx/o3pdBWZDtCbtNQO/3O2lPIK
         7Szz+1yFKjTzvYLesdl+f5F/Enf/zJk9vcofqjGaz1NE+5y5J3NaLlOG4bOYemrUHHi9
         LB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652741; x=1765257541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkfzFCqvKfKCOi7aU1lQGP/DDPeaMGwVzW+1nIy6MqE=;
        b=Gp7FyBRu0+Jq+PbmKN0kHLT8v8u/xA9SIL1Z+S6YBPbQV+O3C8u71T6+GvuWzsQkwB
         JLEoH9gylRKtMzgWiTsfc52yfDheIxezLGEm2MAH8v9ewIrpbdJlobqqDw/MdzbmGJMq
         lyvB0q2GCjiddWHiMaUpVEi7baHv9N91/EctTfdxK7vFZISmPBKsBNrpV592TEmXxjiY
         WHU+VSNw7GoNatpgx67MoVfcaB+dmnLU7NHPEifi5+WEIowVQ2Y4b+gsUnB3BYg3g2Wz
         aaGAuPzZcRobpmPi6CQSsqmVBtRAwr+fSYzJMxg9RJmPwj7wiRHHC99LR0OfkVbgR5eM
         LxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF3SJnZoiyaSHLtil8M2C6Xrgr2iY0crL3nEgSke+ydw7mdX3v0fqrn7kyJ0A1j8GB+ybp834yywtb@lists.infradead.org
X-Gm-Message-State: AOJu0YxkIBSzBuOpkSPUZBwcF+naA9uyQ3xwYrt1IAF9I4wnOWTJB1me
	JADPTzNkdLPPYC3JBG3FKUNPVorN02ikzWIa9JWwIODk4tbCET1RdurH
X-Gm-Gg: ASbGncsu4gNvCgeImiVDfedaaXhnw4JLyzZsJtRTyehKNTEiiOEoN4aVUf+x3p+CumV
	96OTbHUUTVCgG4iKukDBjzlU5XF/t0YV1b4xevJUW05lB9VOm1iff03uMJ0HKe5jj3opcAiYpF0
	E65DqALdiq0pizJAolbbvaCAb1g5smcswMps1vQ0aFyYyZgLPOLkJ04cj/rI0S0pLP3H9XBbVAM
	nho5JGWo8yIWVZqJRRHnJOIrsT6UxluSlHTuKOrD5pP4urZHLp9q429KOtP0HvJhQcPkIyZkBgK
	gWRTqsBP1hhvPSwlBkPWJ6ByzY9vN1P2VgQhU28gS8WTPrJLWc6KWu1WArVJvqtW+X9X8jhBlHY
	e7KsrGOXC0yqJFkrkqdeNbYftKOZHdttf7Zo6qsvCgimsHamFJMsg/Z9ytVlPbK6ji2yE8LZIt7
	tsLrbl2yY68ukk+jkawyf1c42azdU+30/Gc8C9z9CU85vaBfl5VGuXzcusqCV43A5HEJ2JgJ/A5
	+dC9UzspwjJKKmU1wg=
X-Google-Smtp-Source: AGHT+IERkcZpp2jvP5JFdQ9pFXl6f1hLcoZfrE04MFXdv15YE0Uj4+AbGFaC8SWskDuvXuLNzcDTvw==
X-Received: by 2002:a05:6a00:3a17:b0:77e:d2f7:f307 with SMTP id d2e1a72fcca58-7dd75d0a04bmr1615262b3a.9.1764652740923;
        Mon, 01 Dec 2025 21:19:00 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3f79sm15206433b3a.42.2025.12.01.21.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 21:19:00 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 4/4] nvme: Allow reauth from sysfs
Date: Tue,  2 Dec 2025 15:17:55 +1000
Message-ID: <20251202051755.1312158-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202051755.1312158-1-alistair.francis@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_211901_841211_CD9CDDB3 
X-CRM114-Status: GOOD (  21.88  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
This can be done by writing  a zero to the sysfs file.

echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key

In order to use the new keys for the admin queue we call controller
reset. This isn't ideal, but I can't find a simpler way to reset the
admin queue TLS connection.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v4:
 - Forcefully reset the connection
v3:
 - Only trigger if a 0 is written to `tls_configured_key`
 - Add documentation
v2:
 - Trigger on any value written to `tls_configured_key`

 Documentation/ABI/testing/sysfs-nvme | 13 ++++++++
 drivers/nvme/host/sysfs.c            | 44 +++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvme

diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/testing/sysfs-nvme
new file mode 100644
index 000000000000..16aaf0dca9e2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-nvme
@@ -0,0 +1,13 @@
+What:		/sys/devices/virtual/nvme-fabrics/ctl/.../tls_configured_key
+Date:		November 2025
+KernelVersion:	6.19
+Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
+Description:
+		The file is avaliable when using a secure concatanation
+		connection to a NVMe taget. Reading the file will return
+		the serial of the currently negotiated key.
+
+		Writing 0 to the file will trigger a PSK reauthentication
+		(REPLACETLSPSK) with the target. After a reauthentication
+		the value returned by tls_configured_key will be the new
+		serial.
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6d10e12136d0..caf853a0da33 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -806,7 +806,49 @@ static ssize_t tls_configured_key_show(struct device *dev,
 
 	return sysfs_emit(buf, "%08x\n", key_serial(key));
 }
-static DEVICE_ATTR_RO(tls_configured_key);
+
+static ssize_t tls_configured_key_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int error, qid;
+
+	error = kstrtoint(buf, 10, &qid);
+	if (error)
+		return error;
+
+	/*
+	 * We currently only allow userspace to write a `0` indicating
+	 * generate a new key.
+	 */
+	if (qid)
+		return -EINVAL;
+
+	if (!ctrl->opts || !ctrl->opts->concat)
+		return -EOPNOTSUPP;
+
+	error = nvme_auth_negotiate(ctrl, 0);
+	if (error < 0) {
+		nvme_reset_ctrl(ctrl);
+		return error;
+	}
+
+	error = nvme_auth_wait(ctrl, 0);
+	if (error < 0) {
+		nvme_reset_ctrl(ctrl);
+		return error;
+	}
+
+	/*
+	 * We need to reset the TLS connection, so let's just
+	 * reset the controller.
+	 */
+	nvme_reset_ctrl(ctrl);
+
+	return count;
+}
+static DEVICE_ATTR_RW(tls_configured_key);
 
 static ssize_t tls_keyring_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
-- 
2.51.1


