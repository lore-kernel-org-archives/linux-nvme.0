Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78647E9D80D
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 19:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCdiIRO1XmbFYiWnydomnVIw0bBgHYPUnadUZKk4FQQ=; b=GmihQRwNCVyci5BhtLT/eYJXRw
	STBW2AeUpgg4LcFIeHq19yqcJrml73ed6f3+7ckdUHNfiie3QLI+xS6HkIfaNWY5Vld4WXx2H3xXg
	3OAMlMpVLrmvKyUxPBTdJLSuAIRAewBlKzHWi63JVR01esKE1xDqfrOupzxokCIer+W7Yf1V47inx
	5ogJXFEPpC2nafRgDiY7q3ygQ16JZITGZRCby+AWlzmwPDl+3jVny/9FLKr4GaRjIq2aGRMI7uarR
	odLIKzIjp5OGWeUCoAHR0RXzq8gIBdGSjLkDIsiTuu/8qY8G3v8TjbMtHvU8ryNA3z9vs/zWPgwOG
	3xRuHY7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9TQT-00000004Rad-0Kjw;
	Sun, 05 Apr 2026 19:46:29 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9TQQ-00000004RaE-3ahC
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 19:46:27 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso3575071f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 12:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775418384; cv=none;
        d=google.com; s=arc-20240605;
        b=TXVMmfAQYcn1MHn/j7fk8fKo9x+TxeHM230wuhVmXiFRriEgXNNRXulaT76Id3HaKc
         kG3e7X51Sivi/iNXpcR292KFcg9lVyb2zpHh9FG7GN1b+ppQ4qreRw84ZLdBt6nTSVgx
         VK2bcy7c/TR5ietDbU8ybhzIxWNhQ0ot1K3W4bOn9KhqP+uLKvGOFcaRj2PdYngxgJcg
         WJwdZmrJtjfRMA11Rn3GADxPBcdZg6Gcqpri8UvQGPHykbOLCV/wUh7btUvA4PPAKufk
         FbKWCJTazk5ZQIkqWZ3RPrW9dfvTcmXwj3alrPeBZuXP4AEO6EKqolWD7y3yPIyf0efL
         eZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hCdiIRO1XmbFYiWnydomnVIw0bBgHYPUnadUZKk4FQQ=;
        fh=2bgkBJbUjz2QNGzBJWjjp81MZp8luVsLH6vYWESgegY=;
        b=KLyoKoIxTaPXTjleeBj4EMhQyHDWvgV84XqW7X1rxC5pXhGevmmSQB9TB1qAHNHJqR
         6ipM7J1n3xxsZ+EM7k6YNkG5ZykHPxaAN3xVmWzeHsC7be3XzgZl+j0SMfpefy4LZPO3
         0alfYUdreB0KPofJi7CRRBxrDHR6CvQHq43wuYo4vLuypkUdClvzSm8kkubPYXZ5641V
         PiDT8Y+2hONd/lTGqECCfTKybN6nXmr8J/snD/OdgjN6HH1MndtyjOeyUyn2OFd4kFs1
         KLr/gJRK4+nks9CHdG2eT7CR9c288/ePjiIPxyJL6Uc517yf8nfdApwfE0F32LLpePta
         rw+g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775418384; x=1776023184; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCdiIRO1XmbFYiWnydomnVIw0bBgHYPUnadUZKk4FQQ=;
        b=qh9ox1Nm+wXLrSH6PDwh9PsTXDjcv6/8HPXXu6DLVBOAdYjAeif7WZYR0lluhg1K4a
         UECcT88UYpM5nw5B0/UHBQeOJHBq6fyWEMby1PcDgGUu9m8YsMJeDbtSYxHW4anplZq/
         9B6Zm0dbL/D1aGyhkxUyypqMtoNy1f3f81p71NXKrS8Uqigipeqj9SfztV44ADAdyEc+
         OiPjxT07Jy6LRUapxP6CC3zQyiBFczWz7kVgJM1mNwO0gKqgja5XykkJKpcg6Axy0/RL
         pPHD9wzfXVTS+U5XEUDGDowzs5YyWydfQ/zLGD8kFwFHtXsZ0GTkdHYhOJfqnuDEqxBA
         N6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775418384; x=1776023184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCdiIRO1XmbFYiWnydomnVIw0bBgHYPUnadUZKk4FQQ=;
        b=L6LFTmE9+K/gtLkWErIo2MsDBEkMu0TJb6b8VOswcKHUcbTlh1plT7TIHqQCYdixAx
         4anlfOA3HlZbyt/lljuE0YY15ByQ6zB+kK0dmIPelB98zjtVCJIcC5A5Ez6WE5VtPS9z
         SB2iK3wXAttNThNRKoCrzmVRgm+jsn6wWp3bZj4xqwe8+s2HuIVe75ZjacVU9uUpP8Kk
         ZKQ7GgQS+8K4A0RTfDcJFcZd2iTUoRDGRZ0F+ouLftidfDbp/tv5B5y3WjhEvAbp+y8d
         qNXVxykMlAtCE+B4l+nhvdYSmczAJ4g0WO3kvve2cYHQpGPvf+dc17jlrFrwHLnCXomu
         ohUA==
