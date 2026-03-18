Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649D6FD8779
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 00:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zyk4gA0DbxFLS3vhGRrLRfM6spOnrF/9lDtrQsrBl/g=; b=2wJ5hNmpE5RCD1pIj03qQv/JNy
	inirv3Q3Vh8dXcsUgYvPGmc1KnSICWP8vq+K8h6f2jbFynXa3UWi64gMSvVigSKoLXhC8hqa2trWp
	BXMRB0k7ws/saZ+5Gws9zq4YrkgZTD3O6rbbmMxvzdrUSkPI6TXBmxI5sMBhszQd/Z43mIOrZRnOi
	PNAoQZS+Schk8vInaqoBPRiCxC7t/VgNhEiYxy5nUaRFKhUX8sUxDwgvYNaoexaFlbbatby7OPDzt
	PHAfa3Zj9jf/59c+8eiQi8emrNe6LjdgdZvWznThoPzpHwW0S3T/J0mUbPP40RZWUn5GzDIWOrdjw
	qB3jYnaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2f4J-00000007WSR-1Y2I;
	Wed, 18 Mar 2026 00:47:27 +0000
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2f4H-00000007WRR-0r6x
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 00:47:26 +0000
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-417a84c5c2fso404333fac.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Mar 2026 17:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773794841; cv=none;
        d=google.com; s=arc-20240605;
        b=D/6PBAsy/oHmlOMGBFrRPl0C27a8lhk3JkJF8YhaEdef08NQLuMz/1F9HJ59q1HOCt
         jT2U+SDJlV4L3Bb73yrjxgu4gLwqjGUCIg/8Yvi0T48du9hwvF0uKswcimirZpoGPx+w
         cOAOXpmHfQGNLpyU3kEkGfb0J8LquYFvRn4bkAL3TJtnDaHQac4MTTZ9hb8rDKx5QlQW
         nFU7ccs2jFhaudtSG/WNp33+U5T3MnGtkvTtb8+8QC4Nt2PdA6+gcT9CTGlbnBVbfpbC
         Iab3pPlDMISMC0lY3KT5A+ygvxGCNgSx7g06Lg/uegvNDT0j5gJ28iRnIxh1cbE2+1ls
         xFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zyk4gA0DbxFLS3vhGRrLRfM6spOnrF/9lDtrQsrBl/g=;
        fh=IL/b2Qq3YuHZCNWRTXZRjevRtAdrgB14XWjqDJYYfjM=;
        b=YVnVjJDSxGhbmJQEZhN6ZaXwRc7ncIw5aiRBzZBgc+WdMjXZxyeGVniTKdvW6Fscie
         pNLfc7mPnQl40P0jqoa0jYw+76TuIzev/vHG1TibM69kmliJrpuCUX35T9Xa+vh4tL7I
         AinKbyEKyuGW77mA6GYq8WkxbBvx0n1X4oDeNedx2/IxcIZvZ6AtCYtniMGM+a2KpOqv
         v9o8MKTJYI3qndg617ZeZxmXV0r6LTYagIXT3JdA/DQdLxm4QSnGqni5Qz1fpEJ7c6C6
         A7AmtLpeFypK6/Phn6/Gm3JEPcOKXpnsN3Q6JfBud50S049+TEquFpi+h39F3cjxZnrO
         W26A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773794841; x=1774399641; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyk4gA0DbxFLS3vhGRrLRfM6spOnrF/9lDtrQsrBl/g=;
        b=Cll18JINSgK45xWKTd8QjycRJqXzhlIHru96ll/+E6/3AX286H/cncLAt2BhAzT0gc
         25fehxB7XfgVpIwmVdFEv2rMpjbC/mEK2bq6kiguUZYWhVofOEz4ZLHBx5Gz7DQpK5L2
         Ddpz/4L5szEO2MxNa+kDL6ZJjsDqx3x0xGS7sR9xR4Yen/EBqYwiIaLCIS6sXJ5PX33i
         QwKnpysnAC9Stt64WGR+CC8IMnmV619rWh07shGHWQTCtiDVtv1bjXdgpmb2wIHxluKo
         0sI1STTQ2ItQFYSS0084Ujb5JGrhaCbs4Ehj9/XdUCa4ROPySdJnIq9mqP/GhOeBiHHI
         ed4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773794841; x=1774399641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyk4gA0DbxFLS3vhGRrLRfM6spOnrF/9lDtrQsrBl/g=;
        b=YMAH1gDPtDX1Yx0Nz3ZHNqvifU0QLr15iptqYX0xHYAyzw8mPyi0pcST4g0hWxs/Pc
         8gnSMRczADUo2wjzlX7KDSKZ3fznJJXYFe9RFelr1C1EaUOpHNODl/wrnAjUP/8oGGqA
         zZZyHL/ivKsSqZZfcl515HPaOoq1c64dnx2vBjqiAmKX2xB6onGHsrwj6Fx26NMg9QMh
         IpVbwbEurw+BC/t7BxRlyLopST/o1i9sGXnnh6CvB/SibVgJpb+bhaTqa118oD7aXiRj
         CIMl94SE7I72E+laToRROtMdLQsgqWTd0OBKjN52ohCJaZzQzp+/aF4D52/TbpECtgrB
         b2+g==
