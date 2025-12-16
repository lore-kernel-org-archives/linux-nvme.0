Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03609D5C0C3
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 03:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EY5oR+ij1L+0+TK/0EGNOHundo+MK6JMef4n6wrbZA8=; b=CGUvRlEmxbUKR/fOcMuR4YbFIO
	x2qxsnP/5aiMN7/k4ZixmT5OYf4+GSjcpR++NmNMnQeuOwRZj+sk9Opr9zXv97MuNybPEVVmlYRCJ
	MhGLFd8gj4XT2flxhTLhCNGzKpzCunGDOS0d2cJ97h/84tN8uGXe2jkArcqgc1HoW4fyF0ZhlBIp7
	YHJPDxabhjSXh4++slRi3qJbJ7+KlHsMnxH/9zMPOi+/ragpI+xf3tbrfymiln1P+fIemEO0Oquxz
	+dvzOOCOS6lKbTs2G9DWjyCGKpcW78jORlUZfcLNnJ5yVCOj/2rWAGSne65caIvAYWS8zbDJRSvWo
	xo27uQvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLJr-00000004bR3-07Vx;
	Tue, 16 Dec 2025 03:01:47 +0000
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLJo-00000004bQg-14zJ
	for linux-nvme@lists.infradead.org;
	Tue, 16 Dec 2025 03:01:45 +0000
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-55b26461e78so1042770e0c.3
        for <linux-nvme@lists.infradead.org>; Mon, 15 Dec 2025 19:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765854103; x=1766458903; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY5oR+ij1L+0+TK/0EGNOHundo+MK6JMef4n6wrbZA8=;
        b=YMJogslJ5WNCLczNFXkphTb76fCtZrzlS+dcpRSqS/ZoEFMklO9fMx9E00txphYcwI
         kbfUsBDYN3aXp2TEYdtxP2YFgcaTp+faetkT1LOcwEoZa3NlT4Zd4bnXwOtsWT3iR5Wx
         4nTfhlPG2S7u51T41FXPXmcJYqW4yhc0ZnUvOdXU9EaXH1O9ATFtTGx0FTSHdpEiZv/+
         4OCgx/84R2n+YQyZEBbY9BGfaZJEToQDEO6cZ6bxfSlLcdqL/IcfShyAh9xuRJWGxzF2
         iHyUFcIW8nKo/S0SpJMGpju6eGtX2rqaBNF8uZSjWSSNosN9KoUZ2Ej+oP/svxZrGUb9
         dbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765854103; x=1766458903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EY5oR+ij1L+0+TK/0EGNOHundo+MK6JMef4n6wrbZA8=;
        b=J7s6H7BidcVQlY/lo6qBQaffXbDQkrdY/OTCby+RpxPhSD9BlCdRQXZN4Cp9DVJeE2
         hk94nDMSKJuuCnQSYL+bn6wLze5mEMkdA2sztmZHbM/xS5kbFdWwBrvCnWV8NUNvauHn
         IBeqPx42XsDTAAZmZ22uWhmT2Fh1puAX/Snq1dwERo5gNDR8SmTTcCWdl67wc8SezPeO
         zgVd4+CeiBGN4mBZ2JnpdPVe5ilwjJRKXl4VMA3EUPlZ8ZcnUxQ9HAZCqiCbzE73OzFB
         +0AsNyADShnzr6iWTt86L8Y9GRujDF2RD3OWo5B3PjhhxFRYTgYYypnsLG5NZNpXBrzF
         ycMA==
X-Forwarded-Encrypted: i=1; AJvYcCWfg+k+ZbuJ/VVyHiXh3JzIB6vnmJnzClepFWn46FQt/iRjEV8sifnLt63LHjiwnPZHS8aVAj8w2yXD@lists.infradead.org
X-Gm-Message-State: AOJu0YzMPv5+ZBRL63kaOHbXwZcfmT8TlGZ/im/YeXJOZGWA+zfF9jfo
	T8+MFSCckVUBhNIRpBrp9OUAemXjlE4FMHLl7rGAbrJUQgJHc8KzAm7flyO0VwLb51sgpt6QENf
	kDaEfCNXgeSUMbbfBjkRVcMnyMz6yqZU5eUcUmuql+Q==
X-Gm-Gg: AY/fxX4bJsMxe5lRdAvUD+oifoO35R+jSGX1aTUhRXR1FTrFAyciloKgyPP302Ket3H
	hXrvqhIalTt7UvNZJwwi+MJZsbKSqGFvjRw7Zrz+nHW31R07svXtLGTX7OhI997cawLP9V3PKIH
	1LDfmpBkB/zMnebumneMMSbyiimMj9lExO6xUyWrvHw2y5CjJ6i87yLw72LGB3Feqn8NpLbZlRr
	1LEDHN//R77m6Jcc4wtxcbfAvxwgdgrfjG9W6uvd0RJNuiwc739qV2cYDhj0/OojG8WLZ4=
X-Google-Smtp-Source: AGHT+IHFSeVS1F35KqIJj6VKe0baO73wGRXSNwfr05M8YZX984fHrtzAdVlfAOMYVFhFSXAbmUH18o8w+GhkGHSpIwc=
X-Received: by 2002:a05:6122:2a13:b0:53c:6d68:1cce with SMTP id
 71dfb90a1353d-55fed64908fmr3604996e0c.16.1765854102565; Mon, 15 Dec 2025
 19:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-4-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-4-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 15 Dec 2025 19:01:30 -0800
X-Gm-Features: AQt7F2roCW60ML1mnigetB4Vm0xCpavQxmtBL1zPldYRyoa0n70Exub_GftV4wM
Message-ID: <CAPpK+O1iXmt-HeK=ftSrPJn5jXAB9GaEf0sMY4VT0Wj_DXfxJA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/14] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_190144_463061_7A52C151 
X-CRM114-Status: UNSURE (   8.18  )
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
> Reset) command is an nvme command the is issued to source controller by
> initiator to reset impacted controller. Implement CCR command for linux
> nvme target.
Remove extraneous "the is" in second line.

>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

