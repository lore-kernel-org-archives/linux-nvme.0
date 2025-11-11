Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C55CCFA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 23:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ku+uUPMeqOTqJ/waoV9S1SGRJDVLJtYE++c1OnVYckI=; b=bHcYrv7d1hAeFicKWqYdCiecoE
	KPWlYurSJSVcJ5fXgAC/NmS4GKXReoCZN3SeUxDwV+79xocAkXlBSGwsKzJ1utInuy/HWT9TzIfNj
	O178YZdYHhRQkYAt8eE/fRXOETPiQXZiBcmyWvG3+pM+I7nbkCyofkSWAiw+RPPwRgt8lsoKVTfPq
	mYJKiYnob978pK+NafPd+bJr0XD6rGf9Pgz3NHdyFRFE4+VGigbTNDlvsJ7C6GmOjOklbCWkH0qyb
	w2CoTa9VGHRK55pExHhULShV64WXOna4Y0cXvrh0kYs4LHohnVJZC3VgoVZTdsfPs3t6pVhEpmlRr
	aZDQefYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3f-00000007tVk-1oCW;
	Tue, 11 Nov 2025 23:45:55 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3c-00000007tTk-3GD6
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 23:45:54 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so356466a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 15:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904752; x=1763509552; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku+uUPMeqOTqJ/waoV9S1SGRJDVLJtYE++c1OnVYckI=;
        b=KUhRhmrYArMdUtX6ObQcf1fBgghXXe4GYxyMgQ4r//TyWEaCA8OmFa1+grO8VEzEBA
         7M8QACw9M7ubjja7XZe+CRZTN/9goiLZ6RJl/sWRf/7C3/vQqYq30WUK910pVBpnqb34
         EC4JebWT7gWjcMjCfQV+Sztcg4sjbvrmfmdDULRt+pInWHQEfdRL32Q0ohETHbcPIzky
         XiCGzUxHDx7eqI87cmVwqTfz4GV9txhb62VMsyZBYeMVqKN87KKVlnIwC2qZ4k7w9N/m
         Y7BhVuk6ZAOV68JwC9/Ni5nYKEW22O3LkEteUcjSBwGJXmY+hESbT9cDwIf1e+p9T5Kt
         HYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904752; x=1763509552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ku+uUPMeqOTqJ/waoV9S1SGRJDVLJtYE++c1OnVYckI=;
        b=cH+YHOxxmMf6CirhWViHAmn3ZP9z0aPYu6JGQ6EUzGRCiSuqXFbKdisicfFZK4ZNBS
         UwuFtUHro4tAgDhLleRSdamBFxMnLIiz1Lc/0/WEP+75ZQZbbYmzB7INDvE1us5p70Yr
         SCEHBcOfaSiSK+YYJ1/jvscZn0Tvf5XCQMbdQntgFEd+veTq5Pjd5H6ja/ACW6EQH3OD
         ze+dAZv49Rm+BwGzUSlJRcpZ14a2YHTYZuljnvWva/xurUJHL+6vjBvosHKamnFojVWr
         to5tzrSswgDb+lOSSG6C9tdY3P4fbDnCQf7IT8EoR2UCnzkT490BDqEWbiNhODOrnjUh
         cHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvf86rRAstPdCZxUOLwYq4HU93JsJnmPpQSO2TLpvX5D3PnOCumpC6DE7dOXMrrhtB48lebcHLUbJF@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3hvC7AdsCSoEIsMtQ4kSLTaSRRiNL1O6HOE3yyB3/4g2Y3gaZ
	M7cDgR9PlkmdTQ0CHmNy9Rf3Wb2iUF15r14Bc7qG+0FY6Z5jNzHRyEaX
X-Gm-Gg: ASbGncvKIafDwH2lJayn5RThA6/UPVCRhClraI+4VN4q3H/UFxp+8iEjqKG0HEuv6Nx
	FDm1L+94E1cnfYto7imvAom7t+9LfZE11L9upaySRd7FQG1tdVw6jubAGRThLPzUu4MsJFYYeXo
	QlzYB/kVJVD4sY/A29R4lY7WOGD8WXPIT5aATy1wcdd5E8U34PybHB9iJyTzaujvNgAWyacpqEM
	hCnItXTV1fYPVL2hVQxLqx8Jazh1pjtf1utYXIeP6ZequdfivVi9FHm4uZlTdqGhp8pZjvi+el5
	EiINNL+zjV56jX1je703wMAQQmgcoyrY5Bn2PQg3cZ59MDxKDAAxic8lXH/6AYZaX0bEmKBRWcZ
	Vlk07i61ZwJ5q3541yPkPWwg6xkVQuZAFLzbM5XJIQVepJ2aPxW2xYhjcdwdc14MCKDtc0OvpHc
	UKsW7j7sHE2j8r+fdrZG4PN/mPQpZiwMI0sd3YgYrZECxtx6xesxux9iR2JibO4Jmb66CnMlsgT
	nlYpcNM4w==
X-Google-Smtp-Source: AGHT+IFt1zGwYGAmAVjS+MJ38BSYObFsBFiqI8Px7FyooYwE/yqV2VYEEU1VfGxit7rguzbRU6nxWw==
X-Received: by 2002:a17:90b:562f:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-343dde8a9c6mr1021769a91.25.1762904752048;
        Tue, 11 Nov 2025 15:45:52 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:51 -0800 (PST)
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
Subject: [PATCH v2 4/4] nvme: Allow reauth from sysfs
Date: Wed, 12 Nov 2025 09:45:18 +1000
Message-ID: <20251111234519.3467440-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111234519.3467440-1-alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_154552_823561_0C47939E 
X-CRM114-Status: GOOD (  11.99  )
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
This can be done by writing to the sysfs file.

echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Trigger on any value written to `tls_configured_key`

 drivers/nvme/host/sysfs.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6d10e12136d0..db1c53e00501 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -806,7 +806,28 @@ static ssize_t tls_configured_key_show(struct device *dev,
 
 	return sysfs_emit(buf, "%08x\n", key_serial(key));
 }
-static DEVICE_ATTR_RO(tls_configured_key);
+
+static ssize_t tls_configured_key_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int error;
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


