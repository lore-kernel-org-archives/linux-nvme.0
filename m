Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE44103FFAC
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 22:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YA4oP39D1EwOno4AkPegcttVQHiaILWd3dC9XNEopg8=; b=AF6/oWhj9/UWnFFvsSz9dkQu2+
	NIwD0H4HBY3onT7JhRr8BC6CGgWEixIaJM2qW8z7AC1nELbeUIO6AUoMae43stiyurWZD0/WpA9Y6
	54i4YxnGJW4kJrXjdvqtB9pl1eu17PjnBBGDVHKzv6A0PzGMdystbmbppVIiSSxcpioXmiQPgtk+n
	NbOAiTRPlZNBpfMUzBME0AC8GXnu13nYTLteMK1KLPSA1ee4zr+vmDmtdjDkH4IRMDJEjjn7R/XKE
	Q82aD4X5oPQZSj/XJpjK+GeBLS+wJH/t1Xl04u71PdenWOhL5dvMRxi/LyHVABUMJqgheht8Vv8/u
	aonFot8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6Qa-00000009Doo-3zSw;
	Fri, 27 Feb 2026 22:35:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QW-00000009Dm2-2qsY
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Feb 2026 22:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YA4oP39D1EwOno4AkPegcttVQHiaILWd3dC9XNEopg8=; b=ZbxK2QSRL1NtWfC8FdIJbug7sN
	r/0uttqXPu9+SQFi/OSjrn2ulXkLUpBaDv0/SGcNqDbD/sqVDtADgQZXfgQbe6vcFcy69m1Ci4O8z
	jOFaMN8YnNeo2IwR51ZDtvEdYAJd3FqUlSUTV3asU65srWAgWvhA+MUkt7kH1+IEZti1FtqUMOHfa
	PZXHIeY3R/w41hIA4mMS05hU9hP/n0Zt2rhF5z1BDTDjCVSLyNO57DfvCJSzWzIGcACF5TH1khNSf
	fusWCq8zdXEUStQ/sZsfKFX7/D2BWyCAe4vVlGvEsC5UuoZp+iFLy/nVPoDlSxMZ0ciTMaizUcHYV
	Pyig8Ekg==;
Received: from mail-qt1-x863.google.com ([2607:f8b0:4864:20::863])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QQ-0000000E0gX-2gIV
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 22:35:15 +0000
Received: by mail-qt1-x863.google.com with SMTP id d75a77b69052e-50336c6798aso2729911cf.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 14:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772231708; x=1772836508; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA4oP39D1EwOno4AkPegcttVQHiaILWd3dC9XNEopg8=;
        b=VaQMXcURludhspO2mX07KkFu8W+ieFpJ9k9qYt1AtlyWmHz3n3Ygp9TKAkBvFVrzTC
         uw6dkbaO/4FJ57xCJAF1peAXYkTg9/+VLeoZdodua2XkZSm1R4BB/XYlVga7lYpk+8hn
         i4QUw9Z1wza857DNwh1TFrmhwuAMHG5G/pHD5aactL4ptlD1ZFqd6W5z0xbVP+j4e0LK
         IYz6w3MkZDfUT1n9DtgxDXYm3e8rflErWKIRsX03MosBzfFLuEl3+Eete4gPUyPZ8s4g
         ewIe9uNUdhrulsrTaO4A6kRzy9hQVwhYZXvRp+L9ro1hZu0SzoznVKlgD04uRIsrCENY
         ZiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231708; x=1772836508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YA4oP39D1EwOno4AkPegcttVQHiaILWd3dC9XNEopg8=;
        b=wZh7tp+K1wB4Ur2C0MfSNo//XGpTFrBgK6sMBdI2FG8cdl7SWKGO5d+Z72YpUmW/vo
         YpLALknMThr5ty8xa3RIQ91cdJK7kVVt5g8WqJG+NyWUE35oQVja0wBImXEyhARHHES2
         svlrxCB1SVzTqt7cLjgnBle91OKcru5TSdH2OfNToqWO2fuLYtUZVTJ178+/v+50E+2H
         NTZTByEFsHzPmM/ct5fTwyP3NetdxtNaTZ9PbPZYZRxMdZviULiolTMlRH7ZDlNtT8n5
         fvnf3nhl5h0MsPr/ZeKO2mtaDTHTHBMD7LJ91Uh/h2XtK3LeZ5yMkTVi0WdEQXYkWz3n
         xdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDXyVBKzt4hFOcEZp/stlCSPJq/in5qhvqgGuk1NnZzw5ynk2x4DE+AEGBqRM+2ONx228wuVMy4ILW@lists.infradead.org
