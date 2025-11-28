Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D091D111A8
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 01:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OCmoVsJTYhvhdEhqnCuQdxLwDfWSRN4iQRhiwDtzkSM=; b=PUoXhR4cwaOSH+wSo15RKb10Og
	4I2BHxlyCeoc/xNo94oz7QqImobyYWz88j4/mBXdGPteaSgTsrX4udxwhv4GSFTxTn7dtoIoEDhIf
	0Prb7QVHCZ3etnFcYE8CIIB/P2GLlDtB6rTL7IokOqxn3cDQCh4A5vKRVcEczd4eZoQIr2Dva2Gqf
	YrQH4LwdVfWsmmBL41rh4r4tiUaYPkxs+N3GXcC1jsTVVs7dX6n5+0tvWA7pt733ZP0DSOKiScNKr
	vIFXjGsS0gm+3iRIYYvSQMpXHymACGSozmpNPRTcDkV/z4iysYK5/s28G06XvyobfZ0KqbTCRcODW
	S1hIiwDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOnMg-0000000HOva-30HH;
	Fri, 28 Nov 2025 01:33:38 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOnMd-0000000HOvB-1w4n
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 01:33:36 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-880503ab181so13584266d6.2
        for <linux-nvme@lists.infradead.org>; Thu, 27 Nov 2025 17:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764293614; x=1764898414; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCmoVsJTYhvhdEhqnCuQdxLwDfWSRN4iQRhiwDtzkSM=;
        b=IhxbLVWlxIATWCAWUHZ9aDv3UzKB6Qt5M9nZpaIQC6kACHJoWDLwUrklWzGPin1cXg
         0o7v3Doqe8WZQ0jQZ/vq3hiFPGAqXy9U+hggLaLNpzcpD0CxeYoNKiCp/n2L+gIdYcfk
         Lzj2SWeR1QVJXDnUToC7SUYarWUUVFKqydsYyjWEJ0SblAcddHB9HW+sjG5/Z95sdzvm
         Tow5o/fvN4pqMfHPuFovKDBIrzvHcQrTd8HItc1r678ZA/XBe655qHwffDb8FhJS1jog
         CrcY/3NEYBJSx+d/+NxUImSVGd2z08m/7Xpt7Xyxrig4uVBvPC2/e9HYA8JhjYuBXwi7
         BtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764293614; x=1764898414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCmoVsJTYhvhdEhqnCuQdxLwDfWSRN4iQRhiwDtzkSM=;
        b=m0EHzpfg2SljoejtsJTpSGCXNjDtvb3Lrs4ib1NcNlkfLgJ2SSkLNm4n7b0ZpY88P3
         8bINFZ5Vec8iGb9JaMulCfdtdr2W1dVokey20xvinLGYN9vYz2Jx6aLj4bX6Vef0G+Sc
         t9hCiPXQACflGa9qe5YoJ1PHXu52rbdYOR1AwaNHcbUP/sg2ofz2DyItWpLL0NmA2pAq
         1cPg35fuZk4gs09Kz9rTVKr/CZIhUmbXTRJYgsGTzdf0rz+QkRoH6ftZzyw3W9wn0yix
         UjP5B+98DzIimC0dXUDqPESmMRrQRaaz2yJcksqtI1zpZpgL1jL46tnuYJMGQE4LPDcD
         jo5A==
X-Forwarded-Encrypted: i=1; AJvYcCWicm4lrmKbwMo6/z9zPWuRwYD01lATEnxtBBLjCtCNciJwil7APrZkcMzvOvUwcLYlISunrWLlmCMG@lists.infradead.org
X-Gm-Message-State: AOJu0YxJsJihSugRJfU9EM4FU19hswqHTbQKrX4iWiCQ/Zdu6nsnrnza
	SfAUM//8wSH0TDS6972NbpUePlW2hYz41LrZjJ7ZcMr+uDd0XgYd9RjVNOepr4wkS3Tmerpq+gj
	Guazhl2sSCLRj4y+PL6qI8qVBMwUyXCE=
X-Gm-Gg: ASbGncuCPLPcuIjCmFcQmPWswr2gAkXXL6yGo6g/bPaNrnv5TSO8V7VEpDzewJ++CAo
	uNAa67AZvnifRTYMyK0aqlYgKuRYdJwC1z2elaG6kWWW54VED3ASBHmiW6JM7kYnfe7LzERa/yP
	rm6hpaXo4sBXtcJ72Hf1lfQ4NyBLYnvmANNiuMqAzQP3U6L2zCR5L3b5t4Tj7oXPfKpZU9dJyIM
	glHfzUT4yXfcF81kjkVJDcaDQzkKRfPt7POZPfwXeW9CFM0HMUjK11kAxSKQlHlY4tG6Gg=
X-Google-Smtp-Source: AGHT+IE6nrHo52NkC3u4arv+NV93c/YfHBRAs+svXfCqzbJAogT20JAMk+GOCyu5yn5XMiOUt3k5WhNEc+/7Yy6kmls=
X-Received: by 2002:a05:622a:1a13:b0:4ec:ef6e:585 with SMTP id
 d75a77b69052e-4ee5894f748mr348305511cf.73.1764293614202; Thu, 27 Nov 2025
 17:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org> <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org> <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
 <aSf6T6z6f2YqQRPH@infradead.org> <3a29b0d8-f13d-4566-8643-18580a859af7@linux.alibaba.com>
 <aShkWxt9Yfa7YiSe@infradead.org>
In-Reply-To: <aShkWxt9Yfa7YiSe@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 09:32:58 +0800
X-Gm-Features: AWmQ_bnqkcJ2TfUO_Hy5DulnmQrOor9Eq1r7gxzBzqTjOKvbRCKHxxHaYPQTzc0
Message-ID: <CANubcdWh0zZpOqhBhWtKf0uN1+8Ec-RsHiSCQUFrqYXoux2-TA@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Christoph Hellwig <hch@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_173335_500718_62679D0F 
X-CRM114-Status: GOOD (  10.75  )
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

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8827=
=E6=97=A5=E5=91=A8=E5=9B=9B 22:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 27, 2025 at 03:40:20PM +0800, Gao Xiang wrote:
> > For erofs, let me fix this directly to use bio_endio() instead
> > and go through the erofs (although it doesn't matter in practice
> > since no chain i/os for erofs and bio interfaces are unique and
> > friendly to operate bvecs for both block or non-block I/Os
> > compared to awkward bvec interfaces) and I will Cc you, Ming
> > and Stephen then.
>
> Thanks.  I'll ping Coly for bcache.
>

I would like the opportunity to fix this issue in bcache. From my analysis,=
 it
seems the solution may be as straightforward as replacing the ->bi_end_io
assignment with a call to bio_endio().

Thanks,
shida

