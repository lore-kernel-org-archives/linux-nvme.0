Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDEBEF06F8
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Feb 2026 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87FEGSXpVAnMUQR8bI4H8RD58BaU52BiJQ1S2S5ywak=; b=COInjPVrD/ZBRc2Jn00IwjxXuE
	2fQAc9Yjc4nEg8U4EwgDV11hAoEAf76E76h/A+6AP/YG3/yM5yxfmomkInaMDToVKp93gSFEkmkM3
	964M4PdQNMyGgddT5NxE8CfTyIvayENpSlQHsolzTwzE+oPYUDL7OyLlJ83AExXLMSlb3gHClgzj8
	3BifcfzBPuqHc87SN/CRle3DvPOZQhdtHg1ve1zKxO0pYk23xSweL4DVayRwJxiGG5gggMSjB9AN8
	7dFhBpgZBPm1GXRuYM84X+7MN+WlCpmaZ7RgjeRCrlfiQ8atkfHWTrfzLn7HDfXtzBm1g/MupKjcj
	/jIJy3pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpDvR-0000000EY6a-0MEc;
	Sun, 08 Feb 2026 23:10:45 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpDvK-0000000EY6E-1Q40
	for linux-nvme@lists.infradead.org;
	Sun, 08 Feb 2026 23:10:40 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso1212317b3a.0
        for <linux-nvme@lists.infradead.org>; Sun, 08 Feb 2026 15:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770592237; x=1771197037; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=87FEGSXpVAnMUQR8bI4H8RD58BaU52BiJQ1S2S5ywak=;
        b=Y/NfVMuTw0yTxO2QomJOoi800GZKAYFbyCXEirZd5f4cAj43gWuShYl08z9saJeByC
         jBT4Zp+dddVR2xiF4muClX+0kgYQsrQfdP54a4dTo70t6mQgIp+8D5PhwGdlADrxJ9HU
         IhLvtVO0gqMbEqZjY5suhiK4AxCOPEP0zxr/QTGg8iA+ceRppiScI0B6j1rYjvDi9hhP
         53c6FWQQLnEI4vd3Z3vgqrTN4RWKCQAet+i9WWoFv4ixnUcG0n8/moe1be6Rd2PaoYph
         qdzqbyUs0xwvV+i7x2fAZBxoKHNipBx5n6olAVhwfYmoztjb/ZhjYecu9JlsZIHM4S1a
         0dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592237; x=1771197037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87FEGSXpVAnMUQR8bI4H8RD58BaU52BiJQ1S2S5ywak=;
        b=FoAqqIp1jACo9JF6JPNWthvzE/DHAl8YNypNLuCpMfcmEZTjwV6t3FUIyvpfrHIRHT
         E883ip5zXjC89hpO0UzXRmjW3zjni5yrpNoqyZED88/gdBPu/rK2AiJ0aPtO643wOu1o
         F+GZerHANKUuGkPerPPDoeVoqxS6cfSb4m7BK9JKKzSPp3N504ZhHmF1S2HQfZrWQOqb
         SUR3FptNW2kK8GIeJvjO+uNiAq4L8OG1nZJZdX+DyZCMaBpj7j+O5j0FHEPe1sGXWkkV
         F7MEf8vsvkDud0RWqeq1Rz5eqcNeDdGSfZhIXVtDrqCA2gdaF9OoP7zA4iZCe40wUFLM
         Rh+A==
X-Forwarded-Encrypted: i=1; AJvYcCX7zsFAG7aQYJIZyiBaExdBtyfn3oWRTq+R/SeWQ9EmzewDnhSLU+kRLPFCN8MWA8E3i885OPyYW4Ww@lists.infradead.org
X-Gm-Message-State: AOJu0YxRzcg4BjGtFOGDiIbPT0o2g+hZGtr8nxM0y4DOuKUNvrA5J5H4
	tIWcyBZgXySQ1+Gvd1ZRKqD2DMmrwT2neiRSIRDluzhkkChQq/yRskgf1EhtQNzkY9w=
X-Gm-Gg: AZuq6aKcGmQo3V13IiSVGd3NqX37osRGc2e6zEOY53RpEJZ6uhBGIdNRoofzaMcOe61
	byxR4IhowQawzGaD3kHKbPPay0fIOLKImkAMc+a8RsQjc4RLmxqQP0xFL+teie81FfAW/KTai4a
	GzkJruyZ2qbBIp0qtf9UU/5vFTBXMvT1S2bjoaP+ldtuvuAJip+4TuhKTbsjDuL16P9jUVAmW1d
	U1JHi3aIzuFOQBb2RtPpoJFsg7XvquRbD4ogv6cIUeDfNZTCe4+sn7qA0gSXRVMh1xkz+oaAejF
	IUWTqizm20hQxu75Q6j/DOEv/X8TWZZYR4KtVFyarvs5IeVXBx6tCY4DtcLGliD/r2l0Zsq/asR
	hbd6YmIoAhhznM5VjxIsj5ff3JazPR4RT+eZhF2FAujLY1ar8DRuHwdjpqe7wkySYSFQ2BZGsDv
	rVROu98SzldG+P8/k=
