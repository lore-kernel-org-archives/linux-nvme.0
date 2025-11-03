Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2E4CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 07:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fyxHa9/8/Ar3cmThFu6k2oVGwIVFxlREAcZe35Eyfc8=; b=rMKXTwIPkDp+ey8lu6Qoez1giE
	hJINsAZbbxMYHGwUuyVpQjhChWvQjxMhO5r4mPw1W31ldrV4rTDzePpnTuJsaz2tzpDGKx19k8ccW
	eJHrl7l2icIhnqMOc3TH7cxe5LlTI+PrrncEonth9qZUnFnb1aqZKyat9qmZNYbMbiyb7keU3FNwQ
	gLbdLb7cbFPGc9k+RNawhwEuQKjjBz52SUZsXSYZjRto98oTm/GTzo59pQ9aPa0Q9Y0s0VzlTjbgl
	5IA6zIErpbHzWoNvNNwEDEUiiTJlB/ukExNDc2gk9fTWhmZdibSS/9XtlcyKAX0NElCKjTqK3wV3f
	48eF8T+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFopW-00000009LQx-0Maa;
	Mon, 03 Nov 2025 07:18:18 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFopT-00000009LQP-1Ktm
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 07:18:16 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4711b95226dso51053625e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 02 Nov 2025 23:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762154293; x=1762759093; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fyxHa9/8/Ar3cmThFu6k2oVGwIVFxlREAcZe35Eyfc8=;
        b=J3jl9yvsfzlnrn+gPNMQUjxWKDpAHxtwWoMxWKO6TaBapPuCsXzI2c95rrCJsKrv6k
         Ff8D0tiBSawvbafezJDs0VlnM6AHUbFU0K7iX0yCcCWQ2tyGvRLiq/PgkWbQRQoW7mxj
         Rw3eohBzZEEuL9UOhe3qqR39iRXOWmLXdflWZ4bNYYjmzGCCm4h5HsEpAWwt7G5C+fKU
         1f0Nrn+lu/OT8Muov0SK7HYS6vQQ7g+CVZqrvbqtjL8WuHhaDkunhd0Q3Ptw95eQJKfj
         4c7nEeh3wDBWT94a+AS1z2seEh43AVFyVaYgz+JCDrdnEU97zZ007iUMXn9aOTLBGVnI
         QKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154293; x=1762759093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyxHa9/8/Ar3cmThFu6k2oVGwIVFxlREAcZe35Eyfc8=;
        b=MEgbN2CxdVLo7MjVl2R4vblrKh4r0b4qANkT6cLGuzI7JhUwMbQ7ayHyOKy6dICkPs
         cMeeM4P64UDO+VLVOo27iayH7iyA6TDw6er/vEpaUtVQNLz0D1a5PqTB2Fiw/3dbZyH8
         VDA91geY1AyToy60Dqydp22bPUTjRU4yUWENJ2tYtvn8j43uW0ZOfxDQh1BlC/MGufxU
         5iP5Gc2iktEJW+jilFI0eql/I+IJRUwJV9SnQ3w1GtXBQ9PXlc5efIPR5+4pl7UKSElv
         Jr+OmYYOxHS6uX3nNWLKR2oqVqWRmKJTZTlDyCB0U3Sm956SpJreZ3ri5T8Pbrryt++x
         /3vA==
X-Forwarded-Encrypted: i=1; AJvYcCVu8YwXE1OVnwII9qaC38s9cmcYyexpSscmAHoLZhRpZ+8uI/ZIGOBVcwVVU3RANcmWlXyDvzMCkZtj@lists.infradead.org
X-Gm-Message-State: AOJu0YzU8Cz3Tym4qP20ebIy9Al8ytY17tTToB0H1CDfvH2Sysxh2D3t
	lGFZBzNrss9mP0HRXuAk6/Alz1Hqm7W5m1YASDvxiDcU4PHAPq5C5xm/ySFZLEsFxOpxW4YnkXO
	iy0yHIkpl2oW/vh/mPvGwxYDZ/KoT/S19GezKNWz4Hg==
