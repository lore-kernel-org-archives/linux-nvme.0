Return-Path: <SRS0=77Bv=24=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792ADC282DD
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 21:42:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F17B206DB
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 21:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E+rhcorD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F17B206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OWWjTN2dC0Dk53hFvhcB0rYSap4sINIO8ptZgR0aoEc=; b=E+rhcorDFe1S9P
	tpULiFice1k6jK0Y93aM0WIWqrRCmm7UfDH5WwM+YsR+Rex3pyBhKqY/BcUUK96RVe48ThOKqwj1o
	J06+RQOhuyZwBrKJCro7GT8mcpq5hRpgEji41gQr4zjWShmkyYHeHPe0WTR81OQl78qU510DsedCN
	U0Grlh4IOk+vFUXWBoDSvXhf0BwWfEk5tekrirMs1SBxFTZsRtiJiCBtaYPmLz+qx2M1VLsKUDz6e
	OgCLKGolf2kE74T1ziX0lxf8oiDWKZRkIIe9VsnpOEObkW0ShggZ3kJplq/DvI70SLfxr6BAggxB0
	xtxLCi4q3N0QAFH4tCBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iowco-0004Zz-Sw; Tue, 07 Jan 2020 21:42:54 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iowcX-0004Jf-AI
 for linux-nvme@lists.infradead.org; Tue, 07 Jan 2020 21:42:40 +0000
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MT9zD-1jH9nj3H5D-00UYa3; Tue, 07 Jan 2020 22:42:16 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: fix uninitialized-variable warning
Date: Tue,  7 Jan 2020 22:42:08 +0100
Message-Id: <20200107214215.935781-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:043HDHrfAGyhHtmaDtlYyEpE8s5+9wdoNLWS/8OShhwdhjC1qdo
 u12T7hghyb/GDuiHprzuItewQyd1Y+20xuo0WR23Bo3fe1Gb4pSuW/uQajaD6o/Fa9s5BBA
 KV+r5kSVBdMFuYdfaE1hYgO+ccrMa+DeAj635Y2khM1B2QUyjQ0obF6RE8C+MnY5oJFRUCC
 WWijyA4wlaN+VrzPVvRMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mPTXboQZzNY=:zErWC3Q6Kms29bP7mGKw6q
 V9R1VjmR7OQkMczbvn7qcMThBpaTIf+xW8jGazvJyHLKQUR1byi8VhQIUqPi/CItYnRywm277
 DBUH6+LDiOdEpujdIW01gZgNlpN7JWBbV5cc368RJE3IEa0uZXJWeG3otxpVgwSGJMb+JmrlV
 L2Dy8Fz1C8dO5mAQbt/Q/GRhJ8hjwetQMWzD3Huzla38VUVDvNQYjT49v2BK1J+pMK8Qlb8WH
 oKflABu13THng4yOJFRpKr9xH71RvhA4IXBPaSDsoBvzIbGUZElriyE1oDLsyFEJ9ImO3t50X
 CrIRFhl/yNj3U5RLaQUUcvryU5Ug9dPfXXmo0Oqk0uOqbt3uktQfdJcU98zMa6QndWi7t9NGK
 58lCY98ag6YF+Ci9S0LFf+8pemvNCP67AEUthYMW29Qbd0qPs6wWTb3zbc4Qw6etugckZuCyC
 xgu6MCn23i+FqKtwu7AhAaZ/u/2XlZZJIWDm8VoPKQLZk2IicnsW6PaMxM1AN+CycgHeMViw9
 4p4fDmjkUsn4m7MqZA1/YtZIIjvnYlh6T0LiaDmcpLbEuGP6AxY157XaG1biWVjTEmiZp4mbO
 v/b9tnieNvaAHh+VgobPyZpWqOgPpiALKmz1AX7CNXgvBsZRwJCE9mgQVvtNA414RrAWcKQ4L
 Ji4KGfEQJqZc4J3CymDrSkf+thWcM4+9aibGn2dCCgxWqvz3LLazPQYeQiKVg1Oj4+xXVppTq
 rijk6gzfiVtxZm1TLoJd0+MV5SJgLfQYhyOJ9vLlnjKw0DC3ybVLrEJKqxvE4yQ5cwddNNT0K
 J5T4QyLZHoPijiwVsfHRMg5DJ1DC449xXUrnyTTxBXHSnWAFAOWe+GKU+edJJcYT6zmzZLOKq
 5aImhuBfDYv+b0agZViQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200107_134237_676656_C5C8B68A 
X-CRM114-Status: GOOD (  11.10  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Marta Rybczynska <mrybczyn@kalray.eu>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

gcc -O3 adds a bogus warning in this file:

In file included from include/linux/compiler_types.h:68,
                 from <command-line>:
drivers/nvme/host/core.c: In function 'nvme_set_queue_count':
include/linux/compiler-gcc.h:71:45: error: 'res.u32' may be used uninitialized in this function [-Werror=maybe-uninitialized]
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                             ^~~~~~~~~~~~
drivers/nvme/host/core.c:1167:20: note: 'res.u32' was declared here
  union nvme_result res;
                    ^~~

Slightly rearrange the code, enough to let gcc understand
better what is going on and not warn about it.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 667f18f465be..6f0991e8c5cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -825,14 +825,15 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	int ret;
 
 	req = nvme_alloc_request(q, cmd, flags, qid);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	ret = PTR_ERR_OR_ZERO(req);
+	if (ret < 0)
+		return ret;
 
 	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
-		if (ret)
+		if (ret < 0)
 			goto out;
 	}
 
-- 
2.20.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
