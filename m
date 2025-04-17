Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE5CC369BD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 01:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xrkt0T8eTu16gqA53V0agVggjbvcWP87Rtvx20jrF/k=; b=ek+BQkkXNIrGRXxWML/btcEiHA
	P+3VmLOlnghqUuWOabRXLGiiCyoRMmpoaBHNSluHcDa0pNZL0K+EErv7uM3mUj7+NMTk8sJHKon4F
	J3y51Jwx4BnymPL9ksG2FKRorvjMNCMwKLXAfYFOSBDRU1/rhEpLxGwxtGKTA3wG7qEu+VNZUZ7kX
	4ImwcUOqMWsiADjsjJ7cSgbVrdLLFF/gSCHkqJp0ieiPcfXIXFbvwy5az82RLkbhtGx43ggyQZuT+
	TkdS5Fpu+jiLr5l6wZLHPg82oo6Z5SAq7+yYTZUzV3nBHLO2wFpUt/352qPg/PyseNYodHWheUBd5
	BoRKrlFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ENW-0000000BTSi-1aJJ;
	Thu, 17 Apr 2025 01:49:22 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5EL6-0000000BTCd-16tM
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 01:46:53 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-224100e9a5cso3001345ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 18:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744854411; x=1745459211; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xrkt0T8eTu16gqA53V0agVggjbvcWP87Rtvx20jrF/k=;
        b=RVUGWX7gjiZmBPHhwBD8a2/P1w+RAnyVtr9ohGsFN8Elm/NyibECTGIsAzWLouDRLn
         65avuqYiWoEw7N1vs8xgERxJnfXQaukdnOKzzdUPZ3Ia7SE0Q2JOY+Yncdklv/eMH8/Y
         1SzG5GXWDqUyWDG7+Y7Lwi3TALZxvfz/+n+PIbVZaByJu4+/BTR9Qdrs/I6Da5iKyro7
         2/hyIDOf0Xz/VxZupom0E4vNDhy0VbFoC+JdBU6aOPxkVIhereMTh57Pn7IvlBfWLMzG
         LHKOIJTMZj7rlkf1Yn/hk5FoJpviInsSqvn0KfUIWT6KdRbhMLWtopjfMmJAM9mLFxeM
         TL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744854411; x=1745459211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xrkt0T8eTu16gqA53V0agVggjbvcWP87Rtvx20jrF/k=;
        b=Icu9/dczTGUqhgNqwXU2kVtOy7tHc5BOXoPqtH1hZHVcXBr3dNcx+jeP3gog7Uu7FY
         IXmsWBimfiWHDqsPdyFxQgYfXC31IfiC77rhghrYD9TGfgPIx+PrMOxx9a8o05+f4Kjb
         IDV9vpMWd10ojSmlq2p+qdVVPn1qyMIh/hTYffERpdWdS4cv9aauhhF0scF45uX7rBj5
         i6F6/s5rTxbFyR9dgiaFVdusjG3ACFaD4hTubHtWCXyIqCBQH+W0JvDNMIxuwv688opa
         oieGCR4di29l3/H75PsEoA+SBATFjxuvhw7Fct6PcfIcde/b7sLeBqiEc6Ziy52JZiNg
         wA+w==
X-Forwarded-Encrypted: i=1; AJvYcCVXbNgGGDrqip4F6HUH/cO2RlbReuTfPkDRveg7pR3U854S+RJgXG80gRlA2HJ3v5+pgOOYiDDlF9xh@lists.infradead.org
X-Gm-Message-State: AOJu0Yybw9/RDikRywz39QcTeCDw6yTaF5MbP2PPyYLMPyMCzw6NH5AR
	BqI4Z0ebEc6FC/P8CquwxwqN8K6JuJepuc3qKJ720UB+4/t8wirX3Fm/15o0Tew=
