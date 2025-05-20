Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF356C3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8patin74GqqGF7MlUY8lT7uwoy7aCVFNgMaRNp5gnbE=; b=lpyVTLhMTy4MRQ/B+WEg2y/DGU
	gDQpt8YYd6CVIynWK5DCA+J1ZhNp7N6ZZJdZnMlqp6dirtRDPEo+sak+x/1gbEh+YaATxr1AN3OEm
	G9ZEaY1yfC0HIpEvzDX0eW9NZRRouYvIsbPsZ+LQlWlv4QC8Lp3c4mErl5xErG+HiwhhKkAB4OrT8
	I7xPtDnpYWmiZwVoB34sQ7WChFyFTEhiA7+Ynd7wBGNqstTFS6IWCtsUZ8vg5PJ3zwdr2Jh0FG1ie
	32mDQBnO1OeksnnuQ66b+8a5H1uBw9t0i0VyUDXsh61lELHilpz5nYHiiF1YyXqn25SD9uuuNe3Au
	UypIEmbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPe8-0000000DUJ0-0cOS;
	Tue, 20 May 2025 16:16:52 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHP39-0000000DNTd-3Jb4
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:38:40 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so995183466b.2
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747755518; x=1748360318; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8patin74GqqGF7MlUY8lT7uwoy7aCVFNgMaRNp5gnbE=;
        b=i8QI5QB4soGmp0a3UKwuejUMMsR7fkX2i6ZLVw/QdgvkLATvDIR4IJ/Ey9EtyrqALx
         QnolU5rZtOvu0D/xJDaImRXZWnKDiKeBqnY0LOiwxJPcXPSJUEmE6rAZbpyI4BH7LK74
         MfypBDvYUMBPFom5607RKadh1iLOpB0zs9CDrYrDgE7DaCPtG85v2EwP7NS9f686qS9m
         oa1SpnISZ7YY5AGpFUNeTQsYZkcVzixbvoNkO0qlGYj/vCWajKiqHMsh7isJXs4Pucuf
         4uRJ5ZvsjxiTbuIQQsu5zMLCn5BatAYr2fwD3n1ejdPkWMtNyPmk9oSZaML+8WhyUPgJ
         +MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755518; x=1748360318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8patin74GqqGF7MlUY8lT7uwoy7aCVFNgMaRNp5gnbE=;
        b=l2MbKmd/UUhchOwKbNmKjIOcr51NR8ozjmZifmopXD3ZNDFwESkJEMPnWa5tcArCZ7
         YXpp3BwqeKU3loL9L2GqcSeZ70n4rJzuYgTzaodD6bQPyrYaBtokRTM2iiA0TpjKDndl
         NZ9gloqcQbzWOhm0RqqhJu7QoI+HfAxPsrIVxIKi6SYJqdd4LNZmhVm40j273w/Ndo4B
         twQn4ucPvPcR7JaWvnDhFE/lhvj3DTH9EYeGwl/qnjukjIBk0DMueZYCKr9oDmn+MRFn
         9YIPpNSUjmyxY00LJwRdQ9aCcUlbEsHkXypRqjyB++5OeOk8TjHyK+94VMm3RjFlssLs
         GHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV11GVp/2OLK9CIrEdOp4z+c257p0Kb8Dekaj4csCtcZ4So1wBTTi5X2K1Zy2iM+SkG7sAIHQ8P1xDx@lists.infradead.org
X-Gm-Message-State: AOJu0YyQ1Sgl83N46iTdOZmvSueHekUF5Tf4OouIO6C7BIvOkiLerATO
	fHtwfRLCiO5hwST39nEr+K3+zLRdOggPFAWpumFVsjobXWsWjpms3IfFQsMikFG+2Xrh1+N4nd/
	CBgGkSAsPd2w9OBDPrjJk7/s9gZ6gPA==
X-Gm-Gg: ASbGnctGr9jSlE41Dp9tirxKrVvZTOKwDRfVbcxdfCLdhmGx8n9rL/LW0Fg1pDOJ6mO
	BBI/papDkT6c+v/zG7US3s+YA7aboknSk/A19lXG2I/RTbTmrujBmCkyqYcHjALOzSlt8zTfeAq
	eY7zKTQk96qpn+fqLBMtucCoJMVGJC35pIK1nyGlAilQ==
X-Google-Smtp-Source: AGHT+IGnZIMuZjWZcq7uSAQF2L+3s0l7Q1WPfPwu84hheak4nemSyfDkE+9IGCSRuZZ8k/KVGqI35fL16hzBlHVTH3w=
X-Received: by 2002:a17:906:fe49:b0:ad2:3f1f:7970 with SMTP id
 a640c23a62f3a-ad52d45aef4mr1693060666b.2.1747755518180; Tue, 20 May 2025
 08:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
In-Reply-To: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 20 May 2025 21:08:01 +0530
X-Gm-Features: AX0GCFsLmF3t5DuI_MLsIoTRV3g4_kxSXrz_iTnqpNt9IVNFZRB0zNDzIpK2eCo
Message-ID: <CACzX3As2nyCRAm8S3jR9wJRfVUs9Bvxtewrg_O_NPfASMkOP3g@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: fix implicit bool to flags conversion
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_083839_824071_97DF0F19 
X-CRM114-Status: UNSURE (   7.39  )
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

Looks good to me.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

