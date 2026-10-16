Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89CECCA46C
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zfoHK1ZIKQ1TgR5QFK+lCQM9pR1G/aWYu6gXDDq4ISc=; b=zTFLvEbROS3izbOa7M8f8q8dcW
	n+oaXxL7bL40cVAhTEX07t0TZoi1gbkRodGTXrA7IhOfgFyblp9nZkUaKPwYtM+kdMXxg0F8upZoU
	OT7TGdKlTLyCxdfuNvHobXZVp/cwioM7uOSSTkxmSRpIGqoBWx9kMjZRtmS0juieJJie10lyHjhzi
	8I6v9qrVCK/fULSB1srnuQ1+9CBhlchKukHNO61NTVeNssENyjIEe8dUTTV8LfKBn76YcnzXTG1rp
	Rs2xgPkTv3HN0e713AgJ3nHBLvpmg2WUs/yinWtBzeiI5/g9utuwKiBxg35vB4Jl2xESfsidGOll/
	AQLmBedA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkT0-00000003OiQ-28p6;
	Fri, 16 Oct 2026 16:07:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkSz-00000003Ohd-1YXB
	for linux-nvme@bombadil.infradead.org;
	Fri, 16 Oct 2026 16:07:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zfoHK1ZIKQ1TgR5QFK+lCQM9pR1G/aWYu6gXDDq4ISc=; b=OUVm62HOcAO+QMzVDQUn7igy39
	l/RcCNq2ANfIHYXtqpAKLmLbMcSfyFNUilqezT29pxz1SlmUAtQx7PRW7XL/gYEGaAvkeR3H8+oXR
	Piqc6Y3p1bpXyqN9IG1Ht88Sy5Szx5qY/2UaY7nxIqbgjyXVhkAadPaF+wHfJBasoPKok1Y3BYFuh
	/1CDhs8pyOstwxgg/1jzsWLni2zPA8XebLx+pWGiT717GKBD9SDT6XuLqInEd29ZuIFVNEwuMt6r6
	C5EAaewn0nihJMdA4QF0HjXNLhW2VrJtXVDbav12nf6Vm6NdboslAKbYgZXsSF28pkt/6bJdrnFlx
	0xnoqtaA==;
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHkSw-00000001iHt-25bq
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 16:07:32 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so1133735ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166848; x=1792771648; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zfoHK1ZIKQ1TgR5QFK+lCQM9pR1G/aWYu6gXDDq4ISc=;
        b=OYjxVruI6gwq0YwyMJxKke9mcknFSsV6oGkEc1dbMNF3OacVc9QkxNDfIX3eEmjtV2
         c8KGicITgxRrCLofXBgrRpniKGHHGw4txvj9Yx3UMtnnbSvLkQznSUQaNOv5BMwDb+lU
         UAf6/iDrirViM6y5LGXdzpjvwdWiH5awOtuyPrUB1mN8cLqCWIGBGL/7dOBEOLcWx5VV
         o4K9poHt92HTBbQWnZWqxVAF2FLji2WzRkTa1FjXEdlful7Cj8QCSCV7iODsKUTEpHY4
         Sg3eMtNeJS3sk+5zXb2fkK6/2D6x8oKSw5eOEf4G5/fBQyB+zYJIFzak2eSdgvMfoGTY
         6ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166848; x=1792771648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zfoHK1ZIKQ1TgR5QFK+lCQM9pR1G/aWYu6gXDDq4ISc=;
        b=Ky0tfNQwUMQJBe9mJVKd9IzNvv5xYH33AUwaqvrJJNHsTqfUt2xg7Lb47D/epIiUQH
         DOcCrT0plGBCEVfTS68Ly15MFg+6TPqoacZ27gAsAjBYr7ZRQt2WTT1+PpMXJ4tlV0je
         TIvDJFoL3Z2rnsSc0Bmy0MU5fMzpXAjTAmNyxygBINlPhgObhvYi1uab5EVo6JpJQtDU
         /DHJGAhQwZT295J9SS81oTpSGLk2kUVq9DykY1EnKUhGvCchnxNgcEuFTg9RmZHHrmju
         mUCPT9CgeuVHt3+O64fOoql3FsHHSKs7oLcBQ8x3JFsN1+eYWAzLUIC6JnLCudAMBknE
         rHUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwY+VXWRFcTetGE18Uk2/CShtx2X/6XAqRlhF105MOKRUJxBSYkCWKU4twAlCb9bI+eoqaV1fF04imK@lists.infradead.org
