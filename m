Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EB5E7AD67
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xyZ6hMkW3DX+5TPW1p+QwoHRS86qiGeWn6NDq2N5Ct0=; b=Jee0W2vdv3hTiWmFOAMgbcyvbK
	JU140jyXgbsl0nKmDIs1saIF7Msiadmj2aTo/9xmP8HLfyK0/sy8uwMrgHIIfRIuOymZva5hCnpf/
	qtkNt0/GgrwnHrTaKMqmBLdJ0CVXqKVk7NOpeWbtlTpoXmUMUOp3ayp0rXy5mKAVRbolEgYc7k6Sw
	TAWrqaMnbFe52Yy1kI0WdG0H87rUIntLcO1ggpAbf406pFlq3coLXHORvlzutc1CNcw36OdvWoDZR
	hEVPDExFSS6XI9udXbhxYRLD5PZJjXlAXIpMV8fP+n1wBbYsXd+jWLxNEMyJYPYsrvWKy5aJs9mjB
	CZr/T6eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYoxf-00000000Z20-2ree;
	Thu, 25 Dec 2025 17:17:15 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYoxd-00000000Z1b-1CGD
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 17:17:14 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c2af7d09533so1363599a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 09:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766683032; x=1767287832; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyZ6hMkW3DX+5TPW1p+QwoHRS86qiGeWn6NDq2N5Ct0=;
        b=cp9+9WEQsb/j846e+oveGMAmsAuxsZxswQ74EAGJu4/RaITrLgK71PyB3K4yzITnQn
         ZXoI9mmX6z+gvch7i9OaTdTwZe2GAYMj0T0lE0sDTvDe3Iw9iYKJZijp4nGzVBubfAnG
         jr7OhFyli9DEHjR/c4GmtWzzCoQw8aCrlGErAvP3Ndr8pc/R83F2hjw7uOaUIod3wGv5
         jcNVb5NE1nLHn23W4fUyokxZBB+Lj2P4apsonJuTr2y+3tADnSpiVHenr9LN1t3DC+Wu
         yZ1VZBM5h2iiqWbvUteGQ9rWsiRjbUOKB3GEusurGd6kfbC9GqXLXWfNUgmEk1nCTGMH
         Yl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766683032; x=1767287832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyZ6hMkW3DX+5TPW1p+QwoHRS86qiGeWn6NDq2N5Ct0=;
        b=lmSQutYu+ypWrXCjInj0lFz0vvq7k5KLyWe6EtynlleHdh82t5eQG5nn0lxFX/JEUx
         gmyAcnCQW2hDQbT7NAYAVE6cud+Gtoj7hlx9Qr4w8zCJ7oM8xGR506hu0YUdyT+IOYqo
         CV/bYVguOP3Ou3oR8/weoIyIqa32pQh9nvH7iDXAJ6U0IDWEf57Y1yVy892xIbpv2Ai0
         U2qyHEwdGTsGJyg0kgi3FRtST2HCQF7YHhaVSsDT1DakYSdVCZsUdSL+HL6adUfYWmb3
         UIyRbqXp3g7a7/i8iFi8G5xZ/Rag/uSq02lDLbvBkLM//zDRxh6MVH/uKG6ofn5g39sK
         Z/+w==
X-Forwarded-Encrypted: i=1; AJvYcCWFhtfuvUlt+4fKl9M8V0iUVSt3AZ7K78PYp5QJ6CfOHiuUQNZ/NmMBYUeEQGg67/WGS4Tmbn3Gps3e@lists.infradead.org
X-Gm-Message-State: AOJu0YzfJLi1CYqMREMNA95z6ze5gYrKnfmUK1kpNIoqQr2pytv6/OXb
	m5SjXVg0jHktPMiFVFelXBW7cP6yvVGo1yQQjC/hNIm3zKYxKWybRG273asE5vbvgrc=
