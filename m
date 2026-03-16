Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C676F013FA
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 22:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uAp3upALJrMK2vdftm0Mzj9z5vscYKgrSfpwrB2UjPk=; b=RYu6C96jn4i9OR1kgaed6QYSp1
	Ae0K+POenJByec9K13cuu7cUAYfVyrE15QNYFxfygNwAv6UzuDTPSOtfNr+suwAEAgxIs6EJieOmo
	MMXZFqvL4dulZMoaTRhZUXNJnXirNx8LhgMlKh2Z9AmlvzYJDqUXLviSsERW0bLHhAEd+E8ucaVXL
	RK6aeKGX/cLfdfoAPhScJmEF7KZ6BjUBSBju/jiZKuofcaD1ur3e2JlORmxAWHkDCBV4N5RhGe4S8
	QiVSiFApwiNDgUoLyWpWeXhtpmWH6kPfS2T21HaxGSv5C5GLFcg5FVmV/ElrdPulp5lPWJD+jgsyT
	h/tRTOqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2GD3-00000004zOV-1GOT;
	Mon, 16 Mar 2026 22:14:49 +0000
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2GD1-00000004zNp-0V9S
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 22:14:48 +0000
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-7d75ed779bfso5098394a34.2
        for <linux-nvme@lists.infradead.org>; Mon, 16 Mar 2026 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773699286; x=1774304086; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAp3upALJrMK2vdftm0Mzj9z5vscYKgrSfpwrB2UjPk=;
        b=r7FrP70YUqAnL3S6NKwDWMIM9fbMyGDUqigmIQxEDyKUDrzcbE/lFxkaaTI69Smg0r
         1D6TFpVTxFDNH3LpmOSfBRKg76v144B3JYYv7QgypXE96Yb0p2qgG8yo4roOLdIaMhNt
         VjD+Y1LbWxEnWlUVF82ZpdEZHOd5cJS1qKq1gPKHbM2JmMVdFvWrjmhhdcg8yD77yYEI
         eBGUmZM0MfZ9kcFt3ND183A9Gmmt/4Hg860rJOw/2a2dsZ3j5uLd4GFLtk58pz11JA6U
         sm/Vsdp9m8ULJWs7oIpgUsWHJi4ofGBZPE/jjTnTk91Xa637++Nc/lmYiVJcQkV1wZ7S
         +RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699286; x=1774304086;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uAp3upALJrMK2vdftm0Mzj9z5vscYKgrSfpwrB2UjPk=;
        b=G3EAcjA6wLA59Mhdv2qTRaxoRmV5qyNbzE7gpGfHQofT0EZqX52I3IH2KOE8mKoR0T
         AEowYqelN0aQQBUlpWYbIOlSrve7Pjaxie8zFJ3iKprnF8g7icTOqO+R7Zwh2orkch5z
         vUcea1AZuJhXGWE9SPEWkwQHaG1pLP5sY+BWRYYJadHBD1RGx5F62jXZb/7saLENDW0d
         izCq4YE0WBRgNkq/AvrheMefbSrBoTMIDAJPKJYAWA6gs9l8nLJavdliuKiZzxftiVU2
         sb8wgKwZ+mEHSHy52pk1zYRMBUBzxCtKzmXXhGO74gQhM0njThYfYeicQ03sd5VBtYsb
         I/1w==
X-Forwarded-Encrypted: i=1; AJvYcCUszC8bBXigOpjGRORQdzrFtoD49NB2PdPqE0dlDfncACDPAk2m5NXGEdvZscW99Td/Iqm7tlpJbZGT@lists.infradead.org
X-Gm-Message-State: AOJu0YzqIK9SoXBguQr+P1R2ebeqzMIBFt8h1VMQUDVH8zyPwqVlmsZh
	fVUREICsvCPXgQu3lV2lX6WWyheEJvODii92TSaNP+mIspJ33rRQdBbV4lrY8C/GSfA=
X-Gm-Gg: ATEYQzwXxojKjzvwZfznjugz/7CqkTjYjbb8XMdV7Qrob6lvNLJS0uxkDmMd6QFFOpw
	MZDHlhWD3S0ebNSsO40kvM/tepw7mECAyt936URyVYG2/CnUgvWUVK0d514eoGT74G6iCcDol3O
	8MWMbGfQ7RFJUt2uw7oiECCQyMVjs7mlEbKC63qf7TjupMFMzaFdh+hxvfkyb4aPHo741tSKgE0
	uGquKjDrTUortAGpnT1ghTRUYuFg8YNopDjId+sMZEz49J+dvJkVUTk5a20G0V5nW47v4tLPFqm
	yADEGIKYLekSWC92g4c/lR4Odz8CaqsozEMxc+/ya3euaE+Df2OU+xoB8rqviRXcK7Qr3ydqcV0
	FwuNkYfsGr2knAxWkKEPtrq7AL+cnINJJ3/8W8FzclRFFlprmu50EoDizIPByl+OrLQMUWyG8eV
	H98N07jSkchQ/39IaltFGs4EoEUti04igocvFxVLxYj0jIA7N/NU/mBHzBu1BWpa7+SVMs1ZvQL
	zFE
X-Received: by 2002:a05:6830:4107:b0:7cf:d213:7ecf with SMTP id 46e09a7af769-7d7825a0efcmr10863875a34.32.1773699285999;
        Mon, 16 Mar 2026 15:14:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aeccd73sm13375261a34.27.2026.03.16.15.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:14:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, 
 Kanchan Joshi <joshi.k@samsung.com>, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20260302172914.2488599-1-csander@purestorage.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
Subject: Re: [PATCH v5 0/5] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
Message-Id: <177369928494.700746.8101380068186003544.b4-ty@kernel.dk>
Date: Mon, 16 Mar 2026 16:14:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_151447_170197_078C538A 
X-CRM114-Status: GOOD (  11.20  )
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


On Mon, 02 Mar 2026 10:29:09 -0700, Caleb Sander Mateos wrote:
> Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> requests issued to it to support iopoll. This prevents, for example,
> using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> zero-copy buffer registrations are performed using a uring_cmd. There's
> no technical reason why these non-iopoll uring_cmds can't be supported.
> They will either complete synchronously or via an external mechanism
> that calls io_uring_cmd_done(), io_uring_cmd_post_mshot_cqe32(), or
> io_uring_mshot_cmd_post_cqe(), so they don't need to be polled.
> 
> [...]

Applied, thanks!

[1/5] io_uring: add REQ_F_IOPOLL
      commit: 9165dc4fa969b64c2d4396ee4e1546a719978dd1
[2/5] io_uring: remove iopoll_queue from struct io_issue_def
      commit: 7995be40deb3ab8b5df7bdf0621f33aa546aefa7
[3/5] io_uring: count CQEs in io_iopoll_check()
      commit: 3a5e96d47f7ea37fb6adf37882eec1521f8ca75e
[4/5] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
      commit: 23475637b0c47e5028817c9fd4dabe8f7409ca6c
[5/5] nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check
      commit: f144dbac4b177cfd026e417ab98da518ff3372cb

Best regards,
-- 
Jens Axboe




