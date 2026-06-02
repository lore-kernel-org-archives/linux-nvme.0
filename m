Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ECFCD6E57
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 01:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gVnil9pDxf4xGzxDET/zD4uWVKLV2Eh75eRTnrXkejc=; b=p0XPq53ofSDiKpfu7BQ8jRUI1v
	b0Iy/AP3fKaZnoQYsitSF3nlNvdfchShhp3mco+1r2aPCJuu8PofqU/jqim3Vc0AcOvcOuyeNgE9c
	ZYDIz2BhAyV56ZTg93kIbyJcDSGDhPNYZm9/Kx0LAUCdxKvam6+1pA02lGPpurxhxQkCKUAkmgoqJ
	IxTBEXxziKrcg2x3afFCfRFx9t6Mayoa0ZIBYcoc76kWSB01/YH42vMz1Q6ft4JwtLjAsX/P4sIlZ
	h3JUmt8TjY857YuHtPrnGeX9wtkCJdCrBF09ObXVfdJTjEp4CVsrtRRJGgpcKvE9bpyBH3KCAI+hO
	YtaqlMqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUa6T-0000000E1Xj-10D3;
	Wed, 03 Jun 2026 01:09:05 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUa6Q-0000000E1WR-2FmP
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 01:09:03 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2bf237e1433so50549725ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jun 2026 18:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448941; x=1781053741; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVnil9pDxf4xGzxDET/zD4uWVKLV2Eh75eRTnrXkejc=;
        b=AoxwVBoF6xyMFXTwS1PzQbylZ0Y4+uvaJuZd5Niqya3e10Vrz46omGLRWSzwTr3HzK
         KWSG+g+KPMqThz6GhvBxU+rhQ8QuQeoe1vmJce9eL34R9IhqeFKGvMQC8xXnNcVMx0fN
         foCUpxQmmOHvvflBMfhBUxvO7y7MVlkFUePBXa/nEHKkSHQTKRYtgoPA0cR90/IjrWwR
         wQjYtzdvN4MsFhyJTsOFjghRN78AScKgPj0e4l4O1tU2b9KBX/KP6J0dE9LYjXFGBTVL
         ePpfQ/CVapCM8wkPOMrnVdoDwk1FelKUYIVoNKxnhKlpNsJmsVwSbqZVDILsxRfiQhjz
         oZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448941; x=1781053741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gVnil9pDxf4xGzxDET/zD4uWVKLV2Eh75eRTnrXkejc=;
        b=Guk2QYpgIiUogJwMMXXEPJgLLlU2wKadk4JmBOjPKhXgByDM5IrpSVQolQN1xsNyEb
         0Vy73ALkAdYopo2RBhLaET7DM5+hq36CRgjjPYbkS8DXuw4gvQe/vx9thAsyWgU7lUjY
         wEB+tRP9TBQ+tqYoLPKfa5Zr0eAX/xXkEGIi6m3HAR7DsjT9ibWvdYPbJQPNA4SwX89h
         WlSaNxVnDO1IUv+S+sfR89VJiBP7jgPtRuLKtd8ZjECuNOjImXqkzJY0749lDHC1CrLc
         ocJ4f9Hic89Xag48C38Sl4lywqWHNisRVuhWiZDGzDNrFqKiY3rggEytxAsyQNdaj41o
         IZxg==
X-Gm-Message-State: AOJu0YyXlyGTePtMB7VfiS48X9O/fn/fbYC+fG/C2yf+zI0kjlIA4ANz
	yRwzDUMlAFkRsPef0bvjeMyvzyYO33DswIwgKVxMQLy+2xjdiVMYh4vPneLLCRye1+Y=
X-Gm-Gg: Acq92OFzogQEoECq7H5/Oy4A4mwVhcv1t8FHSa1Z/JSGp+t90D9M1/pPfQWXYHoNR/3
	EcyAROuPWeGjKE3WD8jdUbc+LjiNR66yNvuepnMUnUAnWS0ItpXx89Vqyr/XmDauEiB44Kjge0V
	6p5B+AT4U6aI4MNmP+wt5WxOolIbwKkK/CgI5A/hulej+2x+NWWXFnjuVCBAMZ+HAVxJdW9ybZY
	srK4v4PmH84thrfDNlVaDWi2qqa+CfEspByqNxDFx+c7lPA4Iyg1EJ+HOv7IosGAcXD1CmV4JOA
	kUAZ9Q0hLckDDzj23+nVxivSkQqxiHgzCG2VLvxJ3lhxUBAO+U54Iv+NpBSimM7U9S0VQypFmsK
	8l/I7Bjj6Ss6otcy3JRPtcA0CwCDHGuXdq+U1PxzJ09BGudlwBSp6urtSHZ7QyLIHeG34/n06dH
	GIcmsV658rAo/XONq2DSxw/B+cRZO6
X-Received: by 2002:a17:903:3d0c:b0:2bc:f1ef:2e65 with SMTP id d9443c01a7336-2c163c640b8mr11038555ad.17.1780448941225;
        Tue, 02 Jun 2026 18:09:01 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609ed97sm5076825ad.41.2026.06.02.18.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:09:00 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, nj.shetty@samsung.com, linux-kernel@vger.kernel.org, gliuxen@gmail.com
Subject: [PATCH v5 0/1] nvme: validate FDP configuration descriptor sizes
Date: Tue, 2 Jun 2026 22:00:00 +0800
Message-ID: <cover.1748841600.git.gliuxen@gmail.com>
In-Reply-To: <ah7KRIl3LNsbWLO4@kbusch-mbp>
References: <20260527133205.GA12042@lst.de> <cover.1779930057.git.gliuxen@gmail.com> <cover.1748418000.git.gliuxen@gmail.com> <b2f3e4d5c6b7a8901bcdef2345678901bcdef234.1748418000.git.gliuxen@gmail.com> <ah7KRIl3LNsbWLO4@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_180902_578157_460D1A3F 
X-CRM114-Status: UNSURE (   6.52  )
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

Hi Keith,

Thanks for applying v4 1/2 to nvme-7.2.

v5 is only the descriptor-size validation patch, with your feedback on
v4 2/2: remove the redundant "log >= end" check inside the walk loop
now that dsze is validated before advancing.

## Test plan
- Build: make M=drivers/nvme -j$(nproc) (linux-next)
- fdp-lab: dsze==0 / walk past end -> "FDP invalid config descriptor at
  index %d" (see fdp-lab/TEST-FDP-BOUNDS.md)

Thanks,
liuxixin


