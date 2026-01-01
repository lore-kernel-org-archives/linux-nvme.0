Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364C2EEB573
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jan 2026 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bW+D11PmZg+BW3Ns46JZJEkxh91q6adf7Xop1mv+6C8=; b=lVYULjDFJQP2kgUdz1CX4eg6NI
	IHu3GcmHBmapOGUA3VbLlPw0/jqV2suI6BrdXoABswayRaM6EfWmA4SqMI+4aBQ2AAw8PPfF+vjiH
	j+ZV2WTMSeG1tIawTMaxBkgQyfdSX7TvL0KME3i2/kbousL22+wodn2E1j9BKjtS9SlKC3RHj8baT
	UMORtEyb8N6mf1Z1Fj4PDOwyMcv7WeZ8iU0ghSFw7tBJUqCYDz9LFb5/ztb/6t/sNnf1obJu6wpp0
	d7pVq03XBnPOnSPkRpoUjYD2txm//dUAJYdDT47QdkIl+Bpa1EfSuB3wlTKNLk774Rr+ceak0lj3j
	QmkE5nWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb6Ao-00000006RYz-11af;
	Thu, 01 Jan 2026 00:04:14 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb6Al-00000006RYX-4AYM
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jan 2026 00:04:13 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-34b75fba315so12186992a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 16:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767225851; x=1767830651; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bW+D11PmZg+BW3Ns46JZJEkxh91q6adf7Xop1mv+6C8=;
        b=T7y8UWgSiqLmxU8suJQ583T7k/QNZEAj/AJ9v4r3yPcR3srw1auTZAA1t6ZqGnOnv+
         HdRD384EcUX6qyc1GMPHYP82U2PUd35qrE9Ii82J2F9PbeHGgQB3ZiEa+I42IYW21TV6
         DW1qVErCZ+8wnoiTPzuHFW/oyTzWG22ligyPBcvz60IEDqwQ0mZtf00AF18GPl4b0cI1
         kn+CIU3Q3GWk3ouL7fCAveZJhLZ9U1+wv5uLg+EfFtwCOTuLBUejplykA3me7t7lJzaU
         eLxsMs4PxWnCmzUGKFP8+l/0rshiAPYSlHi+oGwB+CyIiw/wqSfAKuuKAzGH2y6EDs61
         Zxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767225851; x=1767830651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bW+D11PmZg+BW3Ns46JZJEkxh91q6adf7Xop1mv+6C8=;
        b=tb1T0wI2HAl37WOXCe3hte2GSWssz+s0SpbBhc8EUZYMckepewiszGsgIUuu8gXP3l
         7hcTav++HkOldhjlj8oXfDo4/HLFXnKy35yLkxqrEByeF+iOLSL20TorlNwM08gNyBkI
         vE/xOTkNq4ZEwFXa7So5xShxT1DVo8iYzk+MSnGiIDUH8+56uJ9/OLu8Mp62l05dBmIc
         UJZPUv/soUv4zRCvugKJxoB5RrllWfig4OTd+/3pZKvWoqzWWUYIbCTdxp8oJZQZ75GH
         uEKp+WZI/l4RbSPoZrb3Fni+Ileyx7sqYA4InoBacVH23tq+D9cVoC0K9mUuhUeaGAgs
         exPw==
X-Forwarded-Encrypted: i=1; AJvYcCVJZ8wao24zv0lmJiyuxI7VAA3GY4tyYND1oDUfjvrgTIY9tfsq4S7pcojRbESfaMXvynJyKcs4RUu/@lists.infradead.org
X-Gm-Message-State: AOJu0YxbWE96K8buFCgJJgbvLgNqiRxOBL1wgExiXwglcgL3KvRDwDhK
	+fHjFas4E+KkxRdMzS+8gaoKPOiBYxZn6XuelhQkottKCksnNju7d4IQyvIjmdeBqHY=
