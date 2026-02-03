Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC2E87855
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 18:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=toEdX66AExMzMeOPPD7ACZ/dROdO5SBZOD0RUcnczeQ=; b=hAWUH+ztZJYsl/VRyxSqQgwM/9
	ECEQd7BgnaRtt4iC4mKZwWSabrvIkoAqKAWivW9lFVYG50gSHkIKmvR3JHGOwcNu6Wi8iASu8e5hw
	YndvaCR1519b/CaoH4Ds78FjqbOCTxxVbbFJVhXQRsf/UObQy4cp6dleFQfiPsQpHBz97fI7E0/f8
	J6mwrZNUnXXvabgr+tHzTb3BVo8WZhCaICCMwDjMFPhf9TUnCPw5ajNXlk5Pphwn8TZp/2k0pvh5W
	rQgZiOqkoTgNY87Dd4y2Y+81wl8bSM6VVwcBIPI2LgVzIy3L5jutwDxaGqdJZxkM12sp/7Asubg9m
	zAJ9KcDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLRY-00000007BzH-2MZT;
	Tue, 03 Feb 2026 18:48:08 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLRV-00000007Byn-1UVd
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 18:48:06 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-2b7381d2d95so81196eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 10:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770144484; x=1770749284; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=toEdX66AExMzMeOPPD7ACZ/dROdO5SBZOD0RUcnczeQ=;
        b=LywNofY36mL/a1wQJI7fNeIuPZW84foqYtXdHEiApDUyWTCylFGctO/lAEojzFgxyD
         ARvYFltOFhKI2I7Mniz/mh0abCj88llQo0H8bEuImsR7oRxzzqnvnTDP6igw/i1hK1i+
         qKPZbTa5JRHPhUsquNw9Gn8y7TK/kaWvV7LTJIhiCNVZ2J7NZxOG3O4/5FeHSBmmb2ug
         hiwcjt0/fakrhSiclzKk1FUNHmYzvlFMHlbIGWn3zmZsBDpc66zznAba4BkXwTSnhP9+
         nDIByUCElqdvhd+ilcjHwbgcmRSRXxTZUMXc2IXc3B8FS5cAnU+82CAD4aHzLU6lxkMh
         wn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144484; x=1770749284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toEdX66AExMzMeOPPD7ACZ/dROdO5SBZOD0RUcnczeQ=;
        b=bexZqRjnJL/2oNP0M2Y1sU7DYin5WwiTFIjK+HrW8qRKV/nvLSNX1uG1o99bAGJD6i
         klge9XDefc0eaLUg/rYWE2S7aeeg5ZbmYfhjdWKcP/hMCI2RqpqZ6iCz1kglSoxB0YqQ
         iCp6goTtzYizNxLDkb8vm1bowbR+28KDapjUrTTWDKXiWhvF+SjSW4CNPnS0tQ8zWLnx
         vvflYZJmTynIE2QnFnVl1DyjqxjQkQaofUJqh54cMMvdeOf1+ibmivEKc++voik12dfJ
         Me14iM7Yannfi6nMOgldRnog2NNDYZgp+QVNBs892EmkKTkWdg+WMEIWFMRwZD/4iLSg
         A0VA==
X-Forwarded-Encrypted: i=1; AJvYcCUbl+9DnUeAXgYcoLfFqz0O2v0mZdYe9WUi28tUM80qOtk25yVnt3GEj0kW898vv+EMUZF1d/wZRcdj@lists.infradead.org
X-Gm-Message-State: AOJu0YyGgXKhHiWEbQ1t6PyRn5R3NXiZYLM/nxZgB3RcVotQ+tsvHzpE
	B9Grg3ydgmzGCQ4Z3xfY/pEmm7qcE+R6JOEaiIhanb4rws5fLeBarWVOP608+HS1kSU=
