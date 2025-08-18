Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5A6CA0EE4
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rp4ChsW415dXiNBk9VNc6AQ81OgEG0DI59aBCyydklU=; b=RFQNYYkYxilL4bnc1jqcDSn4Wy
	xPTpj/fPz+7qdYGSOfjAFZyC+tNa713FOn4f3BVE12Gg6MWwWasuyeJIW5t/wLl5sAMiSm6GSYlMY
	mu5OjHLeD1oq34+TmCW8QKEd3Rs8Ex8Op//fCbMLBAPekpXv0jvRYQQC0AOfOB6AG7+huMxlUVmaH
	td9PompVhe+lQ8JZEGe9aci3GAVOAZQr1mdpMWjxtH+J720ifQse/ng7yEuBezrKgQKQWhlS8A/E8
	ogcqC6DK0VjG7y4fTpaTa7cITx8831jEUOQYKJdi3ls0LTFxGiZJcg9co0/VjHliOZ1iIb0n9RcRI
	q2NPCSEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo074-00000007aB3-07gp;
	Mon, 18 Aug 2025 13:41:26 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unwPz-000000075Q3-3Brd
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 09:44:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28C311F387;
	Mon, 18 Aug 2025 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755510282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp4ChsW415dXiNBk9VNc6AQ81OgEG0DI59aBCyydklU=;
	b=K11VZhuwndZ3kyDFSUeHx6GMyBqHIgeOQoIzNBzhkDSY/DhXs6xEMS285ZH616uZR8yW81
	ICDue5Vl9oCtduKh6nAE7WIAsq/LxGguTwlLm0w6AxOthCkmmQApe5HC9dy8Uh2WWJoqGZ
	bEsjLfuzAFtGjgoEZkfp16bRI//DTfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755510282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp4ChsW415dXiNBk9VNc6AQ81OgEG0DI59aBCyydklU=;
	b=NKC3jmjREoISzxo3nASNMzTJMcO/xoCLWOJGccnx2ZH+m6PBrzKqbXOTNoQMzCnBFKaTpE
	9FsiAr+SyqEq/fDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755510282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp4ChsW415dXiNBk9VNc6AQ81OgEG0DI59aBCyydklU=;
	b=K11VZhuwndZ3kyDFSUeHx6GMyBqHIgeOQoIzNBzhkDSY/DhXs6xEMS285ZH616uZR8yW81
	ICDue5Vl9oCtduKh6nAE7WIAsq/LxGguTwlLm0w6AxOthCkmmQApe5HC9dy8Uh2WWJoqGZ
	bEsjLfuzAFtGjgoEZkfp16bRI//DTfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755510282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp4ChsW415dXiNBk9VNc6AQ81OgEG0DI59aBCyydklU=;
	b=NKC3jmjREoISzxo3nASNMzTJMcO/xoCLWOJGccnx2ZH+m6PBrzKqbXOTNoQMzCnBFKaTpE
	9FsiAr+SyqEq/fDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18C3713A55;
	Mon, 18 Aug 2025 09:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2OOgBQr2omjaPgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 09:44:42 +0000
Message-ID: <5e086767-9c53-42f0-8fce-c23683055e48@suse.de>
Date: Mon, 18 Aug 2025 11:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] crypto: hkdf: add hkdf_expand_label()
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>, John Meneghini <jmeneghi@redhat.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250812221113.313763-1-cleech@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250812221113.313763-1-cleech@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_024443_942123_E1DB0448 
X-CRM114-Status: UNSURE (   5.93  )
X-CRM114-Notice: Please train this message.
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

On 8/13/25 00:11, Chris Leech wrote:
> Provide an implementation of RFC 8446 (TLS 1.3) HKDF-Expand-Label
> 
Looks good, but patches are garbled.
Please re-post as a separate patchset with a cover letter.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

