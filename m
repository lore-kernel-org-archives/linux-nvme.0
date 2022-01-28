Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03745C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=64ePvJZYZ4cwxg5EnUXMzmRNBcCOSpJpUMTnUtbyk/Y=; b=lwnR+obNNJpEwI3z9O0N7x3D0F
	/Uie6hS4bF2L7t1Y+J/G/01812nL9OyMT55LMjPnRhBK2S9FgqpBXJmqxnw7xwxo7SWi7TEhf/FSS
	06bGOssL8Xm8Hz77i7EVZSwpmbfvtUnWhQLthyWtpIu1Aw6TvQuSnzI5VrY4DhTbiVZFgcWGpZH8+
	8dG7TQb+sqbSEdnDPTcopDpr85UMSt8bVTMSP1Tnc8WlMtLYCHsOo/6Z5x4VlPWGC0rKFGDqJKko/
	VRMRru3Ys+gIURU8mT2b8IeJgtsp6SLe+eDY2K5jDdH96jtBOmbKSm/Wzh9dkMKcfX140G+xKdvmc
	3sLslWAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDOXf-001VDg-JS; Fri, 28 Jan 2022 10:31:43 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDOXb-001VCL-IJ
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 10:31:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9705E210FF;
 Fri, 28 Jan 2022 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643365897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64ePvJZYZ4cwxg5EnUXMzmRNBcCOSpJpUMTnUtbyk/Y=;
 b=W6JtESqawXB3XcyfJe4qKyopRtdCMXvrCA/zD/5QWjmNmZ/qXIhUXbisdg3JZmtFFvGZ3K
 spfIHHV2xbOVrcJzknGqa/qJ6o1rCS62EyrDepDzvBOLJ40w6xnaIB/npn54yUYAdUaa9r
 oIVE7uTuQAnvuLNTC+XFegMcABR+5zQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643365897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64ePvJZYZ4cwxg5EnUXMzmRNBcCOSpJpUMTnUtbyk/Y=;
 b=4Sz4stspe4sZFG3qXzdQboeK2jshKdjenoMnqVQ8oynaFHKe3Tj1/KdhUHwkmdzqHSq/jV
 dHYoBg/zNCxJ55Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88A9E13D17;
 Fri, 28 Jan 2022 10:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OuYsIQnG82HpHAAAMHmgww
 (envelope-from <dwagner@suse.de>); Fri, 28 Jan 2022 10:31:37 +0000
Date: Fri, 28 Jan 2022 11:31:37 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] nvme: Do not reject dynamic controller cntlid
Message-ID: <20220128103137.zugnrh2bbhkqpaoz@carbon.lan>
References: <20220127133648.8201-1-dwagner@suse.de>
 <20220127171758.GB2266713@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127171758.GB2266713@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_023139_815362_C4893AF9 
X-CRM114-Status: UNSURE (   9.09  )
X-CRM114-Notice: Please train this message.
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

On Thu, Jan 27, 2022 at 09:17:58AM -0800, Keith Busch wrote:
> > +static inline bool nvme_ctrl_dynamic(struct nvme_ctrl *ctrl)
> > +{
> > +	return ctrl->cntlid == 0xffff;
> > +}
> 
> It's probably safe to assume 0xffff is dynamic, but spec suggests we
> check ID_CTRL.FCATT bit 0.

Okay, but this one is only defined for fabrics. I haven't found anything
so far which is equivalent to FCATT bit 0 for memory based transport.