X-Gm-Gg: AZuq6aIdxLwuDe5gaPybd+Lum7ftovajukUTFupHmJZn+77ZnDkiuKWz3HBCTUxHyMr
	SavDZWNqa/Zc76Itn7WS7f2Iit7Z/teZ77oC6zsX4H7M3hYc21f1FktuG3YcUEf2wld/Mdw+ZWS
	7kvlX1YfWlatmpIUxnHxw6BeUtGg9Hi0Bd1C68lbsAyHeK70mI7T7veYanmgVMupr4NTT55bpCD
	smUCw+b1w2gwC1V9mA+pM5Wzs8JqKU9TuGswo6MaPTh+HL8KMbVbe053NYqc3PbxNNPF7iYNZ3L
	yJ5tahi2AsAroOzIYbnugMqkINnfu744fiE58Xan8fZuhuSKET4S9unuLUaE+oZQ6/oYoCCYvUc
	jahnT7KvNIZ04OU2ZnznP8wMfNnz/NvHDljWl2HO2WnyrmfDU+tHOJYTUmpkGpzUsCV/L07frNs
	JX5le8mpIg5EpMJetLLHK7dZnnWbMRntGXvNA2fzbzKg==
X-Received: by 2002:a05:7300:ed0a:b0:2b7:a6fa:3f87 with SMTP id 5a478bee46e88-2b832ec924cmr130840eec.19.1770144483742;
        Tue, 03 Feb 2026 10:48:03 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b832feacc6sm266190eec.35.2026.02.03.10.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:48:03 -0800 (PST)
Date: Tue, 3 Feb 2026 10:48:02 -0800
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
Subject: Re: [PATCH v2 05/14] nvmet: Send an AEN on CCR completion
Message-ID: <20260203184802.GC3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-6-mkhalfella@purestorage.com>
 <3e5a7153-662d-479f-8205-c17cd3f35455@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5a7153-662d-479f-8205-c17cd3f35455@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_104805_417756_EFBEC18E 
X-CRM114-Status: GOOD (  23.50  )
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

On Tue 2026-02-03 04:27:39 +0100, Hannes Reinecke wrote:
> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > Send an AEN to initiator when impacted controller exists. The
> > notification points to CCR log page that initiator can read to check
> > which CCR operation completed.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/target/core.c  | 25 ++++++++++++++++++++++---
> >   drivers/nvme/target/nvmet.h |  3 ++-
> >   include/linux/nvme.h        |  3 +++
> >   3 files changed, 27 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> > index 54dd0dcfa12b..ae2fe9f90bcd 100644
> > --- a/drivers/nvme/target/core.c
> > +++ b/drivers/nvme/target/core.c
> > @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
> >   	nvmet_async_events_process(ctrl);
> >   }
> >   
> > -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> > +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
> >   		u8 event_info, u8 log_page)
> >   {
> >   	struct nvmet_async_event *aen;
> > @@ -215,13 +215,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >   	aen->event_info = event_info;
> >   	aen->log_page = log_page;
> >   
> > -	mutex_lock(&ctrl->lock);
> >   	list_add_tail(&aen->entry, &ctrl->async_events);
> > -	mutex_unlock(&ctrl->lock);
> >   
> >   	queue_work(nvmet_wq, &ctrl->async_event_work);
> >   }
> >   
> > +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> > +		u8 event_info, u8 log_page)
> > +{
> > +	mutex_lock(&ctrl->lock);
> > +	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
> > +	mutex_unlock(&ctrl->lock);
> > +}
> > +
> >   static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
> >   {
> >   	u32 i;
> > @@ -1788,6 +1794,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
> >   }
> >   EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
> >   
> > +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
> > +{
> > +	lockdep_assert_held(&ctrl->lock);
> > +
> > +	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
> > +		return;
> > +
> > +	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
> > +				     NVME_AER_NOTICE_CCR_COMPLETED,
> > +				     NVME_LOG_CCR);
> > +}
> > +
> >   static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> >   {
> >   	struct nvmet_subsys *subsys = ctrl->subsys;
> 
> But what does the CCR command actually _do_?
> At the very lease I would have expected it to trigger a controller reset
> (eg calling into nvmet_ctrl_fatal_error()), yet I don't see it doing
> that anywhere ...

[PATCH v2 03/14] nvmet: Implement CCR nvme command
is where impacted controller is told to fail. It does exactly what you
mentioned above.

+out_unlock:
+       mutex_unlock(&sctrl->lock);
+       if (status == NVME_SC_SUCCESS)
+               nvmet_ctrl_fatal_error(ictrl);
+       nvmet_ctrl_put(ictrl);
+out:
+       nvmet_req_complete(req, status);

I refactored the error handling codepath into success codepath. That is
why I think it is kind of hidden. If this is not obvious I can separate
the two codepaths. What do you think?

