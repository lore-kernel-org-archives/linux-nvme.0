Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDD9CD4F25
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 23:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yS28pp8pXNzbIxayFJTktXlRXnKWlaLxXToOvKx6JPQ=; b=zMUt+xc/fcyuIxK8hzQgBDsfWj
	h9QIfa6cW3iWnUrZI1YOQnNRXvQrqZmOlTNffxXLoP5bn6xJmFIHNWjRuEUCjF4ChfDUNtfd24azT
	XBKJI72ZN4kvCcalT8z+XU9aVK4OPv52uz6rP9g/yaPdbFHaRWDxvWxH0rhorGgH3gXewajPAeN+C
	Jw3Xvpl2C6r2onkR2vpyuqV9VOs7xNJaNN6WPYhStvwQqNpeTJOYsiEQCqxKe4QCbPccXME8RYSsT
	777MMaiZuRfNesCCStt23ZgN3az09Nso9E04E3uw92BMTuRpMpQWO74S49v4P+s64yy6kEw75C6Td
	XrvxifXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNfha-00000006qRl-3DVT;
	Thu, 14 May 2026 23:42:50 +0000
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNfhX-00000006qRE-2o2s
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 23:42:49 +0000
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-95d18b33f93so242899241.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 16:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778802166; cv=none;
        d=google.com; s=arc-20240605;
        b=Dd8LuE7QyKoXLgiTiQCJXJxC5aP0GuGLcOWeiF72x29a0E0bvbhB/hdZphj+NN0sTd
         hBLUfcoEiAymCIi8tR+NIB5Zg3CI+zLJ/a7UDK2Rob6LsxXbUH9UWDj5jbsTIrquXYmh
         lRqhFYry34SSO4QqFw6pb8VJ7zPtDL0rYCnKwg484NlIx7SBD2JGbCMATgwOnZP7oMCi
         UptFYloXBiZmwGD+ythvejyOjl/QokZ2SLgQGGwNCRQZh1xjhx8qM104a6bF+CgMUZqa
         KqT8J0gUmRmBr0DstGQx7wLF8DGuU4Fgmyiw8OWbWg1UAv+w6XG7+tWxOQ7Iq1jALo2V
         CwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yS28pp8pXNzbIxayFJTktXlRXnKWlaLxXToOvKx6JPQ=;
        fh=akKs/Z3Uue/bxA4bJ8hMwke7zHSTWCgaA78jzQfOkZI=;
        b=Ucu2Z10N1CjM3o8K5LZCDwwBs10S3JmVfz7izIInbG5RgWvYFKIsVgEPZBSpKwnVia
         ZoQs74P3HvcpciJiTLXLTqYyg9KCWSNZtDDPWdXNPTiKZofhh8Yqz8SK/wCwoz6JOWDy
         Ec4a33c5wB6bnKgLLj9uR24hkgGg8TvgGFFHjO6LUe/vGFJHyYSfznp1vL9Cu8Dk4suE
         8iki1gO2FwFbKpu+8rgcNxEu+NVHrYjoiMR0AqjUCYGH+EYYBbhPCWareq4kSqtVbyr/
         jHZ6mn0TugaMUMizJ4hQRV5/fwoCvCjo+ApqvBIKOOeEJOqSzpAvGJlbY969YME2diwc
         mhqA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778802166; x=1779406966; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS28pp8pXNzbIxayFJTktXlRXnKWlaLxXToOvKx6JPQ=;
        b=CAj+0+DOpmblQz8rTVvqtmpT9ncKDY1hb5iqjgkV/r8CJNKfwcCzrpGSvUGBQFj7B9
         GQSsAEfOcQcn6aYINCZeiL1rdZFNYTd0VR/vSti4NeVLCFWa0ezjXRhl0JQ9PF/QbTuH
         4j4pQnPNNbQ+URicYIWKY8daUwFu5XxZNbhX/vxVVb16OvZbC2Z8rDyNwdPEu6LlpTj5
         bJH7UtyUPCExdYPFhSjMqORnY++QH37JPFIDDMLtcBd7Od8VfugS65pLehJyBp4oYVOE
         ym/oE3Kp1T4i4X+hA/5cUmJ9AJrJ0Q/ymPDMwJX91xTicQ8g22okEOfwsXY2fko8NKPL
         Kq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778802166; x=1779406966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yS28pp8pXNzbIxayFJTktXlRXnKWlaLxXToOvKx6JPQ=;
        b=aaUlFYpIFy0S3amo6AlOVFMuNy9G0mySRt0Bae3Z017A+eWAl3k4T+NQ52kP8i1w92
         Cb37nsdJvet6tnTY6/bT3CwDfI70skLUbrGVrtVAcIfXS65Z4M295lIfaRfuwRjWaxip
         yvgbmhMwQouRJzw4Ww0JSNOnbk4BrEpQOLihrzuSpAaswrLhYvGv5vEkjtnnl5UvxbJB
         y/DcRILSaB+5VGBdpd5t5XaVtrxJFmozlFlU057VKUjA18yaoO8l0KPgw6rr2pZqzcNt
         DcFH8fkpGjAPLfc4y86jbTg/vNxVe6y77bpVp9stn1IyPzIDRZ0G3t2XVG5FzmvxeHoC
         3XYw==
