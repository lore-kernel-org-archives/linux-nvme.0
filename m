Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E05E64019
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=; b=tP4s1v+ewe8rInTWJBcFAUN4o2
	PiaMoSGTwiK1kpaTfBoeUUmAVKXQ8i6w0UsFOkMqp4ZV4GQbrRIJgdjNK+jH1oUSWbX4ap/M0T8aH
	yE5VoIcN2f0oKf4y4gqhfdgxcwsbL+u9O627Wv4jWjhzntrzN7qvDucQCx2g+7vgIQDj5rL1edRcO
	2rI/xcvyUqvsiRHQ7d0T8mdihRexDVBv1CpaPQeh0f8b09KDKh8pYcV0v9Ox2XmxHIVTfAWdKYOLa
	/+E57Djy+fHi4kMuHr6RohtuKDss5VX2XuX2+g7TNbpCeb3ueHfnlvHzMTasGGtby4rVo0ofKT4LJ
	pmaAHvRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9LeZ-000000049w7-0ZRH;
	Sun, 05 Apr 2026 11:28:31 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9LeW-000000049vE-3Edk
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 11:28:29 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so4064920a12.3
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 04:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388507; cv=none;
        d=google.com; s=arc-20240605;
        b=AG+3vXl9HmMmiVadOELU96nNw4qP0k87l598v5Ymj9oJU10OeOjiTIjB20+1tbZ9oD
         Km4VpUdOPmuHvTqd9gnP6Bk4oRP+8fdOxdQulxbS6unYvRmDyT2iBVZd+NJG+U+yQvUt
         Uy8ig4W6ASLoXQp6I+tc/5ff7+KzY4yWPiPVmrs2TsuMGeEza0PiFU9acq0rZJJQHSCq
         HweefFvPejx7tsv+uZ6TrmwXSySYlDX6z1rLi4meH2Pt9dSLVP50H38DX0QtOZEFVwg6
         tNFdPjqvSvVAqEh8nh64Nyc0WiSbb7R+/Ji9NFb+M5ljCS2xMoUwNSqLfwmgNeTap5bK
         EV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=KJS9ucO9DD2K+E3KQG12gjjK9XUYHWCfppX1YFOR74w=;
        b=j4WLXxdaqRPOxHkx9oOfhsoCO8Sdu7ojTER7dNgrsHxt3XUxL0l+YF9gBM1WxIRKo+
         1selnVAjOHrOYB5HKdBLLrHUVseMygK+i74hXD2StQcdaKTprGcN9S4M4vDv9BBE/uV6
         X68yFffHASH/f/NBkujcVsLVnExPMQbmgt9f0X+WtTU8nCrxKmGi+bacMYvG6Lm5DUo0
         rbvumdtHtssc3cIPJW3x5pw2Mu9yF1PTLaq0EaT5WY98HfcfeC47sfwzncbFrSN5XFiw
         viwKqHnP0Ndp6vPk4vV6XTzXMZp6NBjJkSukpx7EMW4hDcYUPZPmhOMEfAGqYj9Y65lj
         w2NQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388507; x=1775993307; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=Slr4DOqw5o/9FNFLqqiOPf/kDlhs+Auy2QQtllr3Ro+rmrVyT4gyQ59v1ThXZ993k4
         DoCwzQeTKgb2kNX3zJ0ks48/BBYCw+1oQtEmSDN40eQeLpkperY/BRVBDOfqlfWSV1mW
         gdMYogY8GLJgDMzD1x+AjgLzo+daLyERuMoSI5PExwm19H3lTfcNWXBDftq46Vcp5BjJ
         C+7wHbIjwa2ifaUwNvavhDqq1qd0+9WhsWU/CwV0tPpsFrB0N6yuxeHWnNGiz0HX6Ot9
         Zqyb0Aw8Plpw733Wkvmb/OLEq7QzDZh3FcHk0/Ewi784jhTDevFqj0lAL3tvt6tzOEk/
         mQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388507; x=1775993307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=LOmaxLfpffOLgxVCmSrruvKk15FbEX7L/oVYuV89eLQC3/vfdGDTOV12x6ZEqCjTgE
         QUPUxGbl9aoICQ79A+/cxq+4DeReNx9fYB6cWN7uF9f2r4/zU5b9RWJwc4PiW910PEwF
         UwsWcLPBldH7+28EmByNoeorIv+ezUNNGtFNKVJGgGzAo+RcxJbO5VW5c/22HzpmobX6
         WaXFd3039RVtA8CzrTvWORGGlrftiDyuk9Rzgf59VdBDfXmy38/oqb9Gu2OPEHi+8fJh
         SLxdHnIuf2h39mEZUFFTn8wLRC5h8Q+5te82Vc/uU/eXpd/ggL3CBKz+ErrRbI2X5sc2
         RckA==
X-Forwarded-Encrypted: i=1; AJvYcCXdTdNY9UjVGUF/QyHIh0g5XAoHK5He/RnRa8TEgGjNCb7yA5g9ygwZrgpbkToA4wKmY4HpHqD6dIRc@lists.infradead.org
X-Gm-Message-State: AOJu0YyF8IXs/YOfY4zyclaF/wvUhStg9/FAxnkQPl4xk8j71dee4oe6
	cEZjiaLyUC7Otm+o//3BStRALQxYm80sjKHVxxKARfWdz61lF2ebRfO+L86gEp2GRVbQ+FsT8BG
	GOtqlyHWgQHLyw9R2eZW7u+LyeNP/nA==
X-Gm-Gg: AeBDievaqLLJZjdM+08m6XilwigJNQl1L8CTwIuz75Cwg42EUq6AdzTNY4lzAxZ8vOV
	tuO2aouE+1LHF4KkrydymPmukkryW8i7ENsM5+6/IFEEntp9DgQg2UBCR10pUu+Lih9e5M4futX
	fCDwiAyQN0a+anwZC8G5YrUq/maDEmFbGrDRsU0ZUT1n/dH/gh6sGW8leOtEcVCG8ECJtuDn3wY
	5OZEzdlUoSXiig9pLQhbKhihaK7NbP0OHyTXaf43sk/v5RehEfe5LsgYdrmQZaCQc2dVLZMucW2
	LVVNwOzfHClFrI685av818+xI1h/gI/ckh+TpyBlIV7SKQG3pJWfFZCTXvEZyeMtlpF8zw==
X-Received: by 2002:a05:6402:510d:b0:66d:eb3c:e33a with SMTP id
 4fb4d7f45d1cf-66e3f3cd75amr4391626a12.1.1775388506893; Sun, 05 Apr 2026
 04:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-3-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-3-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:57:47 +0530
X-Gm-Features: AQROBzB7BsO7HtCIFo-YLrsx_ROEx0YM6hJF0_8-6yyuGMvlIZYevxnPKzknkJw
Message-ID: <CACzX3AsJbxpYdVPiSeY8bjZVVWDfMuzGSH_dsTqzBvGGbkvx8g@mail.gmail.com>
Subject: Re: [PATCH 2/6] block: use integrity interval instead of sector as seed
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_042828_809559_CCD91ACF 
X-CRM114-Status: UNSURE (   6.80  )
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

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

