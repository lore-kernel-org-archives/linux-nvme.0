Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ED6C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 00:52:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C0A23108
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 00:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C0A23108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VQpWd4LGyk67Av55xA1xCqP8w7I3cXA5Z54iNYDOMHU=; b=old3KWrzeetdBHK7lZy2OIx/U
	+WpwdpUCVfbYM16BBB6qEbR0/1+GoYDVIzHHC92POu7KUC4anBS9h6twQM6YCg9U6J4Aq/bq333Wd
	8KYjdouQh2T4v0kP7wTdJ4kcBG9BlFx3CLnKQRQflIV70n0ZPq888ahv4PyFUMf3WGlNxY3bq7RsV
	yWXL5boRslLFkC+feisbamf63E7mfYNLYXDOvm8QOWhN2YVVCoXKxb03GAIE1SlkT3ay8EUxtTmqf
	6yqVJ9Yp2YUO/siRxjdrlW3v+vmINptbEK9UJpLv0lmcdvS71B4Tz2rlIdeYB9LtikQG1bLUrIri6
	lm+DvrxCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l21jm-000176-HS; Wed, 20 Jan 2021 00:52:42 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l21jk-00016m-HL
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 00:52:41 +0000
Received: by mail-pg1-x536.google.com with SMTP id g15so14076281pgu.9
 for <linux-nvme@lists.infradead.org>; Tue, 19 Jan 2021 16:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QP+d0Iwgmmu1YyyUqww1wDIflZtrO+dTtfrqCTcE6dE=;
 b=sdIdOzmnMqhPqCq7jrz18eS3ROdxw7OzBOHiqbP/bavWDcit8jN+aO7n6iyf5WgNXc
 hFFvzbiZ5sllhA0acqHKFeNxf28FjAWbipI9iTHXDn+2FQhTiNqXWiHajaMfJhhAPKZy
 9OTj9qHSmCL5gSTSK7nd3Yqhb2sKdRJ4GT68kIhoDH8ojIP1vPYivsNAynzOuEsu+eAb
 wYUNV9aMr8YjsmZgsEgXpJYav+NdjYpiD3Kt+9kILKaoRuz+xLm19/TKFEwAovqfcYvA
 GrceQWO+peKVhsmMVIM9/hLCgdeMCb6Twv9Pvg8/z3zUxcJwMpTJPAaINsNQd5b+EpgN
 rqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QP+d0Iwgmmu1YyyUqww1wDIflZtrO+dTtfrqCTcE6dE=;
 b=CW40v8kUrOVFBNFSpeGGSjl0NJB4dBkxBKHnRU+JINwlv1x1R8H3kIV9CaKs9IsFXS
 Tdw90N7i+mOggJCqcORI84ZYTBEQQX1dK3gmSwvsm0ximcVAorQORvPEuJ454w1EKODH
 wbfAsNFF/KrfM0Fe6YgctiD2Tiyy7xOaD1j3iyx49ipKG0hJEm9s/J2uVJmNp88MR3VS
 H8eKBv28LOGl0q7wgaD1NHx6c5IYFwtPYNQDSgADTfVQcCp5Vw9xuxCwasWZxUhP+OBG
 RvrIlcOxDB1G4o3JRPXazwHy2jvyhPpkhwxLvyzjbCJWsKmHtKgN5kgMVvxY4q4goJq1
 LV7g==
X-Gm-Message-State: AOAM530WupRD0/S1aYxc6UKV2gSViSdNK5dw4pLlbhxvgyUIy9djcYxq
 agy0pxSMWHEHAVCOS1jIiBw=
X-Google-Smtp-Source: ABdhPJxYbIaI/v+AEb6A0QQiNGjcr/FBJXPNCbhyG4cng37TyYdkjqUbfIrUtIorSMLOCnto7ctgEQ==
X-Received: by 2002:a62:2642:0:b029:1b3:b9e2:104 with SMTP id
 m63-20020a6226420000b02901b3b9e20104mr6882090pfm.74.1611103958631; 
 Tue, 19 Jan 2021 16:52:38 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id u6sm256561pfu.158.2021.01.19.16.52.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Jan 2021 16:52:38 -0800 (PST)
Date: Wed, 20 Jan 2021 09:52:36 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 3/3] nvme: retry commands based on ACRE flag
Message-ID: <20210120005236.GD4205@localhost.localdomain>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
 <20210114133110.20779-4-minwoo.im.dev@gmail.com>
 <20210115170412.GA1515933@dhcp-10-100-145-180.wdc.com>
 <20210115182602.GA2822@localhost.localdomain>
 <20210118174051.GA8542@lst.de>
 <20210119180535.GA1520627@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119180535.GA1520627@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_195240_619351_E2928EE7 
X-CRM114-Status: GOOD (  28.94  )
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

On 21-01-20 03:28:38, Keith Busch wrote:
> On Mon, Jan 18, 2021 at 06:40:51PM +0100, Christoph Hellwig wrote:
> > On Sat, Jan 16, 2021 at 03:26:02AM +0900, Minwoo Im wrote:
> > > > I am not sure we should ignore the FAILFAST for non-path errors. If we
> > > > need retryable admin commands, we should let the driver provide a way
> > > > for callers to dispatch requests without that flag.
> > > 
> > > Understood.  I thought the opposite way about FAILFAST in case with
> > > acre, if device is enabled with acre, all commands would be retried
> > > regardless to FAILFAST...  Thanks for pointing that out!
> > > 
> > > How do you think which one is right choice to go with if a user-space
> > > application(e.g., nvme-cli) wants a command to be retired in case of
> > > ACRE && Error && !DNR:
> > > 
> > >   - User-space application should figure out !DNR and retry the command.
> > >     (Maybe we are not able to easily figure out exact status code from
> > >     the user-space application by the return value).
> > > 
> > >   - Driver should retry the command right before putting result up to
> > >     the user-space even it's a FAILFAST request.
> > > 
> > > Thanks,
> > 
> > We could come up with a version of the ioctls that use the normal
> > retry mechanisms.  nvme_passthru_cmd64 has two reserved fields we
> > could use for UAPI flags like this.
> 
> Yeah, I'm totally okay with adding driver control flags for this sort of
> behavior.
> 
> For the moment, the ioctl interface has always been 1:1 for commands
> submitted to completions received, so all user space applications using
> this should have been prepared to receive unfiltered status back and
> handle retries on their own.

Thanks Keith for your feedback!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
