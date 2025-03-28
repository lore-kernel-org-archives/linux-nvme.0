Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585D5C3600B
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 02:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+EzFQHCtUgWmoDifuVxej7HfnN8BQClVg09pdvG46dw=; b=5GoBztDGDatz//FCo5YOFpLNNY
	FcV2xE6EnABKY9VVysz04AckefkQJ/nPws1Q86WHVBPtHZV1hO2/ou6eixhETGSGxrttQSEBqgq/M
	tXBG9PBhVE8m1GIeVh1Kv5iZdhf0HGIvSh1s9Z4Kx0IiryIIV5sFQAu0lyYdIHQNeSbXzn6/YvW7/
	XkliPILQJzoYHxM7oPU832/oEMMgWlRP6ycuqW5V/Km/MKnbbJXOICDpfUsm4cWcHcwUpfhrXDVbc
	zNvzeZyomNGn05Uqxf4HRMrFN+MtdN4w/9KcHf0DN+Hsq9e/BFGpdJEnyAGFSoeS0mwEXAQv+BBX+
	+we6EmYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txzl6-0000000CQUk-1Ckz;
	Fri, 28 Mar 2025 02:47:48 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txzl3-0000000CQUI-1uI0
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 02:47:46 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-301a6347494so377948a91.3
        for <linux-nvme@lists.infradead.org>; Thu, 27 Mar 2025 19:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743130064; x=1743734864; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EzFQHCtUgWmoDifuVxej7HfnN8BQClVg09pdvG46dw=;
        b=EomFV/i5oehXqykcD8Suh3qCCeNdXCBbi3EIG1eEM2BgdbUOFl3ZSHt7sS2023QS1o
         nsgO0QOncMj6l1lyFcypX47YOy0RDVXOBWYKaxEsM/9wBlyGnHYzAo/1xjhJXDqs1/wF
         a/++rJJbLxcFvd6J43ikNG/kQ6MOhgCFckbvTs37APrGHTBiuHgZX8s/YRaqvFAVD68c
         csLIFRCOGWpvh02TfEd/gxMaYwQhB5fCiYD6E8jifpqfA1dl5x0wHTaPeKXf01/wHoSd
         Xv+WucgOwwhhMkjlX5y/bH7f8/cl+kUqmkNiQVro6ZYNCS6IQKTL75zf3Qz+IZabEVF/
         ttbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743130064; x=1743734864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EzFQHCtUgWmoDifuVxej7HfnN8BQClVg09pdvG46dw=;
        b=DwlOPneK06RiOSo/r10Nb9nXOj9bzhbKNbOjvK4hyf6E3wnsWT6DAM6+6U5JYcy21w
         LLo5A2F9GaYS5gP3fw+tagDOoCz8QJlR9TP0bb+vNyuaGjabjlHkN/VIFCppJFiP2egu
         5y2ExmkbCstSVTEKOPTk+DGFL2M8BR07IcmFHM7MxYn+a3Qf2BxVSCVNTM3dIvew1gkZ
         oYMEdwzURScWxBAOKM0wDKZ4k9enRI+fZ0F0/DemZdsanFHq5Z2nfgsi6RijpH0fN6+c
         mmf2h+wWV7loal9JNe1jfGbMa+1Mv7uqLgnmMRlte7IhaMldtU9MKi+q6w1/GcJfI2OV
         2qlg==
X-Forwarded-Encrypted: i=1; AJvYcCU8l+YGzNVMoMjvygxEqNMLNlj0o0VoS2gc3Hc920sLgjsDHp85fg+SDbXjv+QXMSCMmg3bXeRzUpUL@lists.infradead.org
X-Gm-Message-State: AOJu0YwEztJn5bt16tC8DIne7/keb1nxyFEQAgYYZacmO18KxKOs+ZE7
	81zQ7L/n/BhBfi8LxLilRx+ApEAK92BRm10xECd88Xu6e9EBGr2TM+iKFZ/Fw2c0frhKUlQgdpU
	CZ7CypFAigJh8vxO+fdWpQOceYKs/xr5oXmGkZ4IvPtyfti/at7AlmA==
X-Gm-Gg: ASbGncuKGKgsqGJJfKPDnPT2VAOQfRvnhJv9hcBGOEUaFyIY0i6f3FW5huNrkdrcm7+
	z8Bw0WUZnIE9WcehmPdJQM13mxUc/5BD1LxPwB1vKx2wWkfRfWIoZxGm8daI1euLQxPXExJWjPG
	3tzhrR90eXVDVQR7KMxszayI8i
X-Google-Smtp-Source: AGHT+IFyrhfYHVDlBOiKvWboBacvv1fccig7N3Elhwk8fCEKTl6db/yebGmyYLY8ZpyFY7nSqApkcid9OQtcv8EmepA=
X-Received: by 2002:a17:90b:314c:b0:2ff:4a6d:b359 with SMTP id
 98e67ed59e1d1-303b278eefbmr2488894a91.7.1743130063671; Thu, 27 Mar 2025
 19:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250321205722.3947901-1-csander@purestorage.com>
 <20250321205722.3947901-4-csander@purestorage.com> <20250327104441.GC10068@lst.de>
In-Reply-To: <20250327104441.GC10068@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 27 Mar 2025 19:47:32 -0700
X-Gm-Features: AQ5f1JrA-BzXMglBzOaQqSWgz06sNK3uTMpl7x2enG4XCF9cWuP5AYH0nUF7HF0
Message-ID: <CADUfDZoMhCyM1FQmhftEeC7G2b5Wj338DE=H6XxrUjp=eOoJ4g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_194745_680181_8DB7947D 
X-CRM114-Status: GOOD (  16.16  )
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

On Thu, Mar 27, 2025 at 3:44=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, Mar 21, 2025 at 02:57:22PM -0600, Caleb Sander Mateos wrote:
> > nvme_map_user_request() is called from both nvme_submit_user_cmd() and
> > nvme_uring_cmd_io(). But the ioucmd branch is only applicable to
> > nvme_uring_cmd_io(). Move it to nvme_uring_cmd_io() and just pass the
> > resulting iov_iter to nvme_map_user_request().
>
> From a quick looks this valid, but actually adds slightly more code.
> Is there some long term plan you have in this area that this helps
> with?  Otherwise it feels like churn.

In v3 [1], the call to io_uring_cmd_import_fixed() is moved before
nvme_alloc_user_request(), which ensures the fixed buffer lookup
happens before the request may go async. That way, the request stills
succeed if the fixed buffer is unregistered before the request can be
reissued in a blocking fashion on the io_uring work queue. There's
also no longer any cleanup required if the lookup fails, so it's a
smaller net increase in lines of code.
Philosophically, it feels like checking the io_uring command flags and
looking up the fixed buffer doesn't really belong in the shared
nvme_map_user_request() helper.
I don't have any particular future plans here. I'd be happy to move
the logic out to a separate helper if you feel nvme_uring_cmd_io() is
getting too big.

Best,
Caleb

[1]: https://lore.kernel.org/lkml/20250324200540.910962-4-csander@purestora=
ge.com/T/#u

