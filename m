Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6259BE810D9
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WkpLhLMY73r+vBh/5ZRPlCt1NTiPm0bJEIerzBQcv5c=; b=DUEcA/nb0bM8KTpCCQJCDWDMEB
	oRJQuokzsXDi5xkE2mSnH/OOOFKqn+j9j5j2uX4ZR4I4moS4i+FyA+T3YW7pYe6iWyaPBPFZZ7UfC
	8mozk6l5BQqX3ycRzzT3iP5zf56EZGeAha+s7GpEEJmZHvWxPEKGPLg99DRT58r7mG5Cgylpie8df
	tVFyhzWZ7Juuowg6jBQrQCwZO7c22b//vffPPlQx79GymAoHfTGpgLJphrW6EfdDpeSxdec8HuC6z
	vLqsNuL/GHEb46qHxrNsoNIjXbzBznS72SWBSKQYjhjYlHjZStV9Koa/8w8QSpMPbP2AklRoNt0WK
	3vADGwPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlV0S-0013kO-0m;
	Wed, 27 Sep 2023 13:55:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlV0Q-0013jt-0G
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 13:55:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695822908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkpLhLMY73r+vBh/5ZRPlCt1NTiPm0bJEIerzBQcv5c=;
	b=Mx0QyqgUjbmZC7D6nWfngGkBZkvI7AgkEfwMdUl5B7uNrFJDJLe9yyu37/bsQZWlpzmkxJ
	Lq0ybkCaM5KT/ZVQ8Jwg6loTitvyLipSuUHzM0GwY631ZnmTMr/cwMmTaC2q2MkrfHYicH
	YcY4YkPh4MZ1VQzM68KuC5qT7p8rMII=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-NKm3L5qnPxWxSRUj1W5rCA-1; Wed, 27 Sep 2023 09:55:07 -0400
X-MC-Unique: NKm3L5qnPxWxSRUj1W5rCA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-323334992fbso3697317f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 06:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695822906; x=1696427706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkpLhLMY73r+vBh/5ZRPlCt1NTiPm0bJEIerzBQcv5c=;
        b=QWKkXc7ThZ5PtNPJ/qltYgec3uyr1Bc/11Z8xnUHIx1j+cn5Z5kLq/N3SjZeQ8G9Ad
         8eG28o8Musk4cmOmhS/BUNCfksdHsNdoghV+m/hLUrBJpo9nuuIPUJhAFpP1jzBIZcKp
         nGx192pP7/L68IBHhr0baJl1Jrs6yAHAgFluWuXzJyhiYu/FMA7ULVMqKkIwQbHUkrEJ
         nFq78GASdfJ3Jk4pt7PDcMoE7OOO3pMk3EF44bMMdM8L6xiV47lm7IxCEMsOX0W0fXpw
         so39AB8Y3+XOT3TbjL2svKcXfUHBUcS/h/s03k67kIYEuoeBovAwmh0fSdkkVWJxW+/I
         T4dw==
X-Gm-Message-State: AOJu0YwA6pRYHblv6XDd9sBDY48kS72OK7+nQ4idmYfLeSr3s3Lz/oX3
	ax/oMtz+F9cPPqIZI4nfyOk6VO+imPNw0TajqeQWOM0cIJifXIT8G3xYClCwZw9USHCiKCxiVLT
	DOwJeMrPGoWthe0aWkXSkEGXkN6eYtf1VwrpVRY0sAPk=
X-Received: by 2002:adf:ea4a:0:b0:31f:d7bb:481e with SMTP id j10-20020adfea4a000000b0031fd7bb481emr1846344wrn.63.1695822906445;
        Wed, 27 Sep 2023 06:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1JPgooz3wnWKyW48wv6YLsv5w9x5CnoTpC8uNtA3DeI1vViz8x06Fk5k7bypztICEKjhNXoxD9QRs7qNaK7Y=
X-Received: by 2002:adf:ea4a:0:b0:31f:d7bb:481e with SMTP id
 j10-20020adfea4a000000b0031fd7bb481emr1846328wrn.63.1695822906161; Wed, 27
 Sep 2023 06:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230925163123.16042-1-emilne@redhat.com> <20230925163123.16042-2-emilne@redhat.com>
 <ZRP6pCFd8+mWpUcS@fedora>
In-Reply-To: <ZRP6pCFd8+mWpUcS@fedora>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 27 Sep 2023 09:54:55 -0400
Message-ID: <CAGtn9rnxVqx+L64sZPLbWAY=kty25tW4C0W+-GyUbJo4JrmtNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com, jmeneghi@redhat.com, 
	mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_065510_193361_01C3DD68 
X-CRM114-Status: GOOD (  14.91  )
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

I instrumented the code to look at nr_active and it did seem to be
updated for all the
nvme fabrics transports I tested, but I'll check.  (As a blk_ ..
function it would have to
work on anything).

Of course the patches depend upon the block layer having the nr_active
count available
somewhere.  I did it this way to avoid having to duplicate the count
in the nvme code.

-Ewan

On Wed, Sep 27, 2023 at 5:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Sep 25, 2023 at 12:31:21PM -0400, Ewan D. Milne wrote:
> > Returns a count of the total number of active requests
> > in a queue.  For non-shared tags (the usual case) this is
> > the sum of nr_active from all of the hctxs.
>
> hctx->nr_active is only updated if BLK_MQ_F_TAG_QUEUE_SHARED is true
> and blk_mq_is_shared_tags() is false, so hctx->nr_active isn't
> available if BLK_MQ_F_TAG_QUEUE_SHARED is false(the usual case?).
>
>
> Thanks,
> Ming
>


