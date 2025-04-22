Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AFBC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DHq00Jy8ArlG0uUG8qvA+p71m24QNxsUjm+9An1VpRY=; b=mH+oYiaC2GrnLY5BKRzsFdx7eJ
	ahy8r2p51lK17HwCZEl6Sy1RsitkFKbT6Wc6uGaCbVcund88Rdl4EMz7PuGbxCbj5wD/0kCpK3M+a
	mdNqdnGaE+eSnfPNeJ6s8f7JLtgdR+cWVNZRqkBH8zBvGXPu7Y0XxE8KtfkKZPypaxGPCklRjZmZX
	O9GBNNkTHzKthGHj1XDbfbIv8E/Vt5/dLZJIK0mdGGyfTcrxH2PfZFsdpHIQApWv/0AAGdDegWwaS
	F/+ANpjOcWq5DcMLPzR1UZKeUiYBkLmRLTsCdhhYOCL+Q08KP4kKfqipKOLUbuy2xRipyP0NSB5W8
	us/LLFBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Lja-00000008f8D-2DIR;
	Tue, 22 Apr 2025 22:04:54 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7LjX-00000008f7p-07iv
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 22:04:52 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-30363975406so695048a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745359490; x=1745964290; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHq00Jy8ArlG0uUG8qvA+p71m24QNxsUjm+9An1VpRY=;
        b=OtIl12BP/Sull/JNSejq8GyKY7Z4D6t73Vqw6QC6fJAY7RhcE/ZaRIqX6rr5pIdzJC
         AUb5QCHz3bMsXFdUpM/t7gVd502N99S7rw6J5QZAKx6vYNXC3S8vHsw0nRMTROO/U04Q
         LN7mQ8rWaQbUItapGmIviRgWcT+LZTB6sFEukNS090IVFi3w8FjglzsX4lnhU22HgMhW
         YVc5kOwhW6ONjD5IBlAt1+qJuptam4VONWsyp7WZWSZoNRIaCrfxP4M6bemeoiNzH3TT
         x6y2vwE0Mip+jI6c/2cMtGWCdGd1HIHK4ZdTZ6UhKmuv7oW559sSBEWKwd+0o/RLKUHg
         HoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359490; x=1745964290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHq00Jy8ArlG0uUG8qvA+p71m24QNxsUjm+9An1VpRY=;
        b=vUEVJYIqgC9V14BRTVSwAPwPGFf96VOxXtUTnCyY2tXL5Ik6BX8MnW6NH7pPxe0Gmq
         Oyb2vjGL1+jyN7ikruuiS03O9SsuTcCjWuyh44UFQ8Ujnh7+dtJmUCPhfLUNHrEuJ5cq
         VtBfp8wl2JijC9/sFRdEoyOdmWuYkj8gVwMnKwW/2oQTsMG9XZw0Ioio9Rd8t4ZccdC1
         y44AofATPOj0hbpuysLU36EVCTDLyb8EDwvugmSC1syQk1Co3r8yrLQblfMuPLFQIUNS
         JDVb9oqEyyT6wKO5GvUdo4ZfCkQatiQpp8V43VKqJIIvdE1Ncg7Gxv5krWXzXw9D13a1
         LiIA==
X-Forwarded-Encrypted: i=1; AJvYcCVy8RpcgorhQP/jon+EPTseJbLPY+wCh1ZGNQoiogpqVub6oYTD2L2TgVv4cbm0CTPOUZfC7FeuqM+I@lists.infradead.org
X-Gm-Message-State: AOJu0YwC2aTLazp5wbWzZVRcHma8e2Vi56N4/3dQkOhlnFjOrvqi1zTh
	6BygMUP70p8MsscGTPV4mgNUkkqvEkEHEpRygia65jENqfqAdC7FAmU+EX4A331oBDg7fFJoh4o
	XuDWW8gF0hXRoJORKgrgiaM+0QPMIAv2pAP5Mmw==
X-Gm-Gg: ASbGncvc8VFinTNqWlWyQ8GUkRQP65n/yIbSHJ9cqtn63abv1LBAS2Ktg1ZrPWQg4wC
	7DAcYFI+H+pV+R/hNA3VBlM/K9g4mAUz7smp7D1+Uh/zuQIsI/rbZImtBnT+UO/R6FoLchU93eM
	P7ZspfevW3OEPP+vYvLL9n
X-Google-Smtp-Source: AGHT+IGxTPbKr9qKYKe1IBO2sOP3lYbwPMBHyRNRwoKnjkYWlMMKK1yxTaw37paLFCn3ldrutm1hXKT7IveI3tfJZGg=
X-Received: by 2002:a17:90a:e7ce:b0:306:e6ec:dc82 with SMTP id
 98e67ed59e1d1-3087bde2b2dmr8960212a91.6.1745359489559; Tue, 22 Apr 2025
 15:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250422161959.1958205-1-csander@purestorage.com> <aAfWUGAMTpwsHf2b@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <aAfWUGAMTpwsHf2b@kbusch-mbp.dhcp.thefacebook.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 22 Apr 2025 15:04:37 -0700
X-Gm-Features: ATxdqUGYBZdgRQ4qkjYHTy-PaoU7kaf1JKmQBOijRSNMhG9jko2qg-c3dICA2yk
Message-ID: <CADUfDZr5nq9fAvxSZJwUmuZKry6pHqLrucLtJLmV8cAvZ6O6eg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] nvme/pci: PRP list DMA pool partitioning
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_150451_214020_0E7E8C81 
X-CRM114-Status: GOOD (  13.24  )
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

On Tue, Apr 22, 2025 at 10:48=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Tue, Apr 22, 2025 at 10:19:57AM -0600, Caleb Sander Mateos wrote:
> > This reduces the _raw_spin_lock_irqsave overhead by about half, to
> > 1.2%.
>
> Could you try this atop your series? I hope to see if we can squeeze a
> little more out by keeping the spinlock and list links local to the node
> using them.

That does help save some CPU time in dma_pool_alloc too. It's down
from 0.87% of CPU time to 0.52% while doing 5% more IOPS. I'll include
your patch (with a few tweaks) in a v5 of this series. Hopefully
you're okay if I include your Signed-off-by.

Thanks,
Caleb

