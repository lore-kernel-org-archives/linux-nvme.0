Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22377E64013
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 11:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=; b=oXEps52tOJ+b6b1RsefCU+CE1c
	D2bWb78zsAmMzCYNiGBI1CtOzsI6/TCWddbuLeL+JYIqfL82gAWoxEbwt6MoSzHIGUYG9QFIdKqtw
	Ia9PrIF3wnyb7jTeYhWJLYdx7vUDBSsT3idD+m1UmjBdXfO2DuHIT5O9fRlF+vf4pGv4ljlFfwo89
	IhvQTi4CvPKlMKPIWhR+stBFFQIyRVn2FtQJM9w91nVVuKoo9N1QM5eIgfr24ZcmWV8Fxtbxe2NyK
	eOvycoKoyRUQCjRfh6HJlJmv9Mifq5bfmE8/+ZhC8UxGZXHNiKR5Xw00Kk5tWUMF++Cmfi/8h41ON
	xVq4bhgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9Lfp-00000004AGG-3udA;
	Sun, 05 Apr 2026 11:29:49 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9Lfo-00000004AFY-0xdz
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 11:29:49 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-66ba9dfe83bso1308729a12.3
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 04:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388586; cv=none;
        d=google.com; s=arc-20240605;
        b=Xnsg0hVSklUNICmDG6qhI5pOcdWKGw/yi6rN7ckGXetKRC+m/tZrCZAJPFH7TR/g9f
         EivUWPE0k1HFA9jjh3oONW6lEFRNqVaVCTsLJV8M62OodP+yAAHOy+4ClZ3KlZkHlNMJ
         A37BvEt7hEudTA2t+ZdtOtFADVm+qFTfQyBiSuXmIwc28JBi+xLimJ3hfUDMe8EhtT9v
         D/L0Wc71GAlDp76a52QGraYmZRauQ8/37jgq0odrr57Rp2e6zQ1EZbw95eQ/3BMSSjZP
         FvZQ+cVw628RG+3haQ/TN9xIr83s9iSKRRhsfYARdaojzC6GCZnv4Rw3KTnKjsZ73htc
         dIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        fh=D2nB4TcoeFtR1iweFi/k9ngkKaC0f0v9AxWEmbz74vs=;
        b=X1+l7FbLaz4ohZgwmKZOwcm5hGDOHIETrhANIPsPXDj3rMfQVUmZh0IMKfX+1NEWBh
         oOTzxJiP/moTUWdglQLzcyML0XiYJLTGfEsy+UnNuswM1tjGlxwZlrNm6ETB/S2GaFnq
         HlpX9oJYUWYpn9ikcBCDaGh6lt3MLeHChQSpK479nky8sEewJ7rHpHy7RpqLUIi1w0xu
         pp7G9wR0abztrcteb8fQBmzXnUgRFZxqe/PMCcXFbmfNW9y+1J3euj+avHCOZniswGs9
         /yJmxuqLG6u5xd+P7D9Ed2wKeQ8rSftn9YkQvo7nqjN6sQrouCf4p+OHcImmAZ5V4Xq/
         vPag==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388586; x=1775993386; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=cVRfi73X/oatHXNFA+vjW7UqWuZS6tqE4LdS/cVjSB3iu56Y+L1TPhW3LQmhSY2stM
         PmRODn2bQUBl36MXCVVnxB1wBmOcnSFrXYnQf5+BU4QkcXtnPH6+CVSte/ZzVZ3AhdXY
         48+I85BbC//iUDxMP5NPynPp+PxVrKIgm/AcVaE1+Lj4VvioWyFH0E/NPt1jrSbOAiOW
         3MmXbC0NcXeqcpBFhltl08VeT0A9qYj7rrBaD79FoOMYE3ZHzhnU3i3FUfDnhwrNTfTV
         rYnEEtA/i0z0F10QXSvcyuKn6pHT0BbBRWdGQkeiJObzGAxpclZUAstH4Er5Ug1JnV/t
         HpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388586; x=1775993386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=CW8EwqcteJoR0tc3GkgG/GXuup1IL6xZXmhzX/qvVYxHwuXSARadYxIC8eo/NAqZcv
         OaAHogZA/yoqVfq2PxUyRdJqVEJuH6t3tprUSCVITuCm7Vou1w3zxMGEURStcDw5MnYa
         TlzjPoYIRX5EfUOaIMzlxELTOzaLnKJtk8qcWv/cX3Z74JttJu90+ozGsu59T2RuYDAZ
         P7B2CB/T2FHFvSeVubGGBelSgsabGvPzuvkSV/vDW7AaUzsnXgPdcUwnedn3ITUbLC1c
         avFNjbmjh9q0T3kSEL/Sv939aBqkIypIEu1XOfa7tczUc4anJQeu+iPNNUyVY3IpdQv2
         c/UA==
X-Forwarded-Encrypted: i=1; AJvYcCXUBGIorSoF+trkcp4YIJbx/0Ir3ZwbqfdPU8t31DrZJg0yGT8GH2hEWv2TDz8rNbLKkFn9cH1N88Rn@lists.infradead.org
X-Gm-Message-State: AOJu0YyAZaCspa2GifSqrywUI9qdyxj3XtUIHMdmgQnzforz/ml5UPNg
	EgToK6EMlEZAoH90G2yCmtfbGEXWk2PjcYxKV1enh8WXDOPdqstn8FfcZMK0yNnup3kz2UPqeq8
	o5ZOQ+mjdDKtXMi0pAY1jJba12I5bTQ==
X-Gm-Gg: AeBDievhjy7gVToAtRh28OlkjUspgMPFJsF/xJUPCsr8vVKHNR9NISaEyOD9fGRxZ/S
	EcIEDbouFXilWGCvvHKyy9il4SRvli/j76IvmVzRDT1evLYe+NTdLOPj4ap2Ydegn7tMYE4hp6O
	QnblnwzR25Bp661ryFYJmhJxI8OMuvUh126YNpWsM7CV63MR45R6ijgX4asVG3kHtFUhhdBz7LG
	fkKHeWaHpPzO2g/ZcFo8mIzyt+Sw9Sr84U8ZlQJYe+geD/6b55RgfDKea+lMpSHFkTSkAj/v9WB
	NsAU83obAdjZUU64F3eXE2P1zFPhqij+TsaOcifPxyPKT/RIPPXKPcBddNzctXv68mI9hg==
X-Received: by 2002:a05:6402:3593:b0:66c:204:5d05 with SMTP id
 4fb4d7f45d1cf-66e3eeded1dmr4265550a12.4.1775388586173; Sun, 05 Apr 2026
 04:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-5-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-5-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:59:07 +0530
X-Gm-Features: AQROBzCtWGel72grOiSfI-Erz5HUztph0xDvnagBcgqetrQpIdqD-KiXs-24Oas
Message-ID: <CACzX3AtoogGGYdJVhbea55+XfAuQLd4BVzsjwp9Q2R5_SugDHA@mail.gmail.com>
Subject: Re: [PATCH 4/6] bio-integrity-fs: use integrity interval instead of
 sector as seed
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_042948_272574_ABB8C4C6 
X-CRM114-Status: UNSURE (   6.84  )
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

Looks ok to me.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

