Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4283CAC597
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Etvx4E3FckDJn+R1HG5ooXUSdnt8hPie7QlMGR01hk0=; b=qH3MiamZMeBsvJ0H6ladm3YuDC
	oCHia6twxjAOuQvKRrN9dK+TQ+LYBfZZLggGtriYtzyAH3miMeqwQ2uwle5m6Zr1OLI0a6lqaJrNQ
	7EUT7wtDpst3ySwE+7h2ADWpFM566XOmzteSAx+h/P772lReV+aQby0D1LoXetXIpJn7D/t57RM9v
	McVo2O6bo77wi948owV+ujB/Myiq/bwxckhVy81h9rRTVmItbZ7NKw0ixMies/Ie53y4qlTKXq26F
	8od/oteiUnAaZfWMpdbzTtXV8q0lKIC3ET9U/HwYoYQtUb8/zogPliiO9SlDm0oyCqYqaMuDfRqBZ
	ihxjEAsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBYd-000000051lp-3eKp;
	Mon, 15 Sep 2025 15:55:59 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBYa-000000051k7-45SQ
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 15:55:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06FB93374A;
	Mon, 15 Sep 2025 15:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757951755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Etvx4E3FckDJn+R1HG5ooXUSdnt8hPie7QlMGR01hk0=;
	b=FdFJp1YEf9Ky3WJyaKVZ/L5H1xvPqebIscIPjrgKXaROttRCUgS56afRsD/RvJ9CXd6S4X
	vjCqOFTz0QbjseAcXEIOFlbZ3eqdYyRfanc27w/aH1WEdJKQvMwQ8e2ytP9JKdB8B18CuM
	ZDw+dKU6i/xf9qLrHNYt/76gxjEVuL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757951755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Etvx4E3FckDJn+R1HG5ooXUSdnt8hPie7QlMGR01hk0=;
	b=FyY0ybGWbFysZ2yvusqLAQvP58ZyRKKwfHBA4GlUAdMIiIXqCLFXTfT9l8/NCs6U0CT+f1
	hlBXz70Gq5VXIqDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757951755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Etvx4E3FckDJn+R1HG5ooXUSdnt8hPie7QlMGR01hk0=;
	b=FdFJp1YEf9Ky3WJyaKVZ/L5H1xvPqebIscIPjrgKXaROttRCUgS56afRsD/RvJ9CXd6S4X
	vjCqOFTz0QbjseAcXEIOFlbZ3eqdYyRfanc27w/aH1WEdJKQvMwQ8e2ytP9JKdB8B18CuM
	ZDw+dKU6i/xf9qLrHNYt/76gxjEVuL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757951755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Etvx4E3FckDJn+R1HG5ooXUSdnt8hPie7QlMGR01hk0=;
	b=FyY0ybGWbFysZ2yvusqLAQvP58ZyRKKwfHBA4GlUAdMIiIXqCLFXTfT9l8/NCs6U0CT+f1
	hlBXz70Gq5VXIqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 560871372E;
	Mon, 15 Sep 2025 15:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1rHmEgo3yGgkCQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 15 Sep 2025 15:55:54 +0000
Message-ID: <a83f1c78-8fb8-456b-949a-6ed0b71bd7ff@suse.de>
Date: Mon, 15 Sep 2025 17:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
To: Keith Busch <kbusch@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, trondmy@hammerspace.com, anna.schumaker@oracle.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org
References: <20250731180058.4669-1-okorniev@redhat.com>
 <20250731180058.4669-4-okorniev@redhat.com>
 <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
 <aMg0jDkXOd8E7Ihj@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aMg0jDkXOd8E7Ihj@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_085557_157057_39FA19C6 
X-CRM114-Status: GOOD (  12.90  )
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

On 9/15/25 17:45, Keith Busch wrote:
> On Fri, Sep 05, 2025 at 12:10:21PM -0400, Olga Kornievskaia wrote:
>> Dear NvME maintainers,
>>
>> Are there objections to this patch? What's the path forward to
>> including it in the nvme code.
> 
> Sorry for the delay here. This series is mostly outside the nvme driver,
> so we need at least need an Ack from the networking folks if we're going
> to take this through the nvme tree.
> 
I would opt for taking it through the networking tree. For NVMe it's 
'just' a stub (ie erroring out on TLS alerts), so really we're not doing
much with the information.

Olga? Chuck?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

