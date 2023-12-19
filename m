Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BCEC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LlV4EThE5QajqoIuW051/JC+1vZmLfJE/NS9mDkCdU=; b=r/0+O3yFVYd7GbriWVb45YYnIa
	F6uEwS81SYfUHPKC0u2+MlscuVpSGMbFRVWNbs4+MlgzmqeGDuqQ55/7rr/eWZZgbgYeuFbpGY0Iy
	ru2svuS33Q42lPfJ/8+CeMoZJ17324uqzDan9dKfiUjhrVpNkPDI3CHD+uBGKwIGLJ8nzNsxjySSY
	oGAcVamfGnfsOFLFvvScWvxN1phE1lxelCvsZ9GVBpV1sFNjtBOrzRTD6PVV7fB9/GE49/UOXh+na
	QZ/BR18vONkn35AKtFmUD0dZYeGFAJmjO3b5/D84FB6LTRx/45paguODXHao5aYsYyKJW+Gls9ILd
	LKmu2KLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYkZ-00Dw4x-37;
	Tue, 19 Dec 2023 11:59:03 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYkX-00Dw3g-1a
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:59:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D55C3220F3;
	Tue, 19 Dec 2023 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LlV4EThE5QajqoIuW051/JC+1vZmLfJE/NS9mDkCdU=;
	b=g//PLZb+1NBGvOKmcYTjxbNrINWLLGuy24epM2WT06gnyc3UdEEhop/FCgOMBy2JpKUTpa
	hRDkA1UM/0lxS3hd+RD+5rTry/2EUpV8O0vyIrxGNDhJIi5RmitUWcldwrYArHvdQSluRx
	+oKIEZf9xKhB/lLsWGOyx748qWdHcAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LlV4EThE5QajqoIuW051/JC+1vZmLfJE/NS9mDkCdU=;
	b=8eF+dDUy4eK4pIQgEye58M4XVivv7ltAQeQ3rQ3I/USRQXv9FLpvYy4kwbU+TkF+kaCMWe
	aQ8Hn4BaB9CvhTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LlV4EThE5QajqoIuW051/JC+1vZmLfJE/NS9mDkCdU=;
	b=zz0RHkACMN1QgAkT7AdW1FFYHW2orAyl0t+y3jQD+cJCffgk4wGbxBpZiKYOQmXkRXH4Av
	FFI4nriwHh+MIx93YOA+HlwL+K+6CU9DQnD5VpMwBr8aBl94A3Far1Ja+01d1bhQiXnuWX
	sJJCfhHw7qga1VhkWoh6LGooqomhw9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LlV4EThE5QajqoIuW051/JC+1vZmLfJE/NS9mDkCdU=;
	b=2lIkDj1YZG8N81xJOZy6EZAxRtaZY+aVCzxQn+NwOxKw3kRnvVVjILH1P9UKDtAKCc1Khl
	y5LqKthQJix+vCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DEFD1375D;
	Tue, 19 Dec 2023 11:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YLHFAIOFgWV1OgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:58:59 +0000
Message-ID: <91f57dca-99c9-464b-b605-577fdff4a948@suse.de>
Date: Tue, 19 Dec 2023 12:58:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] nvme: add csi, ms and nuse to sysfs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <20231218165954.29652-6-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218165954.29652-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zz0RHkAC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2lIkDj1Y
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.81)[93.85%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,suse.de:dkim,suse.de:email,lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: D55C3220F3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_035901_681673_8134C185 
X-CRM114-Status: GOOD (  16.94  )
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
> libnvme is using the sysfs for enumarating the nvme resources. Though
> there are few missing attritbutes in the sysfs. For these libnvme issues
> commands during discovering.
> 
> As the kernel already knows all these attributes and we would like to
> avoid libnvme to issue commands all the time, expose these missing
> attributes.
> 
> The nuse value is updated on request because the nuse is a volatile
> value. Since any user can read the sysfs attribute, a very simple rate
> limit is added (update once every 5 seconds). A more sophisticated
> update strategy can be added later if there is actually a need for it.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/core.c  |  6 ++-
>   drivers/nvme/host/nvme.h  |  6 +++
>   drivers/nvme/host/sysfs.c | 85 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 96 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