X-Gm-Message-State: AFq9FYKS/OP/2CCgEsAfel+okIk8IINxU1DhVSJ7vtRy7lMQfvBa4DZB
	Vx/wSQ9BkUzi/wWQSrIG/ryZbONz1aIyO8c15OlnDMzUbAjvu6fLtY/G
X-Gm-Gg: AYBFou3nPI4SEDEwjq8PjlG1oAyu9QYTtKExPgVdPDAHbQJPNfjKtRgPxcIbMZBlfI7
	sO07Yb8UecNG/UeTpL96vnquMfqZbJU8XyTdi5f0rrIQh+HeOyS+Me5woqi6CzllQCDIJN9t0kI
	8T5JxiAhB3YcJo9jY8qqvXevHQTBU9QEQNC2p7sJs981NdhRjEr6lNNkkUCA6r1LSHYZgFsRsiF
	Ek5mfrTvdsE88Y8d/ygZv626XgtDBb44+jgWMy7ZiPazn11Sx1jrN8hv1n4pw0NNls2+Eyrr9eL
	88XLoLmWKsI8GDm4fy2kDG7A55pNG26+srxWW3pSg5g3UsJiXvz4mWq3YAphqSP/cjh7t3p1DVF
	EKKuVmV4Bk1J/vw82tIp8r+0nCZxKP9TUP7Vv8jx+crmMlZJ00UskTBWx9i+KNY19+Y+ld2cnzv
	IxDlBYyEa3hRIsuSYC/9+lC81BKZKchCuq5xRyk+u7qnNQbb39HgR23fmEkhOF+OhiHEPbA37vm
	EtX9gxuLb/FznmVeu/7bQ/HJS6dzSGFcgRtPc4HRfg880uUKWU=
X-Received: by 2002:a17:903:2b04:b0:2e9:7770:cc35 with SMTP id d9443c01a7336-2e9a6a07297mr2933355ad.17.1792166847953;
        Fri, 16 Oct 2026 09:07:27 -0700 (PDT)
Received: from casta ([2401:d800:20b:1196:6a2:5930:14e3:f74b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1f0asm12294325ad.68.2026.10.16.09.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:07:26 -0700 (PDT)
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
Subject: [PATCH v3] nvmet-fc: skip port entry rebinding if already bound to a target port
Date: Fri, 16 Oct 2026 23:07:00 +0700
Message-ID: <20261016160700.12021-1-neganhat@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_170730_602690_F3F3E17D 
X-CRM114-Status: GOOD (  13.36  )
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
v2 -> v3:
- Correctly place pe->tgtport check before nvmet_fc_tgtport_get() to avoid refcount leak.
v1 -> v2:
- Move pe->tgtport check before nvmet_fc_tgtport_get() to avoid refcount leak.
---
---
 drivers/nvme/target/fc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033..43c5202a82b6 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1321,10 +1321,13 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry(pe, &nvmet_fc_portentry_list, pe_list) {
 		if (tgtport->fc_target_port.node_name == pe->node_name &&
 		    tgtport->fc_target_port.port_name == pe->port_name) {
+
+			if (pe->tgtport)
+				continue;
+
 			if (!nvmet_fc_tgtport_get(tgtport))
 				continue;
 
-			WARN_ON(pe->tgtport);
 			tgtport->pe = pe;
 			pe->tgtport = tgtport;
 			break;
-- 
2.55.0


