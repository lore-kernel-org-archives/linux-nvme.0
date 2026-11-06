Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174E606A32D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xnVPF83k;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwesgoRy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=qT2iGCtzANHH9hlwoXwHnZX/StQ9bdfI9+nrQG92gYA=; b=xnVPF83kRj7+mx1M+rU69v+7TW
	AcH9hqJYd/oyikqQRYQXsnJPiWuPOjh3CA+4us23xSGz75RXZa71hH6u/iW91PuneLCEGrGPVeYjF
	Bn3b5pHfJp7jrQaj+G70pEyxB8dAigTfoua4Ai7HUrnYUcu4KObCSKe9b30osxjhhneRCPpWO92Cn
	O4Rh1UOSjSR4UmIxm+OFgE2aMAJ1OB2S9H8sW+3wEkPMOuXV8wYAkKw1l4CZYFB36fQOfDEiUp/ot
	jM+oTbMY0DK8B6IO3z6eKNMn0WHdQDlM5xsXvj/z2C1ckSQe+wxWpGLSHgqGyjM+gkdAawr8IXntw
	AnReoUpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKE3-0000000CTKW-1lgM;
	Fri, 06 Nov 2026 13:43:27 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKE0-0000000CTJe-0Oh9
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:43:25 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-5365f9a04c5so8649291cf.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 05:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793972602; x=1794577402; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qT2iGCtzANHH9hlwoXwHnZX/StQ9bdfI9+nrQG92gYA=;
        b=xwesgoRydp/MU5mliadG1UkmDaj8vE3ed6D8wSpDL5eZjUSUTOY83H1ysJtYev6/Da
         U464ZZ1MVLlSFtrNQdbF+gudg0sORFFkJxerMIjGnxvFYUV2FkHd4ZpWGELS8VtwTqWY
         W4huVXdO17+teLnE3YXgfd6rQWm1fJ4wmjOFQ3ZA0kwCstobtZoh6uo6/E+qI1tfiyIb
         K5RrCLdLaIUbV38UgGtZk0gjB1pDjI0eeOlS1XQHOeS95wrs9KyC6FYoBJXn86lRZC5+
         5ZNKo/EMWkuCe2sjx/Z+U17fciKgsT4/U9hCHZntR2l1xyJTdr4tbMgPRoVAFJG/GkTc
         c7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972602; x=1794577402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qT2iGCtzANHH9hlwoXwHnZX/StQ9bdfI9+nrQG92gYA=;
        b=lNjoV2mEZGs39j+lgVzaU8mypODe8MJr6QB4Jq/XYVLGuMVJIwNf3/51RAJZMuC2ej
         mn33eXFXvoBE5Zqv+Dmomv5pGI8rtM9WL4lHM4Sv77h7XEkib2wPifLToQ+XlIzWhsw4
         L0E8UCbq5gw/hK5pZdikFVeQUL+TF+XyW07Fdv4kIQ+Oh3cJ0rSmT0gVTThytQo5h3Yr
         SwUsIuNbbn+C+ddXEL8VO6KrSDNjLshE3M8njISbKVHhLhgupqJIi8tmKd3Gs/pkBjI+
         81XDDSvQpIxUd4begDtjiPFh8Qy8Fouw755gOE16o8mcWq3HldoVXfUg+zkyrw0R4Hqj
         574g==
X-Forwarded-Encrypted: i=1; AKwUvBz5Aip8YghxS3sYKQcUP0kPbQyrK+86OCzWKVF4gRpCSkVoRED5kQAfJJzQCfuWhSEszBz84hH5pVCP@lists.infradead.org
X-Gm-Message-State: APuU4Z+Fz9cl/ClzkQNcVl3p7iTbHMdm8xr1KZwQ3o3GzCbp6+pRGMAw
	D3C0OZp74QiqPF2SLOsXyINOtJIpvQ27rGaqc2LwLG+WTenheRht4X/l
X-Gm-Gg: AYBFou32vxeiVyu5MwNbXtXliabXwOIbSv6B4lLMCAK5s/rbaDA+A3Tzoh5Sfo44crT
	OTsoabBe+DAs3F6UhxZB4DIoKGfsrbO2Tl3KHBLhlpatzS3Zf197SOvsa7HbUBjfYBuKfxovzaJ
	qfpMLB15sGZIkJK51KsQgyjhX58OOCeKSQBQQOOIManULGgYVnoxbJDzGVedGLExChbt18SSIxE
	W/kLzPZty0C1I8XATh3j48WSZj8SeAguXhmxShHi7w0DWn7fD2/rVH1/21oErQz2uCnTUP/hPil
	sc4g+jR15uvneYqUTT+ztPw3G6TJok0FCKa1a2GR3GsRNQkEruA0NmpKVGeVn1ZVyOUV43itF2Q
	RJxhJFP5p7KNxZf4jowywn81oQNJNQ9ybGOixW0Yu1eCUd6aL5axXBy+xueyXVrj8EHcphN3Mut
	PeZV1krPVJt0YxvnXEWQ3fro639a0rANrANZ18WkAqBrBtiaVsRhRDnf18o5sayfgl4aiktxGFL
	/FCcV+BmnZI09vyaav1CkJf/DjTgMnDkw9VRSlD3AVuEvOr/PH+UDA/Kwti+MSplm+512CW9jKf
	mGWg11gft1h5tUNpWAqo54+wVBAauYbGOkkKrDGCMOV5uQ9ySVhpyZhW1LB6wVF4lMzWOwSweBa
	nl2PAXK5NMkonKxk1p2yl/tB1zLICdZqIUjN98FfitqeGKwZSlttesqK2mLHk1m0G0pqxg8DQyc
	2w9pmTzvsDqLVY9pNpeLV5kID8wKI=
