Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C400CC6B2C
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pRta59JtulZeIsykJD35tM5ia0Lq/sCYG19PMeRfN3w=; b=R7mgon4Y2c8ysT+G+lfPJ69zJp
	ZEIbE9Dsg6VOs6poo+IPgg9DaZzbwY5QeYV4HTDUJP/8v1dxWMTbHdHPdoCal6cWTmdgmC6fRHGiX
	ZepmuEbwLTMreq7rm0pF9gNC9axj5n6Nxqr72ICianUUjXQRKP3XMbRD4fKQ4PtDSHjmF9loaZX8U
	nll2FOCyNpThcLaf9FzN16sgpfd+33JTv8j87/vyeZwRsqRaL31Zl1voqnExfaD62SzeVpUXLlLXw
	KVy2iuNVYciWf3xc85AUbFWn3kp6QujwggY3VlzkDeWW8hEdWZo3ad+nv3LlH0+UuosP51umt/uZY
	PmYzAZRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH4P7-0000000GC2q-35sJ;
	Wed, 14 Oct 2026 19:12:45 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH4P4-0000000GC2Q-48Ty
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 19:12:44 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-3550c917fd3so1857475eec.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005161; x=1792609961; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pRta59JtulZeIsykJD35tM5ia0Lq/sCYG19PMeRfN3w=;
        b=G09BgNVlN0dmm8cQb4QUqE9e4Px7ZSMKhifuxEP51TJV3hqZEkzeGpBvTtpOisaLq7
         HhFN5Hs2BXiC2q7F+3ZTeuk6C9LMvoxehYtneWdLGN07/Gfh4SYMNpfbLFVa3D4tgzkN
         7d9kDlMIzoAOmTca4GPoAbJQs7iEYDTsktAg3HCdqv2zpySPOLPIzik9cX8o9dSZR5//
         bkQTUotLTsnP17XnB7y3JxEU6mrfZi6XfsOqyzAoTQM8y+9LTio8qsqBf9nTosnAsHgi
         kx6Hw86FTp9rFROCGFOvATe6Q2Q6rwXadcCm+PEYYJcDlkKZV8I9lRvSINRhRSlO1KWV
         Hw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005161; x=1792609961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pRta59JtulZeIsykJD35tM5ia0Lq/sCYG19PMeRfN3w=;
        b=gsQCS/ozHJCtntMzyD73KVH0p4MqdV3UkypwE/Ddw4eI++h+3rI+juQsoZLnLKgWsf
         +ukcrJZvwu8rr13Xs5T+uV+RxxlLpzI/ocukCPX2821V6Sj7hVokG+0nltB4Z/nN904g
         4Jlu/aLoxTIZfF8E3kjKLKfv20FkxTHsIl8e0DYWq0X/+ZOAEy3pX9Q6zp/HYrqH+w1l
         PPxnWPWTjwdFmwY5Pub2Bj1TfuRfkqj+Gbcg8uDWfqO023MUSqmLPM0yo/EINpzTw3Vu
         BSg6BnzI8DaJPH7blE3MfEsxw4GyLA7i7hHTX6JEAyLp1V6RZAO9P/+NPsgW1LEuLuZV
         qHsw==
X-Forwarded-Encrypted: i=1; AKwUvBw411mcrAAMbI9UA+xzF8KjPzLIsi91Ax6qz0EpCtEVJs7ckZqnR7LSgJraOfXZsSyZvn6/qv249bpJ@lists.infradead.org
X-Gm-Message-State: AFq9FYLddywO3NyvPhxENV8kVRk58e6S4eoSE3QLidCb5/Ap3+0osLmq
	aJWrFmr6rheb3MHzj8AbiovwqKR094+0VBrqZf1bbpikzw1rz+62yA6X8mF5K/8c7Oo=
X-Gm-Gg: AYBFou23tQT2HtbGnck7BaofL4t4TeyZ9mu9qO6HbXBBRDVMRiiUCSgCjdMAQ2fBGyB
	JEMyUx0N9HnuY2O4pcuqgzZLemJfJ3YoHw70rl7zUSE4Xt+Qqag8YYiq2wcEmyYAM2gXQd4ZxzL
	//89bym7UMkV9RJPaf6bBAQhn9asGraGO7qfYiD+9chsPoq2iqe11Wr5YfU1ETQH7r3C7VcZqw2
	mR5XZImWmk8Q4CIs9OsTSFv0j0CeejDzOePfhSLQuwyEpNmO3zRFDC6rq9Vva1YjkVOX8Fb8ysW
	+/iDVd+i3ZwdmsdXPMRiI2xD/BGiwW/D3G/YuIDO1v2XUJ0F+WDcFzUb8zwNaVnrHvcNpEo8+tY
	CoYoMzzrUGyPzP280a07KKPZsmCUVPHjMIzBBQazDS6fGgfZ0mqVgrX1vymOF1Vn5LopKuwUVZx
	mbQxEzV/P9XpMVQT0+EmgZ8spKs8P2+9nIvLMNo0JlpcLje3bbSPW86ItpoRMDOFn34wpuwjxAY
	b69kviK6VdufuM0N1XoDIlZmuI+X82Q6gXh1GLugitjCM9Pv7/jOUIzu1osHqwmYLvj9J4=
X-Received: by 2002:a05:7300:caa:b0:35c:ceb0:8bf9 with SMTP id 5a478bee46e88-35cceb09059mr9595489eec.38.1792005161316;
        Wed, 14 Oct 2026 12:12:41 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm54329888eec.28.2026.10.14.12.12.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:12:40 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	cel@kernel.org,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	neil@brown.name,
	sagi@grimberg.me
Subject: [PATCH 6.6.y 0/2] CVE-2025-38264: backport fix series
Date: Wed, 14 Oct 2026 15:12:34 -0400
Message-ID: <20261014191236.23696-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_121243_026478_0D572542 
X-CRM114-Status: UNSURE (   8.11  )
X-CRM114-Notice: Please train this message.
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

Hi,

Please consider this backport series for CVE-2025-38264 to 6.6.y.

Apply the patches in this order:
1. llist: add interface to check if a node is on a list. (prerequisite)
2. nvme-tcp: sanitize request list handling (fix)

Patch 1 adds llist helpers to mark an unused node, test its membership,
and restore the unused state after dequeue.

Patch 2 initializes and resets NVMe/TCP request-list membership and
rejects R2T processing while the request remains queued. The code changes
in both patches are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: x86_64 objects
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg

