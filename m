Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB27109C058
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2026 19:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3CFNV3fXhTyYK2FfmGVgZlda+hYMW+xdTutgAp9N5H0=; b=cqPfoO5KIeO+kvj7AvepuW1gsK
	S5Mqcb9K8xDRFYczz0zunPFiu7TzsLPAXbCCqNzfDnPkz2F2y5JHod3NAGcZxv6DENEZeLRPPTGjj
	FEjGf+s+fiFnMzhZXLlu427Ojj8o04/Kx5Wr0YjwY9xjlQq9f8VSId49KKkOWaANm5o0tXxPA2E+D
	Ebxe/Qeg7Jq925itpp1b4adpwXuw3Oyey7pjs9h7Vu+3JErLSW/+hZb0HWNFo+dan2Oz02r+yE+Ly
	+V1nKc2Tr/Xkh7DWjr8hepw5crceReHIPOl4hkWxum/3IWWNeqNLy04IYroJgQDS2i20gtol8IIwL
	+zr+Gl6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5TZf-000000048L5-1lL9;
	Wed, 25 Mar 2026 19:07:27 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5TZc-000000048KZ-0KMy
	for linux-nvme@lists.infradead.org;
	Wed, 25 Mar 2026 19:07:25 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-1271257ae53so216341c88.1
        for <linux-nvme@lists.infradead.org>; Wed, 25 Mar 2026 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774465643; x=1775070443; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CFNV3fXhTyYK2FfmGVgZlda+hYMW+xdTutgAp9N5H0=;
        b=Nr8udniXzPPw+b1XqobuoAJ1TkXfvoyeuWN6Kpwr8gqRmtzoXmdd+j/smiTdp1bOEr
         ND/xdu9NeYA/46CK8BYio71yUxKrxAiPFeuGuYzrAWEbBK/P3szLYOgEBka/x1ZpOExD
         6JSO71j6okczrhBiVnYv2TlkguddLrg1OTrrSWdOpp4UdJZ4LmlY++ClMIxxxFqw9TnU
         JQ1Y8xAArYMwxnJ44LwizLyn3q1HFZ5RY/JKwp5CmdZM1bTMQ54Vje/+66vbzXcH0qml
         X9vov3e4PqcLjwYhqmNppDTV3BoOb0V5wf4IBs4E6eVcTdIvKSoqkzTG03pLu+hUgz+l
         iY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774465643; x=1775070443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CFNV3fXhTyYK2FfmGVgZlda+hYMW+xdTutgAp9N5H0=;
        b=LSYhXTr8/SGIZVEtE2qUmuhPt8osL0a5ADo02nRp4y4raOIaELbEUEukHtpQ0ZPObF
         n5qygbrYhbw/+L369Sg2n2JMBWB1IRbTlCXeV1oInfd/5gCKL9jjm7fBPWdgc396qMIx
         xpAK2gVodXsouM/9PufW5nsBpXZpYcQKow52Z11Ru90IJJ2vkbB/PWMfOaJM7XgsdIyD
         wi7vOTiVvJES+LIjLiFl09KOXx6dTfErFybajKlKcOBeJsO993Kbnqyka+G+bxfhVWM8
         TToUhL1/P9X9Z2gkBHN48uifLAWvunKwi9jGoXnncK8JzqxunjZvrAxHY6/wMHhNC3AO
         cTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUf8Bs9riLX66jdWw81XbC4QXtVj9k0o26Tn5DL364A2SCN+gYf+i3wmNjTAPwPCPbDB18uJ1zZMb5@lists.infradead.org
X-Gm-Message-State: AOJu0YzfnH0/kvf47dBE/wFMx8H4oKnKiiqbFa+e6GitDnDQjwST10jf
	Gn7TTGQt2p8LQg/6ErBCReXXDUHGm6ux8xcR8oGWR64sDP64zn7rtXbrSa61PJVhYyw=
X-Gm-Gg: ATEYQzzvbWGzVFtP1N2vo2r6Gslb/dilYh63fWi+zBDRSVAUowJz6dqyjFuE83Kdgba
	Ug5GQSCnwoI9Yyo2MLN52l4ouGepB38GNFYmluU8HW7oZz/mUHZavTGqBEoG4uZP13r0S7LeS1c
	v3ZbDJ2B1lJCmBqS7KFYLYw3DXLb7KtjGDGKGVOlDfJhp/XBOrNovuxfsvTwJQl0y870n4fHnYS
	yGRQbve+ABHvJI7+cq5Z1hi8rzp23Yo0GGU2vE6CbglXQWPzfV3n4r0R3E3xMtZRMWU0rDTVoOX
	LGVwn4FkTB8jsG5Gxtz9kIsC0iF02MZRtRRFvaTNYWo51vx1iRUk9QujoqgK6WMbBws6MlvCLny
	js4AcJH22RA4ccouhasC4qbUzuu/QEAvrlV9j3/VwWrLvO34713ErRcQvJ/riG9JkjePuqJ0jrh
	VAXDKnpnU1znaowg6oe7k/eANQyVwP
