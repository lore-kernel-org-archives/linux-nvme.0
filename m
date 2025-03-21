Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74152C36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YzesUfd46zeebs0CrPG+xIoJVH8zLtMaJo8L9ii+mr0=; b=akh3ng5aIElxg9CD75WiM+NKtD
	os91eBV+TXXa7ZocX9sD5kwQhms4xnJZAQ2WVkHydBjoCZqDt3kew0KDczdXYhQriPStkDLKXf/E2
	e0UNjg09lbar3g7ECD9AemPmQnPX5vOzpoNMdkqzJaU5s/SEOVP/V95P5pFvAEDcvRuhwrBxmBoet
	pLUJEphnqAPhFV/DQqH9SYO7LGb5uBN4/RbPOk4vb2cuiDoQ0iIVC7gdAcfKrBC1Pc0xb0dbuRh0q
	DwEbjexJzfjsbhY1k2r9kl9aWa9S8OaPsiq6pGmIZJFtxB0AByzn94ojcodQDoTNY9WxhhIol44Kv
	soamDdAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tviRD-0000000G61S-3ehB;
	Fri, 21 Mar 2025 19:53:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tviRD-0000000G61B-0Dfr
	for linux-nvme@bombadil.infradead.org;
	Fri, 21 Mar 2025 19:53:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YzesUfd46zeebs0CrPG+xIoJVH8zLtMaJo8L9ii+mr0=; b=NFRNdq5t4lQtIuPCxbYvcmAOdM
	WEKMBuUqKfh/eQ8p1IydSX7YGj+dYFihJraYqQfgERnbZ+C0b9CapwrcNxlbHTpjpwVu0Yd5gZBNB
	C74CvTYSXf5aB6rbIPaBBR0NoTu58+UlADB/1Tv5ZomMoF8/bIQgLz+n43ZAJei4htjepGmYyeUvX
	QDmDuCXwBp4DIGzN8LogxZ7t2FmqmNQfQc7W9Cq50rHM/17Cv22xnR2p9BxexzF2kpb5zebT+Yr1j
	8Yqnf1uQ9UnMdtxQOpmHU5/+NiAs4a9T7CSfeyCAY2NNcycWxdjBHBkf5s5MLPJ9LBFQvTx8rIT7/
	yAo2n2MQ==;
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tviR9-00000004WYx-3LGl
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 19:53:49 +0000
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3d571ac3d7eso7156165ab.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742586824; x=1743191624; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzesUfd46zeebs0CrPG+xIoJVH8zLtMaJo8L9ii+mr0=;
        b=0+A1CEW0Y0Qz17oHGIMLrNzOsoGLOfwDmE1ZW+xn0ajDOHje99PkB+uqWh8YjyHUuz
         pZNO1hW178ijk+g1y50ngDe2Vvr4QpCRZpgZcOSGRIIG8DgjfHmUU7GQZtum0iKzFzEb
         wxuwv6ThDg2VJpgprYOHu4JMpMcyN2gcAFbYKl6Bs+UZbOewGrMzX2iUT0JSiHarHQ/U
         ba+hqA7GB8fBzjVGYZirwC4/XXj9fLsD9z5A96gDCCTVldxZbMYncgIoZ4KA0mEcROGx
         wAViQwPbem2sZr1AOZcI7RAxcUrd+kfz2ppOKuvLmFhDD6+n++m9O9SUO9UcN1BDTWqM
         alJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586824; x=1743191624;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzesUfd46zeebs0CrPG+xIoJVH8zLtMaJo8L9ii+mr0=;
        b=J+sMzab74NjvY+6I60LrE5GleYxCffNmgA9KXEn2AAyymWbQBe5OBIz9BrvsyIUI1o
         NfiKXKAPasdsfkYBBmEszN7pQvdWZWW0G8e+LgY6dmDufjpFgRDLR490l2X9YlItY/jG
         KsWzzNP/QGKZeEuTey1Cn940MhETlRlBXJwAgViFa1WnFNnAlh682rWXHesHHTSpNPML
         vmGzf7dGg+kEjiry8qZem5TiC3s/V6pNN1l6ZQeaPsmdE4bL8punrwJ+1bCxkrIXXALw
         QCX4kxhG/39IHtGRBLalxhZL/hRfS/x5u3wiuYGz5EtzABqqChlghG038a6XpDByrql4
         vYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEXH/7g4Ti1lih8QU6IogxZmnaHSoYj4AWvNcBU/hxcbzHYpHDofcbdt9UPqHtE6lnzHZec4LQuwv/@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/ylACQH0mwfBts4+kjRfnpe9AhW0r57BTbn+arJ9JSzP4dUdj
	20N7SiK+J0Rb0VBSH9YXpvbheAQ3T/9WV12XuHxEcY3BNY5oncYeh0HO8TabmwE=
