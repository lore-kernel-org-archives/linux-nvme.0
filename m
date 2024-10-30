Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFE2D7495E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 07:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yJbEQLCnBR4SQzKuyEWmPij4myoczMGRr3HlpJmFdRw=; b=Mp+7KaDkv7nwC77nVDw2vOHG4s
	CBdhyMShunqO+Nj+Jk4KcxSZNh/l3VadQcA5mG1cEi20YT1N/47iaE6ogWMVfM5iro/uRCST/P6BS
	OV1tydOAmqPed5/vRTAHkTm1f1l6Bkj+F6PQG4mHG7LJkUQIdy91Q+fNOMtmGdOvX5t+NMuffudSW
	DihQ9VSLdi63sUezlVoK4m9PBJH+2A2FX8oXnu3fwNeDyuNYOhvIqvROQ2ui3M4/GLf8Ua1dLa391
	BuGO9uf3Mtm7KfB+dYb6SlJ7RNf1FjmVD3Ijdg3avQ7byw7SDCEwq8UFCKqbMGOMFB52SQEjH8vm5
	MOu2/dAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t630y-0000000H7bn-1GKm;
	Wed, 30 Oct 2024 07:21:12 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t630u-0000000H7ah-0Anz
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 07:21:11 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AECCE1FB86;
	Wed, 30 Oct 2024 07:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730272864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJbEQLCnBR4SQzKuyEWmPij4myoczMGRr3HlpJmFdRw=;
	b=iZ122eRgsRSmTYuESqh4+JG7S2netIatdn8BRzBrgJ16C7Fv587MxeKf1gcUyCNFx3/N2k
	KuxIjLEGYLUTy7h/7rYhP6EQ/y86Q6T6Dw68Mc7Ys3QTg+nwic5KfyhcsPQ6iVj8VFfVZ6
	jSX8vCQXI0LR+T0K70qzjYopywiPXuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730272864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJbEQLCnBR4SQzKuyEWmPij4myoczMGRr3HlpJmFdRw=;
	b=gPmBNM/Z3KJpEZu5iOERipfHjbFXR6Y4p9Wc/cSLPW05rUH45JVi68WjkjgC2Cl1mhHBLs
	uUETwPwiXVQ7GhCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730272864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJbEQLCnBR4SQzKuyEWmPij4myoczMGRr3HlpJmFdRw=;
	b=iZ122eRgsRSmTYuESqh4+JG7S2netIatdn8BRzBrgJ16C7Fv587MxeKf1gcUyCNFx3/N2k
	KuxIjLEGYLUTy7h/7rYhP6EQ/y86Q6T6Dw68Mc7Ys3QTg+nwic5KfyhcsPQ6iVj8VFfVZ6
	jSX8vCQXI0LR+T0K70qzjYopywiPXuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730272864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJbEQLCnBR4SQzKuyEWmPij4myoczMGRr3HlpJmFdRw=;
	b=gPmBNM/Z3KJpEZu5iOERipfHjbFXR6Y4p9Wc/cSLPW05rUH45JVi68WjkjgC2Cl1mhHBLs
	uUETwPwiXVQ7GhCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FF8E13AD9;
	Wed, 30 Oct 2024 07:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kVQfIWDeIWdRfgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Oct 2024 07:21:04 +0000
Message-ID: <ae95fb38-8290-419f-aff8-b2964c9dc4f7@suse.de>
Date: Wed, 30 Oct 2024 08:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 04/13] nvme: introduce wwnn/wwpn helper
 functions
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
 <20241030065149.2297405-5-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241030065149.2297405-5-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_002108_255135_B88AFF47 
X-CRM114-Status: GOOD (  10.91  )
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

On 10/30/24 07:51, Shin'ichiro Kawasaki wrote:
> Commit "nvme: sanitize transport parameter in _create_nvmet_port()"
> modified the wwnn and wwpn names for fc transport to calculate from the
> port ID. It also moved the timing to set the global variable
> def_host_traddr based on the wwnn and wwpn from _setup_nvmet() to
> _create_nvmet_port(). This move made _nvme_connect_subsys() fail
> to refer to the def_host_traddr variable, and caused nvme/003 test case
> failure.
> 
> To avoid the failure, do the wwnn and wwpn calculations both in
> _create_nvmet_port() and _nvme_connect_subsys(). Introduce helper
> functions to calculate wwnn and wwpn.
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   common/nvme | 63 +++++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 44 insertions(+), 19 deletions(-)
> 
Hmm. This was not what my patchset did.

In my patchset I changed the 'logical' FC port setup in using _always_
the same local wwpn/wwnn, and only have the remote wwpn/wwnn modified 
with the port id.
That way the host_traddr can be kept global throughout the code, and
we can calculate the remote wwpn/wwnn when creating the FC ports.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

