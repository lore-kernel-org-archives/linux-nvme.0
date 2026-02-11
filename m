Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C04EB596B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 06:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z5jwbj0c64SgbwGYjaTxpW4PddcaPKJ9bbwRvJtMhOs=; b=mOTfrn1NUGi3HY4axNv9p05a3g
	VUs9FfKYj34UAj9kpzjoJ1hhTQvC1CL4dJK2/PGzfw0XHXedpohTs3C+mBeoWP9wQt9bKk+yxjgty
	BPc08mTFdBcxF5MTWsyhswLYG+tUhdJGx7y7nX5FwN3o27zf9LUoBsWpSlU9OxjY21V8PU3Tpkons
	sf65jGgdeFJJcQovA2DEyifddiZi5b4q+dVsW3xfUM/+tvhYx5E2q5WW7yijVJ9ddgJ3q+uiHFZe0
	icOdTLfNbwVG4kFqU235kcIN8v3a01MBka5yeHhl9kqLAP1zd0CQrG81pSC7hPDSPSdRBxLfLbwFq
	hw9GiaVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq4CL-00000000J9y-0ppR;
	Wed, 11 Feb 2026 06:59:41 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq4CI-00000000J9X-1W6D
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 06:59:40 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2aad1bb5058so18841125ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 22:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770793177; x=1771397977; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5jwbj0c64SgbwGYjaTxpW4PddcaPKJ9bbwRvJtMhOs=;
        b=Pv1Bm/9Lrdj0MhgKOzywZi4h8t1phumxyOYEkOMl4Lypv/YEIJsXREfw+ZrKXtOvvy
         almmPRAiY7glOOUkmVEiwkL2i41Y+okBbIITFPsxqP7j0yyORjUWyxiDDhlIlEMq1Kdf
         KtS4wSlaDL7Psz4mIiAXe631WJQbs7llQU/LdTGkBY8897h+3LBGXzSRjaDFDvBn9tu+
         b+HKvhloQDrAdvSOm/W4KZSdEDsbhNaPPxyteiWVDaaFQvTY6PUg7pq7phOv1fJFzAiS
         WfW3FxmZT2SBjoCQ2nc3UnHDiGpRgiTpOnQLiT5SMlf2q4ZuiyNhflnPSppCnWnO1I6j
         A7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770793177; x=1771397977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5jwbj0c64SgbwGYjaTxpW4PddcaPKJ9bbwRvJtMhOs=;
        b=QxCSNCaVrrLdC9isQzc0Omh+b8Rp20CaDcTjGUvSpBPP04Wi1eaUVa6zZgQoTYADcS
         7maBFSwFCKZE0j0IKECjwQDSlfNI1vznnyujzfYya13/fYLyHJiywRcftWD9YTSHLcW9
         /Ldb489rQ+3czBn4mgaoWly+mqWhG+rAaPGAO84dsNM2ObQ/h2iA93luHUtldso0ZOdL
         yASpv/hqjWXyx0A2YSMoL2RxItnuffRy5Q2T5sM9SMsJIhILXXBGDfOg4gWMljiQP/17
         /hgNPBfytme3Sp77XOXHFAiiFTRjQXxAcwtqmapiNGsgcFu9CtlBocpkQip5d0nj4KHc
         /EoA==
X-Forwarded-Encrypted: i=1; AJvYcCV5P95FiZNb1LcEE4JbzwOH4eRi5tot+K7HgKFwo1Ux7i2hfey2973UPJJjC/dXogolkR8wFBE10ww6@lists.infradead.org
X-Gm-Message-State: AOJu0YyLM9eI9UNCR8zgILc8NuxJdkHw+P0goYvo/irEUX2lR8sSMaxM
	KA7rG3m6JEdegnPwFykdgTN8AdJLmwZB7ffO8WBEvrq9UjGsPi9Ukj7W
X-Gm-Gg: AZuq6aLK448qPlIIwo8PpU9XGPCKW53VBST38py9SFa6Sqck2BSqHQUs7rb5opKWKxs
	dRYamCSK5LYy03HvTKroys9UVb2q2U7DNtMe9HNXi22/BBFh6CUBjeEpQPO4mm0UOqUsm4FtKtM
	9RLGROMlQMankjTMcvZbl5d0PGNXFD0wtAJKzm6wiMTZAOHsh/yDkZVA8FSEQoy5MmQ0c3ez9jg
	pVi2NoyGNJyVC1uZDYPTlLZqVUs5e2ODgVJWqv2+qKmYECOjX5LQKjjXM9OD/a6PAa/OZxs3fpw
	y/RlYTyFRbcEGA6YwLARlYe5tRdiJOu7A+S3610vspmsLstChakfaVKBtm4D9o8zuDt45W6lCmD
	PDWUZSDcZKc1rh/4Wzo9kWakou4ruiWs3lE/x7KWX9zf9rHVa5ZVZejkKxLqQfNCjaxRGYEeU4R
	eN3Miw4BgqljwebaccktKyusuDVY6HE+lewtzQ/TY52wzg
X-Received: by 2002:a17:902:fc4e:b0:2a7:5171:9222 with SMTP id d9443c01a7336-2a9519ae82amr151606075ad.49.1770793177357;
        Tue, 10 Feb 2026 22:59:37 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab298706c5sm12170205ad.33.2026.02.10.22.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 22:59:37 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ioerts@kookmin.ac.kr
