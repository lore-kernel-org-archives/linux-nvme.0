Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D43AFD8FF4
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IhbFnnOqNl3MabDLhveMA0QVc9xaRZe+uvN+prWDjjE=; b=xWq8jtEnF9HDCIOa50h4U4REG2
	vnSYkOflvnGFxexWE8VMvApvCaz6GbYj+7aAnw4Rg+1KZ9uOmOTAAFc5S4w213JhZMSwcxnVMWMN1
	uN3U3O7yTsO0FbHjmMsZwp8E+3nYzfV1WDJ6fYAsoJGfpHAT6GNAbXtx/bCY8hGtWw/usABzqG1/i
	syJhU1kqREbxWPaHMe9uItCTsKpc5/Fzy6rMvDE/vCYgcvCi3e/lIfACmEb1SCOy+iLdEfdgUdMP+
	DB2igifNZZZFgDhVAhYf8QpkC2iFUenKSeEhJEkOUdvEzKGw5nssbfBk1UhEBQq2oxfBy+Ks9iaGF
	OD9/pOBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgNx-00000006zfF-20zC;
	Thu, 26 Feb 2026 18:46:53 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgNv-00000006zeu-1RkU
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 18:46:52 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-b9356452351so16939266b.1
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 10:46:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772131609; cv=none;
        d=google.com; s=arc-20240605;
        b=RNpRCPxIi51x4YWNfrSNUI51QkXNbii7QlAOjmd+FTYuQdTuIXOr3yKlYoZJmqrWdP
         LmxW1l+Y9Z8guwpfOiN3BxymZeEk52ur4y5VWy1Ca05x1NIO4NmqdLJ3pc4OBMdthmcu
         JOcH5mDUsey77Yy7omwVgOYYQxj9b2kRLrwfLGYbf9S6sjS+BPOUmt7ucKP96ILxnfOz
         neM8Rnw1GnY6nOzRaXfe6Pl5aJ9eVstS2Zcx5NzXmMT3juO7xIr+mHrNRMQb6qlrcNOB
         ZW1mK9C53XIVqfxKCAkhDuSL0PVtqEtoqVixk87dK4JTZRHyNoiwA7k1/XNMuYxM26tv
         ch3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhbFnnOqNl3MabDLhveMA0QVc9xaRZe+uvN+prWDjjE=;
        fh=EiOIdXLZRUHrtc2S/GdxdoSVZGjvneEyYlYQo8cB8ZY=;
        b=Q8X2D8nn6rPtRsGKtEB/iuLuoxN/nFDGlJtlXOr+/JW/pAOw4F0R5RCIRvhb/L4RFy
         0/fuifzwJzsNGqwuqByzDnyvBTpRBVQ1jpbkwpMbwesp3PHFEIoL3ITWO+Kx86earjkz
         u7F/mbu073sS0QofiDLsjNfvhOjekaQnfkfqlsshhwlNuAucGCDDryFmBoNLSuhXUdiD
         4d96srkq/NX1cIYbmIdbyVZ/SI71OlJJeJWj9X34Gl0AW7F9yabLOjxzcfjUKIRve8KI
         /JTEOlGMvCqOLmquOQXHzysN1ljReqKU67juMgSea7SfO9PqlNxmbn6Q9y5+yC8J41XZ
         IcCA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772131609; x=1772736409; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhbFnnOqNl3MabDLhveMA0QVc9xaRZe+uvN+prWDjjE=;
        b=ctxhUdwDB92Z56cnV14vdEIruTrWBIhxMUxMuTKPTRBo+lgZN0S+UoRQjl0dm8IT/r
         lBlSe9KDZyeoovqjlIo9u/vCP3AxIVCwyzBvO/DHYRSyIBnheXqc+9vIS71IZppMFbHd
         QVagWvBmpMMOnGa2sd4spJ5+1MxfI9jJCDXd7mHBrm3jOwpsomNBLVpKv0QZuNsjiDF2
         pD0ny2Q/G8CehpuzfKLUhNc9SOKHHSXS/sFNVygnEpYwYhsyEQK0wLjvaXWhnZbJlvy/
         qBRO8WyaVcuY0+U8Q6XTlySGp6lGw2vq44DnyDW0r5gIjGMA9gz+IupBLR3JRmNrvh6/
         2MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131609; x=1772736409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhbFnnOqNl3MabDLhveMA0QVc9xaRZe+uvN+prWDjjE=;
        b=dvDcdkUpXCDuQGZJXDrbC+UFy5CpEQlUi7JY14fMJg6WC47uI5airm7rZn7xgNmIpu
         EjJed4cdQFdLY6RfhcaysR1HuED6GhoVIbge7I/R/jCGBDP/5wnOO0OFpL3WnoFQBVTQ
         nJNdFJJ08/hKtds0kEDBG4uIs6IfDljeM6JOt7EjE9Ap0pjR5Ii5DFtTbMofSnuXZQ0e
         /tya6FMKFkcv5kHCa9xaaCdI9gQFcdXwIw/36Fi5GgVaFt6dVRuqNOK1cfye8/GVaURD
         JKlfS+C6OCDAxnZQxTR8XDre4QKx2fUV4By/w+WeworJ/97tANUqTa30TfYdJsmkEZm5
         3dAA==
