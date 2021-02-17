Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E84C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 02:15:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CD864E13
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 02:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CD864E13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7v0vb7GA0t0jLcgDPKHi0Ar7oZVycbxNgqfaK74Glk0=; b=1dtwtuzuCu9HAv+J1OV/WDiXi
	1ek7ZGXYwNUak8SshQMRzN71+EXJ1BGiNqoQiHRfLOBfhJClJae9GepBTenwtEqLRRstgX0HsYYBy
	N8ms0vhPK+x2B38+IX5vvrAQlxG1aLNz781w9wAQIdSI/KTY8bgQSFMFuy+Lui/LGECt7nFE2vWb2
	z9V4Z3y/VZC9nzYIze2Do1ncMAAscOCFD0X+4AyXzpdZusGTPZ/h22nJJ+kvrdYE5+PnkoBMuiUw3
	gS9tZ+5GsWIgI/K3J1L57YE4a9ZbBXt9M5SNQmVzWT/Kl0J73QQII7s0ObogCyS+HGqZSWvSxvD16
	usMKHVoWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCCMq-00081c-Ew; Wed, 17 Feb 2021 02:15:04 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCCMn-00080j-GB
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 02:15:02 +0000
Received: by mail-pj1-x102c.google.com with SMTP id kr16so569663pjb.2
 for <linux-nvme@lists.infradead.org>; Tue, 16 Feb 2021 18:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rDE8QJ4kq34g+Wz1YMdsNi1DYpviuDa5RWSwbBQkIas=;
 b=GxQXhV39v+hZZBA4Dob1V1tVoGY4jOP6fdSpUuM+/bn9mbvId44tAkIlwqM7yAweHH
 LMNSEJPKLJCPorVPBc+7xwnJYrXnd5cLcdDmUNDPpDsQAa/k+rP8J3O4cqDmxV1xVonJ
 uqg+xpkfpn3iYHioDBFX7wSns7h4M7hQOj7sjAI3g4VU2jBNrcjT3GXqlJghgtcl6vIe
 Ll/55WC0TdOQodq0occRJOJYN64qKiY4rBmg+DbzHNBraK8y85NMIYwqUt3fwbEnoM6Z
 MgNhWdphwlFyBgl20N1Oh1Nx/6UglqWjS0gAOcGYmVE6GfN1s/mPInAqdcnDPvOLaCoy
 N/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rDE8QJ4kq34g+Wz1YMdsNi1DYpviuDa5RWSwbBQkIas=;
 b=s5eSmhlv61QAtTf5jxOqVskyOb4WTljQxlT4GwG46C0bnMAXRQVVaouf6x1104zDA/
 LbzXvjBVsXchJRR6q3HWlAxvoRsR/Z7WzyNGJzmVN6wCsHMDW+OFl3V0ie77j1zfuMNL
 7XK70zXI7h2TEKbLE8Uz3c5J2Q1IRMyXqbYnjQNx0G2WE1RzSTToJzuTh4j4hwf744FD
 vrXB5Q6w0o8Lhw4qdolR6pf8pajRggNWdB1xqt5U9DxasnZWsgo+0fflhe2KErtmpa7L
 mf4fwd0OuFlgX5xMhaqSUrdVE7VvaBUjNZvrVYhugMwFjSW5wrtY8R5eZVZlxwgWzQFg
 j2wA==
X-Gm-Message-State: AOAM531JpiQCP9Eu1nBREvO6rqpadWF+WcrZHo8FMJ5vMLvzJ4JCS3QC
 Q3XMl7q/PqjxM5YGCsKRzx8=
X-Google-Smtp-Source: ABdhPJxDhJ1u7WA+oKPY6xL71QQiYpB2+LHKKCZjHSypyg5gQUi4StUQf7PB+V2LCbDvHrfnjo/H6w==
X-Received: by 2002:a17:902:d2c1:b029:de:7c38:f86a with SMTP id
 n1-20020a170902d2c1b02900de7c38f86amr403417plc.83.1613528097924; 
 Tue, 16 Feb 2021 18:14:57 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id e24sm243654pjr.13.2021.02.16.18.14.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Feb 2021 18:14:57 -0800 (PST)
Date: Wed, 17 Feb 2021 11:14:55 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: introduce passthrough ioctl for multipath
Message-ID: <20210217021455.GA2251@localhost.localdomain>
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
 <20210214110126.24023-2-minwoo.im.dev@gmail.com>
 <20210215170233.GA2707454@dhcp-10-100-145-180.wdc.com>
 <20210216095147.GA2601@localhost.localdomain>
 <20210216175722.GC2708768@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210216175722.GC2708768@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_211501_598436_6E57CD35 
X-CRM114-Status: GOOD (  27.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-02-16 09:57:22, Keith Busch wrote:
> On Tue, Feb 16, 2021 at 06:51:47PM +0900, Minwoo Im wrote:
> > On 21-02-15 09:02:33, Keith Busch wrote:
> > > On Sun, Feb 14, 2021 at 08:01:25PM +0900, Minwoo Im wrote:
> > > > We don't allow NVME_IOCTL_IO_CMD ioctl in case that a controller has
> > > > multiple namespaces attached.  Also, I/O request to the controller
> > > > character device has not been recommended and deprecated because we have
> > > > block device to I/O with where the multipath consideration is taken.
> > > > 
> > > > Once kernel decided a path to I/O for a namespace based on the I/O
> > > > policy of a NVMe subsystem, userspace is not allowed to choose a path to
> > > > I/O.  If a path is broken(inaccessible state in ANA), then it will not
> > > > try to I/O to that path.
> > > > 
> > > > This patch introduced NVME_IOCTL_MPATH_IO command for controller
> > > > device(e.g., /dev/nvme0) to support multipath I/O passthrough for
> > > > userspace.  Regardless driver's path decision, userspace can target a
> > > > namespace to I/O.  In this case, `cmd.nsid` will be used to find out the
> > > > namespace instance target which is hidden(e.g., nvmeXcYnZ).
> > > 
> > > IO commands are not allowed through the character handle with the
> > > existing ioctls. A new ioctl doesn't make it okay. If it was okay, then
> > > we could just remove the limitation in the current ones.
> > 
> > Thanks for your feedback, Keith.  If you don't mind, may I ask why it's
> > been entirely unsafe and deprecated in the exsiting
> > ioctl(NVME_IOCTL_IO_CMD)?  I've seen a patch bfd8947194b2 ("nvme: fixes
> > for NVME_IOCTL_IO_CMD on the char device), but have no idea why it's
> > been really depreacted :)
> 
> A container could read data from namespaces assigned to a different
> container.

Now I got your point! Thanks Keith, please ignore this patch :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
