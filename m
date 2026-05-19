Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B431CD4F5B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 09:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QoHvwM4p61ukSgPZjfDBcRJdrzaBcrrvLVu02xCIKiI=; b=LyYvNqoZ0ZNW8sOIL6KzuJWPhG
	uGKYuGdRUvoI/UAJCJkA1IOLHQh+hyNLSjTsSiZDZgFrRFfvsQa5bfWSp826oLZp7ab0Pfo8owCSH
	B9Ma0fXXxnpQM8oULMqW6MuCoFc/YYZrrVL3jk9UrQZq05DKEe3KIsTvvAjd2kzB/CkFnsQPnYZGG
	zudWmHoB/MEB/NHXI4jHc054FeaEI33OhgjJqQI41q2Unu4p4SO8bSwcdXT8Oz6CM1RI+3to9INZE
	AW4CkvQIv1I8YSh18io+B5TLyKnJPqSeQsxRbw+axOIicRtTlkxKSqDxPGnHVqD7RdhFPBzz+ytkH
	1dnicJzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGeB-00000000tr5-1dy1;
	Tue, 19 May 2026 09:21:55 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGe8-00000000tqB-3V0h
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 09:21:53 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-48d146705b4so35847525e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779182511; x=1779787311; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoHvwM4p61ukSgPZjfDBcRJdrzaBcrrvLVu02xCIKiI=;
        b=BwD9hKRd5BSznBmBIZaFj6ErYEPEIBoMzNAMv/wzt1iJBv/IrDgUH9tnDC+OPHNztX
         4xGTr3qKazz0NyxaUTPKlM3DU6YYgs+wvGDN4Rj5rjEPop9B/xcgsBKaYvUc3F8HUPRM
         x7GI2VNfpL90UlzGPaRN+iI4olg7rrqpLNUzrkIGpaF/1D+f+WoJ5aijQZb9Jya2Elql
         buFkXTkZWMWEGfJ+7ny7HgWzNfUwfOWpNdMvBP4TkTdzdngYfbvUlAcVRqNscG0RNmkZ
         UO9LhGYj6y1pBuHUEV7kkP1fWh8jvvRHfnH9f0ccNaALI7yC8m6byXKBAVGSa6EoUfpQ
         tR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182511; x=1779787311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoHvwM4p61ukSgPZjfDBcRJdrzaBcrrvLVu02xCIKiI=;
        b=GnhfEA4+utZzoQZD82WDBeFvzAs1IMwiWZ7Pls5mEh5U0DgaFexTb87EEJBy0mWgqu
         qLTAGojFVfM67U7PR0rjPbF1bK55bMGBnJmufV/sFqPKqAEZVCDa6J/x8GHD3wP7zTS9
         v61BVQZkXNGZurJj9JBg7Z5ETMKADlz6RoL46YoDM3neNcnbRE8UalENWN/sDl2eejOk
         zsdLGZipUUU15L83gqY+PRYHUUzrPXzlI5duNHYJ5fksjXluoJUYPz13ThZxebeaX9NW
         ab4jPH5pgjZAB/8NMZzqKv/+Fj/4jRuJdlmqgVuhd7Ugde1m2TSbXJ6vZCnNmHh/Ri/6
         ihaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QQx9J1V/uBtCX4IYExkfFG3qC8h4JjRyXWjXbdZcEhh2UOSb5QxR8V+tIinEHmh+qKijCa4MiDd84@lists.infradead.org
X-Gm-Message-State: AOJu0Yzby0QusoE2ZhZD+a0TK6u5ISe35K96fpMKiT/iTP6MqdT4Aa3P
	39bX3yD6uws8lZR5kYY90DQPjGOWy4AFHfta4ckbR4SICLOjQHkl22UO
X-Gm-Gg: Acq92OG6cJcL3mLZWrGxEzz6CJt1FSifOf0CWwR/Wiw9mFlgliqnm2DnPkffjCwGoV8
	MQGDrNl9Nn8picaOxqbh0+2lvpX/bA6BpLousUPGm2+NZr57qb5GdlAkWNHMhEVKOgPcrusdp8z
	IbjWruOAFoBQLpqt2DmfDnd/mdRb5Xjm7eNsnhKMMaQvJHyNJ0Yaq6gibauTZBeJ+YNXR/vRiXJ
	p1da+xSPyFsFxD2ncVwKx/ddFDSqYJsPAce/upOp7ls1+OqQY5WfJGHsY4qIZZ2mbBrsge+j+yg
	DO1JIvXSlQVWqGSYWjDO+whdPIloKq9A5czhBqA9PBW0R29duC94syvFwdPAH9cWPnj36Kg5ngi
	nTQm0ysMqCbNATMr9aS3FnRMxx4mROQ171CkoffCgWoVe6jmp23VSERayZOqC+RLIWyn6VyRWN/
	W9CyJlxXkr31BryIR9IYxw5dLY8hGvQj9Qh4JQCMsY/vFIVrioarX7GUm+8tzxxTg4hXQ9hkv6N
	ME=
X-Received: by 2002:a05:600c:4f13:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48fe6328bb7mr321111245e9.21.1779182510799;
        Tue, 19 May 2026 02:21:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2a23dsm102576065e9.5.2026.05.19.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:21:50 -0700 (PDT)
Date: Tue, 19 May 2026 10:21:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Nitesh
 Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Anuj
 Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
Message-ID: <20260519102148.21d42afc@pumpkin>
In-Reply-To: <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
	<646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
	<20260513081929.GD5477@lst.de>
	<24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_022152_897359_561CEC22 
X-CRM114-Status: GOOD (  17.52  )
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

On Mon, 18 May 2026 11:29:54 +0100
Pavel Begunkov <asml.silence@gmail.com> wrote:

> On 5/13/26 09:19, Christoph Hellwig wrote:
> >> +	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
> >> +		bio->bi_io_vec = bio_src->bi_io_vec;
> >> +	} else {
> >> +		bio->dmabuf_map = bio_src->dmabuf_map;
> >> +		bio_set_flag(bio, BIO_DMABUF_MAP);
> >> +	}  
> > 
> > This is backwards, please avoid pointless negations:  
> 
> I can flip it, but compilers tend to prefer the true branch. E.g. this
> 
> if (cond) A; else B;
> C;
> 
> can get compiled into:
> 
> jmpcc cond B
> A: ...
> C:
> return;
> B: ...
> jmp C;

I'm pretty sure gcc completely ignores the order.
Some very old compilers didn't - to the extreme of generating a short
conditional branch around a long unconditional branch to get past a
large 'true' code block.

likely() and unlikely() can change things, they are definitely useful
comments to a human (or Human) reader.

I'm not sure you can rely on the branch predictor to do anything sensible
outside of a loop.

-- David