X-Gm-Gg: AY/fxX4L8i/lUlRRY/WQ/n9z2avb48Dmoc5dM2kcAfnsJI7uHmubwbPj3sOQ95q9BeX
	mrTebS+Y5DgdoduGD7DzRr9B8O15IsO4TQ/HUnuLcRaCk3hOiY3QZvftT4V+vcqYJS8WXVUlcv/
	8KRRKVheVRiY+rQUxVupu8e1k/LwPVDZq/d33RFlz3aeMjEqoHu14bvpqzwSW1B9AdCe/fXQiAd
	iI0zAtzx9enzvpL3KtS2gYTDNZQBuVYoArc1AVKxbCVPlQ/iUBBR/hVQuwIa77y0wLfY8XySahu
	lDOgr7MzKJ5eQPMDuMJdivjxCJSgOE7+R1BfAl+TVaHgu9//CzbxlYa/TuvIHJGLTZFsy5uEe9r
	E1IEcJY4VkYnfYq+OwbV37bnAqvi1wU8ENWQ4BDa6ag39/CxA5S/ogfXvlZ6g0vwfwYAaVdqqrc
	ev0tKtBcmhinOh+C4/7pZJF7G8Plp8gUY=
X-Google-Smtp-Source: AGHT+IEuZfbioQuYzhI3YjMZrFOHh5dyQiwCSIzXX9mc086QtZB5nMrGCUFYrTJZvLPrV/MfJAab8Q==
X-Received: by 2002:a05:7023:903:b0:119:e569:fbb2 with SMTP id a92af1059eb24-12172300472mr38435939c88.33.1767225850646;
        Wed, 31 Dec 2025 16:04:10 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-1217253c0c6sm160274051c88.12.2025.12.31.16.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 16:04:10 -0800 (PST)
Date: Wed, 31 Dec 2025 16:04:09 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <20260101000409.GR3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-11-mkhalfella@purestorage.com>
 <CAPpK+O3zU_+UTGx044iCfsUzwD7Dy+X5DC=N6Dr9BNzrrjxqEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpK+O3zU_+UTGx044iCfsUzwD7Dy+X5DC=N6Dr9BNzrrjxqEQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_160412_052022_BCE23FDC 
X-CRM114-Status: GOOD (  27.52  )
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

On Thu 2025-12-18 18:06:02 -0800, Randy Jennings wrote:
> On Tue, Nov 25, 2025 at 6:13 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > An alive nvme controller that hits an error now will move to RECOVERING
> > state instead of RESETTING state. In RECOVERING state ctrl->err_work
> > will attempt to use cross-controller recovery to terminate inflight IOs
> > on the controller. If CCR succeeds, then switch to RESETTING state and
> > continue error recovery as usuall by tearing down controller and attempt
> > reconnecting to target. If CCR fails, then the behavior of recovery
> "usuall" -> "usual"
> "attempt reconnecting" -> "attempting to reconnect"
> 
> it would read better with "the" added:
> "tearing down the controller"
> "reconnect to the target"

Updated as suggested.

> 
> > depends on whether CQT is supported or not. If CQT is supported, switch
> > to time-based recovery by holding inflight IOs until it is safe for them
> > to be retried. If CQT is not supported proceed to retry requests
> > immediately, as the code currently does.
> 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> 
> > +static int nvme_tcp_recover_ctrl(struct nvme_ctrl *ctrl)
> 
> > +       dev_info(ctrl->device,
> > +                "CCR failed, switch to time-based recovery, timeout = %ums\n",
> > +                jiffies_to_msecs(rem));
> > +       set_bit(NVME_CTRL_RECOVERED, &ctrl->flags);
> > +       queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, rem);
> > +       return -EAGAIN;
> I see how setting this bit before the delayed work executes works
> to complete recovery, but it is kindof weird that the bit is called
> RECOVERED.  I do not have a better name.  TIME_BASED_RECOVERY?
> RECOVERY_WAIT?

Agree. It does look weird. If we agree to add two states FENCING and
FENCED then the flag might not be needed.

> 
> >  static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >  {
> > -       struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> > +       struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
> >                                 struct nvme_tcp_ctrl, err_work);
> >         struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> >
> > +       if (nvme_ctrl_state(ctrl) == NVME_CTRL_RECOVERING) {
> > +               if (nvme_tcp_recover_ctrl(ctrl))
> > +                       return;
> > +       }
> > +
> >         if (nvme_tcp_key_revoke_needed(ctrl))
> >                 nvme_auth_revoke_tls_key(ctrl);
> >         nvme_stop_keep_alive(ctrl);
> The state of the controller should not be LIVE while waiting for
> recovery, so I do not think we will succeed in sending keep alives,
> but I think this should move to before (or inside of)
> nvme_tcp_recover_ctrl().

This is correct, no keepalive traffic will be sent in RECOVERING state.
If we split fencing work from existing error recovery work then this
should removed. I think we are going in that direction.

> 
> Sincerely,
> Randy Jennings

