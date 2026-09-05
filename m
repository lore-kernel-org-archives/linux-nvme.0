Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A744C624D3
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2026 02:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zfGbJGceSpzokCooR7HP1FJE6PB+5/BbBJX/nX2Rzu4=; b=SOO/z6rJs8UyhJNKx7Xc/ojRof
	sdfpAkJJq5Z8lRN1cv1LsTr1ez+gCzkI+6VVRzsyhmRPsT8hLkK1u+HI2ZyiZ/kTlkZLG58oxwBpR
	tqqlSC68zOmMJvXRnMWhGV7bQZwLBZ8/V/iQoUZwyRQ0ppGQ+Lx0I8t36Ju3La5LZRUyYVGF+L30W
	Kck2RGN+QS0us+NJKLWBt28Qgelnxo4N1Hm8aKZCEY6CxgRNKhSKD8DfGHuhCZM94Lz9EJ54dE5+i
	WEYJzvMuuMnxcCjsjaHR5iV3wsTD+039jkmd1VbuZ4NC16smeX6qUP0pI42t1v0SGvzBjTK/JpCDc
	vW1B/Seg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2fqs-00000003b5t-1mFD;
	Sat, 05 Sep 2026 02:09:54 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2fqp-00000003b5X-2528
	for linux-nvme@lists.infradead.org;
	Sat, 05 Sep 2026 02:09:53 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2d5cad1a6baso15655845ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 19:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788574190; x=1789178990; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zfGbJGceSpzokCooR7HP1FJE6PB+5/BbBJX/nX2Rzu4=;
        b=NfJ5cA99whk5Hemgc3lLiWS0P7rRnssEBJVC1XldgB2/5WM24PKE02v6T+hvTaHZXm
         Xk96rC7zbyuGH/mmLUvCitNSlW8Lb/QbQGtsCRLkbLB9fZa8pp1aOr+8eZvWiv7mdrzB
         3Jex6QiByxf/HMsELe4/EqMdB+i9WofrWcnal0dSJ9Ab0E6i5U4SzSN060fJfsHIRe9s
         LSwrlUwMzQEYjNJME984M+q8Mo/3Oi70EKxObcuKOgC6laLqvX2ir6LD+6Lb2Xsufkza
         wZhGt20usikxA5CV4WwRLIHPKCW1/k1sp0utitmr8zM6fj69Ml3MPfUJRF3FRNn02YFc
         5GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788574190; x=1789178990;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfGbJGceSpzokCooR7HP1FJE6PB+5/BbBJX/nX2Rzu4=;
        b=fZ9wepEO2eC39DYkfdOQOF6bu18ZOUaMHLXNDSud3X5LG438XzpxNgzodIIFSpe6FX
         UcUsoTEfkobV2/0taqJ2StAFh1+XPWQneeyM8TpehfKIcLBkxLYdVVaKuM4nM11Hkui+
         V0vDh2DgkxHXl4cG515qmiU9RqmqCihSUDGiHGd2Ojx2QVwzKZQkxSpCbUNCjNolFYB7
         12/xSY2FlTxb8W+rP0Yraqbu/Ts3QRKsERNCizOa1SpBFNugSqDaE7+bQHPOaEeM3kXN
         qYmBXWS55ew42NI/IRtaGOdfyS8BidQaCbTTeuVTURX8Sse1kPzyjZBcMMkw59ksfoEi
         M3nQ==
X-Forwarded-Encrypted: i=1; AKwUvBypXft/90FhaOf1DXIym6cNjydTH56tFMtrgsDNhX4CiP4q6gl7WaBAGfzG1/fByQgzfLjR75/20NyC@lists.infradead.org
X-Gm-Message-State: AFuF++m7IPmt/F78f4LDqBHXuxzHz4r/TBQHbyoWu3/j3UAByCY2BnaT
	LxAOsqy1gSb0EnW0rK8PmfmSQogbTkzauWxwFT+DXHEQW5oXU25YfAQse//wjgWFylg=
X-Gm-Gg: AYBFou2xprJ3A5ceF6qmjMap0hrAwJGBXb6GCBwxumLCGEOS+4wZZ3vkqaOQ1q3qaX1
	sjQ4IO4RFfwTIpyx63np/AujTfjvkcT8fcsQ8NZ9tnpG/6yI1Fx+atYxSYYJzgSukZ/Me6nKEcK
	4V61/Qi+vJJ77YFynrtpJ7xCWBjSX2nIFjTh8FC/z7zZYJcoXwPl9TNvcuJmUsWLnRVEM9eP2su
	gCo2zGoY1HYFD4SVftO+EYXT4D1Qpt/CJFlnH9JRFjGcNJHP8D7AiDa/oW3D/xG3ZNtg26zxJwv
	PR2WPc7vt/ZwgGFuTiib+U+OMxKg26wUpBjKRGSGdXmo0Qpvlly0rMdiZIjS8yG0nltmXzHJYmr
	hXGtNuRYUE/SY9E3TbyMrfSRcPzelgDIgm/rEuoM99RX3vR04EjDYqOZMhJeIIbK/6EfWfrlOvq
	rEO/iPZjWc8BGcL09Vvk8LHeHmCWkxLZC9e/DzlrYpYDdyBwbpxulaApdljSBl0LeDTFY=
