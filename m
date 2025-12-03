Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405E1D12D6D
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 14:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RqMdYJKNtpqnFCa+gHYL+8XS8vWRB2K6+SiBds0lbTw=; b=gGxyo9KHQn/4sfERM56mashmIg
	gk9LHTe8aLRKmUT3yGAmWqacFGysyMr5WgPKZN9kygOgYWZohpYjy7g/vxtoVxmNJfTv+kjkbvT7f
	s9rTfPjSXHpUHhgrkH5Asy3mndyCzU8v0dPVsrbR6/A5uRi0iMzkwpfBG0+WVMiPvM+cX9cSYiloG
	e1XZfzXqMliwk0f/8Ur/HXC/QA0ePesreOjrgpbtTco/P3Q6ftNDaf89dnBVwY3ttfp9q6jvQJQrM
	GB6B6G2xucHxr/wfAopNaJHfXXUjdc2+0EE1z8kTjwU4/KMIglaLvlYfKwVDLZ2UzsNR6dEV3w4MN
	oZ2TVttA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQoEC-00000006fTO-2eS4;
	Wed, 03 Dec 2025 14:53:12 +0000
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQoE9-00000006fSq-46XD
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 14:53:11 +0000
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-4531eb3964eso1497368b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 Dec 2025 06:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764773589; x=1765378389; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqMdYJKNtpqnFCa+gHYL+8XS8vWRB2K6+SiBds0lbTw=;
        b=iHeCSXumk4YhPS5mPWj9KUh6sDpRkt3daKqDJ1MJ9EysxnsnaiLGiT2Kt0lPSrHIA4
         lNGFP3ZNED/aGclFG+1vG7RR3ZqVfWvqHP0/ZrlPu6aYTWTnh+omD19m/0reIFKXHqWH
         Vq4YnWbAuxziZ6AIlH8ijEYE66nXN+y6LIwtqR/rmp3NHeUGtO8T298WchXmIwP4n/3I
         +bbbMaWKmq6SA/I5evgj04j/iaQNGn+r+1GlHdiupe8SvcefxwtUVZbqOHv3RFv/6Po5
         Kh0zQCb+1fnE3rYCWuG4V9xRQLf8W8+JxQf1wAiX9xE1KFufA8Gm3dyJpAnV3o9GUbJu
         qHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773589; x=1765378389;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RqMdYJKNtpqnFCa+gHYL+8XS8vWRB2K6+SiBds0lbTw=;
        b=A98dFOIuGg+E0OMKREm37yKzFbYfEUkAMrzkc5XKJY3nzTtCaKz+i7YRuh15P9JBuZ
         o+E7wykMDxmhUUAP98ycsfGYGaqTkYEC6N8mtBV4pb+qIiE07jbgq9j1vJw+KreEl2Fw
         n3uaLZH2PGtk/QOESTwXgEPbXJ/EwnlNMs/e4ARFnMLmKzW2L6mblLdTRN81pTRocCPu
         Qc4rzXR6+QO+6qHH0j+HkIkM4vIsXUMnBJMaqQbaTUbNi1nNE+Txr9HLOtE+vlEbCMtf
         xUn8U92Q7dZFNCktt3mZ88XHozkknm+gsZfZUqewLiWQ9pcDdlecnCZrnGcuLbffR2jK
         3Epw==
X-Forwarded-Encrypted: i=1; AJvYcCVkXTDBQHQIs5ZUBFHcL1P/Vt3XpZM14LOh77mPlv16I5evm2L5bNKqzBJepVoizSaCtMCMhkxLQQ+t@lists.infradead.org
X-Gm-Message-State: AOJu0YzaBGNZXceSY4f1Se9Kt7OyOdBI8j+qkwvdA97SWxOx7JIwbbpf
	no5HvSeFnT5OgXztOeyk+f04ptYOqyBJV9zXAJp/in26/8WP70EPsOF+Jq4N0Y6Egq0=
X-Gm-Gg: ASbGnct9o+7H3uSCp2fDYme/wk9/ptAjQMDREKFJ+iorRu1yWh3byCG14YbLsTxWvsz
	GW7s+bGcj3XqEJHJI/oesCmEBeodb2yT855hZs4mThaj7six0LRUMY/b9ooPzQukprSpqNUC30e
	/idpibc/asMZwvtO9sbWTWh7sCn4oJJYaRADL7pwLj8Pjn8W8VMBkBU5I5NEAOwt3l4/zvcdoUx
	xgR0+nxdDNMeB6AqJQsrj5OjbUZPe9MTEFe1qIn6gpqZNBQRzu0rq1MeJ28JJjzhA+IBwYVYTWw
	Y+m3eOWA+hqcxg/zW4sMnX2p/88688GbE8nQEK2+i0NUmYW4wNYUwqytsz2JsigQYkYUKPPMlnN
	upbh9z25PNOAGtZsAv1yJaWb2PP93q/jQQuh4wG+d6LlU3qxAlVxI0BM61VnBoJ6jgv2+IX55cI
	mfgHABSZiH1dzk
X-Google-Smtp-Source: AGHT+IFGSMja15l26XwVOaOiK4nD4iWWKzjJ/wcAt7kaI/lXAw89EczEW3iLJQf1wj0KMvfoXau6rw==
X-Received: by 2002:a05:6808:c2ca:b0:44d:aa05:ce74 with SMTP id 5614622812f47-4536e3f0af0mr1267241b6e.19.1764773589022;
        Wed, 03 Dec 2025 06:53:09 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc55bfsm5953139eaf.9.2025.12.03.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 06:53:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Mike Christie <michael.christie@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-nvme@lists.infradead.org
In-Reply-To: <20251201214329.933945-1-stefanha@redhat.com>
References: <20251201214329.933945-1-stefanha@redhat.com>
Subject: Re: [PATCH v3 0/4] block: add IOC_PR_READ_KEYS and
 IOC_PR_READ_RESERVATION ioctls
Message-Id: <176477358760.834078.18043119459557804028.b4-ty@kernel.dk>
Date: Wed, 03 Dec 2025 07:53:07 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251203_065310_023244_02A0DCAA 
X-CRM114-Status: UNSURE (   8.66  )
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


On Mon, 01 Dec 2025 16:43:25 -0500, Stefan Hajnoczi wrote:
> v3:
> - Use checked_mul_overflow(), struct_size(), etc to avoid duplicating size calculations [Christoph]
> - Don't use __free() from cleanup.h [Christoph, Krzysztof]
> - Drop one-time use num_copy_keys local variable [Christoph]
> - Rename inout local variable to read_keys [Christoph]
> 
> v2:
> - Fix num_keys validation in patches 1-3 [Hannes]
> - Declare local variables at beginning of scope [Hannes]
> 
> [...]

Applied, thanks!

[1/4] scsi: sd: reject invalid pr_read_keys() num_keys values
      commit: d832d9366b072e76b94344c0532b7067536b3ef9
[2/4] nvme: reject invalid pr_read_keys() num_keys values
      commit: d7d07c1995913f23fe6140fd8d7323c8b923680a
[3/4] block: add IOC_PR_READ_KEYS ioctl
      commit: 51f31451b34d1c5d8f16d1dc6ef481d0b49441ee
[4/4] block: add IOC_PR_READ_RESERVATION ioctl
      commit: e78d75d1fa447ce2b66799f1ccdcee61a4951a79

Best regards,
-- 
Jens Axboe




