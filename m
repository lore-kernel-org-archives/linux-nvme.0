Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C760A2636
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JG7NJqOJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BEYuLgvu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EYSAYLomRkx00Riws69w3PNAb4pgR9omSPOZniDwcNo=; b=JG7NJqOJgJhQHL
	GX6+lu41HORxJt8ZmJALAfGIitKsJL023At19RUCT7ebgm4GmXXYVKYxrEUFbX10FbcpyljP5gZTP
	h+IYBIuMoVbtPvK+PCmhmASXWHknbhn2aMv27ew7gpNDqkbUvwGwc89WmtepivmERGUH+UNIJzpWt
	re1+hBXSiK6y0sE5Jmjlnq83NCshGEAhEGjpGlWyI6YfKLVSkISPKnPe5kOab1WBcN5URpZdYL4pg
	KLXvkqc9L+/7yuhlpdesLINb074uSS6yp8/NOPwdv8OfHEqSYysm1HGMz4wZRQdac0cDGt7gvcG6v
	mnYviqFiXxDzbjZJKfsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsrk-0000000ECWS-0vjf;
	Thu, 22 Oct 2026 13:29:56 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsri-0000000ECTS-1IIA
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:29:55 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so6007035e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792675792; x=1793280592; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYSAYLomRkx00Riws69w3PNAb4pgR9omSPOZniDwcNo=;
        b=BEYuLgvu6OMcdYG++ZyKBeUMmmtZTiF5RzBOrNtc/jwyThMztnP62mo2lPgygLgZPK
         DCEtf1Uc5784gAjkeEkSS8hyD5bDySXuuOlTaRhJjgt4ZM8lu93gn1u1GbDOQ78GUnQU
         ED2SzThFrCQh2SoPPdVvJj9+TQt9rZ5dgYNKFYOCHKgHI5jUr+8MdEEdT85mnqa7XijR
         Gyl8vUQj8lilJz2VLEIhBG59w7NzXJgY2UGtcgDu9Fsm+v/8eZrnsmZyn566jI86NOHX
         n3oathVtfpUhqtHfxhggQOB1HwF0inmDxr4fxzpD7QF8BRPENu2HI9UwDBHKk/Q4FPpq
         cIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675792; x=1793280592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYSAYLomRkx00Riws69w3PNAb4pgR9omSPOZniDwcNo=;
        b=miKmhYf7Asj5X6vwZpBXgr0Gs55TDOI/t+aZU/oAd25JaWMRcBejvm4WmRtZnzAhQH
         FliVDxG/Igy0zgVXTpHRxqzwUU5d29jiKv94SvaCQf7aOKey4TZ5Ar9Y3QBbdPWDC0Eq
         JFrXwJr1zsiN6upezDSIBYW0J+4y/fzErbiakHHF0PXuyMCvFDiPiu8KM/llmFn5iyNE
         9IyYtNeufvFGchHFNQwKzGTnrZzojOr/gsPOzayCU0s8cVc3LDf1xLXD2ECRRaR9Im/x
         0VPICKN3gLJGGvo397bngIp1Gk+iW/WAw7wlZqpK3UP3MlU9J31QhyfqKWSHwKRG2Uzz
         uMrA==
X-Forwarded-Encrypted: i=1; AKwUvBzauHJtpuiVqbMvK2DuVyoeCCbbG6iW1mXS2XdyFUIAU24gvr97o3gNmD/de4jmDZ851xXHmXuGmfAk@lists.infradead.org
X-Gm-Message-State: AFq9FYJ8O5D3ws5FpwgcI9J7JHpz7/mPvTDKiWhBFWh9iENvccFSg2de
	WYxPY0Rb0qPgGU1Y/Pw34ae2WBbHowaYg3L61hwZWR0cErAbrbBeIBTF
X-Gm-Gg: AYBFou3ANafhhW9nVXxus44vWYI4LYYDt9CduKTxVT7dkm3Eh6qsKqTr4Sdfqrt848H
	CM200f5LVXUkH82IIp2v1EWOJ2R0PeZ9tpJx3kV44cVpAYE08Si2PJhgPZtfcrYkN8GUPOnmK9M
	kdkcf3Khzw8ZCs421cvgRWy1yljuNxdOpRTjIb7KCeGzub8SxPtRlTqajPfdHfM/hZrVPxYiYY7
	hIBza32KRDohWyyvnhuDd0ZBmyCj0WYuHGeU4fsyZHw3sOhlDQb+DlEqM7msdloUjw9jnvxNUD8
	khkMdSNfjvFZvYKtdOlv6C17EWejQlSUQz5vrHZkdFDvwXXnWx8jfUUQexsWqAj3NVJMVDvbqcO
	zA88gi3RxWtEBNV+PjkMtVYgYfdYxNK8lVrDFN74PJK09BmiQaEUxNBgT6WHKtS6wtNdcaG2c22
	N54z9FDRx3SPk1afg1LpfonCuyte2b+5HQd3BlLo60IXrH2Lu+T0ohH5EjESQVce1jHCYvI81VO
	/l76kEi6opmGjVdf++4sBvMiyuYTEA8/PB6BQ3AmAuQNZo11msnaMQD3uocVhUImfXCpT31Ksyl
	Y/cM0OQs/XjeZKvUVIx8BgGy
