Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA1FCA5FAB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 01:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5pLeu4YqgZECtiedNQxbKwtzen0HMS5vwbUNTX6n4u0=; b=U9FHDs2dCVNRAMtLWms0veN75k
	kDoGqUJ2sfUN5Smy/Yu0KySCKa9+BmnkNoFNVJtBzl5XvrceYbqI69cixs0eq6zPIWilBGday8K/Q
	ddZQ5EBJ1VEJbvWzKn21Qzw+XzJOOKrQv2ZglaBrZ9kVI0v0SlWJVuStI9IySQwZOK6K+AtoWrHU2
	YSerq/NwSsyT0Qr/Wz0qWMdHCEem1yUlmatNb37FvY20urkzSU65lOgrYvoWPAloKNEtRnOuOcbSB
	r9esHqa59E+b4/KbLx5RLTFuCVSmH4tbGBq7woJ0WAl+aJbgfYtSQQnDLbkkZVS36nE09RI2zmwZB
	+9opVK0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBMRp-000000022jt-2gaP;
	Tue, 29 Sep 2026 01:15:57 +0000
Received: from mail-oo2-x2a.google.com ([2607:f8b0:4864:31::2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBMRm-000000022jV-0I4j
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 01:15:55 +0000
Received: by mail-oo2-x2a.google.com with SMTP id 46e09a7af769-801cb343a92so552081a34.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 18:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790644552; cv=none;
        d=google.com; s=arc-20260327;
        b=dfawg0s4rY8klyLHEnrmWZWP1D58SRYCJSsWmjrWWPOtMkbagvs5Yp7NJbn2x7P9dF
         mx2uOMMNKL2Wd22alKJTUXMuEkZGLCwZUkZlqS0PGGX2BnjTiC5AcTPxMHCNor2CxQ2G
         H/czsEmUJ8ReZtsnsx7G9fl7nZwln8rc6GUs1svThCqoEPXP71UjpJoTdHSGJp27rdYi
         1Q84/EcF/OpeLCqDmAYTbx51ri2T1LQr8u2DFSG7e0/7nNOnT5iWlPporQhS6/EQfGz4
         TX2GL+IcGVfUcn4FHwptFz6cFW9lWE+RfIbOLG+6P4IHYRxW835NAuCbvjQ+jEoJjLMW
         QxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pLeu4YqgZECtiedNQxbKwtzen0HMS5vwbUNTX6n4u0=;
        fh=uQLvBubTDknziv/DpHsSPjZbmjBY+BuGfpCQuXllkXI=;
        b=YICow+WC3XKGxg0DxjXUBh3tC13S91bSahgd7r+A4B/EPU79H1Pnaj5zZ2KZ/Eh7iD
         JfmJlFHY0s0QdVsOHqtuS5ZT0fZaO0//2bRP/GloXPY+UDuoeshNSufewkxiSX2s876g
         3TaveRVehH8STnGsHe6kNj1pbJB0lx5eAHvFpF1Lcvp6qxiDQZOX1pXxUPgMAqY2Ufes
         fMf+ssYlPZ3xQadgZcatiHKu0CJ546OJil6jz/rvhRoEThniF1zPDH18Mwlhz1ddMKct
         XfKmqK5MwQ9i+UgfmFd9MKr0NkHetQCZ8llX1942oJ8skVKHoDdUH2S4n0b9Sd3JjSuz
         dyqQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790644552; x=1791249352; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pLeu4YqgZECtiedNQxbKwtzen0HMS5vwbUNTX6n4u0=;
        b=PBhsKbqwotq3i4DcY1IGXPPBuVei7UqVlHNz0lI5sYRfelcRZ5wtIeCzhLKrlMCD00
         4aE7bMk3KpCZ3Ze/3qYgA9oW5kzq8Fc1wjNsgsPTqvxc7lScoVa/GlieuYt9YTQfUYAg
         LSnwYtxYCQs42RfNKPb8koAvHXO6DRRqzDFAxcu89StdU+fpu+2HcS5iio6rttUxrBMK
         uBpeNCZxLh7lrH+xNbW8IWeGMVB9o487CLB9ebjCMEGg3MBAtE7pPQZl/AsLd3WTZo76
         8aDZsybV5Mt4kx4s+WpiQhS+HW7FmO7Dx86wWFZf4fElgrFG21UqyUuu6g65tX4GEuoM
         Fwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790644552; x=1791249352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pLeu4YqgZECtiedNQxbKwtzen0HMS5vwbUNTX6n4u0=;
        b=0/S8hB0iYazzl3GT40YKaJpRg7Q+HePSKWiYHASyFdWkcuEtio2JMb4lNBqRpz4u8n
         Lq9TItNm4WnwmuEuV97B4MXZnVyZ+Iznh639O4vu8i0ojHAxFUgLRUzgL/AbF5+Z6xfr
         n5NfUUP8qRhwfe5EPRdMjUgmv2nuEIto8aPKXC73taeSUyQ5oFRasSXN7U7FM63l8Y8+
         2Fj+VGm8irzUiRs4ooScCJNEEismLFrs5V7aEAIynC/SSV1QYnSAerOJmfiwZ8sYa76z
         UoPr4b1h49lRChLLEx2ydqdtcuFD8aBoYfABkli9gTzcTafaJvrwVphP4OOdeqQusVmC
         C4RA==
X-Forwarded-Encrypted: i=1; AKwUvByz01b5PvJYkUJwr/eikid7XQKK6TtUQezvpEHjbiQfgsmuyU9gvi0w0iw+OS+cjJdYU+D/ERfGtqkK@lists.infradead.org
X-Gm-Message-State: AFq9FYKQIto7tC7PRlZ42WQMtKax9C020a2QNlJICCcUPkCphxtsUUGg
	B5w5pcdeUUWqyTsZwYurKKjGvAgUnERFXODAaGwwg8JgvfWOLArQ/pvs41XhpaSG/QHf1gWtwzP
	5c768a6qGSEi2cFVmzz7BIrsjFDX0O8mDJHX/ktClAA==
X-Gm-Gg: AYBFou0bGowK8Q+/A7QAJCsAbfHjT3iO18Cp+QF57iYjIPBnI4Esog9W68fE2owPb3c
	uFJSA6AKVSdjPGxBUUZ8X/F2m+KNOQeBLq6skMQ3A5OwNH3mfKR3/6wdGk7YCPKlkEY0N1XTH8K
	ZLaXUafqskzIEAfuPbn1XziXnRB1zvFbV1ejt5xQ942kMOzRYXNFkwNRJPCx8Ho73wp9oyRPttv
	rLAdNhuHwW4M/XOgxDn+eFhxySzomkjksuyUenj1qTi+CafoNAfsshhYLusyKFY8oz/5gVAJFeD
	N1SIH58gbEPIZkqU/rBGPGdtCsUNoev1cllXFV2E3pnRN1zFz44f9A0=
X-Received: by 2002:a05:6870:f114:b0:47d:4630:5998 with SMTP id
 586e51a60fabf-4930a82b841mr16313646fac.4.1790644552340; Mon, 28 Sep 2026
 18:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260909222836.2475352-1-csander@purestorage.com>
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Sep 2026 18:15:41 -0700
X-Gm-Features: AclHuK9y1BkUmfj2CwBKzqVvJvr4htN1Ij_BtBFRlnLw9fnPEz3avSjdBXHF6AQ
Message-ID: <CADUfDZorm3WsYxvKQkqr1DVAps=ejF7M4U5PLD4O-94GzmYt1g@mail.gmail.com>
Subject: Re: [PATCH 0/6] io_uring/nvme: support fixed buffer for metadata
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_181554_324404_978E0387 
X-CRM114-Status: GOOD (  28.58  )
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

Hi, any feedback on this series?

On a 4 KB io_uring NVMe passthru read workload with metadata, we
measure 14% of the CPU time spent under iov_iter_extract_pages()
(called from bio_integrity_map_user()) and bio_integrity_unmap_user().
Using io_uring registered buffers for the metadata avoids this
significant overhead.

Thanks,
Caleb

On Wed, Sep 9, 2026 at 3:29=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> io_uring NVMe passthrough supports using a "fixed" (registered) buffer
> for data, but not metadata. On high-IOPS workloads, the pinning and
> unpinning overhead for the metadata pages is significant and could be
> avoided if fixed metadata buffers were supported.
>
> This patch series adds the necessary plumbing to allow NVMe passthrough
> commands to use fixed buffers for their metadata. The metadata and data
> fixed buffer indices can be specified (or omitted) independently.
> Supporting separate fixed buffers is important as metadata buffers are
> often stored in separate memory from the corresponding data buffers. For
> ublk zero-copy I/Os, sharing a buffer index would be impossible as the
> data buffer is a kernel registered buffer while the metadata buffer is a
> userspace registered buffer.
>
> My main question is which layer the metadata fixed buffer should belong
> to: core io_uring, io_uring_cmd, or NVMe passthrough? In this initial
> implementation, the io_uring_cmd layer stores the metadata buffer node
> and the NVMe passthrough layer defines the UAPI.
>
> The main argument for moving the implementation to a more generic layer
> would be to reuse it for other io_uring request types. For example,
> IORING_RW_ATTR_FLAG_PI could also benefit from a fixed metadata buffer
> option, though this series doesn't implement it yet.
>
> On the other hand, core io_uring_sqe and io_kiocb space is very limited,
> so it may be undesirable to dedicate it for a somewhat niche use case.
> The metadata buffer node storage could be pushed to the NVMe passthrough
> layer after my in-flight series [1] to reclaim nvme_uring_cmd_pdu space.
> However, managing request-scoped resources from a ->uring_cmd()
> implementation is a pain, as the same request can call ->uring_cmd()
> multiple times and may or may not complete when ->uring_cmd() returns,
> depending on the ->uring_cmd() return value. io_req_uring_cleanup(), in
> contrast, provides a single cleanup path for all uring_cmds.
>
> [1]: https://lore.kernel.org/io-uring/20260909155848.2069290-1-csander@pu=
restorage.com/T/
>
> Caleb Sander Mateos (6):
>   bio-integrity: remove dead bio_integrity_copy_user() error path
>   nvme/ioctl: remove struct nvme_uring_data
>   blk-integrity: pass iov_iter to blk_rq_integrity_map_user()
>   nvme/ioctl: pass iov_iter to nvme_map_user_request()
>   io_uring/cmd: support fixed buffer for metadata
>   nvme/ioctl: support fixed buffer for metadata
>
>  block/bio-integrity.c           | 51 ++++++++++--------
>  block/blk-integrity.c           |  7 +--
>  drivers/nvme/host/ioctl.c       | 91 +++++++++++++++++++--------------
>  include/linux/bio-integrity.h   |  1 +
>  include/linux/blk-integrity.h   |  6 +--
>  include/linux/io_uring/cmd.h    | 12 ++++-
>  include/uapi/linux/nvme_ioctl.h |  5 +-
>  io_uring/rsrc.c                 | 28 ++++------
>  io_uring/rsrc.h                 | 17 ++++++
>  io_uring/uring_cmd.c            | 30 ++++++++++-
>  10 files changed, 160 insertions(+), 88 deletions(-)
>
> --
> 2.55.0
>

