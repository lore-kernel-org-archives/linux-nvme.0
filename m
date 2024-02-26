Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D23C54E49
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:Cc:To:
	From:Message-Id:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=bkZF/uhLnyt4FCiUuL6SqgUagZoNjH2YpVQluDRw2FI=; b=ruy8bZoKsfYTMo
	XKR+GUy3QTek73oStNHGL1jPT25qhuhYVuYYxJSbLZuZqSvVuoqKDzd95YXDij5qbGF7IHvZ2mAYJ
	v0+GvVD2WMkvmuoxioT84QRowgO2Hj1c7VXUi8N3XlQViiV+xhOOMzXbGzBe1FK+N6IO8o1Dwr/77
	xWV3fg20sGOYcHAsynxaFl6y7P3UPlbLyrwsuKYLi6YIAf7oNwV3odJMuJX9kjDlJ6vh+EShpWhbQ
	M8KJsNL80bdc2Hkpb6A92YNLVua+EsZMBAdZ3Ny0dazBIkAvTUCporlwUT8/dWndGxecZbQj95O1n
	OB/HePu+TT7EM38GwabQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reX3H-0000000HGLZ-0GzY;
	Mon, 26 Feb 2024 09:13:35 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reX3E-0000000HGJr-1L5w
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 09:13:33 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2076849a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 26 Feb 2024 01:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708938810; x=1709543610; darn=lists.infradead.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bkZF/uhLnyt4FCiUuL6SqgUagZoNjH2YpVQluDRw2FI=;
        b=ECdEKPSq2gYlycariFnrJOOmZhgAoWNEghkgMkfaZgGe6Me0dgJBkAq63MrStJ49OI
         p5z8dXatNUk1pZeew6rKrxmGT79A1wqGk9jEEwzkYWGCiiGBiww2hATutK7Zn++MwnMo
         48ZPlK+oU2KRbrseouGzyeqF3VGXRcNlMXBxLXApyjEysx1v5YIb1MZ88W/fg9GfqUlY
         LwAmvCZBK008Yr6ENeH3J7hsIujGK/GoP6mH8/PCJQkCS8KZgYw4QDxYZp1tJq/zT9lx
         aGE7zvbVJZ+/DxZazYVYPoyltD+wvLWU+lh01H860aS6rhzlen5TfA0h8ilmYQP88k2Z
         XiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938810; x=1709543610;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkZF/uhLnyt4FCiUuL6SqgUagZoNjH2YpVQluDRw2FI=;
        b=IAX8g43CM23adP515qs52snBwEk+Vy5rfHTryCk8uVjdKiGwpA+/O4uI5GdvdLrf0i
         JoTAOA+m0xDldKzFaxPd0moju5VfSIOv0DDCbsr90pqZzW/rjLl64bxtQNR1bK3FuLI6
         GauPc7mD0Pk6BMm35N40y6Ni0qoUDNP1KHlkGOb7Rb2cUytVqs9+zs4m/py1C272KibS
         0e5xo3k7wmJ/AWlMCF9QQbkiaW8Tf9NzRztzi0vZ/PxyIDk1P+C1zbdq2qMPCtnrw7W4
         dH7Fx7TKKXiaZQpFStB+bJia6fmZ0493P8FGuNebZu1HNig5tGzY16K3ojLqU3HCLDn8
         c64A==
X-Forwarded-Encrypted: i=1; AJvYcCUFvmfJHeLxsZ9ZvPa2AtR4x0DdPFLaVT1oVPN5X71wPH55qFeVp9HD/0rDHl4vr+Hu6wacFhLmUlzLalVsm1IG8CHzO7XagLjKgdbVfy8=
X-Gm-Message-State: AOJu0Ywt6apnNUyjXk0/sTdQEtIt11+DOY45d8mwIWJ9wAaI7CjsAlNR
	dtRWyLfD9hJ5gaedPQ5tx7UN9y8tg0ZJrKsHzE/Q5KgYK6IzmOf6
X-Google-Smtp-Source: AGHT+IFgXhWF9MbgjGJkxXDKVwsDxRx81p91HlsItwhw0tBZDu43SLV4vOCp4BHWcv/zSvBpEWa16w==
X-Received: by 2002:a17:90a:6f01:b0:299:75aa:8949 with SMTP id d1-20020a17090a6f0100b0029975aa8949mr3725385pjk.22.1708938810286;
        Mon, 26 Feb 2024 01:13:30 -0800 (PST)
Received: from dw-tp ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902c60200b001dc8f8730f3sm2491163plr.285.2024.02.26.01.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:13:29 -0800 (PST)
Date: Mon, 26 Feb 2024 14:43:21 +0530
Message-Id: <878r371tce.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v4 03/11] fs: Initial atomic write support
In-Reply-To: <07537871-ab4e-4629-86ff-5559aa88ad17@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_011332_400416_B491C2A4 
X-CRM114-Status: UNSURE (   9.50  )
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

John Garry <john.g.garry@oracle.com> writes:

> On 24/02/2024 18:20, Ritesh Harjani (IBM) wrote:
>>>> Helper function atomic_write_valid() can be used by FSes to verify
>>>> compliant writes.
>> Minor nit.
>> maybe generic_atomic_write_valid()?
>
> Having "generic" in the name implies that there are other ways in which 
> we can check if an atomic write is valid, but really this function 
> should be good to use in scenarios so far considered.

It means individual FS can call in a generic atomic write validation
helper instead of implementing of their own. Hence generic_atomic_write_valid(). 

So for e.g. blkdev_atomic_write_valid() function and maybe iomap (or
ext4 or xfs) can use a generic_atomic_write_valid() helper routine to
validate an atomic write request.

-ritesh

