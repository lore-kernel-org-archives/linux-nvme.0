Return-Path: <SRS0=EEJI=JD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EADC433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 13:36:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178C2613B7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 13:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178C2613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LfwPCNvbsJg8RJmugo7IgS80HdtANeXf88wdPTvWICE=; b=KO1lzpeindP32htxkFI5wHyYL
	LRvdPd1LdE2Vi+wnTG8g55LY5n82gYEkSHjULswfDQjcfqNilbnRVGP95y1DVnnhM4Y1+61fiEKlU
	9/FQMsY4/cKFZRQn9rmv+1uYKb0H8W++/HsYY0rBIYVawWKq9unhw+UWNTx9t8VCGRuWZ07jJP0qU
	iJir2Kh+LAdKmTlFWNq3Mk5aVm54ehTQUDdm5M3kpRfpE26M52zXBSnV02O7jkh6IYSo/5SZMzMlv
	kEZgSelSiGwpO5hfZC9DeU0hg94FOPXf3evVs+le3NjxoCplmaSpxSedFly0pv1weBWpd5UDfJqX2
	qy9syBAiQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTlrq-002ire-28; Tue, 06 Apr 2021 13:35:42 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTlrl-002iqA-2B
 for linux-nvme@lists.infradead.org; Tue, 06 Apr 2021 13:35:39 +0000
Received: by mail-pf1-x432.google.com with SMTP id n38so765666pfv.2
 for <linux-nvme@lists.infradead.org>; Tue, 06 Apr 2021 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yHBIPojzXKdVNCkWaE7mKQ7cpB2yug9U425YlBqUg1E=;
 b=CMKskFbjc0efeWvT4m17312E3STwYrFAjEtUmPvFyQVHuxAtb4dDcG7h4fGv0XfqQe
 Y+fL11OfN5ROgnRUveB4Lux0aRg+IQYWVXQAldyDOjNv4k/p830KtoqeIkDTIqvf9pCe
 /P+vvZ4fNMC7PmihIjW9fOgagFYOotgBSPTzJ2/29B4cql7tvFm1t+X1t+11anhdgPuR
 rQ8KiOXzOzX5snwSxY2E2YZqoaWVjFQ6M2ka1Z6gQ9JAugexo/jTx3vONrZcYAwsntA3
 XoE1AgjB2uhrKrPe3CyA6Prmf06rl2mwcmiGi42QWkymOtuup0QGAFeK3ar8Ntr2L9VW
 iV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yHBIPojzXKdVNCkWaE7mKQ7cpB2yug9U425YlBqUg1E=;
 b=CZwGyD3hcQLsTQN0srnwBOwFrEVeNy/DxOxX32PKwXCukx0KYdFYyh5LpXeTPN80vY
 hGgVsML61xFdLfNeM/ShVsZhPBMAbFGzT2J9SGm3O9Xl3XZP9RPXi4Qch+EtdOOdhFSq
 QtGKLuf4rZdVZZbLXFukfwQ4scqXbwrglK4URvtr51zDjdwX4p+Gv9OxBFXmd7UoQ1op
 RDt+du5lJtgw1nTXEG3BY1aO11b4YxD89bCrxiNUfAelx6DNv8ZYM3I5Gq3NHCl3N0E5
 0DwVVLbI/HniPnKSPnkFIltKEiYMkd9GhCimMQj4YHv8+s6OqbnjGF/1K/SQ7sW72CBD
 XAnw==
X-Gm-Message-State: AOAM532la6hEC1ziaS8a3qQ+Nx7KKZ3yxRHVNDTAlNbLZQn5WHQ2UkR8
 pQ3HMJRqcqdftSfw4GlCryA=
X-Google-Smtp-Source: ABdhPJztlyVuKuXcCJGFfOGlROgebC61+M+MN42E3yWmgmBpYDmD353qx2ZnIlhHHfgRMwhw2KboSg==
X-Received: by 2002:a05:6a00:16c2:b029:228:964e:8b36 with SMTP id
 l2-20020a056a0016c2b0290228964e8b36mr28364808pfc.11.1617716135481; 
 Tue, 06 Apr 2021 06:35:35 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id a6sm19286274pfc.61.2021.04.06.06.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Apr 2021 06:35:35 -0700 (PDT)
Date: Tue, 6 Apr 2021 22:35:33 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210406133533.GC2594@localhost>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <YGwjc8rliXhvccPp@x1-carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YGwjc8rliXhvccPp@x1-carbon.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210406_143537_408952_3FF449FF 
X-CRM114-Status: GOOD (  35.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-04-06 09:01:41, Niklas Cassel wrote:
> On Tue, Apr 06, 2021 at 03:48:40PM +0900, Minwoo Im wrote:
> > Hello,
> > 
> > This is the second patch series to support generic ns character device
> > to expose per-namespace instance to the userspace.  This version fixed
> > code mis-ordered reported by Kanchan.
> > 
> > This patch introduces per-namespace character device to I/O in case that
> > blkdev is not initialized properly.  Userspace applications are able to
> > I/O to the generic namespace chardev even there's no blkdev properly
> > initialized.  Because we don't allow nvme controller device to I/O with
> > a specified nsid, this generic device will provide a way to I/O.
> > 
> > This patch is derived from Javier's patch series [1].  Javier and I have
> > re-coded this series again and it starts with new version tag.  Changes
> > from the previous series are:
> > 
> >   - Update naming convention for the chardev exactly the same with the
> >     blkdev:
> >         /dev/nvme-generic-XcYnZ  to  /dev/nvme-generic-XnY
> 
> Hello Minwoo,
> 
> The current proposal puts these new per-ns char devs in directly in
> /dev/ (I assume since Christoph didn't like the /dev/nvme/ subdir idea.
> Keith seemed to like the subdir idea, since he had suggested the same.)
> 
> For the absolute majority of cases, the namespace will not be rejected,
> so the user will be able to use the per-ns block dev to perform IOCTLs.
> 
> For the small minority of cases, Linux might reject the ns, so no block
> dev will be created.
> 
> I'm slightly worried that adding all these new per-ns char devs, in the
> same directory as the regular per-ns block devs, will lead to confusion
> from regular Linux users.
>
> Imagine the potential confusion about what device the user should use
> with e.g. fdisk, mkfs, mount, in fstab, what to specify in fstab, etc.
> 
> I think that there is value in reducing the confusion for regular users.

Agreed on this point.  We might have thousands of namespaces and it
might be making confusions to users.

> I don't know the best way of reducing this potential confusion, but here
> are some suggestions (suggestions are mutually exclusive):
> 
> 1) Put the new per-ns char devs in a directory different from where
> the regular per-ns block devs are located.
> 
> 2) Only create the new per-ns char dev for namespaces that were rejected.

I prefer this one which is the major reason of this patch series being
posted.

> 3) There is already a new module parameter for this, default it to false.
> 
> 4) Introduce a sysfs /sys/class/nvme/nvme0/export_unsupported_namespace
> that you can echo the nsid to, if you want to create the new per-ns char
> dev for a certain ns.
> 
> 
> I'm certain that someone can come up with an even better suggestion.

Thanks for your suggestion.  It sounds like it totally worth to be
discussed with people.  I'd also like to hear from other's opinions :)

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
