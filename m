Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2CCC79FBF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tPSEx2E5juGVh+7+CkjxpWQjRnb00L9DvXVIbF/QJ0E=; b=jU0opbMFVgU6yo7Ubh5mmVIwvR
	dng8wF1c8dF5iKeyxOQWn6pHJ56sXYvN2CFjhu9sdVt5ZPbs9q/UVPiBq28Ue2LR7x9izHtiM75DF
	y1s56RKGmBVW8gKAN1Sec82cINxGNWJ+nUmOSb5z641RIHN8bKCWjIvJFJEPbWrezbkYmNl2FvBoO
	67omzTsyIFgturAk+JgO7VM2K+H571S0CDlIS9pTHDVTSfr7Jv2dQwNbbzCHf9wirMBBfQrbe8hlA
	3wRe5Qq/xnYVotl4XpgOpys4r5QfPUv469j0VjKSe+6i0avp8p2TgqLOhBO/gtq2FzF5DmvpLYCV+
	xuHU4alg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4j5I-0000000F7L2-27m9;
	Thu, 10 Sep 2026 18:01:16 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4j5F-0000000F7Ka-3rwt
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 18:01:15 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-9397e2994dcso620712785a.2
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789063272; x=1789668072; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tPSEx2E5juGVh+7+CkjxpWQjRnb00L9DvXVIbF/QJ0E=;
        b=a/X2BKrZ2n8IPSYDzvJpvwAlr9FfGoAXDIloP+zxlNI/NFmkqOdjWkkEuRNDkVsRlz
         ooFHzY5CwXU3c9LRwCj1MN6lsDhDLlms6FbZgARHi7SXgyXXyM59kvBVvS0LQZYDl4KK
         fite7RA40cOydv47DkdmjLD/eJVRn13KIY6YRRsmiBPQ2aiQuBqdpmfYP6AmpyCUK8DC
         a2upmoZ3szko6nH9ExWd1h2LZu3M+lwJJOE32Y+lJ64lHsnLWrNXbLIRSHRGBXR0c7go
         cZuZE0wKvUOc6QcXv0DSTZU7cOrreQUZqXA54oO06yGmQd+mDQ1U7VKmVCrH5MBAXW0i
         TbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063272; x=1789668072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tPSEx2E5juGVh+7+CkjxpWQjRnb00L9DvXVIbF/QJ0E=;
        b=SkZgAPbE9URJ0acSG/7Iaz9PFXFSGMglW+SyrCItorKcr7rfAf2DNd48y+AcvwQqOa
         j6ayetpYq8vRxxjCOIW3Mpxy15QL+aHrIjGeqJkRZE5WRVSRYL7CezAXx7nrrWwsSFWP
         BrvozfY79WEpse2Ly3Q97YcAjLdInUCuvDlmZAwbQCvJlMnbBA0FZefaP01pyluGg42D
         aIFIHJfvnKoKqJEy9d/7aqWQsx7RJij+QwNvYPJhACPEYGx27cjUGp9oA8hWCz7Ft2hb
         ys6AB3om5EpEk5dJtJ/iDhw01vujItGpan2xjx1Hc4O2BCO2HmIZ3s17ufX0Xj27zSPm
         FD7Q==
X-Gm-Message-State: AFuF++m1k15tMVnenQIDeBCpxnkx/HuS3bZ5ZszFRJu+6TPpwvoBJmi+
	wCZ1Bw5DW5AUot3AgYXYx9Ze4eN41DiLjjCveseJDVCUstXPTuIPqhbd
