Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66097CCFA18
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Nov 2025 10:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xKkpvmb/gNhZAh81SS7lxMpIqynFZoUlh3WN1RUeadA=; b=OB7LmGV4UZGdDYVnxUZAPjuPhm
	HLpmQOpuQb6uQWY5DoqafqwBCorNNHCLzMR+nK9hXpnIP3z+Yhckud5o5fWo79U+b5cEvMTGtMxb3
	nSEqYKo9nJRGsjXcQDQSRHUNBIMq9sA0S8YjiMBcMEkatkaOOefLAbuDtJ99q6g6+mAlvxp4hGxAs
	FiwlFVBIle278cgRz6ahaaJlwv8cJvDAVJd0XCrDVjEuupLZvK1H2TOxNmhx1BjRFRp1HybN0LEfp
	/5c512z5LlAZJ5Bg5/g3FuGzgV6+iYrENbwp3Oikzw0EiKp5YRPfK/MsSac5DGAFhJrSFwIQkigL+
	B5O2WvIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHfkQ-000000030Yg-2Cxv;
	Sat, 08 Nov 2025 10:00:42 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHfkO-000000030XV-0xlm
	for linux-nvme@lists.infradead.org;
	Sat, 08 Nov 2025 10:00:41 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1295068b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 08 Nov 2025 02:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762596038; x=1763200838; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKkpvmb/gNhZAh81SS7lxMpIqynFZoUlh3WN1RUeadA=;
        b=caBg7wlbpWlryypDef//KaduUNc0+5zxV7Yux9Z3YEWmFItbOsetc2TgF4BQSIdSg5
         9YzgpVMlnr+uSBoGzkRqsxQ30LNwk/SYAV3yHtMakYXK0J9hXr/S64gDV8Yrv0IRGyzt
         Xwkl+Tw7sahTdjWuz5k35nktlSBngFB1h9jIdmtt12qlg7OGoVyBT0mXq1Dn6JXgkBL7
         hXQoZWXufeYmfn2dBOjYNwHLMbKVC4R6FhomIo91UIo3e43D1lTX+sHqkzUu+zviAVqM
         7WrfeDaRFyH5buCudgKgswpz4Vn4hxkJIRqdUsfGFVieu2YWT+5uYV/5CJQOBNV/j/5I
         aU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762596038; x=1763200838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKkpvmb/gNhZAh81SS7lxMpIqynFZoUlh3WN1RUeadA=;
        b=Vjw6gqxmyEkt1MR0HCRAJmubL0OpPganX7UKGvvEN0gupUwRFjyqO6yd7nSf31w1p2
         ELdqzqCYniXtC9XUGE6S3+ABgKhNJfirc7noxrNthGBpLLkQNSbzOXBoHLg9ICiUuh+p
         phzfKNjcGTRjyVNj7ph6H91IeXEMWUePH/t0Oyolqh7Xpqq9SQUiSocBPPVIMoygaQ17
         8D3ArgOgUA8bFzVwuZUhLWdt/SlLhrkn4d2KNq1KuEXxLljl06Knq+pfGO9acqfBQMiI
         xC8258Ww0p7gqw/3KLWQ8qs+HHjXImhQyIcQ1p3KuF7ydZeIJZ5XRtWh0IPOp3HkerdT
         GyOg==
X-Forwarded-Encrypted: i=1; AJvYcCXivhx8YxgUaA09N/9vjZwFOSehs/EaydnlUcjox0/Wgtja8xxHg2i/BkBZMJ6/sg25KtDKj4W1OL1b@lists.infradead.org
X-Gm-Message-State: AOJu0YyzZv9zC21sh6iKz8liZcIxPtMd+Dps2mbfgjeGuHGAoxcaPEuw
	3wPty2q2YTJir5oYMdvNkRKEmK6aaEX7EpVNelOqQgkGnS8Vgbx5QEJ2
X-Gm-Gg: ASbGncv8qqXei2basT67ETTV4Z3GVgO03IFw53CHgvbcmFOGgR4M3tWJDGdKJHWS22/
	fhsUMlPZDYB0yfHUe6gnnGEqpQxUH/CKgsa4LocxgRQamkyc4NDYuXtIVGBBmolIg0G3sjwNTur
	X18vgCZKxHgmko+hVGpduw2x1yQ2gWgZiy9SfGj4sANjqvvm82I/UaAYMUg/PtUWNc1A2EXRAOB
	uTt+SPYMiZA/dJ1AYFQoHTX4ixPp7PxLOa4tvTiTGy2IoUOO9oTgz+lH+SUkG9PUgyyhgbdZIQG
	cIqt98fp4SfkFlY/yxu166QDGCZSKBBWNGa7+m0VyFMz6Jgn7ZuwdaB1j6Z30AJTdAr3swwHuLl
	K0k8X6tc0MIzwzUG/TlUVPRdDtP67oF9eq6m5qWLat2KaDUoGSddMNqRXSuND2Lj7f2MsHjt6rg
	ipZxVAfZApeV/MWVmMYhrKSw73ZC8adcdHSYCSovri3DPHhHYPa3n9F968nw==
X-Google-Smtp-Source: AGHT+IHeqVqxMetOHAbnbE/jeU7bkSaaZHhTfZXTTL7tsffypUXuVkCFrS/EZD7ccDhZsjdeCDvGeA==
X-Received: by 2002:a05:6a20:6a22:b0:33b:625:36be with SMTP id adf61e73a8af0-353a3574e00mr2761286637.38.1762596037688;
        Sat, 08 Nov 2025 02:00:37 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b2c83906e5sm960397b3a.71.2025.11.08.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 02:00:37 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: shinichiro.kawasaki@wdc.com,
	wagi@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH blktests 1/2] common/rc: add _have_kernel_options helper function
Date: Sat,  8 Nov 2025 02:00:33 -0800
Message-Id: <20251108100034.82125-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_020040_266978_1CB0243A 
X-CRM114-Status: GOOD (  10.02  )
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

Add a new helper function _have_kernel_options() that accepts multiple
kernel config options as arguments. This allows tests to check for
multiple kernel options in a single call, making the requires()
function more concise.

Example usage:
  requires() {
      _have_kernel_options IO_URING BLK_DEV_INTEGRITY
  }

Instead of:
  requires() {
      _have_kernel_option IO_URING
      _have_kernel_option BLK_DEV_INTEGRITY
  }

The function iterates through all provided options and returns failure
if any option is not enabled, maintaining the same error reporting
behavior as individual calls.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index 86bb991..545da61 100644
--- a/common/rc
+++ b/common/rc
@@ -226,6 +226,12 @@ _have_kernel_option() {
 	return 0
 }
 
+_have_kernel_options() {
+      for opt in "$@"; do
+          _have_kernel_option "$opt" || return 1
+      done
+}
+
 # Compare the version string in $1 in "a.b.c" format with "$2.$3.$4".
 # If "a.b.c" is smaller than "$2.$3.$4", return true. Otherwise, return
 # false.
-- 
2.40.0


