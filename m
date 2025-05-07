Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B354FC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmeTg3rjXN4MkuoVZrPEg6WRNv22XhbV9ixjF1dT3f0=; b=f3YZjeLh6P3T8VB94cdIIW4L0j
	9qwKgZbuFLJZP/JJ/EA1xDbnpJC6NNFDIeuIxUjIhZLf2QQ8aTAGnPx2CK/qGziK3ZdV7xXE2hnV2
	Dzh3rY1YAWOXGqvnbONzh497GC8dDrTMg92NVi3LOj9ZNvMliunnwqGc4CEc6NX6vUuNBjL42v1jJ
	+w3rA92uWB/czZ9CzMEKOwPUFhT0ivO04i70fgLRqcSDWIU0g4gVi8WVjEGDg/cmbuL0yiYEDFLkL
	aqiDykRXXzK5Kg8JXFgz+2nyrW+X+bmes4jg/J4iZkaa/buC9ei0G5+INk7ZD77FFUy5nU089MiJK
	gQ30sHJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCfvS-0000000Fowx-3JQa;
	Wed, 07 May 2025 14:39:10 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCfJE-0000000Fg1T-3dIM
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 13:59:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FA811F395;
	Wed,  7 May 2025 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746626379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmeTg3rjXN4MkuoVZrPEg6WRNv22XhbV9ixjF1dT3f0=;
	b=LRV1yysshpXdAx6c9h5CeFT6lTzSqNbmC7gOoG+LwE+XxBZvzkH60SPw8hb3diWx9vkFvs
	OpEakw7YHZNpD7kvDSC3FHeaQZi+RGPsrPkgU6dTmdBev6+JhBWxQ+0t+9xiaAA00rWZnB
	Z0H+9UhCysTZdz8P6fYnPGyDRC+wj+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746626379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmeTg3rjXN4MkuoVZrPEg6WRNv22XhbV9ixjF1dT3f0=;
	b=LjXUk3qhq8BhA3N4iw7wucf374BjUoVPRRPlg/a86HfZHV1Ku4MsH4RoKIcXhyRl56kvmG
	5Ij2tK1/f25UH4AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746626379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmeTg3rjXN4MkuoVZrPEg6WRNv22XhbV9ixjF1dT3f0=;
	b=LRV1yysshpXdAx6c9h5CeFT6lTzSqNbmC7gOoG+LwE+XxBZvzkH60SPw8hb3diWx9vkFvs
	OpEakw7YHZNpD7kvDSC3FHeaQZi+RGPsrPkgU6dTmdBev6+JhBWxQ+0t+9xiaAA00rWZnB
	Z0H+9UhCysTZdz8P6fYnPGyDRC+wj+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746626379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmeTg3rjXN4MkuoVZrPEg6WRNv22XhbV9ixjF1dT3f0=;
	b=LjXUk3qhq8BhA3N4iw7wucf374BjUoVPRRPlg/a86HfZHV1Ku4MsH4RoKIcXhyRl56kvmG
	5Ij2tK1/f25UH4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C0E8139D9;
	Wed,  7 May 2025 13:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H0gADktnG2h9TgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 13:59:39 +0000
Message-ID: <8d418b1b-a2bb-46ec-9469-c67bb59be089@suse.de>
Date: Wed, 7 May 2025 15:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/14] nvmet-fcloop: don't wait for lport cleanup
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
 <20250507-nvmet-fcloop-v6-10-ca02e16fb018@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250507-nvmet-fcloop-v6-10-ca02e16fb018@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_065941_063505_B3D3DE9C 
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

On 5/7/25 14:23, Daniel Wagner wrote:
> The lifetime of the fcloop_lsreq is not tight to the lifetime of the
> host or target port, thus there is no need anymore to synchronize the
> cleanup path anymore.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 21 ++++-----------------
>   1 file changed, 4 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

