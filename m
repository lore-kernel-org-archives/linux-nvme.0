Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3E4CD3436
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 02:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Io/N+hHnLMI/zVIF68lkuWkyC9l4bvcPQWSmOV0m6oQ=; b=fvniX4EA/nMMaR4ckNIj5xod0c
	sQDZeByshCaqehYQ7G1xQ8QDyITwmKbvJg+GryLNMdD0lZfcVeTQfCD0ska+UkQEMHL7v9kN/Dfm+
	OkKLlP1BsYDe1aostbnnFFVHSS673FVURgY4x+pOytRspHhtmJ93wPNOD6R/KPaQLeOyhVAZpIZ1p
	Es8EV1/s/GKroNqvsn+A2MzbnYY0FOi5M5s+zPtNOi0VN2XX9pbGNr2ZIeHyiVOro4L6hXDndQW10
	IdneHNCV0ZM8AjDfRbIIZq1IstSltuyxwi56+24Y4dBS25TIlNC65DJpW2Sr4l2UuZPRHo5VP+p3M
	VymgchCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKoSe-00000002Wan-2cj5;
	Thu, 07 May 2026 02:27:36 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKd2W-000000012gZ-30vI
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 14:15:52 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso8622845e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 06 May 2026 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778076949; x=1778681749; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Io/N+hHnLMI/zVIF68lkuWkyC9l4bvcPQWSmOV0m6oQ=;
        b=b7mfAnZakstYiU4aSVoFSdqhPtnLGAVdjsyGLlQ8zYpkBMofRNrGGxvlSbij/0R11a
         +O6Y4ZSHo7+vRJGTQ9a0DGUuTBl3GE3XWLab79sRDMRP98Ewj/CA+U51pjcaqZL5dSX6
         KF91Qbw0JNwYwW7XupAKJwBPrVzdIe085hHqzGXmhuiANp0sJcIt7rw4OmhA7a4E7FmZ
         nBPGO9OUJgVOPYtZWfAqQfU0O/E1XfbFuZ8FDd3Qp06dfwh6gQg0pdNxnJ8HsPatrFFQ
         BO3WRUvGNu+/Pd6nK5nYqo1jXTe9/Ej/Qiar48pl9qnn4r4aZEiVe92msnICkMb1ZhBM
         SKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076949; x=1778681749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io/N+hHnLMI/zVIF68lkuWkyC9l4bvcPQWSmOV0m6oQ=;
        b=PXqjQVM/LeG+0lUjdhXIzssjgQbGGHQ8m0G6fLS69ioxvUuy7xOP+5/K79k4LPCJ21
         HtjqswvOeAu6qLO5gn7AcfZZ8cH8n7ET1ImMVs9T6LaCywaHW4ziww6yZD7t0h8eGC3i
         kd4PKTJ1dUBS5T1/bDkl7WpnInjodxF3rhAZiT4r2qB3+kqHb4sbgMDe8zdLA3Szsjus
         wNANWYnF/LKJr/ikeJDViI/6noQDOcVRSVTMluDs89kQ2HzN2FbR6KYjLbyNFUdmt17G
         HvNqfjL13dTcHEC6mpzcEFb/9cJ2Vn5EyHlNakVHRJEXZUighR2zuDA5o0OPOUHP+iCK
         X2Mg==
X-Forwarded-Encrypted: i=1; AFNElJ+q13Nw1am6i8hMd/6gqvyUSVbASGRwd2swnmgXQ9hfXIfzOZj1PbAEhf/Z9tcUfEa+NsMBzkpS01ba@lists.infradead.org
X-Gm-Message-State: AOJu0Yzz8yD1egmaWWwIjLMXPyChihj190finoodKLLeidcILUcmI8dY
	jyl7Osh0WdWUsv3/3uktUVZlBetk9Px6r+NaQGk7kLVTEOhxi5GO4qQ=
X-Gm-Gg: AeBDievlHO18NRq1QFWlp46OTF5Fo/yYfkzEz7X+o9oD2kUJTctKMqXTT7mLkDdhCkt
	pTxonfJloo9zB+70+0ER5LdiydNWVWJAYCn9p/r/Scsl2tzWvxSt7RSfGO9G5UMulZnrL1zOYnM
	GSE1t+TnAVD9bTklPJWosLDG+7NgWSbQTta632pP/FrPWS+XAy63xGC16m4Q5C+SwlXAKmZ2OvK
	uE/tN2+nnZ7fNSVjiAPiybEzsavj/B+JlbvJsqBLWigRO6ChfwrqMwftBQBB0bHzk3kjnOjpamf
	Be6UB6h51pkxSlI68s7IGvqMXogu5rrV4lgj64N0b2r9q6ITIUaXgN4qxHa9RHswkWUC+GW/MI6
	0V0qfTVzFjsg50qs1UZ8JFpGFZrP6VUL9MfwCBHV1vQUiHtTMRbqxuKeSVqn5dUQa1j3BL9hfs4
	PPdyjSl0ZYZmIQtTgtREfe6LanRbXnHcoAmjwGG06QFksm4W5o7Oww3Byl7wUckt5qeaGRbORj
