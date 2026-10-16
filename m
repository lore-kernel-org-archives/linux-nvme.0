Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F77CCCA46C
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qvmLPz06rJRqpskfFH0YX2GLcYLTXoI2OSEKQqiSxh4=; b=EhQmDpkxHjhXUJdfu5JeKzGcM8
	2m9aBmWU3DPRYyE+60BzDXYMIPBrB9W0ZWIsteI8njUuQXaIOzTNYvpDndN/5QDOIe35+wuNN5Imt
	NxnIEct6Pmh9jI4TGvEb8PPt/V0Z8gUm4TSsYqtfeqVu1hA0AI6b8GSFPOl9ymFvk70sRbR7LBgdA
	89gROe8uZ0qhMnqqU43H82UEhKP8HsdLz1wCGiY/QQAgZtzkvMWSYD68DlTxB1xI3fmfN1PUSH3LN
	zDgd9/s/6sQX2pgPT8V9oVfJ9IntGQbrBopfilrOHTzYj461Xm0OaiIYoeEf8F4deQfs30LqmY2M0
	u2Z2jq+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkM3-00000003NAR-1p35;
	Fri, 16 Oct 2026 16:00:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkM1-00000003N9E-3HOv
	for linux-nvme@bombadil.infradead.org;
	Fri, 16 Oct 2026 16:00:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=qvmLPz06rJRqpskfFH0YX2GLcYLTXoI2OSEKQqiSxh4=; b=ML4WUXbrTsMqgu0MLzf5Uc4vvt
	2JdZJeQqPg1qDoDxxqUJpbq+vZnyU192smWVA4UrGYbej8CwBijP4Udbd4ekR/ghUsB8S1cuSMrEQ
	p/vwVjWk5zsi8EQvqOet27+a/kyisxF7ZJl8V++oLHMbHAjoo3aEomwy6UHt9jFaaRcmiYSU/d5rA
	P080kDOyClj/hN6lztOyCIHSyq2b3+MCPMgzVN6pyQ3IL2oIVFUml3yAjkaGmN6Oa41ZVt+PlFG6W
	Y5d+6LvR2Wt5qoW4OmDZkibuioMNUjn9d6vZl/okOnXYGZPOdRKdtRPAOncbI/Q6QNVCViiJLirAV
	mjsiafwA==;
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHkLy-00000001hme-3Fiz
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 16:00:20 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso84066a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166415; x=1792771215; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qvmLPz06rJRqpskfFH0YX2GLcYLTXoI2OSEKQqiSxh4=;
        b=a2RC/yWMvcoG6CpiTkqiN067AX4WXDfgxsb83wlsj7QpfY8Xpj1+u9nCXQkVcz8bsz
         1EoYCFJQvX2WyZzuEG6OXXGY+rGlVXKQMlTa3qqVr2nZtq2e1MdbdOSMsqWy2kshHbmx
         b7r58wsKjelOqmBUX3EFhsgdegltcAHH863aGGykURFPheBSTDzL71DS8X+M7Er+g5F2
         RWGjv8sPoMCoH+h/kLXT1ZNeYyJoYcYP01myIxOBZj/h25NYS/JI+2VNYSSs1RIAv0oM
         X1o+VdJDaWAPAB2pxBInyRU+rNqFTpHS5hVuH/DGAhnygXGwUIgmK8oWqvB8Wh0cJKnI
         bUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166415; x=1792771215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qvmLPz06rJRqpskfFH0YX2GLcYLTXoI2OSEKQqiSxh4=;
        b=WBOyjBbi4bcQ+PUPOvKbgDlt4L660FTNgEculQgfM9ZA2sA3PlDWm5G/e+A8mVUunI
         7l6IZysItWBIAPzuh83WT9B5CwcZ1S0S8c6m0iTUe0kRaUVv0uMPxHM8I1auWNXvNlUt
         Sdl+f/LIlkjzm6EKNyJ19/0AFBOzBBZU8CyYKX0rZDp7DX9l2eKZBGBJ5F0OhLSeaLII
         XqwfZIJsX7qLJ9lPmm6mA9k8WJ8RgFz+D1SI7l5MG5KeMv7bej+2X1JEbsO8XNfBHash
         +XO6WuatRqUrbzswbFKNIzAfMI1vyk5IAwyJ80Ug8Cd6abfSpYin+fqCpxQIEwM8PznG
         yt0w==
