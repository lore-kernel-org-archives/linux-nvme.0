Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2B7EE644A
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=plHL9+oSbLNnTM7eUaDrsYWcFptA7VDrjL54CvUj6zE=; b=iaXQU0fJFVfM5tOIVZQlS1TO9X
	StUn1oQ9QH2JZp9oGbphLNaMzNXeWdP13XkC30Rzrss0Mi6ROA45M6pqkz9PdC7vYYlP9xyxAqkHM
	WwbfanxdPWXxFK8zw5uUjiqffTE2BgX5sm2E5WJJ+Q7sUkii1KYdAtY7UXXRhQwgbMjlBlwQo1yV9
	LY3xEXRYbEgejnuB2KzTb9mVwkucPqAIvk9BuLuWTVDnOGveJPikwY5pgIvIV0O8Qxrv0mrF1NI08
	E9h/kvXJICio0PcMOX1PrRXzCVmsx5pDdn+LWWQ9meeQfx+8ASnqaagmbCvbYBhSxl69ITBuMxNtz
	wvKF573g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb4F0-00000006NqR-1Bww;
	Wed, 31 Dec 2025 22:00:26 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb4Ey-00000006Nq3-1hPv
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 22:00:25 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2a07fac8aa1so119837435ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 14:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767218423; x=1767823223; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plHL9+oSbLNnTM7eUaDrsYWcFptA7VDrjL54CvUj6zE=;
        b=VYvZswwjNv1vZ63XkJEK5FYOwqbvh5dkVAU2FMr7ORSZ4aAyDBgW6AXkdcNYBBYD/c
         FmlInJ8oCIwRKngo8wgMed992PCgAM7UQh2FAJrJYS8gA6ldXd8Cx20fdDWORCb3YX05
         Qn0+ddbhPqHAxln8kzg/qAH27e51KlGvShuzpnL8s5rj17Rq38A4Fed88ELE/XrromL5
         EIaJMy2RD7T6cEvsl8tpD5ojAp6yrtlPHl0EhjA9hNuLsIawLAEaQmT57z8b/5AVMeUl
         lOFmefHlr6qguTlj9NKexvbLrWHYgbUa2tGjOjOSBatI3sn0Rp1XRsOnkKxJbBKjlBVs
         l3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767218423; x=1767823223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plHL9+oSbLNnTM7eUaDrsYWcFptA7VDrjL54CvUj6zE=;
        b=XvrbSRCWOGI0Mk66CvJTl2Fp+ShBaLV6f6jId9meGkJX1UWlaxNm3Y5BNERqAGmPgq
         xmgtbSQ4XVH+VN6cWR1J2emPyVUmeKfbuFWDE555O70xoATB+Lpoyc8H4UygOwiRC93U
         Cn0cylUjzukh7g6ygcTjXS7+mw6XDcdp0tmzCESQ1zl1D/Q9Cu26C/OAZrbu0ZsWbCtS
         gifNwtK9RpHeRcDYW5Enk8qKwrRjMBsqathoZsRjffOAXfB2l1JN1Is4RwEEmyQteFYh
         hCxshdgUfU68GHkaRLNAZUEJUSgyjl0k4FlEEVqNufwKHWx4py5VlWWipMn2lD5bXN/e
         o2SA==
X-Forwarded-Encrypted: i=1; AJvYcCVQT+HBcPCew8ZTKUyleZAZJsXF+WSOvQdKH+P5CW7d/c8MCDs0i8mld7JE+okjOu2SRherP2r+hA3P@lists.infradead.org
X-Gm-Message-State: AOJu0YxO2FHyM0MWVtVvc382Jq6S2hKsbFlLaZq5C55+2/CHcS4z6Z8x
	/Lftb2hh5WhrtFiF/R5RRcalzcm5eshY11zj6qtyfMcvoipQ1STTW4uGqlg/si+jEzY=
X-Gm-Gg: AY/fxX5qWn3r435EbaY/seSdfXgwzg/tjjx7neEBcT3YgF+ViGkI8GjiqlIhIhyAN+d
	ECkAJZMisROZudBsWHCRrdSViGx9w4sZVZl9MRegArFm1rJHsXUoyEesYKIAYOS0YgJQL++fdEP
	5psemhAIWHJEy19IceddzDl2JteHrUVJyyN7zv/NxvEFO0z+5tP088keiYDsPnfPJ+3RH5OND9L
	z7d2ETE/7pWkvnhSOvApzsmcM9KWw3duPv1hIiavFY0eUr2m8hddGMUnaWB9DaESdqNWJu0Qbx8
	I3rBroi5rNwPpfyepFc1K2QqBZqHboniZECh8tlXXnT8z0ogM6ujz/vKRWkP2DEIwJgZts3kV7e
	3XoYrHZ5gabWBR2AngueZPANxt3//eZcWsieDo6eJtDRMJO9UU7UwyU6vKOqQiaoJgs8dubWMyX
	m6fxiN1FdfatB1vTNdjtjThf47yqJ6NCo=
X-Google-Smtp-Source: AGHT+IErmVq2ZJJlRu6w72hZrcFPXfclS6rhnNiGuSvJ7jAIOyFnVwerOHWwtv4A61/jRRnREzQcWw==
X-Received: by 2002:a05:7022:e1b:b0:11b:b622:cad9 with SMTP id a92af1059eb24-121722b44a8mr36254861c88.21.1767218421818;
        Wed, 31 Dec 2025 14:00:21 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-1217254c734sm144726019c88.13.2025.12.31.14.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:00:21 -0800 (PST)
