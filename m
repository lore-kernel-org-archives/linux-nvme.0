Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F64606A32D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SuiEmR1W;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=TCdreGre
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=y9kHH79sXvLdJ8c1WHqBXC13L6ROL+nCnwolQUHTp5s=; b=SuiEmR1W9lg/dE297vzRYzjI1B
	cLF/0BDbuzvWxXJgNhyxocfJk4Ie4PVqPTy882HEF4cq5/pJERoSW6EVD1WSgvw0CIQIBB4comMFc
	1WP0yrEi0JvZXItDB0Mhzg+1z3XYe01feVkkXxllrbuXBJaNRdLEHMfijNAiZRRKsaSmiQed8cZhv
	/PjD5JFPIB5OFIDzeuk1M078ozGB/li9pOAApxyQL7zvq0sIT4QgcrYSVJwZ2bRJTW6Ecys6YNW/r
	LjBGNd3VDyYKkd3goDMyUBjLNdfYxMgA6KbvXwOted+tGM1NXG+lQ/E+0bG/COOtmBhKo1PgeDVrv
	QiDK8lWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPDdM-0000000BMg7-1olS;
	Fri, 06 Nov 2026 06:41:08 +0000
Received: from cmccmta6.chinamobile.com ([111.22.67.139])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPDdH-0000000BMez-1EN3
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 06:41:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=TCdreGreS8IsLXGTPV5IjCPYFKnAKRAtSsCJnSw5EVTrvoFaaRM4z0uWdnBc8bnWV3iW4qRMIJZwd
	 QkUJlT3/qQsS7dGnsz2PpYnRbXFlg2AIhF77h0zR5z161a0/FUlk1onoKPo0HW7XRZ+iXR4/oSip1N
	 459O1WNLXYTF2iT0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16aed7672245-893f9;
	Fri, 06 Nov 2026 14:40:50 +0800 (CST)
X-RM-TRANSID: 2ee16aed7672245-893f9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from cmss.chinamobile.com (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26aed76712be-154d7;
	Fri, 06 Nov 2026 14:40:50 +0800 (CST)
X-RM-TRANSID: 2ee26aed76712be-154d7
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, Maurizio Lombardi <mlombard@redhat.com>, Mohamed Khalfella <mkhalfella@purestorage.com>, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>, Randy Dunlap <rdunlap@infradead.org>, Aurelien Aptel <aaptel@nvidia.com>, Nilay Shroff <nilay@linux.ibm.com>, Jesse Taube <jtaubepe@redhat.com>, Rongzheng Wang <testwrzwrz@gmail.com>, Kees Cook <kees@kernel.org>, Rosen Penev <rosenp@gmail.com>, Guixin Liu <kanie@linux.alibaba.com>, Qing Zhang <diasyzhang@tencent.com>, Eric Biggers <ebiggers@kernel.org>, Julian Sun <sunjunchao@bytedance.com>, Yu Zhang <yuz08559@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: clamp the last ANA group index against the real array size
Date: Fri, 06 Nov 2026 14:40:48 +0800
Message-ID: <20261106-nvmet-ana-grpid-1-yuehongwu@cmss.chinamobile.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_224104_319901_4FCA9302 
X-CRM114-Status: GOOD (  15.45  )
X-Spam-Score: -2.4 (--)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NVMET_MAX_ANAGRPS is the highest valid ANA group id, not the size of
nvmet_ana_group_enabled[]: the array has NVMET_MAX_ANAGRPS + 1 entries
and the controller advertises anagrpmax == NVMET_MAX_ANAGRPS.  Both
array_index_nospec() calls however pass NVMET_MAX_ANAGRPS as the size,
so for the last group the mask is 0 and the index quietly becomes 0:

 - nvmet_ana_groups_make_group() increments enabled[0] while the group
   keeps grpid == 128, so the later nvmet_ana_group_release() decrements
   enabled[128], which underflows to 0xffffffff.  The ANA log page then
   reports group 128 as inaccessible forever even though the configfs
   group no longer exists, and the increment on enabled[0] is never
   undone.

 - nvmet_ns_ana_grpid_store() accepts 128, stores 0 in ns->anagrpid and
   returns success, so the namespace silently stays in the default ANA
   group instead of the one the user asked for.

Both failures are silent, and they change what the target reports in its
ANA log page, which is what a host uses to select paths.

Pass the real array size in both calls, so the masking is kept but the
last group is no longer folded onto index 0.

Fixes: 20dc66f2d76b ("nvme: prevent potential spectre v1 gadget")
Cc: stable@vger.kernel.org
Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
---
Verified with nvme-loop in QEMU/KVM on 7.3.0-next-20261027, with two
kernels built from the same tree and differing only in these two lines
(no instrumentation):

 - before the patch, a group created as ports/1/ana_groups/128 is absent
   from the ANA log page (ngrps=1) even though configfs accepted it, and
   it is reported as expected afterwards (ngrps=2, group 128 optimized);
 - 128 written to a namespace ana_grpid reads back as 0 before the patch
   and as 128 after it, and the namespace is accounted to group 128;
 - removing the group again adds a phantom group 128 (state inaccessible,
   0 namespaces) to the ANA log page before the patch, and leaves no
   trace after it, even when creating and removing it repeatedly.

 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 8aea64d..48d3f68 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -701,7 +701,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
 
 	down_write(&nvmet_ana_sem);
 	oldgrpid = ns->anagrpid;
-	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS);
+	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS + 1);
 	nvmet_ana_group_enabled[newgrpid]++;
 	ns->anagrpid = newgrpid;
 	nvmet_ana_group_enabled[oldgrpid]--;
@@ -2074,7 +2074,7 @@ static struct config_group *nvmet_ana_groups_make_group(
 	grp->grpid = grpid;
 
 	down_write(&nvmet_ana_sem);
-	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS);
+	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS + 1);
 	nvmet_ana_group_enabled[grpid]++;
 	up_write(&nvmet_ana_sem);
 
-- 
2.43.0



