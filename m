Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBA2C36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IzHqaB1xXtn1biQiH6+BombSZ4qjcO3Cqq4ZsPGl3l8=; b=ucZ0RKOpY5PCbW9YCX+i6F9AFr
	kT8Z2jrKsHIosvoAzPKu92WIpnV5eWjn59gFzVMT/SyepZdwBf1Ax7J80+fgzbno7193KRwpKx5Tt
	r5s+tOsX72NLfzxaFJMYjwgmMo1550OngGnLTAqEVj2TeEvbcO7HTipa9x/w2ImTrzzoIsBQ1FG94
	Ov4+opFnp3EMXkVYdoUb8iLPad0/Hv0/u88+U5Qfow7b6eo9U1T6VYo4tLC9WkTcTsDFhCkWniTTk
	l4RuVx+YaQHTSlQhuasIRnhX6W4u5Z24gcEy3j9bBhJPaTxwosbLJEye8NgqXLHTgs6P0BpJeJqLb
	T+qMwZBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjEG-0000000GEXp-4BZt;
	Fri, 21 Mar 2025 20:44:33 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjEE-0000000GEXI-3TZ3
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:44:32 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so646267a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589870; x=1743194670; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzHqaB1xXtn1biQiH6+BombSZ4qjcO3Cqq4ZsPGl3l8=;
        b=UnuCOqYQ53+HjBsY/9Bxb2tWAfIkeMdg8T3+YmcTr7VNh4YRUaLNkzaIUoT0pmyFw8
         9YNIpBSTIJgRNz5JmcYBS/wCu7QZQnYX0qAyKDW67uLCcBvgi66tJMPWh6MT/PCV2tl6
         DvDr6N8QQoUnRlUXuHyc+QtG1i0cEBrmM36Bi8QDynIxaNwYv+3JcZNppy/BF4ai4iwJ
         DhawMCOOtXixh3JIqRJa+HTj9B5qHFJZuwJzT7KYV2Mw1/6ByI4F451RYIfJ4+hV3MrJ
         HF9eOwzwO+wcVWqnK90MdipGvnQE7sW6f4F2mgImBgft8xhd2D0ScaWNu8MVJL8kHLC9
         L4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589870; x=1743194670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzHqaB1xXtn1biQiH6+BombSZ4qjcO3Cqq4ZsPGl3l8=;
        b=vBCGolKNqbaXkadf4whdzbODWr2vTuIFY0m4nAMuW8wsZec8V+OyeMQHX0q+rffgkH
         u35ow7wjDV82hs6rO6SLtMGKJsWgAFmKJj7Uht+LGnVUvyCk5iD50Y7TeaXFVOY48pRC
         alOcfBVHj7bH3GNAC4yXoNmA6d55t1UxZnzb4xwnwYEGVtHiZ03kOPU8C/NcT0Apk3C3
         k1qcxqUrFIl8tOoWlwptIzI2xfF6gVtabBi6WGllhPhJIhr+qmnRBAcGM6kqKhqPaY+f
         U7IdbdcGYUcQl6YN0LqcMUeE67kY3rlO7jJZXkyjoa9Llfy3lwsiCLc9MqLEk0Sk4i4l
         YDWg==
X-Forwarded-Encrypted: i=1; AJvYcCWOJe62ck4iV3p9Dk9JMtLhTqpJzt97GJoNKiEN9ZdDD9JEsMX2BBSZ/rudHSEnjCE12kIaRUUW9ort@lists.infradead.org
X-Gm-Message-State: AOJu0YzgdyUihjLfxVRXH86h1CZEkm5qnjm0Mrk7tU1KjFyLmwY7Pt+B
	uf2LCjdPJ0sa1v6Y8BJvy6YNr8cy2tcebmS1mknDdW/DciO8LBDXck60Ne48cViJZGq6XxGQdcd
	PJmDCslnC3lRC1HLm89uenUbLoi37VYDQ8FO5FA==
X-Gm-Gg: ASbGnct4b6+aoTHpz8YW+GPLnE/9gWvb7ZMzgUimKZRO1cD7Br5aezPn3eNO1gM6sxV
	M/QafTtX6WAyZ04rIWzYUclPdwqmVhG9I5s3A+JYtp85thhp7na2tip44L/Bcpnm8JPdOgAnf3v
	/cYcm8ZipMrvngm1yrfWCM2U5t
X-Google-Smtp-Source: AGHT+IHb7qNZVc4dbo1EN1WvdXjQ6zVnZ8qtjLzzTA7S1AqgBNosamOSmdEMbw5hYcAX2F+qzbprqzxMQiDGSU0T5QI=
X-Received: by 2002:a17:90b:1c08:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-3030fef77bfmr2814564a91.5.1742589869879; Fri, 21 Mar 2025
 13:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250321184819.3847386-1-csander@purestorage.com>
 <20250321184819.3847386-2-csander@purestorage.com> <ee6c175c-d5b7-4a1f-97b3-4ff6166c5c73@gmail.com>
In-Reply-To: <ee6c175c-d5b7-4a1f-97b3-4ff6166c5c73@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 21 Mar 2025 13:44:17 -0700
X-Gm-Features: AQ5f1JqsMWeWHDB8wb1B7Zchq6sPKT-24dX-m8MSW4wk0vEJnpusemPKRi6lxhQ
Message-ID: <CADUfDZq=UMw+tm8YdnttVSL=wvF_fnBSvixbfj=KZ1inOLZHug@mail.gmail.com>
Subject: Re: [PATCH 1/3] io_uring/net: only import send_zc buffer once
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_134430_869670_E9F73751 
X-CRM114-Status: GOOD (  18.78  )
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

On Fri, Mar 21, 2025 at 1:37=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 3/21/25 18:48, Caleb Sander Mateos wrote:
> > io_send_zc() guards its call to io_send_zc_import() with if (!done_io)
> > in an attempt to avoid calling it redundantly on the same req. However,
> > if the initial non-blocking issue returns -EAGAIN, done_io will stay 0.
> > This causes the subsequent issue to unnecessarily re-import the buffer.
> >
> > Add an explicit flag "imported" to io_sr_msg to track if its buffer has
> > already been imported. Clear the flag in io_send_zc_prep(). Call
> > io_send_zc_import() and set the flag in io_send_zc() if it is unset.
>
> lgtm. Maybe there is a way to put it into req->flags and combine
> with REQ_F_IMPORT_BUFFER, but likely just an idea for the future.

Yes, I considered making it a bitflag. But since there was an existing
hole in io_sr_msg, I figured it wasn't worth optimizing. Certainly if
we want to shrink io_sr_msg in the future, this is low-hanging fruit.
I'm a bit hesitant to reserve a bit in the generic req->flags that's
only used for one opcode.

Best,
Caleb

