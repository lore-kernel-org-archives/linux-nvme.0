Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0123CE8B387
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 00:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrMlnCSR3aMEJwapKkMfRkB9Q4sVEd0XSvOGMzL5MAw=; b=Wm/MG7K8Axm7YvBF33ylWc+ZPX
	0bcvgeME4qJIlOvjJM1gnBWLP9P2c6HLXSaLdw7AXUIvJkhXJRZCQ1QGgPpWcpFzMhfHY9yWdpDks
	DikNT+27Pp55SmF3wmEWtdaxd1HujE31qTQyU+qsDJRV4txBG4vZyqbGA8EoEscmnNTqBAnB6RZ9s
	Tr0Jxr8NgLHKzsqKbrp5Qi8iLqpeyIeo204Mw3G8eys0xAfPrG4wDePxCNQiinKl2OWIZKrEXeyQa
	YXvkWG2lRz6mE9pCm/UQPzAmgt/oUa8jCH6M5m4C2FAKeH7TpoVbT1jTblMuPk76VgU106HDiC8Yi
	/jmwh69Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnR0I-00000007eC6-1HmT;
	Wed, 04 Feb 2026 00:44:22 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnR0F-00000007eBg-3tGU
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 00:44:21 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-124a635476fso9247140c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 16:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770165859; x=1770770659; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IrMlnCSR3aMEJwapKkMfRkB9Q4sVEd0XSvOGMzL5MAw=;
        b=DECu36lCErDcrpk4m8fVqCdxfEK/WCocuN69T8IvaRkIXgbO5l7nV34rz8n9/r1fkm
         YF/9vIILjI3ypdF0Ihhyn4gKH7NRuh3dtEBpNQ8A5bj7zvPNS/8H99Ldy8C/g1gc4t2k
         O6hGjihxOrNMH0+7RAh6mqEJE2G5g/eY+b7NAE0ZkOSHttivnRCE0bNE8A2DbeKCTc12
         1LGgCKblBW/A/N6MuRFqtgiPV/p+mpuWgvRQdkQd3D+Hrowafey53DtuTvqv0EDkNgER
         0yXt+lJsY/ngVDHo49OzXJlbWhmJqkOGwtVG5SgnpSK1PElCxd/+3tDrJnvQGK20OdqH
         AomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165859; x=1770770659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrMlnCSR3aMEJwapKkMfRkB9Q4sVEd0XSvOGMzL5MAw=;
        b=eHZRuW7XqsASWtqbIjvbE9EaK60Yjmq+4j1tVsSr01k6iLZTb+7AlFg2A9mUppB5jU
         6BAUIlQu+PUvPNI3DpUBeED0C3e3j8s77b0MftkDTrESLqnLBRDQ2Rpx3Jp3Wpqx/l4i
         sCT0bNo76oCMtwp1bdf6hXdcq60JWI1NVAoy3nyg/2GQCgsGrRKNvB5RqLmXeVXXnUxA
         /bmTfLnTf+/S8+GGvSvPOZsBNSsMI/18aSeiUiLQ6bK8tkMPTNlzYci3vgHiIQ6QmN5R
         LRLBXs4oQnqJ4Rqt2+TYMQ/Xh5K0/xcJrDTkFUHo6ZjU0qiO9phgChW0ISzh7qvr/JWB
         w/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYD4lss3IdZFHtStkhvCoiWT/lE2U0qdGQJTwTNcscw4yxbsdRJaTfQ4knfvmhgUvlk7m9nig3SgjD@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7wAP0KQbLWBJK3cOJUFWcTnok6P2VO+gxhZynfpjipD8/06D+
	p6yY85zW+cXxErGMvp2MAs+jNuZ+sCoRjPc2y4CIfQBLZRwC+EMcfikiT9L8yMay3xE=
X-Gm-Gg: AZuq6aK+Fjh0Q6UvR23D0VrAwyeAhuEQKg7HSg5GrNFthaVkbDyMiv+gdDtfpR1eary
	jCqLGoeNCLzxe7FBpo0Nso0JUdWWhbKG47bEq3J9wxEsQQu6fxhtqST29kgoWxCjRQLhl9qMUHr
	PYz/Yqjp2rgVwVfl+wt0c9I9FqVLQSUQhlsuVXBZxiGlaRRm5mrAFYQF+Wlr3FzHSavOU8llvQJ
	ynjSbon1BV01dOjHO/2VzElWMP0eCXuAs9s8cmBAd/L4sQzUZAdyvd8u/tpOTwvgogktAyNfUJ6
	aD8JjYN279oDZoKcVzyKDIc2H4kJhZ1hXTWPGPlTtuhngsQF1OY14sybtkMd/FU6Mb5neV892Dl
	xDFnGzJh5oscDiUdnW0DtZXP1RZbSiEzklebZegBLKFtyxc/hlTgamUoP6xjuwvu28oPk1gTVit
	x7b37qDzE0CuBXo7D8psQuwyWPh5uVZ34=
X-Received: by 2002:a05:7022:327:b0:11b:9386:a38b with SMTP id a92af1059eb24-126f48e1fd4mr680897c88.46.1770165858753;
        Tue, 03 Feb 2026 16:44:18 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f503087esm833774c88.12.2026.02.03.16.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 16:44:18 -0800 (PST)
Date: Tue, 3 Feb 2026 16:44:17 -0800
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
Message-ID: <20260204004417.GK3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com>
 <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
 <20260203184039.GB3729-mkhalfella@purestorage.com>
 <21be273b-b1b2-4813-8178-e01cb0aa6301@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21be273b-b1b2-4813-8178-e01cb0aa6301@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_164420_615531_7D724D7E 
X-CRM114-Status: GOOD (  22.11  )
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

On Wed 2026-02-04 01:38:44 +0100, Hannes Reinecke wrote:
> On 2/3/26 19:40, Mohamed Khalfella wrote:
> > On Tue 2026-02-03 04:19:50 +0100, Hannes Reinecke wrote:
> >> On 1/30/26 23:34, Mohamed Khalfella wrote:
> >>> @@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
> >>>    	return ctrl;
> >>>    }
> >>>    
> >>> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> >>> +					   const char *hostnqn, u8 ciu,
> >>> +					   u16 cntlid, u64 cirn)
> >>> +{
> >>> +	struct nvmet_ctrl *ctrl;
> >>> +	bool found = false;
> >>> +
> >>> +	mutex_lock(&subsys->lock);
> >>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> >>> +		if (ctrl->cntlid != cntlid)
> >>> +			continue;
> >>> +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
> >>> +			continue;
> >>> +
> >> Why do we compare the hostnqn here, too? To my understanding the host
> >> NQN is tied to the controller, so the controller ID should be sufficient
> >> here.
> > 
> > We got cntlid from CCR nvme command and we do not trust the value sent by
> > the host. We check hostnqn to confirm that host is actually connected to
> > the impacted controller. A host should not be allowed to reset a
> > controller connected to another host.
> > 
> Errm. So we're starting to not trust values in NVMe commands?
> That is a very slippery road.
> Ultimately it would require us to validate the cntlid on each
> admin command. Which we don't.
> And really there is no difference between CCR and any other
> admin command; you get even worse effects if you would assume
> a misdirected 'FORMAT' command.
> 
> Please don't. Security is _not_ a concern here.

I do not think the check hurts. If you say it is wrong I will delete it.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

