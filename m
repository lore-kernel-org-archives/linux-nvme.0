Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C74DC3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 06:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eB/u0ZTlPX+YZObQGncZtGwwHoboXsssQbVeUBR0mc8=; b=4BQWmpc6ww8YDTRbuzXu6y23At
	WTV5N1G7eQ51rCTEaJXs0xbJqHjQX3kdjmji8i6qSaYDBJSFvl69kQP/OI0MgXpAvZyy6p7/IpzLF
	UK4fCZypvUGce7Rde2pQg7qXhVwDz3TpBz7CKx5fq+tfM1M1jhWnaViY7yuwVtAujwDQz4Wa9ITvg
	7LDYYy3rOibn1GyMV2B7AS2yHf+jNYe+zsgawhpctz8+Oz9vuEAtv7eQ6XI60uH6QZjc/gFE4O6t5
	TPVxFtF8QhZWIfuc5SlYTNK/ksq40hugkMX7bPTFieS8p6qyS4QXDfQrw60oMfokP9/ngp3wD+OcO
	afg+rHGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUh6W-00000001oF9-2Ozk;
	Fri, 19 Jul 2024 06:28:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUh6S-00000001oEO-2fNK
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 06:28:31 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB7202189C;
	Fri, 19 Jul 2024 06:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721370507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/u0ZTlPX+YZObQGncZtGwwHoboXsssQbVeUBR0mc8=;
	b=MmQERhQUvwJd5ThS+9bBTyjkuEvOaWBt437lxgjVG5h5DywEw7rYF0YdozVZG50XsdCRwk
	h4RSdxMgrwPBMBnJcYOHokpaDo+90zTwEhdKe70UC5j6nEchf/WhzFEgAn1xtPIjxmJoaw
	el7IfZeQSZTZuUgxCaWvnCDy9nVjLCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721370507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/u0ZTlPX+YZObQGncZtGwwHoboXsssQbVeUBR0mc8=;
	b=mgsPp+kIBYw9nkS8oMLQ6OjjRJpp1RgBuhCqKIIuwNePkLDFkybdrJrfkF8GGcRJDAE+8E
	OdJz/PTM8NNopYBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721370506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/u0ZTlPX+YZObQGncZtGwwHoboXsssQbVeUBR0mc8=;
	b=i7nmXu9w/OSW9dGFbrJsgvse/S04zvFcPvCMsTu0zU+ljpnFjWwhOhqeFMLvb0mgzQn2S5
	hRH/QJSJkIOthZKPjYAx5COJbm9K600dc8exPXU/xgV4z8UC9OjTT/Vr7XxEgGPMVBhlFV
	iwWoG+fVkfi5B9bHKHj2GTims0YSJLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721370506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/u0ZTlPX+YZObQGncZtGwwHoboXsssQbVeUBR0mc8=;
	b=UehNu/3Kgr3YijA81JSZyCRGf9DpeLTIWI3v5pN45JPNnMb/jlcdczd80GDsDYclnLbZDP
	x7WyMhNgaF+GOXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A53A9132CB;
	Fri, 19 Jul 2024 06:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9txzJooHmmY6EwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 19 Jul 2024 06:28:26 +0000
Message-ID: <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
Date: Fri, 19 Jul 2024 08:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Ping Gan <jacky_gam_2001@163.com>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240719053116.GA21474@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240719053116.GA21474@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[lst.de,163.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_232828_850811_559106CD 
X-CRM114-Status: GOOD (  14.64  )
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

On 7/19/24 07:31, Christoph Hellwig wrote:
> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>> When running nvmf on SMP platform, current nvme target's RDMA and
>> TCP use bounded workqueue to handle IO, but when there is other high
>> workload on the system(eg: kubernetes), the competition between the
>> bounded kworker and other workload is very radical. To decrease the
>> resource race of OS among them, this patchset will enable unbounded
>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>> get some performance improvement. And this patchset bases on previous
>> discussion from below session.
> 
> So why aren't we using unbound workqueues by default?  Who makea the
> policy decision and how does anyone know which one to chose?
> 
I'd be happy to switch to unbound workqueues per default.
It actually might be a left over from the various workqueue changes;
at one point 'unbound' meant that effectively only one CPU was used
for the workqueue, and you had to remove the 'unbound' parameter to
have the workqueue run on all CPUs. That has since changed, so I guess
switching to unbound per default is the better option here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


