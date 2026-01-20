Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ACACA5FB7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jan 2026 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sa8+4KO1m/ufVgLZFpuPOgrMf4fnNhj8yXe10/VofOY=; b=tRAvoHE3vCoDrW3t8S7dLNXx8O
	GbRcX9sEEW5mUmqdLGMBW5oJeAXZ7wVVsnUsCabWh5m831158H7Pi7LZHHBUvNVi8vn/Ynt99Rn3f
	IZpy/7QS1HYWJ4nC5sSIuWGmKWnMguvB+bmCaVVYJ0Z/yIwPHeR85JMYbzNrVKvNH6IYt6eYToMH9
	evBAvLRG/9Zng4u0u0cwcF+nEyLBZppkc8pcTdvwy5s3urN1YkJ/KI0dYo/DfpgqfcFChqM4HdxY1
	+XxEE5AuVTwOvYxyel3MeIalgmSbkjPp4vrXc/uBTNIvO7ULgQE9PCzpFW0fDBFGZJUA6nln5XbP0
	yIgu2IQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFTM-00000004Emi-38Cx;
	Tue, 20 Jan 2026 17:24:56 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFTK-00000004EmB-3j0M
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jan 2026 17:24:55 +0000
Received: by mail-ot1-x344.google.com with SMTP id 46e09a7af769-7d148db5fdcso3251a34.3
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jan 2026 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768929894; x=1769534694; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa8+4KO1m/ufVgLZFpuPOgrMf4fnNhj8yXe10/VofOY=;
        b=EPanSNxI3sIS/EGKqiAaVH4JCmFHjOpwEreoRHEpiTXJHpgmqDd1+Gw9lHYOoUClf6
         7zbe45QxzGFNU/pmkPLUbOjnhnDnYbXRDiDCHLYI1LkfeNFwXMymDjLXzlaJj1bavAT2
         YRAfjLSL8LCYyhCRA7+f3YnfMiFRdmllwkBDqn4xYz+Evb/DxBXJRQjvCeOX4pLFqcuw
         XLPrFcReA/RvBqb9lUSSqOv+RYBSqY33xExW9x6tkTt2Gx7nIdhAEdf8uJ2pEJTCZMMP
         DbNeTDa0N8iVqwTU28mqPteimlgdvd96NvTzB/JXOa5L0tt00I5WCwYM3iIyrEGexnw5
         M/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768929894; x=1769534694;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sa8+4KO1m/ufVgLZFpuPOgrMf4fnNhj8yXe10/VofOY=;
        b=UhkynJc4ytl9t3Qve3tgSepC0TK74bSMO6cy5cBdHPaULZdUkzHxRlgXcpInfpyf+4
         mMaG5FDFK4AZvsLXRvJ9F8jRy9GsA2BY78Zn1C0smhOBr0ISvwDJYrpEPzQqnioFs1Gu
         miRr8NgjnIXnQ1OIizp7yXdG1r/lXF4wtZF/jDmODtB6IYDhN77lzGtd2TLWBh1NTw/0
         2p27RlGK2V+7YVuBYMaZOb1kEyN+Va0VXLM4srE/b5g2HR9FMEZebOlELYuV6GHR2Jvj
         vrzVHb7C7sy4obnI7R8O0OfugOw31LM9zzVhcQF+IWHrAVgD9uNcAHvE75VuUdL68EtK
         dlqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfoDVnSM6xqPjbzlKJeCXasZYgWClb0nbL15+Th/orDVEda1fXnEAP4um8rgcPgNjxK2Rh/0ZymNYq@lists.infradead.org
X-Gm-Message-State: AOJu0YyVnR7u87/Uad4WrVTeYwVCkmbg4+4Hlte58V0GyxezSbCE0TqR
	pEwtzYDvS947OeYO3fvXEnBKtA2ApMfwt9Z4VvaUEQ8MxKSmRIY+QJMXEP9cc4iACEY=
X-Gm-Gg: AY/fxX77U7exMrY0fuz9+Al4AorRWWEZMzRbOLqXxJTjdknx1HVUxM0UZIjXJRgmuUh
	F724wbiVpa8gJHtRJoWe3IRmNw61XTwxqoPZPTKe8FpPRT6VnWa4d5k23XEDIAz5+F0ETEllcIU
	5ZtnRF+s/oHuM5RYIQmH7wv/PXUnipIs8XCofTtixrQe+Rm1i3uhf22QBEfU4w7/+fJ0XaTDn2+
	UtXCZynfrbJ0MCxqLu8wpTW0DaVoS9wgAn19m6ELE9Qmjnbu+RL1UP5swsZRsrWAxuAlzIG4iVR
	YZoxBzHgCCTc/At/NagQHG6KORQSLfvJKQLCpdMnMXbFrvmlS3J15yS1ZbHj82a5ZTN8c0D45D3
	rqrTfaaT9FZx91SvD7hBOQ5dwYKfP4t8fhujICIOHKArSj5XDehWr0yxAEHHxg61QGwJPYm6kFW
	y77UmqL7HHlJWkzgSIQV48/Ug6kkGSb5gF6l75ATXODcwIeHCkrdLGutxBbKFCoiU=
X-Received: by 2002:a05:6830:7006:b0:7cf:d822:37fb with SMTP id 46e09a7af769-7cfe029c704mr8422971a34.34.1768929893712;
        Tue, 20 Jan 2026 09:24:53 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0e9209sm8932389a34.8.2026.01.20.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:24:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20260116074641.665422-1-ming.lei@redhat.com>
References: <20260116074641.665422-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion
 for local ring context
Message-Id: <176892989230.1994823.2473484633888931536.b4-ty@kernel.dk>
Date: Tue, 20 Jan 2026 10:24:52 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_092454_934831_3A39EE51 
X-CRM114-Status: UNSURE (   8.19  )
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


On Fri, 16 Jan 2026 15:46:36 +0800, Ming Lei wrote:
> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
> 
> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
> context, and improves IOPS by ~10%.
> 
> 
> V2:
> 	- pass `struct io_comp_batch *` to ->end_io() directly via
> 	  blk_mq_end_request_batch().
> 
> [...]

Applied, thanks!

[1/2] block: pass io_comp_batch to rq_end_io_fn callback
      commit: 5e2fde1a9433efc484a5feec36f748aa3ea58c85
[2/2] nvme/io_uring: optimize IOPOLL completions for local ring context
      commit: f7bc22ca0d55bdcb59e3a4a028fb811d23e53959

Best regards,
-- 
Jens Axboe