X-Gm-Gg: AYBFou2dXAObfbm7nC5r2bLNVs9MacuCVYb8/muu8kE9O17obBGB9Hmy0E741TD7ejt
	MYDN4bWizpUohPbunPoUaKVvWlzAuXjKu+sQWfPzIxdVsXI+1lBBPBIp4u7GAHm0EYpUdDEoDXE
	F3S16JmFFrIXnF5K3C5cOdAGZDqwFHedraKJht1aYaXC53gAumNJeQWV87azccdqCDRKEzRbWrh
	QJlFLKr3bJMA6wRfIqYDxscxUyIYWUKen4bOPQG/6eEoBbiIrdOEqeOhVeFGYaPBtXhvnR/Vs8P
	SZlsfm5gFQu+Dg88osqDmsEKajqTPlklewzQFysLA/f9NRyk2hBiz0qo+cRroBlIdy48awWAhmM
	390tRbdWHkUHmQJXIBQYzsQ4l1paYNR9TY+V1U7HOHsinMdk7uWIjQUYImcTxYtqfdRi5gVyYR9
	8mxpxbBS5UnngqnNzEqiI7BOU9M8NWYo9lOphmDZ5GiLL/VFdjf/M461lJF7wCcUSoBMaMVwGDp
	s9ERhPdJRTTD0MUP43jJOybVxtoCb9I9rs26M++YzW6Tl41FSXWxViclBoLv/GffmKwUK1DwMLP
	zyptPyzMOevLL4Jj16vvb4hkdP48MxN6CivaxsSa7TCFlkzcH/OZjIlm+se4maJa0ZGlfKMLkw=
	=
X-Received: by 2002:a05:620a:410f:b0:939:112:d526 with SMTP id af79cd13be357-93980361ca2mr4985510785a.18.1789063263268;
        Thu, 10 Sep 2026 11:01:03 -0700 (PDT)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:a0f5:ee47:8227:6ffc])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7d9f945sm41280185a.6.2026.09.10.11.01.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 11:01:02 -0700 (PDT)
From: Andrew Stellman <astellman@stellman-greene.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	astellman@stellman-greene.com
Subject: [PATCH] nvmet: derive the CRTO property from CAP, not CSTS
Date: Thu, 10 Sep 2026 14:00:56 -0400
Message-ID: <20260910180056.81257-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_110113_971609_D52432A6 
X-CRM114-Status: GOOD (  15.96  )
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

nvmet_execute_prop_get() answers a Property Get of CRTO with
NVME_CAP_TIMEOUT(ctrl->csts).  NVME_CAP_TIMEOUT() extracts bits 31:24,
which is the TO field of CAP.  CSTS defines only bits 6:0 and nvmet
writes only RDY, CFS and SHST into it, so the result is always 0.  The
same controller sets CAP.TO to 15 in nvmet_init_cap().

NVMe Base Specification 2.4, Figure 36 (CAP), says that when CC.CRIME
is '0' the TO field "shall be set to: a) the value in the Controller
Ready With Media Timeout (CRTO.CRWMT) field; or b) FFh if the value in
the CRTO.CRWMT field is greater than FFh."  nvmet reports 15 in CAP.TO
and 0 in CRTO.CRWMT.

Take the value from ctrl->cap, where the timeout is actually stored.

The Linux host reads CRTO only when CAP.CRMS.CRWMS is set, which nvmet
does not advertise, so Linux initiators have not seen the wrong value.
A host that reads the property directly does, for example nvme-cli's
get-property.  Advertising CRWMS is a separate change.

Tested on 7.3.0-rc1-qpb-cc-crto-base+ (unpatched) and
7.3.0-rc1-qpb-cc-crto+ (patched) in an arm64 QEMU guest with nvmet over
NVMe/TCP to 127.0.0.1, reading the properties with nvme get-property.
Before: CAP reads 0x8200f0003ff (TO = 15) and CRTO reads 0.  After: CAP
is unchanged and CRTO reads 0xf, so CRWMT = 15 = CAP.TO.

The issue was found by Claude Opus 5 running Quality Playbook, an
LLM-driven code review tool:
https://github.com/andrewstellman/quality-playbook

Fixes: 1e058089d28f ("nvmet: implement crto property")
Assisted-by: Claude:claude-opus-5 [Quality Playbook]
Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
 drivers/nvme/target/fabrics-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 42d1d1811671..3311b79e8f3b 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -65,7 +65,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 			val = ctrl->csts;
 			break;
 		case NVME_REG_CRTO:
-			val = NVME_CAP_TIMEOUT(ctrl->csts);
+			val = NVME_CAP_TIMEOUT(ctrl->cap);
 			break;
 		default:
 			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;

base-commit: 4d7d9486c04d917265f64c55bd23b2cc4fe7749c
-- 
2.53.0