X-Forwarded-Encrypted: i=1; AJvYcCVTRls3uLzJeQveuXMQlcr6aee1qiGZP71DhlacP4HGulCk0UerorjYZfFQAJoVFYriLJtU7z2LYWy8@lists.infradead.org
X-Gm-Message-State: AOJu0Ywt1hQRboFTj6i4puJQdwjnSzN6hU3832wNifkmy0UNt9AwltVU
	0FyVfM8+jekPziP7U6W4sKbyryG7Yad/Tf8Wzi+O2Z2m5BDUkrqyP3QkUOGVVmTKKPj3xXrbOjW
	uDP4ij73bhJJ6x7PNLOnE6IOWaGSPpr5mYf04lS3Iqw==
X-Gm-Gg: ATEYQzyiNxS1LGRtZy38p5SBtSidJuivXZxKspcjzWvIElLICmnMJqMFYd7LQspaF7K
	yvtklrswm4+bJS+5k0dQFivyZduRDdWMuUtyQBJ/6kRVHqUN/RMxvpLzuYFBrzOqi8lRV1bwIQ8
	BK9p2qWSKj2btaxnhm8hGbw0Nfo0TL6J7AvVOog+WLrehs91/SYiT9d1Wh17CeSDxnDPF6mUpZs
	khmcA6hOSHJpaHDp7SNqzd3C5EVW+xS1fcv9sszw81jZmcv8iFcQqjCv0CKIGI2uwnfWobBbETd
	pFnNPZpfl1csx56aSg==
X-Received: by 2002:a17:906:9fc7:b0:b8e:7dcb:7f23 with SMTP id
 a640c23a62f3a-b90819894c5mr671306866b.2.1772131608740; Thu, 26 Feb 2026
 10:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20260224171437.3175993-1-csander@purestorage.com>
 <20260224171437.3175993-5-csander@purestorage.com> <aZ3zQkApqZN3tkf6@kbusch-mbp>
In-Reply-To: <aZ3zQkApqZN3tkf6@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 26 Feb 2026 10:46:37 -0800
X-Gm-Features: AaiRm53f4VuJ2Ic9LTxa174UctZ-W7Ll5kKgbyKKl3-rgAk0AhPyamnI0TW6NYA
Message-ID: <CADUfDZqp0a18KKvzfVoK8+a930DYx6AO2VKw=VD+i0kG_U5ykA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] nvme: always issue I/O Command Set specific
 Identify Namespace
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_104651_440209_C10E1496 
X-CRM114-Status: GOOD (  13.09  )
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

On Tue, Feb 24, 2026 at 10:51=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Tue, Feb 24, 2026 at 10:14:33AM -0700, Caleb Sander Mateos wrote:
> >
> > -     if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
> > +     if (ns->ctrl->vs >=3D NVME_VS(2, 0, 0)) {
> >               ret =3D nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
>
> NVMe allows older spec compliant devices to implement features that came
> later, so I think you need to keep the old condition as an option in
> case there's a 1.4 controller with extended LBA formats.

Sure, I'll change it to issue the Identify command unconditionally.

Thanks,
Caleb

