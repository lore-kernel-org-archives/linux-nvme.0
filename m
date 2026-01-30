Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E0CE6BF3C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0X2ZQ9UOyfp3ToxPGW0s5g5NWoV+yr/cg+LR8OLcIM=; b=IQJpcYcVNYh557Je7MzR6U1mjt
	+6U7x2lVsHy4T8rSAD4ZSPrkwrZXMLoU2MMHyuNBOpxog4dAYAPQnFC656FDnSxVZVgOmEW/8kg/D
	V0SuRgbKt6LejKnmvCNblgtPI5+skerJiCEZnN1iLEaOvpj731l0O9C0zANPSoH01x9R6R9OrDoX5
	ZP0MZXX9mrI8k3g0mMi6hPTOiQ3D+TzLKjgXmwVUZB01Eei7MyLywxw1N1K7ueC3CKZBTS1S8EsoE
	0xZ/1XcCI+JmAw/HLRes25BsGnQVdioBCpVio8462q3zKpPaO0D9vbPh2xp/WSgBBCE8IOsRvlDV0
	kY9c+pvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx1m-000000022K1-2jMa;
	Fri, 30 Jan 2026 22:31:46 +0000
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx1k-000000022Jg-1bR2
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:31:45 +0000
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-2b70abe3417so6004114eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812303; x=1770417103; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0X2ZQ9UOyfp3ToxPGW0s5g5NWoV+yr/cg+LR8OLcIM=;
        b=RnxkV7OJI/QfsO60j5LejjBpPHP3HcLiXGaYrVzs2HHicDTmvsj97XGpLU3lMwThzi
         +uBpFTysdJHUhS74DZ17kJ+pyGwmbdENPWlMwojea3Cw3dO8c6pYrun6LqSGjIvhUBOx
         9gQQT9jW+t048V+2XBgY8t+ckfAWAP4hPSCyPrVCKc0krqc/NbJtTGXI3hwFofCPdOap
         y8HYW0kmKkbl/qz1te91olbMp28dOEXR3fhtZRZd64Skjmw8BfIjiKSX34/OFsZ64K38
         +PnqRPLrldKLXDQjQ54EdyXTHvrc6OGhJqKSAZV7MBzENZMnqIz1JUxH8m/o6XiBGlim
         +tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812303; x=1770417103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0X2ZQ9UOyfp3ToxPGW0s5g5NWoV+yr/cg+LR8OLcIM=;
        b=LQkNjXhGjWUF9O94LGnPV3LRyggvLywyn7vt5fHtSiBJfBlrzHROPk07Lc+0f3BBHW
         sy3/pjd++eV54GYfSz6k6Z+TnYfqmn7Y4q3Pmh0YwluckkESdPVSH5QwCTjYDwkZf0fa
         hbuv28tQAtPtOPIJqikuzFO2ujpGdDQD88u5eB1rkmnOOS46DDu33q/kn9+beN0pN07/
         iR8Rf6E+7qAnmjzdH0N9YYEI8nYndu5XWo4PnIfLIlClkKCEqHed/WmLYm+DW+ITu19I
         eG7fYrSQijX6K4nBx4B881ha2v0iAs6EaK5T8Ec45+Sd7ya7514jlcdsMfrBMh4Xrpha
         7CaA==
X-Forwarded-Encrypted: i=1; AJvYcCUdiV+6YBsnXxaRQzfZVsSTk+rv+Ql+xqTGyfgN/4oA5dmdAK9PRfGzUkbRBC4wtgRBfpJiBEfYLJN9@lists.infradead.org
X-Gm-Message-State: AOJu0YyrD2Q6xw4NnG3XEOPZso7gn0Qrg2DK6gBN/7bVzTEGHjGiI/nU
	whoGHa7D1TZIVBilW3agpOQw6vrrvLPfm+eiW066aRkiZyErjofJwirp5Dduj4cy0kE=
X-Gm-Gg: AZuq6aIMyXEbqjfN3pNF8rZlALXMmbI+CfvKjCUowGdvsUYtwwMzyV4TkMtxZfQyGom
	6W+8GAcWlaX0giwq4zqp9FxdO8OVlSwYRT90qkDWfeVp0BbqpeJDww6j5SUKpIKRk1lNt1iP9h5
	9NOVocNOPgWaPk2jgnj8GMYBBYOb/2u/jZ2ZqTyqVsX8PWtL9E4nlzRgItgpc1M8RCU6jhQRiwK
	SZuKoRF0eyGg1Iad2OStBSDAlx07JvkRziQTSG/bDNtzPDvo2g3bL6gUoyBPVpvkgGZ7Uy9vJqQ
	cnMpsujpFcMUNd/ZjtC7S3PI9/qiTNQON8LwY8qBXr67V5abkWmkiS9VCa1awcKIqo4xYRk6yhs
	edQ+WgUMmDVCCzyKkP57N62l5WRHNFKnYbD4rowLv2qWxLr+6v6fIiijy9GPKaXALzigC125q8j
	ciLweILP5FKzA7Cb8uVlWbJHds85t3x5U=
