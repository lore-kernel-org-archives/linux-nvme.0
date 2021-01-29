Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB800C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 14:18:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9446D64DF5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 14:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9446D64DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RsbhZRAB55O5UE60d9M9QJ9l9XqSHlZ1el2sphiDksE=; b=Vb5c6UicuehMR8R4YNNBXSUBm
	EfmkfaW78RHP0q3yvq8MuMJHDdyCvW+3QA8H1dSkSYtkkCrelrXggUtfMCmdv6xMRTJeobcQ4LX1S
	Yc+2pcgWCtIuIg7vaooxuwQaAehYCKE4PuFoobm+DQGaSV2fLkpMRSW/Rj6UM/ggGkIUZoQtaZY2E
	NSo0nIsHpa4aMQtC/Lj3XSh4qtcY0wl388Bx4yQD5SIXMnbJ+vnLxRVZobKP+vnPsZT7jrwPu7HDi
	xCwNTZyTemYC4CIfsD0BaX42jarvNLcRJhcKCz+cMXIDub7TJrL0WTKIEC7WR3LlA0i3bNqlVkiX9
	0zlBMZG6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Ubw-00068m-1k; Fri, 29 Jan 2021 14:18:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Ubs-00068K-NM
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 14:18:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611929930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Gdcn85ukeBHtKrWG90MaBBVcgHCNgoLYlgakB9HRYo=;
 b=KKbDHUfHD1XzNuvR/bjvRab+P5RCHDYdEVjO8F3lcfqblL1zEjInJ9+qU+gs1YKGbLThHC
 m2+AEETCQvGcZiRujAxZWpOKmQ+EpyWcAubHdVx4v45fFAMqDrZBlGTeiPQaquvRsTSiyn
 5hVKRmJaw3dGX/OjwBG02DAHwhza0y8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A5BE0B1B5;
 Fri, 29 Jan 2021 14:18:49 +0000 (UTC)
Message-ID: <6abf2fd0c4e04b3c11cb5240068200018449309c.camel@suse.com>
Subject: Re: [PATCH 16/35] monitor: reset children's signal disposition
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 15:18:49 +0100
In-Reply-To: <35ef1b10-1d24-f0f3-3af8-2d14d710533c@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-17-mwilck@suse.com>
 <35ef1b10-1d24-f0f3-3af8-2d14d710533c@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_091852_888586_E418268B 
X-CRM114-Status: UNSURE (   7.65  )
X-CRM114-Notice: Please train this message.
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2021-01-28 at 17:54 -0800, Sagi Grimberg wrote:
> No commit message?

I'm sorry. I'll add one next time. For #17 likewise.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
