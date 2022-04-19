Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971CCC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 17:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9TRLt0umpK42xe/joZUuCtcbZ6R6cAmp1bJxdUcgm8M=; b=vGom+b0/hEG3MXPO115Q2GRkoY
	J6g7kVe5akM2C+GKAAOPlTxXvFy94iwrN8osn0iDNoCZ/iVnJV9ldobteRQj+L0W1tumqS3nhXjmc
	frSmdvsja1csV9IYtDEWiowU8SIdyHGx5W4WlKzzIqUgbpYsTMveXqL3tq9zKlGsTmyanDEVGxThs
	R1Wbr5sPi+kb129vKzK8JkQDbBm0TAzP05OyPoZG/9YagXk8V3oVNMzLQV0tROwmx83MBwJgWKQQ2
	Zxm2YHGt8FVPM0lL1fWvTIbakgFyBarvM+ByR4zbYrXL5JFZ/nM4QBv1q+8VCW28KlN61YKhtMBGB
	eYyW54hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngrry-005PNe-Vc; Tue, 19 Apr 2022 17:42:31 +0000
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngri0-005KrV-9R
 for linux-nvme@lists.infradead.org; Tue, 19 Apr 2022 17:32:13 +0000
Received: by mail-oi1-x22a.google.com with SMTP id a10so1425803oif.9
 for <linux-nvme@lists.infradead.org>; Tue, 19 Apr 2022 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9TRLt0umpK42xe/joZUuCtcbZ6R6cAmp1bJxdUcgm8M=;
 b=XJpQjzjjctWjfGZZgTtSKyIT83IHM45dieg4WsW3ak2hpJ3kPz5fBe7UBbK0wNxoIJ
 ivMYTJzH5nSfURv5rAgqT6W3/nbjOJr+K2C8yMDpYzRAKNtea0GU2KQn1qWFcL5BXG+i
 j3O4+GnfOhQgA4GdyKvqKANlfxsFsCSfIG/uYL+yg/zvZNcUEokQO28bOaFAJcgOSn25
 aMaunSVG5GwIkyUnZCC/xZ/W0HCTmgipivwurrrbRbvCsYM3KAmnuJTz1Po7XK7xT3aW
 WQF5eQ83vqBHR4woYK1i2LaQtI6OjFRYQuFmL3uxFhbr73u1aqNW6CJgmR3PWdWScj2a
 t1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9TRLt0umpK42xe/joZUuCtcbZ6R6cAmp1bJxdUcgm8M=;
 b=mjpLlgG/0/5T7bizcV5A3Yx3fBvYan+5E9qlm38aYN4faIdK8zDuEhjREL94B+yyy1
 quQMrQr+Lu6Bf8lg+6y2ee9V0H1v7LgkkJvkkc9yOVPqsX0LcZXIzVWS3DlMS/O0UvCj
 B516VR18CeCbQpUhyVTsifY5CCqmUryL6qoZhvlWZXGJHevPuyGgTf/bpBZHDGdY9GtA
 P6Sg2K028ejoHQ2LU+wOvOIUHKQWZJvPKkqB/3NK6BEXw58lsFt038ffiHeURNysqp7N
 HLkTBvK7gR6cWAwa7P3K0rNOiygoDaLHaXjK2en3C49nJ0slSwzDp/7gXktBhE1m4uj8
 0KzA==
X-Gm-Message-State: AOAM531B5XbO1A0isBYsciyVwTTkcmaVLH/DdIoTwpLFYkgtsDUoGAr5
 L/yyNBIYnLJB6xTtVcrys985z2nG25lFoiJxfKc=
X-Google-Smtp-Source: ABdhPJzjvbZzKw9AmTVeqJqXQyrX4Xm2mQCN5iTfSaun8qvgGqsIrB7jYyjuk+QaIV2MI5zrGwOmpJwfcJbb0uNqSDw=
X-Received: by 2002:a05:6808:f8f:b0:322:b4ce:a10e with SMTP id
 o15-20020a0568080f8f00b00322b4cea10emr2758955oiw.160.1650389528530; Tue, 19
 Apr 2022 10:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com> <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns>
 <20220330130219.GB1938@lst.de>
 <CA+1E3r+Z9UyiNjmb-DzOpNrcbCO_nNFYUD5L5xJJCisx_D=wPQ@mail.gmail.com>
 <a44e38d6-54b4-0d17-c274-b7d46f60a0cf@kernel.dk>
 <CA+1E3r+CSC6jaDBXpxQUDnk8G=RuQaa=DPJ=tt9O9qydH5B9SQ@mail.gmail.com>
 <f3923d64-4f84-143b-cce2-fcf8366da0e6@kernel.dk>
In-Reply-To: <f3923d64-4f84-143b-cce2-fcf8366da0e6@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 19 Apr 2022 23:01:43 +0530
Message-ID: <CA+1E3rJHgEan2yiVS882XouHgKNP4Rn6G2LrXyFu-0kgyu27=Q@mail.gmail.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Keith Busch <kbusch@kernel.org>, 
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_103212_414554_8ABCEEA4 
X-CRM114-Status: GOOD (  16.58  )
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

Hi Jens,
Few thoughts below toward the next version -

On Fri, Apr 1, 2022 at 8:14 AM Jens Axboe <axboe@kernel.dk> wrote:
[snip]
> >>> Sure, will post the code with bigger-cqe first.
> >>
> >> I can add the support, should be pretty trivial. And do the liburing
> >> side as well, so we have a sane base.
> >
> >  I will post the big-cqe based work today. It works with fio.
> >  It does not deal with liburing (which seems tricky), but hopefully it
> > can help us move forward anyway .
>
> Let's compare then, since I just did the support too :-)

Major difference is generic support (rather than uring-cmd only) and
not touching the regular completion path. So plan is to use your patch
for the next version with some bits added (e.g. overflow-handling and
avoiding extra CQE tail increment). Hope that sounds fine.

We have things working on top of your current branch
"io_uring-big-sqe". Since SQE now has 8 bytes of free space (post
xattr merge) and CQE infra is different (post cqe-caching in ctx) -
things needed to be done a bit differently. But all this is now tested
better with liburing support/util (plan is to post that too).

