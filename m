Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B1DD12D79
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 06:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9qv7O8dew7I+B9eEJJt0qBNM8IZdD1sLJueFsW4bvsc=; b=2b2tu039MUCOIrdNMahYix3Fwn
	l80vUMLuLkGm8Rv4/y4dwbJjfz8LzG9BsY4LfJ+ESJHB+GBlHbgs7pCBbTHk8/FyvrsVvf+p0Y4pN
	Z5uRUWQ//YKPVRZfHkLFCEe52zCUzBTtYhxLyHC0xovjCRePuo6gs5R2LW0HPYFTcaAw2YSj1EBW+
	GjbiTCt/3CUNBvKWiDWvtZOq6U0iJTpX4IS5/sHQYa5vqTMKPu5GziNXz/7Y/RoP9Z7QuPXZdbSwR
	wWigOJJSAGoAF/rcsrb0ZoijHUE52zSSClgfHk09u3N3S/pi3x1Tj8pfP1AaguMvUa5FXuDJuo2ho
	S4vdfuAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAO8v-0000000GWBK-0GVJ;
	Mon, 11 Nov 2024 06:43:21 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAO8s-0000000GWAr-3QAM
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 06:43:20 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2fb58980711so32285151fa.0
        for <linux-nvme@lists.infradead.org>; Sun, 10 Nov 2024 22:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731307397; x=1731912197; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qv7O8dew7I+B9eEJJt0qBNM8IZdD1sLJueFsW4bvsc=;
        b=KrjvF5E3wFO0RozzJnO9rhBl6B76RZD0fZFFUQT5Hi8VUd4ByJ5OVUO4JO0ddtbt1l
         mEQt24+KF5A5TFuOuJ4Gb/e3sRJCml0/Nww572YZPfMAjHZtJborwXLmYVJ2nSZtBHZr
         LxcnHQH+zPDkzdKLbUfcOD6zE30yV6IGr53CIQP0co2jUrUODMxi21s99zIYnQ2pR0/v
         dFmOy2Bi7woCaSvy/jsl547Tn9dlxN7mxY75dq7WN0HwWAYn/k7X1eeH59W1AVb528ap
         bCsjEuLGl880L39eYayAaERE2KP/kMNokuMQlJQ74B9bBDvtTfB7bOa5CrXwHeZpk7vT
         KbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731307397; x=1731912197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qv7O8dew7I+B9eEJJt0qBNM8IZdD1sLJueFsW4bvsc=;
        b=crZmHHdVvEhRcK/UY85/KXw79BBiAPcUhIY0Njs4rIjhvNtvn3IwvkbWUScT8TXnI3
         trXp2emK/LRQXCu2o835e2Ook3aCFYqu/yL8snMwOk1Cp13JdeHGLVFLSZhUIt6+/p4J
         G7Lq5qdvE6sN4AIRRlEBc73xyMQ3NksEXuGI1xivjNmbvIr2uGx5nzlPirX4YYHB8v1N
         Bs6kq3hc3ljzhUDEWwQuP0fto2vmJLXt475OutQB7yNlsOMR6Vh9uHjw9BMIRQekWo1B
         /CsDC2Smzz/fDHCoZlpAAOTRe79IvMzYBFqjpPBJJuCM242+syKxJWScPidxSWlBDiS9
         cxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+YGEj0AqWsaPF0+T8uJnLeUrQZGtfpHmiZFb1ynaPvGfFX7qYj5FNrbIXCItGZcl/TgEVd2rZwoVq@lists.infradead.org
X-Gm-Message-State: AOJu0YxQqcPwHBZPF61hh8yEENwSkE0Ld0AE0W0DoPrkZI9b6NMb7vdN
	gvsiyxSfk/oy7VZKtDzHvH0sBVd/VujoCbjFHoEF6FNuyDJA17XauGESTsaWhvFKtl/vbKchkCM
	5F3Qx79R8Gee+COuZAH6Slp9f13c=
X-Google-Smtp-Source: AGHT+IHutgQAlXklRgMYNRidcA41kXnbJbGiEJGtaB5sYolGWbh343PWRuG4ZkC83mQMH8VsiDxXBWb3iwvgsLPw2Uo=
X-Received: by 2002:a2e:a813:0:b0:2fe:fec7:8adf with SMTP id
 38308e7fff4ca-2ff2029fed5mr47426781fa.38.1731307396466; Sun, 10 Nov 2024
 22:43:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730298502.git.leon@kernel.org> <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
 <87ttchwmde.fsf@trenco.lwn.net> <20241108200355.GC189042@unreal>
 <87h68hwkk8.fsf@trenco.lwn.net> <20241108202736.GD189042@unreal>
 <20241110104130.GA19265@unreal> <20241111063847.GB23992@lst.de>
In-Reply-To: <20241111063847.GB23992@lst.de>
From: anish kumar <yesanishhere@gmail.com>
Date: Sun, 10 Nov 2024 22:43:05 -0800
Message-ID: <CABCoZhBVWY=aUQtQ5b=mF8hXqpgJw21_jAPf9YvEvdgPf_GALA@mail.gmail.com>
Subject: Re: [PATCH v1 09/17] docs: core-api: document the IOVA-based API
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_224318_876553_EB8115B7 
X-CRM114-Status: GOOD (  14.45  )
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

On Sun, Nov 10, 2024 at 10:39=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Sun, Nov 10, 2024 at 12:41:30PM +0200, Leon Romanovsky wrote:
> > I tried this today and the output (HTML) in the new section looks
> > so different from the rest of dma-api.rst that I lean to leave
> > the current doc implementation as is.
>
> Yeah.  The whole DMA API documentation shows it's age and could use
> a major revamp, but for now I'd prefer to stick to the way it is done.
>
> If we have any volunteers for bringing it up to standards I'd be glad
> to help with input and review.

Jonathan, if you agree, I can take this up?
>
>

