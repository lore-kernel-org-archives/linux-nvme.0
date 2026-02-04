Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634B8E9D41E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L+mtqSUCbqzuDcEW1o3mGHLmXW8L3fM5ZNzzT1MLFDA=; b=ItqUEFKgrco6+kY9ESFCoXl9cr
	3beEzlHs0KH7NZpJzH+JblymeQuflFE+9gpioxbUmCSLc7exEuvZUj0l1tDyV3M4uY2/fvTC44NQj
	zhTqizd4J9Dty2jJF/+leVjwaM2eIUSmZEZGcl92DSDB41lqJijV5ZShC0TUcio4P7Z0RjroJjGfi
	RaUBOvkpwhdbelr4lv27m0HMvJ+8/OXb34uKefx6aQQrpYYRBqukyO0mp0/WHPdfXX7aNaeZyfVAd
	UYlnBG5+XnxeLVzozesjQbdEFYsdzzaxnYcSVyOwr7U/vcYuQrVBJl5n0eEszK+Bg5meid//XsMyk
	x17ps+rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnh3i-00000008tLT-1W1d;
	Wed, 04 Feb 2026 17:52:58 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnh3c-00000008tL4-3dlK
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 17:52:56 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-2b81ebac5d6so3787120eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Feb 2026 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770227572; x=1770832372; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+mtqSUCbqzuDcEW1o3mGHLmXW8L3fM5ZNzzT1MLFDA=;
        b=aFV0gbGAW5/of8vBsWOP87y6Brd8DjxOBEkDNq/ZMNp892fpt4d3LE5HFGYSdJBwux
         YICKYHSRgsZJArqDvjC4pz6YCEkJJMigJyHIqKmKcLTzKuI6hEaevQ1xGMRRLJpitk0/
         udZ2PiuSvyHsNqTqCdlzfZhqvxsdPg6BRd5gicnWqlLw2ol6CsqGgbxxm0ocHdwGU83A
         OuWZEJibSV1ZjBHlOXGE86zwyXysZNn/PQae7oBywJ7Obtjkoa8I++1kvjd0ykGIakRk
         BR2kbATziC6n32rQcrJ7et3WoWaXQ13uJWJyqVbtlA5GaLbhsuwCJCmxAMqTY5WrF93m
         9IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227572; x=1770832372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+mtqSUCbqzuDcEW1o3mGHLmXW8L3fM5ZNzzT1MLFDA=;
        b=gIrDoppCVFM1E4kK4TV6HoDjtLZQSeKcOQ2GRDjnJrxXVrPmiANdFRZh7ebC7hWtjD
         rvBEAf3K828uccu55fGf6NE8WCFES2QJe3M0lTrqf04BO7cc/E9XW13PfWJVTbFccWkP
         PxYrMttT2y2IJJgPvUPXehnUayGTmSboCTpLXz0nVFV6ch1PLiYHv9eDKbooJSjKIIgk
         jJdXvZRn5X6eTuzKN4HIViSSQfy8ytQAhgX9ltqT4N93RWFDq+RiCcOzs56LrUJDTkKy
         N39L23BN4Qcg5rY8dgOwph4S+kkti0HAtFbQkng1aW/3utVQvLmCNRGunn35+7Wb4m3i
         lK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwAIau+UgfB4q1Y0vIrDVde+i6BjOKhHiu4Dd1uXdXUUN0gx11B1SeoL0vw8MGt7Ud/Qi4Nlv2LsPP@lists.infradead.org
X-Gm-Message-State: AOJu0YwklUIe/DsTDtz9NhfpX0g+cXfQvSSsqLufrK46ZSyrlVUqhd8d
	+HuDWpHQFOlk71A69UjUvL9VLFTxpZbzH/0RSZtVawV0yQFS4ZxmyDrpJa0LbRu+yMMvaA5QUjj
	2PIH0
