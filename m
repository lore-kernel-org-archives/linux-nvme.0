Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F02C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 18:26:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD5A2313E
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 18:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD5A2313E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3bCFla1OL3Hz6DRPuejA2DCRO/IfcziDnLZk5ebZQQ8=; b=YPQ2nXJDyybr0+9GjVkOavZOK
	bzTF/xaShcJ5UTQCmq7B010SkOdxrNUO/mYaUs5jVx3dpy4zal9wuLR8tSBGA/6AvnXTa7gsUohQg
	FIrifIq5DhlIQ29+YbFnN/Nxg79GHq32AneuCf9nGGW8ATJHtfwEblwOCuwzUoE7Q1GnWK5Qqi7vc
	Hmm2XlIlqIlvnGcrNIIWwRndgq3gnoS/6K48vstVl9OT0qK9a1jxfg2Im6eDqiNrWPqaFeWGX/CLt
	Gcf99SzoalFelTzEO+WGkfHlxyTmNSmL5YVR19qaHZjK3IS4KFwBY02AhDb3th9xk+twEeySIlAo2
	lIS+lr+4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0TnY-0002s5-Gh; Fri, 15 Jan 2021 18:26:12 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0TnW-0002r7-1w
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 18:26:10 +0000
Received: by mail-pl1-x62d.google.com with SMTP id t6so5139795plq.1
 for <linux-nvme@lists.infradead.org>; Fri, 15 Jan 2021 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lSpvJ7XxTSF4/L1GeU6HJgz75b3xfhSg5dMarCh7E7s=;
 b=ctetNe9WmLlkbMr5+e/8Exr0Wwbc8OOfETlasNSxRYQbvkzVSVrmx29MZPNmcfUKeG
 6FZQsDqTun0aGjusVH4YsfhZ8upBsQkSyZGINjKslsC2i0DdA2DuU6ARA3EB3xJld6Dd
 gaEB0xcBL8IUo21RymU3x/ZDyPusDdmYbDHRlcCV0aZF+udPRJpSU0zGhQOxeY+WZhba
 2qLukO0swfb6PAZbrAu/OQtZod1PIlaJrTwrbeaMh+hJQKXh1IeGPTwcPKV7Mf8Wsd4l
 vXJ3Ob/l7BqHAzoFG0axB/ZX8q1arpS/16J2mGpECYhQhDaI1q7XgGuJtKfGmvY5EaCn
 4MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lSpvJ7XxTSF4/L1GeU6HJgz75b3xfhSg5dMarCh7E7s=;
 b=ruA/BvYtJEQXVv2UD+mLkkgdM2rrci5+HCcwcEePwYYJI//z/2YINCvXx2c1otaqGI
 YaCzTBH/3h/Y+mbvy8y6KQpYlyNujCubfT6axWrT7o4OUI4vRApGpYjBUfFmXYRgJPY9
 0e55sOSRRsz7hVd+bGnfZ0nKltJCmP+illcOwSHeZfRrqz1NMPI/b6FLl7hNZfBouua0
 yao3jqCSwsKj726jUYidQ596rJbG4qQLg9XGkcQKeUxjxERmU4r8JuxHLc+2INrmtIvi
 x+vgEQyee/j4uR9RJMs2kqkROAtKlNgdNl/abnEVowsQxkLZRvPtn59Axlplz1pZHdfU
 c9kQ==
X-Gm-Message-State: AOAM532hZpe6UPYCMcBa0g8hHbsLZ55mvFV5R6keh8sgvU/gQiBTwGJX
 wlAr2P5UvMzMWhlVEP0DrUIxDs9hNlvcBg==
X-Google-Smtp-Source: ABdhPJzZjQLUcoMZUi8fRtG219/F+rgyFL+Gp5/QqoTa2+r6Xm8yGVNaxJ6wSeMvOmriIAsvTSOcWA==
X-Received: by 2002:a17:902:a988:b029:de:27c0:cf2c with SMTP id
 bh8-20020a170902a988b02900de27c0cf2cmr13853163plb.25.1610735166095; 
 Fri, 15 Jan 2021 10:26:06 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id k11sm8959508pgt.83.2021.01.15.10.26.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Jan 2021 10:26:05 -0800 (PST)
Date: Sat, 16 Jan 2021 03:26:02 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 3/3] nvme: retry commands based on ACRE flag
Message-ID: <20210115182602.GA2822@localhost.localdomain>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
 <20210114133110.20779-4-minwoo.im.dev@gmail.com>
 <20210115170412.GA1515933@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115170412.GA1515933@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_132610_115387_C16E7B86 
X-CRM114-Status: GOOD (  18.97  )
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
Cc: Jens Axboe <axboe@fb.com>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-01-15 09:04:12, Keith Busch wrote:
> On Thu, Jan 14, 2021 at 10:31:10PM +0900, Minwoo Im wrote:
> > @@ -317,6 +316,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> >  			return COMPLETE;
> >  	}
> >  
> > +	if (nvme_req(req)->ctrl->acre &&
> > +	    !nvme_is_path_error(nvme_req(req)->status) &&
> > +	    !blk_queue_dying(req->q))
> > +		return RETRY;
> 
> Is there really any reason to tie this to acre?
> 
> > +	else if (blk_noretry_request(req))
> > +		return COMPLETE;
> 
> I am not sure we should ignore the FAILFAST for non-path errors. If we
> need retryable admin commands, we should let the driver provide a way
> for callers to dispatch requests without that flag.

Understood.  I thought the opposite way about FAILFAST in case with
acre, if device is enabled with acre, all commands would be retried
regardless to FAILFAST...  Thanks for pointing that out!

How do you think which one is right choice to go with if a user-space
application(e.g., nvme-cli) wants a command to be retired in case of
ACRE && Error && !DNR:

  - User-space application should figure out !DNR and retry the command.
    (Maybe we are not able to easily figure out exact status code from
    the user-space application by the return value).

  - Driver should retry the command right before putting result up to
    the user-space even it's a FAILFAST request.

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
