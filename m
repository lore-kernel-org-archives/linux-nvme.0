Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E634C3ABC9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JbJTeFA+Rp8jsYIA7TzMagN/M/vKdvhIvOGAT7x5hJs=; b=NksnqtOIArVc6pw86dFnbFMg7v
	WcbwhAxjK/Xt6Pk1AUxs/p9ATpsfKdV4kl+fgBuV0lcU0EWyBZTAPH3uWDx5Pp6kG+HFi1ZBhJPWx
	YthZlz9HelCaCm5V/Cy66iwf6VnIr4Z07Cp2vB8BqGg/KO8x5sx7mGs/WE0bLzPkR2WgRRs+F73ZO
	28SRKKSGLQG2ci19WiMVH/mA7qBmifKl7AvZT6YMe1LU3B/lFnCS3vA0NCegRv2ELGvK0/r07Vc21
	soiGocdLBsQTSeMjd2n+ZEwn4mAavyVxCJ4lFxjNor4GbR+2oVFSI+xm2BQKWP2ddXTLKCFmhtpI2
	bq8ZVr/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEE-0000000Ekah-3c0u;
	Wed, 07 May 2025 08:34:10 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZDr-0000000EXEE-1Y8p
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:29:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C50F12118B;
	Wed,  7 May 2025 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746602981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbJTeFA+Rp8jsYIA7TzMagN/M/vKdvhIvOGAT7x5hJs=;
	b=UFOaoTirkfwpbGanYSQUBGKChEBsxci8cBTDnzU9mPPZBaEUkpMTo2hLGjVgUZsYOt+pD3
	K9dNPg2aOz00OSR8uJjcgIsfG34Rg9YpCswR+RZwk7yngmV4EXn2VHXvbF7Av0b47od5A0
	tPgtNNLB/iOIxspqZn1mPc8PzNTysN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746602981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbJTeFA+Rp8jsYIA7TzMagN/M/vKdvhIvOGAT7x5hJs=;
	b=D0SOPIpvOvSz69hfGU0PZYKG7qqJBrg6Lh0/rUEkz51SrK+5Y/jaSyiik1WsRHfBkGz0uC
	XQ8OetipPrSVPaCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746602981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbJTeFA+Rp8jsYIA7TzMagN/M/vKdvhIvOGAT7x5hJs=;
	b=UFOaoTirkfwpbGanYSQUBGKChEBsxci8cBTDnzU9mPPZBaEUkpMTo2hLGjVgUZsYOt+pD3
	K9dNPg2aOz00OSR8uJjcgIsfG34Rg9YpCswR+RZwk7yngmV4EXn2VHXvbF7Av0b47od5A0
	tPgtNNLB/iOIxspqZn1mPc8PzNTysN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746602981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbJTeFA+Rp8jsYIA7TzMagN/M/vKdvhIvOGAT7x5hJs=;
	b=D0SOPIpvOvSz69hfGU0PZYKG7qqJBrg6Lh0/rUEkz51SrK+5Y/jaSyiik1WsRHfBkGz0uC
	XQ8OetipPrSVPaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E14113882;
	Wed,  7 May 2025 07:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XEUTHOULG2hNVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 07:29:41 +0000
Message-ID: <9ed19121-0fc3-475f-9a09-68b506b1dadd@suse.de>
Date: Wed, 7 May 2025 09:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] nvme-auth: use SHASH_DESC_ON_STACK
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250425094927.102656-1-hare@kernel.org>
 <20250425094927.102656-3-hare@kernel.org> <20250507072819.GA2665@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250507072819.GA2665@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002943_550283_674AED8D 
X-CRM114-Status: UNSURE (   8.36  )
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

On 5/7/25 09:28, Christoph Hellwig wrote:
> On Fri, Apr 25, 2025 at 11:49:17AM +0200, Hannes Reinecke wrote:
>> Use SHASH_DESC_ON_STACK to avoid explicit allocation.
> 
> Can you send these two as standalone patches for ASAP inclusion,
> please?  They look nice and unrelated to the rest of the series.
> 
Why, sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

