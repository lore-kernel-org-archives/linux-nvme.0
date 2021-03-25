Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19336C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 09:38:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AE761934
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 09:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AE761934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s6m0YT3lI9tzWlD7VbzLE8o4qYFvj3HdWynrFKXJY2E=; b=QY1pkKq5cAAZFHVOc+A6EgVGE
	S+3q0z7XaITmFCg/TJfN8mXOlYhMUZ+D/KmfAu0LPB/QmBEed+Gg/Geb2YS2jVSc3i5j9kNUFPlRy
	3dMY1mkj7SPDaoRQTzv7Th5MiS4GmzwO3/eXxTbwvB4TlAu0T3xRwWAuON7sv8zKF2B3J/RmQ42PM
	lwKXnuyv9KUeZxdOIZBk6DmAXI2ukFN2LZeO3zrQ4cxz4txll1GNAAIBzGE60CTnMJAZkDwQwQVJC
	nJg5kpHw+64PSoHPIHCseGYkTQZP1jRgjMxytotUTLhVh/2XZzT3gPEr8BmVVbRxmKbB/IHSMzR6U
	mFPWF/sIQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPMRJ-0017I4-80; Thu, 25 Mar 2021 09:38:05 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPMO8-0016kx-87
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 09:35:23 +0000
Received: by mail-pg1-x531.google.com with SMTP id l76so1203007pga.6
 for <linux-nvme@lists.infradead.org>; Thu, 25 Mar 2021 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3UP5h4Op4BS3+R9UjmCX7Iew5IlZCzw4jgGGElWFIiw=;
 b=Jf/yRSukhVIRqFkNYmlTBkc40E/7lajmaPL9ojpAVetkvA4Uwugf2ZDCE5f3Nj4yCv
 6c/K2DzcIRkQtMof/r5AFRMBssCfxvIn9U5VVvdL0Qyt+W5wBSTg+Uy4DbY99US0NQZh
 /VI6XaoS7NplB583G5okyi2+YGwRbIQkyVojK1wUIUHSltHHHrfu9JrNydyNAEH0RMaN
 VVrWVh7WmAf4V29Lo+ZOVZc73iIthB3KC3QrpJb6HIHdRkChRK+yecb39HFliZN0+XiV
 P3TWmjhzZNIiveFB1gTXu55iVrg+wM69xs5lOpjR6+SIFVSfOrY2rDFkCN1/pJ17rUJf
 7FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3UP5h4Op4BS3+R9UjmCX7Iew5IlZCzw4jgGGElWFIiw=;
 b=AO+XES6lZBLQuFWHTYLQtgbO3ncOMkl4/jfqZHAtFtDEZAOnJIpH5VJMxkISd6q/wE
 w1oDBCFvz9+We1ODv94G/hirvXCrb/XU/Gq8H1EZJjj5u22Gfhgu1eZCZ/ONLdNBxHX1
 vlq/6VltYDom4PBkc5QEDGz/2FBRZmN3YMW1uVM0ZiJ35ymJrxsFnb728yCkmB1RZKi8
 4gHDufx6XzhyoRTeJ+rt4iGbaqTi19bj9V07/rfy7VssUH46QJAIyqP/KM1ibkEH1Yya
 1Gf/I+pO7bmci1SF8iprVUyW0YuEfQzVv0LlP817W4wTp8I3E5ZtEJ81d6rAkoVsI5UU
 idTw==
X-Gm-Message-State: AOAM530WlkTinnu2ioCokLtiAdHUtVTy/g3f+r9rpGbMjj37DdYg23Vp
 nKELo2gEr3gjvUFgLvE9PF0=
X-Google-Smtp-Source: ABdhPJx977jhtcCNFqgWpF7+d4rUgjNf4nUwxM3nC9DVW0sGqrwEHtGkogVa1tnu7fgQp3whOSMNTw==
X-Received: by 2002:a62:52d7:0:b029:1f5:c33e:811c with SMTP id
 g206-20020a6252d70000b02901f5c33e811cmr7501049pfb.50.1616664886612; 
 Thu, 25 Mar 2021 02:34:46 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id n24sm4820914pgl.27.2021.03.25.02.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 02:34:46 -0700 (PDT)
Date: Thu, 25 Mar 2021 18:34:44 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325093444.GA4330@localhost>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFswq8pgzg9y00GO@x1-carbon.lan> <20210325020951.GA2105@localhost>
 <20210325082647.GA27622@lst.de> <YFxMSzjJMqdUiqxm@x1-carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YFxMSzjJMqdUiqxm@x1-carbon.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_093521_728018_2F3D6835 
X-CRM114-Status: GOOD (  26.10  )
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

On 21-03-25 08:39:40, Niklas Cassel wrote:
> On Thu, Mar 25, 2021 at 09:26:47AM +0100, hch@lst.de wrote:
> > On Thu, Mar 25, 2021 at 11:09:51AM +0900, Minwoo Im wrote:
> > > > I was still allowed to write to NSID2:
> > > > 
> > > > sudo nvme zns report-zones -d 1 /dev/nvme0n2
> > > > SLBA: 0x0        WP: 0x1        Cap: 0x3e000    State: IMP_OPENED   Type: SEQWRITE_REQ   Attrs: 0x0
> > > > 
> > > > Should this really be allowed?
> > > 
> > > I think this should not be allowed at all.  Thanks for the testing!
> > 
> > It should not be allowed, but it seems like a pre-existing problem
> > as nvme_user_cmd does not verify the nsid.
> > 
> > > > I was under the impression that Christoph's argument for implementing per
> > > > namespace char devices, was that you should be able to do access control.
> > > > Doesn't that mean that for the new char devices, we need to reject ioctls
> > > > that specify a nvme_passthru_cmd.nsid != the NSID that the char device
> > > > represents?
> > > > 
> > > > 
> > > > Although, this is not really something new, as we already have the same
> > > > behavior when it comes ioctls and the block devices. Perhaps we want to
> > > > add the same verification there?
> > > 
> > > I think there should be verifications.
> > 
> > Yes.
> 
> Thanks Minwoo, Christoph,
> 
> I'll cook up a patch based on nvme/nvme-5.13.

Just FYI: Actually Javier and I am working on this patch of the next
version and have plan to post it on this weekend maybe :)

Thanks!

> 
> 
> Kind regards,
> Niklas

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
