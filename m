Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F7C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 12:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QY2K1/YQxAlSWF47sl9r9mh6hui04/UAdmJGCH2Qmj4=; b=oH5/DBI5URGYwVrQhVgpyVUaoc
	SWWhvEtn1cqAcCZklL5MWZ9xOLtqtoSNjzCaUbpVIIj5JWoSVS7tY7D19iGVFwwGPOof4ggT1rD3g
	G/Dywu48rDFhSaCoISDL/5Qfli5kPF4z/svpBC3D+OmCe1s9XZ0bJ6XOfeDncORGc2+8KMVR9Q/CW
	ag3/UVRvMI510/ihe5qB+/bAWhWfTw8wVECjOWSxQHDffivF17LKZYXXScmsVIkrZUBCLB+R3LkjI
	V2peGJcFSPhAFgO/b33FaKnem+Tnf5mLkc2d7lBQNxLMUhRTfhaWBaN+lL1Acrla60dSDu+Lh/gn7
	KcEl4b6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rArUN-00AKyp-2m;
	Wed, 06 Dec 2023 12:58:55 +0000
Received: from forward100b.mail.yandex.net ([178.154.239.147])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rArUJ-00AKv7-2f
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 12:58:54 +0000
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2a7:0:640:d5ba:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTP id 6861560ADC;
	Wed,  6 Dec 2023 15:58:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id awbwOREoAuQ0-uRSLF4Fp;
	Wed, 06 Dec 2023 15:58:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1701867516; bh=QY2K1/YQxAlSWF47sl9r9mh6hui04/UAdmJGCH2Qmj4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=XJiCztpqrON8fzSNXl/QRtqS0C9e1Hs5OjxqqU61FB/dvmz25bm9j8qeuEeZBD6rW
	 aU5XJsuxwjJdYJL/UfKdTlG6kDqy5oTksGplqhJzJ9j9FLK4wvaJyYM7c1V9O+WfAB
	 tb3wwIqRqVxs0k+KGcR4py8BvlsbM2S1rpXk2E6M=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] nvme: fix fortify warnings
Date: Wed,  6 Dec 2023 15:56:57 +0300
Message-ID: <20231206125711.619739-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_045852_646081_1CCCA0F6 
X-CRM114-Status: GOOD (  11.56  )
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

When compiling with gcc version 14.0.0 20231129 (experimental) and
CONFIG_FORTIFY_SOURCE=y, I've noticed the following warnings:

...
In function 'strncpy',
    inlined from '__assign_req_name' at drivers/nvme/target/trace.h:56:2:
./include/linux/fortify-string.h:68:33: warning: '__builtin_strncpy' specified
bound depends on the length of the source argument [-Wstringop-truncation]
   68 | #define __underlying_strncpy    __builtin_strncpy
      |                                 ^
./include/linux/fortify-string.h:147:16: note: in expansion of macro
'__underlying_strncpy'
  147 |         return __underlying_strncpy(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~~
...

and:

...
In function 'fortify_memcpy_chk',
    inlined from 'perf_trace_nvmet_req_init' at drivers/nvme/target/trace.h:61:1:
./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  588 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
...

So replace unsafe and deprecated 'strncpy()' with 'strscpy()' and
pass 'struct_group(cdws,...)' member of 'struct nvme_common_command'
to 'memcpy()' (just like it's done in host/trace.h).

Fixes: 5c629dc9609d ("nvme: use struct group for generic command dwords")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/nvme/target/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 6109b3806b12..2d5e75643e6e 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -53,7 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
 		return;
 	}
 
-	strncpy(name, req->ns->device_path,
+	strscpy(name, req->ns->device_path,
 		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
 }
 #endif
@@ -85,7 +85,7 @@ TRACE_EVENT(nvmet_req_init,
 		__entry->flags = cmd->common.flags;
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
-		memcpy(__entry->cdw10, &cmd->common.cdw10,
+		memcpy(__entry->cdw10, &cmd->common.cdws,
 			sizeof(__entry->cdw10));
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, nsid=%u, flags=%#x, "
-- 
2.43.0


