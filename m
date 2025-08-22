Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9E2CA0FE9
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Aug 2025 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iAGJNZt/SVuXm/6gXKf7y/cvf3/WZOP+sAK7SE94s34=; b=pZ+yqzgovlGuf/WvCXe0hRhVrn
	i92fTPCBfrjPuyFNW86XgLTT5v5rZLizTFArk3BPbWaBCuWgbUuH1qAbLZSvVwLlR8fLkRjB42AJ3
	EaxVLhbSHtO8Nct3O/kSyvFfFRYblcjN5D/9iSj/6Yppu3xBOgD9SfcqX5nPKpvwXewLElIujnTpR
	ORgSHtN9GdPDgtkX+VN5ruR33W4EpMK/tb7/zSajlnSCRUdJhWMU5tD/qHkspOwLxgQPVKzr7uXmF
	6n6tjVApQ6Ukvvx52hMHflLMOLLJO60RBLDfaFG7RQSy4F921d3YCPx9WMUmZSrPIbAVPhMH2YUgG
	UfPBFO4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uphlb-00000003yUs-3aF7;
	Sat, 23 Aug 2025 06:30:19 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upRIj-00000002YV3-3IDJ
	for linux-nvme@lists.infradead.org;
	Fri, 22 Aug 2025 12:55:27 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F04C1F38E;
	Fri, 22 Aug 2025 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755867324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAGJNZt/SVuXm/6gXKf7y/cvf3/WZOP+sAK7SE94s34=;
	b=Wo2D11wjQJ5jK+7tkectyOtW5XK4Ng+0iA0XpKAA9eoiOFXyIabkMKYa9dlWDO7Xg1MpMg
	XKBkIkXjUpZoS/xxhnpcN9ExugYqm1/UwrDETa+DeNSt/jk/DRmRMKMvUTpxmRvfyuGx3H
	ki6PPgfRfmWaxIgnt6STWaRI28BFlkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755867324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAGJNZt/SVuXm/6gXKf7y/cvf3/WZOP+sAK7SE94s34=;
	b=fzUQ4KRihzwadLuz06J2zef7GLhmVRp7Va9lLCFgrESN7IeASqWeywlDPMW7phUhy/VDJV
	tkvgyMDh02pjFNDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755867324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAGJNZt/SVuXm/6gXKf7y/cvf3/WZOP+sAK7SE94s34=;
	b=Wo2D11wjQJ5jK+7tkectyOtW5XK4Ng+0iA0XpKAA9eoiOFXyIabkMKYa9dlWDO7Xg1MpMg
	XKBkIkXjUpZoS/xxhnpcN9ExugYqm1/UwrDETa+DeNSt/jk/DRmRMKMvUTpxmRvfyuGx3H
	ki6PPgfRfmWaxIgnt6STWaRI28BFlkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755867324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAGJNZt/SVuXm/6gXKf7y/cvf3/WZOP+sAK7SE94s34=;
	b=fzUQ4KRihzwadLuz06J2zef7GLhmVRp7Va9lLCFgrESN7IeASqWeywlDPMW7phUhy/VDJV
	tkvgyMDh02pjFNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1338813931;
	Fri, 22 Aug 2025 12:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LkxKBLxoqGhYbQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 22 Aug 2025 12:55:24 +0000
Message-ID: <5cf81b43-b173-4b36-a1df-f40cf395acfa@suse.de>
Date: Fri, 22 Aug 2025 14:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_055525_974728_8FD040B7 
X-CRM114-Status: GOOD (  13.05  )
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

On 8/21/25 14:48, Daniel Wagner wrote:
> It’s possible for more than one async command to be in flight from
> __nvmet_fc_send_ls_req. For each command, a tgtport reference is taken.
> 
> In the current code, only one put work item is queued at a time, which
> results in a leaked reference.
> 
> To fix this, move the work item to the nvmet_fc_ls_req_op struct, which
> already tracks all resources related to the command.
> 
> Fixes: 710c69dbaccd ("nvmet-fc: avoid deadlock on delete association path")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