X-Received: by 2002:a05:622a:408d:b0:536:93e0:4b46 with SMTP id d75a77b69052e-54e13881a4dmr40064431cf.25.1793972601788;
        Fri, 06 Nov 2026 05:43:21 -0800 (PST)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:3d5f:800f:1837:ce61])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a887c0sm20792636d6.29.2026.11.06.05.43.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 05:43:20 -0800 (PST)
From: Andrew Stellman <astellman@stellman-greene.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Yuehong Wu <wuyuehong@cmss.chinamobile.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-kernel@vger.kernel.org,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH v2] nvmet: accept ANA group ID NVMET_MAX_ANAGRPS in configfs
Date: Fri,  6 Nov 2026 08:43:13 -0500
Message-ID: <20261106134313.34829-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_054324_150511_6945C3EB 
X-CRM114-Status: GOOD (  17.85  )
X-Spam-Score: -1.7 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_ns_ana_grpid_store() accepts an ANA group ID in the range
1..NVMET_MAX_ANAGRPS, and nvmet_ana_groups_make_group() accepts
2..NVMET_MAX_ANAGRPS (group 1 is the default group).  Both then pass the
ID through array_index_nospec() with NVMET_MAX_ANAGRPS as the size.
That helper treats the size as an exclusive upper bound, so the maximum
valid ID, 128, is rewritten to 0.

nvmet_ana_group_enabled[] is NVMET_MAX_ANAGRPS + 1 entries wide, so
index 128 is a valid slot, and the controller advertises ANAGRPMAX =
NVMET_MAX_ANAGRPS.  NVMe Base Specification 2.4, section 8.1.1
(Asymmetric Namespace Access Reporting), "ANA Groups", defines a valid
ANA Group Identifier as "a non-zero value that is less than or equal to
ANAGRPMAX".

There are two visible effects.  Writing 128 to a namespace's ana_grpid
succeeds but the namespace lands in the reserved group 0, which Identify
Namespace then reports.  Creating and removing ports/N/ana_groups/128
increments slot 0 on create but decrements slot 128 on release, leaving
nvmet_ana_group_enabled[128] at 0xffffffff, so every subsequent ANA log
page reports a group 128 with no namespaces in the Inaccessible state.

Use NVMET_MAX_ANAGRPS + 1 as the array_index_nospec() bound at both
sites, matching the array's actual size.  A namespace assigned to group
128 now follows the same path as any other group: its ANA state is
Inaccessible until ports/N/ana_groups/128 is created and configured,
where before it was placed in group 0, whose ana_state entry is never
set.  That entry stays 0, which isn't a valid ANA state, so
nvmet_check_ana_state() let I/O through.

Tested on v7.3-rc1 with and without this patch, in an arm64 QEMU guest
with nvmet over NVMe/TCP to 127.0.0.1.  Before: ana_grpid written as 128
reads back 0, and the ANA log after mkdir+rmdir of ana_groups/128 lists
group 128 with nnsids 0, state inaccessible.  After: ana_grpid reads
back 128 and the ANA log lists only group 1.

The issue was found by Claude Opus 5 running Quality Playbook, an
LLM-driven code review tool:
https://github.com/andrewstellman/quality-playbook
The fix and this changelog were drafted with the same tool and reviewed
by me.

Fixes: 20dc66f2d76b ("nvme: prevent potential spectre v1 gadget")
Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
v2:
- Rebased onto next-20261105.  No code change from v1.  On this tree
  it's only build-tested (nvmet as a module, W=1, no new warnings); the
  runtime testing in the changelog was done on v1.
- Changelog: noted that ana_groups/ accepts 2..NVMET_MAX_ANAGRPS, named
  what the tool drafted, and dropped the Assisted-by: trailer, which
  checkpatch now warns is a non-standard signature.
- Sagi asked on v1 whether this had been tested, and I didn't answer at
  the time, sorry.  Yes: the test described in the changelog was run on
  v7.3-rc1 in an arm64 QEMU guest over NVMe/TCP, with two kernels built
  from the same tree that differ only in these two lines.
- Yuehong Wu sent the same fix on next-20261027 and tested it over
  nvme-loop with the same results:
  https://lore.kernel.org/linux-nvme/?q=s%3A%22clamp+the+last+ANA+group+index+against+the+real+array+size%22
  He said he has no objection to the original being taken instead.
  Thanks, Yuehong.  If you're happy to reply with a Tested-by, it can be
  picked up when this is applied.

v1: https://lore.kernel.org/linux-nvme/20260910154849.66095-1-astellman@stellman-greene.com/

 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3a5242d0..85dda0ca7 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -709,7 +709,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
 
 	down_write(&nvmet_ana_sem);
 	oldgrpid = ns->anagrpid;
-	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS);
+	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS + 1);
 	nvmet_ana_group_enabled[newgrpid]++;
 	ns->anagrpid = newgrpid;
 	nvmet_ana_group_enabled[oldgrpid]--;
@@ -2084,7 +2084,7 @@ static struct config_group *nvmet_ana_groups_make_group(
 	grp->grpid = grpid;
 
 	down_write(&nvmet_ana_sem);
-	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS);
+	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS + 1);
 	nvmet_ana_group_enabled[grpid]++;
 	up_write(&nvmet_ana_sem);
 

base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.43.0


