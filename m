Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7C3C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 14:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vzZ0t+6EA44YYeZ1nSKnkOHgB4WgwxxqFBIuc3oST+w=; b=jBvWSC3qzJSx43LhQ76IECvyqs
	22woTa643salpeS2kBPosTxJpkHiM/+Yad+wsWFkhwNsTh4i0wAzhmJQav3GfL/36Y+WItsLf/LWw
	/xg7CvTeg0Yn2tyfAxwE/Vlga5NMF7jO5ktO4AFqWpwgMuwhNhXtFVMQzc1pKmjjshJL0cf6dtjwJ
	f7l3goOoMd7PSN2inYfMdtqlN5bQdR+GHHSknQzl3FzIRDxupRpnHB8w+UX4JPbxZ3vPQZ+B7Lnnd
	Lky1aXC2XOtIILaPF/QKxqCEmEH8FhckYpRUzl+3UOWwUp8Jt/7Qk6vWOIYcLkF6P/lkaOh7k7DsN
	AVxhu5HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQpCS-000000042Qk-3L8y;
	Mon, 08 Jul 2024 14:18:40 +0000
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQpCP-000000042Om-3h0w
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 14:18:39 +0000
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-81015861cccso1141417241.3
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720448315; x=1721053115; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzZ0t+6EA44YYeZ1nSKnkOHgB4WgwxxqFBIuc3oST+w=;
        b=Fsg/qvy1MxIPUo0xXrklTOf73juGJa5xvcioSEFeg3X12g6mzD+IeWPuLLY3Yj+uWc
         aJ/9W6ld8pdhUW3f8w6/nQnzZpOk4gC/2OIneu/ORBVu4+FrJ28slrvresmy20iRDrJl
         RpscYGcsAZHUUhnvw2JK3G4QC1ijV8EbW96qz3XVuyNjQm7VO1oavpvdS7VkC+s58BiQ
         vs00VYo9H9/hyKu/VU2s2rR2nF+X+4gH6UVdYW5fPZ3IPIT+GT20EuLKkhFDALW+sHlz
         pzf3lB55fipSL0+QepXGutjR3Ty/QPQG5z1yzywC0zLjrSs6DMRuN11aL4FT1YQ+tDY3
         qMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720448315; x=1721053115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzZ0t+6EA44YYeZ1nSKnkOHgB4WgwxxqFBIuc3oST+w=;
        b=t46wZRLxyQTF8yAwYiRvI3nVWtHA9YIm1ODe1giK/TlmHQHB6m2T5mVLGwhsJmZjj/
         tf6AUvkjzy2huo4uxbtYp0d+MM+i9Nbtmtf+jH6/MSm0lOnd3wWZJ6GrucSrhxsYYjso
         yln3ey2VJDR93fiXQ90bbAVDxRxJUIb2a4AdW/kVjAuD53Lvx1PyfEykPMwZdxLDbdE3
         V+jbKuD0N3fG6RVwHDVT/1vaDC/LqIUuPMS5DgoaZYC+vn1GWLDatcppvMHQbC4lGlPT
         vXoMuuKjPKDKyzr4xDRSkBik01v8cnHKVC77QsXx7PEp7OzuT+9SqlAz23dtKLrfBSWi
         wUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVMQp+alvfxLNkNRAn38fyfMu5yC7U7EXLNbPGgWorUP4msMZlb40oazIjlQagJhclwF8HZguEJ0f0Va6T/GKggEfxYOCsMbb8MtYWP00=
X-Gm-Message-State: AOJu0YyHgQboLqqdMeRZ9GAgs2wsnXN0LFFxyc6a2skXKuYypaVA0yrX
	j9/ezj99SeYMB/+MgKXpHwbPbkieDt4DKrWONik/nr3w9VbVLKZD+377Ac1FBVcqGr2dXaF8mNY
	Rywa5pYQqStxM18PlWVvQKW+sMQ==
X-Google-Smtp-Source: AGHT+IGBZ+nfOhagN9EruogOZmg7A5VWL+nHpS7DVh+j85DRP1XireqJnFUSTtEzQm9VwJ5uppvB8QfKb3CsC3X5BvU=
X-Received: by 2002:a05:6122:d1a:b0:4ec:f9ad:d21a with SMTP id
 71dfb90a1353d-4f2f3fd1102mr14678174e0c.10.1720448315692; Mon, 08 Jul 2024
 07:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240705083205.2111277-1-hch@lst.de>
In-Reply-To: <20240705083205.2111277-1-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 8 Jul 2024 19:47:59 +0530
Message-ID: <CACzX3AvXAhcjE0PEB_PO7B2e0pRB7mj2QMdw5Gj_sNH-acTfYg@mail.gmail.com>
Subject: Re: fine-grained PI control
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_071837_938745_F1F29585 
X-CRM114-Status: GOOD (  15.74  )
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

On Fri, Jul 5, 2024 at 2:02=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Hi all,
>
> Martin also mentioned he wanted to see the BIP_CTRL_NOCHECK,
> BIP_DISK_NOCHECK and BIP_IP_CHECKSUM checksum flags exposed.  Can you
> explain how you want them to fit into the API?  Especially as AFAIK
> they can't work generically, e.g. NVMe never has an IP checksum and
> SCSI controllers might not offer them either.  NVMe doesn't have a way
> to distinguish between disk and controller.
Yes, these flags are only valid in the context of SCSI. One possible
scheme can be that the API still has the ability to pass these flags
and the NVMe driver fails if the user specifies these flags.

>
> Last but not least the fact that all reads and writes on PI enabled
> devices by default check the guard (and reference if available for the
> PI type) tags leads to a lot of annoying warnings when the kernel or
> userspace does speculative reads.
In the current series the application can choose not to specify the
GUARD check flag, which would disable the guard checking even for PI
enabled devices. Did you still encounter errors or am I missing
something here?

--
Anuj Gupta

