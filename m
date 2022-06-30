Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09104C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 06:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=EdY9sSNeQ6fSKtsBW9nFeRY59fbPs9KPNAfeqYvbeXM=; b=FptV6V01wx7HVH
	+Kb/q7YFDKiZ6gfshzIFD0QDznOPun0BYqi1BKJM3huEolbbrDVOJSIn57ArZZBTebxkYq149r2K1
	VZTC0w+ofCfA7yTSRUb40B+E3pmulTCmEpXPRVwf0faX+Y1PM0z/6u16RaRY4MdgkKkbv6264eloI
	2Z1weQpfZ2E+7Ob00ir2Vj20cKfZBgeJOQ5OLwhVu0g5H3m3xJ17xi0zQXXL08cPsV/BqqOSzrUBF
	fQgbxfxwg/bf2AQY8Be5aE0ebQq4kGHPoBfTWUSXXQOAAHFrSNSUGG4rN8XFZPzNObTGb8PaNPKwG
	2TxOZwT4r27268nVjxtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6nbD-00FVmB-Mu; Thu, 30 Jun 2022 06:24:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6nbA-00FVlm-O0
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 06:24:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67D7168AA6; Thu, 30 Jun 2022 08:24:13 +0200 (CEST)
Date: Thu, 30 Jun 2022 08:24:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <lkp@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [linux-nvme:nvme-5.19] BUILD SUCCESS WITH WARNING
 4db675888cdb7b24812e289d7f90e7928dd400a3
Message-ID: <20220630062413.GA6635@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bd3b92.UluA72FI79OFZKgS%lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_232420_971145_B49F1036 
X-CRM114-Status: GOOD (  15.32  )
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

On Thu, Jun 30, 2022 at 01:58:42PM +0800, kernel test robot wrote:
> tree/branch: git://git.infradead.org/nvme.git nvme-5.19
> branch HEAD: 4db675888cdb7b24812e289d7f90e7928dd400a3  nvmet: add a clear_ids attribute for passthru targets
> 
> Warning: (recently discovered and may have been fixed)
> 
> drivers/nvme/target/passthru.c:54:16: warning: variable 'csi_seen' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
> drivers/nvme/target/passthru.c:57:7: warning: variable 'csi_seen' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]

I ended up fixing this with the patch below.  Alan, let me know
if this works for you:

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index d71ed297ad16b..6f39a29828b12 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -33,10 +33,9 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl)
 static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	struct nvme_ns_id_desc *cur;
 	u16 status = NVME_SC_SUCCESS;
 	int pos, len;
-	bool csi_seen;
+	bool csi_seen = false;
 	void *data;
 	u8 csi;
 
@@ -52,26 +51,25 @@ static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
 		goto out_free;
 
 	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
-		cur = data + pos;
+		struct nvme_ns_id_desc *cur = data + pos;
 
 		if (cur->nidl == 0)
 			break;
-		len = cur->nidl;
 		if (cur->nidt == NVME_NIDT_CSI) {
-			memcpy(&csi, data + pos + sizeof(struct nvme_ns_id_desc),
-			       NVME_NIDT_CSI_LEN);
-			csi_seen = 1;
+			memcpy(&csi, cur + 1, NVME_NIDT_CSI_LEN);
+			csi_seen = true;
 			break;
 		}
-		len += sizeof(struct nvme_ns_id_desc);
+		len = sizeof(struct nvme_ns_id_desc) + cur->nidl;
 	}
 
 	memset(data, 0, NVME_IDENTIFY_DATA_SIZE);
 	if (csi_seen) {
-		cur = data;
+		struct nvme_ns_id_desc *cur = data;
+
 		cur->nidt = NVME_NIDT_CSI;
 		cur->nidl = NVME_NIDT_CSI_LEN;
-		memcpy(data + sizeof(struct nvme_ns_id_desc), &csi,  NVME_NIDT_CSI_LEN);
+		memcpy(cur + 1, &csi, NVME_NIDT_CSI_LEN);
 	}
 	status = nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
 out_free:

