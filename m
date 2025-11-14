Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B328CD4F49
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 04:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uTJF2IVWNkJM1mmfSKdon1mXIee2k3r0B/i/GeCmrds=; b=kJL/tWWpSA/SXY+z5s9awnSofO
	ePNffjDdWTCyedZTyNrCvmdmTu6KMmSrLGNKX8j4t4ok+ykknjAIoSmT6UXtA/xcKMLue5UXwAgba
	F9nfcwvyjZSWtpP6HPRhbwReDAqGcEAS/pAdRGKx92VcS/GtUJzc152a9sP2J5rZMFFbc7x3Y9j5P
	rvcK1nB2tuUB97ukuXWsr1pIqDnDZTdVSQFEsuHNvcWj7DKf/deZ8NGwxFY69/r+CYhbuuCoqUI/d
	vZwoFQ4hWq9ADPAi9D93k9NEW+SRoDCfuK+GlHckAhfgIjlUCQm0+VkCM8DCebVv9KqfssBxkFTPA
	CIPUwB0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJltz-0000000BZIB-3blP;
	Fri, 14 Nov 2025 04:59:15 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJltx-0000000BZHj-1gKK
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 04:59:14 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7b9387df58cso1895139b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 20:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763096352; x=1763701152; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTJF2IVWNkJM1mmfSKdon1mXIee2k3r0B/i/GeCmrds=;
        b=ZZxG+vuL+i7OqfvsWBnKSqRgA9rQxIqTLX+QICxiTskG/eY44kecoVQRC3ZQi0wkRI
         Wz8lZIHoSzIYVplipVO0inL5bROSfFwiaDh1Dm+7kSWaYBaX+laEkXh+7HMxzNBCuMbL
         P/QYNuU0T5zyZY5m6udr75xeToTnMZPK8+XWIr80pHSFx+nn9y6k5uzZzNzDXL8Vzypw
         afgJ9ETwPTcl+seqOdze9XrzaedcOyAHYcM+XwJGeNOGzmj6zlxBQT8YSu86F7bFnfd8
         qUF41xquB5BUmGLx1iLKzNLleTl5XmtDGB1u4LjyUfQccHusuqyscn7OQjKg3af9leGI
         0dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763096352; x=1763701152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTJF2IVWNkJM1mmfSKdon1mXIee2k3r0B/i/GeCmrds=;
        b=L7lznY0CHx1cZe4s216RrOoQPq/zX0KZVx9tFOTOdL9itzbcXN4ZZJWFRlwDqXYJFH
         DixJEcMkRsXmNEQx49b6QjUJ5F+WMT+gFeWzpw5idA6M5sdFGEaBGxdQlc1t8QvhL3y6
         LgLkL/eDa6fI+diCS2Pqde47HxubZcb+krlMsDbaLvA1uwFwskS3dY1TZfoFcPT6HUyk
         Nc3lC/3iBLWTmG/p4oDlX7hPOWZCfVAQ+9Kla3ZasMukSrCiFLjfiXzDI5AfQyCeg4tz
         W6FaXUUPCpDhf1lXkEbg5eR+qplUSPD/brFYH1OW5/59GO8/ueKzlPPouj1I9nEnx3tk
         I+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW1XhBrcOE6+WY1w2kXiE9quWthqk0UE9jUOo3UNY8iMzkoqTmG0IK15DLOJxJ8KF9t8xPuoj2XIUb@lists.infradead.org
X-Gm-Message-State: AOJu0YyxLHacPbxxnCe+MAyFVukiP+xHecA0GQUiDkjrJ7FQWMIdBv+D
	ZNeGiPAF8Sid9fecnzcn+/DlCJHlBbx+8zXcrnUdjl0BJUrLG9o3qI/Z
X-Gm-Gg: ASbGncsz6IgRAvpXGgKu9sorUBy8efFPWE61u8FMszMNVbyVK3G928y9YtFfviYJk8R
	2HgqJPLtXkuSdPgMuV5W86a4H+KCAI+Xmpz9oS7QwM76qSo6ArhOHY68mupEnAXEWmd4eqykosD
	S9AlLx6DSRfmAB13KY9z4O5lzZcCdnsZjedqSDXHHvvM7GMGr+bGFt4Zebkc7p9Obqu9e11VlUx
	+hjtUXaHQHB4GPQAkUyDoZN9j/sGQKnd7O5JOyAf0uV4JlpSD3JVhev/d2g3rPxI2JHbT92T+GD
	ARyX6sx/rtM74LW5IfCJa9BsnpsBQ+8x2aT4MUKUCA/gRscfMKUp882q9JvNyWX0BEq91UTWt6m
	JSuJq4GMQ1Bak19SKzSF912a1p9bN2r4L/YcLQCJX0UWQ7/dt79c+NLD3XKNH3WtWX5uNRZFHfr
	CSvUWGM3ani/SgU3m1p0uq7dIJ1mXzBTRS+0wTQCaS6jMPY/denD2KhV0YgjELqDcQdfvx5omwT
	6ncFAvt
X-Google-Smtp-Source: AGHT+IEAntUdkPQY8a0mAsRnWToD66UATuULSUdId23rNGk68FT/ii0oMWCJ5N8Rx1g1w8qLx7bScg==
X-Received: by 2002:a05:6a00:4fcf:b0:7b9:d7c2:fdf6 with SMTP id d2e1a72fcca58-7ba3b89ed15mr2763696b3a.24.1763096352471;
        Thu, 13 Nov 2025 20:59:12 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba438bed8csm1061189b3a.53.2025.11.13.20.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 20:59:11 -0800 (PST)
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
Subject: [PATCH v3 0/4] Support PSK reauthentication (REPLACETLSPSK)
Date: Fri, 14 Nov 2025 14:58:46 +1000
Message-ID: <20251114045850.1898865-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_205913_439653_DD9F35A9 
X-CRM114-Status: GOOD (  12.13  )
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

Allow userspace on the host to trigger a reauth (REPLACETLSPSK) from
sysfs. This will replace the PSK for the admin queue when using
a secure concat connection.

This can be done by writing 0 to the `tls_configured_key` sysfs file,
for example something like this

```shell
echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
```

`tls_configured_key` will only appear for concat connections as that is
all that is supported.

Reading `tls_configured_key` will return the current configured key, which
changes after each REPLACETLSPSK operation.

This series also include some fixes for the NVMe target code to ensure
this works against a Linux NVMe target.

v3:
 - Only trigger if a 0 is written to `tls_configured_key`
 - Add documentation

Alistair Francis (4):
  nvmet-tcp: Don't error if TLS is enabed on a reset
  nvmet-tcp: Don't free SQ on authentication success
  nvme: Expose the tls_configured sysfs for secure concat connections
  nvme: Allow reauth from sysfs

 Documentation/ABI/testing/sysfs-nvme   | 13 ++++++++++
 drivers/nvme/host/sysfs.c              | 36 ++++++++++++++++++++++++--
 drivers/nvme/target/auth.c             |  4 +--
 drivers/nvme/target/core.c             |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 12 ++++-----
 drivers/nvme/target/nvmet.h            |  4 +--
 6 files changed, 58 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvme

-- 
2.51.1


