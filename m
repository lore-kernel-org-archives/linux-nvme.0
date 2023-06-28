Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF55EB64DC
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 05:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sI2fzc8FIgVRp6/0G7OEBOQsc7dDWyTTvRQA68GkrJE=; b=DeUm7+cXU3n8LYFTSfnx4DIsnh
	xfMoU6PhzqQtnvvUDMr2YfGegjHcRMD3uMMsIs8sg83EeGGDM6kgllFMc7gOn8LdYud3cTDIk0lxg
	xcDyYyVqcFMfwt4C+KBpjEtfu+a7L5yUV/JzfrskR2tsnbdiTeJAt8SA5+hg7H/Qg8zhqG2cQc5tp
	ilWNiU1bJUUDZLx09c2yqb7LupUcyWqgaMOWD5ynNIhd3t39cLW4GE0huje04lBHVnp3JQPn/XrOi
	zuqUHAGI3iBGfCyHTYlu1afDq4zZxYHLgjGdsYun13z6AB7fbrQmGPphkZZbAK4Dq3I2i7uco63wU
	6TT+4Hwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEO6Q-00EtYV-28;
	Wed, 28 Jun 2023 05:52:30 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEO6L-00EtXG-0o
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 05:52:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D4BE1F889;
	Wed, 28 Jun 2023 05:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687931540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sI2fzc8FIgVRp6/0G7OEBOQsc7dDWyTTvRQA68GkrJE=;
	b=k+161G7z8ioudxMwi+XLxMLHq1hwIXR9LVsqtLWJEi98nGOtwRbBAjOGkMOJGCAApQvrHq
	/oePJqE83iHoP0n6hyLQg+owuRj3WfmOA3bj/qDNokZfewoQqWygF3pPxU2dPpzGdbXRiW
	B4KsS1TD10fnSjFpe4NBFEbJSwENhy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687931540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sI2fzc8FIgVRp6/0G7OEBOQsc7dDWyTTvRQA68GkrJE=;
	b=F5z1fUKdECyVhDAIDynzs/DRaJMTBnYpB0wU0CfQbWaEW7ncFZ7+skXJ1EtH6nVcG43fis
	byvA1LRkfTx7cZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B86113483;
	Wed, 28 Jun 2023 05:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /eLfHZTKm2S/CgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 05:52:20 +0000
Date: Wed, 28 Jun 2023 07:52:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Message-ID: <bfkbjiznom3lddrec4skyi7245dff5sohpvitzv6fkaaln6w7t@bery27x4o7qd>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
 <6he5owg5e6h4vq5uwhw7jo3cncwrrlgjdxnq6csr5wlopbwk5c@l434fr2edukp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6he5owg5e6h4vq5uwhw7jo3cncwrrlgjdxnq6csr5wlopbwk5c@l434fr2edukp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_225225_494904_0C28BBD0 
X-CRM114-Status: GOOD (  13.96  )
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

On Tue, Jun 27, 2023 at 10:13:48AM +0000, Shinichiro Kawasaki wrote:
> > +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> > +
> > +	queue_count=$((queue_count + 1))
> > +	if grep -q "${queue_count}" "${queue_count_file}"; then
> 
> Does this check work when the number in queue_count_file has more digits than
> queue_count? e.g.) queue_count_file=20, queue_count=2

The idea is that it should be an exact match. Let me figure out if this does
what it is supposed to do.

 > -	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> > +	hostid="${def_hostid}"
> > +	hostnqn="${def_hostnqn}"
> 
> I guess it's the better to move this hunk to the 3rd patch. Or we can mention it
> in the commit message of this patch.

Good point, I'll move this to the 3rd patch so this change is in one patch.

