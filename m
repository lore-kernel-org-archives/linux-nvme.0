Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE047C369AB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QENNCrjCWntef3deRbb4YDB7wTorwvsVGVDTK+xRntE=; b=Xvo2qa+RA+b3Y6jTsJqsnnRa31
	cI5R+rmhKBGayrTdxL0tKvtAMaS8PX53vRfcl7FH4bL6QPwi1Nih2pA/dgi+9mB0eiAj6Pk89mlbw
	+R70GeSLtMhS109emXvsqbd3Mk1OEjlxM+Wtyrbyluf6Td/X3iSzAq2V6rO7E8wjLMOJrzeKjtGra
	hVcQhv96B//f6ari035QgGiecpOUSVBrMyx80CdxsOh15c8r2wKEfd5+G38t6NMqaMyVDOm8PMDv4
	kj3OTk4ZZJYuWA+ej02YJNBONpMr02i5tVUtjDHh8bDPdcuI996pV3zxxcgFoMGHblPJJA+h5Wpn5
	Ai33I3xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6sVa-00000004VIy-15kv;
	Mon, 21 Apr 2025 14:52:30 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6sTf-00000004UxM-2TnM
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 14:50:32 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2ff67f44fcaso968824a91.3
        for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745247031; x=1745851831; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QENNCrjCWntef3deRbb4YDB7wTorwvsVGVDTK+xRntE=;
        b=UfbJlCFoWuydskfTRPaeNTEsS3eoRH7DiX3vgQExN32dcHMAko6QUWVlM4HZvT6F14
         MuZVDRpAj2n913d2ztbR9B6SMP5fMQ8f3oRC/UmmLAAfJDz8wZCS7B9RZSxQtqSpd63H
         dCWKVzkAjo7krL7NMnG1UgvaXAWlbGnd9HjbeF/CL+D1aDwE5CxsBW5mxbaSt2nlSpql
         d7JqlGyi/CKL7oU416RKi8Y3jbbg3cuV0/2U4oQ8yIPLNkA3mr1mT4kUoCv1xvOjr7SP
         226Zx3yFdSrd1Vwjlk/Rg+oklimhwfTR3IkMmVl1MOAqC8KNwPSfWow9K7NkmgtWUPl1
         HBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745247031; x=1745851831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QENNCrjCWntef3deRbb4YDB7wTorwvsVGVDTK+xRntE=;
        b=C96i+M1HQrdHaGUKHZZknhYWScF9t4uypuDfBGVIJH0H4E14k+KhF6tF8gFVOtRGJO
         VQzoeuDmzt/mYfz9zX8MQHwnlY38vRBA+SBT69Q4dI/Le8gM15/1+zwC+PLrccCr6uZb
         JgS25V+yhhwbqA2THyCK0veytRhrJ7ljkT399EzAiK0btqCuh/ntGIF7nP1Wd6yPoZ94
         Tom3NRh9TNbEZgDfe7TC4EqFDNLSLvh5OPDiXvRWAaJ6lh5bN4Y+DiA8xIGnw1ProCo7
         PmCNxB01JmeNZKg9A0GzqGoxgdSTDOloV3mWFsshJHwjL/2OTDyl0/meCAordIrG6Kbx
         TbAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeK/Y83gotZiPi5dyhGFFcgBRffkRBqteF7M583hubUKwgi9GKJYoOyoNs2aLJesFrJuoeN+kH86mK@lists.infradead.org
X-Gm-Message-State: AOJu0Yyxzr8NwWGY9DCkDQtxtOoIrQPBwztfHWdz9g6SbDJtaztNQqFu
	voH8GGyLT6F28SHhzOYCYiJaBwov7TJiuTuR1XjKjvIfH6pH0t69ZufNl1ryYz4xBWRshCwukNl
	gjVH7/E4nY1jgayzyeFn6me66ASlPC52xYwHqPQ==
X-Gm-Gg: ASbGnctgaVSQsnsOggUMC0w3vLO+EkxNEaFiVPA9anUKWemRpQGOgkgiX0CHqJ9xoW6
	30QIXXVf2DOW/j9B2qoY+Rf/iGEeg4xOkNCHfS5bXVDSIkLVWjEfi/gqgRrmgwU65Hcm7o7kzpg
	/DPB447BMs1pO4FqK71pyBjQ==
X-Google-Smtp-Source: AGHT+IHGyIn8Ggts2Cc0qvPGykqovnuCA00psLfWjJbSCUbMZNw6jer7jEaCr1NDs6Jo7lxB27P4MZf4Q205Us9cxvc=
X-Received: by 2002:a17:90b:3b82:b0:2ff:6bcf:5411 with SMTP id
 98e67ed59e1d1-3087bb313f0mr6899291a91.1.1745247030715; Mon, 21 Apr 2025
 07:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20250420164653epcas5p10dba2c638655fd4b16c6553d5125a3a0@epcas5p1.samsung.com>
 <20250420164450.1144416-1-csander@purestorage.com> <ba40abc8-8b41-4e2c-a700-04e8e424bcc3@samsung.com>
In-Reply-To: <ba40abc8-8b41-4e2c-a700-04e8e424bcc3@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 21 Apr 2025 07:50:19 -0700
X-Gm-Features: ATxdqUF55Ax7ibERHwBXWAwdTqIHaIXovQcmFJZCKc-VxqIvQ5GCvoXYN6uIH88
Message-ID: <CADUfDZpDS6GUOhhM=je1hiKd-iAQLR6c6pWCyS-qTuutKNWzuw@mail.gmail.com>
Subject: Re: [PATCH] nvme/pci: make PRP list DMA pools per-NUMA-node
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_075031_675913_4F86BEFF 
X-CRM114-Status: GOOD (  10.77  )
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

On Mon, Apr 21, 2025 at 12:09=E2=80=AFAM Kanchan Joshi <joshi.k@samsung.com=
> wrote:
>
> On 4/20/2025 10:14 PM, Caleb Sander Mateos wrote:
> >   static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> >                         unsigned int hctx_idx)
>
> Missing this handling for admin queue.
>
> We may go to that case (i.e., admin command with data payload > 1
> segment) less often. But when we do, this code will give
> null-pointer-deference.

Good catch, will fix in v2. I'll also adopt your suggestion of
dynamically allocating the per-NUMA-node pool list.

Thanks,
Caleb

