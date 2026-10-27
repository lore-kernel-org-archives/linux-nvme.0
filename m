Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F7606A329
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1DiDvNdN;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUEn9y/O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Zq80UJ+hgfJc//pAabUCEXC8s+2mlwefGbT/4AIXsFg=; b=1DiDvNdNffMdIh
	stX59pVxpKOKiDa7UfxV32b/Fysqep0gxIxwD5YcGVwRmF0i2HM2ygpxYKTv7j23zXp3Og/58hrDM
	7sCmehttJK6s/jkq/I8JpxoLXug/kPDWtiOh+oziiUNwYEpO8EWoNOY0UlnvODPF8/8YmVhpxseaR
	QnssWwkDvBDFTNDDyyoqgYApJ0bKFWt/R8pPelvO1SMMGZgY8r8SLovRI2Wg19g3he9aEUQEUba2P
	3ZX1FOhhsJ9fA7z0+ftgzgOiK6xkb7PMYsaV2KaD2RVxbvM4k22laiQPlbmIZj+znop3tm0JbjxG6
	pUAgYxCzoxQR7AfVPBnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLjVd-00000005HVf-2ft8;
	Tue, 27 Oct 2026 15:54:45 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLjVW-00000005HVH-2gG2
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 15:54:39 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so6729eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2026 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116478; x=1793721278; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zq80UJ+hgfJc//pAabUCEXC8s+2mlwefGbT/4AIXsFg=;
        b=QUEn9y/OE5vSJOQRP5B6xE6xjM2LDcUwFrOdyonqpBhDfe4lu51mUOWxAjBXD9jCil
         mlMW95zrVmLOefg0sqkJyuJ7GUFcCm7WJ/vh3pOLM+EyQBxUcJMqlHeOtib2ANb0/+gg
         JZIWzIiaovq2yRrXdTEc/K+yoft3C1QR3aXF0qtHTxrTebm67R/Zfwr8qvkl+PDCxiS+
         T9DNr/CF7z7YBFQ+4XGDW0CzI6j4ymlMaDe5DV399yrsW0G1mJbBEb1wARDhTGQkb2dz
         xeoLFgM5EqQz1pkN4jp4Kr8Et5X30yYdMk932sLuDBcjharBooHXc1ZlneSieJu4La4t
         7NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116478; x=1793721278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zq80UJ+hgfJc//pAabUCEXC8s+2mlwefGbT/4AIXsFg=;
        b=KF3n0tqa8p+TZ2WWxtnGrDz79oqgY7/9DswTu5U3F58KnmeejDQ5205W+l/CeKfpar
         Tvb4h/GFOjEiCGpVwpnvgWJoeoIqzYvgvKOTxNMshsA7Jpl9pmYphSqOxZd87UtN+lNq
         FWSs83VfJzhvYMtSIA9nGIPdCiYstAcJuuz08pDqBcmWBd2bY/DwSxTMbiNVKgWi0soN
         nmE7SVxsoRfEKb/7D0YSxAxbddy62snIIjYsNHv58NrbZHqqtOxJ5+OZeVh6VdZY+mJH
         uB0xQdl9Uy9CqJkbMMgT9OATMhRBIs/3t6GEq9VPXtAx42eueWtcL7kWKgoU8v3VtRnB
         3ezQ==
X-Gm-Message-State: AFq9FYKp8MRCtocIDmelgLsRfltsuVuGa0nWzxYv8+ildttexquESKe4
	ox9Oyw+Fkl3mlggV00kY3ela9viObAkiedIUjmatjUanpzi+6Tl3VuoC
X-Gm-Gg: AYBFou2mNHSFjh4TcxjS9waUDiosAobNPgvYdf5ChKv23RjGhhILf2j0YjDXNW92HbL
	+cWYaGzaOF0G2JZE8vwpDFOhPlKE+oHV7y4L72OmhF9ZD8LCuBRTyPpxrm8iNxC5usfaHzXUuDL
	EXT4lyZg+L4tjErNMiGNyn6vkYdthxbBHc+3r+Vg9Y9HYbyx/hWaYWIl8Q15cR51ixKelXLNWZc
	wQY+kgF7OhUZMl5jobNtpxQrr/r2UBOYS2U3LuolEb7WaSooAIyXf6toEReLkdao1SxTY4NRyPU
	G/Y2Fp1wEh0ReZ+ocUlL1qgdVb1gVXFAAZhJX3JaX7ub9mtaweHVzCHfpMW15lWnLO5Oa+y1IR2
	12VBAviZa+BCTQeqQUto3I0C9XJrmXTWNGinSYoay4m5q1PygFzD3yRjsz0K5dYwJpqy74yU8hb
	SxyDcfzemstRyy47VllAPnoC2iAdMwU53ofCHb/ukBakua40mb7Wf0wno3xuf9PkZ9XJs4t6i/S
	RP8v++gAsmNnblQPLzZiMnAt+rnbpGNKXe5gostfQT24Gq41osK419HQe8P0onkc3nB
X-Received: by 2002:a05:7022:3b82:b0:149:1b5b:1f25 with SMTP id a92af1059eb24-1993505e533mr15180431c88.15.1793116477644;
        Tue, 27 Oct 2026 08:54:37 -0700 (PDT)
Received: from yocto.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5937dsm34071951c88.20.2026.10.27.08.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:54:37 -0700 (PDT)
From: paritoshpotukuchi@gmail.com
To: mlombard@arkamax.eu
Cc: linux-nvme@lists.infradead.org,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	syzbot+df0058a8d0bdce7c4059@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvmet-fc: extend critical section in nvmet_fc_remove_port()
Date: Tue, 27 Oct 2026 15:54:18 +0000
Message-ID: <20261027155418.2005768-1-paritoshpotukuchi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DMFPJJEAQDER.1LTPXDFP8FYUG@arkamax.eu>
References: <DMFPJJEAQDER.1LTPXDFP8FYUG@arkamax.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_085438_705854_E3CAD93F 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I don't think this safe.
> nvmet_fc_tgtport_put() can end up calling fcloop_targetport_delete()
> which calls flush_work(), therefore you call a blocking function while
> in atomic context

Thanks for pointing that out. 

The current implementation of nvmet_fc_portentry_unbind calls 
nvmet_fc_tgtport_put() while holding a spinlock.

From what we understand, this seems to be a design flaw,
since flush_work() is still being called while holding a spinlock.


Paritosh


