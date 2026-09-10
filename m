Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5292C79F9F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+b1rUPajXnIz3K03+u8nWNAorrkHepuPd1JCl0GIhBY=; b=uBvN7pSnMoJ8lhsnfhhx4gXdDo
	ekpCTckt6LvYehqUJ2MSDdYSSSNP7FYNp8wZ4LMBt9QpP4WNRZOoXG6eFqltJNKJCze5MeKNZwT0d
	9YwkUGoB9/vIRbbNrPsJ8Nx/xvDE7F02Nq83F9F8kEXscYPymfJ/LsMsQ2c6EMGjacsh+A7e8CIV5
	ii+iQPRUCEmheCZmlEgxbJbMqtvQz1tQETvo3Ks0EvoyBQmgsGbhEGsEYGNIT+bJtwynSd5QK94Gx
	ijVUTgQAQ2d7psGp5UezIUnQI6RCUGEUCjPqg6aJOZXqy1f9b6/lxG8NKQWJKjm8Vh5ADUi0slY7F
	x7hFEakw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4h1S-0000000Erlq-49Qn;
	Thu, 10 Sep 2026 15:49:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4h1R-0000000ErlS-36VT
	for linux-nvme@bombadil.infradead.org;
	Thu, 10 Sep 2026 15:49:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=+b1rUPajXnIz3K03+u8nWNAorrkHepuPd1JCl0GIhBY=; b=CVPzSrNwyFbo1pO3brZkeJ9Fe4
	jy8qIexValXYwk+3TCs1V5Ge5v34wFxHZ6yv/TKO8vPNFrQA4HBpBSkZ40pDuNR9rj/ELztErUm/S
	xHmtNw8SK4Wer3OOEa/U6zYo98sa8Crq+/gjZPke7HMLfp+EalHsPIRXYdbOk2NLya8fH192NQiOL
	N8e0OnPuKrtP1V9o6K7Oq60OIb9PU+yI1xcKyq0Z2zPw+IkBvwdQhQambvBcwmpI10dT1KcITwaQV
	Gjmbl9b8NKrQanqrDRenBcntMmQFhj3hCylQkNi6LfI1cjxfxLlmdeHUunUr/lhx7isP06BZBtXyI
	8XrDZpXw==;
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4h1O-00000002hXU-0qNL
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 15:49:08 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-866e57f63a3so84950307b3.3
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789055344; x=1789660144; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+b1rUPajXnIz3K03+u8nWNAorrkHepuPd1JCl0GIhBY=;
        b=bFF8ohrDDvyh02D+9KybGGaAgRhgt1TsuPnUepZwRkojP1mYltm5uEUF3xZ2ivGAga
         48I7dcaxgycRDTzmjREaDrJV1SnV3fovZIf01jv+6UFNNJGos5lRVAGNHdZXcLB60XgG
         ooA7V/NP78kAlR5SvYVqQ3CADJxZcrCN0nOfVxrpuqqcP4cLbqTKnuQCihnuf6GAWrPI
         7LA5IRZXn/N3p7q9miwz3v3eCNut8sT97DRq4ooDjhC2dTllKsrx+D87CQ8yU28SbvXD
         qF6V6iEFa+2KldhZUOkByLhVugi2Xo/HBrlXPPwQCXLZilDUNf70+HeONcxLosrXVHUi
         zPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789055344; x=1789660144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+b1rUPajXnIz3K03+u8nWNAorrkHepuPd1JCl0GIhBY=;
        b=RUQPCKjiPWugoHgafoAc8i84rEYwf4gsSGcgBsgL6OIyF6voaxft52T62OReoXWV0G
         dKSz8pr/AdquJyfvrqz81n9jG86/x4GTtpytwXnIeM4h3AHVxuxjJdvfHm05isFdiSnZ
         BEbOUs5dp46lT0tESddO7bkEIbvaBy6Z7uVdHGHPVrzNJX7+2M11veOOW+met1FlVADu
         POiv38yLQYvPTaKwSQMXIdz3HweylS0sUgcZ8thRhwFL/VUcG+T3F+y+u2wScSj0p+dO
         co4b7meopnnwDREEp74fuFN2Udp6U9WOwnDO45AHWWSfcNYji/WyBC6AaMLYZqXRvm7B
         jsZg==
X-Gm-Message-State: AFuF++nHJ8uB+UQjbAXhc09nXadpuJzA1Z0LAocjuJL4nI+XWih4kXao
	qAdhI43BOaclGDG/MbE/P+rC+wOrFwxbXRz5ntrY7DOH1QUE45fH+kvAecktZ5D7
