Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124A3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Mar 2022 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1nMim+eDxDf/5PKoFQWnd0bc2gDZtzpNJd3Is7aeZY4=; b=DqKPOh2pRomAUD2gFNPNdGYOMC
	mbB5M3UTb4FM0k+4ahgCx2Rmhriw6uxzAvZ7LZzyOFXA8r+nIHmss2p3JU5C4u8RBwKbwEzkTFjxy
	IluVvXImmsXmY49e9EZ9AsLgY1t0nPWW24ZvngmsERa3zh1zMb8hRyPA4xvHHRJHYMbjrn6XiBX/S
	XkJMMvcl998lQNxQ9VwX9reU52OckWSd1gkwxvEG+cxlRIuMTazkHdRf3Ijkq/GM4BPWVKhqAirLt
	qvWoUShmgKdMhuGaRC+dtOmzwSXBgeANnScusZOd2d4sI0Nd1c0TqDXssV54NOHOXLFMCO6d6iSzB
	nDO6xJGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZY9r-00G1VR-Lk; Wed, 30 Mar 2022 13:14:43 +0000
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZY9o-00G1Tk-BD
 for linux-nvme@lists.infradead.org; Wed, 30 Mar 2022 13:14:41 +0000
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-dee0378ce7so11636447fac.4
 for <linux-nvme@lists.infradead.org>; Wed, 30 Mar 2022 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1nMim+eDxDf/5PKoFQWnd0bc2gDZtzpNJd3Is7aeZY4=;
 b=OO5qym66qk0XlxKttsyfA46hGzSbNVjvrT/LxJlPEiiqAz4AOlcErzm1ffT2k8o7B8
 307OYsfFOYzDkF/kiz6EcRTBnGTWAgeCDdfnAU/EdCSMlrhOaZqmo6eOAVojefshckW8
 ndlDVekcZ9riKZweXxxyTUmP2zQFfc8uFG+7aLJm5Td3z4ZLEH/S5PTpGFT4BuI3fWNa
 SV86A1+K0q2lgb4oxXG3dEzPkkarlR+K8+VudDymSYFvjfBUr25FQufpE4iv+Z5O7/LG
 DtKFfqdbLu/ZcIyJjMSWXwa8jnYTwmhMf97Be1YIgeptlIyx9apeyjB7LpmQEMt0jsa8
 9Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1nMim+eDxDf/5PKoFQWnd0bc2gDZtzpNJd3Is7aeZY4=;
 b=b6sHKh3BmzmKMYWOQCjKcEHYAG6Zvwkio5oxdXQDtiqyg+qo44M9qXT0i5zo5vRwmr
 eBXwQ5l6wxMM3r0KmVHrxJF0IqvTBj09PvwJvS6dKT7piy8U1YXSE0DxcR10heclxF7D
 s+kaZlUaFeVFZR8xwrVYIn5w1sqbohHqa1JnLJUIjS2qQY0APOGWXyQyon68YthcQT3A
 cosQI95Pbg7V0yKcJGjzbBXILYOV87hroeE4hv03Plb4i8JNAMpr8gLUyVgZy8PiPXbN
 oWc87/LxGt8MQ2egDc42idOWvySKKqIEneGnppxHy438MFwuuCdMbTVi8bO95zklOhXU
 pbng==
X-Gm-Message-State: AOAM530rZcjYFNxqoL6z7DOTjpmbyU5AaNM3vod448jpb/3N0n3ZvclL
 sv5DxXOiJnxiQr18ATmc0v4pmALZa54QzurSyLo=
X-Google-Smtp-Source: ABdhPJxjFqw1iL+mE7nQo5TNi+cZ3oFVY7P5u/Ty0k4rd+2f0SFlkNu4vS/GbISpH8YqSLOOLjyeWPP6F1006rYG4GI=
X-Received: by 2002:a05:6870:c154:b0:dd:986c:afa9 with SMTP id
 g20-20020a056870c15400b000dd986cafa9mr2052493oad.160.1648646078446; Wed, 30
 Mar 2022 06:14:38 -0700 (PDT)
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
In-Reply-To: <20220330130219.GB1938@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 30 Mar 2022 18:44:12 +0530
Message-ID: <CA+1E3r+Z9UyiNjmb-DzOpNrcbCO_nNFYUD5L5xJJCisx_D=wPQ@mail.gmail.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220330_061440_419156_34EBDC49 
X-CRM114-Status: GOOD (  15.39  )
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

On Wed, Mar 30, 2022 at 6:32 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Mar 25, 2022 at 07:09:21PM +0530, Kanchan Joshi wrote:
> > Ok. If you are open to take new opcode/struct route, that is all we
> > require to pair with big-sqe and have this sorted. How about this -
>
> I would much, much, much prefer to support a bigger CQE.  Having
> a pointer in there just creates a fair amount of overhead and
> really does not fit into the model nvme and io_uring use.

Sure, will post the code with bigger-cqe first.

> But yes, if we did not go down that route that would be the structure
> that is needed.
Got it. Thanks for confirming.

