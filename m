Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36636CF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Nov 2025 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EX5b8rxE0PmWNT4vjormhkpeQDkMyKJbi7lKL6k0MA4=; b=s9q3c8S7xBEqlfdt7n0n9xSDJI
	vcKOnmR/B+77N2wwu6wojDihCXRVV0GSthCGpIs+XWwtQqOQ7XikttIvLKLfV8mJ8XPslj7tj0wOt
	ARfM0QNFLrppSsAx5hoID/w94i/MZq+TOFuJ6sogkCiSiPRK9XINdiiSvGgTj/Nyvj+pKhTcqs5em
	I2QIsCyzPWjN5TEfHMpx7/WnLEjY1I4bjHdnfM0lDWJiAC3lRb/qSGgOC7MTmMsbenNBxbuiI91Il
	RO2jynqR+fTQ98L3mT1pB+z4PPRqJ1tZbEYZLqOhSOQAlYgyIg4Bkob8uPIVnxZ1QNAW93PZs8kMu
	ozoHHt1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM6nQ-00000006wBy-2pZN;
	Thu, 20 Nov 2025 15:42:08 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM6nO-00000006wBT-2KSw
	for linux-nvme@lists.infradead.org;
	Thu, 20 Nov 2025 15:42:07 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-4349044be0eso4706175ab.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Nov 2025 07:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763653325; x=1764258125; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EX5b8rxE0PmWNT4vjormhkpeQDkMyKJbi7lKL6k0MA4=;
        b=BfzhYV3ooRux6l0ZIvqGvbrO89GY8LnVxcoiLoHfJarcHE7cpDDDk0c92U7LJV83Fs
         jB06M0TxCMkN1WOQf5irLrEYzeIrJ78AQBB+8hHK5L3kc/CDIg2cacrFT6q+cTxv8EaI
         ywUEQPjcv2H2f4Jd1gfw00JIWy4dnQywey3VwEzzBMnjeNX2M/BkX0NYZaofbYPXBEgp
         5hm6UmqJbK+yCI3EWFZCFIMuB/eRResPV3nV1knUxn8QllWDhqjNwWrHedrFLOoyRqY/
         zqyLSAbYn0yBclOd1ImdpgQrhypBftpkVYsaQPSn5lEh/YBPP1cocxw4Tvmu3wQeD1/r
         fd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763653325; x=1764258125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EX5b8rxE0PmWNT4vjormhkpeQDkMyKJbi7lKL6k0MA4=;
        b=JQbJIe2PnYAFjAXoQ4Qj1RmbfcILbhDugpuNy5qxjWmb2zVHH8DPhFN8QNrVzOISp1
         /eP0pNusiXlKdva8pnlSkqpNnfeJXv3oUq3Y2M6oqYOazbZ5NWFYWKUpTqidiU+DfBd6
         7SDL4ZrV9vNBxM13ryPQhRFkVRUzuqfer9EoUJGWBqSSqM82EV9/W/NEMF8vMJsgYrOu
         4zTBYEkCT5rKZResTP4hTNX1YPfyob6F2kuRUXI1uSXrfUl18ckMpzAFPoelBWUCamHF
         /4GTxlBM5BNHLdC8krvdMqwqYgxwN+nXfyxNlAaOmObhj0d++c++B5pwYnXU9MW3kFtu
         /8Tw==
X-Gm-Message-State: AOJu0YyTYIgsldAlgttNTUkb38A/gDpkw8DAKmeVmks5AIoK/KK2y58o
	RHiSBSwfFvTYUHTA1AFGqL/AVFhJR3ak2cGIwFv0I7AISgJplygUhoStEdoMhHtHBZQ=
X-Gm-Gg: ASbGncsDdNpcvpPqvagCZLpQGLITQ78GuabpESFVnxdLa6OJdgYGlxvpgYyXzo0clfO
	alKAdmCHvCRFf1Sfosjhwt8nAoLwn01O7Bgm7MhpYG9wT/zggFcaYoTo0Xae7WghzGbENd6G2ui
	z2jeiw0/CyGF46UE3vTt+2BFX2gODph1uECEdslFs3f7xQRjk/TwYE61cD/zHzZ8WIGsmvGenHg
	KTV16tMhzu0E59cl6wr6lEsGVcaVxbPn3eN/bGrNlGCqN6K3Rmj/ejIzA9/rL3x5vAQloEp45QP
	d5+qxvvJR1r6QFZ8/FDsGIJDaRd0+P+RqERJyoaX7OBQG8JGwHwJh+gp1czGENHLWqG2g6g9ism
	MatZGbgM4jCpUfWScL+BQ2RZfZSIoNn2jFg7LN1z/OyzUJ5/5V9hJNnZziLnD1vke9qbRugondF
	FxTXDxAg==
X-Google-Smtp-Source: AGHT+IHsbkcqWdK7p1V6M9n6bqqGIjuqXE/ug1nRQ+TipQua371SxbGNubc2K+fwTsj/qJFi92KHAQ==
X-Received: by 2002:a92:cdad:0:b0:434:77a5:fea5 with SMTP id e9e14a558f8ab-435a9e06c4fmr24454285ab.25.1763653325444;
        Thu, 20 Nov 2025 07:42:05 -0800 (PST)
Received: from [192.168.1.96] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a9056bdasm12182835ab.4.2025.11.20.07.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 07:42:04 -0800 (PST)
Message-ID: <c50520a2-1f22-4a75-bd06-8e44b8604456@kernel.dk>
Date: Thu, 20 Nov 2025 08:42:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.18
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <aR81XMUX0mILxPpz@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aR81XMUX0mILxPpz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_074206_601829_658E405A 
X-CRM114-Status: UNSURE (   9.21  )
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

On 11/20/25 8:35 AM, Keith Busch wrote:
> The following changes since commit 0194b65ab571430130a11f8500894bb88f7af2c0:
> 
>   nvme-pci: use blk_map_iter for p2p metadata (2025-10-22 19:46:25 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.18-2025-11-20
> 
> for you to fetch changes up to 0a2c5495b6d1ecb0fa18ef6631450f391a888256:
> 
>   nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl() (2025-11-17 09:00:42 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.18
> 
>  - Admin queue use-after-free fix (Keith)
>  - Target authentication fix (Alistar)
>  - Multipath lockdep fix (Shin'ichiro)
>  - FC transport teardown fixes (Ewan)

Pulled, thanks.

-- 
Jens Axboe


