Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52883D29FB2
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJB8cnxCczj8gnT21hmIzpL3HBpQcF1qbwkCZVuj7jw=; b=QcYNqdabVIfP2lAi2rTIDLwknG
	Fi7YmjZLfdpIPr3SJPy6Hh86zkcSqtEcJ/8txYMQ2o60LtTbPsJr2RgWUz/hmoC005HWSVWol4fCj
	nwIaDgeYpNaaiNVThN1DhBKsrqxt/3MbQp4vX4dYIALfJ7tgCWvUeM0ck9dKxKxs/dA4wtm+t0AI0
	BVKVdc2lh7DUGdzv6xVkVjcjUBnqvgzibgLLbU5Dx9aEFGnwCszN6S4v8SW1W4JvhVTlboMFbF1Eg
	fOncmDaZ1qH0vfqjfPe2xxQIigf4zPeJC4C8jaBe+B0aQUHL7sPJUCopvmS9j2RDHPdZWsi8WSes5
	FG8ZdRbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRFIo-00000008WVE-1A6j;
	Thu, 04 Dec 2025 19:47:46 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRFIk-00000008WUW-48pQ
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 19:47:45 +0000
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-8823dfa84c5so13367456d6.3
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764877661; x=1765482461; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJB8cnxCczj8gnT21hmIzpL3HBpQcF1qbwkCZVuj7jw=;
        b=A8cLIcQ6rrA1wHIDsTyDrxgNGYzh33bxF6T/2Xej2incv2aIerfpCXzYd1PA6nVfri
         cWDe3CRGpUsIWWrOgUmfKZbfT2TYLOk/qhbi378bDvijtIaah+ERyrs6d79md/DlXpkb
         mDJjITiw5vE4BhJ7l8jCJgIbsUyXxl9iXe80OVmjOJOEixllVA5isfeVZkr2bsgB5N4d
         oUyGhszC/G8Q89w6JhnHuUzu/NlvgeNUdF9TZFsByGF7yPcQj90+MbgvqBjtNXEhnmT6
         8LVxkP9N6Z1sd3W1Zt16WGDBhA5vMre+rWryH8DoDw/XAzGwwWJS96GfbgKiYXRERSut
         H1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764877662; x=1765482462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJB8cnxCczj8gnT21hmIzpL3HBpQcF1qbwkCZVuj7jw=;
        b=nY0CmeEC9EHamJNi7+6TbEw7Tv+x5//sfPe+RlDsNo84oD3RD3tCk4N5cbYqf/ECeS
         fzn6Ec4kAZYjd23Gg1eYHL4Y34md0rtIpO8vw7Y1+3lW9lpxPVtmXtnC/y4v/OZRla+Z
         3HFmJUq05cJOECQgA8eSUBzUQpeXeGDiAmPvttak/wm8QlKOYxWOI/Pykml0fZ/qdqR1
         lnQOl0QDH1Qt1L/jvx4gMHkVyEybaBK4kkd60MsCGjiDT1m/EYhnqOF6vK2b1xUPOezQ
         ddqlvulMZfQr3k70YPvkXw7iglHZk4xOAbcxkegVns0d8IrLVqOZOd8k1Gfmq0eQ6XZC
         p+iw==
X-Forwarded-Encrypted: i=1; AJvYcCVS0KYSSkud+CWKRCNmYtBoI6NYKiNzynrJZ+X4vP6wEXhOX5zJUOY4VCgwS9w/Gfno8dVTeZrWnIw3@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5MJ7B84DFFqgekFuXe5rWOE/t75hb0iD+iesKv1zP0bFkwkku
	kaKIHw3XECu9kvhByHbTobRU46V8SwdaAxTnCaIO8p1Wv08rPSieohIc5liFWFZSANQ2O9uoMbl
	1YwhjwgJEZxzoCD4idKVe3PK3lql+4hI=
X-Gm-Gg: ASbGncuYj4Hk8r4xK7YZ9Osf4Tk9aY/pbUoj7grjv4+bIKM8IDA5J87lnirPLeGRRw1
	dDSrcqpjyWlxCzSukLi0GzBCX9IcA+4eNMzlYMfIbAXLHyx06ztEJjzjEWkONwaascsbMG/ouhT
	xQb889472JKJMLJ9B1UDiNmheal/5iaIjo9vfLHWcr7ID+sd88VfDNiKiCV1fm0+qE3W3Mk9qaR
	VTws+jlyrzHMX6Re5w3sLnoz9+Xh5uNhLcD/qMGuQghMteIgTje+DCT4wLDm5dvrGNTR7X9
X-Google-Smtp-Source: AGHT+IEcysjQTdL81Q7lNbnwJOiGlShrjQHYbYkzo6XR86OJfOc6Uz5sAXVis694rd6mA+1Ov/Ce9CBlVgxi1rpUmn0=
X-Received: by 2002:a05:6214:3387:b0:880:5636:6241 with SMTP id
 6a1803df08f44-88819594cd7mr110930506d6.65.1764877661633; Thu, 04 Dec 2025
 11:47:41 -0800 (PST)
MIME-Version: 1.0
References: <21255200-a271-4fa0-b099-97755c8acd4c@work> <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
 <6440e968-a181-419b-b203-a354b924341b@work> <05b455fc-d08c-4fb2-81db-a818771b9c42@gmail.com>
 <fb66da17-65b5-483f-8d49-e3dfa38b27d3@work> <CABPRKS-e9pXDyFejW+o42vRfzhy6EkUnOVxe46iZqqm4OMk4yg@mail.gmail.com>
 <CABPRKS-UZMwfKNCK6Mx17_MxYK-ZieKddx0N7YBM3hf5Ur=4Ug@mail.gmail.com>
 <CAGtn9rmQW9w42oMVGpXZB4OuifwF3XzgVaxuHyXN1aYpzjRskg@mail.gmail.com>
 <CABPRKS-j+J1XKKoMOXx-d-8d_yxo2JhF6G6jYYFvFXOdy5x3tw@mail.gmail.com> <b1e0835e-cdc1-448d-bb24-1bd7afee8158@work>
In-Reply-To: <b1e0835e-cdc1-448d-bb24-1bd7afee8158@work>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 4 Dec 2025 11:46:42 -0800
X-Gm-Features: AWmQ_bmNEhhsiis4ofn-JqFcGLWNvEyvwS9_8dCDygtbWgai8oWe6rOguP-FlfA
Message-ID: <CABPRKS-kEzVcHzDxEtrk1+OPC9xvObhykxEnXNHTuHOEqcz8Ng@mail.gmail.com>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
To: Aristeu Rozanski <aris@redhat.com>
Cc: Ewan Milne <emilne@redhat.com>, linux-nvme@lists.infradead.org, 
	Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_114744_399701_27BA282F 
X-CRM114-Status: UNSURE (   7.25  )
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

> FWIW, test kernel with the revert still running since this morning (~13h)=
, no
> crashes.
Thanks for confirming Aristeu.  I=E2=80=99ll be raising a patch for review =
very soon.

Regards,
Justin

