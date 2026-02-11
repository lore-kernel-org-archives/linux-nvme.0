Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52303EB5967
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 05:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j/6pkAHIj9F6wIg9mEEcLvUsK9XzM95fb9c/+NnfMZA=; b=xQvAIES7CTyEUu9E5FonVk389o
	hwe4rjIwa+hh5mTkw8udNKtifd7F00ZdwipsD7qCLe806ma0ycEjOebs2/CMSSDtxEQ2EeB8UDBEk
	QLaw1GFDyozMyNfmluPVb7l+YibMg7f0gozDa+AIx53267buDnS0ZW3vuBopXU6AHP6LBzNK1L+tM
	1mmekRo4xeX6LxaRyzA2KyGd56Ido3HqFWi0/TT7NVSrEegrCC2QXBM3a/+AjOxEDVOIh6881vyZx
	b/qemcjwPGr8Ia52rwM+0XFWohCD/dioefNSwFFuLjD9aQHpc+TIujsxUUp2VWHZcGlq2ni8boaxZ
	G64r1P4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq37i-00000000Gei-3SqV;
	Wed, 11 Feb 2026 05:50:50 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq37h-00000000GeL-0AFD
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 05:50:50 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-34c868b197eso5011211a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 21:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770789047; x=1771393847; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j/6pkAHIj9F6wIg9mEEcLvUsK9XzM95fb9c/+NnfMZA=;
        b=iCqYCKScUgdsqgLXJLYM/dH6s8VoxQadhG4UBhEa1aeVyFbXdNtbPD5wm1CiPJwvHZ
         ixq6mcgdaFfpBVbGcS4sJ8kLfZTSSydOdBtrCXLtN1sntHlf9oCl59euy3C/RFuHbQg1
         zNZHrnwPH1mkKEHws1gwlpX2LVyMvuyGXuKEN+4bkckNVrv2GE+AXqHJlXVXooMFIBez
         zFM79zXygMznrZjzU9fYqlMEQwDgeB6CIbzJvmfT08guvBqLwoOKfhzIzF9kwOa0Y7+3
         nrFW7EKrrjpseFQH/RqkFaDO2T29O1ibfo54EQSEki/5YJ+FWnbi4goD02h6vhd86u5G
         lfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770789047; x=1771393847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/6pkAHIj9F6wIg9mEEcLvUsK9XzM95fb9c/+NnfMZA=;
        b=s605+ek1p9MwfChnYioN1Eb1DES8yZJGfsj7R7Izq2AEtx28cKdB9Wlg7tTTgqfyPi
         4snyC8QrPb0OXOICbOs0W/olAbOnZW6aLigbyee7P7Xig1DwAJ7jwTi82GxJ6ScOE0Nf
         TrojVmX1wvW4ATZESuQpeudD6jAiysLo9q3I+a16wUsvkotv8fjSU3XEIn4uOusYL5zv
         xlcCZ1o0OOMH3s0Qk3KJgWIXzltWbxl9Mbn5Zr5DoODPMJRVnyzA1BHB1xkwl3PLNTSE
         hGUcWIMneoEUKfHx8BfMQXfnlGlV6FB8MsvWU2brxE+6ArNk+WaI7vhxvxxIzaHwUAI/
         ojsw==
X-Forwarded-Encrypted: i=1; AJvYcCWIxY+dN32JGuMX1GwNxKdOod/hXVACtZONqd+/ijcBP7YA2OcKP1IgaheS0dq/j3vAT8AW7GuHJOVw@lists.infradead.org
X-Gm-Message-State: AOJu0YywMJNyEMrRMsFjS48DVkLot/l39Udin/9vOsHE0B2hS8gb9Hew
	vgrSXIHhGSawo0H+1YOtUxHiamo6/P8rq32YH8Csp3XGoGvA7Pw63zMW84nMqQ==
X-Gm-Gg: AZuq6aJ6mgYLrOxrRlNmHa3QSUc3dgSC4zpoEJPZvAVPjEeQmLBaH3E7Xhp73dM1H0w
	US+6gM8nksain0jU0UirOIwfJM529p0y2XBAYj7B9ORYWoy7ZKW91Fe2A2PvG4tl08PUEMmBfZ2
	esWm67AkrZ8mKwiB3VbsUeN83Gb3yMRmIqEyOkxQSpg6FpW6yiLRQmzWVRz50d5Eudsfz67aOCS
	PlFWuJidNLqk2FDr+piTIqNBBp5F74j5PnxDw+DgWL7wCveS5pBavi9OHfWSYrMKVBHArzAk/gn
	PwyqhD5M2D9UHZYgkSI1OjXzYZeIKcwNTTKHOz72k7EZ069UgCezIhhCmGMGmLb5NHXKmpchLSv
	d6u2Kydgwoxt5iv00dAkiEPgSKrhUDA66DClAvVaoIiOGHXymcEonIoQxAJfzbP5Rp8EgITaoDZ
	Fa+nW/4nayHDE8UBDlk+JF5OySXXNOPCfOO3nkCXqIdSto
X-Received: by 2002:a17:90b:5823:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-3567f85cfc7mr876477a91.23.1770789047491;
        Tue, 10 Feb 2026 21:50:47 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197f91b5sm864428a12.28.2026.02.10.21.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 21:50:47 -0800 (PST)
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
Subject: [PATCH] nvmet fabrics-cmd-auth.c : validate negotiate payload length(KASAN: slab-out-of-bounds in nvmet_execute_auth_send+0x1d24/0x2090)
Date: Wed, 11 Feb 2026 14:50:03 +0900
Message-ID: <20260211055036.2675866-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_215049_085096_21151FE9 
X-CRM114-Status: GOOD (  11.45  )
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

