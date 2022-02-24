Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F6AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 22:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=puf/8FKdbLYr0quA4rpvgcZpxrpDxz2P+EMGDZo/H/8=; b=xXVr8XnmhVug5pzx+ZBmblPSZh
	ABg+jlqW7yV1O67sHaEfKfMWttPU1JRztwgfiQSJUcS6KU3N33MNEkBUSy2cA+fqdhOyqw6bTX59P
	StN4BgrAcELPWKvhiAU9OPmAHSNU1+ZzRD7LNlnu2fXGNjZh4uUSTHybHrwtEiKsjTiuKlgmirpn/
	ONbjkV8qRxIB50CIXyHl40IXcPHDNI7NxHYEajCBKD3vD/z4iGz23YCKoSmwOMWCWFBT3FKq3G4tZ
	MLyuTyD1HHd9bxx7M9XwIPPs4gFi7CBzaxmd0UDYOTPADZcoykGEFjM+xX6YGlIDcI4rfJGdjoWhD
	zUkJjzOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNMh0-002Z5M-4X; Thu, 24 Feb 2022 22:34:34 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNMgx-002Z4r-3Z
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 22:34:33 +0000
Received: by mail-pl1-f175.google.com with SMTP id n15so889074plf.4
 for <linux-nvme@lists.infradead.org>; Thu, 24 Feb 2022 14:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=puf/8FKdbLYr0quA4rpvgcZpxrpDxz2P+EMGDZo/H/8=;
 b=SCjyFi/APLnUGvk5GfhguflpYnLTNIh6Ukf0fMQ3xVkze1CGYMg4H1yhrWvx9rqe3N
 bXyqHB2y+EbgBMoLUgWrW95LsBe8yTOzBzixMtaIlxDswV+oCZAxSkD2M/WuaCscLCtB
 63uMGJUr8U0A+qA2L1XtGLTHfKWvWmjZ2/rYHk2H6CWifm7FEhWagz/HY1jL8KRos3Rs
 cuCfi/PRbLJSszDOYBhzFrqP/SYHQXoTHdQcY9HiTOgPCtlQt/9m8KLeyssE2/o3ba4/
 IG4ObP356jHfL+AqW8ZTxAr6KgoZr3U6Ql7M5wngjEnZSQNPhbf1+HY0Cm46BX9Gykvw
 IIAQ==
X-Gm-Message-State: AOAM533sOIthbeFMLEoa6nJQj4Q191FCwMZCby4AuJvUWfSvJ1D+fvnf
 QMjYZoGZs8M/gtF3MI2tUzxG0Yu37SM=
X-Google-Smtp-Source: ABdhPJzRDjZLym3li7hQ1xawBNXudqozQ0BsjH0SuPNJGvDI9I0OWzXtLRm+ZuRQbprUfctKxS5dAg==
X-Received: by 2002:a17:902:b08e:b0:14f:11f7:db14 with SMTP id
 p14-20020a170902b08e00b0014f11f7db14mr4511843plr.106.1645742069068; 
 Thu, 24 Feb 2022 14:34:29 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id
 my6-20020a17090b4c8600b001bc2cb011dasm305319pjb.4.2022.02.24.14.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Feb 2022 14:34:27 -0800 (PST)
Date: Thu, 24 Feb 2022 14:34:25 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, io-uring@vger.kernel.org,
 joshi.k@samsung.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org
Subject: Re: [PATCH 1/8] io_uring: split up io_uring_sqe into hdr + main
Message-ID: <20220224223425.yb2bs5sp3vhttjz3@garbanzo>
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-2-axboe@kernel.dk>
 <20210318053454.GA28063@lst.de>
 <04ffff78-4a34-0848-4131-8b3cfd9a24f7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ffff78-4a34-0848-4131-8b3cfd9a24f7@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_143431_176116_C7B2562C 
X-CRM114-Status: GOOD (  10.91  )
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

On Thu, Mar 18, 2021 at 12:40:25PM -0600, Jens Axboe wrote:
> I'm not at all interested
> in having a v3 down the line as well. And I'd need to be able to do this
> seamlessly, both from an application point of view, and a performance
> point of view (no stupid conversions inline).

At this point I've now traced the history of effort of wanting to do
io-uring "ioctl" work through 3 sepearate independent efforts:

2019-12-14: Pavel Begunkov - https://lore.kernel.org/all/f77ac379ddb6a67c3ac6a9dc54430142ead07c6f.1576336565.git.asml.silence@gmail.com/
2020-11-02: Hao Xu - https://lore.kernel.org/all/1604303041-184595-1-git-send-email-haoxu@linux.alibaba.com/
2021-01-27: Kanchan Joshi - https://lore.kernel.org/linux-nvme/20210127150029.13766-1-joshi.k@samsung.com/#r

So clearly there is interest in this moving forward.

On the same day as Joshi's post you posted your file_operations based
implemenation. So that's 2 years, 2 months to this day since Pavel's
first patchset... Wouldn't we be a bit too much of a burden to ensure a
v2 will suffice for *all* use cases? If so, adaptability for evolution
sounds like a more fitting use case for design here. That way
we reduce our requirements and allow for experimentation, while
enabling improvements on future design.

  Luis

