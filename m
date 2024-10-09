Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566BACED60C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 06:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1yQSa54OpTxsEjyT43avn9SR6hd1EaptYXueVbG9dBU=; b=DgRJKhdZB/wRR2jWtwZKd1TZ2j
	QMPEMZYDSgpskHD8YpmdRm/by24Q7D45XfCWITRVAw9DqsG/0BDNnmicj6k610BlD0vbpfmQet0QE
	npZRPxFIiCUSV8YIGpherS4ubjReJ7zCUbTHPDvRfUocYS6U+U/ZmsIQZGc3Ty2jMrjasgPM2knpD
	rtpHVGf09ZSacczHAuIKIpI+sfbtJR2DoNJsSp1Xw87buJfHu7gGLsrjzwWvqhgK0CzLnofigvi95
	xrbCcD/miPRkSfzL4KW1PQKusXKI4q6xJY2fULj8Kapetn40BDI0ZLhqZqkcVJG74mTlJ3bNUO6av
	3K4/x96w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syQ2G-000000084iN-3dNk;
	Wed, 09 Oct 2024 06:19:00 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syQ0Q-000000084L6-3x0b
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 06:17:10 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4418D21E4F;
	Wed,  9 Oct 2024 06:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728454625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yQSa54OpTxsEjyT43avn9SR6hd1EaptYXueVbG9dBU=;
	b=scwr3xuq9oZC+0wpE5+v4NnIXxO+TQ9QAwX6v7fctizgArpEm9MGLH1NmCwOLvY65s9af7
	dJnRZ9ximaCSRZpMgw892MEEzf3hcdJWD69vk0FRnMOP/7VIgMSA24ZdVGajODDaOOCrFc
	Mze8jw3XqlVl+xjmqNeDBVfh3y8BpYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728454625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yQSa54OpTxsEjyT43avn9SR6hd1EaptYXueVbG9dBU=;
	b=VxK3l/3Lu6fSvIwJhPZcHg5SOFmiifiH498h/qH0VMCO/9JESDaO36sAmGcOsH7WdTDyf4
	jWNuEOYS9F37vTCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728454625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yQSa54OpTxsEjyT43avn9SR6hd1EaptYXueVbG9dBU=;
	b=scwr3xuq9oZC+0wpE5+v4NnIXxO+TQ9QAwX6v7fctizgArpEm9MGLH1NmCwOLvY65s9af7
	dJnRZ9ximaCSRZpMgw892MEEzf3hcdJWD69vk0FRnMOP/7VIgMSA24ZdVGajODDaOOCrFc
	Mze8jw3XqlVl+xjmqNeDBVfh3y8BpYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728454625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yQSa54OpTxsEjyT43avn9SR6hd1EaptYXueVbG9dBU=;
	b=VxK3l/3Lu6fSvIwJhPZcHg5SOFmiifiH498h/qH0VMCO/9JESDaO36sAmGcOsH7WdTDyf4
	jWNuEOYS9F37vTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4A53136BA;
	Wed,  9 Oct 2024 06:17:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y2QuNeAfBmcnJQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Oct 2024 06:17:04 +0000
Message-ID: <7aba8d61-c68d-49ee-990e-e5c0381296ba@suse.de>
Date: Wed, 9 Oct 2024 08:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: add rotational support
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, kbusch@kernel.org,
 hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-3-m@bjorling.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241008145503.987195-3-m@bjorling.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_231707_153871_B2640269 
X-CRM114-Status: GOOD (  11.84  )
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

On 10/8/24 16:55, Matias Bjørling wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> Rotational devices, such as hard-drives, can be detected using
> the rotational bit in the namespace independent identify namespace
> data structure. Make the bit visible to the block layer through the
> rotational queue setting.
> 
> Note that rotational devices typically can be used to generate random
> entropy, the device is therefore also added as a block device that adds
> entropy.
> 
> Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
> ---
>   drivers/nvme/host/core.c | 5 +++++
>   include/linux/nvme.h     | 1 +
>   2 files changed, 6 insertions(+)
>
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