X-Gm-Gg: AYBFou1lxj2BTBPyqYMvhzD+ltKjyNSqrYzTwBKgjTDojQFBmL7nE1i2Xp+MKNRIlSj
	uJaYeNnnSDAJ6KrxRHjMZxkfxWeTnnraHmmYtrze8MGkOh0wTVk3I4AcM5nSnjP7/s00zAWuKGy
	vPuq0TVq/ynG0qVR6UACwJQ0MJCUTKCJXzGhamle/ef2vwxdBk12+ifeAFeM95VWmct/dGlXFrv
	kZJGOJIcjO4eCsFmbkpCPu3sMUAgsR8onPqPmfjnRjz8tS7yniIffw7vEUoiEe/WSyv29g4R/k8
	XvoJ7IYvboZhZ+KYQM0JXMjcOlswZ+ogvU5dVW57BSKf6Bh4cTIoSWh/zl3g/fjNcZIH0gviIRZ
	o2VCY/trudcacj/FVHKs/Y5ordqPQgs/g9YEQH8VIoSZe+EjbvFDBuatdRB4/6KYfydy1WfQFqJ
	lJCGLDbXmJEe1/4OBw1hbfNsC4AUdakjiDm/W7Efdd9PA5vaJ/hqJn/ExId8q3A8W0n3mXtUKN7
	ashr5Rb2B6Fri2nuhxlRtyqO+O+tIR4yEYgwyi5KPwWiqZib8jF/tFPX5ogMtafL0CywkRJWbN6
	VgRJ3d8JU86KsLmDR5oQeN0om71APUGlgWZKuG+vN5Ght9YcN/1E1siY1ZX4ExQSYzvjq0s9Uw=
	=
X-Received: by 2002:a05:690c:6508:b0:873:5ddf:d871 with SMTP id 00721157ae682-8735ddfd9f7mr135085687b3.60.1789055343629;
        Thu, 10 Sep 2026 08:49:03 -0700 (PDT)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:a0f5:ee47:8227:6ffc])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040646d64sm174102926d6.14.2026.09.10.08.49.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 08:49:03 -0700 (PDT)
From: Andrew Stellman <astellman@stellman-greene.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH] nvmet: accept ANA group ID NVMET_MAX_ANAGRPS in configfs
Date: Thu, 10 Sep 2026 11:48:49 -0400
Message-ID: <20260910154849.66095-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_164906_425793_6B1D3453 
X-CRM114-Status: GOOD (  13.63  )
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

nvmet_ns_ana_grpid_store() and nvmet_ana_groups_make_group() accept an
ANA group ID in the closed range 1..NVMET_MAX_ANAGRPS, but then pass it
through array_index_nospec() with NVMET_MAX_ANAGRPS as the size.  That
helper treats the size as a half-open bound, so the maximum valid ID,
128, is rewritten to 0.

nvmet_ana_group_enabled[] is NVMET_MAX_ANAGRPS + 1 entries wide, so
index 128 is a valid slot, and the controller advertises ANAGRPMAX =
NVMET_MAX_ANAGRPS.  NVMe Base Specification 2.4, section 8.1.1
(Asymmetric Namespace Access Reporting), "ANA Groups", defines a valid
ANA Group Identifier as "a non-zero value that is less than or equal to
ANAGRPMAX".

Two visible effects.  Writing 128 to a namespace's ana_grpid succeeds
but the namespace lands in the reserved group 0, which Identify
Namespace then reports.  Creating and removing ports/N/ana_groups/128
increments slot 0 on create but decrements slot 128 on release, leaving
nvmet_ana_group_enabled[128] at 0xffffffff, so every subsequent ANA log
page reports a group 128 with no namespaces in the Inaccessible state.

Use NVMET_MAX_ANAGRPS + 1 as the array_index_nospec() bound at both
sites, matching the array's actual size.  A namespace assigned to group
128 now follows the same path as any other group: its ANA state is
Inaccessible until ports/N/ana_groups/128 is created and configured,
where before it sat in group 0 with an uninitialized state and I/O was
allowed.

Tested on 7.3.0-rc1-qpb-cc-base+ (unpatched) and 7.3.0-rc1-qpb-cc-anagrpid+
(patched) in an arm64 QEMU guest with nvmet over NVMe/TCP to
127.0.0.1.  Before: ana_grpid written as 128 reads back 0, and the ANA
log after mkdir+rmdir of ana_groups/128 lists group 128 with nnsids 0,
state inaccessible.  After: ana_grpid reads back 128 and the ANA log
lists only group 1.

The issue was found by Claude Opus 5 running Quality Playbook, an
LLM-driven code review tool:
https://github.com/andrewstellman/quality-playbook

Fixes: 20dc66f2d76b ("nvme: prevent potential spectre v1 gadget")
Assisted-by: Claude:claude-opus-5 [Quality Playbook]
Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 413ee2d16d29..0d4c69c4697a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -698,7 +698,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
 
 	down_write(&nvmet_ana_sem);
 	oldgrpid = ns->anagrpid;
-	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS);
+	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS + 1);
 	nvmet_ana_group_enabled[newgrpid]++;
 	ns->anagrpid = newgrpid;
 	nvmet_ana_group_enabled[oldgrpid]--;
@@ -1976,7 +1976,7 @@ static struct config_group *nvmet_ana_groups_make_group(
 	grp->grpid = grpid;
 
 	down_write(&nvmet_ana_sem);
-	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS);
+	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS + 1);
 	nvmet_ana_group_enabled[grpid]++;
 	up_write(&nvmet_ana_sem);
 

base-commit: 4d7d9486c04d917265f64c55bd23b2cc4fe7749c
-- 
2.53.0