Date: Wed, 31 Dec 2025 14:00:20 -0800
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
Message-ID: <20251231220020.GK3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-6-mkhalfella@purestorage.com>
 <13c2bf9c-6eac-4c48-b12c-f76e86c8ef32@grimberg.me>
 <20251225181313.GC8129-mkhalfella@purestorage.com>
 <eaf73b5a-a438-4afe-a76e-148a7d9744ef@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf73b5a-a438-4afe-a76e-148a7d9744ef@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_140024_477012_BA4EA95E 
X-CRM114-Status: GOOD (  39.00  )
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

On Sat 2025-12-27 11:48:49 +0200, Sagi Grimberg wrote:
> 
> 
> On 25/12/2025 20:13, Mohamed Khalfella wrote:
> > On Thu 2025-12-25 15:23:51 +0200, Sagi Grimberg wrote:
> >>
> >> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> >>> Send an AEN to initiator when impacted controller exists. The
> >>> notification points to CCR log page that initiator can read to check
> >>> which CCR operation completed.
> >>>
> >>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> >>> ---
> >>>    drivers/nvme/target/core.c  | 27 +++++++++++++++++++++++----
> >>>    drivers/nvme/target/nvmet.h |  3 ++-
> >>>    include/linux/nvme.h        |  3 +++
> >>>    3 files changed, 28 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> >>> index 7dbe9255ff42..60173833c3eb 100644
> >>> --- a/drivers/nvme/target/core.c
> >>> +++ b/drivers/nvme/target/core.c
> >>> @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
> >>>    	nvmet_async_events_process(ctrl);
> >>>    }
> >>>    
> >>> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >>> +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
> >>>    		u8 event_info, u8 log_page)
> >>>    {
> >>>    	struct nvmet_async_event *aen;
> >>> @@ -215,12 +215,17 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >>>    	aen->event_info = event_info;
> >>>    	aen->log_page = log_page;
> >>>    
> >>> -	mutex_lock(&ctrl->lock);
> >>>    	list_add_tail(&aen->entry, &ctrl->async_events);
> >>> -	mutex_unlock(&ctrl->lock);
> >>>    
> >>>    	queue_work(nvmet_wq, &ctrl->async_event_work);
> >>>    }
> >>> +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >>> +		u8 event_info, u8 log_page)
> >>> +{
> >>> +	mutex_lock(&ctrl->lock);
> >>> +	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
> >>> +	mutex_unlock(&ctrl->lock);
> >>> +}
> >>>    
> >>>    static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
> >>>    {
> >>> @@ -1788,6 +1793,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
> >>>    }
> >>>    EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
> >>>    
> >>> +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
> >>> +{
> >>> +	lockdep_assert_held(&ctrl->lock);
> >>> +
> >>> +	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
> >>> +		return;
> >>> +
> >>> +	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
> >>> +				     NVME_AER_NOTICE_CCR_COMPLETED,
> >>> +				     NVME_LOG_CCR);
> >>> +}
> >>> +
> >>>    static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> >>>    {
> >>>    	struct nvmet_subsys *subsys = ctrl->subsys;
> >>> @@ -1801,8 +1818,10 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> >>>    	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> >>>    		mutex_lock(&sctrl->lock);
> >>>    		list_for_each_entry(ccr, &sctrl->ccrs, entry) {
> >>> -			if (ccr->ctrl == ctrl)
> >>> +			if (ccr->ctrl == ctrl) {
> >>> +				nvmet_ctrl_notify_ccr(sctrl);
> >>>    				ccr->ctrl = NULL;
> >>> +			}
> >> Is this double loop necessary? Would you have more than one controller
> >> cross resetting the same
> > As it is implemented now CCRs are linked to sctrl. This decision can be
> > revisited if found suboptimal. At some point I had CCRs linked to
> > ctrl->subsys but that led to lock ordering issues. Double loop is
> > necessary to find all CCRs in all controllers and mark them done.
> > Yes, it is possible to have more than one sctrl resetting the same
> > ictrl.
> 
> I'm more interested in simplifying.
> 
> >
> >> controller? Won't it be better to install a callback+opaque that the
> >> controller removal will call?
> > Can you elaborate more on that? Better in what terms?
> >
> > nvmet_ctrl_complete_pending_ccr() is called from nvmet_ctrl_free() when
> > we know that ctrl->ref is zero and no new CCRs will be added to this
> > controller because nvmet_ctrl_find_get_ccr() will not be able to get it.
> 
> In nvmet, the controller is serving a single host. Hence I am not sure I
> understand how multiple source controllers will try to reset the impacted
> controller. So, if there is a 1-1 relationship between source and impacted
> controller, I'd perhaps suggest to simplify and install on the impacted 
> controller
> callback+opaque (e.g. void *data) instead of having it iterate and then 
> actually send
> the AEN from the impacted controller.

A controller is serving a single path for a given host. A host that is
connected to nvme subsystem via multiple paths will have more than one
controller. I can think of two reasons why we need to support resetting
an impacted controller from multiple source controllers.

- It is possible for multiple paths to go down at the same time. The
  first source controller we use for CCR, even though we check to see if
  LIVE, might have lost connection to subsystem. It is a matter of time
  for it to see keepalive timeout and fail too. If CCR fails using this
  controller we should not give up. We need to try other paths.

- Some nvme subsystems might support resetting impacted controller from
  a subset of controllers connected to the host. An array that has
  multiple frontend engines might not support resetting controllers
  across engines. In fact, TP8028 allows for subsystem to suggest to
  host to use another source controller in Alternate Controller ID
  (ACID) fied on CCR logpage (not implemente in this patchset).