X-Gm-Gg: ASbGnctw+JSFa23smhMDWljQ4VauKR7K4IteHk6VU1b6egwqlD7Ba0sfTinxSmbaxnb
	fsb//fdjfh/nn1Gm3vwmdv7WQktoLGKAGaMOcrdCtbtuCRq4g9HIi/+y2FmOLv7OMNE9RzKuxz2
	l1QOdaOiAwudmLClogoGxAyUP/OELGLOFvCDT0hTDmytByUI2H9wB8Bc8SOTzNmX5kamrF10o4I
	+JaJFM+/z5bws9ZkSomCBBO5tEzVOZD64iuDbUVQ3AFK+ynJEZ7g5DDaswd8c5HbHH265MVjM8p
	ceyirdYr8rpMzLvdevWOJcOuLr+Y7brH96an
X-Google-Smtp-Source: AGHT+IGn7T9SD5ve8iBciVQ/OCx5fdDy3xWn9IiJSqNMPE9sGxY4HUf5wukQHEc1lEXa/fwCOdPLkg==
X-Received: by 2002:a05:6e02:3112:b0:3d5:894b:dfc7 with SMTP id e9e14a558f8ab-3d59616b1c9mr51603165ab.16.1742586824296;
        Fri, 21 Mar 2025 12:53:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d59607e77dsm5694405ab.16.2025.03.21.12.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:53:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20250321184819.3847386-1-csander@purestorage.com>
References: <20250321184819.3847386-1-csander@purestorage.com>
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going
 async
Message-Id: <174258682264.742943.2572990287219952668.b4-ty@kernel.dk>
Date: Fri, 21 Mar 2025 13:53:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_195348_043602_BECA8E41 
X-CRM114-Status: GOOD (  14.96  )
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


On Fri, 21 Mar 2025 12:48:16 -0600, Caleb Sander Mateos wrote:
> To use ublk zero copy, an application submits a sequence of io_uring
> operations:
> (1) Register a ublk request's buffer into the fixed buffer table
> (2) Use the fixed buffer in some I/O operation
> (3) Unregister the buffer from the fixed buffer table
> 
> The ordering of these operations is critical; if the fixed buffer lookup
> occurs before the register or after the unregister operation, the I/O
> will fail with EFAULT or even corrupt a different ublk request's buffer.
> It is possible to guarantee the correct order by linking the operations,
> but that adds overhead and doesn't allow multiple I/O operations to
> execute in parallel using the same ublk request's buffer. Ideally, the
> application could just submit the register, I/O, and unregister SQEs in
> the desired order without links and io_uring would ensure the ordering.
> This mostly works, leveraging the fact that each io_uring SQE is prepped
> and issued non-blocking in order (barring link, drain, and force-async
> flags). But it requires the fixed buffer lookup to occur during the
> initial non-blocking issue.
> 
> [...]

Applied, thanks!

[1/3] io_uring/net: only import send_zc buffer once
      commit: 8e3100fcc5cbba03518b8b5c059624aba5c29d50
[2/3] io_uring/net: import send_zc fixed buffer before going async
      commit: 15f4c96bec5d0791904ee68c0f83ba18cab7466d
[3/3] io_uring/uring_cmd: import fixed buffer before going async
      commit: 70085217bec1eb8bbd19e661da9f1734ed8d35ca

Best regards,
-- 
Jens Axboe




