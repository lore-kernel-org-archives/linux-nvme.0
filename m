Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2D4E87856
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mkOMXZ+mhfKPghY6ZSWYtvEZTLv6CxviqMg+Pg3zze0=; b=QhahG0JmP9NfbbRI2DbJjM3GTB
	SPP7mnpluVSWYLiZQIr6vFqT+UkiWbzyuJXZMIGiq4iOoTw8vW62CgSsPjTV2UfYNDrrvJeYF8/3o
	+7AmNUimd+qgFeb1882/kDQ9AE/MJJlpcVwTkldc9UroQ3zKS33qEvfDHoqb74JZSdGIxB5XV6fd5
	OTHvWkOAmD3ePxuk5EWV9D6UywcMpNA8nQLL+s+n1NmsKTVcKJFC9a0v5P4wK3kIzKcFbBC0Qr4dV
	aP2DSU1gt+AFH/tV0te/CisLn5jXAoXGgj6nuCrBNskXKC+sVTuIFYwgUv/tkhT8oFw+VSoaY0xEt
	GWhRSIMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLKP-00000007Acb-0m3G;
	Tue, 03 Feb 2026 18:40:45 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLKL-00000007AcE-3sW1
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 18:40:43 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-2b7381d2d95so77797eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770144041; x=1770748841; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkOMXZ+mhfKPghY6ZSWYtvEZTLv6CxviqMg+Pg3zze0=;
        b=SvJ28ti/Fb4oLc8nJ222ZF4+3xEi2ybYrhtLK9VzxKxSGnguNJTqDBdBubivM5zpFQ
         6DdfVAsRjsoQjs4i3bceNo4ROgmgZolfhB87NP+S1P1doX6FoDedWRwzGOU2mOCKDu4v
         fMiXZgCe+2iBwjp4qvSm5x5Rv/cHo1jtnT45uvZI4tnjyVJLxEhBchJxCwj8AyBiHt0b
         Yu86SaPsuOALjrOMwftnT2OdugD316N7fxL2yU9nrfTFQWga0W26bamEY7vFbTB+dsOJ
         arHhR86OuAOdgAUi2LeDbzGl2urchUKQuN68bAHv0idPpNZ5Oh5IPPsOxpz1OqK/Thvk
         yn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144041; x=1770748841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkOMXZ+mhfKPghY6ZSWYtvEZTLv6CxviqMg+Pg3zze0=;
        b=Td6aRK4kgLKYp8PgNuw5e+ppRJGgeg9IWM5BxZ0ennJSIuRujV4SsHs1E6EgXVkCLD
         DnpAuieg3Pqu0NhEL8odHOSQM3TQ7qnZl194qzOW2pDbIpEnzt4OSBs9ciS2k7h9cxgT
         8ObJh2YPcgBv28tGr9pAT4uvrWNQJif0OgWK2/TONfBPbE84c51ffCpfVtqjFkYKWvur
         eipNwBw6GpnEnal3hcQhbJGY8t1sRkrbHGj319vvM21I1Ttsrxrh22gfQIxhNSmuYjam
         AxC9XTj2I6HWW9DHDYPyMDtKFeHmaDwPd2GyTaqhA2ZE5OMOtDsVqsZqhoCIaoFnuXFM
         FPww==
X-Forwarded-Encrypted: i=1; AJvYcCUJsW35nxpijiWB5+F0/uagWSxVD9gDhlO+uC+p4OtVb9kkbq80hN+Z3pSevnwkz+syBt+3lU1I5NeQ@lists.infradead.org
X-Gm-Message-State: AOJu0YxryHptJN+nqrLqkF91Ka5FE2A1ky37bDYDUuBP9rHYoLcfe786
	YDEC7ypBAeirYLd5L4UeGNebZtGjn/Tx6bZzE59uge6ZYTMZCkrYZylZQaF2bTfQdD4=
X-Gm-Gg: AZuq6aLgokok3FKlL+7BVR/jwxgFiVE6tjPCc5wWrm6n68mLSP0ZGfcdg1mNplCJ80z
	lJMWGwadVZ0Rp0YdwsNWHRhsDNZb25tx0UyIKLCCF9MCuep2Bhp0adScCSOPqy0JertiUplBf0q
	s4ltenOTvHdYVuTR9oOmVmVkKHXS2Tl2d8rjvObBuL97tjG86QDrWqqaO58jzG/5Eohfx9rjsB8
	G6sWxqtx7J1QidNo4ndk9JllQDqKsXxpgo40zCGA7uwqXfV8O41clCpCyPoUUQxg+MOrsoj0o78
	kNnufSEiQUdI7urLtEg8zn3o9jAOZ1Ldobl5Zy80nuBH8XmwRI6Zm6uC0ji5GPUXqyM6qHhOF2d
	TlOwm+kJW4NzRfREdZTO5tfYpzF08gFMBivLiCZFQjIGPKskUZqKM+Ibi917s3OMWRDBPT9YXBj
	kG576/jTNYQGksNR18DU3sgiBuqHnfbhs=
X-Received: by 2002:a05:7300:3707:b0:2b6:f13c:8d58 with SMTP id 5a478bee46e88-2b820f69facmr2054379eec.20.1770144040807;
        Tue, 03 Feb 2026 10:40:40 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f4e107b4sm109588c88.7.2026.02.03.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:40:40 -0800 (PST)
Date: Tue, 3 Feb 2026 10:40:39 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] nvmet: Implement CCR nvme command
Message-ID: <20260203184039.GB3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com>
 <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_104042_020934_1D5B26D1 
X-CRM114-Status: GOOD (  17.23  )
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

On Tue 2026-02-03 04:19:50 +0100, Hannes Reinecke wrote:
> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > @@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
> >   	return ctrl;
> >   }
> >   
> > +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> > +					   const char *hostnqn, u8 ciu,
> > +					   u16 cntlid, u64 cirn)
> > +{
> > +	struct nvmet_ctrl *ctrl;
> > +	bool found = false;
> > +
> > +	mutex_lock(&subsys->lock);
> > +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > +		if (ctrl->cntlid != cntlid)
> > +			continue;
> > +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
> > +			continue;
> > +
> Why do we compare the hostnqn here, too? To my understanding the host 
> NQN is tied to the controller, so the controller ID should be sufficient
> here.

We got cntlid from CCR nvme command and we do not trust the value sent by
the host. We check hostnqn to confirm that host is actually connected to
the impacted controller. A host should not be allowed to reset a
controller connected to another host.

> > @@ -1740,12 +1788,35 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
> >   }
> >   EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
> >   
> > +static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> > +{
> > +	struct nvmet_subsys *subsys = ctrl->subsys;
> > +	struct nvmet_ctrl *sctrl;
> > +	struct nvmet_ccr *ccr;
> > +
> > +	mutex_lock(&ctrl->lock);
> > +	nvmet_ctrl_cleanup_ccrs(ctrl, true);
> > +	mutex_unlock(&ctrl->lock);
> > +
> > +	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> > +		mutex_lock(&sctrl->lock);
> > +		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
> > +			if (ccr->ctrl == ctrl) {
> > +				ccr->ctrl = NULL;
> > +				break;
> > +			}
> > +		}
> > +		mutex_unlock(&sctrl->lock);
> > +	}
> > +}
> > +
> 
> Maybe add documentation here that the first CCR cleanup is for clearing
> CCRs issued from this controller, and the second is for CCRs issued _to_
> this controller.
> 

Good point. Will do that.