AUTH_SEND negotiation expects at least one DH-HMAC-CHAP protocol descriptor. 
Reject payloads shorter than that to avoid out-of-bounds reads.

[ 1224.388831] Call Trace:
[ 1224.388833]  <TASK>
[ 1224.388834]  dump_stack_lvl+0x53/0x70
[ 1224.388839]  print_report+0xd0/0x660
[ 1224.388843]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[ 1224.388847]  ? kasan_save_track+0x14/0x30
[ 1224.388851]  ? nvmet_execute_auth_send+0x1d24/0x2090
[ 1224.388854]  kasan_report+0xce/0x100
[ 1224.388857]  ? nvmet_execute_auth_send+0x1d24/0x2090
[ 1224.388860]  nvmet_execute_auth_send+0x1d24/0x2090
[ 1224.388863]  ? __pfx_inet_recvmsg+0x10/0x10
[ 1224.388868]  ? sock_recvmsg+0x178/0x220
[ 1224.388871]  nvmet_tcp_io_work+0x1709/0x2200
[ 1224.388875]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
[ 1224.388878]  process_one_work+0x5e7/0xfe0
[ 1224.388882]  ? assign_work+0x11d/0x370
[ 1224.388885]  worker_thread+0x446/0xd00
[ 1224.388888]  ? __pfx_worker_thread+0x10/0x10
[ 1224.388891]  ? __pfx_worker_thread+0x10/0x10
[ 1224.388894]  kthread+0x2c6/0x3b0
[ 1224.388896]  ? recalc_sigpending+0x15c/0x1e0
[ 1224.388900]  ? __pfx_kthread+0x10/0x10
[ 1224.388902]  ret_from_fork+0x38d/0x5c0
[ 1224.388906]  ? __pfx_ret_from_fork+0x10/0x10
[ 1224.388909]  ? __switch_to+0xb13/0xea0
[ 1224.388912]  ? __switch_to_asm+0x39/0x70
[ 1224.388916]  ? __switch_to_asm+0x33/0x70
[ 1224.388918]  ? __pfx_kthread+0x10/0x10
[ 1224.388920]  ret_from_fork_asm+0x1a/0x30
[ 1224.388924]  </TASK>
[ 1224.388925]
[ 1224.403207] Allocated by task 670:
[ 1224.403446]  kasan_save_stack+0x33/0x60
[ 1224.403723]  kasan_save_track+0x14/0x30
[ 1224.403987]  __kasan_kmalloc+0x8f/0xa0
[ 1224.404286]  __kmalloc_noprof+0x18e/0x480
[ 1224.404631]  nvmet_execute_auth_send+0x3be/0x2090
[ 1224.405016]  nvmet_tcp_io_work+0x1709/0x2200
[ 1224.405356]  process_one_work+0x5e7/0xfe0
[ 1224.405695]  worker_thread+0x446/0xd00
[ 1224.405996]  kthread+0x2c6/0x3b0
[ 1224.406256]  ret_from_fork+0x38d/0x5c0
[ 1224.406578]  ret_from_fork_asm+0x1a/0x30
[ 1224.406907]
[ 1224.407035] The buggy address belongs to the object at ffff88800a6537c0
[ 1224.407035]  which belongs to the cache kmalloc-8 of size 8
[ 1224.407998] The buggy address is located 0 bytes to the right of
[ 1224.407998]  allocated 8-byte region [ffff88800a6537c0, ffff88800a6537c8)
[ 1224.409014]
[ 1224.409155] The buggy address belongs to the physical page:
[ 1224.409669] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88800a653a00 pfn:0xa653
[ 1224.410401] flags: 0x100000000000200(workingset|node=0|zone=1)
[ 1224.410895] page_type: f5(slab)
[ 1224.411160] raw: 0100000000000200 ffff888007441500 ffff888007440210 ffff888007440210
[ 1224.411787] raw: ffff88800a653a00 0000000000800050 00000000f5000000 0000000000000000
[ 1224.412412] page dumped because: kasan: bad access detected
[ 1224.412866]
[ 1224.413006] Memory state around the buggy address:
[ 1224.413391]  ffff88800a653680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1224.413963]  ffff88800a653700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1224.414544] >ffff88800a653780: fc fc fc fc fc fc fc fc 00 fc fc fc fa fc fc fc
[ 1224.415045]                                               ^
[ 1224.415444]  ffff88800a653800: fa fc fc fc fa fc fc fc 06 fc fc fc 07 fc fc fc
[ 1224.416028]  ffff88800a653880: 07 fc fc fc 07 fc fc fc 07 fc fc fc 07 fc fc fc
[ 1224.416630] ==================================================================


Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5946681cb0e3..2bcee44b3395 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -289,6 +289,15 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto done_failure1;
 	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
 		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
+			size_t min_len = sizeof(struct nvmf_auth_dhchap_negotiate_data) +
+				sizeof(struct nvmf_auth_dhchap_protocol_descriptor);
+
+			if (tl < min_len) {
+				status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+				req->error_loc =
+					offsetof(struct nvmf_auth_send_command, tl);
+				goto done_kfree;
+			}
 			/* Restart negotiation */
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
-- 
2.43.0