X-Gm-Gg: AZuq6aJeEoW9WRmjk20F82ivVTKzyYWvUF+rXgLzOaibryF/rX65JArNljoNwMUgdkc
	aGzR892YDdItW1ttvEHPOZWhw+rakNClcYUeywQFoomV7of8orI0EUOCV5vZXqru1Z6LzXWKZy3
	keHI+AGcf60TOK2+xQnfOxwO95/v+dJ1BRx8DJrj/0RWx1pRvfEMN+tYKZWsD7LbgGzIj39y0zE
	Qe6wxyGp2TMbPO7gVYcQu+eX/kW9YUEVtsFqJ4kaS5KTqF3UOURWz8mb4fdqJP/1RoSPkFp1r/t
	mB6h6/w8TjiE8fMqH+64smiecCTjud6fZnsNiHzqLWFVSyeu5Eqmo2xLZemkLnu8X7YRvYX516y
	b71sFXdtSAFIbDxVWoyOoacQrCtkBUmiu8jNzSi+cKgbXQaGEUcIbqGOIMudcpRBIw1EHuMwdXD
	Fj74cvsxJ5FOyByspaPY/rClD5dnDxjoeuXZKigiVGCg==
X-Received: by 2002:a05:7300:5711:b0:2b7:f809:9c41 with SMTP id 5a478bee46e88-2b8329df851mr2012242eec.25.1770227571532;
        Wed, 04 Feb 2026 09:52:51 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f4e107b4sm2502371c88.7.2026.02.04.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:52:51 -0800 (PST)
Date: Wed, 4 Feb 2026 09:52:50 -0800
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
Message-ID: <20260204175250.GL3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com>
 <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
 <20260203184039.GB3729-mkhalfella@purestorage.com>
 <21be273b-b1b2-4813-8178-e01cb0aa6301@suse.de>
 <20260204004417.GK3729-mkhalfella@purestorage.com>
 <d53ac6e1-af6a-46ce-9b91-946a26ee1043@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d53ac6e1-af6a-46ce-9b91-946a26ee1043@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_095253_234180_0BFC2C7E 
X-CRM114-Status: GOOD (  25.05  )
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

On Wed 2026-02-04 01:55:18 +0100, Hannes Reinecke wrote:
> On 2/4/26 01:44, Mohamed Khalfella wrote:
> > On Wed 2026-02-04 01:38:44 +0100, Hannes Reinecke wrote:
> >> On 2/3/26 19:40, Mohamed Khalfella wrote:
> >>> On Tue 2026-02-03 04:19:50 +0100, Hannes Reinecke wrote:
> >>>> On 1/30/26 23:34, Mohamed Khalfella wrote:
> >>>>> @@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
> >>>>>     	return ctrl;
> >>>>>     }
> >>>>>     
> >>>>> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> >>>>> +					   const char *hostnqn, u8 ciu,
> >>>>> +					   u16 cntlid, u64 cirn)
> >>>>> +{
> >>>>> +	struct nvmet_ctrl *ctrl;
> >>>>> +	bool found = false;
> >>>>> +
> >>>>> +	mutex_lock(&subsys->lock);
> >>>>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> >>>>> +		if (ctrl->cntlid != cntlid)
> >>>>> +			continue;
> >>>>> +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
> >>>>> +			continue;
> >>>>> +
> >>>> Why do we compare the hostnqn here, too? To my understanding the host
> >>>> NQN is tied to the controller, so the controller ID should be sufficient
> >>>> here.
> >>>
> >>> We got cntlid from CCR nvme command and we do not trust the value sent by
> >>> the host. We check hostnqn to confirm that host is actually connected to
> >>> the impacted controller. A host should not be allowed to reset a
> >>> controller connected to another host.
> >>>
> >> Errm. So we're starting to not trust values in NVMe commands?
> >> That is a very slippery road.
> >> Ultimately it would require us to validate the cntlid on each
> >> admin command. Which we don't.
> >> And really there is no difference between CCR and any other
> >> admin command; you get even worse effects if you would assume
> >> a misdirected 'FORMAT' command.
> >>
> >> Please don't. Security is _not_ a concern here.
> > 
> > I do not think the check hurts. If you say it is wrong I will delete it.
> > 
> It's not 'wrong', It's inconsistent. The argument that the contents of
> an admin command may be wrong applies to _every_ admin command.
> Yet we never check on any of those commands.
> So I fail to see why this command requires special treatment.

Okay, I will delete this check.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

