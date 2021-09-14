Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62977C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 16:46:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B16560FD7
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 16:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B16560FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lXdP2JyWFqiS26zqy2xeU9gY6Y2VYUEI6TWh9xEAHqg=; b=Cj6/w1XjHPjHGJ
	IQB7UHqfn+SNy6iGMH1/F4xTlkGZ3xjYbgwW3jvVkha9hCt3MI7w7zLI42LT0peMjxZ+cgWqEDSzR
	WjRr53obFxjcBosRTplsfGVbgVNMuHEyzbZy5ksSWMvTNsGGuL1OK47353/eZydOQEfEnpoDkZAdO
	Db8iGc1XOe/AyFmcviZH7/IDG/0tQKvU3Lgg1oUyQEpR9sNg8wQWTnsp609Gm5uLAOFkK0C+Ek+ZR
	TX3hG9fF9IDSPYlSz/JYmiUjwI/DOk1xFpj11bddtMtChBpx4qe9WEtc0Mae7nTsTHsxLI9lc+k1R
	/2svynZzrR4MywhJpB+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQBYz-006U83-Fw; Tue, 14 Sep 2021 16:45:41 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQBYw-006U7c-Po
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 16:45:40 +0000
Received: by mail-wr1-x42f.google.com with SMTP id t18so21331402wrb.0
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=I/kbNLfbtuKlsjXeExD9nw050HG/AAsZkvIyF43zgi8=;
 b=nTiOxoNkTRc8RzCpmJuwGiSiF1z5RtD/++CNp6wwhFh3KMjnd+nOb9nGuWhzYv/hwf
 5/2mvLS/h98g7XV3wkg4fuMG07ukdqyz9EuJ4CFW3R0aGjEfjryqDfzO+4pTVyxGoBRI
 WSfI5EecWm89IMlWfJX/6GkAkkNO3dUzRq5SOq3Gcv9ugRKpQsuS4ePm4X6gU2K2bXN9
 m6M/debPFmu9yZEAfsqJY8r8hnGhJrEq2G88DgTgO6Wsx5+pK1h1KRi6lyhfMqgdFSm4
 tvYhozRhIYjCBqYHoWvkYljz1hTpXxTvepgduFfqMRMGc1/E0zNC9V3oZJ+FT+POmgRz
 cwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I/kbNLfbtuKlsjXeExD9nw050HG/AAsZkvIyF43zgi8=;
 b=opJj3H6jUzOy2X+SyvwhKUtjWcmdPZJ1FK73fagr20Vpu7Y7R1NKhrpydyJsBWQjMV
 gHt3k32xhSir8HNyP9tdhWs0mj2ZgaRWoXx2Rq8Tffy5rsTLwVFKGnTfWaKMiNA1FYFp
 kHmjzdqqvqqa2DFPWU2ZwOadSnBn/URHLQSok3en74FSMcRb4HpcY2mmAG4HOog81eKr
 NWfiESgPLk/bdN3IGwiV+uyHOk2f7CZzj4RnKGyzK1U/qrsjDvDwLxOLF/rT9rL3Jc7/
 9A/zZ1Qlb5qNpa+XqFzzmpKo/j1oM4oWBQXlTtGWstVZZVgTq8KwHnfn9zwzr4eiuj1i
 7KhQ==
X-Gm-Message-State: AOAM532cNgDX3wL1VzT35tFLjTTDu93kW2CPZTQv6ZKZ1Bysep94s8j2
 Sk3rXPC/xzWa7wEKWsaoiXc=
X-Google-Smtp-Source: ABdhPJzYKjWttjMmkvjDm2sEY69bpSljYa9KOBX2wlh1KvhULZr218bH/e26cMeva25BXWL3B5407g==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr106435wrv.406.1631637937311; 
 Tue, 14 Sep 2021 09:45:37 -0700 (PDT)
Received: from anton-latitude (c-76-23-2-87.hsd1.ut.comcast.net. [76.23.2.87])
 by smtp.gmail.com with ESMTPSA id
 s14sm1522140wmc.25.2021.09.14.09.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 09:45:36 -0700 (PDT)
Date: Tue, 14 Sep 2021 10:45:32 -0600
From: Anton Eidelman <anton.eidelman@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210914164532.GA142795@anton-latitude>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160310.GC6442@lst.de>
 <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
 <520b56e9-cac4-3cd7-9d2e-16633c6e7df5@grimberg.me>
 <20210914063052.GA27942@lst.de>
 <e65e9c83-33ed-df58-0eed-4ecf9cb4485f@grimberg.me>
 <20210914073236.GA458@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914073236.GA458@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_094538_885268_CBC7A590 
X-CRM114-Status: GOOD (  22.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 14, 2021 at 09:32:36AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 14, 2021 at 10:09:43AM +0300, Sagi Grimberg wrote:
> >
> >>> I agree it should not happen with xarray as inserts preserve sorting,
> >>> but that patch has the non-trivial removal of the namespaces_rwsem which
> >>> synchronizes in a lot in a lot of error recovery flows. It's very
> >>> possible that xarray will introduce regressions.
> >>
> >> I've actually started looking over the series earlier today, and staring
> >> it I'm pretty sure the namespaces_rwsem is completely broken.  There
> >> is nothing preventing the namespaces from going away in these loops.
> >
> > Where? the ns itself? the ns is removed from ctrl->namespaces list under
> > this rwsem (nvme_ns_remove).
> 
> Sorry, with the series I meant the xarray conversion that removes the
> rwsem entirely.
> 
> >> But I can't see why we don't just always do a sorted insertation into
> >> the ->namespaces list.  Just trying to figure out the history of the
> >> delayed sort ATM.
> >
> > Don't know the history.
> 
> git-blame teels me it showed up with the initial ID ns list support
> from Keith, so not all that much history here.

The main reason I suggest applying this as a short term fix
is that it is well isolated and is easy to cherry-pick into the LTS/stable versions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
