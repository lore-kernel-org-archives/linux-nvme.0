Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FA7C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 04:52:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405D22075F
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 04:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405D22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Beu32lpNj/Bz7k3UVFEA3u01JoI/vmIb4X6hO6TIfhk=; b=BrN/L59IhvdJLyerb+2oeM7lB
	5p0YnOJwn5Ns3R9Mjy8rai8eq+ZVLxAS4QBAm9RkwgN4Sbtdi0CRa5nfSJVU6JtXIiGQF/vFAYx7M
	gjTfQS2bGXLveeZ70v0OM+4cXcNQDrTRwt+9B6QvH3IG5uxmOim70A7ZLymnVHE1uV/QEwg8sQWtx
	vyuvErIA68XxD96BA/XnAai/nmyfBPI0fFrc9fWxldtY23T8ouRfj5ez59pqnDCQVNdjpc3EPlyHp
	QurGPIQD7H4X7bcdyZ8honxgfCujZwo2hRdjJ9c0jPYUXvAqlhg5LGaaR6DOIOh4rufQ/zpf6meT7
	bbyJiwvDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwHrJ-0000Te-9U; Mon, 04 Jan 2021 04:52:45 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwHrD-0000SG-D8
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 04:52:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609735959; x=1641271959;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sFe4cdxjumntlSIxYHRIMddGtmBjNFu9Is0T3KlCg+g=;
 b=d1kqRYPdnLUVsJcDvhnwH9GXsCIRQ1Qf+hcLq5HdvEEQ2RA6j/K1Gh41
 NG9PgkPSXfkzFBnWXy5BDHqu3BhMtAm4EztWvxZwUk656C3hgcjr96fn6
 H963cqGqaHRdPz4+pliSBgivlXQEnh12HcgcEijcJPQm6osr0GWKok0rq
 uiVJxVwqebODAgxc/4xSiVmQB292Q91NhteTBfaemzC9Xfa6le9jbkRg9
 F4YqnKGnsA7rSuSuP/FWkBrKMQVHQnIgD4GsRjImymLgOLsfeLasF4E3b
 Cw3TMMbzOOJkx7dzvTgJpnxpkNdUtsNRFaAfIaqGm/0Io9W8Fd6tCUwQq w==;
IronPort-SDR: rWQwGLPh4vBuakW7XxeFpQXohyTc8jcNFNXzsIwoBfX8qQZWHa1UQakYLbpENlRL/RtAmIz2Oe
 ZDjoE42lm5z00ZN9buqLVDjBvkA3GGUx3jLXhR0skIOm/SHgnRXlRyIWuGmaEFZ1mkmQbbWZ4o
 S+ZZNmvuVpmicyqsENsHeI8QGlZ2CKBZg839QfKpOzzmB2XNDRJi/7upr2fYgIDABjr6gWQDVe
 l2qWSMTF20EehtMxejrtVzd3ScJ/tJjotNj/lpX83R9VSUHsWUXG+uEQ86nsRJ/RryzwvMCYwq
 41w=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="156479888"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 12:52:38 +0800
IronPort-SDR: v7C5F90frI/oyjvE/H4wnULfouISETP+7vv9YbCk7PGS9WWM3ohI0Iir2z09XiZ8KlExYPM3cL
 bxbyZrLPHS76lLd0dUDkMKXPdIkP1YPA5GCbtlEjY2PJr585fEdTgBSAr8jD41kXI07xt+B0R7
 bL/q68cj7ukkXFPQaVUK9HDQSAqocbYKPVm4RCKObxVGQwk5qltaGNc5g7HbjwZatF5zJYPUMh
 EpE8hOKV2v92yY+C7I5YuzjvB2fe6DUk0bAuGOWn6kmA2HwuYCwaCKRD0PdDAm9bioBzQj4dYo
 Vm6YC7WwaxxlpJSmPdeobC5d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:35:48 -0800
IronPort-SDR: rQ8Pe9smeBjPHyABSCY4TnrC+pLJtOTpyI5Zz2I9ccu2RS83b7e1ChR751j6/JKy9OTzhqF6C4
 6sxVf/znYXFz2IDR0MUJaZQ1mhWtFvvUHt9sK0XyoRLX3PtZl3TqtwxCGh0gsqz5YfhWIO2UUc
 xkfciImbcRy7u1RestmBr2bRzlSTkamriX2PAvasCVkw9LASiYb/fU1CVM0La0GQMKbAQVAJmq
 nzNgePxhp/leEfeW7ZoesGO52FtcBxcsSIreZUEUpJOsexj74wOuyATwtndw7ibBsSRa3q24Ht
 svY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 20:52:38 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 4/4] nvmet: set right status on error in id-ns handler
Date: Sun,  3 Jan 2021 20:52:03 -0800
Message-Id: <20210104045203.24472-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104045203.24472-1-chaitanya.kulkarni@wdc.com>
References: <20210104045203.24472-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210103_235241_344625_774FC994 
X-CRM114-Status: GOOD (  15.10  )
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
# nvme id-ns /dev/nvme1 -n 3
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
3fd4a1736f35 (HEAD -> nvme-5.11) nvmet: set right status on error in id-ns handler
4d8a9ebec05e nvmet: remove extra variable in id-desclist
de9e611ac167 nvmet: remove extra variable in identify ns
54165b5c1ca3 nvmet: remove extra variable in smart log nsid
# nvme id-ns /dev/nvme1 -n 3
NVMe status: INVALID_NS: The namespace or the format of that namespace is invalid(0xb)

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 955ca5a653fb..220edacfccfb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -484,8 +484,10 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	/* return an all zeroed buffer if we can't find an active namespace */
 	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!req->ns)
+	if (!req->ns) {
+		status = NVME_SC_INVALID_NS;
 		goto done;
+	}
 
 	nvmet_ns_revalidate(req->ns);
 
@@ -538,7 +540,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	if (req->ns->readonly)
 		id->nsattr |= (1 << 0);
 done:
-	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	if (nvmet_copy_to_sgl(req, 0, id, sizeof(*id))) {
+		if (!status)
+			status = NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+	}
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
