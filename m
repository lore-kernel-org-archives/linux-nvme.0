Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C2FC369BD
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HQPjVTwAlpJP7gDyjMdFPiWvjeOPxcDyZfzJMUg3hr8=; b=Brgo5d5rp4UX0gaUFlHu/eWSOU
	BD5OP+IvUObnEScXLtoWPRZkhfdc0KYDRrH2aAPtbFspJMFSW9i2SfUkGV9eEzthmgWemPb90xpLj
	VeQn5Db1AxeaWnCSOkyLj8UNcfUYXBpChtKbRiGLExLNgr9eYhbQ2nkdedFRypRqmp3DUB44drJIm
	0PEa8cXnKwYLgxUcTyw+ln9G6UHPhxFAg1kdRI8PZs6AoJlSFigrx8Lgg3Kz8g5U+z2fSktZ9jsD0
	qAKZeZ7CM4IOTN2hGKayrv+ZvsqrAa/tHdo+6v2sxXSvFshIZGtv3ZU6ssDEBJq6G/usqXDsrLWcM
	hcWJt3YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u52yw-00000009gfw-46fX;
	Wed, 16 Apr 2025 13:39:14 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u52yu-00000009gep-1lH3
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 13:39:13 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-22423adf751so62895955ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744810751; x=1745415551; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQPjVTwAlpJP7gDyjMdFPiWvjeOPxcDyZfzJMUg3hr8=;
        b=DlAFZ5jKzjBkgt2isVzpd5AICi5eo0GATvQzV0ygfWd1EP1YWe7j2dHK9uOZkTrspj
         Q2Qf6rE4rafmQGeKKP8kEfTVf+BXrMljcf6eBs19DRrduyJ+Y3MckuJO6ErgZH8YmsVI
         sOW78jJkj5E78ZqbIwi6a+m16VpB1IBR/HipnT3silQiuaGyRBVTYm0An0YAdUFluSTz
         Ys24Sv7vT3fl5KuLHAwDYi8xmCBB6JLdmy1m+uy9Vn1H4mJGz93QhnG9gg8rBBI+24uY
         TcM56tTOHE/HfIS0DLjKoVsmIyV+KA00CzZjPUuo/IMH96lRVtthyR6TcCNxtAy+nEPy
         1suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744810751; x=1745415551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQPjVTwAlpJP7gDyjMdFPiWvjeOPxcDyZfzJMUg3hr8=;
        b=gVhJ38mEcraeMca4CZ0GAeA7xEw+tKPDhqMcfoUcI5MrGKTEPO0oaMGQgFuHXVWSkN
         ObOofk5Q4aqL4cOuxUpNCQQk4nWeBfm20hgIxM7idjXhC4HtZExjTZtXTrYREuVfp1q6
         j2xc7eQxe5I/fxNLD13cC7yO4VMbeFZAWIeokRFaQdm1mZnz/TQuBtwRjzJWMPzC5aWl
         jSA+94JDANEZcquTXU8crDYOcxYPopAYZKeYgLbiI60zNb2uWWMxC0Sscw1OvMGG/0il
         P5p3LFV5yDKjRZcX4IQXBfG//p49yMOoLMpsFPuL+IQZGk/338I4ddqoQZ5O41cFDtlU
         8CyA==
X-Forwarded-Encrypted: i=1; AJvYcCXKFOpr06BkrFWAo6GDmptM7KF5ZW6x7IDQ5TBkagz6JADfZ4NOs2uuj4uKI0ZG+WQ2UcXjgBOZ049x@lists.infradead.org
X-Gm-Message-State: AOJu0YwqoiakQZIsG6NTj/Mk/oCX/Uwi1YZ9nNIBOvXYCRGo5NbSFtDK
	+dtSwjdiL0UpXIdFtK0/Cblx+Qgo+enzs59GdIyyE0E4mQaDTJDj+Lkb6YTEM0I=
X-Gm-Gg: ASbGnctyCkOJATAu8vY7mXjcYyVxONV1qN7SSBIz3RaELYjPbxIEkXV9Coq78gJNPWH
	FLP1waPwSFRTAEPqdNkLjKDkXaomRr1rucMR8YwqpX2dndVw6oGIFCQThC6jb56YKgw8Tjq0S0l
	EJvXz8ZiEegNuw6Vs8qw/gSwnrruPycJJfnfwMytcX3AyLhurgdP8MW1l+g26GWHmasQN71O+4P
	GX2wNdc15pGXy17L3DvOa9g9nb2XKgP2ifNIv1OqTXk4rq211C208oAwYOla/0kNSMZyTFeVbOP
	1guJk2xyVaKM/jpCev+Ef7fbybpAuxYJ8qu0okofMOaywMI=
X-Google-Smtp-Source: AGHT+IFoIPNDkQn7oVxuncqn9fPhp4/UfPtkr5qC8X0Eb/ohId2zdqpFsmOhFASawm3nULqiEQTX4g==
X-Received: by 2002:a17:903:2383:b0:229:1717:8826 with SMTP id d9443c01a7336-22c358fd48bmr33065235ad.28.1744810751270;
        Wed, 16 Apr 2025 06:39:11 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8900:32c0::c137])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22c33fcbf61sm13589115ad.201.2025.04.16.06.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:39:10 -0700 (PDT)
Date: Wed, 16 Apr 2025 06:39:09 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <20250416133909.GH1868505-mkhalfella@purestorage.com>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
 <20250416001738.GA78596-mkhalfella@purestorage.com>
 <22e48664-63f3-4cc0-8b99-f56e98204e5b@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e48664-63f3-4cc0-8b99-f56e98204e5b@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_063912_498793_811758D8 
X-CRM114-Status: GOOD (  28.66  )
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

On 2025-04-16 08:57:19 +0200, Daniel Wagner wrote:
> On Tue, Apr 15, 2025 at 05:17:38PM -0700, Mohamed Khalfella wrote:
> > Help me see this:
> > 
> > - nvme_failover_req() is the only place reqs are added to failover_list.
> > - nvme_decide_disposition() returns FAILOVER only if req has REQ_NVME_MPATH set.
> > 
> > How/where do admin requests get REQ_NVME_MPATH set?
> 
> Admin commands don't set REQ_NVME_MPATH. This is what the current code
> does and I have deliberately decided not to touch this with this RFC.
> 
> Given how much discussion the CQT/CCR feature triggers, I don't think
> it's a good idea to add this topic to this discussion.
> 

The point is that holding requests at nvme_failover_req() does not cover
admin requests. Do you plan to add support for holding admin requests in
the next revision of these patches?

> > > > - What about requests that do not go through nvme_failover_req(), like
> > > >   passthrough requests, do we not want to hold these requests until it
> > > >   is safe for them to be retried?
> > > 
> > > Pasthrough commands should fail immediately. Userland is in charge here,
> > > not the kernel. At least this what should happen here.
> > > 
> > > > - In case of controller reset or delete if nvme_disable_ctrl()
> > > >   successfully disables the controller, then we do not want to add
> > > >   canceled requests to failover_list, right? Does this implementation
> > > >   consider this case?
> > > 
> > > Not sure. I've tested a few things but I am pretty sure this RFC is far
> > > from being complete.
> > 
> > I think it does not, and maybe it should honor this. Otherwise every
> > controller reset/delete will end up holding requests unnecessarily.
> 
> Yes, this is one of the problems with the failover queue. It could be
> solved by really starting to track the delay timeout for each commands.
> But this is a lot of logic code and complexity. Thus during the
> discussion at LSFMM everyone including me, said failover queue idea
> should not be our first choice.

Got it. I assume this will be addressed in the next revision?

