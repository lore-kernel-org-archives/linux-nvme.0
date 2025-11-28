Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908B8D111A8
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D5P89IZigPftxBdPjv0hBiMVJle7Ici8oyWvWVUIt1w=; b=N3tcviW9uInMeDEtYUNlm4Oomu
	fb85P5fF60Fj2+0qkp2FkqJUalMtTD/ZRnDcpQzckWAwsKLbGvmxtBC0lPKOS7ySupexFImVrttdF
	gRuMlif+5VDQrfYsy2dpgMeJ9zY2bM7VRMPkwwbGFWQvPDAlfDE/DFPxNZ1x0cjSNIN6zUGARjkEn
	x/buVsRXlMHd6MnZ//Bs09Jw9+H5ZradJli7g1L1yk0v8uHwjFrMetUtH6HOB5c+Ryb+d9TMaOENe
	UYVuaOH9ASMn+G2pLdDAifte6b7FsbIv05BmykQy3m+bLPvxvvXT1e2NoIXHxxcQM9nTeF9pweHH0
	am2MDFNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOnJg-0000000HOlu-0kKe;
	Fri, 28 Nov 2025 01:30:32 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOnJd-0000000HOlT-2JaX
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 01:30:30 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8824888ce97so19261316d6.2
        for <linux-nvme@lists.infradead.org>; Thu, 27 Nov 2025 17:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764293428; x=1764898228; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5P89IZigPftxBdPjv0hBiMVJle7Ici8oyWvWVUIt1w=;
        b=NIZ66zP5Xb7P5xvoQTKbc5eVxg05kpEZ8MS8sgyg/x6kSBtM2JjBYKOSO1Z1N+Mjg7
         s/1gyrZfjKP3gUCcwzCiH88oQI2zdAFOA5gv546t06n84gNiA8vLvSAcpSpsrn5XDCM4
         8LBbTw/yMOoX0/pAlJKijC+mk7w/G2HI2t4p4I5tDg6d+LcOLGdSytbZqsv278Y0xW/O
         V2BDjduyWpC0LdO4Y8W/c899xNdf6QqRP1O8BjowYhWT5xaKCQhTIWHvh8i/iuWifUEl
         YaqTP0dqSiYhVVOxXAwoXjMTnBru1sakXu851ba9VIWPnmlIPagEbMoAIcooj9gwgOF8
         JoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764293428; x=1764898228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5P89IZigPftxBdPjv0hBiMVJle7Ici8oyWvWVUIt1w=;
        b=dIJY7kl6h+karXfPJ6Mg8it+SrTsGS0QRvIzLimIEsRWYoXtpPJqVaHjVG0Tk6h+Y9
         macmAFtz71w6+5xwsG0/uUfZVxi3MAt63zSXtAHH/4s0wJWSG8VlRoxICVY5pg+ppwUf
         Cinp6UhlHzqR2Of27nE/lhCzY6n37DLJ4nRKxj+0GomBth6i3lJ2e81/YvGZVykHOo7+
         eSOZYod5/0BGNDKwrsb9wZYxY9RwQwnaliaTsjTtXq9c/TLdFESldre1tA6EqgRlXRqi
         Jcj0sPuvi86O6Ir/u05TiBFtN4ebk5TCtlHC8WkghRjKI8jiDwfwMaNiasXwpLlQ0ta6
         k9PA==
X-Forwarded-Encrypted: i=1; AJvYcCUfI/cP8w+HEbSt1n2tEKF6ffuaYn86pN+d8HBrupVuZk2dgOM8bPvDeN7AfHsa4JEAVagmJbYZc6pR@lists.infradead.org
X-Gm-Message-State: AOJu0YxfXxkm+sywbYayN//oue4q7uX7NGB1q+GAWMLJE+MM07oX1GIG
	Hbrn66sWYGXWceoiywPdb7R+ik6plW5ZDlFcTKoPyKOLHI7CdSt3kog4bssaRGC4AmubLBzKYDt
	vlgCdj1PmkjuZRsMoFy3GJPL2dno/G3E=
X-Gm-Gg: ASbGncsRUl2ePBi6fy7fhEg9NjOW3EoZM+s134uhBmDA/6zTInfp3T+RrR7Cs8iYXdk
	Pmsww5YIYy4XlPeeZZai6BVwEbgIx3xV25UZJpVj7yc5pE2J+M7fXPW0ZtzPuLtEsAhVw/KFu5h
	0fJr2oEf4typCoOrRwTBQgI1BsbAn+Il3d0ExoGjRajs/CAU+kh35umGHZb5/3gW00E6xexGYYS
	ISUBtj5KTCNYxBUieGVsBdiY7JT8ilGWdoJqHQRXZNMcb6IQsLYvjuBVZ4cTvGQyI8GRQk=
X-Google-Smtp-Source: AGHT+IHLwC+N+hhLqdlufghZ5fhnM4rSYysjvUV/1fIoNRweHCYWM0pQrvWGMYNUf8igtQ6F3vcEMbZAHieS7voSeP4=
X-Received: by 2002:ac8:57d0:0:b0:4ee:827:7e62 with SMTP id
 d75a77b69052e-4ee58b05b62mr339066531cf.82.1764293427985; Thu, 27 Nov 2025
 17:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org> <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org> <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
 <aSf6T6z6f2YqQRPH@infradead.org>
In-Reply-To: <aSf6T6z6f2YqQRPH@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 09:29:52 +0800
X-Gm-Features: AWmQ_bnZka8N-6d6tnub2wv_mKK_srvt07g0FExU0PMtOqpsh3yITqQM0jweo2c
Message-ID: <CANubcdVhDZ+G5brj6g+mBBOHLyeyM9gWaLJ+EKwyWXJjSoi1SQ@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_173029_634027_27937774 
X-CRM114-Status: GOOD (  18.38  )
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
=E6=97=A5=E5=91=A8=E5=9B=9B 15:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 27, 2025 at 03:05:29PM +0800, Stephen Zhang wrote:
> > No, they are not using bcache.
>
> Then please figure out how bio_chain_endio even gets called in this
> setup.  I think for mainline the approach should be to fix bcache
> and eorfs to not call into ->bi_end_io and add a BUG_ON() to
> bio_chain_endio to ensure no new callers appear.  I
>

Okay, thanks for the suggestion.

> > If there are no further objections or other insights regarding this iss=
ue,
> > I will proceed with creating a v2 of this series.
>
> Not sure how that is helpful.  You have a problem on a kernel from stone
> age, can't explain what actually happens and propose something that is
> mostly a no-op in mainline, with the callers that could even reach the
> area being clear API misuse.
>

Analysis of the 4.19 kernel bug confirmed it was not caused by the
->bi_end_io call. Instead, this investigation led us to discover a differen=
t bug
in the upstream kernel. The v2 patch series is dedicated to fixing this new=
ly
found upstream issue.

Thanks,
shida
>

