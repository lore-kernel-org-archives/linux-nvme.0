Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64364606A33E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sQAb7y0H;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SmV04ei9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=+/ie1fjm6lAVadllpDyXq/QvwISd8L07DcsiVDBTI0I=; b=sQAb7y0Hu2k0sOqpo+1Lhz5OOo
	gwNn1lBndEh5OjYKCcII+uZ3MhRjgRJIZmUQCdCrwpm+/sSnQUQjxB+LWXFYG4h/URw86TT/qlo3W
	1Su8aIX5huifOV0Uo2LqeeY+cyVc2j8yGwj71y5z7LqF22vM9CcI0fHLqNS+qICZLA9Te+BwnJVyO
	pVnx4CbRTECqcig2olK/F8cpR0OM5lB3fxYBzzdf9UBy861RmqSwIwUraGARu0IZw3KZRPyiaOoWU
	WESzTpkCWQ/v4OUXOZR5Rdpfg7c/LMyGC4j6W4EmddwZXBt1F04eCnMsOI27JyP5YxwT96LWI9V9C
	8OHei6Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOvrA-00000008hjS-1SQT;
	Thu, 05 Nov 2026 11:42:12 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOvr7-00000008hha-3Bts
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 11:42:11 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso4781232eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 03:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878928; x=1794483728; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/ie1fjm6lAVadllpDyXq/QvwISd8L07DcsiVDBTI0I=;
        b=SmV04ei9ZjfTxK/FfbaoSfjBm5cz1peWxcLDFgU0XX66ckG/xfiq++8IJUIHikpZAa
         J6dSkAEvpkDqvEyToAxA2A97IO75Gt3yyRHSNonkp6S42gixL8FOzyPG8kRHgwYxZO5K
         Oc5c2AtaQFqoeLdAkRGTPNzcvFWxErTpOQB6xOOnrWc497y8A8uuar9UDI1/i/T/BSmU
         5Hg2TNdz6ina3iX3dcFSiOP0yNB+39cJtdCKDudyZuojQ4FHOwx1Gct7iHG8AvxNQ/gh
         ifXN48MqbIMgsQ3vnrqEJxqEl8wm7HTew2Dh5vPdi4KOqHDnDFKIYV5Xj6Klf76mLumO
         2A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878928; x=1794483728;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+/ie1fjm6lAVadllpDyXq/QvwISd8L07DcsiVDBTI0I=;
        b=OA5y9/JdYrltQcBoz/2CgjwACkaexXxMpwyfNBVue6PNsuCYHUIBWPHnnnC/IMTEPG
         kogFnAZcvH2vVBP3eNza2pHICzjwS1SRDZvPMULgXgNAQ4k7u2DxgOEPwd95cenFFE5K
         2BTRoiJFymNk8r1cncHPclEBF7yZfoXEUEW+L3Ftwwdh4/lbo/ja78pzVe9pvEFxspm+
         rvEFUypuGa7pN9ke7OtNCxg4icXIvbZgiAahgMp7TOh62VgUXcqAPQmF6hrLXeTb09Mm
         VR7XrFWhn+Ce7WmNgbS0haV8O0/BiXfj3rXDEauWLT0l8UZFSOofqE08oMQxN0EKuuNg
         XvTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxe9aRbm3refCb5Lz/FCnP0AGJlULtanycNzG61n/mLmvUeH5OdGE0nOLbAUVwcwMgfS+P98uCV7oO9@lists.infradead.org
X-Gm-Message-State: APuU4Z+S/IOfo6VjRTyQy7SLXdA1feK1s4jzyxN1PxEVS3XRhxJXZzJG
	9rohdIM7TvULJaQ7qHwgiPMH1awWm6F3Bnr1k4+EKhRO6nl2y3ch/rwi
X-Gm-Gg: AYBFou2ydDBWQuP9XZxWtubOGxhEhq5UFpx493sIGdtv4gpMFCBETywE1FRY5ocXwem
	4y75vXKD/EpFTW4blDsMzlA0VwBfnP4Tep9UHTm12AuOaLwkxNakW10IdNfCbdb+VKaIMJK0eaK
	TMGcHEZ94/n2bagOOFKqpx1bg2+hZDUw6900zBAdju1LyE6iEkuaKipP5kMeKmpVG9n2X4GfrGe
	Bny6UYDpmY5y9/JaDKR9C6VMtg85lt2ke1aTdcn6v4IpBg+2xLuiNCVEYQdOXvQGEzJQsCxeZoR
	Irmj4dM/2eRxXgmlvQipbDX/MVxh+Mk4aIwLgX7qiUFrq9J6nR+UNf1IUID33xz6QP9AZ1MtkSc
	BObLbAJjsRN1P7j0SoSLCGOE1LzP8TFtX5SM3EoYu/vLVZt3zP1r3DI94j6OprxAhUO15U3jqiK
	8iyWW4d7HZVe6QWeuYogxuEjygK1iFTvMifNElRO5cOdBm3X7LweXrQ34rLbKsFRheuPypUQ2w7
	c19Ipow+FOwGoLnrn7zo7Ru6pBTorF9gEMEDYxFPGzBmR00w7Gy4c+kiArToqVYRV152ZqoLDXX
	qL6s4qivn0v9vs4fRI9HWdBmkhP2HLPjc98Wr7xSOoUM68keSaE7DORW/lsGjXEhXI9OVaKVGtk
	kOTIdLhGladeKg3JpEaI46cdWryWFnt0=