X-Received: by 2002:a17:903:903:b0:2da:e967:794e with SMTP id d9443c01a7336-2db12657cacmr167916525ad.19.1788574190310;
        Fri, 04 Sep 2026 19:09:50 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm6351100eec.4.2026.09.04.19.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 19:09:49 -0700 (PDT)
Date: Fri, 4 Sep 2026 19:09:47 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/16] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <20260905020947.GG5552-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-11-mkhalfella@purestorage.com>
 <3bc07e43-750d-4e8d-a209-e1d45acbb230@grimberg.me>
 <20260904225236.GB5552-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904225236.GB5552-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_190951_720689_C451B6B2 
X-CRM114-Status: GOOD (  27.96  )
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

On Fri 2026-09-04 15:52:39 -0700, Mohamed Khalfella wrote:
> On Sun 2026-08-23 04:03:18 +0300, Sagi Grimberg wrote:
> > 
> > 
> > On 12/07/2026 5:23, Mohamed Khalfella wrote:
> > > An alive nvme controller that hits an error now will move to FENCING
> > > state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> > > terminate inflight IOs. Regardless of the success or failure of CCR
> > > operation the controller is transitioned to RESETTING state to continue
> > > error recovery process.
> > >
> > > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > > ---
> > >   drivers/nvme/host/tcp.c | 30 +++++++++++++++++++++++++++++-
> > >   1 file changed, 29 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > index ba5c7b3e2a7c..a1711dd1d3c2 100644
> > > --- a/drivers/nvme/host/tcp.c
> > > +++ b/drivers/nvme/host/tcp.c
> > > @@ -161,6 +161,7 @@ struct nvme_tcp_ctrl {
> > >   	struct sockaddr_storage src_addr;
> > >   	struct nvme_ctrl	ctrl;
> > >   
> > > +	struct work_struct	fencing_work;
> > >   	struct work_struct	err_work;
> > >   	struct delayed_work	connect_work;
> > >   	struct nvme_tcp_request async_req;
> > > @@ -605,6 +606,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
> > >   
> > >   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> > >   {
> > > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> > > +		dev_warn(ctrl->device, "starting controller fencing\n");
> > > +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> > > +		return;
> > > +	}
> > > +
> > >   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > >   		return;
> > >   
> > > @@ -2494,12 +2501,29 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> > >   	nvme_tcp_reconnect_or_remove(ctrl, ret);
> > >   }
> > >   
> > > +static void nvme_tcp_fencing_work(struct work_struct *work)
> > > +{
> > > +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> > > +			struct nvme_tcp_ctrl, fencing_work);
> > > +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> > > +	unsigned long rem;
> > > +
> > > +	rem = nvme_fence_ctrl(ctrl);
> > > +	if (rem)
> > > +		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
> > > +
> > > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> > > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > > +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> > > +}
> > > +
> > >   static void nvme_tcp_error_recovery_work(struct work_struct *work)
> > >   {
> > >   	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> > >   				struct nvme_tcp_ctrl, err_work);
> > >   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> > >   
> > > +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
> > 
> > Agree we shouldn't be here with fencing work running.
> 
> Right, nvme_tcp_fencing_work() above queus tcp_ctrl->err_work. This
> flush makes aure that fencing is 100% done before we proceed with
> resetting.
> 
> > 
> > >   	if (nvme_tcp_key_revoke_needed(ctrl))
> > >   		nvme_auth_revoke_tls_key(ctrl);
> > >   	nvme_stop_keep_alive(ctrl);
> > > @@ -2542,6 +2566,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
> > >   		container_of(work, struct nvme_ctrl, reset_work);
> > >   	int ret;
> > >   
> > > +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
> > 
> > Isn't it being called in nvme_stop_ctrl? - perhaps it should be called 
> > in ->stop_ctrl() callback.
> > 
> > Other than that, this looks reasonable to me.
> 
> This flush_work() is needed in case nvme_tcp_fencing_work() loses the
> race of transitioning the controller from FENCED to RESETTING. The
> moment we move to FENCED anything can reset the controller. For example,
> userspace can do that. If we lose the race then tcp_ctrl->err_work will
> not be queued. That means reset work needs to flush fencing_work.

Now I am thinking about it again, what you suggested makes more sense
for both fencing and fenced work. Both should be flushed ->stop_ctrl().
I will do that.

