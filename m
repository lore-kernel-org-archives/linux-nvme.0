Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C04C369C2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9gcrtZdemerL6aQk6jw2p5xNDI9nJ1A11Kxs8TNl/+g=; b=SFS5RMX9Ufo49UttapUg6wA6qc
	L0Z3TYUh0I1BYJ31oGtCJl2tjDkV56Gj4pWcZ/jAMRa7p0sw0zikY/9ZzqKhGLc01iDIR+H2tuMaG
	hM+SJRXRvripcisr3BaW9jbWchguxV11Eq+NIGtDsfhLr5nx/b6Qm9mIA2YysvAlLx25IFKqUkxkd
	l23t5vps+xz3f3J3aZFMgJlng5M18l1GLILREg8BZyd1g3c6Eo0wuGuQ6mzAJ60xZoxHWxcJos5XW
	gtkr/oml7M8fGNWIPM2OVdqXz4nJhFlx2dDAWkH6SFLKkK03S7DwwRrkck7deq/iDF8senCp+yuxr
	5m94E6yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u54On-0000000A0sM-3BVP;
	Wed, 16 Apr 2025 15:10:01 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u53Cb-00000009jy3-2NAX
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 13:53:22 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso7551806a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744811600; x=1745416400; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9gcrtZdemerL6aQk6jw2p5xNDI9nJ1A11Kxs8TNl/+g=;
        b=J6IkLBZo4ZXodNQqZSyPqEKsTYFL7zIj/xX9Zv1ojMsk+XfpcsmIPu6tJR/I4bTJTK
         6u1JbUuXaI4N1tWBW/mvjiy8hwH8wipCIQipGXlxKFZpL+hgkMwy78035j9Qhsq/WH3L
         C28UoyE/Tkf4apGNCiph+GX71fm6OUjL7RPGBZrcwuMKb1L2So9NeFDYjrReMhMED77d
         hdBgJi1NKs6jkeGv8dxDbJrvJjqMLk6rLf2/rVC+HglUkU1k9w+O3KZuRAKft2edrVRb
         4HoHXsjSkAHBUv7mhFobOPBmLwag2HTgJLj/frvE4/URdPh8Et20rEt1FuEalLNd4kKY
         3EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811600; x=1745416400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gcrtZdemerL6aQk6jw2p5xNDI9nJ1A11Kxs8TNl/+g=;
        b=ZcqbPkhS2In+ZsRBqDjSDtT49/bvnJVzu4yc8aHkfxuYmP13gpSSL2upaS4S14kpYV
         ZWMnid0NMNBQM4SPMUkS6v48FNh4CteSWFnrkuGDTrlgkF/QnGliBppIiuwCtZofNEiC
         4ifj4nVQIsWyY6ztlrNLWOmg5edfQryidTiX0AkrUOAvs6yC75LeShNpy+ctBt9anizz
         mvbN6es4Pq0MAo7NmJS5bFfOWWtd0J97xP0dYMUOiWs/m66QFtrWzIKMFSbjoSVXWlCh
         eO8c3Iywk4jCgNMwNgo3n+BTRc2Ol/uJsLmkB/PYSKYRSMJlqMfLVkxXtTkLOs2ooToO
         Erjg==
X-Forwarded-Encrypted: i=1; AJvYcCWLZrNlrneB/tl/aPFuklSpwult62Cv8sARmN/92/OStGcpJv+u4BKpIEuv8IynlklNA2kXVFjFLzR8@lists.infradead.org
X-Gm-Message-State: AOJu0YzNv1mrqPpoh0DL6IXoBWAmBJfhwHFJNREXd76F1kiWjJ078Ijc
	Wa7y42//EkyiBVe6HvjJXFkwg17XCdTb548kiYggFv9rDQrHyhMYLr5viFB/nyo=
X-Gm-Gg: ASbGncsEoUWZm0aDCQA/hi6p9Yr+oA62xobSI9/IuoPPfEsRAbnNoPezFqIF0wjb7qZ
	3QG1VcJfTcv8Br/qh4Ylwzglt1AQpMfXT91axnOzhz82DisIaThDmho6d465nfxsf1Sg3TfY9XV
	/Xisb42Miox47+633unensrOhN/obX9Mhu56XjpbBZxWe7IWynUgeOW/i0BrwB0bSMsv+Cn8uXY
	OrO/CGfJVLkcoN4XYO4FKt4Tb+5Y6kITUoVl7ZiORncAftWwKmyP0YGCzCcGaHiopGkWt+5s5oi
	TwfYPYHcwA96UAPz4HVQuIcMvMLVXa6sNXT2l0eg4drK9Kk=
X-Google-Smtp-Source: AGHT+IH2odz4MFUc8fi8peGC8XeupX73csOpmsRiYA+TNcVlda9dlCfptbzJAjHUUoSNYQRcyiH6+w==
X-Received: by 2002:a17:90b:17c2:b0:2ff:6af3:b5fa with SMTP id 98e67ed59e1d1-3086415dde8mr2433910a91.22.1744811600569;
        Wed, 16 Apr 2025 06:53:20 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8900:32c0::c137])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-30861212fffsm1568898a91.25.2025.04.16.06.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:53:19 -0700 (PDT)
Date: Wed, 16 Apr 2025 06:53:18 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <20250416135318.GI1868505-mkhalfella@purestorage.com>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
 <20250416004016.GC78596-mkhalfella@purestorage.com>
 <3dad09ce-151d-41fc-8137-56a931c4c224@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dad09ce-151d-41fc-8137-56a931c4c224@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_065321_602175_58CE0299 
X-CRM114-Status: GOOD (  26.22  )
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

On 2025-04-16 10:30:11 +0200, Daniel Wagner wrote:
> On Tue, Apr 15, 2025 at 05:40:16PM -0700, Mohamed Khalfella wrote:
> > On 2025-04-15 14:17:48 +0200, Daniel Wagner wrote:
> > > Pasthrough commands should fail immediately. Userland is in charge here,
> > > not the kernel. At least this what should happen here.
> > 
> > I see your point. Unless I am missing something these requests should be
> > held equally to bio requests from multipath layer. Let us say app
> > submitted write a request that got canceled immediately, how does the app
> > know when it is safe to retry the write request?
> 
> Good question, but nothing new as far I can tell. If the kernel doesn't
> start to retry passthru IO commands, we have to figure out how to pass
> additional information to the userland.
> 

nvme multipath does not retry passthru commands. That is said, there is
nothing prevents userspace from retrying canceled command immediately
resulting in the unwanted behavior these very patches try to address.

> > Holding requests like write until it is safe to be retried is the whole
> > point of this work, right?
> 
> My first goal was to address the IO commands submitted via the block
> layer. I didn't had the IO passthru interface on my radar. I agree,
> getting the IO passthru path correct is also good idea.

Okay. This will be addressed in the next revision, right?

> 
> Anyway, I don't have a lot of experience with the IO passthru interface.
> A quick test to fitgure out what the status quo is: 'nvme read'
> results in an EINTR or 'Resource temporarily unavailable' (EAGAIN or
> EWOULDBLOCK) when a tcp connection between host and target is blocked
> (*), though it comes from an admin command. It looks like I have to dive
> into this a bit more.
> 
> (*) I think this might be the same problem as the systemd folks have
> reported.

