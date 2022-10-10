Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4E6C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RpUSvVnWaGbOoIwxcuWyRel5Kf5muzD0mHkI19EVMmM=; b=rVPFPL55Y0GPSQVdsS2ct+mOQB
	HU0ORz5aClWnk6oREb3LCkLcbb7HPbZ2zlOh+ppCCQqoW6F27dD+CbwaWbNGzODNzOnq+zZW4jaJx
	7KtUYfKWbIZnUHrGbluIXge9q8JHJdxQ+mP+cFug9KhR+Z9iL9dD3AuWcPEYrYo65ql9U1GNsM+qv
	W+qPBqNmM9RcUw5iCUPeXy+Zme7+KSqiYoV/LvnyB/eReXd5ZEkIgIRdGZPfuJWwpG8DN9OqblJp7
	T6Tqe4MApVjvuwT3URoUG1hb7KG7AG5opVxzKjVBCDz2o3qCQhITIvw8xscJarDI7us+KZ0viqqKf
	oFp4JsNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohssw-0011hz-79; Mon, 10 Oct 2022 13:31:58 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohssu-0011hA-4u
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 13:31:57 +0000
Received: by mail-lf1-x133.google.com with SMTP id d6so16584153lfs.10
        for <linux-nvme@lists.infradead.org>; Mon, 10 Oct 2022 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RpUSvVnWaGbOoIwxcuWyRel5Kf5muzD0mHkI19EVMmM=;
        b=Sh54JfuMpHwEKxXAkdFj8nCT/Qexz9mu+YaW/MJKOTW5fEPqbMW+n56wDSaUzzlTyD
         W6maaxmQsJVVSo+82Bho6BjER15oIA5QvLcV6EZUzXtEUXCpArIKQRrHL0MmGbDc9G7E
         z8QFHhyn6aYhnqBZgCw2tZtU0LF07D90m7HDyEjUrcMeZswUEKKs1E2j6kGHbWpd0DE5
         pT7vGmq7JRZ7cEmnnuLsqaUEO2Zq9xmt/471Bvgr1HaeFwHX20M/Hv9ZeolJDE7pumaY
         iY6spfsVcIwi7YgsQD5TkJX9EPvI6bgmgIvHQsqLGx/BqxjAn1COp+j7bcWbiBbJpJ/8
         ZA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpUSvVnWaGbOoIwxcuWyRel5Kf5muzD0mHkI19EVMmM=;
        b=YajRgE3MCwHWRzC7nJMmH0GjlaVt8waqbnfRvZDOcGR1DJvTQg7r9EdMlIzdmSvAZR
         n4/VOfI+5IQvo/4Aa4wT3s3tvKsNOUw+/NHSTct5MOTnMVE7e61N7cico2zvdg1E2Q6T
         4shVly9kjRTTuQu590UAVSQnlarKn562F1b4CJFeJOLIyIzJCqZgfsSEVyOoYfIvf4hY
         pN/ckCSpH4SPe/SrSDGAC+JMq83j09sOpL82BTPW1eHZcAugogrR8TdU/iFiMYawV1JT
         T+Bxw1tzRlgYzp/biE5MnH0nPv5VE1m0zcfSGtdMxXGQQbpIjraFKnkjAfLrEtITs6tC
         QVhw==
X-Gm-Message-State: ACrzQf1B6xkuY2+AM24+uwOutSnRCuleQ8hcmIIkDIogBpgiTaJCwLYR
	aI/5FNQXHi7KuucrOY5b2RP1GafIWp8BnNjIcIQ=
X-Google-Smtp-Source: AMsMyM4XwbfUFAkoLu3m6gd65bR0pXwTQkyux9wM4Uwjov0jrCeInT8i/MmRJoPJJJnw1kV+SDjmLfPSiaqRES+FbQA=
X-Received: by 2002:a19:5503:0:b0:4a2:329d:bc74 with SMTP id
 n3-20020a195503000000b004a2329dbc74mr7363290lfe.77.1665408711438; Mon, 10 Oct
 2022 06:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220930001943.zdbvolc3gkekfmcv@shindev> <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev> <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <b6e9a4de-3200-f4c5-0665-8e919757035d@acm.org>
In-Reply-To: <b6e9a4de-3200-f4c5-0665-8e919757035d@acm.org>
From: Keith Busch <keith.busch@gmail.com>
Date: Mon, 10 Oct 2022 15:31:32 +0200
Message-ID: <CAOSXXT7RVg8rNWP4cDwV6Ywtu1_DSZ=XhAyMkKrqS1uCi5UFKA@mail.gmail.com>
Subject: Re: lockdep WARNING at blktests block/011
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_063156_223190_36E77298 
X-CRM114-Status: GOOD (  20.38  )
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

On Fri, Oct 7, 2022 at 10:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 10/3/22 08:28, Keith Busch wrote:
> > On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
> >>
> >> BTW, I came up to another question during code read. I found nvme_reset_work()
> >> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
> >> controller is already disabled when the reset work calls nvme_sync_queues().
> >
> > Right, everything previously outstanding has been reclaimed, and the queues are
> > quiesced at this point. There's nothing for timeout work to wait for, and the
> > sync is just ensuring every timeout work has returned.
> >
> > It looks like a timeout is required in order to hit this reported deadlock, but
> > the driver ensures there's nothing to timeout prior to syncing the queues. I
> > don't think lockdep could reasonably know that, though.
>
> Hi Keith,
>
> Commit b2a0eb1a0ac7 ("nvme-pci: Remove watchdog timer") introduced the
> nvme_dev_disable() and nvme_reset_ctrl() calls in the nvme_timeout()
> function. Has it been considered to invoke these two calls asynchronously
> instead of synchronously from the NVMe timeout handler (queue_work())?
> Although it may require some work to make sure that this approach does not
> trigger any race conditions, do you agree that this should be sufficient to
> make lockdep happy?

We still have to sync whatever work does the reset, so that would just
shift which work the lockdep splat indicates.

