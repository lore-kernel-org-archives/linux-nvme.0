Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DF0C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:13:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA30F61284
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA30F61284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z6Yn3IG8g88gvSchdQqt3usN3g1J7ETYuPzG2LBGEf4=; b=oP+q2E0ZW22uQa
	yWRY4dPH0FUwaCExkV9jWS37IHcG5PRULAFuYROPPULVctMWsB+e4l9ycljHIVu6cvgHxmLwGXjeg
	4Q3GtM1CA1pYu59Rg4S0IbXugqAA2fm/XbHlLlDQHSmBK4hJFFt4lN2NSmqQPTrj26WqZT5Z6BsHS
	1cSli6j/yscV2AoSOvr9OL16ueloipR62AFNbODozqtxqxLQffNaFAS9pSar+Os63OzND9tnxk5hV
	UZhFyHiZv2J6Mcy6B7+Z3A5mNTyX676YmYdbTjHd/pWFAU9XfUU5RKQFoT1D+zps8fH0XbTsx1Xmg
	5x02M5Lb3jlHnyoylkKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llRFR-003nz0-Tg; Tue, 25 May 2021 07:13:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llRFO-003nxY-VB
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 07:13:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621926779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFrLKjx227jLbVbX0QuAMdsMDPH43Of7iC/2lHJE1RM=;
 b=cnuk98THGytIPMklHLkASVx3uVxo8jS8XpVUZatQLOfnWtLA11EHI25tgT1pL1Vz+EwX7d
 8oBSIihU5MS5pueinvNaypCGc86WOou65GAR4M6o5A0ZaW7Tg+GMd4JpwoLaIOiB+WPybT
 UVdlw1Nbn2UHePFitgDN0u4phDd8l4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621926779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFrLKjx227jLbVbX0QuAMdsMDPH43Of7iC/2lHJE1RM=;
 b=e5+zqMx+Xl4i8jMrp5X7spni6sgBQ5571DtYJTJJgsnk/IwUY1Bg91tt62drPHvlzMg3+R
 4HsVgM2ytQzeV7BQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A7853AEAA;
 Tue, 25 May 2021 07:12:59 +0000 (UTC)
Date: Tue, 25 May 2021 09:12:59 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210525071259.j5g7koxqad7hwpkp@beryllium.lan>
References: <20210521144734.90044-1-dwagner@suse.de>
 <20210521145306.ld7jc6alchimyzny@beryllium.lan>
 <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
 <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
 <20210524073703.GA24372@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210524073703.GA24372@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_001303_175600_4310DCD4 
X-CRM114-Status: GOOD (  11.89  )
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

On Mon, May 24, 2021 at 09:37:03AM +0200, Christoph Hellwig wrote:
> I think we should add a sanity check for that and reject the broken
> controller if that is not the case rather than working around it.

Alright. I understood from the spec, that in the non ANA case the NN
field should still be case though?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