X-Received: by 2002:a05:7301:1016:b0:2ae:5ffa:8daa with SMTP id 5a478bee46e88-2b7c862673fmr1658612eec.5.1769812302264;
        Fri, 30 Jan 2026 14:31:42 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b7a1af8ac0sm12987901eec.35.2026.01.30.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:31:41 -0800 (PST)
Date: Fri, 30 Jan 2026 14:31:40 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/14] nvmet: Send an AEN on CCR completion
Message-ID: <20260130223140.GF1710902-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-6-mkhalfella@purestorage.com>
 <13c2bf9c-6eac-4c48-b12c-f76e86c8ef32@grimberg.me>
 <20251225181313.GC8129-mkhalfella@purestorage.com>
 <eaf73b5a-a438-4afe-a76e-148a7d9744ef@grimberg.me>
 <20251231220020.GK3864520-mkhalfella@purestorage.com>
 <06f365d8-9861-4c22-a226-06c8c3b2cc5e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06f365d8-9861-4c22-a226-06c8c3b2cc5e@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143144_456781_19F28043 
X-CRM114-Status: GOOD (  54.73  )
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

On Sun 2026-01-04 23:09:54 +0200, Sagi Grimberg wrote:
> 
> 
> On 01/01/2026 0:00, Mohamed Khalfella wrote:
> > On Sat 2025-12-27 11:48:49 +0200, Sagi Grimberg wrote:
> >> On 25/12/2025 20:13, Mohamed Khalfella wrote:
> >>> On Thu 2025-12-25 15:23:51 +0200, Sagi Grimberg wrote:
> >>>> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> >>>>> Send an AEN to initiator when impacted controller exists. The
> >>>>> notification points to CCR log page that initiator can read to check
> >>>>> which CCR operation completed.
> >>>>>
> >>>>> Signed-off-by: Mohamed Khalfella<mkhalfella@purestorage.com>
> >>>>> ---
> >>>>>     drivers/nvme/target/core.c  | 27 +++++++++++++++++++++++----
> >>>>>     drivers/nvme/target/nvmet.h |  3 ++-
> >>>>>     include/linux/nvme.h        |  3 +++
> >>>>>     3 files changed, 28 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> >>>>> index 7dbe9255ff42..60173833c3eb 100644
> >>>>> --- a/drivers/nvme/target/core.c
> >>>>> +++ b/drivers/nvme/target/core.c
> >>>>> @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
> >>>>>     	nvmet_async_events_process(ctrl);
> >>>>>     }
> >>>>>     
> >>>>> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >>>>> +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
> >>>>>     		u8 event_info, u8 log_page)
> >>>>>     {
> >>>>>     	struct nvmet_async_event *aen;
> >>>>> @@ -215,12 +215,17 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >>>>>     	aen->event_info = event_info;
> >>>>>     	aen->log_page = log_page;
> >>>>>     
> >>>>> -	mutex_lock(&ctrl->lock);
> >>>>>     	list_add_tail(&aen->entry, &ctrl->async_events);
> >>>>> -	mutex_unlock(&ctrl->lock);
> >>>>>     
> >>>>>     	queue_work(nvmet_wq, &ctrl->async_event_work);
> >>>>>     }
> >>>>> +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >>>>> +		u8 event_info, u8 log_page)
> >>>>> +{
> >>>>> +	mutex_lock(&ctrl->lock);
> >>>>> +	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
> >>>>> +	mutex_unlock(&ctrl->lock);
> >>>>> +}
> >>>>>     
> >>>>>     static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
> >>>>>     {
> >>>>> @@ -1788,6 +1793,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
> >>>>>     }
> >>>>>     EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
> >>>>>     
> >>>>> +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
> >>>>> +{
> >>>>> +	lockdep_assert_held(&ctrl->lock);
> >>>>> +
> >>>>> +	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
> >>>>> +		return;
> >>>>> +
> >>>>> +	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
> >>>>> +				     NVME_AER_NOTICE_CCR_COMPLETED,
> >>>>> +				     NVME_LOG_CCR);
> >>>>> +}
> >>>>> +
> >>>>>     static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> >>>>>     {
> >>>>>     	struct nvmet_subsys *subsys = ctrl->subsys;
> >>>>> @@ -1801,8 +1818,10 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> >>>>>     	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> >>>>>     		mutex_lock(&sctrl->lock);
> >>>>>     		list_for_each_entry(ccr, &sctrl->ccrs, entry) {
> >>>>> -			if (ccr->ctrl == ctrl)
> >>>>> +			if (ccr->ctrl == ctrl) {
> >>>>> +				nvmet_ctrl_notify_ccr(sctrl);
> >>>>>     				ccr->ctrl = NULL;
> >>>>> +			}
> >>>> Is this double loop necessary? Would you have more than one controller
> >>>> cross resetting the same
> >>> As it is implemented now CCRs are linked to sctrl. This decision can be
> >>> revisited if found suboptimal. At some point I had CCRs linked to
> >>> ctrl->subsys but that led to lock ordering issues. Double loop is
> >>> necessary to find all CCRs in all controllers and mark them done.
> >>> Yes, it is possible to have more than one sctrl resetting the same
> >>> ictrl.
> >> I'm more interested in simplifying.
> >>
> >>>> controller? Won't it be better to install a callback+opaque that the
> >>>> controller removal will call?
> >>> Can you elaborate more on that? Better in what terms?
> >>>
> >>> nvmet_ctrl_complete_pending_ccr() is called from nvmet_ctrl_free() when
> >>> we know that ctrl->ref is zero and no new CCRs will be added to this
> >>> controller because nvmet_ctrl_find_get_ccr() will not be able to get it.
> >> In nvmet, the controller is serving a single host. Hence I am not sure I
> >> understand how multiple source controllers will try to reset the impacted
> >> controller. So, if there is a 1-1 relationship between source and impacted
> >> controller, I'd perhaps suggest to simplify and install on the impacted
> >> controller
> >> callback+opaque (e.g. void *data) instead of having it iterate and then
> >> actually send
> >> the AEN from the impacted controller.
> > A controller is serving a single path for a given host. A host that is
> > connected to nvme subsystem via multiple paths will have more than one
> > controller. I can think of two reasons why we need to support resetting
> > an impacted controller from multiple source controllers.
> >
> > - It is possible for multiple paths to go down at the same time. The
> >    first source controller we use for CCR, even though we check to see if
> >    LIVE, might have lost connection to subsystem. It is a matter of time
> >    for it to see keepalive timeout and fail too. If CCR fails using this
> >    controller we should not give up. We need to try other paths.
> 
> But the host is doing the cross-reset synchronously... it waits for
> kato for a completion of the reset, and then gives up, its not like it
> is sitting there waiting for the AEN...
> 
> Generally the fact that the spec states a capability/flexibility, it is 
> still Linux's
> choice to choose weather to implement it. I'm trying to understand if we can
> simplify Linux host and controller in this non-trivial error recovery flow.
> 
> What is your expectation to happen in general? what are your expected 
> kato/cqt
> values? how many attempts do we want the host to do?

For a target that support CCR it is expected to support CQT as well. If
the initiator notices path failure then it either needs to get the
impacted controller reset via CCR or wait for time-based recovery. Time
based recovery adds long delay (n * kato + cqt), CCR is expected to take
way less time. This is why initiator should try CCR for as long as there
is time and paths to do so. The alternative is to sit and wait and do
nothing.

kato defaults to 5 seconds. cqt depends on the implementation on the
target. I tested these changes with 30s of cqt. With traffic based
keepalive time-based recovery takes 3 * 5 + 30 = 45s. In case of partial
path failure CCR finished in milliseconds. This is why it is better to
try every possible path before giving up. There is no fixed number of
attempts. As long as there is time to try CCR and there are paths to try
the initiator should continue trying CCR. Again, we do not want to
fallback to time-based recovery unless there are no options.


        tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
        if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
                ret = -ETIMEDOUT;
                goto out;
        }

This is the code that waits for CCR to finish after CCR command was
accepted by the target. The specs does not say how much time host should
wait. max(cqt, kato) felt like reasonable value.

> 
> > - Some nvme subsystems might support resetting impacted controller from
> >    a subset of controllers connected to the host. An array that has
> >    multiple frontend engines might not support resetting controllers
> >    across engines. In fact, TP8028 allows for subsystem to suggest to
> >    host to use another source controller in Alternate Controller ID
> >    (ACID) fied on CCR logpage (not implemente in this patchset).
> 
> It is not a case though where the impacted controller will be reset from 
> multiple
> source controller at the same time...
> 
> I'd also say that if indeed there are subsystems that require specific 
> controllers to do
> cross recovery, they won't be able to use this at all... Are there any 
> such arrays?

Not at all. CCR is still useful in the case of partial connectivity
failure to the same engine. I can not name a product that does that
today.

