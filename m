Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ED9C83F01
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Aug 2023 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQgATRv0Yi8dSOXsizpcql2/oe40FoEEth/0M4vOQzM=; b=ugzAYSpRvHEvizdmplpCgFC7ts
	2FZtBp4StoVTYF+V+oyNKnVxSczxzGKpxWCb+50dWjzOEzbKTgnAoFSpc05LaLI8K7cKKHFA3Wohj
	3zjj1ZgZ5sWZtSHm4H3PiSXbw1TSAlnWzszbiA13xoHxwlPNZ6UyCof+RANg9hrkYTV7JF7vYEqt8
	h8f1D+J6zUIS2AXfnPMty67k7XW0XBL1UrydbpBcem2yeWQyCfgbvzqKvBAvbEFA0KawKF6LbRgfV
	MGIgb+Z9D7M8pZVi37wtbi0xycpHVmI5J2k8cbJ7gSs5XtNzqKmzm5TtMLOzFFUsPseb7qWzLe+FR
	AvCzoxeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbMln-00DjVN-1S;
	Wed, 30 Aug 2023 15:06:11 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbMlg-00DjU6-3A
	for linux-nvme@lists.infradead.org;
	Wed, 30 Aug 2023 15:06:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53E271F74B;
	Wed, 30 Aug 2023 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693407960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQgATRv0Yi8dSOXsizpcql2/oe40FoEEth/0M4vOQzM=;
	b=i74ke5EYmN+nuBvfIpv5fQssIN/iuwRGjWUWPuvhq4yxm0U6tFvN5uHv1WDVVwblXr7u7L
	5NIcfJXMboFmwLmsOVTLumnuwmLMel9y3IKHj8dt+l3J/XF7G/mld86ZE06xzjNboH/8P+
	oyted/cJUQeM/7Clf1H9A6UE0NweGMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693407960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQgATRv0Yi8dSOXsizpcql2/oe40FoEEth/0M4vOQzM=;
	b=9GX8ofwxXSF4PgfWcK3B9cLiDA031+L2dIToWIlgI4jgwZr8uZzr0FrILvEhqMBnympM9z
	ZdE3Es6JtcsS+WAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43C741353E;
	Wed, 30 Aug 2023 15:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id woJ9ENha72T7IgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 30 Aug 2023 15:06:00 +0000
Date: Wed, 30 Aug 2023 17:06:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v4 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <c36hdvkw2ia5g2e6k2jkagux3by453stigjoik2wf7neinfrew@t35ny54nn7gt>
References: <20230830092019.9846-1-dwagner@suse.de>
 <20230830092019.9846-4-dwagner@suse.de>
 <fhwbcvhmm57c55ozfgtczcix42zri63cswjavre46l42tmzgo7@3krpokexbslw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fhwbcvhmm57c55ozfgtczcix42zri63cswjavre46l42tmzgo7@3krpokexbslw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_080605_161832_EF7C0C52 
X-CRM114-Status: GOOD (  13.84  )
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

On Wed, Aug 30, 2023 at 01:38:03PM +0000, Shinichiro Kawasaki wrote:
> > diff --git a/tests/nvme/018 b/tests/nvme/018
> > index 68729c3cb070..19e439f3f3e0 100755
> > --- a/tests/nvme/018
> > +++ b/tests/nvme/018
> > @@ -21,16 +21,9 @@ test() {
> >  
> >  	_setup_nvmet
> >  
> > -	local port
> >  	local nvmedev
> >  
> > -	truncate -s "${nvme_img_size}" "${def_file_path}"
> > -
> > -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> > -		 "${def_subsys_uuid}"
> > -	port="$(_create_nvmet_port "${nvme_trtype}")"
> > -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> > -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> > +	_nvmet_target_setup
> 
> As I noted for v3, I think the line above should be,
> 
> 	_nvmet_target_setup --blkdev file
> 
> If the change is ok for you, I'll add this fix up and apply the
> series.

Sorry, I didn't see it in the response. Sure thing, no objection from my
side.

