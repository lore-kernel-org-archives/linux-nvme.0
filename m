Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02BFC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1s8LxSgdpw/QFNWhayU6GhU6VvikEqRstbNbkkV5cHs=; b=MAiY+aIZMPISzIqjtUcmA3nvcl
	6ygk97jY1N0KGiM74TKekkGSuZmrBqDuXviHikba9k+cYS6S5iP4d6KgUmzsSDBnpdMdeu1lX8iRA
	sygLEb572tnWmN/0fn5gdmoOFuK/i9sAo08l/3RLhob5Xhy1AqlqAmTYbLSaFnVGaGoOJJqPHQKgy
	yU5no7qxZYtMk8v0858ln6BsSXfLoNl282r7m/CAze4G1S56GYI7L5Iy1/o4KD9ZB1gW5ZkDZYoT3
	TFBOcAkjdBnyuFeYe1Kj/39/Jfo1JFeM9EJUaT5PM96x+QTJfebaZJUi29MmfLsQQTRpGlJul0hd8
	x20Pmv/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCgsU-0000000G0Nt-2ASl;
	Wed, 07 May 2025 15:40:10 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCgJ4-0000000Ft9c-0Nq8
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 15:03:37 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-22e1782cbb2so6265585ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 07 May 2025 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746630213; x=1747235013; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s8LxSgdpw/QFNWhayU6GhU6VvikEqRstbNbkkV5cHs=;
        b=WaQXk4El8+SW/XrbZvbU00bC/5oVsnIlC6e9ZHbWkXeiOorZ8bEuVqYdepvKdNmI1h
         yY3LFdHyO/Ht+2RKox8KDc7G26PM37i7zWNVzaL/mVSLRwfbMES0uDICFogNAcAMrFQd
         VUCEy202qcpWHMRxNn9oExvu4nVqc4thrswMSYfFm8Mr7az/QY71HBI+iiMEykipe4kr
         Un3w9FmomoJAjA0sBi+APHHgQ4xIpabRqL8IVOncFrILZKNzH3ocUsJY64NurJy2eAiO
         1p8oFLtnMIT7k5PgfFg4PohaLSCIKZdIh7Uk2UtrTTwlB/f+VbHKqwNSpz98CMl+7Apx
         lLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746630213; x=1747235013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1s8LxSgdpw/QFNWhayU6GhU6VvikEqRstbNbkkV5cHs=;
        b=AsorN636zuiTZfc5B4wbYJkv9ZOmKciAgMKPcC06d+ahcWPAbD/bvDV37P+hkMqPO6
         vkR8lFAeFsyaf5aTkV00Mu9GPLcDyEgrmtyELZuxZ8lsXGnucVrfs7wF1ue6+vxt+jEe
         r768EoM1LCWRy/OG5WzBSxz0+zxn5HNtBrrs+n58mG9XRLG9esW4dlAO7/pOAjmtwZTH
         1cSu0bgBsS92iOg9IEi+urrWJ8kAVcPF88xnx9oxbwWEa/Y3che2pJHkacU34RvEDbki
         YJ80zKktXGtKGmOBqOBDbPY4kHetreR7X/XoAhK/Gs6z6p8265e9kOU/UzKs6O72HTe5
         DfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHa0eFaRMwAUyaOxectHUqCziOsSH8ZeMFPQ68+SQeKiKe4bw4wH87P46PmjbFYI72Tn+HzbSH7pRq@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+jJuNHrCAd1FnxtDYJxKyVDOum3Yk6Y0nWUzyJXAo+y99bfoq
	5JZsYW2kmJFU1OLmHCh9C8HFgGRM0FWAy5c6EIgL+5njmKwTl2kpepx/KJ89CqdBnSBIv1ZPrpX
	df3bmCNftfnPuue/n4VfFl40Rr0L6bpM9lQ1LXw==
X-Gm-Gg: ASbGncu6Ln0ur6rSmMIHTI1e8L8zUe66Tm1i/1LJiKg2rFaXZnsZj3e/y/97N72BcEE
	paSfKs/6NdEszumv7dlHVzuI3e/O4IdnIW3+4Wd8ybSfSl7rWs5j4ufTaNo/4fQEB9U01PDTNFq
	NexDNYxvJ2EYzXk7YDHD+T
X-Google-Smtp-Source: AGHT+IGVRdVpmD42Zl1K9/CFzNk9/9fbzp0SeC722EZPTJKMkP3YbezVcTCIZOjRu3Yyi3o0XRR2Kv7U8ekDo75qkiA=
X-Received: by 2002:a17:903:990:b0:223:28a8:610b with SMTP id
 d9443c01a7336-22e5ee1cb10mr16787145ad.14.1746630212740; Wed, 07 May 2025
 08:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250426020636.34355-1-csander@purestorage.com>
 <20250426020636.34355-3-csander@purestorage.com> <20250507071610.GB1413@lst.de>
In-Reply-To: <20250507071610.GB1413@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 7 May 2025 08:03:20 -0700
X-Gm-Features: ATxdqUG1uu45_rIP1595jmow33H5jf2cu-Lb4HqU3C1enyWziA9-fbza28d3E8s
Message-ID: <CADUfDZo+WKATQ4+ZpYvvNWrqBqP7pkBhzfBxyMWQomeLR-qtJw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] nvme/pci: factor out nvme_init_hctx() helper
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Andrew Morton <akpm@linux-foundation.org>, Kanchan Joshi <joshi.k@samsung.com>, 
	linux-nvme@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_080334_157942_14508011 
X-CRM114-Status: GOOD (  10.05  )
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

On Wed, May 7, 2025 at 12:16=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > -     .init_hctx      =3D nvme_init_hctx,
> > +     .init_hctx      =3D nvme_io_init_hctx,
>
> Without an overall rename of the methods I'd rather avoid the _io
> here and pick a _common name for the common helper.

Sure, that's fine too.

Best,
Caleb

>
> I can fix that up when applying, no need to resend.
>

