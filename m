Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC217C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 18:23:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B617D2074B
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 18:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RRyAJu/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B617D2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JUDf7C8qMgu9TruBcBBw/NtVNTaSSdc812YFyOZ67g0=; b=RRyAJu/fDOt9xD7pt2tSSOBYI
	R/Qi+ibj85NLN72boGqslSJOAdAjVpaC/50pRV2OpONj4e6n/TW0WqQVe7s/n87uQu9LC5H8tsh1r
	vz37by8WYmi2FwbSZlGnMOKxaj/a7VclxS4HolUAirfvx8E2Lf1sb6Yzojvby4ApCSWgcUh1z3+kN
	VZm2vCb8uYeOStNk73HoWud//cOfiUMjT09Jrtz3SKf8B6nhObch7RG6KwWsKu6VCwjIMG/lMHzmS
	v6y3Cp+H4bk5831hq2qtnhPuI70tVy3xxpu5jWGXXWVhckXX6nuR4tynYkzLx6nH4te11cf3mzQLX
	HmmMzUSAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jw8XV-0002uZ-3A; Thu, 16 Jul 2020 18:23:25 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jw8XQ-0002pn-Nm
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 18:23:21 +0000
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mw8cU-1knyB43bwy-00s9qi for <linux-nvme@lists.infradead.org>; Thu, 16 Jul
 2020 20:23:15 +0200
Received: by mail-qk1-f170.google.com with SMTP id e11so6460306qkm.3
 for <linux-nvme@lists.infradead.org>; Thu, 16 Jul 2020 11:23:10 -0700 (PDT)
X-Gm-Message-State: AOAM5314Fj9+bgZO281vZX6v4IP5a+DYGvKXspMU6Xhb/n0rA52sIEte
 VI2/7G0WXbbnvmoY9R49rY/kHYY5fC/t2i8uwmI=
X-Google-Smtp-Source: ABdhPJxGrriyRsR3c/KbpnjkC2s9ZK2i9yjLtrI7t9taPXMe6YEy79uW5SDiSgg7Rvt4nATRSACGzmEr51YGyOvKzdk=
X-Received: by 2002:a37:a496:: with SMTP id n144mr5371218qke.286.1594923789486; 
 Thu, 16 Jul 2020 11:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
In-Reply-To: <20200716141534.30241-1-ulf.hansson@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Jul 2020 20:22:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
Message-ID: <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To: Ulf Hansson <ulf.hansson@linaro.org>
X-Provags-ID: V03:K1:pBNKhkZweV+7rNlDK7Z+eP2oVRlQjl1DEgQrR1pPmLkbBpUZqev
 FNzIv4mmJId6IiPuF0s8bViBZWiXf2rgQh+8i0Tl8JZLh1oubVIGyOoACQ5U5cGGyuYFthJ
 ImIubrAxKK+jlRm/g+Ho//o0M0ojGLylcm6Cinzxkdt6rSOsgt+REfKZQN/e8XtorpuaF7J
 oYXof+u9r+aONjN4BeEnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4crNCgM/By4=:0pMk1nr3wFw/MRn/hGAsjH
 K9uNh8azjPt3PSWa6xAIPRauC8/R+rCagF2ENMRKv6+NtkMOcJRq2CAJEOZvLDbPvEJqi5ggS
 UsOnOdaCPIArNJDNXLmJD5NGIO2ZQZVi8hf50PtgqcDqHZ3MJZCKu3vr5gfProtgUFPypZ7o+
 zgti97ShB/CZF8AOOVYk4Q/VKyuO6O4oUvn1Yr4ZSnUDtu/3tere6mvn5Snj+4h5Ymrk3gcKf
 C5YYRhgDxuod6uhoNB204LW57xt1mAH7SmhNXOLFrhfCs9rlzs4k5rVTYbaza2eoYcyJkOWC+
 ApK3G8zZQWdyVQEpy9DHw904oJwz/6Rga8gn1PTPXme64CMwsd+lonSTCBTBRvhZVe/4ykF7m
 L1+wUyq9ul0O7JavsjWhnUQ++yhGRkBNMrKTlh8mBC7yU0/4ttLz6twC1GPUoVN5G5YWvwOZ6
 1IPpS28R2taztt3KF8MPFunq9o6lPW5g8Ri9ZlVO6j+wM4ynsXiwc8kQKfxIydTLwb/cWYDdd
 rqeux+/sVRVCBHPjxkkPfN1Y2twsrsx4e72E4Bgv/FJ3jsRx3BBAousQ32cB9lqANSrOCI9Op
 vJnW78xO08csXnih8ER6RhrpYo0ZC/uYqoqhMjFG25Lhq52GAt3jbF2Ty/W6KcFn8Rp9hYaDN
 lKWxavJGlcpMzg6d2ntiGiLqbMkI/CU1l8PfxhfxUxdbNj2NIpurhktnTsbGqt7ow5K3iK7Op
 f0lFnJEgm74ehojm2g7fx40Bqa42xdDNgcILnCLlysodFhQZUtBlPVzefNyktyUrB8POETyff
 gTkX3p36au2byXnGjgMh71R+ndt0EcE1NypY+zX5Xd3ZBQq/J7UCzZ0FDFPPMxnuUyYxP8BA+
 iSXSAEDWYXFGXj+mi8D5QnJ5eHoGkKX9ll6vy+ZUoYGCWVsTFrQfNaLgDLr7wdVBWRAslWF3Q
 Z9pWnc8UNQLPNhNzdT05r0pRyxbCnQDObjBkPH1pkBBJdVfAMD3Ro
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_142321_041761_5FFEBC9B 
X-CRM114-Status: GOOD (  14.95  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Rui Feng <rui_feng@realsil.com.cn>, linux-pci <linux-pci@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Adrian Hunter <adrian.hunter@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 16, 2020 at 4:16 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> +       /* Continue with the SD express init, if the card supports it. */
> +       resp &= 0x3000;
> +       if (pcie_bits && resp) {
> +               if (resp == 0x3000)
> +                       host->ios.timing = MMC_TIMING_SD_EXP_1_2V;
> +               else
> +                       host->ios.timing = MMC_TIMING_SD_EXP;
> +
> +               /*
> +                * According to the spec the clock shall also be gated, but
> +                * let's leave this to the host driver for more flexibility.
> +                */
> +               return host->ops->init_sd_express(host, &host->ios);
> +       }
> +
>         return 0;
>  }

Does this need an additional handshake or timeout to see if the
device was successfully probed by the nvme driver?

It looks like the card would just disappear here if e.g. the nvme driver
is not loaded or runs into a runtime error.

     Arnd

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