X-Received: by 2002:a05:701b:420d:10b0:184:d593:2897 with SMTP id a92af1059eb24-1ac5d5aa2aemr30545874c88.29.1793878928117;
        Thu, 05 Nov 2026 03:42:08 -0800 (PST)
Received: from lwq-System-Product-Name.. ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4706bsm19644566c88.15.2026.11.05.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:42:07 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: mkp@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme: stop asynchronous event work before ANA teardown
Date: Thu,  5 Nov 2026 19:41:49 +0800
Message-Id: <20261105114149.970315-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_034209_824250_904DD273 
X-CRM114-Status: GOOD (  15.72  )
X-Spam-Score: -1.9 (-)
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

NVMe ANA work has several producers, including ANA AER completion,
namespace scanning and failover processing.

An AER completion can queue ana_work for an ANA notice and can
separately queue async_event_work, which sends the AEN uevent and
submits the next asynchronous event request.  These work items access
controller-owned state during asynchronous processing.

Controller teardown must ensure that both the event work and ANA
processing have completed before their associated resources are
released.  Cancel async_event_work during controller uninitialization,
after the controller has stopped accepting new events, and cancel
ana_work again before releasing its ANA resources.  Draining only
ana_work is not sufficient: an ANA notice completion can still queue it
while teardown is in progress.

ana_work is initialized in nvme_mpath_init_ctrl() during
nvme_init_ctrl(), before any teardown path can run.  During controller
removal its producers are dead before the final cancel in
nvme_mpath_uninit(): namespace scanning is flushed in
nvme_remove_namespaces(), path clearing removes the failover source,
the transport's delete_ctrl tears down the admin queue so no further
AEN completions can queue work, and nvme_enable_aen() is only
reachable from nvme_start_ctrl().

nvme_mpath_uninit() also runs from nvme_mpath_init_identify(): from
the ANA log growth path, where nvme_mpath_stop() has already
cancelled ana_work, and from its out_uninit error exit, which can be
reached without nvme_mpath_stop() when reading the ANA log fails.
nvme_mpath_init_identify() is called from nvme_init_ctrl_finish(),
while the controller is CONNECTING or RESETTING (LIVE is set at the
end of nvme_start_ctrl()), and nvme_ana_work() returns immediately
unless the controller is LIVE, so in both cases the additional cancel
only drains work that would be a no-op and cannot race a work using
the ANA buffer.

This issue was investigated and the fix was developed with AI
assistance (ZCode/GLM-4).

The race was reproduced with the in-tree NVMe loop target and
scheduling injection.  Cancelling ANA work alone left reports;
draining the event work and the ANA work together removed the
reported use-after-free under the same test conditions.

Fixes: 0d0b660f214dc ("nvme: add ANA support")
Cc: stable@vger.kernel.org
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---

Changes since v1:
- Corrected the causal description: an AER completion queues ana_work
  (via the ANA notice handler) and separately queues
  async_event_work, which sends the AEN uevent and submits the next
  request.  v1 wrongly attributed ana_work re-queueing to the event
  worker itself.
- Noted that ana_work is initialized in nvme_mpath_init_ctrl() during
  nvme_init_ctrl(), before any teardown path, and documented all
  ana_work producers in comments.
- Audited the producer shutdown order for the final controller
  removal: nvme_remove_namespaces() flushes scan_work, path clearing
  removes the failover source, the transport's delete_ctrl tears down
  the admin queue, and nvme_enable_aen() is only reachable from
  nvme_start_ctrl().
- Corrected the error-path claim: nvme_mpath_init_identify()'s
  out_uninit exit is reachable without nvme_mpath_stop() (when reading
  the ANA log fails without growing the buffer).  nvme_ana_work()
  returns immediately unless the controller is LIVE, and
  nvme_init_ctrl_finish() runs while the controller is CONNECTING or
  RESETTING, so the extra cancel on those paths only drains a no-op
  work.  No additional cancel_work_sync() calls were added.
- Addressed the Sashiko review note on the explanatory text: the
  comment in nvme_uninit_ctrl() and the commit message now describe the
  actual queueing paths — an AER completion queues async_event_work
  (uevent plus the next request) and separately queues ana_work via the
  ANA notice handler, while namespace scanning and the failover path are
  the other ana_work producers — instead of attributing ana_work
  re-queueing to nvme_async_event_work().
- No functional changes beyond v1.
v1: https://lore.kernel.org/r/179378587000.73780.18152328009023418065@gmail.com/

 drivers/nvme/host/core.c      | 10 ++++++++++
 drivers/nvme/host/multipath.c |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..8efa306205e19 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5182,6 +5182,16 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
+
+	/*
+	 * An AER completion can queue async_event_work; drain it
+	 * before the controller's final release.  Note that ana_work
+	 * has additional producers (namespace scanning via
+	 * nvme_scan_work, and the failover path in
+	 * nvme_failover_req), which is why nvme_mpath_uninit()
+	 * separately cancels ana_work after this point.
+	 */
+	cancel_work_sync(&ctrl->async_event_work);
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9e0a0fd77c56e..4ced8136d5f63 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1610,6 +1610,15 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
+	/*
+	 * ANA work can be queued by AER completion (via
+	 * nvme_handle_aen_notice), namespace scanning
+	 * (nvme_scan_work), and the failover path
+	 * (nvme_failover_req).  Drain any remaining work before
+	 * releasing the ANA resources.
+	 */
+	cancel_work_sync(&ctrl->ana_work);
+
 	kvfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = NULL;
 	ctrl->ana_log_size = 0;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1


