Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DEAC38159
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kd9+V7ZRlXGnYXskOGGGSl8CVPf2TRZzoIuwIZRzvPg=; b=Ssi93kMtq/LZtCfhT3NaBXJd8e
	wdlh19lYpJJZjRvuvAazgZKXYnoGsfis73wzC0YCm38ioABZAJP7QH+Ll5+ZBztOphLoqfMPp/sez
	lBtFm3zMWchMy3VbxRReN0gcXYPQ1snwTIzKdFZLkqfalGoUs5uMeU0zlgOrjEH0GtNtmnXzqTnBY
	ZDToHq2oY29xNnbbbHNdB8sSAvE1xC06QB4PdTa5M/xOv2XE4c+azGPXvPzhSg9znQLLWQhf794EI
	FSolNiCzijjvHeTLozFtiZ+ofoqi+SeY1b1wN1tjumyl7dr8IEv2YJUr3YaiSxYt44mPY4H6d8zSC
	tGytJGLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI9zE-001UXo-R5; Wed, 18 Jan 2023 15:04:24 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI9zB-001UX1-77
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 15:04:22 +0000
Received: by mail-pl1-x633.google.com with SMTP id c6so37177028pls.4
        for <linux-nvme@lists.infradead.org>; Wed, 18 Jan 2023 07:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kd9+V7ZRlXGnYXskOGGGSl8CVPf2TRZzoIuwIZRzvPg=;
        b=ClQqpGilsu8jFE9JkyDsMo7NEJuEGxD60Y+phlWeRVvIeG6Oy/4Kf9GQiOg6rqPBrF
         WHOdg9/2YxgVBk33qX5inpJyhgnDIr7//tuXPrwadpgxZk5VIQv29hopzCtP3LctXeN5
         QF7GR/Z7SVP1n0s6kC+v79+4Ntrq4yEpgZGuYo1g7WkurzhR8HxUz6qA7Pi63RYTSrHL
         WmFJOb9689CA5AKwhX5n62qZnoDIWLMun1HmTJDANZ4Th8qZyOXgcAExa5o8GQAzz50a
         9r2jb1xMcvzJik9YdUnsYyOxvW+71S8nQcTP7DCzqhIhNNojQScXYWaD+LVPw5B47r1f
         8kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kd9+V7ZRlXGnYXskOGGGSl8CVPf2TRZzoIuwIZRzvPg=;
        b=xN+ybFh2GkiMhppUpyNuQmmogiZ6ZgjTys4g1HCZF5E9BTqZfCthVEb7QtTo5RhfHq
         wOzPSZrrgMMhsoXQxRoaQ7RDqByRDw0R0Og11PJ998CFZYx/FkcHptC1+vaogimi1OWk
         0/kdA2sBpdGseJ4B39wO7zkgTUuuLxDXJm1jFthRdjqD1dL5x6sBNTzJqx8mrd8a8DvJ
         EPcpSlDSTYUXOEEEjPZBIyJts2g1hqVp55wkaIkp66/FfsjMYjfcuVG9PDvJyd5FPZ5D
         KAsKQGyMMwim0a34vFKIf9QjFDRIm2/g3xTxBhaGY5yH/4NJW38gG3+j8Q/ICtgskJiv
         +AkA==
X-Gm-Message-State: AFqh2kq/DNSBJinJXb7bKq33BDUoumw3YYtz1ypiVhsDhGUsTiLKqbou
	wF90qlfVX0iiT/G2+eSgwt82RTauS7TcbuBB2+5dePdCjUH7OilZ
X-Google-Smtp-Source: AMrXdXtmzOopxMEci5Lyj8vQDPwKXtgtHDIJ6gIXNg2ZPsBwOzdyQqOz4SPpKvq7UFwLMfl90byIi6/eeYbSuMp5F7I=
X-Received: by 2002:a17:90a:ea92:b0:229:189b:6fee with SMTP id
 h18-20020a17090aea9200b00229189b6feemr708619pjz.221.1674054258223; Wed, 18
 Jan 2023 07:04:18 -0800 (PST)
MIME-Version: 1.0
References: <Y8AG21o/9/3eUMIg@cormorant.local> <Y8W+H6T9DOZ08SoF@cormorant.local>
 <Y8Yq5faCjAKzMa9O@kbusch-mbp> <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com> <20230117192115.GA2958104@roeck-us.net>
In-Reply-To: <20230117192115.GA2958104@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Jan 2023 15:04:06 +0000
Message-ID: <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
To: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_070421_295462_197011A4 
X-CRM114-Status: GOOD (  13.86  )
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

On Tue, 17 Jan 2023 at 19:21, Guenter Roeck <linux@roeck-us.net> wrote:
> Anyway - any idea what to do to help figuring out what is happening ?
> Add tracing support to pci interrupt handling, maybe ?

For intermittent bugs, I like recording the QEMU session under
rr (using its chaos mode to provoke the failure if necessary) to
get a recording that I can debug and re-debug at leisure. Usually
you want to turn on/add tracing to help with this, and if the
failure doesn't hit early in bootup then you might need to
do a QEMU snapshot just before point-of-failure so you can
run rr only on the short snapshot-to-failure segment.

https://translatedcode.wordpress.com/2015/05/30/tricks-for-debugging-qemu-rr/
https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/

This gives you a debugging session from the QEMU side's perspective,
of course -- assuming you know what the hardware is supposed to do
you hopefully wind up with either "the guest software did X,Y,Z
and we incorrectly did A" or else "the guest software did X,Y,Z,
the spec says A is the right/a permitted thing but the guest got confused".
If it's the latter then you have to look at the guest as a separate
code analysis/debug problem.

thanks
-- PMM