X-Received: by 2002:a05:600c:8b4c:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4a20729f92bmr40185675e9.8.1792675792204;
        Thu, 22 Oct 2026 06:29:52 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd629bbsm108832715e9.5.2026.10.22.06.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:29:51 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] nvmet: zns: reject a NUMD whose byte count wraps
Date: Thu, 22 Oct 2026 15:29:31 +0200
Message-ID: <20261022132934.3592924-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132934.3592924-1-parri.andrea@gmail.com>
References: <20261022132934.3592924-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_062954_397711_486C0C01 
X-CRM114-Status: GOOD (  17.63  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Zone Management Receive computes its buffer size as (numd + 1) << 2 in
u32, in nvmet_bdev_validate_zone_mgmt_recv(),
nvmet_bdev_zone_zmgmt_recv_work() and
nvmet_bdev_execute_zone_mgmt_recv(). NUMD is a 32-bit dword count, so
any NUMD from 0x3fffffff up wraps.

The data length check in nvmet_bdev_execute_zone_mgmt_recv() sees the
same wrapped value, so such a command can pass it. A data length that
does not match the wrapped size is already rejected by that check, with
Data SGL Length Invalid.

Every site agrees on the wrapped size, so the target zeroes and fills
only that many bytes and nothing leaks, but it answers a command whose
NUMD asks for 4 GiB or more.

Reject a NUMD from U32_MAX / 4 up with Invalid Field at the start of
nvmet_bdev_execute_zone_mgmt_recv(), before this handler or its work
item computes the byte count. A size_t computation would still wrap on
32-bit kernels, where nvmet_check_transfer_len() and req->transfer_len
are 32 bits wide.

nvmet_io_cmd_transfer_len() in core.c, which the pci-epf transport uses
to size its buffer, computes the same expression before this handler
runs. Return 0 there for such a NUMD, so pci-epf allocates no buffer and
the handler then rejects the command.

Tested over the loop, tcp, rdma and fc transports with a zoned
null_blk namespace: a wrapping NUMD, sent with a data length that
matches the wrapped size, was accepted before this patch and now fails
with Invalid Field, while ordinary NUMD values still succeed. The core.c
change only affects pci-epf and is build-tested only.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
v2: check NUMD at the start of nvmet_bdev_execute_zone_mgmt_recv() and in
nvmet_io_cmd_transfer_len(), before any (numd + 1) << 2 is computed,
instead of in nvmet_bdev_validate_zone_mgmt_recv(); this also drops the
over-long comment line (Christoph).

 drivers/nvme/target/core.c |  3 +++
 drivers/nvme/target/zns.c  | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 291d782ce5442..2e4e066ef6bac 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1093,6 +1093,9 @@ static u32 nvmet_io_cmd_transfer_len(struct nvmet_req *req)
 	case nvme_cmd_dsm:
 		return nvmet_dsm_len(req);
 	case nvme_cmd_zone_mgmt_recv:
+		/* The handler rejects a NUMD whose byte count would wrap. */
+		if (le32_to_cpu(req->cmd->zmr.numd) >= U32_MAX / 4)
+			return 0;
 		return (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
 	default:
 		return 0;
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 78d82b6ff1214..92f5c1435582e 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -322,9 +322,17 @@ static void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
 
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
 {
-	u32 out_bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+	u32 numd = le32_to_cpu(req->cmd->zmr.numd);
+
+	/* From U32_MAX / 4 up, (numd + 1) << 2 wraps here and in the work. */
+	if (numd >= U32_MAX / 4) {
+		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, numd);
+		nvmet_req_complete(req,
+				   NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
+		return;
+	}
 
-	if (!nvmet_check_transfer_len(req, out_bufsize))
+	if (!nvmet_check_transfer_len(req, (numd + 1) << 2))
 		return;
 
 	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zone_zmgmt_recv_work);
-- 
2.53.0