X-Gm-Gg: AY/fxX6K4oASkzofpG9IE/pXUi1/FKsCo1jh/N8YY6cxZZcts5DNYiHxhZRfi0sbNvY
	+1VTUdf9sM0614ShFwyP3D56xScRY4bTxlDRaN5VOp/MqDOwJAl+Y1SOlYumjT/JzLTol4F+qf8
	1pkfmjBvbE2VlMGR+sDqnN7d2LDSJnQZbxTj45hxkCR/z0BcY7ahCwiGH/SojCn8Iy929k8Oi6T
	sFF8d+vmapXBV7IAEC+wWhF6k6uaaoZljwmHMaOW7EhTa5iV0bKtqUB1OXUrUyGZLEey/PxqxFY
	ZERbch6nm0XJpy4eeRKGnybbL95DyGjveuFdP97aypNFsFffFiCzn4asvMYIDnSAvTectDq+e9O
	3l1ceLmdX+QyXBaJnpheeY52TwO5X4w830ANVZyR3Q1exlkzkC9LZ3CvRRo1ZbGTeMgNTwryRMt
	b9ZWajZewgsVqDR7I=
X-Google-Smtp-Source: AGHT+IEujUxnJ3Yf56OShfmRl6zR4FEe2J4/AA7VRwnwhDo1gdETfH6iNO+yk0TJK0yI38t5mq8J9g==
X-Received: by 2002:a05:7022:7e84:b0:119:e56c:189c with SMTP id a92af1059eb24-121722aa627mr22924662c88.4.1766683031606;
        Thu, 25 Dec 2025 09:17:11 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::1305])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-1217253c23csm75969311c88.9.2025.12.25.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:17:11 -0800 (PST)
Date: Thu, 25 Dec 2025 09:17:09 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
Message-ID: <20251225171709.GA8129-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-8-mkhalfella@purestorage.com>
 <e9bb2664-9d96-45f0-a39d-6deaad0829e9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9bb2664-9d96-45f0-a39d-6deaad0829e9@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_091713_417515_34BF241B 
X-CRM114-Status: GOOD (  28.82  )
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

On Thu 2025-12-25 15:29:52 +0200, Sagi Grimberg wrote:
> 
> 
> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> > Add NVME_CTRL_RECOVERING as a new controller state to be used when
> > impacted controller is being recovered. A LIVE controller enters
> > RECOVERING state when an IO error is encountered. While recovering
> > inflight IOs will not be canceled if they timeout. These IOs will be
> > canceled after recovery finishes. Also, while recovering a controller
> > can not be reset or deleted. This is intentional because reset or delete
> > will result in canceling inflight IOs. When recovery finishes, the
> > impacted controller transitions from RECOVERING state to RESETTING state.
> > Reset codepath takes care of queues teardown and inflight requests
> > cancellation.
> 
> Is RECOVERING really capturing the nature of this state? Maybe RESETTLING?
> or QUIESCING?

Naming is hard. QUIESCING sounds better, I will renaming it to
QUIESCING.

> 
> >
> > Note, there is no transition from RECOVERING to RESETTING added to
> > nvme_change_ctrl_state(). The reason is that user should not be allowed
> > to reset or delete a controller that is being recovered.
> >
> > Add NVME_CTRL_RECOVERED controller flag. This flag is set on a controller
> > about to schedule delayed work for time based recovery.
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/core.c  | 10 ++++++++++
> >   drivers/nvme/host/nvme.h  |  2 ++
> >   drivers/nvme/host/sysfs.c |  1 +
> >   3 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index aa007a7b9606..f5b84bc327d3 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -574,6 +574,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >   			break;
> >   		}
> >   		break;
> > +	case NVME_CTRL_RECOVERING:
> > +		switch (old_state) {
> > +		case NVME_CTRL_LIVE:
> > +			changed = true;
> > +			fallthrough;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> 
> That is a strange transition...

Why is it strange?

We transition to RECOVERING state only if controller is LIVE. This is
when we expect to have inflight user IOs to be quiesced by CCR. We do
not care about inflight requests in other states.

