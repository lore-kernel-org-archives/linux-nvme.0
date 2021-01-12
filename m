Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8099C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:14:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B32623117
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B32623117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pYhFwPD1ROuonof3Lw4EsvGXttlcwycVhzijkYxD0+I=; b=f+4OWRPJYw464kn0ZK+fctUXD
	QbUA2+9ZLGhyIjMxjTnUgvufAxM9/8C9fTVegTC6S33tD7mRLyAvVLAKKzg4nJnv8pbvqDGxN4gdh
	71T782EDJH2Okj5GLJ+iLZh6dEgj+n/AjpupyN5mMA8icg7BlYuYObw/8xN8j4cFxMrDFyet5FahH
	xAPq3K02xs6MFuvi3YGYMAP0NC7LLQMk21C9JGl6TcK9US7eblCpGDzPjb7uNIn79O4pOYcDC2WPB
	TnSCKw2GrwMuc2oLm6PwZYFHwKvKItDfcjt5A27XSVfWrMW4hhzN2fDqMAJT9QbkYHWH+WqIOTuEX
	JBDzcKjlQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzQzj-00050C-Mt; Tue, 12 Jan 2021 21:14:27 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzQzg-0004yJ-3f
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 21:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610486064; x=1642022064;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b/12PgxquWqvt/jeYG+xJltDakk/g4iLJM95DjxiUa8=;
 b=oeQBI6bDvdARsc+lE9aOfyMJlWQHrvAk9lelZyzOZ1zAqy1WoyJPHpXw
 /ktmajw3UaYfBe4f1SdeiwdWZWly0keUt3gQgwMdxDrgW8txJpP3o81dS
 6waLNojM7Q6R88LCoXgbC4Gj0SQGyNWxm1Qo0XUL3359mzssKVourqxq3
 T2SYhtU0wz3SS+Qp/35fnptCxZX5FQAmRAGTRh+qS+xj1JQtaJITtd8qF
 aSt2b6eSA8c+HW7w8MkOYTz3i42unzCHJfZUIPwPCb2LVY5nNj2X5x+/v
 0UqMjtEREpvo6EZn7CpVNGSjoDARXXKlUHjIVD4R4XTFebBJgc+OnhDrV g==;
IronPort-SDR: opmdclMJOCod0lPk/zt3k8noEw749gym/Ko3DrkHp8YmdvzpbhC3Q5tqMhvOExewL8jpnQ44N8
 OcIC+wO7f0Md2WIh/RUESHnrxjUbUvR+U8BANPhWbh74N72O8YslmjwfE2Iq+uyJkkBVbUxAMV
 Mal1C3zEZZ7XwKR08lUXDvYxLRyYo4z/YqNGOnc/t713MNn3Pu8S1bgrDjgn38VQmpkqT4f339
 YzNRzA27E5grqSPboSBKy5F+c+0oTZ8R7ITFCkdnErC3fFvZrLhrtUKhvopFZGtzB/7qpGrJcM
 fDI=
X-IronPort-AV: E=Sophos;i="5.79,342,1602518400"; d="scan'208";a="267576961"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 05:14:22 +0800
IronPort-SDR: x51iqrkuPAFL/yZpTXjKIuczsoVutCRkSR2XN1A7oUOxQJbUxSse1IDtwz6dB8cTtwWrxXzmHX
 glFpVQQZrjcqW8wluwoj6qg/mcoLXmSkzObSUn287k3QeK566A7FbqxsBHpZZlJhVTN6HvcM/0
 EXVT757mWEscxmjglNDS3zo4R7Lom/LQdwiKQY/lygRC0P0BbE0NG4LJ35mJ9KA7mq/H1d79Sl
 ImMJK//xUFDf6guanj+k2yQ7yUeLCtMBIwTqqWLEPYi6JfbBy5B7rz7I3JnGcjrLr1EhwTnaLi
 wRRZ0QyLyDCBSRQCfM3s3jlU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 12:57:14 -0800
IronPort-SDR: MJic73WdNE26BHBg70nOsFWl/fkMR6yxV/Q6XEVbgqwPk8UEQroysQZu+XjIiJY8aAQuQpGJoe
 7kPFWN2Fzb5Fg3TV4skDWhFZkTfg7LCPUF5bBRmPiOOMO8WYDdkYVZ+0ByYyY/82Nmla8+80k/
 tyFVyIgxTRbv1zebClbnTIar73DItI7CGioZ72YStKvtij0RNUcOaA4fN+ZLs+Mo5l9OfC2raE
 OAWzCRwevuX6OdxcK3PvEC5fw4LSbSBf/VPCn2ZMIQ5I2XzAV7SNU6Nj/dEqgZP5EDWbpnvZWR
 BHI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Jan 2021 13:14:22 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [V3 1/4] nvmet: set right status on error in id-ns handler
Date: Tue, 12 Jan 2021 13:14:07 -0800
Message-Id: <20210112211410.24742-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
References: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_161424_344169_42EBF196 
X-CRM114-Status: GOOD (  15.42  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_execute_identify_ns() does't set the status
if call to nvmet_find_namespace() fails. In that case we set the
status of the request to the value return by the nvmet_copy_sgl().

Set the status to NVME_SC_INVALID_NS and adjust the code such that
request will have the right status on nvmet_find_namespace() failure.

Without this patch :-
NVME Identify Namespace 3:
nsze    : 0
ncap    : 0
nuse    : 0
nsfeat  : 0
nlbaf   : 0
flbas   : 0
mc      : 0
dpc     : 0
dps     : 0
nmic    : 0
rescap  : 0
fpi     : 0
dlfeat  : 0
nawun   : 0
nawupf  : 0
nacwu   : 0
nabsn   : 0
nabo    : 0
nabspf  : 0
noiob   : 0
nvmcap  : 0
mssrl   : 0
mcl     : 0
msrc    : 0
nsattr	: 0
nvmsetid: 0
anagrpid: 0
endgid  : 0
nguid   : 00000000000000000000000000000000
eui64   : 0000000000000000
lbaf  0 : ms:0   lbads:0  rp:0 (in use)

With this patch-series :-
# gitlog -4
feb3b88b501e (HEAD -> nvme-5.11) nvmet: remove extra variable in identify ns
6302aa67210a nvmet: remove extra variable in id-desclist
ed57951da453 nvmet: remove extra variable in smart log nsid
be384b8c24dc nvmet: set right status on error in id-ns handler

NVMe status: INVALID_NS: The namespace or the format of that namespace is invalid(0xb)

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8d90235e4fcc..9bf1fd6933cc 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -487,8 +487,10 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	/* return an all zeroed buffer if we can't find an active namespace */
 	ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!ns)
+	if (!ns) {
+		status = NVME_SC_INVALID_NS;
 		goto done;
+	}
 
 	nvmet_ns_revalidate(ns);
 
@@ -541,7 +543,9 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		id->nsattr |= (1 << 0);
 	nvmet_put_namespace(ns);
 done:
-	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	if (nvmet_copy_to_sgl(req, 0, id, sizeof(*id)) && !status)
+		status = NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+
 	kfree(id);
 out:
 	nvmet_req_complete(req, status);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
