Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1153CD4851
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 00:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ClrtqZ8x9yt17eBnj412p27ytJWuSZtaoH0o74kNhP0=; b=hkPeD0Z7yrnH/jlVeykpOMZWpf
	ZVz00jws/EfTIL3OH75QZ2VTTGTSI4EL5M4yKZeWj9pmqQhIeMTXHLk4Au1GOIAj1E2J4LqfkgFsg
	7jw8KQczvIpRxhcV7UibMhReYlSdLwH1dh6VNFauyG4M1DNDpQCP3H7GkOnP8AJgFp5lTCsAvPAtw
	f/WBjO49J10drg4oSqt+p4N9l7PF+eGmCM36NnOI+Sa2hBhWAX6SyTXLk4TRZ8Px2kBizJSdA8H5O
	zVOgEtnGWIECTKzmHtjvYn2SNUdOJ10Rvd0LIGxTtzkrgDbicWusd6qYugIFZNwdgXrMKw7KvW7TS
	kV4QFBEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO2xw-00000009o4d-47so;
	Sat, 16 May 2026 00:33:16 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO2xt-00000009o3r-3v9x
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 00:33:15 +0000
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-6314cff521aso124809137.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 17:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778891592; cv=none;
        d=google.com; s=arc-20240605;
        b=P/XGXLWvjM0YlZScOFVSynJrMTlF+prbu82RPNXVD8qiuccN3PMf3XhjYRwh+pk7Br
         v3cH1xFmBsfh8EmJL+qxdinLmu2uh5jMCeon54AVtG8468dN0V3KD9BURgiwE0wEWy0O
         evZ7YmGHg7/oBL4ySgNzQSmO5I0WdnWDo7xOvIkwmfzroJgLeLgGA2E4fPbb0y1fjpHD
         BRVwXnRG5jUGn8QPT5rCoaW9agiPNARwBLCMPnQW9ASAryH33IObDRtlr9i+ANmI/I9q
         lTcKIeSLv4DpuPZpU1HrSBqNf93l/021glV1y694eBk+Tl3dsYUpsJ/T1t3V43LYN7sM
         SMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ClrtqZ8x9yt17eBnj412p27ytJWuSZtaoH0o74kNhP0=;
        fh=rAYU1DjdONAWmHZOWpMbzU15lDP3BtgqWBbPTfuXU4c=;
        b=ZYE5qLa/3GmBw/f2c0jdPDT764JnJfAIgguZFIz/m/+Kkz1cViivfLvmGbnFfLqMoJ
         khyyGqeN2ujvz0LgG+q54HV5lbvvMe3ShOV4xBU38/BxVdBB9Df3YII52GOctkg4+F1X
         XMZg2+nAvL3S4yaWGHXXUMBWgDu4I7a9WgLQXqiCgH+a/k3Iw8+HGlfeFvoSdLF28CJ6
         QoG4R9EfO63qCF3JLja1NqL6BYxNZAdLRP4MZN5YzRp0O+4N8+R5ToK6pB+m89xlJ5fE
         HGKyY8dw9H+wg+528Ypim5XCV0lihDMdTE7GuSFz0B9/zXDebr9HP12p6z8HI1tNl4ib
         lh4A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778891592; x=1779496392; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClrtqZ8x9yt17eBnj412p27ytJWuSZtaoH0o74kNhP0=;
        b=WAnO5Adcqp4sB/ws77lbkScZGAQu5EWhom+EN428dBp1ASv+pE/rRMh7B9FNPnLQaV
         UZyLQlzbF5Xde9Nta7gebAJfVVJTu9OmKOB4RkAHv5tTtetlxYK+XDhJbsgqPGT6ROlY
         p0nP8KoJtG1P1nN71ggPVcXh/4NwPONaPgc1QprJ6imWQH5avtkYzzfD1NKqkTvG2KoQ
         V/UkGgKMT6QyM7l+uKRrQ9YnS4CuIrjABjV5/C8gyV7fRoc6xFB6686MYa68zwhmNh6s
         znW98lKulLDsLGxN0E6datYBm9Lb+El4KsHqpzSbb76p83qZeQCLVsbOA83dkh/IDbbw
         izAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778891592; x=1779496392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClrtqZ8x9yt17eBnj412p27ytJWuSZtaoH0o74kNhP0=;
        b=XOPrqjBwSKk/M1Tju3EVeR0kQ0kgM5IdqMCQev7x9YnQYhz3wu8VGuofJ7GGjx17wA
         8Jy0OL10bwRumEitccClliH8NEscNCxA0+hEjlzsOHJlBIAKpEtdrXoGPa+U1kKq3pDK
         kP8+dJV7TMjV+kMSmJcskd8Vyh0GbW2CLzqjWscfo8Ui+WZqou9tKRXN5XGOYrmsgRlT
         /cjvN7I2wHC6njAGms297WznsfgH/QkKAWscjQNMIkBi9uruz8+SkwCTVizRg8Jj6d1w
         IfgmXewHhYgVBbY2/moUSNWrtA5Ijfgtwr1tt3zIuOPK0O0HQtyhkabyvgP7wjkSYcSr
         RELg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZFNioCErL9w1zuap8RLLjYh+NZ6ZwqdwulujjpZHHVJAFcE3oSGuZ4P9ygz6JJvc2QYZCe1Igtamo@lists.infradead.org