X-Received: by 2002:a05:7022:4a7:b0:11a:23fb:16e2 with SMTP id a92af1059eb24-12a96e4901bmr2240147c88.9.1774465642819;
        Wed, 25 Mar 2026 12:07:22 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12aa6e5b38csm873408c88.2.2026.03.25.12.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:07:22 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:07:21 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <jsmart833426@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 21/21] nvme-fc: Extend FENCING state per TP4129 on CCR
 failure
Message-ID: <20260325190721.GD145093-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-22-mkhalfella@purestorage.com>
 <74b4496a-5ce9-496f-8032-a220c2f69cfd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74b4496a-5ce9-496f-8032-a220c2f69cfd@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_120724_121986_8ECDDCF0 
X-CRM114-Status: GOOD (  23.12  )
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

On Fri 2026-02-27 17:20:45 -0800, James Smart wrote:
> On 2/13/2026 8:25 PM, Mohamed Khalfella wrote:
> > If CCR operations fail and CQT is supported, we must defer the retry of
> > inflight requests per TP4129. Update ctrl->fencing_work to schedule
> > ctrl->fenced_work, effectively extending the FENCING state. This delay
> > ensures that inflight requests are held until it is safe for them to be
> > retired.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/fc.c | 39 +++++++++++++++++++++++++++++++++++----
> >   1 file changed, 35 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index eac3a7ccaa5c..81088a4ce298 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -167,6 +167,7 @@ struct nvme_fc_ctrl {
> >   	struct blk_mq_tag_set	tag_set;
> >   
> >   	struct work_struct	fencing_work;
> > +	struct delayed_work	fenced_work;
> >   	struct work_struct	ioerr_work;
> >   	struct delayed_work	connect_work;
> >   
> > @@ -1878,6 +1879,18 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
> >   	return ret;
> >   }
> >   
> > +static void nvme_fc_fenced_work(struct work_struct *work)
> > +{
> > +	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
> > +					struct nvme_fc_ctrl, fenced_work);
> > +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> > +
> > +	dev_info(ctrl->device, "Time-based recovery finished\n");
> > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> 
> sync with comments on patch 12

I will do that. It has been suggested to move CQT changes into a
separate patchset and focus on CCR changes for now. I will drop
patches [16 - 21] from this patchset to be re-introduced later.

> 
> > +}
> > +
> >   static void nvme_fc_fencing_work(struct work_struct *work)
> >   {
> >   	struct nvme_fc_ctrl *fc_ctrl =
> > @@ -1886,16 +1899,33 @@ static void nvme_fc_fencing_work(struct work_struct *work)
> >   	unsigned long rem;
> >   
> >   	rem = nvme_fence_ctrl(ctrl);
> > -	if (rem) {
> > +	if (!rem)
> > +		goto done;
> > +
> > +	if (!ctrl->cqt) {
> >   		dev_info(ctrl->device,
> > -			 "CCR failed, skipping time-based recovery\n");
> > +			 "CCR failed, CQT not supported, skip time-based recovery\n");
> > +		goto done;
> >   	}
> >   
> > +	dev_info(ctrl->device,
> > +		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
> > +		 jiffies_to_msecs(rem));
> > +	queue_delayed_work(nvme_wq, &fc_ctrl->fenced_work, rem);
> > +	return;
> > +
> > +done:
> >   	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> >   	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> >   		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> >   }
> >   
> > +static void nvme_fc_flush_fencing_works(struct nvme_fc_ctrl *ctrl)
> > +{
> > +	flush_work(&ctrl->fencing_work);
> > +	flush_delayed_work(&ctrl->fenced_work);
> > +}
> > +
> >   static void
> >   nvme_fc_ctrl_ioerr_work(struct work_struct *work)
> >   {
> > @@ -1917,7 +1947,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
> >   		return;
> >   	}
> >   
> > -	flush_work(&ctrl->fencing_work);
> > +	nvme_fc_flush_fencing_works(ctrl);
> >   	nvme_fc_error_recovery(ctrl);
> >   }
> >   
> > @@ -3396,7 +3426,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
> >   	struct nvme_fc_ctrl *ctrl =
> >   		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
> >   
> > -	flush_work(&ctrl->fencing_work);
> > +	nvme_fc_flush_fencing_works(ctrl);
> >   	nvme_stop_ctrl(&ctrl->ctrl);
> >   
> >   	/* will block will waiting for io to terminate */
> > @@ -3573,6 +3603,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
> >   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
> >   	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
> >   	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
> > +	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_fc_fenced_work);
> >   	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
> >   	spin_lock_init(&ctrl->lock);
> >   
> 
> looks ok.
> 
> Signed-off-by: James Smart <jsmart833426@gmail.com>
> 
> -- james
> 

