Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46D2C369C2
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 06:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8/uNX/eXsoai1a0BEvF6HRYsx3oTLrK378mwz2sk/hk=; b=3OLraq7hAicGmAi5zFb/rqJ7Er
	6FLP+cOQXhwasQeXboyrA2SQsGyA50mflWaFALDedcwC9nSwZd2rrKk85MmpU2JkR1RKhWIMQtbwD
	ojSag/e/GZiYMUBMadkwHbtHi2h7mnje+wHgqzpO0N46aVUyxqE7pa2BPa+xdqBxXLv5a7Wp8mHS+
	G9Gz20gF6LP96ZLvjkVuA0eD0vWEWP9Y8k1JkKjg4erlIynutxMlYOwDwuXO+iASUNMYPVq9ZCpit
	oeuNHbuGMJcAQQ0Upc4dlmcty4PulW7m+Wr9mi/lP6Ld5B185UD81FMRJLWozkJx4G3P2TeBIaypn
	yC+Sbxhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBpGj-00000006WE7-1dE1;
	Mon, 05 May 2025 06:25:37 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBpFu-00000006W7E-3ZZj
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 06:24:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D10E21293;
	Mon,  5 May 2025 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746426283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/uNX/eXsoai1a0BEvF6HRYsx3oTLrK378mwz2sk/hk=;
	b=soqsISnQWBRjyxyKJQqbc1rHXpOteaIJ5jQG33qX5rfSFR1GgAxsOTLzt6yHblSMB94R2h
	WGiWegpQUNf0Ygv+XuqOKFZwXhLGAHiQ029I/a3H+lDz4XDA8xoPcFPdim9JmlIp4Am6Bn
	D3hAWPlFVocGuahj4b79cyjyZ/icEPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746426283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/uNX/eXsoai1a0BEvF6HRYsx3oTLrK378mwz2sk/hk=;
	b=Vlv10y4lFLFVbronsoKHJMIIrXOfBO8k1Tig19DxXhljVtMDe1VmIOD7dU7D86RcLZfCmy
	8dE5CBSJda3vgnBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=soqsISnQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vlv10y4l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746426283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/uNX/eXsoai1a0BEvF6HRYsx3oTLrK378mwz2sk/hk=;
	b=soqsISnQWBRjyxyKJQqbc1rHXpOteaIJ5jQG33qX5rfSFR1GgAxsOTLzt6yHblSMB94R2h
	WGiWegpQUNf0Ygv+XuqOKFZwXhLGAHiQ029I/a3H+lDz4XDA8xoPcFPdim9JmlIp4Am6Bn
	D3hAWPlFVocGuahj4b79cyjyZ/icEPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746426283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/uNX/eXsoai1a0BEvF6HRYsx3oTLrK378mwz2sk/hk=;
	b=Vlv10y4lFLFVbronsoKHJMIIrXOfBO8k1Tig19DxXhljVtMDe1VmIOD7dU7D86RcLZfCmy
	8dE5CBSJda3vgnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36A9613883;
	Mon,  5 May 2025 06:24:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0qCCCatZGGhANAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 05 May 2025 06:24:43 +0000
Message-ID: <0d3378d0-4546-4898-94df-fcb788f31dc5@suse.de>
Date: Mon, 5 May 2025 08:24:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 2/3] nvme: introduce multipath_always_on module
 param
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250504175051.2208162-1-nilay@linux.ibm.com>
 <20250504175051.2208162-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250504175051.2208162-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D10E21293
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250504_232447_175559_DCA11B1B 
X-CRM114-Status: GOOD (  12.01  )
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

On 5/4/25 19:50, Nilay Shroff wrote:
> Currently, a multipath head disk node is not created for single-ported
> NVMe adapters or private namespaces. However, creating a head node in
> these cases can help transparently handle transient PCIe link failures.
> Without a head node, features like delayed removal cannot be leveraged,
> making it difficult to tolerate such link failures. To address this,
> this commit introduces nvme_core module parameter multipath_always_on.
> 
> When this param is set to true, it forces the creation of a multipath
> head node regardless NVMe disk or namespace type. So this option allows
> the use of delayed removal of head node functionality even for single-
> ported NVMe disks and private namespaces and thus helps transparently
> handling transient PCIe link failures.
> 
> By default multipath_always_on is set to false, thus preserving the
> existing behavior. Setting it to true enables improved fault tolerance
> in PCIe setups. Moreover, please note that enabling this option would
> also implicitly enable nvme_core.multipath.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/multipath.c | 72 +++++++++++++++++++++++++++++++----
>   1 file changed, 65 insertions(+), 7 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

