Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EA6C2BB40
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C362332A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C362332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/UbFoDp74TMYrueYm+WnxwPgSAtmfAvgg29MGhqPkts=; b=DDViuQS/kiKOP4RyXIM3DH4/c
	l1cGzEyZ6uznPF6g9E1cBP+ujZXMwQv+lPo+HOF99QqEGe99Rxp7oqksr1SqXxJ6Ao8WN77PzkwFG
	aCYLxqsJ94vojcL+63H9k0glijTxQO98rtvtYGEOaHOYdbW76n5Jrni91tPfpMZqqK9M683mufLIZ
	FlKFfl+4t5ADTvnM2NXzCylcT6Ct2ML/y35iKdodhDtXHsYskWRU2WgGVYFwFniinzUJKBzp9t2Vn
	bPnhmBkYnKkQqENCJ+yG4HQsCYnmXdr7dKPrinY/DXEWg0DdPvrJcFligr09ZVjS0FGzeRZSADN+T
	SaL1T7UQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knCAd-0000FL-26; Thu, 10 Dec 2020 02:59:07 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knCAU-0000BF-Sl
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 02:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607569754; x=1639105754;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pJEPnyF2I5BBw39+FFAvKG8fHHiiVVxySNlVpvwZf04=;
 b=WFWQvA7X8svra7GnGp3r3jQPjFMxA4bF2sOhDTq8hF/4tQ6qBn8bk+uv
 XJT8M2wg/XuSWm86sKZvC5ENnj0D7lHO58hne6ahPSYIoDtERAPVemf97
 3HqNeBdnnxs0qL76eOMI4hz7uVEyQJXtqFyCkiT5yXhKV6W84zi0Zf7h7
 ELY0NmoF2lW2o//QAQ2+l9gplbeOkxNXpIGQV1rakJj3aqutkVrZA9hql
 04ZvCYpc3dqwPAc3kRnLqQx6DVti2gp7Fg1CW7xnRgKajcjj48gJwE0FL
 poMx86qcazoMM80OkpEWsG9zHCtZo6stal2EfkcqXq5XxPpFzYHzkGCtm Q==;
IronPort-SDR: AKVmF4hHK34tFRJzkCEWIrPETwdbbeU7/TunLFCTi0/xCrVeQFlBLj4zj3DbbBjQQ07YJGzUyA
 jGaIjr15GvxX+NH8lZHKILphkCI2eoAIIhUUeZ6sI9+4B0/rZNpj+8H9inOIh5NPR2E5C9eifT
 yfR1hSEBb8n33xxQd/5OMzugkl8SU01DQdqZZdsbzPokXA//ZT89f9nofBDiwN8vBfplzNImxw
 nN5DVvv5oEUf8LKm+fwn43w4cCG51IoAQI0buZVyEPCfdzzZ5XApgB2ryzOPoj5WasGGjQlapX
 9ww=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="258549094"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 11:09:14 +0800
IronPort-SDR: TlfVVfsMwmu/cHYCP3RUK7G8BnH0OftTlElwp4vOvCWe3A8XnWLYUQfzEqLCM1wNAH1XHYkdGu
 gR/lSp8cxFCrxZr9cos70KhhHE8hUplik=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 18:44:24 -0800
IronPort-SDR: 5XxdK770HMsXuuaJxx8c/c+N9viHTiLqFByKHQgd2T9V0g2VSxc7vybtOe+/MJZhGR/Cxu4p90
 bz064xGtB3YQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2020 18:58:59 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvmet: set right status on error in id-ns handler
Date: Wed,  9 Dec 2020 18:58:48 -0800
Message-Id: <20201210025848.46903-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210025848.46903-1-chaitanya.kulkarni@wdc.com>
References: <20201210025848.46903-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_215859_141935_83DCF7FC 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
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
index 29438ecfecae..74620240ac47 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -485,8 +485,10 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	/* return an all zeroed buffer if we can't find an active namespace */
 	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!req->ns)
+	if (!req->ns) {
+		status = NVME_SC_INVALID_NS;
 		goto done;
+	}
 
 	nvmet_ns_revalidate(req->ns);
 
@@ -539,7 +541,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
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