X-Received: by 2002:a05:600c:1f95:b0:486:fc61:541d with SMTP id 5b1f17b1804b1-48e51e124b9mr32527385e9.2.1778076948868;
        Wed, 06 May 2026 07:15:48 -0700 (PDT)
Received: from localhost (8.red-80-39-165.dynamicip.rima-tde.net. [80.39.165.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505558e213sm13671647f8f.25.2026.05.06.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:15:47 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Aviv Coro <aviv.coro@ibm.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Brian Bunker <brian@purestorage.com>,
	Caleb Sander <csander@purestorage.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Chris Leech <cleech@redhat.com>,
	Christophe Varoqui <christophe.varoqui@opensvc.com>,
	Christoph Hellwig <hch@lst.de>,
	Clayton Skaggs <claytons@netapp.com>,
	Constantine Gavrilov <cgavrilov@infinidat.com>,
	Daniel Wagner <wagi@kernel.org>,
	=?UTF-8?q?David=20Santamar=C3=ADa=20Rogado?= <howl.nsp@gmail.com>,
	"Dmitry V. Levin" <ldv@strace.io>,
	"Ewan D. Milne" <emilne@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	John Meneghini <jmeneghi@redhat.com>,
	Jyoti Rani <jrani@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Li Xiaokeng <lixiaokeng@huawei.com>,
	Marco Patalano <mpatalan@redhat.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Martin George <Martin.George@netapp.com>,
	Martin Wilck <mwilck@suse.com>,
	Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Randy Jennings <randyj@purestorage.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Simon Schricker <sschricker@suse.de>,
	Steven Schremmer <Steve.Schremmer@netapp.com>,
	Thomas Song <tsong@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Vasuki Manikarnike <vasuki.manikarnike@hpe.com>,
	Wayne Berthiaume <Wayne.Berthiaume@dell.com>,
	Zou Ming <zouming.zouming@huawei.com>,
	BLOCK-ML <linux-block@vger.kernel.org>,
	DM_DEVEL-ML <dm-devel@lists.linux.dev>,
	NVME-ML <linux-nvme@lists.infradead.org>,
	SCSI-ML <linux-scsi@vger.kernel.org>
Subject: [PATCH RFC] nvme-multipath: optimize path selection in queue-depth policy
Date: Wed,  6 May 2026 16:15:41 +0200
Message-ID: <20260506141544.125089-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_071552_782054_33095244 
X-CRM114-Status: GOOD (  14.75  )
X-Mailman-Approved-At: Wed, 06 May 2026 19:27:34 -0700
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

Move the zero-depth check inside the optimized path case to enable early
exit. It avoids redundant condition checks for non-optimized paths, and
eliminates the per-iteration check at the end of the loop, improving the
performance.

Cc: Aviv Coro <aviv.coro@ibm.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Brian Bunker <brian@purestorage.com>
Cc: Caleb Sander <csander@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Chris Leech <cleech@redhat.com>
Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Clayton Skaggs <claytons@netapp.com>
Cc: Constantine Gavrilov <cgavrilov@infinidat.com>
Cc: Daniel Wagner <wagi@kernel.org>
Cc: David Santamaría Rogado <howl.nsp@gmail.com>
Cc: Dmitry V. Levin <ldv@strace.io>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Ewan Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: James Smart <jsmart2021@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Jyoti Rani <jrani@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Li Xiaokeng <lixiaokeng@huawei.com>
Cc: Marco Patalano <mpatalan@redhat.com>
Cc: Martin Belanger <martin.belanger@dell.com>
Cc: Martin George <Martin.George@netapp.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Simon Schricker <sschricker@suse.de>
Cc: Steven Schremmer <Steve.Schremmer@netapp.com>
Cc: Thomas Song <tsong@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>
Cc: Vasuki Manikarnike <vasuki.manikarnike@hpe.com>
Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>
Cc: Zou Ming <zouming.zouming@huawei.com>
Cc: BLOCK-ML <linux-block@vger.kernel.org>
Cc: DM_DEVEL-ML <dm-devel@lists.linux.dev>
Cc: NVME-ML <linux-nvme@lists.infradead.org>
Cc: SCSI-ML <linux-scsi@vger.kernel.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
Status: Compile-tested only. UNTESTED on real hardware.

[I do not have access to this kind of hardware]

Feedback and testing are highly welcome.
---
 drivers/nvme/host/multipath.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..7d212f6e865d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -409,6 +409,8 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 				min_depth_opt = depth;
 				best_opt = ns;
 			}
+			if (min_depth_opt == 0)
+				goto out;
 			break;
 		case NVME_ANA_NONOPTIMIZED:
 			if (depth < min_depth_nonopt) {
@@ -419,11 +421,8 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 		default:
 			break;
 		}
-
-		if (min_depth_opt == 0)
-			return best_opt;
 	}
-
+out:
 	return best_opt ? best_opt : best_nonopt;
 }
 
-- 
2.54.0


