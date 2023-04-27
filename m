Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F8BC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u54fgxU+CHObOkXsorNdjsGBCY6sjzZbJYTo0Qudxr0=; b=fczrqMO7odJdvV3GvqwOWGxq7h
	T15SOxWWh8w8LGFg45D1MM+4CDolq/qmZknINaD4tVrqCxloucIA1FtP1tQ+c77ZovQ5lnlHkZ0DW
	XFL3J+A+4rHfNT0QfFGXcd24whk4aWOMk44l/lI9farLo1noahzWP2lTSMAKtMF3rXNRax/aavpb3
	403FeYaY9ZyQM5dewQyFV8xIlQ+CpXAu1mdC+/GoLfWpiXraqlGR7qj1I1lxWI0LmR8Qd3nqncFXK
	VXSufXXz97sveaIWem/ol42juwUyRHE9HzztqPxgx7LYqahBUh7iwHy9KnhDkSHt2ArhX5iNSSffH
	dTdJlOdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps93Z-007aFe-1x;
	Thu, 27 Apr 2023 21:21:37 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps93W-007aEu-2p
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 21:21:36 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-956ff2399c9so1621174066b.3
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682630493; x=1685222493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u54fgxU+CHObOkXsorNdjsGBCY6sjzZbJYTo0Qudxr0=;
        b=U5AL74lBnKYvwwkoI/X9p780B/xtdotPPct8+yyQWJHHGAiGVQvKotV8zL6Ks/Cjri
         Mj2Cm6PQUw3vihklIu6ZqW2Fuktinv0bnkuqRVIGoedtED1WrcIn8VqzAw7xJXZxDY9/
         Ha3dSEwQuWLn13FjTUNI/Lo9cuSe3jq/+eWEfqOkjcq4fCiym3xEAV4AbM8L5ziUyVi5
         TjOsiYytoveZA9UOYxxQGo2aOF/28oJuFR8WOZyD3gGMa+cVBQzeVVI5XopSN0vQuEoM
         kl9OF75PKmZco57AZqcEmxeTZOMC+RdAVKxUyaAtHfCufDgkDSTKvhwZrfxYZYTIBF6f
         Iw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682630493; x=1685222493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u54fgxU+CHObOkXsorNdjsGBCY6sjzZbJYTo0Qudxr0=;
        b=Q20LrpIux1Lg4QpI4YuyBS4ociKY69T+9aYf9STmCjbtbhpZabjqWXSuV98jhvGB5+
         Kx/DJQDtlZaaocAr9+1k94F1GCJxEnt0Ji8O/2T9hEMF8Cg2KEBLPSF6J+GwTELSTm1v
         mMSkIUJKGd6Zr4rSrWjubX8t49GCe4XxLja8m32bGuKA0n4EvMh1MEUztnL8cJGzfMUa
         qq78vo2jZvl7wP/I6B/IrU3zCcbRPFqC+fDIICEJkLKikTh/Cnl5V8b39xI+BGIbRCcg
         ypahJSMYitTBdfK+OmnSAp00Yocniq5jX4kuH9EnJucxUNsJJozHOWGIUm8FYQ5M9SA/
         vK9w==
X-Gm-Message-State: AC+VfDw4gHB4ugkRAo9li2VAkzuSSDL1S9mvnSS9xcScgyMRnYXRhoiU
	ZXJh79vtlD/JQdFUexE6lfU68/agIazBtnKCbnMaSkd+KZo=
X-Google-Smtp-Source: ACHHUZ52WFkXaLfiEbgmIMaypeOzgZeyRaxtLyZhyu9SWJCb09T6yjJZcw3hDDy2f+soUqzylztNzxlwgHGJrsE/xhY=
X-Received: by 2002:a17:907:608c:b0:958:4c5d:7dd2 with SMTP id
 ht12-20020a170907608c00b009584c5d7dd2mr3194525ejc.72.1682630492901; Thu, 27
 Apr 2023 14:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
 <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com> <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
 <ZEre23NoKOB56eDj@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZEre23NoKOB56eDj@kbusch-mbp.dhcp.thefacebook.com>
From: Wang Yicheng <wangyicheng1209@gmail.com>
Date: Thu, 27 Apr 2023 14:21:21 -0700
Message-ID: <CAPiksxOEFDjHh4OrkcuBCMe59vf8_CE=AHeCN_+yFCe3_ry-2w@mail.gmail.com>
Subject: Re: Seeking for help with NVMe arbitration questions
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_142134_920074_7188806A 
X-CRM114-Status: UNSURE (   9.31  )
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

Thanks a lot for the prompt and detailed reply!

Before asking for further clarification of your answers (thanks for
being patient with me :) ), I'd like to sort out one fundamental
question first. When we're talking about configuring the queues
(default/read/poll), is it really the software queue or the hardware
queue in the blk-mq model (figure 5 in this paper:
https://kernel.dk/blk-mq.pdf)?

I've always been understanding the configuration procedure as
distributing that number of queues among the CPUs. But as you pointed
out, if I only distribute 1 queue as default, then the cpu_list will
contain all CPUs. It gives me an impression that the queue type is
really about the hardware queues. We don't need to set up the software
queues, as they're automatically affinitized to the underlying
hardware queues, in order to make sure all submitted IOs, whichever
the queue type is, don't need to transfer across CPUs. In other words,
if I allocate all 3 types of queues, there will be at least 3 software
queues in each CPU, corresponding to each queue type.

Best,
Yicheng

