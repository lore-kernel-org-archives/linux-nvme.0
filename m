Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA48CD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWM0+JwyfaLK+JEvNyeAgz9DrS34z7QF/WxQ2UK15x0=; b=pyDZQmQ1wkkb5m1w/2vnGlUBMP
	CkzTtBXK34s/Ydb6rC/9GiNsTmIlcmMuu3OfYbXcKgSdHyxjce8nyGoE6FtjCGlDMlzvC0MFfThAO
	hTD2+rfRT+tvJxJYwlLLTSDyGlxieoaeYQXAH/IX1Ts4SIH9XljEdLElCzknNcCcW35w/eKcEbWD1
	UdfDjFw1WcW1WqpRNK2k1Pl41pSPUHaBfYEaxs/cLRoSQ0xtq8tN8Hd3SBaI5TcIxYWLWXkMZ77tR
	QwHQ+WuER7KTtPhQ8h5mZ7TfUjaKiwIyDrSVWEomXWZGvi3cJlmvSPlYS2eCF2hjcjA7lHuVMxiSX
	NO6Bxyqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX5i-00000005VjS-2UO3;
	Thu, 28 May 2026 09:31:50 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX5g-00000005Vj9-2te5
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 09:31:49 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3698e34a567so11653669a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 28 May 2026 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779960708; x=1780565508; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWM0+JwyfaLK+JEvNyeAgz9DrS34z7QF/WxQ2UK15x0=;
        b=l8/vCg7x6OysrcmFrcmi73+Sn6kpWHk/kBNvVA91FnWta2rKM7iLpTQ4QUXQJV2kqD
         nk8ueZI7Uo6o0SjmzSiBhzYQ/LxJ/cTrPGfymNAUqGnXi7CT6uTXI9Rku4rwutINNoyu
         LOmIU2wSTQwSz/qsK0yLzm2W2FBxHnswL8Z213WlGQ2NlDOFG4CafRL+26IpaYUvgwf0
         qdWYugFSkT2bF+MyB8Xp/lfTi577eC/NUfgnxI5KhIQ41SwYvrx5h7VTNyGU4p8sK8F0
         /P6VN0g0NQwzb1sZosBE/LROVo8IKRjUmXFdpvYeYcfBwVY8+96XN95GQ+vwp3i5dcGH
         VVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779960708; x=1780565508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWM0+JwyfaLK+JEvNyeAgz9DrS34z7QF/WxQ2UK15x0=;
        b=A8NZJnpyDZkCuSMwZHQ10bn+ZvnCC5nT0giaWAey7EiZ8znb7C05BGyzEL8+GOGvhm
         fSN5QVXg5xEsK/ZIr/UbqbOiINW4BY/8KOeLnRNx7gbHQsisrpXWa27Y4k0U3wfEbTL3
         R8pl6/GOPAaHm7u2J+rvAhLijleAnRh6jTmsqHZvueg+kb3INqZTyv/1IwfhrfS4Exbq
         b8YGe4cZWQEb1tvqEM3VVC6h8wIQHnuu2rfAFjsyCDwiGDokL9Xyx1RYXUocEUTDvcTI
         7e3Kwtet6ZU6EthOdbKLH8c3hShBsweGsqlLS2FMtE/h53cm5+cTQ+gOd2LR/Vd3RAre
         zwfA==
X-Gm-Message-State: AOJu0Yx5IiD0t9EbAMt3I2q5qTUDKpBiBqyTkpxKPdbdtQbsLwo/pdSv
	GpvumvG16airTwLx2zSkxMR6u0kTnWDfXdvPA8jED8sVSYWbU5rnMQWPTLNP455R69g=
X-Gm-Gg: Acq92OHqjrDJPbksWbAR8Ca2IjqNzJnBfh/BbZa37uh0aBMrj8hApD4srbFxmyROpos
	QX5DdkBGXcf9ApPaWgZTyAfiTQE8B5Srx3G4jbwhtIBZ7CBQliFIfL7qndBeFXQxurLaBMnmd7J
	7Kxjj60DfqIfFH/eBOTztR8jQIWshPdjR7Ux4eA8e0FscWRgzbx0u3a92HP5BVhYcUfTzI9u1oU
	s/fnbg8UIuQr+B/436s62a/ay8lXGzWspJr3nZxJ5nFF/P8oI7sygZ7HFTO6SAWG8XiIG/9mXBC
	OGO6yXmoNb1y2X5xNLyvX/UkVb5yRiXDMTwb7NzqUDeAqjA+ACFckjcEXgPQDCt1NQ/zFBTQUk+
	EXgtCwwaLw10vV5es6y5aAQ0eCUk5pWTkUVEdrpBZz6aYOR4yGL/chfcd/p4z0tRfj1oSfupHx6
	6m1QecfiP0RtIAk1SVJkTC+tQcfLhy
X-Received: by 2002:a17:903:3b8b:b0:2b4:63c8:ce18 with SMTP id d9443c01a7336-2beb05a4cd9mr304026585ad.12.1779960707663;
        Thu, 28 May 2026 02:31:47 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ca7fcsm173561985ad.27.2026.05.28.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:31:47 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, gliuxen@gmail.com
Subject: [PATCH v4 0/2] nvme: fix FDP configuration log parsing
Date: Thu, 28 May 2026 18:00:00 +0800
Message-ID: <cover.1748418000.git.gliuxen@gmail.com>
In-Reply-To: <cover.1779930057.git.gliuxen@gmail.com>
References: <20260527133205.GA12042@lst.de> <cover.1779930057.git.gliuxen@gmail.com> <20260528083016.GB7073@lst.de> <20260528083043.GC7073@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_023148_735231_58B3AA3F 
X-CRM114-Status: UNSURE (   5.77  )
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

Hi Christoph, Keith, Nitesh,

v4 is a re-spin of v3 with no functional changes.  Fixes the garbled
mail format on v3 and adds Christoph's Reviewed-by tags on both patches
(v3 already had Nitesh's Reviewed-by).

## Test plan
- Build: make M=drivers/nvme -j12 (linux-next, verified)

- QEMU (fdp-lab, tested as one patch before this split): linux-next 7.1-rc4,
  QEMU 8.2 nvme-subsys,fdp=on; fdpcidx=1 / NUMFDPC 0 - unfixed: invalid
  descriptor list; fixed: FDP index:1 out of range:1.  v4 is tag/format
  only; no re-test.

Thanks,
liuxixin


