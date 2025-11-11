Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF450CCFA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 23:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yHl8WC+Yx5kDN/c9d1A4NEdS4ms45YXejq9GQUU7yOM=; b=G4+m24aME8eGfwlDoNBFm3N2Nc
	p4+0/azvEbvItzOgG+xd86E1wnJBJffTpYM6UCTw6tfHNMSyfywrFWW69CzFBnMw10HTp/Yd+Hrxb
	GO5b9r/eacY6mM7TOmGG51yD1etNYD7uQ/xhLNUhwdMQi7ScLYj98Sani41vImjNcSYjnJW4yEFyC
	xBJSjXwBNTUVXjbGlsv1QaZuT9irnGMPJ8W/eZzFSpbh2JI/rhH4bvgpAK6kqsMnRF2a4ZcaRrtQS
	1Lak9/jZRETP3NKF/214liNQ4khQ1AdRzqqWMrDCx8e+kQuR8mSxQybGJ4AdOaGW7J7rPdBP0/JKC
	1JjY2Sfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3N-00000007tNG-1SVu;
	Tue, 11 Nov 2025 23:45:37 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3L-00000007tMm-1VZt
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 23:45:36 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso292958b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 15:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904734; x=1763509534; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHl8WC+Yx5kDN/c9d1A4NEdS4ms45YXejq9GQUU7yOM=;
        b=WOyfcSJ2eAws8D41CLj7BzjcAHrBwB99hjLzKvUKYAzm8Lk5+4h31vN39YUnCl6gi4
         KgQNMdfQhaUYn8B9V9Si622h6dekyq31pS2sNEiIfmpxLO0hvH7NnIVEU8L4Q6wo/SFp
         lN5GcEKBfpqFfbi4pdtWmHL9vQLlT8cyEaiQyAueCcojjMACplGfeqqIKsw+tMQKyQYN
         R3eWIhGtAa53aqIQH+5ToStOjvdN6oJ7XiNp2Ib1YVygGeQ4k24A/HhvJS3B3TXpHQLZ
         dfMsUYSWvpBWKn0yWUoTrsLEj+as1e8IcAW2770A5E7WklrbV6HjT1iM0OTERiXfhlgz
         MP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904734; x=1763509534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHl8WC+Yx5kDN/c9d1A4NEdS4ms45YXejq9GQUU7yOM=;
        b=pXqmYIIXENdQLeFCAYKMJ89nhl8TQsBFhpQckRSwMSMrRT1wUr++L6pY4YoVC5zv3w
         B4bWpygbk7f8RjowxGfYAn5IzmeiQr7J2g47I9bZKmgiw5/SkR/dv0JsF0EuTifdmoK3
         eFN7BglteYpw7PDvAukAXIEoEqka7166HMMJUGVzUwiSqx/owXn6V13VqWCOD2LWuMxG
         Gvi+oT7CjDQLYROveXfcX44QGMFyVGCZmIto3Ufq3HSsoAVhbSGlSrN2CbbbgUVgVKfk
         sgH4RghSzfzH0SXO/zPntqKV+zUVK/9hXjdoiu5TmxvX+3AYrw1fZW0iooCkgJV4zK4p
         vbUw==
X-Forwarded-Encrypted: i=1; AJvYcCVjeTdTRLrclvOLn8PgxIHoPSx2vFdXqap4dl8w8D72aS2cguiTUGmWLqzxjL0vMrI5f6ObvLT8/JwO@lists.infradead.org
X-Gm-Message-State: AOJu0Ywx1P9o7sPuFcPsFeaj3etA+xHUiOa4pqISp0T5zAzWxWoN3fbe
	soZaSBXA9XmpTaUtQGufOqFDXLtcucL3gFygYrjM1KR8QI7Ckhemh59D
X-Gm-Gg: ASbGncsIKugLXHUCSTFPVPR6G34JVQn4rbBJZ+oE4RnE3dKysje1kXsTz6noVugNrlg
	pR+Uam/dzszm9+Gx/IOU2XcJLHCAZytoSvdy5PvuaYbIH6qAYSO38JmKbcLtNb2FJutmTOI3ILl
	Nz/jbkUz2HplIpktqUE48r1puqg4p17UB04spjAu6VxcJxqcCzyYDslryLgWwdjjzduSpF3ZTPY
	tDxzVCd+gT9RBjwi9eJto2PskLSrVNNr26WE9NAHUaAR/p9396k7vuJ64knFPk+mjwDxR0E05wm
	PvEba+DIp4rMSkuXTBcCqZTwbbV/e8QvDPCB7V0jGu+uAyHG6mMz81jh9t6ICWeblN3BaDs3l97
	FQ8sSgF7MpWClSwDg7O9baqhkb0ffsQlpAigk0xNUokcV+m1kte1AdcwZYppAmWIWiKvrd8mprl
	4JjcVh8njpv/4CwgZXlg3+htOGmY1isX3dVKQ7k2hp3hhPtyYVgFtGFVsqynVJnWyzNn9crfzDc
	gv8Ep+m0A==
X-Google-Smtp-Source: AGHT+IG1kqKUqOrjRrapu7xdbjn5g0ilcKHbFQIZ+IaVNxqvrqQimzUwNTVK+gdDH2VrNT0zNKduXg==
X-Received: by 2002:a05:6a21:339c:b0:341:d537:f8bf with SMTP id adf61e73a8af0-3590b40c13cmr1157218637.38.1762904734481;
        Tue, 11 Nov 2025 15:45:34 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:33 -0800 (PST)
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
Subject: [PATCH v2 0/4] Support PSK reauthentication (REPLACETLSPSK)
Date: Wed, 12 Nov 2025 09:45:14 +1000
Message-ID: <20251111234519.3467440-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_154535_443975_6AEA40DC 
X-CRM114-Status: GOOD (  12.38  )
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

This can be done by writing anything to the `tls_configured_key` sysfs file,
for example something like this

```shell
echo 1 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
```

`tls_configured_key` will only appear for concat connections as that is
all that is supported.

Reading `tls_configured_key` will return the current configured key, which
changes after each REPLACETLSPSK operation.

This series also include some fixes for the NVMe target code to ensure
this works against a Linux NVMe target.

Alistair Francis (4):
  nvmet-tcp: Don't error if TLS is enabed on a reset
  nvmet-tcp: Don't free SQ on authentication success
  nvme: Expose the tls_configured sysfs for secure concat connections
  nvme: Allow reauth from sysfs

 drivers/nvme/host/sysfs.c              | 25 +++++++++++++++++++++++--
 drivers/nvme/target/auth.c             |  4 ++--
 drivers/nvme/target/core.c             |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 12 ++++++------
 drivers/nvme/target/nvmet.h            |  4 ++--
 5 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.51.1


