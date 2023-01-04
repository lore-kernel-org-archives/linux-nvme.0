Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675AFC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=gbKqkFsN4hQeaKGBwT0swWYlTLMQd/HhdjuV7OkFZck=; b=Ea8hS0USIktcUUXtkxCPJuSYbP
	YDo7Orj/dZUmIyhQSYvFybRiBP3qrPmOSqmCaeI8xydqd3VODF0cp4gSIm0NGYhV4OKf8GpTEq59R
	llO41uO4j6rDMsCYmHf7vxL56KgTKc5RvlYR1KlqWcMja2curosAS+NDAJyq/SV3bxfAVkUOQeDuu
	EYZ02zw3eccgWaycCjIWm0BkcuGOEDGnTmpVt4G0PAPIj+miwk3RL9nmXj11G9Q/FdF+QqyW39y27
	oxQAHh0OlIbpf5d+kYqtkj4bp6JqCRu/ARxf/xgfm+6xam9TeWTVzisLl8CW3qrO+KHr8xT5SiFqR
	F3C8bMxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD2zh-0093X5-SD; Wed, 04 Jan 2023 12:35:45 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD2U7-008wxZ-Fa
	for linux-nvme@lists.infradead.org; Wed, 04 Jan 2023 12:03:08 +0000
Received: by mail-pf1-x42b.google.com with SMTP id 6so19922944pfz.4
        for <linux-nvme@lists.infradead.org>; Wed, 04 Jan 2023 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbKqkFsN4hQeaKGBwT0swWYlTLMQd/HhdjuV7OkFZck=;
        b=mHVGqX8H91pzBJ3DqpDdUa8q5l+Xnziz+IY+I893b//GyPfrcaV4LyEnL5N7W5orqd
         KhjDg2DKRkhNeg7kPMi5/Dhy3WkN7600cWS/0Yu9rxCpyqo6ycTsVO0NN2JpLSH8kMyK
         vXORpTS7mvElXy7DsHenbpJaJVvGFX/hjwlGlF0eg94KlhEZgBDawY7WE2dRw3ar+b2i
         KCiH4TGS/ukHVvhsiEvXeIHB87DmZkltPYIzUeRllH6xEgLaT6NJ0QPl9TZhB2tEE4Ex
         wsFb6n+q+5/6hA8Q+vPZ5CnnwLwj2nu7jw2G2lKejRqy5shn0+KKHYefSNm2sZ/Hxh65
         xfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbKqkFsN4hQeaKGBwT0swWYlTLMQd/HhdjuV7OkFZck=;
        b=pjWOA9U761uTtkh43tk0z49HkCAYT7dijnRhcWdqikAWcQEOaY3FF6QY32g5BZh9kc
         j5/Fl5h0qxoqWZzq8YfFMmjlrd4D2JMTOY00kRxNHCGn1orTSx7fRtCHCDdFpDKnvkX3
         euCDNtWY4QJb23JGAIKyh8VFLNQSqBR0Knw4zD6lAR8zDit4BHf6OiERv0uQqs0wWzoa
         xYhgkKziw6OnNXuVmCaqUgpH7JGHgWTAQZJh0aYGOy1ldfdxy0vF0Lba9/W9W0SDMTWw
         tcS/IZZEREm+6kT5yXhAV2NzfPQjwPOYkad2lxsGvPMyiwJruzq4vpgKN/8WmeA5JcVp
         /dyA==
X-Gm-Message-State: AFqh2koHomDHgwsd24vyihvDFQlz5ktkUbBc1lkpc8M4Pyqrr4M6hqx9
	1nl9bWvjmBT/dGWEj47O+hc=
X-Google-Smtp-Source: AMrXdXvLlycQwR2yfcSSdIDuT8mAhKbn5aH7b2zhWOcV7RFoNEz+oc6njRkxGsmdCSs+xOoNDXJDDQ==
X-Received: by 2002:a62:e317:0:b0:581:4297:362f with SMTP id g23-20020a62e317000000b005814297362fmr33459797pfh.13.1672833785678;
        Wed, 04 Jan 2023 04:03:05 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id d18-20020aa797b2000000b0058251b6e0e8sm6856527pfq.188.2023.01.04.04.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 04:03:05 -0800 (PST)
Date: Wed, 4 Jan 2023 23:03:00 +1100
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: marcan@marcan.st
Cc: asahi@lists.linux.dev, axboe@fb.com, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, sven@svenpeter.dev, ushankar@purestorage.com
Subject: Re: [PATCH] nvme-pci: Add NVME_QUIRK_IDENTIFY_CNS quirk to Apple T2
 controllers
Message-ID: <20230104230300.66b4a581@redecorated-mbp>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
In-Reply-To: <20230104101641.12215-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_040307_682502_B6F62200 
X-CRM114-Status: GOOD (  11.85  )
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

> This mirrors the quirk added to Apple Silicon controllers in apple.c.
> These controllers do not support the Active NS ID List command and
> behave identically to the SoC version judging by existing user
> reports/syslogs, so will need the same fix. This quirk reverts
> back to NVMe 1.0 behavior and disables the broken commands.
>
> Fixes: 811f4de0344d ("nvme: avoid fallback to sequential scan due to transient issues")
> Signed-off-by: Hector Martin <marcan@marcan.st>

On T2 macbookpro16,1 with 6.2.0-rc3-00010-g69b41ac87e4a I had this in
dmesg:

nvme nvme0: 1/0/0 default/read/poll queues
nvme nvme0: Identify NS List failed (status=0xb)

And in /dev only nvme0 existed (no nvme0n1*).

This patch fixed that and /dev/nvme0n1p* existed.

Tested-by: Orlando Chamberlain <orlandoch.dev@gmail.com>

