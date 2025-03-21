Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5A5C36002
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 21:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0s8PHm04p4vmMdRlrDb7etA3hydAU6JK9t4r3Yd98L8=; b=2lxRaynGxuwqBHm847g+KDUkbp
	yWQFBrjGEZk5EqKGwXCAK1FFuXcktyAT/UkhKK8sQWaC36HVh6HdpQP9kx+72YGCEXW1BJswJ/bAV
	KGwSwzNe7Jb+rVmQqQhoxzqAE6tP+ivX++vT8dluRDw3MuzOCGWOuc0jr4p2O6rjjAptcS5e99+sR
	leVCO0p0VPxlAjNOSTJlmpGv3IsX+YPehKwVHa0siQivhNrkcWDhEtBb/1O50V4/xYpPzuqplYI1T
	Od59stfu1TPaKSEIRc21lG+sEaJkMRsw8ptbcvNvYpS/nx47uCT/W7lTccZrJ5L8ZwkcsjPEhT+iy
	qVkILAqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvk4Z-0000000GNsM-04vi;
	Fri, 21 Mar 2025 21:38:35 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvk4V-0000000GNra-1smb
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 21:38:32 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2264aefc3b5so6494055ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742593110; x=1743197910; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s8PHm04p4vmMdRlrDb7etA3hydAU6JK9t4r3Yd98L8=;
        b=CIYdPy7eau4oj4SRR/69O2qU3rGms3wP0CZiajzB6tRoTZ0mjKgZcki/s14dkD+8Hh
         F1kkrkxcDDmOLT0he0NIJqyCS64Q6vXWNKnt9alcziynVimqJyd6SYVvyLjWa294tDnt
         GdCjWJf90OUbExlL7M2wXph2yC/JP42z6iPxpzKrKhB3Ji14MdoQTILzsUBOXcTeq76I
         KkZ66URbhFIw5tRz0kN10PHNiZCc4UpH04IYq8WCIo10b7mtp+STCVlcp2ci2bZknROf
         tfEbVtA40AfbLLhtSo2Dg7aiWj4VlabGXLjGrQzlgbsF3Bfc51z+ttLs3A1XEXHVcdIm
         oZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742593110; x=1743197910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s8PHm04p4vmMdRlrDb7etA3hydAU6JK9t4r3Yd98L8=;
        b=oPyL2GK+0SZB55Zh5phtD64gppEvdq5vypBqjBkGg1ODv74Qwn0THV9y+QkYXG16z2
         Xni2wd8aWXjo9kOZF8RJG8GIVkTheid7fbYz1tvSzHAShBBU5BkeWOAs5PFl/mQPkIg0
         2Fs3qgl0nprC7rusQxBdQQPFLIfgtlkSbVmr+Sp7FGJ0Npev0SZGuTEG2zB6zv+qqXbB
         EGooJgtKSHb36696Lj+C6p3JEda9zFALfvsBvyBPnQfQyrKkE38qODYgGE2KuU7YQI2e
         Oum+dFw6UxHeDhJYOk9ZqwKjJnsdA76anGBm99MFfsTmpKaPMw8Ymnkjt8l3ekZaHG/u
         vjQg==
X-Forwarded-Encrypted: i=1; AJvYcCW4HRE38bkJ6gA4hZHHZ305Vwob5BfKxATfJExmemIC6SU8dhCRTlJrTmNIGEAt6TqtZgZX9JtqEKxj@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5T2oHw4rDMmMQ6bU/2+NIb6L98CMnASjgWfBFyoF9pbpgILLu
	wBJGehja/OcMS2yrUEowjT74iyg0tPU741ONnx87NjJquDWVYehKjf0vwUevKGTtc+22eE2apQC
	9YMIygjQ0o08nK3ZhGu+A4zQOcyTAxhMIb4OL/w==
X-Gm-Gg: ASbGncu7eOHn3/j+z6Qupyqd7r6vI3NaOJwHvzLDxu4TmP4HUQ/mgZSFW5yeV22J7Fv
	spwgxlNBaV6Hnwba2OuILETUoUBFnGODsqxGP8y0KveRqE2S0cogZTF2ODDGfublQeO/DPgBb/O
	TS5pW5gLmICT7pzW7TKjmpL0v1
X-Google-Smtp-Source: AGHT+IGSk+bsBxz+JO9UqX1StGRAOw80slB+xBi/7szzHuQU/IKincKxZ1fz09uQ/n1u+YujF0fQ7TN14YtlTnBH7/c=
X-Received: by 2002:a17:902:db0e:b0:21b:b115:1dd9 with SMTP id
 d9443c01a7336-22780c7cad0mr28361055ad.5.1742593110608; Fri, 21 Mar 2025
 14:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250321184819.3847386-1-csander@purestorage.com>
 <20250321184819.3847386-4-csander@purestorage.com> <8338ac70-ed0b-4df5-a052-9ab1dfec9e26@gmail.com>
In-Reply-To: <8338ac70-ed0b-4df5-a052-9ab1dfec9e26@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 21 Mar 2025 14:38:19 -0700
X-Gm-Features: AQ5f1JqF7084HWCX45pZ6paHlx6q6XUtczTCEEBO8pEFGjQNkwueLYbERoxLSfY
Message-ID: <CADUfDZoELiri8Fuq3tHSsKf1XhPVaZ1eoCzfXK7g994VY4o9Vg@mail.gmail.com>
Subject: Re: [PATCH 3/3] io_uring/uring_cmd: import fixed buffer before going async
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_143831_493226_F6ED0ACB 
X-CRM114-Status: GOOD (  20.04  )
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

On Fri, Mar 21, 2025 at 1:34=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 3/21/25 18:48, Caleb Sander Mateos wrote:
> > For uring_cmd operations with fixed buffers, the fixed buffer lookup
> > happens in io_uring_cmd_import_fixed(), called from the ->uring_cmd()
> > implementation. A ->uring_cmd() implementation could return -EAGAIN on
> > the initial issue for any reason before io_uring_cmd_import_fixed().
> > For example, nvme_uring_cmd_io() calls nvme_alloc_user_request() first,
> > which can return -EAGAIN if all tags in the tag set are in use.
>
> That's up to command when it resolves the buffer, you can just
> move the call to io_import_reg_buf() earlier in nvme cmd code
> and not working it around at the io_uring side.
>
> In general, it's a step back, it just got cleaned up from the
> mess where node resolution and buffer imports were separate
> steps and duplicate by every single request type that used it.

Yes, I considered just reordering the steps in nvme_uring_cmd_io().
But it seems easy for a future change to accidentally introduce
another point where the issue can go async before it has looked up the
fixed buffer. And I am imagining there will be more uring_cmd fixed
buffer users added (e.g. btrfs). This seems like a generic problem
rather than something specific to NVMe passthru.
My other feeling is that the fixed buffer lookup is an io_uring-layer
detail, whereas the use of the buffer is more a concern of the
->uring_cmd() implementation. If only the opcodes were consistent
about how a fixed buffer is requested, we could do the lookup in the
generic io_uring code like fixed files already do.
But I'm open to implementing a different fix here if Jens would prefer.

Best,
Caleb

