Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3053606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eioVYr3b;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=P1CDsUZ6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQkkAaWtxUgZD6Kqp6WcVP+DNLI/QqlyqnrtoDUgzXQ=; b=eioVYr3bV078qcpArOuJkN1KaK
	lWEQHUp8b1rF8X0GT91OH+yrOwRaNI+zMfuxSM1SGyN2X3OoaiZTbka593XbcDPnywG6wwLUH7I2k
	iELkZY58rXtNT4GOGCFeXTJMr6Mtf6S5JKqERuVO9uFZ+ZWIey5qzc39xlx6ycJMrN1HxGklOHL0/
	A6cnM5MACLKmdziQGHV3knFFTfsonrje/M5znsXbaJMR0jtDrg1T1AOTP2Gb5MXh5+51TkiSLrmGn
	K+zFXYpQh4fH/ZMrJVxvGhZDSBz4DY9SE46fuVc8tA16mEZlaF8nw9r3i8hYQL8+gUuyb0u1ExD6E
	q2Tfollg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIsbk-00000008DOe-1Wxn;
	Mon, 19 Oct 2026 19:01:16 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIsbh-00000008DNx-3k6b
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 19:01:15 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-48df8fe8513so2046406f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792436472; x=1793041272; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AQkkAaWtxUgZD6Kqp6WcVP+DNLI/QqlyqnrtoDUgzXQ=;
        b=P1CDsUZ6eBL/bODjPy+WOH93EYPXoYuyJ/KSHYNxle3ikpf9IBnPIr/TjiPiM9FXdt
         OPxj6+v0kbI4s2T7MDOTEEbS+VuG57uT/syP8aCsIaUev+A7TkFk1X394urHQWasrS4b
         ztT6GK34Gl7hpr3+eTp/WA3ysxDtLXHQqCn8jnISEVo0jui5BxBX8k9NgovmjE2Nokq9
         K0chmi7e54kFGCJkIpFioa4GoAUIA9zuoe8bWuAE4DDnGaHQfS4NF4e7kh0XU64LGJ47
         YGf3ij1f9IUMviDqRC8TG6ovE2NAtzjTmTXmvM02UoPKfa0rBLSZi/Gfatk8Yh/htDid
         /5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436472; x=1793041272;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AQkkAaWtxUgZD6Kqp6WcVP+DNLI/QqlyqnrtoDUgzXQ=;
        b=W6X/qtzYMvZuL/4MXRnTQQ2KkrXBNYm7DcWwUarptDd0V9biw3Ml0Kww+LiAxbhUlH
         rOOWoDq2fzK39avUiSGYuWTuEQaY7xFqV0TNINzBKdnfj9umNsQuKpQ7UzfDr8n1VD+2
         NhHsqRpD3SlV3BwKj9VTwuTKbwMy4z3/HFo+U1N++Md+9rFR4YbamYH6Wazemv+Esyyu
         weEqtGh8nhcZYHbZcec6em6IfLpmnT0CYHRoIoPmTq+lD/lChTaTq1igJTrCq2iFQfUY
         Qvw4ykJXnFQOIUNIZmN8s92eU7B9pHEzfzEnaNai0LV6zBtyuTePc2pd2MfWOuKjXjte
         FWrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGGCEqtCJtmISdv4cFoWol1fD/tmYVWmtzX/vkRtLZhN7ps/G4LLrVsQ/hIdro7r+ljWy50+TvHBXf@lists.infradead.org
X-Gm-Message-State: AFq9FYK6CfFkSOTbryW/3UP826dD3XS3e+bD9adYZpR7x7RMosQ7EaPN
	Wqyh6ATPl1svemcnpYMWpI+KG4F9S88LliR2knEyy4rqIz/UmLVEC/wyyILa43y0GtI=
X-Gm-Gg: AYBFou11F2GLJaP5nCXT7smyQni6bm/gVpqYWSGc9p1MDNRpQ0MB2T0KG76c7Oed/CX
	qq43LIt9BgA6ZgpWV/4S6zijzx+2TGaT5KpdaLy+dCZLpPs9gp5k3Tft8EXifgOLJm6ftYU/ATR
	mTyAcDN8QQQ464k5wM+ZG/gZ+znuCR8YLwU0IwzDkMgmUsytKgFjVZIKbHkemQOPMLpUK3Fxp5Z
	XKv8tRDJgfL+dEbHUk2SJOQkDjrhS97VBpC9SBCvlljiovKqnCEBfzqZJ0LqV3XL7nMLCl/oElN
	GIjhSt02IHSFKxOJ0U5qErcsXg+Zxck+/dq5/h5uFS7CsTTLjTdOPvIb/FuAvI7fnNY8SyySqeZ
	V4w2HOcA0/UKug0ib7LSuS8Lv5ww6B/BZBUtuPRrq8I5N6nPB+ZIq1ffnh8qaOzApy8InERFctV
	4o1x+uYgiOTywI6BHN8xbAxlf5wR9ccxPfoU0RF0xrMHHAV/9pv/9Q+MZAtO1pCrBrXhBc+98Zb
	dMNVz9FWPVqZFfr3M4=
X-Received: by 2002:a5d:474c:0:b0:48a:f454:3d4 with SMTP id ffacd0b85a97d-48e07fac2a3mr12245302f8f.53.1792436470203;
        Mon, 19 Oct 2026 12:01:10 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e1d823cfcsm711128f8f.39.2026.10.19.12.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:09 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:01:06 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 02/18] nvmet/debugfs: Export controller CIU and CIRN
 via debugfs
Message-ID: <20261019190106.GK2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-3-mkhalfella@purestorage.com>
 <179241127352.3544975.2554197788837860779.b4-reply@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179241127352.3544975.2554197788837860779.b4-reply@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_120113_966197_E9C2012B 
X-CRM114-Status: GOOD (  15.41  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-10-19 14:01:13 +0200, Daniel Wagner wrote:
> On 2026-09-20 11:28 -0700, Mohamed Khalfella wrote:
> > Export ctrl->ciu and ctrl->cirn as debugfs files under controller
> > debugfs directory.
> 
> Could you add the 'why' part to the commit message?

target# grep . /sys/kernel/debug/nvmet/mysubsystem/ctrl1/{ciu,cirn}
/sys/kernel/debug/nvmet/mysubsystem/ctrl1/ciu:57
/sys/kernel/debug/nvmet/mysubsystem/ctrl1/cirn:42541d24813bb536
target#

host# grep . /sys/class/nvme/nvme0/{cntlid,cirn,ciu}
/sys/class/nvme/nvme0/cntlid:1
/sys/class/nvme/nvme0/cirn:42541d24813bb536
/sys/class/nvme/nvme0/ciu:57
host# nvme admin-passthru \
  --opcode 0x38 \
  --cdw10=$(( 0x1 | 0x57<<16 )) \
  --cdw12=$(( 0x42541d24813bb536 & 0xffffffff )) \
  --cdw13=$(( ( 0x42541d24813bb536 >> 32 ) & 0xffffffff )) \
  /dev/nvme1
Admin Command Vendor Specific is Success and result: 0x00000000
host#

I found it useful to export these values while working on this change.
For example the command above can be used to trigger CCR and observe the
target behavior with the expectation that ctrl1 on the target will be
failed.

Added a sentence to the commit message to mention that.

    Export ctrl->ciu and ctrl->cirn as debugfs files under controller
    debugfs directory. The values are useful in matching host controller
    with the corresponding target controller.

> 
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Besides the missing 'why', it looks good.
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 

