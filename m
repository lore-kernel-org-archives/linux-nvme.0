Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A721DC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:38:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AEE64E24
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AEE64E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=m24HXv5lSMCJM+Mmk08kMiVGUgUSJe/1+xDtHnNayks=; b=WpFaHfaRRcdxVKVKbhdTagCsw
	Z+263YRV+FhX8FB8ZjwoNLxK+NoP3pWDqZaf3bC02neexPg5wvj0+yhLA6BroUKjVax3PQJwhdEFA
	cE32c4AJ0MhJMCfqXu/ulvXaPv/DfzOygYUxhi2MwCbax/O5wAAxoakob/Ov5+7bW+i0BTJy4SXKZ
	W62AoFP/eJB5gOnUwWxImWX5fZsZu6F+qSA3tfSAo+gbyAMwzK4hTgxRowZIINce7Kf1VWFrFMLEh
	tPbAIWGSTicZKdzaeBdUFbCevi0eq7z284iyv6jmU0JOIyHJh2BBmAmCklATHTf8jb1ouLRDJ9uz/
	lTv/j67xg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5VqX-0006bW-36; Fri, 29 Jan 2021 15:38:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5VqE-0006TK-MX
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 15:37:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 499FB64E1E;
 Fri, 29 Jan 2021 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611934666;
 bh=6J9ZmvFEAaG3oGT7LvaoN/qHHjKYIo5xf1ysxtlon+g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NftDOERJQWIcx7FAzhF8oCXIz2AroYXlg/8KXw7Z6tLFK2x3vJx1CP3/TukHzwxjk
 En1F2zTpUBC5P4hfz387M0l7s2eO9vrO62WyTSrV3Sp7/5OhdpAuC15s1JGYDvMcRV
 MznjcD6nY/2T3BoMtFDe6njXsZmErw56LSVD1PwkstLn+juJY/Gk6bdHnndEHxtLDY
 oDBTyKy5BYY/zNZpTcizBLnsmZj+MDLCTbY/4Ebz8d/8tTLkX1NTYpvSvRLem6qezN
 BYEAEk1sseDTpJktnrx3ufmBCARHzQJkBz2xQCNdaq39/5fcjPPF9pTtOW10FpXv2Z
 0d8JxarcBof0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 26/41] nvmet: set right status on error in id-ns
 handler
Date: Fri, 29 Jan 2021 10:36:57 -0500
Message-Id: <20210129153713.1592185-26-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129153713.1592185-1-sashal@kernel.org>
References: <20210129153713.1592185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_103746_845681_C9A130C7 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit bffcd507780ea614b5543c66f2e37ce0d55cd449 ]

The function nvmet_execute_identify_ns() doesn't set the status if call
to nvmet_find_namespace() fails. In that case we set the status of the
request to the value return by the nvmet_copy_sgl().

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
feb3b88b501e (HEAD -> nvme-5.11) nvmet: remove extra variable in identify ns
6302aa67210a nvmet: remove extra variable in id-desclist
ed57951da453 nvmet: remove extra variable in smart log nsid
be384b8c24dc nvmet: set right status on error in id-ns handler

NVMe status: INVALID_NS: The namespace or the format of that namespace is invalid(0xb)

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dca34489a1dc9..92ca23bc8dbfc 100644
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
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+
 	kfree(id);
 out:
 	nvmet_req_complete(req, status);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
