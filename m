Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9E1C369D3
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 06:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9VPilbHRhk/K5ZBOCPJOvfextA3nm+QGqvwc1ZzV5TM=; b=bNjq9y4V8+9D6MBzfsrTHlQ1gK
	1LBmDcDVIDnDWP6ziW61tgdy9I1tXf6KqZWdbLp/LW9e/Io9rHeSJ5BdtGAe/vckbLUGHDs6Zch4s
	h/f7XQqmYaXd3aMq6x+9obuOcyke6Sp3q872cXVQDczPbpx0J1Ca8+FtyUiCsOIIT3B6o2qSlKpXE
	H/8CofMoBpQLxn0j/8zAZRWXVEi3GKaWMHNEPiXH8+DXTrgTfQmnotjUQvcW3cYp56V0BsiJ6TF3l
	xptUcP/SDSo/cdIzD3PBCX1GATluzVMsNON0v14/gQMS7Lo9vjXvcerZvS0kWlt1XSJvC/SGSzEV7
	n5Daphsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7U15-00000009PQX-1Rzk;
	Wed, 23 Apr 2025 06:55:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7TUG-00000009KZq-3OYj
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 06:21:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBC23211AC;
	Wed, 23 Apr 2025 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745389295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VPilbHRhk/K5ZBOCPJOvfextA3nm+QGqvwc1ZzV5TM=;
	b=X7Tb+4sc7oYXND0gqmrAIbZJesKIuL30YKbKYHRx+y12CsFOeB9+TVa/GLRwIyhcbbD78o
	6Hti29YjdZNfDFD9Cr+j5+OwhiibXqDjPfaViuWXzFXR3YMl821pknaLuqbV259NR0BJ53
	37zj55ZTLuUhDdp1zVuxQozN/3UoTRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745389295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VPilbHRhk/K5ZBOCPJOvfextA3nm+QGqvwc1ZzV5TM=;
	b=8ah17k4tlHNGLNyFsInWpEMI06n1G/oYmvYHOQ73tFJVOEzvbbbTNbuufkVhzoi1m4litV
	CGX5muDiEH5K61Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iBMizeFU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/43G+4pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745389294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VPilbHRhk/K5ZBOCPJOvfextA3nm+QGqvwc1ZzV5TM=;
	b=iBMizeFUGVmXg3/TYWINQZTpv1Vm+4mUS6BZepdRTDLs+WAZ+VcBeZCC4sVt2j96u7eXKK
	ageVRzjrXZB+bWOrdoiR/CwFsxW6GDRcTHC9PcGJSXL0WhBYEhOgJhZyvnL2fNXJ0g6Xa8
	dDs7kzqx7RgDXzP8yiyFaqCtc+073Ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745389294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VPilbHRhk/K5ZBOCPJOvfextA3nm+QGqvwc1ZzV5TM=;
	b=/43G+4pWMt7toMjzbn4SdHmsBSPj+7t3F8HAu1PnEI5uLu1JOuQWi+pvHqhfyQhKVHQtZS
	50olcOPJd/CyOBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8683C13691;
	Wed, 23 Apr 2025 06:21:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fY6rHu6GCGisUQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Apr 2025 06:21:34 +0000
Message-ID: <ed993f55-bdfc-4376-951d-9af4a4f461a9@suse.de>
Date: Wed, 23 Apr 2025 08:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: don't restore null sk_state_change
To: Alistair Francis <alistair23@gmail.com>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, csander@purestorage.com,
 shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250423060621.632581-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250423060621.632581-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EBC23211AC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_232136_999240_DA06C40E 
X-CRM114-Status: UNSURE (   9.67  )
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

On 4/23/25 08:06, Alistair Francis wrote:
> queue->state_change is set as part of nvmet_tcp_set_queue_sock(), but if
> the TCP connection isn't established when nvmet_tcp_set_queue_sock() is
> called then queue->state_change isn't set and sock->sk->sk_state_change
> isn't replaced.
> 
> As such we don't need to restore sock->sk->sk_state_change if
> queue->state_change is NULL.
> 
Good catch!

[ .. ]

> Resolves: https://lore.kernel.org/linux-nvme/5hdonndzoqa265oq3bj6iarwtfk5dewxxjtbjvn5uqnwclpwt6@a2n6w3taxxex/
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> We could also remove the `sock->sk->sk_state != TCP_ESTABLISHED` check
> in nvmet_tcp_set_queue_sock() if that's prefered.
> 
Please do.
We cannot influence what the network stack did, so if there ever were a 
modification which caused the ->state_change callback _not_ to be set
the whole issue pops up again.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