X-Forwarded-Encrypted: i=1; AJvYcCVBIDf0+CCTrd54PhwlB82NySvB7k/8yPR1/YCDsPtgQ35odX9NyN/4Xz5sgDuwaRnjQ+c11yfUnjyB@lists.infradead.org
X-Gm-Message-State: AOJu0YzapjmdnCZsNWwq6+qINkNkQNoCPRbdqavoBbaOK0lh3Lg9m1vz
	5SKyZOM50MufX9D82FjL9K14AOnBnMmyP6nuAGy5fLPsozF5oxv9HT5KCWyJ61LMRiFLyJFRCad
	IKoMmdgU/hD3C5IHdzfPcJbCDBCCv34AiV0KeDizSjg==
X-Gm-Gg: ATEYQzydJVOfqD3ZTvP5tEnDECgTmrooLk5wVK0Wgmh2IOMCfMY4uRpsKYu0hWnJrXD
	aFHFy/jewvuqbxNVVisRi05U8ARTBFX7Qzy1H6Qwba6Ge5w/Q8NitDZKdJW+yET8jqBkYXoDMl1
	NJ5rJbol4DYr3T2AgibqdjyV04F+TSBf30ejv3f4SC8DU4bKdxMgsn3H94pynEHAxmJcJ/ntUAW
	XjTtixQyQGTWQHHApJY5o4Bv6XGbkaYMzKL7y0wktdfY4Q5YC1mKq50An0IvWamH25+buLMwZe0
	N1Jhtrgs
X-Received: by 2002:a05:6830:438b:b0:7d7:664c:7114 with SMTP id
 46e09a7af769-7d7ca6776f6mr1004746a34.4.1773794840750; Tue, 17 Mar 2026
 17:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260302172914.2488599-1-csander@purestorage.com>
 <177369928494.700746.8101380068186003544.b4-ty@kernel.dk> <307e4126-91ed-4ca8-9eb0-3f24f1490aa8@kernel.dk>
In-Reply-To: <307e4126-91ed-4ca8-9eb0-3f24f1490aa8@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 17 Mar 2026 17:47:08 -0700
X-Gm-Features: AaiRm50fXeMnnwNEqTWQp199CEE9NlmeVQCNSmHF--sYgGOecuoeLi0cfofOaFs
Message-ID: <CADUfDZp-Fq4TAdOcvjwSO4G3sZzekzVsyT_yMsoC9D-2=5aLyw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_174725_364715_FFF52D0A 
X-CRM114-Status: GOOD (  15.24  )
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

On Mon, Mar 16, 2026 at 6:01=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/16/26 4:14 PM, Jens Axboe wrote:
> >
> > On Mon, 02 Mar 2026 10:29:09 -0700, Caleb Sander Mateos wrote:
> >> Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> >> requests issued to it to support iopoll. This prevents, for example,
> >> using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> >> zero-copy buffer registrations are performed using a uring_cmd. There'=
s
> >> no technical reason why these non-iopoll uring_cmds can't be supported=
.
> >> They will either complete synchronously or via an external mechanism
> >> that calls io_uring_cmd_done(), io_uring_cmd_post_mshot_cqe32(), or
> >> io_uring_mshot_cmd_post_cqe(), so they don't need to be polled.
> >>
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/5] io_uring: add REQ_F_IOPOLL
> >       commit: 9165dc4fa969b64c2d4396ee4e1546a719978dd1
> > [2/5] io_uring: remove iopoll_queue from struct io_issue_def
> >       commit: 7995be40deb3ab8b5df7bdf0621f33aa546aefa7
> > [3/5] io_uring: count CQEs in io_iopoll_check()
> >       commit: 3a5e96d47f7ea37fb6adf37882eec1521f8ca75e
> > [4/5] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOL=
L
> >       commit: 23475637b0c47e5028817c9fd4dabe8f7409ca6c
> > [5/5] nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check
> >       commit: f144dbac4b177cfd026e417ab98da518ff3372cb
>
> Caleb, want to send the liburing tests and documentation updates too?

Sure. What type of file do you recommend using for non-iopoll
uring_cmds? Most of them seem to have relatively specific hardware
(e.g. blkdev_uring_cmd, nvme_dev_uring_cmd) or kernel configuration
(e.g. ublk_ch_uring_cmd, io_mock_cmd) requirements, as well as
requiring elevated permissions. Maybe io_uring_cmd_sock would be the
most general?

Best,
Caleb

