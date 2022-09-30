Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D85C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5e++Bq8byiSeO9h99CYt5V1LItyqEPo3VTEHQk8BylQ=; b=ShBOEatAjXacI8CQnRrzYL+EJX
	KD3j8HnwtEeeV2y/2TGGFzZhMw1+WLMt0OcT/6gfYk4yQ3M9Aygs/MhftsP3pIJjC8nQgtMQdYl9Q
	zg2fLH9MUwKWqf1pn2XRVRdNbXR2AJTpOg/eU0+Gt5qSsHd3SfTKc6uvlsz1Qjnl2fgNQFPxxQif/
	NPaT2wlMH3SgCaADJfK52vv8UmkhIHMX0IQ5Fv4BzdsS2gcdY2Qt1z/TEdA9EqJt2UUVON+Q9dGiv
	wLhfGrYT8ze/fy1HMpVZaMpClH2m5sJG23Tj2yq5xVvQRoejaE5sJgxlGq4xZEagr5yAQh4ScWch1
	EprVQA3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeChU-008Qok-6X; Fri, 30 Sep 2022 09:52:56 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeChR-008Qnp-4O
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 09:52:54 +0000
Received: by mail-lj1-x22c.google.com with SMTP id a14so4233424ljj.8
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5e++Bq8byiSeO9h99CYt5V1LItyqEPo3VTEHQk8BylQ=;
        b=HwxvMPTlOzXP1QfP3zDzS7IbqRifPUtcnIIb0LaVXEe1n8584HeeBV8pTDgaEoqFFP
         LawrtsDaBnla4Y9Nh0y6H6BypJloBhWDZ6FLzwUYBdbmj1l50NGkzyULniykfbiaw8Sj
         E+NDJQ1izK3UOlHhKpxSvb6uRs0xUL7i/rX0a2V6a99AJw79LQYkFEKFIoXIf6pHtxTf
         wRqtb+F4+9MAoZp56CAnTtFpaAaWP4AWMM7LaZyQzVBq94EsnvH7hhHOqJR4O3GiBGS7
         qtb04qii52P1uk1QTF6QvtZbJRzlGOhCHqAOWTw9M6zzzx7k8ZmKcUvP86vHMW7WPnqz
         aA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5e++Bq8byiSeO9h99CYt5V1LItyqEPo3VTEHQk8BylQ=;
        b=Oh2XA1bOmvs+fQOwCRUFmfzxn36OikxuWh/jdA+EOFc4tKfolODQ3tswe+WOm8+3ZN
         YBGLgxTUBJVWQOZSCnNLvdkcO1AiKF6Esr+gDkHyTTMUQ9a7WbcBEPntP4JrwYe1kC2e
         OLcgx1VayMdrRIRe2kBFwTWaibWTNEcF0PFC8R3Qh6JDW0zH4eKJYtsIli4awvx1iFd1
         Nzfk4lwHOTU9z0+hrNtgVqn8AeXssiYg1nk3HSBy3GLK+HhTYe8l39hwYB6WkTN+VYl2
         QIZKIEdKzfLK3zJuT4uekRsiOWO0akHW5ER6G9S0h00ETPsj0hUOr1UTLR0nazx4L4o/
         tGDA==
X-Gm-Message-State: ACrzQf26JuCbvbGbb/JjkUGkZfrmu5t+ywnC7bLw/GqfLYhEc89uDv1b
	MpppR5b8WXMUkC0K5+mxZzw=
X-Google-Smtp-Source: AMsMyM5W3qggiqHyrqng78Ar+doOtQG5XPfZcA7kWDg4EtlNDKjdeRjPyWaF128cmsRAZ/ILfiIL2Q==
X-Received: by 2002:a05:651c:2205:b0:26c:622e:afef with SMTP id y5-20020a05651c220500b0026c622eafefmr2879674ljq.242.1664531570503;
        Fri, 30 Sep 2022 02:52:50 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id c17-20020a056512105100b004a1e592837esm242979lfb.140.2022.09.30.02.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:52:49 -0700 (PDT)
Date: Fri, 30 Sep 2022 12:52:47 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <20220930095247.vqtdc53rr66uaiwv@mobilestation>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_025253_213227_D23E48CB 
X-CRM114-Status: GOOD (  23.96  )
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

On Thu, Sep 29, 2022 at 05:53:43PM -0600, Keith Busch wrote:
> On Fri, Sep 30, 2022 at 01:46:46AM +0300, Serge Semin wrote:
> > Inability to allocate a buffer is a critical error which shouldn't be
> > tolerated since most likely the rest of the driver won't work correctly.
> > Thus instead of returning the zero status let's return the -ENOMEM error
> > if the nvme_hwmon_data structure instance couldn't be created.
> 

> Nak for this one. The hwmon is not necessary for the rest of the driver to
> function, so having the driver detach from the device seems a bit harsh.

Even if it is as you say, neither the method semantic nor the way it's
called imply that. Any failures except the allocation one are
perceived as erroneous.

> The
> driver can participate in memory reclaim, so failing on a low memory condition
> can make matters worse.

Yes it can, so can many other places in the driver utilizing kmalloc
with just GFP_KERNEL flag passed including on the same path as the
nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
either finished or executed in background anyway in all cases. Don't
really see why memory allocation failure is less worse in this case
than in many others in the same driver especially seeing as I said
above the method semantic doesn't imply the optional feature
detection. Moreover the allocated structure isn't huge at all. So
failing to allocate that would indeed mean problems with the memory
resource.

> 
> The rest looks good, though.

but you ok with kmalloc in the next line. Seems like contradicting.

@Christoph, what do you think about this?

-Sergey

> 
> > @@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
> >  
> >  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> > -		return 0;
> > +		return -ENOMEM;
> >  
> >  	data->ctrl = ctrl;
> >  	mutex_init(&data->read_lock);
> > -- 

