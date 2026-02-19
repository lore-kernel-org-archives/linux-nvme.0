Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E33E9A053
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBiZ17iwfft0wbQAGLtoaADnrAgBOfJOHZF3aeqDH40=; b=Vij/F0qLAi4VIZ+LlEKLFn5DeJ
	3r+U0TQvl9Fn+fTF3pCLmtpuKm7myv9aWuIn3zR5dTu3yXoCN3XLt9HK4aPsX7IvnXENYlnzxgLpK
	TU/kUXJT74KG5wWW16YNzU/kfC4GAnU5nDPohzGJ7HUw30FbzPMTfBMh9OFNSBgci+GbQRYwe8Xgu
	JI2XqGzVl9kjj/tczJqyyh0ZxvRKR+D0StFNlquRB01m+sgwifrqiApljvLuOHAYfk9HRyQet4287
	7MqeIRtAVcnAwyG/XpBKPFzpGdMe+zLlTHx6zzAeVBXtntH/Oj1WUcr2otj3VR7WHGySTGiT7rM01
	3mR41Tfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7RG-0000000Bfgg-1B2m;
	Thu, 19 Feb 2026 17:03:42 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7RD-0000000Bffw-2wIe
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 17:03:41 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-b8fb8858537so15296066b.3
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 09:03:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771520618; cv=none;
        d=google.com; s=arc-20240605;
        b=MGZR1oLFeb5WQwq0Zd6631vrxDUDk7KMh39Blyh24gJphQYu2ugpLeU2GKGqeTTkOp
         py3GjSiu5i1ezEkhErcZlqsnaoklZ/npezjNNRrf5gD/Uf6XJzsZpHhTbLxhN2+5lM7x
         utdXIyFHMM08kGjk5msCA+UKmFxZTMavQlkz2YMlLaPpuihnvAIMtK+C4u9d2+sIfG12
         2hQDoPezks+ArKRTWSp1S+Bmu3SJ/zkTaVQi4tVtXzOe3rF9YtsYUjVZZE5QQeuLqUVd
         skcpzCirqaxMf4+Qa3ljiCMvFz2smns4gAyaIbfmwDk5iFcFEhtSJnimK3rOl+VBHcRm
         i0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tBiZ17iwfft0wbQAGLtoaADnrAgBOfJOHZF3aeqDH40=;
        fh=n8NwPyNRArlLK42Vv+AH6uu3FwIVnGo16+dUdbRNwpU=;
        b=liLrptQ4MU5d5n1rQ63/3jxzdcnpwmkX19SncEV2Y1vgPkOTU7LotsAp1xktouZP9u
         gVZ3Zgjq3crIKotinJq64iktN/jZbMqZWCx0Gn8uk9ng2Kfrs9iD4AByrqJuwScOWyzZ
         Nt9bhYj82pn+6u9Oo6c407WyaArxgvHnvPxegE2jC0RRC08E6oLE0YqpH4p+Nii/Rmxc
         +py3pohANq+A+WBLTONXPN5gyOwq3BWhGCGYHowH1PS+p/g6H7dD7V6MhgaqdzRKyxnd
         CGZYb53Mqd8MDk354HRP+CgTXFFs85qlHn7Lt4A61/TTkU4mQeSzoCaSXMP3hiNxpk0z
         7pRg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771520618; x=1772125418; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBiZ17iwfft0wbQAGLtoaADnrAgBOfJOHZF3aeqDH40=;
        b=HyYoC9180GOL3qcJEc1DNuRW+FT2p7K+LH0RS/HFs5XlXEAoDKV9BpndmR8eqosPzR
         s/pLD/WG2wSu4ZFjwsxUyFugG08BLtlPT4V3ozDF8jF4NgDnmz25vGgT9X4rwbqUHjRc
         RBjcAS6Bkry9XSftKekG/yFA6rrF/dHQPQBUrz/YYG4d9OKhL1VK6yOUxircj3zQ2OrF
         JG+5DmJMsTPS9yZaJPGWvsDN4HdxnkMNUOqcuWLdrP1FC9QFvtJyEmF9JsqqLVpPII4N
         K8RTRzq2/PbzRX9sLrs4uBazBGuwBVziOWrJVsCFftOUV19+Y8fpL1b2XDgydfL7LxpJ
         dmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520618; x=1772125418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBiZ17iwfft0wbQAGLtoaADnrAgBOfJOHZF3aeqDH40=;
        b=eL8McHmUHiJ0ZZg96eXS9Ykdl45XXjcnjYx2x67rmxY8hnF1U0QnprLRKMplp3TdSk
         rBaV2IEFqUBUz7tv+NpLBU72JpxW63OBRYNoG1wOEUGD5c1AFyap98KfWT+Zs5GQfiNA
         GrOigzX1luftMSl688Pw0WlvHlgYKm3m7bux3QD+qHGiMzElXQnr1+LmVdYjS7HqkH0w
         9GsF9QSgrH8MOX1ohQKGduMELs70J1yM2ZZ1JIfRZaesbzmFVvY3EzfQAQk+FJxk2RHH
         f6YHL4ZtlPw0mSefJtyLmtjXssxvQZAroakA8TADmOEvA3DeQ7MmXG6jVwggHqQqTAiN
         zPLw==