X-Forwarded-Encrypted: i=1; AFNElJ+BmEk4MPJIgsGuKdYJD/nhemy2gYaiLEiWRKfT4ieUBrVoRhAqwZrlayIE+rlVBRxtnxdLYYjoqL8r@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6byo7YxdMKeaZ6l0ybzgG6jOVSjrRqRXbQArfcIsYQkpRqS8I
	V39ikHelmkrNoyWShSJlIjRZnTuFszqJElVMtqt5+J2n8qXM4BNa+kmrlPThXSN8/nHG0uJdOO9
	naRnI8zz4ayUqKbJM3yMRvm8U6RgmAlhzG+nATV/hyQ==
X-Gm-Gg: Acq92OF1BQSoXDppwHq4C33YLyjBso9/zWv1HzDenwkOgN/+6R3ssjmtJw3auZ/7eX9
	l7lc8fZFi2IinPHtn1FvuITDiOIBfH6l6IX2NJH/9Vg+f5wW6RbjYhBVLgchElJRuwkhSIhs37U
	5dB4Hjf+ozGZHd/xHUxEZHH2PC7WAGktTtlNe/W4ROy4vaLUMnWNXoNKG7cVdGwutAFLrceFjCx
	pUWpaDmxKnKU17YMR+zGrmYhyBGI6jRoC/13OEB662dx7slAD/PLA0vp4dzCBgN5v5LEqkOVHTp
	IkiM73sp3IzdrCKmUVqRmroxkkkENRiF3B6kpYP0A1KEpSGtchgklzATKR+5V2AmsGsc2HYHYw5
	j6PbO
X-Received: by 2002:a05:6102:e14:b0:631:ba82:e80 with SMTP id
 ada2fe7eead31-63a24679b0emr750738137.11.1778802165616; Thu, 14 May 2026
 16:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-3-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-3-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 16:42:32 -0700
X-Gm-Features: AVHnY4I4ykyj1VcRQRdfgZU8gVl6Usp1sQOjyBjq6mzI9qjkOBsDlIW6rG6kVrE
Message-ID: <CAPpK+O1x_Op8wFRt04TUaBVve-Pap12LZO8h3pKM0ig+1kBZrw@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] nvmet/debugfs: Export controller CIU and CIRN
 via debugfs
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
X-CRM114-CacheID: sfid-20260514_164247_850357_4B6E8BC9 
X-CRM114-Status: UNSURE (   8.08  )
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

On Fri, Mar 27, 2026 at 5:45=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Export ctrl->ciu and ctrl->cirn as debugfs files under controller
> debugfs directory.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

