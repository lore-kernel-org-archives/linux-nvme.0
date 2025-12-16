Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7C9D5B161
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 03:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mYkM7ChDobuz6+UKi1Gzhfiq4lvRZrzGNb6NVDjbMWs=; b=0Algu4VgTJD4hQX1i8ammgDO+W
	JWQ3wBEK0Af9GYOzOuoNFvWhIgF3w1RvBn+sVt9mdn0jvhJYLJTArF0SKhRtdXp2gLzOjkdFrSBWS
	EfmN6Wlh2p4q0fpGGymDbGzL8mOrGE2JI80cf7hQxZ8wzTI1tjWoESbh+hC1FIyBFPFMJOMUSubGH
	pqdmjBPnPvECGvxF9v+bZOu4OhsGy0qXLweO1+AwjCxzwI7m09PisfctmfvN95hLZK6xIxkE4vt5S
	Cn+mYT2rxsy+jG6u4XnOxdTFeBuabFz0qpykJczOjRnfYau1plCKphEPNXt02aOsEHqcR+exGw9sg
	CnyF0dyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLmq-00000004d4X-1B0o;
	Tue, 16 Dec 2025 03:31:44 +0000
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLmm-00000004d4B-2Ycg
	for linux-nvme@lists.infradead.org;
	Tue, 16 Dec 2025 03:31:41 +0000
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-5dfa9bfa9c7so3027611137.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Dec 2025 19:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765855899; x=1766460699; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYkM7ChDobuz6+UKi1Gzhfiq4lvRZrzGNb6NVDjbMWs=;
        b=NgBW8CjLbR/9IoA4XOgefYOFY7Wev7Xc/nK+jJmJPSmihe84wZTgbOuEKMkKHN10Az
         j/C2e4oIBmdp+GAgByrdFLYj3KLtG7yRZEZlIRZ3zl+yRRlCgN9LDR2h5K6iLbbmP19G
         FFkLGrbrGrYK8zkf5JgKb9VAWrO+DvfzuY75hsV2Lr4lnJR64EtyNh3g3DdHWav6lvur
         398HXFCS3YmuouNbt8ikvTLQaNcVjKawNF04X02SN9+1fVQTvjUEttOvlFdvAWYwuAfc
         TWNaL9doTM2r1b+Gt0189WJBmaGDxPxMVxQ+pVx/JxMt3PgpV3oWMV/uSrjSBScn8Ya6
         FgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765855899; x=1766460699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mYkM7ChDobuz6+UKi1Gzhfiq4lvRZrzGNb6NVDjbMWs=;
        b=wzvllHy5FENveVabRGE3DzgOaMbohKEt2fbrz6zE+KbziShFKSF/Y7HEwTT0ZNcCjj
         XQofVqBGCIIz/2nbd2QIEIjaM7neF/mTXCHYohoTRmGsQpsPjlrTvLquX869U1m1aInk
         UiFMwdF4/RoFv6oGwlw8FszMEdr1K9PFHAe6pMX1Ddd+nneWmZdrBTqyvbcleLgfhGI0
         HdqCKtvlGBcBytbPZzccFVKs4DWOFg4FPn1DKa2KkEc8Op6M6N9ZvZb/+fxqHoqFdsNB
         rFQnrYUvbprrvsDDct4QKHWJR84bOABF4oGGdNSAQhDgg5W7nXmxwYmDvS8sVFIlFiSW
         NzBA==
X-Forwarded-Encrypted: i=1; AJvYcCVv3S2iFgaAay2wLEuwzKSzchKKsq6LlXdpzJHxUrvgh0W4YJM3JNTHzsG1pTXjkRWN6TRwj6fwU4PC@lists.infradead.org
X-Gm-Message-State: AOJu0YxYBxgLPG5hrof9XvgGdZBC7vH7q6zNHEQujQXoRCax5IHgwNGu
	ecDZzYs2WroKaCQOXhpYuE7hZAzd0TaCyg6TMbcqosVBu4wa5EPF6wwqP4Qk7vrQwJO3SBOQirG
	/dcwX9gdDESI7R2AsiT0p9p+sEbfEOb2w4n9+yahWfA==
X-Gm-Gg: AY/fxX7i3MJnn700pS2DLxoM9hKQOK8G2MjKl78DbxpGHm0DqFu0CQ7qZdVdzYFZdW4
	wOL+pqKAbV0oOwQUBHHjbGkeLaXtbMHBgAc0L1XfH2izXr1pifA258NAkOMwm8WVUEzvrje4/3z
	oS5w69lo9zENJFrfCINbfTElMrvkZhXxK6KMoJaRQRnZ1AFjW/leYdeF1cMktlTntfRv8g3pwOK
	BXnKI4f/f5VeHi3A2u+Zj1x1gm4wjN62a6r9ngWY9MrK+1n2chaNObK+vmPr/2+17ZGK9k=
X-Google-Smtp-Source: AGHT+IHaalmn78dhTh86kqWml+wV89K5l2y8egDLEJIgBEFuXKNAkSLcy8KhEA1IbMVsqB4/oIS8kfJsRIeoQnfER7w=
X-Received: by 2002:a05:6102:5111:b0:5db:d2b7:9518 with SMTP id
 ada2fe7eead31-5e8277e7185mr5328816137.34.1765855899409; Mon, 15 Dec 2025
 19:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-6-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-6-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 15 Dec 2025 19:31:27 -0800
X-Gm-Features: AQt7F2pfORgH-XA59Y41UMye1zb8yk-Sw9SEhBPzAfAd4yIGxXInCYCaA6Cnj1I
Message-ID: <CAPpK+O3Rrb2Lk8B12VMUydcvOYCPYdK07Sn9DoBKQ6w3pXOJ8w@mail.gmail.com>
Subject: Re: [RFC PATCH 05/14] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_193140_646962_93B84482 
X-CRM114-Status: UNSURE (   7.82  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Send an AEN to initiator when impacted controller exists. The
> notification points to CCR log page that initiator can read to check
> which CCR operation completed.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