X-Forwarded-Encrypted: i=1; AJvYcCW5ldoYXOjX2qIXUaDMCEbUBjmmIWS+tho8rSeB2N3s7mu2e/exhYWBvPoM1LY6X+j08kM747dSp739@lists.infradead.org
X-Gm-Message-State: AOJu0YyhOBEz9HLXtTMEfr7UE2ygJ9F0ngC2EY/QIxe5Z3CitoFhzK/D
	EMiFW9Y29p6g6Ht4bybRNiV6xrRCAsR2EKYWz+fj+2zONg0J/XvV1zmlYSmzMs+rIJ+Nglcu5ZM
	rpvmLlC9mfVHBsKiUgRC1nhnN89aN6Pc=
X-Gm-Gg: AeBDieuQyD1hWsj+47+TqJZIeBD+nh1tsxXCX361NIW2DxATXq8/a76MfsYdX77geiH
	2L8bhLgAK0P/EoQkJsor5tkZUijtaCZNjqzn91f7leILnuEFzoaBK26BusiF2Wy6nOOUfdK+VsD
	7lM68YaRnW1EqXMBciMjHXv4pYYarpVoqRWiooP2ixnWBX1NPCidExB4xWFSX34Xy7Og65OEGfk
	cd0vH0zVhsNr9szugiNhAa9kjg6xobDZstKNKNEL+727U7/WIhw260bnbqC9zA8bEeoqRdFKWyt
	/nhiOQ==
X-Received: by 2002:a5d:5f86:0:b0:43d:61d:382d with SMTP id
 ffacd0b85a97d-43d292a901cmr15367127f8f.22.1775418384124; Sun, 05 Apr 2026
 12:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <2026031805-stretch-skid-ae5b@gregkh> <20260319012630.1802025-1-kumar.shivam43666@gmail.com>
 <DH6LLP692EBM.4N82LTNB60WV@arkamax.eu> <CA+ysrSLau_52n+4JMvQ=EtqY-cyWhhZ_pLOyeNL=mwkjkNvoUw@mail.gmail.com>
 <20260320074825.GB14485@lst.de>
In-Reply-To: <20260320074825.GB14485@lst.de>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Sun, 5 Apr 2026 15:46:12 -0400
X-Gm-Features: AQROBzCusOQ3LKw68Iuv16r_pKhcRmsAkpeQR0YiIi431BxTmScKIghbt7qXNcY
Message-ID: <CA+ysrS+9bWdF1LvxoZaZW_JLZ97H-RXM548Cm8ZW5KQAD+NCLw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: bound sgl->length check in nvmet_tcp_map_data()
To: Christoph Hellwig <hch@lst.de>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>, gregkh@linuxfoundation.org, security@kernel.org, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_124626_931760_98FEB208 
X-CRM114-Status: GOOD (  16.10  )
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

Hi Christoph, Maurizio

Just following up on this thread.
Would you like me to send a v2 patch that sets a sane default MDTS for
the TCP transport? If so, is there a preferred value I should use, or
should I follow what the other transports do?

Thanks,
Shivam Kumar

On Fri, Mar 20, 2026 at 3:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Mar 19, 2026 at 02:00:27PM -0400, Shivam Kumar wrote:
> > Hi Maurizio
> >
> > Thank you for the review. You're right, I was conflating the per-PDU
> > H2CData limit with the total transfer size for the command.
> > And the error handling should trigger a fatal transport error rather
> > than completing the request with an NVMe status code.
> >
> > Would setting a sane default for MDTS be the preferred approach here?
> > If so, I'm happy to send a v2 implementing that instead.
>
> Yes, if we want to limit the I/O size we have to limit MDTS.  Which all
> other transports do anyway, so I'm kinda surprised TCP doesn't.
>

