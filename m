Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD65BC982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gxKOYiwnSGccIXUUVnXis4FJuJJCk61rKpucnc5dxhU=; b=fhyXygSxByL0Zjtm/ByKiewac2
	0FSGfC0fSlFQwuL1re/WLB/CtMReH/T5ln8jl7GOlJIfWvJO6X0t3DTq45bY7Mv6h5mCzbFo65oFy
	DFURMwGBKDZvRUGrAxVK9Tdfx9DNMeduARIhbmxutHdwNqNwKB0P9aYUkGhZ/+dzAW/2ZS+JaH1xc
	RWywjCWtpDopOD140JFMXHht3Hkq8SevOufm00Ir+OSo0Xx0j+s1cdU/evHeHKmiTX8xZ0lcX5+56
	beQyKZm/0DPiUJWdCtG1dehXYKv0a6qmgQGtqOPUGymEgsZVD9LtHF22BO52ufCV+QI6r7qKsWLWb
	whQdn/aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Y5c-000000019V4-1Pg0;
	Mon, 21 Sep 2026 07:05:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Y5b-000000019Uw-1GbN
	for linux-nvme@bombadil.infradead.org;
	Mon, 21 Sep 2026 07:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gxKOYiwnSGccIXUUVnXis4FJuJJCk61rKpucnc5dxhU=; b=eInpMJqIGUY8/CXBoS3G2SN6jE
	l7zy97b/EzAe+riGfp91CUw4/K48d+9PzMBZU7zxuZ5D57ocnP3d53IIkUVSQq6vHo881AoTjqW5z
	wmawvnfhZQ78WdgsKvyQeWQDAtk780LDVDBk9kCxYZAnlLOWuCZfiVOyfHR1HATaF3+HEueVpiJki
	a3SQ8Go2s855l57wGm2geF4w4SoY5e/tnygOVQ/kOIzAP244h9+wxCbFdifkX+CL2pCuLNF9IVb3T
	uHr3fHMln/esgwfOgTSdnI1whZpWwTWqPaDGBUXMvlZpxHNFqfoBD4A/CbhEFwHZfAcurGlj/sf9u
	UzpNsvBg==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8Y5N-0000000BuvG-44KC
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 07:05:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E25221BB2;
	Mon, 21 Sep 2026 07:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789974301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxKOYiwnSGccIXUUVnXis4FJuJJCk61rKpucnc5dxhU=;
	b=NmatIp+/fBnuk7Pe7A+/d9hlhCjv9vAunkYLJSbuw1mtOz46g2r79qYApD1o4URjlaVRhv
	3NTJN/rDo5DmXLix0ujtfNsof+ooMgMlKSzZXC4VR3FMg1BnxYJlbmR9qy0Bh5l5Fs3mv6
	rTERMNnTsIgi+Rff1jKea6YzX45Tc9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789974301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxKOYiwnSGccIXUUVnXis4FJuJJCk61rKpucnc5dxhU=;
	b=DyJLhsADhOAIO8d7AdjSDYeP6cxrNaY7GYMNFJwvCoogVBNkpnFp4z0TcxTKLcVcf3iTU4
	tLOdLbXsTaUREoCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789974297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxKOYiwnSGccIXUUVnXis4FJuJJCk61rKpucnc5dxhU=;
	b=O1S/kZZE8fE7L6g5NJi8rmvHG7uo0xQm8izAC37+lyHiWeSCEnKugHZByVxxlF1QxtBexJ
	ebgJx41s4teK15kqXvI1VVALdpIssCNHFJzLgGZCBqp7yJF5MorRIxv1XIvdS26GiH7uUG
	9ZEvGJA7w+U9fR78Aquy4jjv4ivaEP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789974297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxKOYiwnSGccIXUUVnXis4FJuJJCk61rKpucnc5dxhU=;
	b=rIbE3XUPT/NYRlfmYy+CCNaAzmb+tbdNiovE8NSpmsCtZhDzrxQBMVJZPCX4H6V3ohOPEz
	wYkdVwzbWtXekiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D461013793;
	Mon, 21 Sep 2026 07:04:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qb3sIxjXsGp7VwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 07:04:56 +0000
Message-ID: <88046cf7-8c6c-45a2-aabe-68a8c9fff6a8@suse.de>
Date: Mon, 21 Sep 2026 09:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
 <20260918181614.3947933-9-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260918181614.3947933-9-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_080511_870973_EED8E02E 
X-CRM114-Status: GOOD (  15.35  )
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

On 9/18/26 8:14 PM, Mohamed Khalfella wrote:
> A host that has more than one path connecting to an nvme subsystem
> typically has an nvme controller associated with every path. This is
> mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> path should not be retried immediately on another path because this
> could lead to data corruption as described in TP4129. TP8028 defines
> cross-controller reset mechanism that can be used by host to terminate
> IOs on the failed path using one of the remaining healthy paths. Only
> after IOs are terminated, or long enough time passes as defined by
> TP4129, inflight IOs should be retried on another path. Implement core
> cross-controller reset shared logic to be used by the transports.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/constants.c |   1 +
>   drivers/nvme/host/core.c      | 152 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |  10 +++
>   3 files changed, 163 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

