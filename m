Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D94EA3F18
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SqVmBaTO+OddvGKWDZZ/ilUmsb87OdmigQ3H7H/PITY=; b=C3teMDVUIx4mN9QxP7G6DN1Sla
	fOU4DOevgBCkjetN2EpFPxZsqpLWbmA9k45bcjhRQlBn6paerRrE3gwh56zJQsh98TzDM9HdDTk4l
	cj98tJmUVQlqQLCt+3bpVSxNqQ2P5wFKPeb4/d7GZCLzAWPbLnW/H6tRI5ZMQ2rNYPf9kBMi/sqbo
	H7DMdGlAfyvjhUPam2SANqDq3Jx5GW2fY19wA10nhQA8UNRFjaJdcAjCx+iLDo/2uaAsTrLt12LYE
	cmaZMsuP+xJt/1QDp7PnkYZh7amGbubA2fBmBfoGwW614fOSk7hcPnEz9PtqkODiA5r9SESGR1nxS
	ra1fGANg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpw65-0000000HZ22-3Xej;
	Tue, 10 Feb 2026 22:20:41 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpw63-0000000HZ1c-0UrE
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 22:20:40 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-2b8675d4f93so3195964eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770762038; x=1771366838; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqVmBaTO+OddvGKWDZZ/ilUmsb87OdmigQ3H7H/PITY=;
        b=QjyAQxkeSD5/a83jduAP9Jl9fVjfY0CtugaWMcKna3u/p0W/V1yxHs73zv8DPqLCNb
         WXmKD3QiwEh9pkWiU5nSUU7P2bODGf3A+zI+vgwCMJinVRYpncernvE79+4mFARfVrIm
         wkL9qA1K1cOT6blH6eQjjn3QqOHfRTux/9Nn/I91uIYkATEb/I7i1TvQPQoR1NYV0JE9
         dtIlE/gp9semKYDwq0UzLY0EAjQk+PyZIPhh1U+hYYu5kszXBevy6d1FvsIfygkGk0xt
         L4K/71UEOhsUfujkp0B7iK0+/2kFr+pVJnKFrMTdMxul7AxbKv9AG/h6BD3QDSKopm4p
         HGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770762038; x=1771366838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqVmBaTO+OddvGKWDZZ/ilUmsb87OdmigQ3H7H/PITY=;
        b=ZoFlYL3cjFdgpzY9f86DsuLM/YW+25W/BbnPjqza7Z1E8AqoO9a02pqflzBhzakeEE
         LfKiTxkKlWamGtmAFOXgAV7h+XsRc2Yrrgm6YI4MWmBqxcq6/7xzY1CFzwQ+wmwfXun6
         8AUZy622qHQPoTFCP5il0aWsrgw+U5kNpCw3QnGTLRGhtbrUJifl+zI3zWpU8V4op6gi
         gs+m/CoDDv3rvzcl+CJGiPUmt1Iog9NiUVA9Vr69+0UCRNP8dhkNzCOGtkxSfL4T1qxn
         /I7b6ifkpC01qkd5tHizVqFIeD+YHiwG1oCQ+H9cngRaUF20aBit2+I8Qe4WQkBRMZv8
         jLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgiwntW5pYumSlZ2R6YVEDuAxHG/wkD/HDhPjWJc7jdEeE0RbKmOPLfM75w8bBqEuGM+7uO1blq6A8@lists.infradead.org
X-Gm-Message-State: AOJu0YwJdAVtwTXqjfwMAMg9QfPjW5c/tjXyFj+e+lli0AW7tOR5ptCb
	4bVlinAM4lffSPCYmZCQUBZrX1IwgIOAG5n5VXRONWT8DmWZw7IZXBf9uAJwds6X7/c=
X-Gm-Gg: AZuq6aKI+sgwkLOR1vjMe50ADTFb/0Dyw+SojWUrzJpTYu3Ry+gusdI0Kz57jyNSmbm
	Cn+q/ewsIF2z1HwVz3UppSfx36pImJ1JvQLK6lyC9TlBftQmlRo0SYSBZS91zGfegtq2avXD6bW
	qDMYO50+AnN1FmilEHMFWPFg1hcAFwpFW059/kiZ3vSxbVjqi9GscrhMlbI2DKOT2HMBDlEazhX
	hg11p2OPfgoxZyn0FAnByz+rcnXrjE/q4svwCdd/q8yye2HDZvBd6JmfwYmnU250AdYMUH1iJj/
	FEzvT2wi5NGR58nAVxOQ3lWj2FU12vU1MxTZ7TNQ2IJpbk/e9zg64tjb3R4Yg9EmZxz1G98GkBe
	2BV0U8qtsAI3LVdwyauf4lToJvLs6WneajOYGrnxl5oRAn5PIcKs4WB9Iw9DiN3bL4T0QOclZEJ
	NTUCEWR7lqyrLKb0uOpEtIymtY6jGVRTa6z1bzmnTnrD4yETbg8iB6Og==
X-Received: by 2002:a05:7301:408d:b0:2ba:72c3:53c0 with SMTP id 5a478bee46e88-2ba9aa571a1mr204865eec.0.1770762037492;
        Tue, 10 Feb 2026 14:20:37 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b855af7806sm10554646eec.10.2026.02.10.14.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 14:20:37 -0800 (PST)
Date: Tue, 10 Feb 2026 14:20:36 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <jsmart833426@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/14] nvme-fc: Use CCR to recover controller that
 hits an error
Message-ID: <20260210222036.GP3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-14-mkhalfella@purestorage.com>
 <864e0ce2-4fa0-4d89-aaaa-a552977781a3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864e0ce2-4fa0-4d89-aaaa-a552977781a3@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_142039_321695_DACA7105 
X-CRM114-Status: GOOD (  14.19  )
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

On Tue 2026-02-10 14:12:24 -0800, James Smart wrote:
> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> > +static void nvme_fc_fenced_work(struct work_struct *work)
> > +{
> > +	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
> > +			struct nvme_fc_ctrl, fenced_work);
> > +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> > +
> > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> > +}
> 
> I'm not a fan of 1, maybe 2, state changes that may silently fail. Some 
> trace message would be worthwhile to state fencing cancelled/ended.
> 
> -- james
> 

The change to FENCED should never fail. This is the only transition
allowed from FENCING state and this is the only place we do that.
Do you suggest I put WARN_ON() around it?

The second transition from FENCED to RESETTING can fail if someone
resets the controller. It should be fine to do nothing in this case
because they will have queued reset or error work.

