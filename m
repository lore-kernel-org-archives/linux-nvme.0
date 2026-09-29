Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D47CA5FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=; b=X/v9CtiCXfa1/U5Cpcrd4gUOWf
	8+fIeXNKk9uU7kxAaVFj7VuHKAiar46Yxl/yKnocxjUYqEtCgFWU8fmTVGbm9CpICeYTynb8cBw/m
	p4dkO1IsoxFcfxEOUF/2NeXWvSInbbpUnzZTIfdOaOqsRg686c9QyDFKxvnUnfuKhrqF2roM3I36I
	YrLxa4AI66PxTXArux6o81VWiGXCpz00I9QINMAnKEeMU8BfiVVElOWuvL5UdD5pC/A+hoVP9gAwB
	xQakrOpkj00aqWtVeTrgv/gN25nVZQL+IQGG5dg/lrWW38Zu6D/UB1uIfdWfJq1rV/iz613wk87P+
	HSj3QguA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7j-00000002jcV-3GOT;
	Tue, 29 Sep 2026 08:23:39 +0000
Received: from mail-qv2-x11.google.com ([2607:f8b0:4864:33::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBSIn-00000002cd4-0oRC
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 07:31:02 +0000
Received: by mail-qv2-x11.google.com with SMTP id 6a1803df08f44-90cdfcb5cb1so46894916d6.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2026 00:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790667059; cv=none;
        d=google.com; s=arc-20260327;
        b=MheK2ZYJgCeEsFmCvl+AFq6laDyzsRe48DNyXNz0GFwN77GKiHmwv2easkIMY3t4NY
         2TH+J7m5MGLmVT4lQKMIas+9OtWp1y2hxR014QM7srPwcS5K6UggdvRqoZ9NPFaUMH2E
         M1dKXCTbwpCc1qNQrGVSz04f0JJHGVIZKvZzOWvIk8VpHUN3DPniWeQKGsEyjPXo8lx8
         yDsaS68oglTQjftYz+Gi/Mey0o5fWF/33kZ9Daz+4TM21I6JEinBttvMhLCmYkVkwNx4
         QauB8uXaThHvayZiE3RiPFp3jYrzd6MMCKcHXqavWXUvX5fqlOgPIHgK7FkDIqUiuIvc
         JAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        fh=X1HWXEqx1UewLsh2wiicZ0QuJmIN6uOt97EOxKQGidU=;
        b=O4JgyItHCc8Ws7eunjZgmhaC2MbeUIcdL55GeN6toPjlNBdR3JaS/1lbrLczzd2+3x
         QmUF1MR5jhns2j9YoYlW+ejsYglHD8G9BgIeUPX8keIqK58xlUPLkdfKvrctvpUX1Nvu
         3p40a6JVhelW4H6j//PEpO9ZdyofdUtgIUJuqGwHAfc0kkmoXpSdskvomedtWPux7dK8
         KPTGBzf5mgcBB6vrC9kEA8uG3MUIQT4xFZplyvKSe6NvdciLlFh5oBhY0jvoaII3tk1z
         H3+SpxuR5zMMh9WOTnTwbG9x3lS8ahUN8fzTsJeyIMjvo1s+nzE33qOU7R27/yXdz38k
         lnPw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790667059; x=1791271859; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=b3ZcSGGdelTFt1YScz5hV8vCohwwslvlxfJY58WN55Kef8h49zuW0mnum6CSbXCPR9
         W8vuD8LiqCmi4t/i2hpGP+66CGLgLbzQR6Z0x44eRDszcnn/p21izq+IWk96v5+zMUdo
         16IhCDPJZGsM2MKr4cDmNWssy8cTL3ulzBC/FUpIKMYLbUzcfMNtoPWxEzNdDnJXGnFv
         yVaFAzRIQSWBIiGB+QirM9cbUW0Lkc9PG4c3H/Qdbricux6bqscmlm8Hh4psF4D0ZqB1
         ZXztdS3ogU89Dyy2OOlR7xKr6iykDjwnQ9dof8IHU0IPS8smIXhDaBlDNiCuE+X114Oj
         AxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667059; x=1791271859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=K46mK7gimG6gWiKuYVPiQniSNB7rL3sGMjL90TFxTIb6AnXa1g4TPYFNUAv/f7k6Jz
         I7AHpDhAVkxJJjuos+/SOxFLF9wmh7giwFHMOmb0Rp1XdNvbA+ApKMjtANP89Cob5e4J
         FfH5qDysCrfXGRZtCUkm0vVMa/mxRgJtFUr/5wgEm31hZQluAQzI40N8sNKBNK4w4Y8C
         GmfISOUDleVyQrgdHVzSOcv7y9nBHjU5DVUhhBS/82Ee/SnqKBshn/wB2YoRedo5tS4Z
         O3NoYK6/dTLK+3jxQpsBRTTapltATWZU2RbQb1v4ajaDEZGyGCGAn3eyzgYxK8EnllHA
         sM4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwBrEdkHDbF80B8stNzyUMwqvd+Iy65N8y8ucrJlEKiikMzYLd+LmwUFGHg0bx3lJPH8+sr11Omza9K@lists.infradead.org
X-Gm-Message-State: AFuF++kRu+BcOgZyos9bt9sX+haK81C3JYdA+wo3IcbaOn2YfDicWyH5
	IcYGRflT0A/3797DZqeIWlzwKoqzJUVFnTi0P6WsN1VMAkUwloYlVNXuVMluj69txjce3Z3/qtw
	aKgA8iSSF4VUyPrcMj3lKLcIPib97lMHvER6lkBJ4
X-Gm-Gg: AYBFou23dh0+mdFFZ5vqXivnHmuT+EgPxrD5AYQuSGwMQjIplHYhM3o4NkZw8/nPKsM
	LkW8YMDOhj1Ptc4UxSTURv3kDHRmlLj9Nk/K7SbIiHDMQpaciVdRQRa0FMPk/SenIcGaqD6wqgH
	8L54I+KpTywlyYV/wqabiJ8y7rjkriT5WeEAO+6W++IchNQFS7W5Vg00I+3yV80Pg/XkOEMK2df
	poH3ffBGXBkbikP6GSd2BZZv+cnoXR4qaRYSbGg7z14WPNKZ/WSaQRN7RSQEosEaslR5LjgXD/a
	pJ7CbW31Co7zXoDtUrOcaGcW5hXZ1IH0nXwALnx+gcPsRm5WXdrCMjrutetg+0z/QRDj5F5FDub
	9uYySFFWNdwwlvo6Lf7Ng5hsYAsnU0rqZcg1GjOyI/bTDtJM0/lHTOCdYMKlWzuJx0T6D
X-Received: by 2002:a05:622a:580a:b0:532:d3c2:165c with SMTP id
 d75a77b69052e-5330dbe7682mr252226541cf.5.1790667058017; Tue, 29 Sep 2026
 00:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260929071743.23624-1-edumazet@kernel.org> <179066667444.31693.3326934466907750947@kernel.org>
In-Reply-To: <179066667444.31693.3326934466907750947@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Sep 2026 09:30:46 +0200
X-Gm-Features: AclHuK9CAnCUx8smImHilXsTcocuUN-fbbX48CMDJnYU9QbhFatMhZFb2tpvc_0
Message-ID: <CANn89iLUKHZVrUOEtqDwuAghCRAkddigPwSWj4uS=fKyWdk86g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/9] tcp: avoid struct socket cache line miss
 in tcp_check_space()
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, 
	Wen Gu <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-nvme@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_003101_250419_FAAE103C 
X-CRM114-Status: GOOD (  19.66  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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

On Tue, Sep 29, 2026 at 9:24=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>

Patch 1/9 fixes a bug found by code inspection.

Other patches are not bug fixes.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

