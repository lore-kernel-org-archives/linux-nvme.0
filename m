Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37883CD4F49
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 04:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bfzmvxt/gmw2349tGAnFjOdfZ+93wga1zw9nPNy4MXM=; b=Gc3qpvQ76iFtxyddLoGQdRGCdy
	ww1oTDA3NRo6eweUPL91Cc81wQs0I/Jxks/O1bBflc+mMelO8cRvdztaMKnOg7QwDi51i7LyUGS8e
	hmUqe6yCSMhZZECvEzm4M0suutYbdj8Ns39HweR1xC17/mumFexxpJw2S7r4ynIXz3kpdawWxQrzS
	Y5SBPcKl7YT7iKpwnwmjMUQpQDxS0+vkQffm+a/7BKUdOQW/2Eu+0MxNr+5UiWoF8dWJe/n/KX+tE
	mDowZfvFh7O4Ae3AaXiXyHhaL5Q5FMhhClCxqH2Mje4uLbah/Vu7IJ3+MlJgFMXLGaj4GX7UEX5C4
	mmm32P6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJluH-0000000BZQb-2abd;
	Fri, 14 Nov 2025 04:59:33 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJluF-0000000BZP2-0k7Q
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 04:59:32 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so974405b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 20:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763096370; x=1763701170; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bfzmvxt/gmw2349tGAnFjOdfZ+93wga1zw9nPNy4MXM=;
        b=i2yJ+M19k4IkqrxFo34spAURQ9z4jhpues34X/DrlY9TRvqzSvb18tgLA8xRGORA/x
         Yy4abYl7W0Wy9Pz91uh1nFLbxYBGZPjJGk43iIGY6IytmNvPT3WvuXiUv3Vdkrt5+TEC
         s+00zyfKd1M6F71pLDfix9iMCjEpncjU/PkxjiDBW9/qRdk4GUSXp0t3U+VmP4e3HctB
         iz0MloqgiwVcboyKmUdfcptfBlOatLYCOfX+6adR0sHTNWU5pPL2XPAaz+3hGXNz0U1k
         jG45ZGZXyIRAAJUEqbmTWc8MlWOYdqbfKnjsy44/Vcq97CYF53jIJ2goA224mWydDTog
         haNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763096370; x=1763701170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bfzmvxt/gmw2349tGAnFjOdfZ+93wga1zw9nPNy4MXM=;
        b=sUUpEZj0MlFucPa7QzZtoAj9gwzGs3Yna1r2TLUmM8fGLMgecun/QdnB3G1fTDRUJk
         Ri7JdogwAcVB5fDk7VZb12OCg54OecmMZh0PEMuZdhkMCtqGg5/3EolJY2fEm1HaLdTG
         RhfpCH4AEFyD6x2HtJHNb7Nc4Q0sd8tC5MihfWl2ovCGXcNzTcDmXTjYgyjNQaT0cXWJ
         csof/tvZi1u9mFRlxip9vOGLOuECv+PfWDyDfBqy9LKwochvcBCnDAaOKGNSYJ2w9hRB
         l34HmeqVHAkc3rMHiSyL/GQFCtTRzIYE4D1al/FLlB8ZGuKsE5bvYlw84rtsMCgxaOfO
         NbKA==
X-Forwarded-Encrypted: i=1; AJvYcCVH9esE1PN6Oxabg4tx8ndQphMQfLQ51IqD9BiBtBGFC9p/TfmzqOD8PGj/pY6b/wVGqE69y0Rddmcb@lists.infradead.org
X-Gm-Message-State: AOJu0YyiQriuPsXkNBFzXeeffLP4WYSdU8VVHLkPPt2Tx5rRj8jbh2EZ
	eKlkZxvrDUigp07yDPhnYmI24lchdaNzUf402K9jukmMlpjGp2GbWN5g
X-Gm-Gg: ASbGncsaziDdTL/isOYjE2JGpYjQre5BWsLSb24AeRja3Zqh+SVO+7TpdQUlYdybpa1
	xcvSfhNTUWeYkq8qI0n5fqQTJwaS2KfQi58Jc13OP+a7V+ljZoihqgNJnQBiRcLVGiq6jHT0Jxc
	FMbB6pxp7BltgpYNO0QozJDAJSThsMz//fockhC7YkTqxl+PU2WX54fNz7+piYfyUpq8jrm5VKa
	hDqaOtf6pdnAhw7P+DXDBPPARku5USBwmiFjuST+P9GjT1ux3Z1hfoUC69roBGYjpIl8mPpMp6A
	9CdkXmiffDs/8Z9vVC0fXgr4agKqmKQ9Il7/+29SC80F4DUGRhPT1pGoLh3UYWpGAaPEVU/EaJu
	mPDurybQ4fz5JRbwrtOkrI8nzJhMUTHZ5i49ZUTxDKdtDkL6qQy2y5GftBMPG16F7aSlLXjfkGt
	4BYwCDqWNEEHZ/8N1RzecjkmCLIto/Y2D6KvFKiO1oy4rEkCDpyAn7fDcEaASu73+kYUa62jXGt
	ORFCL27768uQltmKWc=
X-Google-Smtp-Source: AGHT+IHYxOiVntXwdtqm98FQCjt4LFl8Y6F+Q8OyX8vy/WuUTKNMXkpNTUzXfzCcsTtpGGne/L6IGA==
X-Received: by 2002:a05:6a00:18a9:b0:7a2:7c48:e394 with SMTP id d2e1a72fcca58-7ba379a7b0cmr2019546b3a.0.1763096370323;
        Thu, 13 Nov 2025 20:59:30 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba438bed8csm1061189b3a.53.2025.11.13.20.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 20:59:29 -0800 (PST)
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
Subject: [PATCH v3 4/4] nvme: Allow reauth from sysfs
Date: Fri, 14 Nov 2025 14:58:50 +1000
Message-ID: <20251114045850.1898865-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114045850.1898865-1-alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_205931_219466_293A3CB1 
X-CRM114-Status: GOOD (  18.46  )
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - Only trigger if a 0 is written to `tls_configured_key`
 - Add documentation
v2:
 - Trigger on any value written to `tls_configured_key`

 Documentation/ABI/testing/sysfs-nvme | 13 +++++++++++
 drivers/nvme/host/sysfs.c            | 34 +++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)
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
index 6d10e12136d0..7ff9a5053c3f 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -806,7 +806,39 @@ static ssize_t tls_configured_key_show(struct device *dev,
 
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
+	if (!qid)
+		return -EINVAL;
+
+	if (!ctrl->opts || !ctrl->opts->concat)
+		return -EOPNOTSUPP;
+
+	error = nvme_auth_negotiate(ctrl, 0);
+	if (error < 0)
+		return error;
+
+	error = nvme_auth_wait(ctrl, 0);
+	if (error < 0)
+		return error;
+
+	return count;
+}
+static DEVICE_ATTR_RW(tls_configured_key);
 
 static ssize_t tls_keyring_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
-- 
2.51.1


