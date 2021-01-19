Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B74C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 03:31:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A7E221F7
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 03:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A7E221F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g8IlRqCPLmTS/j+0M3a8eA2/1OQkqDVPda2v42xbebo=; b=HCDAyezaK2erptbN2NfmEIkXr
	EwjcIi0lA2cFTmk7JNb7ClAFE6xwuTHo4WB+fv771zNjFKv85DbAG7aLcRXC88CN7d/vgUGc1RDYa
	63ky1ZfmYW+Qbd5sdpx6OR9xvZXNxGesdBY8DW7XvCy8p6EzW3mcYR4g47ye3k8LXMoYYi3uVB0D9
	gD7A2rPD5oybvd3qXi/Ib8xpTrawG+QoEcnngXTblyRvj/F91+7GgUMtTdthTw313XTJIEP2ktmhZ
	uDrWyl6mPXm3ecVPmC+odBEKvlUGYAuXsNiRPwy1jzwdYn1E5MwUIBni6tOu02wkFIWhCqrdp9jcI
	ykynS5k6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1hjX-0000Rf-OQ; Tue, 19 Jan 2021 03:31:07 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1hjV-0000RK-1b
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 03:31:05 +0000
Received: by mail-pj1-x1035.google.com with SMTP id kx7so1595940pjb.2
 for <linux-nvme@lists.infradead.org>; Mon, 18 Jan 2021 19:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4xTSTI2+gq3OyxFgsCPFuFdnJxj1NGzd9OHCzv3RKrM=;
 b=WFyEjw1Kic8befQFBjm7nzRCgIjFMislknUc4CWg+TbUxjMwBrDnlGenzj2A9K90rd
 +YJTU56oZaJFLvu+DfI2GvtIMMN85vvrINuEpAxAJ4I/DQ8Tq2Cl8hO6yWII60fZqjAj
 98LhR2UIeeVi9VHbARVBAuw+fpCOvHtbkE9T6em0wTtl3PMY+VjLGXIZnuU4yvbD4YRh
 wIW4Abi5vUoIL8oowuUfD7sxPlIfkn8thfPyL9zGe5A8pUhJqv/JSkwJevBwINypt0zq
 p7XrSCrez6lVyOTBv31HXj13odhnd8urac+fRbx75niU3ITLe12kH2Qrx9tgTAmvQNFL
 rCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4xTSTI2+gq3OyxFgsCPFuFdnJxj1NGzd9OHCzv3RKrM=;
 b=q+NqKFzG5iudUmCHAYswi8XAbnM22AjN4SEgYj5MPxUSecdLj2rSOB88bb3vwWsIfs
 9wCDOnjH9+Z+jyf/WVC/sRZNK3hKudKvuq3ST02dVotlHX0cVXnbCT6vgCNxA3iuXzDm
 K9GNECbW92B+MYcIxu1lnkq+W9Ys8+XZub7BLRgfxvlummaNtmg1qbRbVT8x1NchwiLW
 QBEsTZWZRg6tt9CIbay7hHaMFP/4OcHpmxlTNrXVDh1Aj1l1jarFVDXI3FdPeflyr6nU
 X7uS/KNPmXUOVDmaJU4kwyI3htnExW2BNluPBNEzNH8R1FQX1Z1RhaXZ3oQmWbyt2Yy+
 mLCw==
X-Gm-Message-State: AOAM532jpAEDfF/AtcHTDJ5FHjZaCxPYD+Y5foJhUabEyHLepwJSbawS
 76yCERnjFHe4EjwRS88jf+E=
X-Google-Smtp-Source: ABdhPJxUVp7f+VWQrPJPHWtaG7phYfnfczp8BpOQT/odtP1K0SQSZPI5z9+JMIzw1yo4NuAyHNCJIg==
X-Received: by 2002:a17:902:f688:b029:da:a817:1753 with SMTP id
 l8-20020a170902f688b02900daa8171753mr2589252plg.76.1611027061249; 
 Mon, 18 Jan 2021 19:31:01 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id d4sm17009008pfo.127.2021.01.18.19.31.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Jan 2021 19:31:00 -0800 (PST)
Date: Tue, 19 Jan 2021 12:30:58 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 3/3] nvme: retry commands based on ACRE flag
Message-ID: <20210119033058.GE5939@localhost.localdomain>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
 <20210114133110.20779-4-minwoo.im.dev@gmail.com>
 <20210115170412.GA1515933@dhcp-10-100-145-180.wdc.com>
 <20210115182602.GA2822@localhost.localdomain>
 <20210118174051.GA8542@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210118174051.GA8542@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_223105_103509_71C4180C 
X-CRM114-Status: GOOD (  22.91  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-01-18 18:40:51, Christoph Hellwig wrote:
> On Sat, Jan 16, 2021 at 03:26:02AM +0900, Minwoo Im wrote:
> > > I am not sure we should ignore the FAILFAST for non-path errors. If we
> > > need retryable admin commands, we should let the driver provide a way
> > > for callers to dispatch requests without that flag.
> > 
> > Understood.  I thought the opposite way about FAILFAST in case with
> > acre, if device is enabled with acre, all commands would be retried
> > regardless to FAILFAST...  Thanks for pointing that out!
> > 
> > How do you think which one is right choice to go with if a user-space
> > application(e.g., nvme-cli) wants a command to be retired in case of
> > ACRE && Error && !DNR:
> > 
> >   - User-space application should figure out !DNR and retry the command.
> >     (Maybe we are not able to easily figure out exact status code from
> >     the user-space application by the return value).
> > 
> >   - Driver should retry the command right before putting result up to
> >     the user-space even it's a FAILFAST request.
> > 
> > Thanks,
> 
> We could come up with a version of the ioctls that use the normal
> retry mechanisms.  nvme_passthru_cmd64 has two reserved fields we
> could use for UAPI flags like this.

Thank you for your feedback on this!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
