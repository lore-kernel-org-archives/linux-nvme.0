Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81970C48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1m0zTcQVE87GlJP7/ISMt7U2bx0NFQf4k25N4z9hJGc=; b=x6+jT5qsUb4x7k02uQr5vnHzEv
	vYY8Ll66RQ2aNTqvwsTfelYFzXSv8W7azSjtEUfuhay4W82F5/5WKredt3EHUq2RhCmakjET6LeL4
	BbrHmdHxRn65OvFyqVOjqk3/ej1mdE/JP/7ROqbtUeBixUEOmsrFuEai5bjfOdTL9+F+9Df74smaY
	IHsiema7CAPGQ+619Ky+NOUELA5yua8E6nT40ta7No7LxT7UjrSLLMEetF4rR6sjhmJ0h+ExKXcRd
	axH2oXFsxlRzKZkP5eNiMpCvGyfFukq/wmd8kaRrvqpq5nier91cuMlRn1/uO/Vp9KzT0Hxz+OHTY
	kw5b7BCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZrTp-000000096QY-0XM5;
	Tue, 13 Feb 2024 12:01:41 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZrTk-000000096OX-1f1C
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 12:01:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A22D022203;
	Tue, 13 Feb 2024 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707825694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m0zTcQVE87GlJP7/ISMt7U2bx0NFQf4k25N4z9hJGc=;
	b=SzcpL8yjaEmzoorxZYybEkQHaCSAcTpSsnJBBG2UdZBzixjxGRranSsHoVlll+hPy6gjIS
	K0Zs2H7Ts5EYujyPSr4Sqe9csuw5k4FUePWfpdg7F2AYJES+AJPW+BcH18BGB4cf/md2Gp
	pvW3z7CXJmfsAFTHNkm7A9uV76JTfrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707825694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m0zTcQVE87GlJP7/ISMt7U2bx0NFQf4k25N4z9hJGc=;
	b=VL9EBwwiRInkQE6B45kxAJheNLyG1hPcmhTHDXhkPKzWTCUwvFs8d8O5QAKdalIUC+kJ3f
	xdS+wh2vg/f8kICA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707825694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m0zTcQVE87GlJP7/ISMt7U2bx0NFQf4k25N4z9hJGc=;
	b=SzcpL8yjaEmzoorxZYybEkQHaCSAcTpSsnJBBG2UdZBzixjxGRranSsHoVlll+hPy6gjIS
	K0Zs2H7Ts5EYujyPSr4Sqe9csuw5k4FUePWfpdg7F2AYJES+AJPW+BcH18BGB4cf/md2Gp
	pvW3z7CXJmfsAFTHNkm7A9uV76JTfrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707825694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m0zTcQVE87GlJP7/ISMt7U2bx0NFQf4k25N4z9hJGc=;
	b=VL9EBwwiRInkQE6B45kxAJheNLyG1hPcmhTHDXhkPKzWTCUwvFs8d8O5QAKdalIUC+kJ3f
	xdS+wh2vg/f8kICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C48A1370C;
	Tue, 13 Feb 2024 12:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0HUdBh5ay2UaAgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 12:01:34 +0000
Message-ID: <83b5a7ec-da7a-4520-973c-bbc3131693a5@suse.de>
Date: Tue, 13 Feb 2024 13:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] block: pass a queue_limits argument to
 blk_alloc_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240213073425.1621680-1-hch@lst.de>
 <20240213073425.1621680-9-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213073425.1621680-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SzcpL8yj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VL9EBwwi
X-Spamd-Result: default: False [-5.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.87)[99.44%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A22D022203
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_040136_623280_FE511ECF 
X-CRM114-Status: GOOD (  11.82  )
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

On 2/13/24 08:34, Christoph Hellwig wrote:
> Pass a queue_limits to blk_alloc_queue and apply it after validating and
> capping the values using blk_validate_limits.  This will allow allocating
> queues with valid queue limits instead of setting the values one at a
> time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-core.c | 26 ++++++++++++++++++--------
>   block/blk-mq.c   |  7 ++++---
>   block/blk.h      |  2 +-
>   block/genhd.c    |  5 +++--
>   4 files changed, 26 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



