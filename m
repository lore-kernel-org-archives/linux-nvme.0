Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A454ECCFA02
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z55zmfhPZ/JH3r6Axk9zdxLaTNVRfIBYZwVYwYMTc5I=; b=c2CkaSWg4d7ktcExuXT/ZheSja
	FSsDkyFgzKDe3BbeZcMrDn9gYeXBA/TsLxURqujv7389wSs76nBc0eNFQqUosNVdAVHcrVt7fTN+0
	tK1YmTrMM1HYZZ/q5YdJjfUlg3O9N6cfJRQR1kddkk1EdTytxMCgZu3A4aOibxN3T0KH5SQUcNiS7
	V6dZ2yTf4DS0jXFPK323mkwNpTq+bIevtg+sV+nVjKenZooJRWbfR7oZ7yKV1uhtSkH78XNqREUYJ
	KAVa3EeMOKQNl80DFYGfS3/ux0pqdG/DvTnNvH8ptd5bYcK7K0v4uI6O3QuUPU9TcSb8kdxeZ2YE2
	74oTwd8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEtso-00000006cVR-0CSt;
	Fri, 31 Oct 2025 18:29:54 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEtsl-00000006cUm-2wXh
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 18:29:53 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-294e5852bf6so4204865ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 31 Oct 2025 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761935390; x=1762540190; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z55zmfhPZ/JH3r6Axk9zdxLaTNVRfIBYZwVYwYMTc5I=;
        b=Y/c4JxmfUfyKosWOMMp7BbzgNNNyVlcZZuQJqNLIomkFdHpnwopeGu0YhVSZZFSCqq
         BJyZHwtd4fFskeAxW55zwF7qJoYBdwx6v/NPO7UdcDNLp5j/yvT74sdmj7kdKYBs90or
         O5JYpW6wGzcDDP3cbJWBeG23l4aLU+iiZzuJpRV6T2hIV0RBslPhYv0lquy2XREWV0+a
         EudjOLyvieOkunskbcz2FDfCQa+iWuu7taxxYxo+J49uja/ImTimXH0Aqxtp7RgMASpC
         t3wFaJMufZ8LajYwY98h1Y1zY6camwO/zhr5gAhMGhuqcYhd1AyeF2L7HH5ZjJEd4H3r
         PEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761935390; x=1762540190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z55zmfhPZ/JH3r6Axk9zdxLaTNVRfIBYZwVYwYMTc5I=;
        b=moMGNimpqz0GS8sYMnHnwKEyJkqQOFshM8fT+NR2b8PgEgYNalU9zejt2iAsiFC8VK
         9BgCUcedavP1uzQp+Ni5cJIpu0Au1Dq9nsY1CNXmt+oc6YXJZKjKD48TVk1bAOUz6XXu
         08DAnyvrUyQkMQmfaMepxFegwCW0wu1w+JrvtQbfgl2NRqBu4pop7PB1/5jDR44JTuFE
         pGhCS0Y1i9g2jF0HPstKn5514FvNXgnqwwsB14GGYm/tTJbIgZ3V4y9BfBmQ/ho/wA98
         48rPEpwIma7f9WK35ENHG0Rh5TsBX7gVc98cuThk7l6uMzgYTsFHfa01NzQgboezjvUl
         1MXg==
X-Forwarded-Encrypted: i=1; AJvYcCXzZRLzZfKfmh5B88kuRdAgusPJt+Sn4YWAPHc71l7nRh9J5HZQPs8ZZAsixKeBdzUZRcjkHnZ1U9Ed@lists.infradead.org
X-Gm-Message-State: AOJu0YwH1XIyxYvoUFwUNWThaoCdGSPfCCAhiN4iUO63mdJmSr2tZdjP
	/6oI9sf4KGu1zlV7F0fs3btSOkOkxaDUgqi7S4di9prPyelBEdlHWbiC4X5RB3Uq7L5XDbr8zEn
	T2BTPPa4t6JNPo2k/l8szY1UsRFQWDnGtkElclfFcOzsfFY35GuyDaJw=
X-Gm-Gg: ASbGncsafwY2ebK0l1KHjK1ZU1WufpOOUlIMfljtMr6xm1pzxqb/Y5GLv5Wfc5aSZxj
	G99GZAYaObxE3xe0SHNoWLP0QiBceg0OWNTCVjdCJuio/wQc44nKCgY3mpo9NbRTsqrPeIUWfUz
	i9qGkwUzbZSHIXXbXXLFVFRmZcwoMfx1BsJE0SF7KXjIuurLmslS+tPrsZNgJ0oZXWUmIcUB1jp
	ZgOZp3XEx0dNsM/vtHUQneHAUjkOMlSolx5kczkrHI69OycQSslejV3Ml2RHU1tOxdndRXWPdYr
	pcBshje3In+D/hGk4TjuOAQSEZxFJg==
X-Google-Smtp-Source: AGHT+IG4bOkdfsFJZblcFZ6qJHvTEYrpwiVlyRYTXktlwfAYyq7KD0P/FbFEhEndkdVv+NprV5snVBt3nCQR/grG0qM=
X-Received: by 2002:a17:902:ce88:b0:290:aaff:344e with SMTP id
 d9443c01a7336-2951a36c31cmr37241305ad.2.1761935390144; Fri, 31 Oct 2025
 11:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20251027020302.822544-1-csander@purestorage.com>
 <20251027020302.822544-5-csander@purestorage.com> <20251027075142.GA14661@lst.de>
In-Reply-To: <20251027075142.GA14661@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 31 Oct 2025 11:29:38 -0700
X-Gm-Features: AWmQ_bnD9cmB_he1htZLcay_wVtXtWzu-O7fBpjGn-Ny_vwA3iif2bU7bDu7dec
Message-ID: <CADUfDZq88mkARUOx-RQw72dwkTc2EB+0KiBtC6BL66e4pgiZxw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_112951_935559_2236AD40 
X-CRM114-Status: GOOD (  14.53  )
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

On Mon, Oct 27, 2025 at 12:51=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> > +static void blk_cmd_complete(struct io_tw_req tw_req, io_tw_token_t tw=
)
> >  {
> > +     unsigned int issue_flags =3D IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
>
> In most of these ioctl handlers issue_flags only has a single user,
> so you might as well pass it directly.

Sure, happy to get rid of the intermediate variable in places where
issue_flags is only referenced once.

>
> In fact asm most external callers of io_uring_cmd_done pass that, would
> a helper that just harcodes it make sense and then maybe switch the
> special cases to use __io_uring_cmd_done directly?

While issue_flags is mainly used to pass to io_uring_cmd_done(), there
are some other uses too. For example, ublk_cmd_tw_cb() and
ublk_cmd_list_tw_cb() pass it to io_buffer_register_bvec() via
ublk_dispatch_req(), ublk_prep_auto_buf_reg(), and
ublk_auto_buf_reg(). Since uring_cmd implementations can perform
arbitrary work in task work context, I think it makes sense to keep
IO_URING_CMD_TASK_WORK_ISSUE_FLAG so it can be used wherever it's
required.

Best,
Caleb

