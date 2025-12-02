Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F789CFD2F6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 05:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qYChLLisF92vMviB8HABTYRPAVQBwrW/Bd2dqCbTO7M=; b=1FLdsFJH9m8/xJDC6qghWrra6W
	ATnpSv0kdK2bXXgqE9B49e2eXVK52JhUCcFMTra1u1QFR30m+fEXote5+nVOm1AObMYhbdAfsmc0+
	su3klZG0NgIIAT3RamC28t44Su5AOp2Gazh83pA1meEGuctJfhxKb1AcSpZp2In/yTMLFN/Hcb/+l
	l5GAW5iCHUixwc5mTCENwe9LQtTRCnL7EeDP2lXpt8NqaBHn4PVyQ0ERGFX+NC1+6Tatnj1NOsj82
	1Ac5a1V/TKRRX6d+a1f3u1vXE3h2UNcSnrxRPbCYyu8YtmqMU6JD3LrIqSAD0MHwCSYBJQLwKTvQy
	TMcO3eMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQImx-00000004owl-3qPp;
	Tue, 02 Dec 2025 05:18:59 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQImv-00000004ouy-2GS3
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 05:18:58 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7ba55660769so4270036b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 21:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764652737; x=1765257537; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYChLLisF92vMviB8HABTYRPAVQBwrW/Bd2dqCbTO7M=;
        b=PKYRhQXW9pP21zt31VHFHLivZTXrCJUztuQ86bI1y6ZN+SJE3akHIvsSdG5unJqjwD
         ACM36H2W5E4Xo0q4OJO6vnh8gWxe90i7EsUr6KeS8qwCdbzKfv/iRBg8kQJqShNYPTQ3
         f+sh0HIrhuo5F5MIOZsJydl+AkFKhZ1Dpedg4i2cUEkaZQU12AY0ValjxquOM8cXl8uz
         V/Kwkd5i+x2ieVi4eZNn4rAtb4OUBEF9pZGpiSFvQCM+VJGMN5DdNDrRrABGupcNBuBD
         QhfSmdIuiIDAfUx9x9vBlFGlJXQFqn0kwFUAmWXqEH/GLfRLKVXDwbUFsX38QKxVHu7E
         Hr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652737; x=1765257537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYChLLisF92vMviB8HABTYRPAVQBwrW/Bd2dqCbTO7M=;
        b=otXSL9uakmqztWbkDyYuT0DDdg3Lcw+4eo86VvzzG+FVjkBf9h7XnZQxOMTODQPBDZ
         HHaMZ0kCOt4G5qc4lRTzvkJtfm+fKsfPVZv7CVRw4Xf7YcdcCZ7X1hs2KfH463RpQxlu
         lGzwvttbSBRxyj4fB4nT/Sv04rwDjcRalw+HBS1chxAdrKYnRwGr12cDBjtNzsECPUgl
         mUP6Mdn9oHJSusHRoa3ZWvY9sJP5fjvkGfWWweT3PRvaYaaepEC4xQeem3I0rACox8nf
         FM6nhF7zLgnEBmSGV6sFetF0+KN4stzYymWeyOU7MX67FUOML5BdSnvfIsMs9d9aZcro
         4Haw==
X-Forwarded-Encrypted: i=1; AJvYcCWLv5njw2Jp4qiJtUrRqjvwMEDA1KUj6BsLW8/3Uoieood99vcErj5mKPJtjtBVUs4KX9Plq8o4+kJm@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+/NYypWPscvjjHPWN54gkgKkYNBMDfnKBpR137pp2I5C5gyXj
	vBFBq1qV0k4wp2eS9L88lOt8U5GxGifu6fpXLWdn3GE/pTdvTZ+e0HA/
X-Gm-Gg: ASbGnctYln3Zm+sBai7Xy65Ekl1oXHlbjBxqKEy2QAcHIGgjM8xxyzGmv9cLzyx7Lfq
	dT8nxir+WzdrMwQmW9/EssfDiferiJ4MP3IfmPbjKjUhVTrn/kcFwCNuUznDfa8yiQtdk87d1cx
	YeoH5K8irQii9R3NHc7Jqt6OUXVqqlT9UphBVX5k3vUNnscJpk015CBpdFvbrfSRsO5ORB6D6ma
	WB9ohdT2N7d4YsghepMIwfWeNkT5gqpYFN5UFHSR8vlmKd+49M5ygWYSeq0EcsIeq8j4Owq/I3o
	ChGV9DoG3AnZGXe/nLztGIBRiqK6+tjkac8duGrva2F2vSxD1grwvkw/l6A0Z9uBX6g+TXBcXm9
	BIUSNmUO+PJBaOXx/8HKuk7Y2xHjFqVVcOYsVnfyLUzNv7msiQPzRHfOxZh8xYdVqpojMiWd+7/
	TZGpsJ6v/n6310pEmVOjNBma0dBPGWKFd4qQw/QleyDpgyTA2yv1Dn+4yb5sMsUCf/y1GosKY8i
	YC+fTqJOjJqmEHz3Lc=
X-Google-Smtp-Source: AGHT+IGyXxCF9q0xyJndVDMaC+/byqrnggwcF6XFCV78+YHp/QJxvP50mBiITv6Vom2ND/TrIJCJPw==
X-Received: by 2002:a05:6a00:17a9:b0:7a2:705c:5037 with SMTP id d2e1a72fcca58-7c58c89cbf5mr39205546b3a.11.1764652736573;
        Mon, 01 Dec 2025 21:18:56 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3f79sm15206433b3a.42.2025.12.01.21.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 21:18:56 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v4 3/4] nvme: Expose the tls_configured sysfs for secure concat connections
Date: Tue,  2 Dec 2025 15:17:54 +1000
Message-ID: <20251202051755.1312158-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202051755.1312158-1-alistair.francis@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_211857_580229_3A155B2C 
X-CRM114-Status: GOOD (  11.46  )
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
v4:
 - No change
v3:
 - No change
v2:
 - New patch

 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..6d10e12136d0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
 	    !ctrl->opts->tls && !ctrl->opts->concat)
 		return 0;
 	if (a == &dev_attr_tls_configured_key.attr &&
-	    (!ctrl->opts->tls_key || ctrl->opts->concat))
+	    !ctrl->opts->concat)
 		return 0;
 	if (a == &dev_attr_tls_keyring.attr &&
 	    !ctrl->opts->keyring)
-- 
2.51.1


