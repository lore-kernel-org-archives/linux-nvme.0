Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7A9C3ABBF
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zkX3c5/GMMV4oRJ74gAOyvqF/rDoibhnZNI5+zww/CI=; b=uXPpjpJIHvNpkZ0PaVWnonK69Z
	g6QNg3+IWCcBNy0ysSLXmI2afPxTrLoI+BZSOYacBBxi7wWSznQONmAf24339o+Y+EnDIKvu2f+Gx
	juE9iiQEyLft1Tszk1+2DOpvDBAgNhbGhEBo8wFlZGwUK0X63snI+FnC8pwurRSfua/wNNGO7YvNf
	0oowH7wlPMmHT8f2MDeFVP/zh4rZdlVZNu0EDrm1XL/kTJ/og/7QWSmlgxySUqizqarjFgpFyyLZo
	M0WEFtpAswZ4CIx2wFyOLd5Y+lkkq7zFBLRiiZRwiOhfHPDEg2ATRW4UKFZ+FKLlVV3F+nBA7bynE
	frvuF4vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCS2z-0000000DjsO-1NRv;
	Tue, 06 May 2025 23:50:01 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOFz-0000000DGdR-32I2
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 19:47:12 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3d46ef71b6cso60744075ab.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746560831; x=1747165631; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkX3c5/GMMV4oRJ74gAOyvqF/rDoibhnZNI5+zww/CI=;
        b=E1M2LQbzStc+EPMZeQ4o/bQKmi8AHXXXC4nPevKeMtOgDXK4rMTcpA7vepepFEI9f4
         encr2YXa/M2sFRR9uA8bFwrHptM97XAfAaVWtEL8IOndbQ8Qrkx7bpf/1r058bcFiqDb
         tUFXxYdnN6JeEPa1cINOgDQ9BUOcgmX7kUW+2l5iVeOcT2z1SVquLMuN99AbtrNIy7jr
         8NxeSV244RpHUg3Z4uBSPMnuKtKzFjU6qtqUXadxADjlQ3sTSZrZGThxn7eghEEWgt21
         okd6ZOrxVRw1klYfItxcsGvEUkDurT4Bf/47OEfN14f/04A2zgSCPIIXnf3TIMMkznv/
         4bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560831; x=1747165631;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkX3c5/GMMV4oRJ74gAOyvqF/rDoibhnZNI5+zww/CI=;
        b=p5DInO9pj2PsUlR6j0/hzElfIZriRwrEWVJ7Pi4Atjpb7HqFpS+rVm8WkS6bf1UM9Y
         mzdUw3Nl+UzjdVzZLcnRHDW46wSQopLHACX/wLgmz+Z5AN+u6n8NGvo/Z0yEqhVHsW9G
         TmDz/evVf4lXHbJbhcknZOeP5W7mUAW2/wn+MsbalSoIzwDfk6TfT7wZ5Ds2FFyLHCvV
         hscRTYG3GB8H5K47y0Q8oAh5wdEE4kj5kCnhzMPYqPTKCx3XQrl+/oxpEItUFtlh7TT+
         vBZLEdWN/zTsu9Dfs7vBSwh22OB3HLZvNrE4uSwkrRYZvubUz5QLKvuxIRsRAWLiMNy1
         /V4w==
X-Gm-Message-State: AOJu0Ywk1lvUvr5OVq/Q4JrBOWBy/WijIG8UAKHESU6Juhmt18jZYO6N
	EZMATRZJ9wOGgc5hw2BYbfMbzbhq8dLxmUTiVj9aw55hx4Ynhy5k69HGmR2TGnE=
X-Gm-Gg: ASbGncsnvlz+EKF4PSTFv9Q2kWv2jS1+Hy5LBmpJ1uyGwyXfXCAdSAvCFtzUpZvjT7F
	XgNovDZX0awZGQIAQWdvvPc+R245h2JWQjzttCfiDu9c4THyHt68ynbL8VBNN24GVa/72aJFasX
	L9JqsjouieRwQT2YtgoyLP8O5mRi0SBp0i8I72CicEM4AuuC3HUNFA5icwA4UK/f8P/xDkcT5dV
	+9HvlQ8uvW4oigB1SimewDSJ4KbDbDp9/yZsNwO2pJfOTjC3D3bwtDed5BUltWsa1FsJir5KOX5
	NUYdkP3ggiwG4ro88RiY6SMz4UGEuZg=
X-Google-Smtp-Source: AGHT+IEy+u0t14HIzWKrfb4cSWqt6yNDK8lOEUGmHQp0wvCPWclPXGAJTOLeWBXuCnkVFmOaq5G2Jw==
X-Received: by 2002:a05:6e02:398b:b0:3d9:3a09:415e with SMTP id e9e14a558f8ab-3da73933cdfmr4603155ab.19.1746560830842;
        Tue, 06 May 2025 12:47:10 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f58f36sm25962075ab.51.2025.05.06.12.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:47:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250506175413.1936110-1-csander@purestorage.com>
References: <20250506175413.1936110-1-csander@purestorage.com>
Subject: Re: [PATCH] nvme: fix write_stream_granularity initialization
Message-Id: <174656083001.1636559.2161433067551641939.b4-ty@kernel.dk>
Date: Tue, 06 May 2025 13:47:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_124711_770236_4C60C2A0 
X-CRM114-Status: UNSURE (   9.34  )
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


On Tue, 06 May 2025 11:54:12 -0600, Caleb Sander Mateos wrote:
> write_stream_granularity is set to max(info->runs, U32_MAX), which means
> that any RUNS value less than 2 ** 32 becomes U32_MAX, and any larger
> value is silently truncated to an unsigned int.
> 
> Use min() instead to provide the correct semantics, capping RUNS values
> at U32_MAX.
> 
> [...]

Applied, thanks!

[1/1] nvme: fix write_stream_granularity initialization
      commit: 86b6e0bd1a69efd0ed408997e0adfb85df96a0c7

Best regards,
-- 
Jens Axboe




