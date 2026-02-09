Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7753E7E0DA
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCKwtEDIGSn0kPdwgs9hDBGk0+B7QKz+ryxhKiPMenA=; b=Q/2FOu4699LK52ulWaJOr82Mt5
	VZAIwpjowsuQgqeXk2Ia5Pw7t4gswchxNXnvp8NAi2ShBszlqzn5SuUe0WVOZt/0f6ADFtbRClvL6
	cjfD9Q9l6INs9xOy1U3Wg+mmtYGzumAzl0HUm5qkqTwC4hJUcudt93U1I0dD9WqtlRYK71iwO5IZE
	NzXlaKQgGQmni5eTR9Y8y1QrhUii4H6pMWAmx5l/qT+0lAaZt34vY68/9EmJVhrUKLa/eDanvzoPe
	B1NqVWzJ4c2EgxjJuunznEVHrUmPw4zXb5BJlSzAzC5IVgds03xSTals3ILdyfgYms/3nTXnVlWGx
	BbbiF5EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpWuh-0000000Fv3p-3gFG;
	Mon, 09 Feb 2026 19:27:15 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpWue-0000000Fv3N-0zLE
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 19:27:14 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4801bc32725so25988645e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Feb 2026 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770665230; x=1771270030; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCKwtEDIGSn0kPdwgs9hDBGk0+B7QKz+ryxhKiPMenA=;
        b=fh43ltNdF1KEoR4v+kcnCU/vuZqEAlXG4X8B51+NzQitqBcjAnb2N2wCA/caRMU9vq
         BAy6AsfLFqGYuSBn+a0as0isQC4V8z2pwWJlAxMxLH7S+fL3F27Z4tkh5MLyeFKhsA6s
         Z9qWbapunrEDJ8DxagCzqYPL3rHNIldUxeUphn6XfajdgCNkmUTdDxMmZva1EW6v2V0u
         amMIvsmkOhgZ8Cbm9AccsSKlrG1grej4sJ8yjGkvpeKAH3gsFMbyFiG+pztTodEn6ZyM
         /dwyMgQHufH/Xz3tD4Wa0P0c7NkmHfYuvrYREwOWPN6t691DZEhRhHbijBfSRv+d1wUn
         ujEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770665230; x=1771270030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCKwtEDIGSn0kPdwgs9hDBGk0+B7QKz+ryxhKiPMenA=;
        b=cFArVKRiQD4BCKIbeXr+Igu0XLFVFFipYugh4T5beZJxU87y1gfUP86HZc3AE6m5jz
         ysKZGsYyuBaVLpODAlG9uOj8u+UihO+SSqr6R6DA7MniEN77tCLInkSBpaIsXCuh1Gf2
         n9QUHwe58DNlEIdObrT8Hvq3frBNym1ZrcUYPpOPWn6rjkE4Uv/U2zAmd8Vp3xevtO2C
         Sgk28d1x5VtaWSwWO8wJNM5wBw3ES02+hEBy8kpzOlMglF1cm8GMvarQ4BOnlUSIWth5
         syyY4vcHM1KqEJuPef5jPb54NRBg5R98MKApggCRXaPfm71g7Ih8cJgnsV5kBTcrr594
         TSLw==
X-Forwarded-Encrypted: i=1; AJvYcCX+SIH+MXXRM4A28I1AFIdRmzvaxizfXHYn4zKckXIWV6ctVWu2G9AbETZOf+exQELZW/FkRZQyhwqp@lists.infradead.org
X-Gm-Message-State: AOJu0YwuTx+Ga8AjXrDz3B8IqNOa2i+naL5p+DaDfl2NukM6A/vFEKlt
	SWzXd/DZyWyiCV5MZTp35AG7L76742b7EYuYV/Dr0vKY0MSWU/u06u0dycI/5+M56OI=
X-Gm-Gg: AZuq6aKeBXuvUlhDBMpdCNQdU39Dd06ytDaObbPdfpVMA3woM78r6N4dI/zZLVLhjBU
	acVROVeSQj0FHi6iZzzSNcOPirrPWFu4JazuKIW3o5futlrbz3Oko+DoeZMxEFS+m6/+4wdYwWD
	GRUT9/Sa74xd/yUs4d95pSxTU/nSpzO3F9L0ISlB6LT98pF11u3ZUls77R2Mg6isqEvylk0PwLo
	B0oHkBKeP2CVpPsbzwVKQZ404VamK0IwhxTf1HfPMkEc8Vz59tzOjf0ZrJh/HrB3SmhtxxJEwwq
	oLujhdDBeg8DACkm5Y6QaHsSqFeslRBcThVCPZbPoOabkpp9r1rmjdYR7dY8f2OhHYd6CrF5Orv
	d/Y0sjGikud6W57c0hpjCThBBrYeajcYDAXOOEWW5EuenrAt2t+04QBDlG7uFgMzv6LYCPVAotw
	ZzJf9pOq8aS5n2gCIxJ+xyuMDbv7SxJ0c=
