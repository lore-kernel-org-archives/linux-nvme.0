Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E434C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PBAQKFL51IUJzfGkUivLccmE4hfp9jcr00CR1G31Wmo=; b=1f7Y1j9vSDGIQMwR+PksL0v4v+
	5nOSSZh+5YTqcZq9lo/RJIJhDRGBikDe/1DTmVBAdlFGiTlbrtg9AQKy5T2sOZJ4Euvj3IXjOEaj7
	kXjxCKaa47NnovCfyf58IP6WB8EPZalzRhVerCRHlZ50w87ZT2E6fq0owmgpxCreeu3TCKQYCp4FV
	3gbkEHxtReBjlmpiP6tJn6/NRw+FgDSzDU9CgQE48+uN5gZDKXg0lcpaI/vT0SEUazp0d0CwDjjbf
	l+TaBQcc+Ki7r6DlSrVvQKMq8xomw54DqvcsSK+5vsmHoHRr8jFiwWRo9ebNHlQE/PT21ylVEdlDm
	/fudzWJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYk4-00DvvS-0q;
	Tue, 19 Dec 2023 11:58:32 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYk1-00Dvtp-0v
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:58:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDE7C220F3;
	Tue, 19 Dec 2023 11:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBAQKFL51IUJzfGkUivLccmE4hfp9jcr00CR1G31Wmo=;
	b=ILQXvy/b7RwMLh0Mb0xg05rqmT+xUsltWN3oMpX4Q3THpQuNoJN2zizP1YfF1jgGzzF9eS
	hPkIPk7kbyU/UxUZNgvbz+utNBsKUOwcIHRkk1YCY5/z/7zrbZlD1OElwxXbhtpjQq02MN
	YN6kZ1mT3UnOQUjR+iBTVqhnWflgKXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBAQKFL51IUJzfGkUivLccmE4hfp9jcr00CR1G31Wmo=;
	b=8MdkKCS1JdESuof0F6bXZwHr6ljCqxKdYvKRXDAALMdE4Ij+2SWiexpLgqrpz1O3j3FxCh
	bL6bmr05pIrn1iBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBAQKFL51IUJzfGkUivLccmE4hfp9jcr00CR1G31Wmo=;
	b=ILQXvy/b7RwMLh0Mb0xg05rqmT+xUsltWN3oMpX4Q3THpQuNoJN2zizP1YfF1jgGzzF9eS
	hPkIPk7kbyU/UxUZNgvbz+utNBsKUOwcIHRkk1YCY5/z/7zrbZlD1OElwxXbhtpjQq02MN
	YN6kZ1mT3UnOQUjR+iBTVqhnWflgKXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBAQKFL51IUJzfGkUivLccmE4hfp9jcr00CR1G31Wmo=;
	b=8MdkKCS1JdESuof0F6bXZwHr6ljCqxKdYvKRXDAALMdE4Ij+2SWiexpLgqrpz1O3j3FxCh
	bL6bmr05pIrn1iBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04BD61375D;
	Tue, 19 Dec 2023 11:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aI7HN2KFgWV1OgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:58:26 +0000
Message-ID: <d9742922-cf04-4715-b9c6-067524fd473f@suse.de>
Date: Tue, 19 Dec 2023 12:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] nvme: rename ns attribute group
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <20231218165954.29652-5-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218165954.29652-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.08)[88.01%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_035829_493395_692ACBF7 
X-CRM114-Status: GOOD (  10.37  )
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

On 12/18/23 17:59, Daniel Wagner wrote:
> Drop the 'id' part of the attribute group name because we want to expose
> non 'id' related attributes via the ns attribute group.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/core.c      |  2 +-
>   drivers/nvme/host/multipath.c |  2 +-
>   drivers/nvme/host/nvme.h      |  2 +-
>   drivers/nvme/host/sysfs.c     | 14 +++++++-------
>   4 files changed, 10 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