X-Received: by 2002:aa7:9062:0:b0:81f:9b0a:812a with SMTP id d2e1a72fcca58-824416097f1mr8006691b3a.14.1770592236722;
        Sun, 08 Feb 2026 15:10:36 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-824416746cesm8521379b3a.11.2026.02.08.15.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:10:36 -0800 (PST)
Date: Sun, 8 Feb 2026 15:10:34 -0800
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
Message-ID: <20260208231034.GD2392949-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com>
 <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
 <20260203184039.GB3729-mkhalfella@purestorage.com>
 <21be273b-b1b2-4813-8178-e01cb0aa6301@suse.de>
 <20260204004417.GK3729-mkhalfella@purestorage.com>
 <d53ac6e1-af6a-46ce-9b91-946a26ee1043@suse.de>
 <20260204175250.GL3729-mkhalfella@purestorage.com>
 <a2b46f72-857d-4145-ba87-c36c88710f18@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b46f72-857d-4145-ba87-c36c88710f18@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260208_151038_545638_554D0C48 
X-CRM114-Status: GOOD (  30.73  )
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

On Sat 2026-02-07 15:58:49 +0200, Sagi Grimberg wrote:
> 
> 
> On 04/02/2026 19:52, Mohamed Khalfella wrote:
> > On Wed 2026-02-04 01:55:18 +0100, Hannes Reinecke wrote:
> >> On 2/4/26 01:44, Mohamed Khalfella wrote:
> >>> On Wed 2026-02-04 01:38:44 +0100, Hannes Reinecke wrote:
> >>>> On 2/3/26 19:40, Mohamed Khalfella wrote:
> >>>>> On Tue 2026-02-03 04:19:50 +0100, Hannes Reinecke wrote:
> >>>>>> On 1/30/26 23:34, Mohamed Khalfella wrote:
> >>>>>>> @@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
> >>>>>>>      	return ctrl;
> >>>>>>>      }
> >>>>>>>      
> >>>>>>> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> >>>>>>> +					   const char *hostnqn, u8 ciu,
> >>>>>>> +					   u16 cntlid, u64 cirn)
> >>>>>>> +{
> >>>>>>> +	struct nvmet_ctrl *ctrl;
> >>>>>>> +	bool found = false;
> >>>>>>> +
> >>>>>>> +	mutex_lock(&subsys->lock);
> >>>>>>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> >>>>>>> +		if (ctrl->cntlid != cntlid)
> >>>>>>> +			continue;
> >>>>>>> +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
> >>>>>>> +			continue;
> >>>>>>> +
> >>>>>> Why do we compare the hostnqn here, too? To my understanding the host
> >>>>>> NQN is tied to the controller, so the controller ID should be sufficient
> >>>>>> here.
> >>>>> We got cntlid from CCR nvme command and we do not trust the value sent by
> >>>>> the host. We check hostnqn to confirm that host is actually connected to
> >>>>> the impacted controller. A host should not be allowed to reset a
> >>>>> controller connected to another host.
> >>>>>
> >>>> Errm. So we're starting to not trust values in NVMe commands?
> >>>> That is a very slippery road.
> >>>> Ultimately it would require us to validate the cntlid on each
> >>>> admin command. Which we don't.
> >>>> And really there is no difference between CCR and any other
> >>>> admin command; you get even worse effects if you would assume
> >>>> a misdirected 'FORMAT' command.
> >>>>
> >>>> Please don't. Security is _not_ a concern here.
> >>> I do not think the check hurts. If you say it is wrong I will delete it.
> >>>
> >> It's not 'wrong', It's inconsistent. The argument that the contents of
> >> an admin command may be wrong applies to _every_ admin command.
> >> Yet we never check on any of those commands.
> >> So I fail to see why this command requires special treatment.
> > Okay, I will delete this check.
> 
> It is a very different command than other commands that nvmet serves. Format
> is different because it is an attached namespace, hence the host should 
> be able
> to format it. If it would have been possible to access a namespace that 
> is not mapped
> to a controller, then this check would have been warranted I think.
> 
> There have been some issues lately opened on nvme-tcp that expose 
> attacks that can
> crash the kernel with some hand-crafted commands, I'd say that this is a 
> potential attack vector.

For an attacker to exploit CCR command they will have to guess both CUI
(8bit) and CIRN(64bit) random values correctly. I do not see how an
attacker can find these values without being connected to the impacted
controller.