X-Forwarded-Encrypted: i=1; AKwUvBxureCj4uKSDS12QgbDUWpOtsat52OZR0E+ECh/ze4YRGxa36VOcvCxZim7k12ZRQj3Nn7kKwxmF+5Y@lists.infradead.org
X-Gm-Message-State: AFq9FYIh0gnbTNAjMkiUq7qlT+b4h08RJPtAsXRC9XFEKcJlZ/Rz966F
	vphAhSv/JqczLfOPIKAenUdtyPDZVJk+EZrwaZ+RyLtsJiAFHc7xJbYU
X-Gm-Gg: AYBFou3bWXoROvNCfDZi1UcHQV6twDDbVyNpL8q7KbyNBaKGbKmsZIimiOftsgirYlx
	IayLx+Ddlf4BITQ1zcHIvkETvw75jf6aJ54kTWKsq4GcxldTSRHCsJyyPR7eidF1aIEBbJhvWVc
	v+w8eW3zVAoLrGE6rv5VjWptu28X3t7LKkknm7J+iHVvupzKYQ8Rjt8hnBALEa6Ag8DJrKr4uqp
	qxXOO1AHithuGB6nalLJNmVdq5uskiQOn15T7lzchVyNFHHSZD8fQQPqSxWInVTVf4NN/y+LVUn
	Nu+ZEKo3sgtgoAFKgRwHwuKrCVSafgwcCkU0PUIVWLfpJOTePk+VPUEOKoZXrsTD7+XrKsqGj6q
	UFd2PQ85KfifpSrW/3VkVqPSx5YsF06TQqqZwHJHig2BOP7JbVYEWX8N14XZ5JTmuIC855twBWN
	GbcXw2zljMTCIoH8m3ayR9vFWtW7d4LIN+wjmvXgx2TlIE9LNwqRD9Nq9YjOZ/xx61RmmyNLRiy
	HRj0TCV8wWZM/rQXTtmB82SwSab8j25wgM67QKuqBjqFbMYjJ4=
X-Received: by 2002:a05:6a20:3d07:b0:3e0:d38e:1ed9 with SMTP id adf61e73a8af0-3e16be86c35mr22403928637.48.1792166415388;
        Fri, 16 Oct 2026 09:00:15 -0700 (PDT)
Received: from casta ([2401:d800:20b:1196:6a2:5930:14e3:f74b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89febdc2209sm814796b3a.33.2026.10.16.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:00:13 -0700 (PDT)
From: Nguyen Duy Nhat Anh <neganhat@gmail.com>
To: paul.ely@broadcom.com
Cc: nareshgottumukkala83@gmail.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nguyen Duy Nhat Anh <neganhat@gmail.com>,
	syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com
Subject: [PATCH v2] nvmet-fc: skip port entry rebinding if already bound to a target port
Date: Fri, 16 Oct 2026 22:59:47 +0700
Message-ID: <20261016155947.11018-1-neganhat@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_170018_865983_E0F36171 
X-CRM114-Status: GOOD (  12.11  )
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

In nvmet_fc_portentry_rebind_tgt(), nvmet_fc_tgtlock serializes access to
nvmet_fc_portentry_list, but does not prevent multiple concurrent or
duplicate target port registrations from attempting to rebind to an
already-assigned port entry.

When pe->tgtport is non-NULL, WARN_ON() is triggered and pe->tgtport is
overwritten, leading to kernel warnings and leaking the reference count
acquired by nvmet_fc_tgtport_get().

Fix this by checking if pe->tgtport is already set before acquiring a
reference count and rebinding. If it is bound, skip the entry to prevent
clobbering existing bindings.

Reported-by: syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be62d4b375542ecebd17
Signed-off-by: Nguyen Duy Nhat Anh <neganhat@gmail.com>

---
v1 -> v2:
- Move pe->tgtport check before nvmet_fc_tgtport_get() to avoid refcount leak.
---
 drivers/nvme/target/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033..9b7fd8f5bd47 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1324,7 +1324,9 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 			if (!nvmet_fc_tgtport_get(tgtport))
 				continue;
 
-			WARN_ON(pe->tgtport);
+			if (pe->tgtport)
+				continue;
+
 			tgtport->pe = pe;
 			pe->tgtport = tgtport;
 			break;
-- 
2.55.0


