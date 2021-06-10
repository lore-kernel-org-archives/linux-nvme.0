Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2092C47094
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 11:51:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4F261278
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 11:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4F261278
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SrgburYBoIY5YRLUXiHcYbJAktrkK6uU6Q3HJAVgMiA=; b=C46lmJd4szAF2i
	xZcT1ct61Ppqo5eiRNMLTE2m6kJ1UdpOe6GhPT5CC8nzvEYKVdbmm0dOQd+I3+ph/i8g5Ti2FfybU
	63/t7xPvZjg2B07HdqxooB5nqTU0KdN/j5qcvaH1DGXoeEJV3PQP/m46hWvBZU7FKmbuJ4Hrvn36H
	K/BivH/EIUzjjbR9lVM9B9xh10ALbkwImLXrxNtwYzl+36iRT0eKx1GVaabSwwAAyW+Iz+0B2lC24
	bG63eIYsihsgb6/q5euLS2CjHLyyaMc1b0uuoOaVJy36v64tWgdKmaNoq4qARVwhs1EswZMlVSM8a
	wGbb4xTpWfNRgoN5XQaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrJDf-000ami-NZ; Thu, 10 Jun 2021 11:51:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrJDc-000amF-IC
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 11:51:30 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93D8C21910;
 Thu, 10 Jun 2021 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623325886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rm8a1L2pKjBfb+raJ+EyG/GiYYXn/HPMZfDBYy43s4E=;
 b=iFWA4MBVT0ueVLpWeeJ5w/5ty0oPb9Rs8bCP9aMnJWUE7e9uAdDlIRm/vtQn86WjUl12RT
 hFD+LRs4kHnwRMDo2yr5D0amDIi++1md6ZWJ7sboOHvMOIHTTjV+Tp5MxyTUk1rqlTfv5s
 TCykLlPMLtDRGQsHgNUV1fvaBu0+UGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623325886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rm8a1L2pKjBfb+raJ+EyG/GiYYXn/HPMZfDBYy43s4E=;
 b=fdZj3OVn4ZDM0i+Wmaj6TXsMb58uTqAu+cI+3cisn0/blUbddXtLZ9wD0ZZaMxHL6dOf1e
 FUaxX60v3/M8mZBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 7AB7A118DD;
 Thu, 10 Jun 2021 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623325886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rm8a1L2pKjBfb+raJ+EyG/GiYYXn/HPMZfDBYy43s4E=;
 b=iFWA4MBVT0ueVLpWeeJ5w/5ty0oPb9Rs8bCP9aMnJWUE7e9uAdDlIRm/vtQn86WjUl12RT
 hFD+LRs4kHnwRMDo2yr5D0amDIi++1md6ZWJ7sboOHvMOIHTTjV+Tp5MxyTUk1rqlTfv5s
 TCykLlPMLtDRGQsHgNUV1fvaBu0+UGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623325886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rm8a1L2pKjBfb+raJ+EyG/GiYYXn/HPMZfDBYy43s4E=;
 b=fdZj3OVn4ZDM0i+Wmaj6TXsMb58uTqAu+cI+3cisn0/blUbddXtLZ9wD0ZZaMxHL6dOf1e
 FUaxX60v3/M8mZBg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id LPYAHb78wWBdCgAALh3uQQ
 (envelope-from <dwagner@suse.de>); Thu, 10 Jun 2021 11:51:26 +0000
Date: Thu, 10 Jun 2021 13:51:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Message-ID: <20210610115126.r3fxxtgnuyq447su@beryllium.lan>
References: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210610074546.jyqjalpldii6reg6@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610074546.jyqjalpldii6reg6@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_045128_774754_016E8685 
X-CRM114-Status: GOOD (  13.22  )
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

On Thu, Jun 10, 2021 at 09:45:46AM +0200, Daniel Wagner wrote:
> >         id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
> > -       id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
> > +       id->mnan = cpu_to_le32(ctrl->subsys->max_nsid);
> >         id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
> >                         NVME_CTRL_ONCS_WRITE_ZEROES);
> 

I am a bit confused how the target code indexes the namespaces. In 6.1
Namespaces the valid range for NSID is defined from 0 to namespace
-1. In 6.1.2 it says 'Any NSID is valid, except if that NSID is 0h or
greater than the Number of Namespaces'. And the figure 348 shows clearly
NSID 0 is not valid.

Looking through the code I think the nsid range used starts at 0 and not
at 1. Which would explain why the above change is not enough. The valid
range for max_nsid should start at 1 and not 0.

Thoughts?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