Subject: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN: slab-out-of-bounds)
Date: Wed, 11 Feb 2026 15:58:18 +0900
Message-ID: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_225938_406831_91370976 
X-CRM114-Status: GOOD (  14.94  )
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

Validate DH-HMAC-CHAP hash/DH list lengths before indexing the idlist halves to prevent out-of-bounds reads.

KASAN report:
[   37.160829] Call Trace:
[   37.160831]  <TASK>
[   37.160832]  dump_stack_lvl+0x5f/0x80
[   37.160837]  print_report+0xd1/0x640
[   37.160842]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   37.160846]  ? kfree+0x137/0x390
[   37.160850]  ? kasan_complete_mode_report_info+0x2a/0x200
[   37.160854]  kasan_report+0xe5/0x120
[   37.160856]  ? nvmet_execute_auth_send+0x19a9/0x1f00
[   37.160860]  ? nvmet_execute_auth_send+0x19a9/0x1f00
[   37.160863]  __asan_report_load1_noabort+0x18/0x20
[   37.160866]  nvmet_execute_auth_send+0x19a9/0x1f00
[   37.160870]  nvmet_tcp_io_work+0x17a8/0x2720
[   37.160874]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
[   37.160877]  process_one_work+0x5e9/0x1020
[   37.160881]  ? __kasan_check_write+0x18/0x20
[   37.160885]  worker_thread+0x446/0xc80
[   37.160889]  ? __pfx_worker_thread+0x10/0x10
[   37.160891]  kthread+0x2d7/0x3c0
[   37.160894]  ? __pfx_kthread+0x10/0x10
[   37.160897]  ret_from_fork+0x39f/0x5d0
[   37.160900]  ? __pfx_ret_from_fork+0x10/0x10
[   37.160903]  ? __kasan_check_read+0x15/0x20
[   37.160906]  ? __switch_to+0xb45/0xf90
[   37.160910]  ? __switch_to_asm+0x39/0x70
[   37.160914]  ? __pfx_kthread+0x10/0x10
[   37.160916]  ret_from_fork_asm+0x1a/0x30
[   37.160920]  </TASK>
[   37.160921] 
[   37.174141] Allocated by task 11:
[   37.174377]  kasan_save_stack+0x3d/0x60
[   37.174697]  kasan_save_track+0x18/0x40
[   37.175043]  kasan_save_alloc_info+0x3b/0x50
[   37.175420]  __kasan_kmalloc+0x9c/0xa0
[   37.175762]  __kmalloc_noprof+0x197/0x480
[   37.176117]  nvmet_execute_auth_send+0x39e/0x1f00
[   37.176529]  nvmet_tcp_io_work+0x17a8/0x2720
[   37.176912]  process_one_work+0x5e9/0x1020
[   37.177275]  worker_thread+0x446/0xc80
[   37.177616]  kthread+0x2d7/0x3c0
[   37.177906]  ret_from_fork+0x39f/0x5d0
[   37.178238]  ret_from_fork_asm+0x1a/0x30
[   37.178591] 
[   37.178735] The buggy address belongs to the object at ffff88800aecc800
[   37.178735]  which belongs to the cache kmalloc-96 of size 96
[   37.179790] The buggy address is located 0 bytes to the right of
[   37.179790]  allocated 72-byte region [ffff88800aecc800, ffff88800aecc848)
[   37.180931] 
[   37.181079] The buggy address belongs to the physical page:
[   37.181572] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xaecc
[   37.182393] flags: 0x100000000000000(node=0|zone=1)
[   37.182819] page_type: f5(slab)
[   37.183080] raw: 0100000000000000 ffff888006c41280 dead000000000122 0000000000000000
[   37.183730] raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
[   37.184333] page dumped because: kasan: bad access detected
[   37.184783] 
[   37.184918] Memory state around the buggy address:
[   37.185315]  ffff88800aecc700: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   37.185835]  ffff88800aecc780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   37.186336] >ffff88800aecc800: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[   37.186839]                                               ^
[   37.187255]  ffff88800aecc880: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   37.187763]  ffff88800aecc900: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   37.188261] ==================================================================
[   37.188938] ==================================================================

Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5946681cb0e3..8ad3255aec4a 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -36,6 +36,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_negotiate_data *data = d;
 	int i, hash_id = 0, fallback_hash_id = 0, dhgid, fallback_dhgid;
+	size_t idlist_half;
 
 	pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d halen %d dhlen %d\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
@@ -72,6 +73,15 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	    NVME_AUTH_DHCHAP_AUTH_ID)
 		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 
+	/*
+	 * idlist[0..idlist_half-1]: hash IDs
+	 * idlist[idlist_half..]: DH group IDs
+	 */
+	idlist_half = sizeof(data->auth_protocol[0].dhchap.idlist) / 2;
+	if (data->auth_protocol[0].dhchap.halen > idlist_half ||
+	    data->auth_protocol[0].dhchap.dhlen > idlist_half)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
 		u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
 
@@ -98,7 +108,8 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	dhgid = -1;
 	fallback_dhgid = -1;
 	for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
-		int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
+		int tmp_dhgid =
+			data->auth_protocol[0].dhchap.idlist[i + idlist_half];
 
 		if (tmp_dhgid != ctrl->dh_gid) {
 			dhgid = tmp_dhgid;
-- 
2.43.0


