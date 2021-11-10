Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBF3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 10:33:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF495610A8
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 10:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF495610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uxj3iZ+1Kns9ZZLvGJ0djujxKcWE9jkByIFZt1w07yA=; b=jzxpCkPsccBKotdtIT+hJD68wy
	9L6e0iwSZOhmACLvUuZPtHFByKO5r5+zyA07sR+/95Np7wpVifgdH4Ncc7jHF7Xbfq/1gvOjCT5yw
	h8qOwLfPiilPxkBbwg+THIpMiBHhmwZ7hmlRcogTkXjrBX4TDxcdKKR95ZXq+wo0E41D15juaekkM
	Bq7JOOIvGjqkQ6OGHZw2/8Fe/rGDCA1owLnFm3BoU9xxt9Pno5zlWklXn/EQcRCQD5AZQaREkv6JM
	NYS/iL7ug2ERTH1utPrM8/QBJ8x27LHXayStSu4yz30qonvsd2LzvPUFuU13hZw/cPFmKoPIUtOqS
	RNPX9hBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkkuU-0058R8-Ly; Wed, 10 Nov 2021 10:32:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkkuR-0058Ob-8p
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 10:32:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0E7B1FD6B;
 Wed, 10 Nov 2021 10:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636540367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uxj3iZ+1Kns9ZZLvGJ0djujxKcWE9jkByIFZt1w07yA=;
 b=UTAi0uDgMGwEG2sweTLzY5CXUZxsi5QiiqbKpNU7gFaAcTJKfD4QjKOm5qBsTK33XBj9op
 fLgKh1seSv3aNtNSYmqxNrQUg7pZQJ8nwMmcX7K+8NgvPofWa4sxTUFJ6Bt92m4Aj3Soqm
 4vPPZhGNB08J8PEO/8AwTumtCXbWOvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636540367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uxj3iZ+1Kns9ZZLvGJ0djujxKcWE9jkByIFZt1w07yA=;
 b=wIwRNbkLEPmR9nLgy7CtlrmlzkmNCObZBtUWbfrOjXWl9SkClTkWSJV7OBLxVL+HNaWYJD
 nTnNI+8R6/tARZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8076A13B7F;
 Wed, 10 Nov 2021 10:32:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aglPH8+fi2H9OQAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 10 Nov 2021 10:32:47 +0000
Date: Wed, 10 Nov 2021 11:32:47 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me,
 chaitanyak@nvidia.com, oren@nvidia.com, benishay@nvidia.com,
 borisp@nvidia.com, aviadye@nvidia.com, idanb@nvidia.com,
 jsmart2021@gmail.com
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Message-ID: <20211110103247.i7jnkg3bpbet42wm@carbon.lan>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_023251_477728_82D30253 
X-CRM114-Status: GOOD (  10.43  )
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

On Tue, Nov 09, 2021 at 02:08:27PM +0200, Max Gurtovoy wrote:
> We also don't know the target that cause the bug in the initial genctr
> commit..

As I was the one asking for this feature: During development phase we
saw invalid cmd_id from a (buggy) target. The target has been fixed. It
never got released to the public.