X-Gm-Message-State: AOJu0YwwoFZ+0FGzrKB53+vP3oldrNyIh3HVSsRyForMAnEsIqM65zAz
	NjgKtg8Yh7z+9lTJ/mewNHlLABkMU50+iI1uO9Xlavtc7JCcuqWTjK2G78qqdJtmwGpyHnly4J5
	Xon/8+UrOIsbJppbiVy3y5nMvJCXUTgMWO3Mp
X-Gm-Gg: ATEYQzzgfMYG2AcPtSVpbEAzb59eXjqS+BY15s9TvSkdg3soMR2VqYnyzL3YHYCQS3Z
	eukF4xU9kWiz3waRB2l0JCgNGamQAXgKfNJcdLs7zyJSrIsGYKYTKXI8fm6gjUO5rmypSl39L83
	DUl1XJ31rR/YMZaBm3nAo2g74tKuAAjbjK84GdFxvZ0Yf7g9ycC4Rv5DCXG2optiWb/Vgi26RtB
	EIIOjljLTJUqdz4S+/EoRcxCwkTjM15kTc0hmHyz6uIdhyGAxuSxYU9i40xoPbTl3S0wQIg6Slf
	D6Me2iht0p9fBtTIeOQJMny7+I6WNRsnjdSbR+PYgPmPBHWZey0ksNsafVMXI/zvC+25ePNQwPI
	LJdSkSc1a0/vr3WSkwuU+BOzxSpeNrCOnIhlO0LLnA8xjlKfAvLE0uQ==
X-Received: by 2002:a05:622a:178f:b0:506:bfa3:55c8 with SMTP id d75a77b69052e-5075297bae4mr45875231cf.5.1772231708069;
        Fri, 27 Feb 2026 14:35:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50744a78567sm7946111cf.6.2026.02.27.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:35:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 55B0C341F2A;
	Fri, 27 Feb 2026 15:35:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 51DE3E420D8; Fri, 27 Feb 2026 15:35:07 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 4/5] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
Date: Fri, 27 Feb 2026 15:35:02 -0700
Message-ID: <20260227223504.1162421-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227223504.1162421-1-csander@purestorage.com>
References: <20260227223504.1162421-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_223511_206029_61F07C81 
X-CRM114-Status: GOOD (  15.53  )
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

Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
requests issued to it to support iopoll. This prevents, for example,
using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
zero-copy buffer registrations are performed using a uring_cmd. There's
no technical reason why these non-iopoll uring_cmds can't be supported.
They will either complete synchronously or via an external mechanism
that calls io_uring_cmd_done(), io_uring_cmd_post_mshot_cqe32(), or
io_uring_mshot_cmd_post_cqe(), so they don't need to be polled.

Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
even if their files don't implement ->uring_cmd_iopoll(). For these
uring_cmd requests, skip initializing struct io_kiocb's iopoll fields,
don't set REQ_F_IOPOLL, and don't set IO_URING_F_IOPOLL in issue_flags.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
 io_uring/uring_cmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index b651c63f6e20..7b25dcd9d05f 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -255,13 +255,11 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 		issue_flags |= IO_URING_F_SQE128;
 	if (ctx->flags & (IORING_SETUP_CQE32 | IORING_SETUP_CQE_MIXED))
 		issue_flags |= IO_URING_F_CQE32;
 	if (io_is_compat(ctx))
 		issue_flags |= IO_URING_F_COMPAT;
-	if (ctx->flags & IORING_SETUP_IOPOLL) {
-		if (!file->f_op->uring_cmd_iopoll)
-			return -EOPNOTSUPP;
+	if (ctx->flags & IORING_SETUP_IOPOLL && file->f_op->uring_cmd_iopoll) {
 		req->flags |= REQ_F_IOPOLL;
 		issue_flags |= IO_URING_F_IOPOLL;
 		req->iopoll_completed = 0;
 		if (ctx->flags & IORING_SETUP_HYBRID_IOPOLL) {
 			/* make sure every req only blocks once */
-- 
2.45.2


