Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CF3D5C0C0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 03:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yjG2lX7n7wOSZfD8CTEfqlnriLEqiqwwz+HBAZVFE5Q=; b=MH4galHIB3xs0kolnD61YoOKJn
	tP/IcGnKY8TJlnoQd6UaKa+mHB6Ra3nwbNe5ofWueIbLnrGFNVeOlk3ZnrgxaWgYX+uAJvIHxSzoM
	8u+x8g23tUsSzqvN3i0zy/raGAMPw3wozXCRgQ8yftMCMOFJ1ffLMjr6UT/MelN4GHJKMGuMDCJ8N
	mfVbHmop8/GIYKR4mZg2BtxWC2UgcXhlZNZdeChjJMCiYM9DaEsl431Ai312kOmbCbFlHMdQYnySz
	qOEr86AzGtqfSgIbkr72FIKgi4ScMKOYI0AcJ5AIrZTWSLlpGjrz0h5eYy45fnKsrW11ie0YRExkW
	ez6jOyUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLTl-00000004bxF-0bor;
	Tue, 16 Dec 2025 03:12:01 +0000
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLTh-00000004bwp-0Hkj
	for linux-nvme@lists.infradead.org;
	Tue, 16 Dec 2025 03:11:59 +0000
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-5dfa9c01c54so2794084137.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Dec 2025 19:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765854715; x=1766459515; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjG2lX7n7wOSZfD8CTEfqlnriLEqiqwwz+HBAZVFE5Q=;
        b=HhfEDeOFiI5N1wGnwbYh/lrVjeuHaySRVu3wnL9ZJnrq7NlhYyqBObHtr9jOvhrbkr
         6d3E9gXucNdYua9wCgLQ4hbrEvJe2ve9bVliaCMWpOxOzZoiGipEAQ4myC3VQBEzGpKK
         coiZ0PNTmFQHKorfczqfzO2weILGHb+6KIBe6iTEt0eV8fKem91BZUmAyk1QCoTHFa1+
         84mZJJpcP1Nhofb8dd8xlsqUWs9/rB4nhMD1HIyj6Gt7klcNVfNbfxBi3yzqsJIEZTr9
         TESkzlyXxnwc+MzknBAbtaiu4DlE322q9VJEexx74571eGPOaYdRQrY0oyKS3bGivygg
         6ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765854716; x=1766459516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yjG2lX7n7wOSZfD8CTEfqlnriLEqiqwwz+HBAZVFE5Q=;
        b=mXNkBti+c/aEUJ3v0FRS/+oi7x1GAX2zMII1H3KNe2ILcKeM1DndLhWLNJ7tyxPt1Y
         ky6KUdl+TUs5bUyJTtW4Q2JTcQCkP4O4v5s3WXmNd6FFD59So0bT9eceBfBtACWZmigP
         kOURk4RbW0wsFx6j3oEI1fI0UOzecAUZUxs7BYiB+330lGi0NWyzYlu2diDqVkerttbc
         DCSHTXSgEgUpCndvqoS/NyjoXXzJ9XeDlgv5IDlcULqur6XkKTElzBZ4XTwWqNenXJ0S
         VnGF901A3ReL7PQWoQWvsuihnzHR1K8dmqGV+oTRul48jxttDUeSBKodrfypRcNF5bnQ
         FA9w==
X-Forwarded-Encrypted: i=1; AJvYcCVmIz9EkcOfSEdiyS9ww1XjQ/Q9/twXXZ0wbqMiIE+Xp2IFdD+6qFn0QhI7+cWWBixK4vpLR81zKQia@lists.infradead.org
X-Gm-Message-State: AOJu0YxDPR3VQvu9WS2VJEz/y4O1YVimkyqg8413bXGN3o5h7Im9u+z/
	UUVmL+uk5KQVa4r0Po09AN9PcRgZbsV3kkjnbwZkTNSXjZjTziuXEDHthG78JKYSkMesA9zWPqm
	YJpbw5x8yZzMlF9cDVa2+nvRwf2/IT2YVg51d1TO9qw==
X-Gm-Gg: AY/fxX6Q2OdvWq4k0kvYJr26hXtYHnHT2/c+v5CeLxCi1o2wedOtLFgz+wxtFUqAPmC
	gCgwkKzcJl5Fi/LRGMWNwIRVdyPGphON9HnNsIDfUcsNTfAE6yFHnbcJAmRQJLcrM7WZavEqcFb
	N4KZkD43+RQY97xbfqOBOfROraoYim2Bghh9EzCwGSKsxhXQRUhrziEuUfK59/aZM9XhsmX7dbu
	bZz6VMWG8VkEQ1SQWwH6zfNZPVNpAmjwRr2U6pOwx+g57Gsg9LxfOnU2/QeSiL7ANCAZug=
X-Google-Smtp-Source: AGHT+IEiWXPvoqHbZ/a5BNEZi8tWeKrWGWn5ltal3AQZ2rEKT3QMFjqqU7xw/OEuBhmZqyDroRNoJrdVMItRo4N12QM=
X-Received: by 2002:a05:6102:330a:b0:5db:cf38:f506 with SMTP id
 ada2fe7eead31-5e8277d5685mr4651508137.23.1765854715657; Mon, 15 Dec 2025
 19:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-5-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-5-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 15 Dec 2025 19:11:43 -0800
X-Gm-Features: AQt7F2rXpdFj9mHVe4mlG63Z53WvOvhHvnqbczcj0jpc1JD-mkd5fGvcrE0acdQ
Message-ID: <CAPpK+O09NHye50m4prAGOJeKUBabAqsFJLikbPi7LOSHi5o1EQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/14] nvmet: Implement CCR logpage
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_191157_113413_A46121F4 
X-CRM114-Status: UNSURE (   6.85  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> Reset) log page contains an entry for each CCR request submitted to
> source controller. Implement CCR logpage for nvme linux target.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