X-Forwarded-Encrypted: i=1; AJvYcCWcIUh69SWor+e4WrwF4deIPDygMN/6Wz+cJwmwQb4y8O51gYDXTDLKih1OoY01r6+4XXEY1eoEr1BA@lists.infradead.org
X-Gm-Message-State: AOJu0YxNAOoazbM9fBh+B2RJHm2PQDJ+Oc2czS8NSrt+g0JzoUR1ziqR
	A9l/znb7gzItz0yPGxlPc55G6Eki9GqYjONz6EqAc6e6/UFTj6M7OxEw8dPNLMUogVxw7Jm/cB7
	65lrGPAtXaZCX40Gxk6cQfOjsIUWyqwy405zmlzXsdO2WNX3+cOedE0U=
X-Gm-Gg: AZuq6aKPMeZU+uQSLdS8589a+VFL72Z/pFjlRldEWdZOUoHAawe/6Pl5jJnJaMH/N7b
	a0296SdUOG1sQLMl6irvBJrCBuHRLMLQ9bSwMsLOzH7L9nupjHarqTjzRK2vR3cfkCgCt6wrcAl
	Pjyq/xXxE3rVpNfcnhBp5zWsy9jQgtoF8HUq8IdI5MF3AbvRPvRGwBOazApQhXcEFfTZP/6nLYO
	Z+rU4b1cZ5M2Sa591ObobIHxaA7zk3YmGIAuZD1UiP/yJzRKWLEM+vi4mjY7AZzZQk3+p+UNHQ0
	vbRPnnXN
X-Received: by 2002:a17:907:3e88:b0:b87:2099:9f6b with SMTP id
 a640c23a62f3a-b8face2491bmr719909166b.3.1771520617544; Thu, 19 Feb 2026
 09:03:37 -0800 (PST)
MIME-Version: 1.0
References: <CGME20260219014357epcas5p31a24ed7f17ebfe2d15f850c2a4114ebe@epcas5p3.samsung.com>
 <20260219014335.9061-1-csander@purestorage.com> <bbe35147-af86-4066-8732-c0d786c83df5@samsung.com>
In-Reply-To: <bbe35147-af86-4066-8732-c0d786c83df5@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 19 Feb 2026 09:03:25 -0800
X-Gm-Features: AaiRm514HVDr43F6uGOoNr91TzPyJVfVDvc5lu9SfKCR-pgqvUyhUK65XwoRlkA
Message-ID: <CADUfDZopEPJ5C37iTRWYmsJq5u=uVBXm1EbR1GsWm=2QtjA2fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_090339_760203_5F485740 
X-CRM114-Status: GOOD (  25.62  )
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

On Thu, Feb 19, 2026 at 5:30=E2=80=AFAM Kanchan Joshi <joshi.k@samsung.com>=
 wrote:
>
> On 2/19/2026 7:13 AM, Caleb Sander Mateos wrote:
> > Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> > requests issued to it to support iopoll. This prevents, for example,
> > using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> > zero-copy buffer registrations are performed using a uring_cmd. There's
> > no technical reason why these non-iopoll uring_cmds can't be supported.
> > They will either complete synchronously or via an external mechanism
> > that calls io_uring_cmd_done(), so they don't need to be polled.
> >
> > Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
> > even if their files don't implement ->uring_cmd_iopoll().
>
> For a moment I felt that series is going to change the user-facing
> behavior of IORING_SETUP_IOPOLL and therefore might require a
> documentation update [1].
> But the change is limited to uring-cmd and that too for the files that
> don't implement ->uring_cmd_iopoll().

Yes, in principle it should be possible to allow individual I/Os to
opt out of iopoll. I mentioned that as a future possibility in patch 1
("io_uring: add REQ_F_IOPOLL"). I'm wary of using up the last bit in
io_uring_sqe's 8-bit flags field for this possibly niche usecase. I
think it would probably make more sense to use an opcode-specific flag
field, e.g. rw_flags or attr_type_mask for read/write requests and
uring_cmd_flags for uring_cmd. Any opcodes that don't support iopoll
would implicitly opt out of it. I'd like to get some feedback about
the UAPI for opting out of iopoll and whether it even seems useful,
which is why I'm deferring it from this series.

>
>
> [1] The man page for IORING_SETUP_IOPOLL: "it is illegal to mix and
> match polled and non-polled I/O on an io_uring".

Good observation. I can definitely send a liburing PR to update the
man page if this series lands. FWIW, there are already several opcodes
allowed on IORING_SETUP_IOPOLL io_urings (IORING_OP_NOP,
IORING_OP_FILES_UPDATE, IORING_OP_MSG_RING, etc.) that don't actually
implement iopoll semantics. Basically any request that completes
synchronously is fine, but mixing iopoll requests with epoll-style
"poll" requests may be problematic.

Thanks,
Caleb

