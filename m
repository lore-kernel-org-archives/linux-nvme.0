Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1DBC369AB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vGkg6fJfEeqQsskmUDXVrcnD2zKVMxuHFOsr406hQA0=; b=HtEyzAGcVsfSHCuaQ4n4pS4l/+
	s0CtG0hlu6Fs1CIDaGHl08M+Intr/XdA+W0RzjNPhE4PTLSbkehiNOt7KIuBxPMH73Q2Oy2hVIgEl
	0E5Z2bhTqwvewvYUiU5Fl6oktvc0yO+B99SKUfRD7DvzgCmqyV2mGpiLHWy2ZhUcArmxbixh/kY8n
	QBgwBr04TQDd+JMxBykBbq/KSNYFSDYlH+fnLq2cZiIy1zu4TWAlLAhFqyzsM80khuQGtslriBz8E
	FIi7iSm2ikvHdHWHlEwnOcwPp3sJ85ZrFfbLpW9G+Z/s99q8G/txmb9LeAXIfl5Nz6J3sdZb1Ic1P
	ON2DtIfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6vyI-00000004vLu-1F2F;
	Mon, 21 Apr 2025 18:34:22 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6vu6-00000004uvh-3k5Z
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 18:30:04 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-8616b7ad03bso47123039f.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745260201; x=1745865001; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGkg6fJfEeqQsskmUDXVrcnD2zKVMxuHFOsr406hQA0=;
        b=tiKF13Xk7WK+xL/+1hUIiFr2lZ2FQWk8DN2kuz15xPqz74ocnZJ2BNmtWx/ftd3RcY
         LoCF7Yl4fnrEU/Ys7oWPHQ4z4AT0AdTDoXkD36N+1SPyDJWFWkP5W2qYc2wjqWhTOs6z
         /2KUfOPe1hXXOC9yfzNWgN4gPK7h5V5cSgs+LczGD/QgLkIhzG24sFjbkEW/O7fkfXDJ
         A3ZicBFd1ts+RANQo1uqGHGTv2lK8ZIFZ8zsaNDlB1XnyuYlW+bkHZG2aoOhBRLShChx
         dWrtmvwu9cz7L+mHOluUiCc5tEaPNa+RzDpuTzBmmUm3qF7GQ41PjdNjpZ7QC1NzgPMR
         FS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745260201; x=1745865001;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vGkg6fJfEeqQsskmUDXVrcnD2zKVMxuHFOsr406hQA0=;
        b=Go+ufttE0P9xnJUVNbjyuFDAoCWKTE2t5sBAseeXIaw3ZKIreWTNbRcY0rud/iBZFj
         onx2hbmCuPrN+aybUpr/ZwYZ/chpRx2x+WUN7gXp1vJWfsaDTYgepizSHhTqyI+2c0sM
         xeksRKJOU0L3ACNfnHkjq7jEUcqGmEgLNViLJ5+zg66p1nYZwrvH0Iarr+4+Nx9m/Qr6
         g/zAcknHX5cJQMFl/5ILyxTbmmxv6uK3VKLkoeahq2PHFkckehPpLBGptBPFT9R0Cw5P
         DPYLEFgsb4UtDORoSQgIfOr+9MNKatkmBcbzRcAXHo6vIVGgzt1F/0x6aJg05OiJNeO9
         99QQ==
X-Gm-Message-State: AOJu0YxOQ1m/GIseKS6ULM1wPBSpGj7U/6mbHWFNm4Uq5xgPN1hB2el7
	lft9Oixy4D95FIN97osfHIp0MPz/k0DGwyEgAnl2sxRPqutYz7oU/nbKRJCpDjQ=
X-Gm-Gg: ASbGncv8wDU8LB7G6dxhTCutwY1mFaXt4rWxDJKeZMnOCGbwnTTmQTrF5OUYStjuCQU
	gNng4mYpeDNL2dkRuL1MSlb+xeqFWkfq2O7iSMEhpfEH0PVSnofS5DCvaAjG2qhTSsIWm7GT9O4
	FqU/pR3fBgg8UDsP+5yRJS0rrVAwsPu0Orr6jwkeM3lJzzrpHC4IWokNOIW3lOYZSPEhfhFuH5D
	anOxYGHzDD00iZRYtjnlU6uxAQTM+JhWKjJjMVTa4xEYewJccORDYGyISkoNkw+hj3jjmpPimge
	8sX7Gk7JgbuAkt4IGPc1LZ4dca1pkaTJ8J6MWMFca9I7Zi0=
X-Google-Smtp-Source: AGHT+IGs+RY6yuQIDSZ+7ZuvnOYwO/eV79WXKG2RfxjH69TJj3I/337jZDquAm7a3dq3yNkCxgc1lw==
X-Received: by 2002:a05:6602:7216:b0:85b:3407:c8c with SMTP id ca18e2360f4ac-861dbe93745mr1237803239f.11.1745260201114;
        Mon, 21 Apr 2025 11:30:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861d96129aasm179946339f.23.2025.04.21.11.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 11:30:00 -0700 (PDT)
Message-ID: <b858ce52-212e-4913-963b-07fcead96f30@kernel.dk>
Date: Mon, 21 Apr 2025 12:29:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: for-6.16/block rebased
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_113003_200459_6E8C0D1E 
X-CRM114-Status: UNSURE (   6.98  )
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

Just a heads-up that I rebased the 6.16 tree this morning, as there's
been a good amount of changes flowing into the 6.15-rc tree. If you have
a tree that is based on the block tree, and you already started it for
the 6.16 series, please rebase as well. It's early enough that I didn't
think this would be much of a concern.

-- 
Jens Axboe