X-Gm-Gg: ASbGnct6DXBu6RoUDQSjCPPQA4jm8oQcG5iwX9zHyZegLW5WTJTGxPYjKNVWD35EVju
	ibJwynjEHyP8G+cyUpNsBoCUPYGipYDepmof48czdPCMbC+Xig7VhWx5c3eDLjfi8IRUSkQSZUb
	xHfW8tz3g/M6A4Ia3cG/PjQ4VEpreNB2FUd7gb4237EmeRymq+jcZkM/YP3HkTt0KJBjOxVURUj
	QObbZsRlVNbxWIMmyMo4sl9nkUqLhyviPr8entiF1nqVJ4f7zJ73hzdcCwazgonGEPqeo6cSSLM
	PEJJS6O0HaG0P+mBqi+4pEW9DgXBTmvklOdeKEtVl5NLeq36eRp6Oxx4HjnA5WcLxpH5cqTMkw=
	=
X-Google-Smtp-Source: AGHT+IFsX+PqKZk9D3Uny/tD7FhInwa03DmQRsZ7lR2VZkpIAgn6LMjwNXt/Ss/mApVfjpVWh/HtIQ==
X-Received: by 2002:a17:903:2c8:b0:220:df73:b639 with SMTP id d9443c01a7336-22c3595dec4mr66016065ad.36.1744854411140;
        Wed, 16 Apr 2025 18:46:51 -0700 (PDT)
Received: from xldev1604-tmpl.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fa5e74sm21447975ad.151.2025.04.16.18.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:46:50 -0700 (PDT)
Date: Wed, 16 Apr 2025 19:46:42 -0600
From: Michael Liang <mliang@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: wait socket wmem to drain in queue stop
Message-ID: <20250417014642.ljhowsbvkn2waipw@xldev1604-tmpl.dev.purestorage.com>
References: <20250405054848.3773471-1-mliang@purestorage.com>
 <CAPpK+O3_3KLxA6QuLSu7QbBwAt9jLBKmihbqQUYfmJwNzNGQ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpK+O3_3KLxA6QuLSu7QbBwAt9jLBKmihbqQUYfmJwNzNGQ1g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_184652_306295_4440ABD2 
X-CRM114-Status: GOOD (  29.96  )
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

On Tue, Apr 08, 2025 at 02:07:24PM -0700, Randy Jennings wrote:
> On Fri, Apr 4, 2025 at 10:49 PM Michael Liang <mliang@purestorage.com> wrote:
> >
> > This patch addresses a data corruption issue observed in nvme-tcp during
> > testing.
> >
> > Issue description:
> > In an NVMe native multipath setup, when an I/O timeout occurs, all inflight
> > I/Os are canceled almost immediately after the kernel socket is shut down.
> > These canceled I/Os are reported as host path errors, triggering a failover
> > that succeeds on a different path.
> >
> > However, at this point, the original I/O may still be outstanding in the
> > host's network transmission path (e.g., the NIC’s TX queue). From the
> > user-space app's perspective, the buffer associated with the I/O is considered
> > completed since they're acked on the different path and may be reused for new
> > I/O requests.
> >
> > Because nvme-tcp enables zero-copy by default in the transmission path,
> > this can lead to corrupted data being sent to the original target, ultimately
> > causing data corruption.
> >
> > We can reproduce this data corruption by injecting delay on one path and
> > triggering i/o timeout.
> >
> > To prevent this issue, this change ensures that all inflight transmissions are
> > fully completed from host's perspective before returning from queue stop.
> > This aligns with the behavior of queue stopping in other NVMe fabric transports.
> >
> > Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Reviewed-by: Randy Jennings <randyj@purestorage.com>
> > Signed-off-by: Michael Liang <mliang@purestorage.com>
> 
> Through additional testing, we have recreated the corruption with this
> patch.  We had a previous iteration of the patch that ran some time
> without the corruption, and we convinced ourselves internally that a
> portion of that version should not be needed.  So, unfortunately, it
> looks like this patch is not sufficient to prevent the data
> corruption.  We do believe the issue is still with the zero-copy and
> too-quick retransmission (our tests showed that data that was only in
> the buffer while userspace controlled the buffer was transmitted on
> the wire), but we are still investigating.
> 
> Sincerely,
> Randy Jennings
We identified what was missing in the patch. In cases where concurrent I/O
timeouts occur on multiple namespaces under the same controller, there's a
race condition when stopping the same I/O queue. Due to the current patch's
queue liveness check, only the first timeout handler waits, while the others
roceed to fail I/Os immediately.

To address this race, we've modified the logic to always wait during queue
stop, regardless of the queue state. This resolves the issue. We'll post an
updated patch shortly.

Thanks,
Michael Liang