X-Received: by 2002:a05:600c:4584:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-483201e26acmr178083255e9.14.1770665229753;
        Mon, 09 Feb 2026 11:27:09 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5b1f17b1804b1-4834d5ebd34sm9173895e9.7.2026.02.09.11.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 11:27:09 -0800 (PST)
Date: Mon, 9 Feb 2026 11:27:06 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] nvmet: Implement CCR nvme command
Message-ID: <20260209192706.GN3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com>
 <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
 <20260203184039.GB3729-mkhalfella@purestorage.com>
 <21be273b-b1b2-4813-8178-e01cb0aa6301@suse.de>
 <20260204004417.GK3729-mkhalfella@purestorage.com>
 <d53ac6e1-af6a-46ce-9b91-946a26ee1043@suse.de>
 <20260204175250.GL3729-mkhalfella@purestorage.com>
 <a2b46f72-857d-4145-ba87-c36c88710f18@grimberg.me>
 <20260208231034.GD2392949-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208231034.GD2392949-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_112712_444853_6ED61279 
X-CRM114-Status: GOOD (  36.37  )
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

On Sun 2026-02-08 15:10:36 -0800, Mohamed Khalfella wrote:
> On Sat 2026-02-07 15:58:49 +0200, Sagi Grimberg wrote:
> > 
> > 
> > On 04/02/2026 19:52, Mohamed Khalfella wrote:
> > > On Wed 2026-02-04 01:55:18 +0100, Hannes Reinecke wrote:
> > >> On 2/4/26 01:44, Mohamed Khalfella wrote:
> > >>> On Wed 2026-02-04 01:38:44 +0100, Hannes Reinecke wrote:
> > >>>> On 2/3/26 19:40, Mohamed Khalfella wrote:
> > >>>>> On Tue 2026-02-03 04:19:50 +0100, Hannes Reinecke wrote:
> > >>>>>> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > >>>>>>> @@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
> > >>>>>>>      	return ctrl;
> > >>>>>>>      }
> > >>>>>>>      
> > >>>>>>> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> > >>>>>>> +					   const char *hostnqn, u8 ciu,
> > >>>>>>> +					   u16 cntlid, u64 cirn)
> > >>>>>>> +{
> > >>>>>>> +	struct nvmet_ctrl *ctrl;
> > >>>>>>> +	bool found = false;
> > >>>>>>> +
> > >>>>>>> +	mutex_lock(&subsys->lock);
> > >>>>>>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > >>>>>>> +		if (ctrl->cntlid != cntlid)
> > >>>>>>> +			continue;
> > >>>>>>> +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
> > >>>>>>> +			continue;
> > >>>>>>> +
> > >>>>>> Why do we compare the hostnqn here, too? To my understanding the host
> > >>>>>> NQN is tied to the controller, so the controller ID should be sufficient
> > >>>>>> here.
> > >>>>> We got cntlid from CCR nvme command and we do not trust the value sent by
> > >>>>> the host. We check hostnqn to confirm that host is actually connected to
> > >>>>> the impacted controller. A host should not be allowed to reset a
> > >>>>> controller connected to another host.
> > >>>>>
> > >>>> Errm. So we're starting to not trust values in NVMe commands?
> > >>>> That is a very slippery road.
> > >>>> Ultimately it would require us to validate the cntlid on each
> > >>>> admin command. Which we don't.
> > >>>> And really there is no difference between CCR and any other
> > >>>> admin command; you get even worse effects if you would assume
> > >>>> a misdirected 'FORMAT' command.
> > >>>>
> > >>>> Please don't. Security is _not_ a concern here.
> > >>> I do not think the check hurts. If you say it is wrong I will delete it.
> > >>>
> > >> It's not 'wrong', It's inconsistent. The argument that the contents of
> > >> an admin command may be wrong applies to _every_ admin command.
> > >> Yet we never check on any of those commands.
> > >> So I fail to see why this command requires special treatment.
> > > Okay, I will delete this check.
> > 
> > It is a very different command than other commands that nvmet serves. Format
> > is different because it is an attached namespace, hence the host should 
> > be able
> > to format it. If it would have been possible to access a namespace that 
> > is not mapped
> > to a controller, then this check would have been warranted I think.
> > 
> > There have been some issues lately opened on nvme-tcp that expose 
> > attacks that can
> > crash the kernel with some hand-crafted commands, I'd say that this is a 
> > potential attack vector.
> 
> For an attacker to exploit CCR command they will have to guess both CUI
> (8bit) and CIRN(64bit) random values correctly. I do not see how an
> attacker can find these values without being connected to the impacted
> controller.

I changed ciu and cirn sysfs controller attributes on the host from S_IRUGO
to S_IRUSR. This should mitigate an attack by unprivileged process
running on host. On the target side debugfs files already have S_IRUSR
so no change is needed.