X-Gm-Gg: ASbGncvB0FPa594RW0jc/YyugBVxR0ywf10O+ZVOOZ7q1JzpVK7hG2amCmbZjugH+mA
	jKI3j39nq/FDWvFUIP4pY+oj81z24YK99AN0RvENmC20MEHD4AMv0TJ1a/8i80Tf+98fJ53SElD
	4x9KujTBxHt8hiWeh+LpHuWJrw0tESGbedeaiELJaXnkhah7k0bGyQ0fXOuDoJp5Dt+07ybLAGs
	ZQDqSIqfnqcU7cpBg36+MiKCz/l8SeYXW5DHgQZPLxg3qz3qdUE7RP1TKGE4lrCmRpGXUgbgIOh
	40neHQ8nXcnyVIXLpI/i5JB3VBZ0t8BH/HFwYYUHXrtsBg+dK911gAFN5Vm2zYDxRo5l
X-Google-Smtp-Source: AGHT+IHqUQu8mdmKFV60YUxpDIMFoEiDUTPxoVdwOa3d9A2KABNI1QO1FJGgMlmc/MHoUnrp0Cz2XrvfjpDIzK4Hz9g=
X-Received: by 2002:a05:600c:620a:b0:471:7a:791a with SMTP id
 5b1f17b1804b1-4773bf42644mr79682075e9.7.1762154292857; Sun, 02 Nov 2025
 23:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-2-dlemoal@kernel.org>
 <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org> <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
In-Reply-To: <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 3 Nov 2025 08:18:00 +0100
X-Gm-Features: AWmQ_bmxLu0zc6F1WlZXfm4Psv5Sxs14UirqMZbxcqRpQmruSk8F7QkSWlVIM64
Message-ID: <CAPjX3FebPLu_P=-BuP63VuaiAnC62rthcQ0vb+J8b-w0OckyqA@mail.gmail.com>
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>, 
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_231815_385147_F3A23E14 
X-CRM114-Status: GOOD (  19.03  )
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

On Mon, 3 Nov 2025 at 06:55, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 11/1/25 02:48, Bart Van Assche wrote:
> > Hi Damien,
> >
> > disk_update_zone_resources() only has a single caller and just below the
> > only call of this function the following code is present:
> >
> >       if (ret) {
> >               unsigned int memflags = blk_mq_freeze_queue(q);
> >
> >               disk_free_zone_resources(disk);
> >               blk_mq_unfreeze_queue(q, memflags);
> >       }
> >
> > Shouldn't this code be moved into disk_update_zone_resources() such that
> > error handling happens without unfreezing and refreezing the request
> > queue?
>
> Check the code again. disk_free_zone_resources() if the report zones callbacks
> return an error, and in that case disk_update_zone_resources() is not called.
> So having this call as it is cover all cases.

I understand Bart's idea was more like below:

> @@ -1568,7 +1572,12 @@ static int disk_update_zone_resources(str
uct gendisk *disk,
>       }
>
>   commit:
> -     return queue_limits_commit_update_frozen(q, &lim);
> +     ret = queue_limits_commit_update(q, &lim);
> +
> +unfreeze:

+       if (ret)
+               disk_free_zone_resources(disk);

> +     blk_mq_unfreeze_queue(q, memflags);
> +
> +     return ret;
>   }
>
>   static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,

And then in blk_revalidate_disk_zones() do this:

        if (ret > 0) {
                ret = disk_update_zone_resources(disk, &args);
        } else if (ret) {
                unsigned int memflags;

                pr_warn("%s: failed to revalidate zones\n", disk->disk_name);

               memflags = blk_mq_freeze_queue(q);
               disk_free_zone_resources(disk);
                blk_mq_unfreeze_queue(q, memflags);
        }

The question remains if this looks better?

> --
> Damien Le Moal
> Western Digital Research
>

