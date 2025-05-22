Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09CDC54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUu2tvAxGUJdCeVnccCqWAoYjCWauMy0PUQ37gdYwaQ=; b=cXaHvPKAwMA/BKZGWFJzLnnxGL
	0dtimwUBC7Rm4SL0cq/FZuqmXZcj8INd/oZfD2mHhFUPutWpk5wR48vUiqVamOWLwK5h4ihaZYBd/
	CUMyZlXvW30iMYCqmOmFVKXRvSHgUzvny4MDi/bJew4Joq1jfnSu85vRxsMtSUPZvfXua8Ax6HcKm
	G1gGRS5d9aF+mI+nPD8A75s0XK5xLZNhq1Pv3qPO7rGg8zmMi957vlMSSTPYkHzQARt72q258GsFm
	mzW2YdNebEdx2ey1cMCiOzXICiHua7unaish/VBJl3byFQD9LBgwfzfdhRhz9qhIBMN0Nu3Qk5aGd
	hLIWkGTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6S0-00000001Bf6-0xCA;
	Thu, 22 May 2025 13:59:12 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6Rx-00000001BeN-3KzU
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 13:59:11 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83AED1F460;
	Thu, 22 May 2025 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUu2tvAxGUJdCeVnccCqWAoYjCWauMy0PUQ37gdYwaQ=;
	b=Sc6TmsmX9EYQK0KAffCif9SmbCyu7EvOC+njEM1inB77vTmZpWLhzdzLIpTXsofsS8lQWd
	GXSwO6KLLe17nsTf3K4Y6HVOEkKgCWkEME05AiKRfvNNE2onojrGSyIcPXvsz3zg+kl0pq
	ghEt0c7CJXUgudOC2gsq4zrMpOl36s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUu2tvAxGUJdCeVnccCqWAoYjCWauMy0PUQ37gdYwaQ=;
	b=32M51D0TPITn6ThDzi7JjYFNbRjfa9z+NnEDRflhjlL3jo98j6sEZQNcxJTAEflmVAVD41
	fnceVO/Rl2RIh8CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUu2tvAxGUJdCeVnccCqWAoYjCWauMy0PUQ37gdYwaQ=;
	b=Sc6TmsmX9EYQK0KAffCif9SmbCyu7EvOC+njEM1inB77vTmZpWLhzdzLIpTXsofsS8lQWd
	GXSwO6KLLe17nsTf3K4Y6HVOEkKgCWkEME05AiKRfvNNE2onojrGSyIcPXvsz3zg+kl0pq
	ghEt0c7CJXUgudOC2gsq4zrMpOl36s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUu2tvAxGUJdCeVnccCqWAoYjCWauMy0PUQ37gdYwaQ=;
	b=32M51D0TPITn6ThDzi7JjYFNbRjfa9z+NnEDRflhjlL3jo98j6sEZQNcxJTAEflmVAVD41
	fnceVO/Rl2RIh8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 679C4137B8;
	Thu, 22 May 2025 13:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bmJ9GKwtL2h+DQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 22 May 2025 13:59:08 +0000
Message-ID: <a67c2d17-216c-4e41-be53-09200f590896@suse.de>
Date: Thu, 22 May 2025 15:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvmet: implement copy support for bdev backed target
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-6-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250521223107.709131-6-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_065909_974213_C77A01A1 
X-CRM114-Status: UNSURE (   8.52  )
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

On 5/22/25 00:31, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme block device target type does not have any particular limits on
> copy commands, so all the settings are the protocol's max.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 52 +++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