X-Gm-Message-State: AOJu0YxBpESl7vElcU/RSOT8KFF3qGkP2QJ4ZrRw+5dnKLimfaJ2s8dy
	WSAJSXOWxWE0iqsWyN6SwtaD+Lt1MUwTpXuM7dyR8EBujjwpXI5MTPnTE8EyaMTIxL1lUkmvS6I
	iEv1U0gx5qkv2ZMvRrc5V67Ho7a9Hd746i9jKcxSqSA==
X-Gm-Gg: Acq92OHBEd7HV0PO3X123YQTSKEQAe+JofQksjAzSb/YsplCvtSgXDcsXNG+VhBm1oD
	ol2OJyAgLXOM6JgNMMNqm1Y9BW3KJGqUrufwfGdsueGc7NxE3wS0znPIGUjFeW6npdpowYdC5IH
	uGcYAcESsGvJNCNC/SfmUkLc6LnjIe3ELfR+3f4X+lT6WFKuh7Hym3IoOclvw9zUd6moxuPyT5u
	5cpkZdw2PlcaS51P2zXpJXY/dCDstDy0Nk47inJVDsPDNyi5Kek+/z7vHhdY6aQZEnM6hvK0Gjt
	jq/lEB3wrivj0LC1ZKb+wzMNOd/qG8ml75ovEvhHFX7PAKV5FkfWZ9izCSG+sSWxInXRA6O43jp
	q0ps=
X-Received: by 2002:a05:6102:4428:b0:639:43f5:1fcc with SMTP id
 ada2fe7eead31-63a3d42da4emr3753989137.13.1778891592273; Fri, 15 May 2026
 17:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-15-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-15-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 15 May 2026 17:33:00 -0700
X-Gm-Features: AVHnY4JDtI3w0OMx9t1QtIOkGleR9Cpb7SvfdihshfxlFwWfIEleYe6CZMAs8D0
Message-ID: <CAPpK+O1MUxLOFbCShysDhbPoFV8qpxZcxd25pk6XCe0qztsweA@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] nvme-fc: Hold inflight requests while in FENCING state
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_173313_978064_499C74F8 
X-CRM114-Status: UNSURE (   9.57  )
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

On Fri, Mar 27, 2026 at 5:46=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> While in FENCING state, aborted inflight IOs should be held until fencing
> is done. Update nvme_fc_fcpio_done() to not complete aborted requests or
> requests with transport errors. These held requests will be canceled in
> nvme_fc_delete_association() after fencing is done. nvme_fc_fcpio_done()
> avoids racing with canceling aborted requests by making sure we complete
> successful requests before waking up the waiting thread.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Signed-off-by: James Smart <jsmart833426@gmail.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

