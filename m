Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684DEC43334
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqQAL3N8Luk/zg+q9kaVtlB0ZEWpTPA1vvTdunhz3Uw=; b=Q/4vM+1R1lbPe0qG1Ki1nwaRdv
	zrKd07CYg2rULtKvjYq2n0l3JEPy2iu46E2syw6ck8W4zmBFi5luLg9KKpJ5/hpUkK+NGD9An3fwT
	XbJ6hI0aqYr8D92xtNSXCb+21ssYs/7u20VeFW+BG4swni44+gz+GhQYzAMehA2NPS8blhHjS5FoC
	KAMR9sBHDrLO3K5oCkSOocJUukcALnO2pU4uLliBfH1BIY22Zp4uUMkdayPfX0RX06gDlL91CAcdp
	DqFj8/FxbtoQCxPxQjIqIQZ4SNQ++2itaFKACSvhb3aOgbuu8oVo6beVWEVzGpQTDbh2+bET9oyUk
	ZbxmqjFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzMoq-003YBQ-RW; Thu, 09 Jun 2022 18:23:44 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzMon-003Y9a-VH
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 18:23:43 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-fe15832ce5so447046fac.8
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jun 2022 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqQAL3N8Luk/zg+q9kaVtlB0ZEWpTPA1vvTdunhz3Uw=;
        b=M24RoEN6+kIcJIjVqJwum0bvxzbhcmoZTMWsVl6mwk1BGDQ7oBXSelyfwvvq4t0ahw
         vW1IRuerzx5o7wVsCf6597zK/IlflZVQiJZ/M7D2y/2KbuiY2+ji0ORSvNxL1SFNjW9q
         O9N5LzRav2DtNsIJApb1z2yw/dz4QYDu0MLeTiEQHnN0waSBMGvU5farKc5iO/6Njudt
         poszWPHk4wDTe3YT8BOqctW/HTr2srMZNQeJXOVQ2KLYcZk3Mg8tYKQns5Yj/r1KyeMy
         ykYetj/vnoEtTDH0ZPTcqpSPk+1B6tVs2/Fdo61HWFeGerSAHSoqSfHCBxTeNG2xTEgH
         NuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqQAL3N8Luk/zg+q9kaVtlB0ZEWpTPA1vvTdunhz3Uw=;
        b=qwXxEoUUCwuLHvAZ+tswfDt7BhZWOkfcExlQ7+Rp6Qe2MToZHs2CfMHJ+LeWpq783S
         vRUXYM/VLVNMACYO2AQTlvxrdVzgXwDJw3eVIOeghNk9ZRJ+GcvOnF3SFecZzX3fVVxu
         vBYeEEAuJumQpRq9rFAa5TzDcNJexFjZND+Hh1KIsf2HPPcBPQe8t4JCSuywJDPWqB0c
         kVFTt/SGYNtoJdryua+nTf6JjwZPT38wxQCTPP3AgJL+zHGqTDrH18WLwvqB+DNsK20V
         Ely3wJityKX3TD/+n8qJ9Os3R0jEpY9hLuAOhI0hspGbzMKfCEpH77onnOV/IuvqCq3G
         JR7w==
X-Gm-Message-State: AOAM5302RTMBFbdUPhI3Ir3EfW9F5tytZPutFxcacuAMJmTfVkbx3Bs5
	aqVcqtvhwMK1XH7JlAhUIb0Ez2pGNl49Owa+C8sTc0KtziGduQ==
X-Google-Smtp-Source: ABdhPJyK9VdXyR/jh99bLvkb6f+uPPtYZSTZ276YCzYfvlAV7NSpavwhYASyxNTeTq0Nj7JHdAlGGtm8kW4Oqdi+koA=
X-Received: by 2002:a05:6870:5492:b0:f3:2791:b056 with SMTP id
 f18-20020a056870549200b000f32791b056mr2463729oan.269.1654799018842; Thu, 09
 Jun 2022 11:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220609173734.381654-1-vitaly@enfabrica.net> <YqIyvQdcASwatPx2@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YqIyvQdcASwatPx2@kbusch-mbp.dhcp.thefacebook.com>
From: Vitaly Mayatskikh <vitaly@enfabrica.net>
Date: Thu, 9 Jun 2022 14:23:28 -0400
Message-ID: <CAF0WxhmGzAaq4=gLM0jW2KwrpAxyZ=wS+i=A9N4=gaSdYnVypg@mail.gmail.com>
Subject: Re: [PATCH] nvme-multipath: allocate MQ disk
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_112342_046420_36091F44 
X-CRM114-Status: UNSURE (   7.44  )
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

On Thu, Jun 9, 2022 at 1:49 PM Keith Busch <kbusch@kernel.org> wrote:

> No, we don't use request based queues for stacking drivers. Especially not one
> that re-uses the same tagset with the lower layer it stacks on.

Yeah, I screwed up my test bench and misdiagnosed the problem. Sorry about that.

