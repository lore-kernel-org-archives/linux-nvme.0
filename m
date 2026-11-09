Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929EC606A326
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Pqbo6roY;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBj7tDUR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7f0x77VxeyFJGw1qnk2bYiIJYFod8edED4Dubqc7evo=; b=Pqbo6roYur3/9q
	cknOzFNSY93l6jEgZnEeb2DXJbLjeVOojT4UMtvkwytRkq29rXUlQtgQjUR5OhvrEi9go/TP1neE9
	4hCJ0QmOyzRIXHBgkZAlOgXQxvSc/MIjs+57tETvQ2vBc/Q38kv15bZ6ItphtcgHYmtfdfwS8xR1P
	fWSsp3BJUtOH/v38chvVy6Fb4gSyLeOkCE45PGVD7Y/V7NBHG4r8nHImRcwGgwo/OQlWXH3B6C9tU
	u7RzKeepM4kxxqslxWpnZPwUPrKTEBMhUuEcpms+hzNUFUSBAicaYuM6jYKI2w87RkyxBAVG6Bkya
	cBnN8/IPtNYK1AjKPTPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQV4I-00000001YGZ-1jSj;
	Mon, 09 Nov 2026 19:30:14 +0000
Received: from mail-yx2-x05.google.com ([2607:f8b0:4864:41::5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQV49-00000001YCu-2aLZ
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 19:30:13 +0000
Received: by mail-yx2-x05.google.com with SMTP id 956f58d0204a3-67a3d39e403so953718d50.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 11:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794252603; x=1794857403; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7f0x77VxeyFJGw1qnk2bYiIJYFod8edED4Dubqc7evo=;
        b=yBj7tDURBfru38RanqqYWJA8OMg4jLtX2nz1dB3QujwAHH9vUcwkXiwaVwKHgLQDLR
         cpUby+sTywAmIgKO3yfKqyzai6Mh+q/N4B18Yz4zIE0zPEW2IetqUB3RAxbVIrcebott
         uVN8eiha1IjnVhrHFVpTneRuLh0Ft5EbCXF4m7uvXQsDtuyqMHVcoXzFlJSt0dDgV+tx
         0K2pL9o3zW78/yU8+vx9Bi8qOyan3kmMrnzq2ql7SXnj13Sxferi+BAvblRYS6pcZaLJ
         dUqr1Aw/MavsSs4w03cIejhbxL69EaYL2A4NG1LFfqUp0/5giGiRAV6aNW8Wf7Rbc+yc
         FExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794252603; x=1794857403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7f0x77VxeyFJGw1qnk2bYiIJYFod8edED4Dubqc7evo=;
        b=lr8ghUcwYBNjMhI5cHOWV1GjQm8PqvTwU80xDw0elUwG9b3VEdN+Z3sC6tFvMJ9Sib
         FTznFLcTiPtHPv2VPN5yx6Bo59/5YCuJmyRb1/07G4/51fuaasqNnbY8HS0rEpD9exUn
         DNAVv0AEq8RY9ggLEgFgNDqR0iJkgLpc5V7zgOc8fIRwnKcovrV9T84LuXC20QCPlBY7
         g3Aauc6a7FfPM4xQIcXXFDdAhhZrR+eE1UbHvwZ0arS4SCfCKrrDee1msqiWNob2ogQL
         7hfzkT6o1FlHZoS//qCF9b9k+TXpds8uJargFY07lAs8XVkYXIF4Fk5ylkbDD1IphYMc
         FEXw==
X-Gm-Message-State: APuU4Z+K1Jc3Cqzabt5rPufJDoh71vdkFpQNz2ZZg6q096A7YmntXMKV
	I7355Qz3ul4iy32hVLxN+KUZ27pN64+EaLZBrVSkKas16QXIAlf2ysOnI32zN2RN4CI=
X-Gm-Gg: AYBFou1iciI2LGwFP2qTJuWvusA5SFI91v22vcOpKZJv3mdnZWzP4f7sKkNIptmCseP
	o1LSM2z1tY4aWANhegFgbKtyr9O0B6KpuEytzD0FvXKwfWHQ+iSzNSGOCrLHV66XXHbhLuJHjHO
	nOdytsWfBNXpqB/TdsDcwIh7UW8nPxZDBRTJtKC1Rgbal+I/yIpmCmh/N/xivWZH+7xpnaiolKe
	2XhCqBjConh0lJDZ1eCpg9Syhh2EBVxzwDdoSaamr1/MB3VltzTwfWJv4DwlL0RjogLbNx2Irvl
	9/DACK7BhV6aNg57PazmTu2FsNhCwXxUrFkLuilqCWUNTJTAVbADhr1dSo5F6IuYUIfGLD9558o
	EsIKlRrx5UmmLkgBFiADO5IPjGWGoKwff1vutu8Zoq8Njo+ZBLKms8w6R8KxvVTmSxbuRFLGv74
	/dk6tZc2rl6zClu0MA/10vkHoy1QNg044Usbde4mMlaDexgpVvSN9iymb6dO/sidAhZ0g8RFcSH
	BdiN/k1qhF/J+Qno0m4l/n885HC8+0aGj/qTsXI0sb7pvmA28ztiMsCVuLJYMh67EZd3H+sxcn4
	jbr5S7b3oZpJPL6tKhp49nb3keR5IBq8Ss4=
X-Received: by 2002:a05:690e:438d:b0:67b:e862:e228 with SMTP id 956f58d0204a3-67c568d26fbmr214564d50.86.1794252603311;
        Mon, 09 Nov 2026 11:30:03 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c58a201ddsm39422d50.21.2026.11.09.11.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 11:30:02 -0800 (PST)
Message-ID: <ee61d52b-e8bb-4504-a893-f9dc4036d615@gmail.com>
Date: Mon, 9 Nov 2026 14:30:01 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: move the TLS record read loop into a helper
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com>
 <20261109-nvme-tcp-live-ctrlrec-v1-1-47ba61670e65@gmail.com>
 <sashiko-outbox-205465@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-205465@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_113005_696425_B3ED5CB4 
X-CRM114-Status: GOOD (  11.89  )
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/26 14:11, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> This problem wasn't introduced by this patch, but can passing the
unaligned
> char cbuf[] array as msg_control [1] cause unaligned struct cmsghdr
> accesses?

The report is correct. The char cbuf[CMSG_LEN(sizeof(char))] pattern
gives the buffer 1-byte alignment, and put_cmsg() and
tls_get_record_type() access it as a struct cmsghdr. The pattern exists
since commit 2837966ab2a8 ("nvme-tcp: control message handling for
recvmsg()"), and this series copies it into the two new receive paths.

v2 will add a first patch that declares the host buffers as a union
with struct cmsghdr, as sunrpc does in svcsock.c and xprtsock.c. The
new code in this series will use the same declaration. I will wait for
review of v1 before I post v2.

nvmet-tcp uses the same pattern in four places. I will fix it in a
separate patch.

Martin

