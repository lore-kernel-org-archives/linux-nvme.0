Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB15D0E6E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 10:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8FtLlTjPQAQg7HRUtUwoTVXA27J2UGZv9Oyyy6k+i6M=; b=E1o9fcMaDvwPiQvcO4+Af2gr43
	NiV0CcUe3lu31QKv5lazG4XFViaqwmW1AdAO2PoHyE8dP8RBQdn2S0XEeEJUiTGD+IaK/bUAYj8Va
	ESgrv6A3es/20p/C7uJJ631e9HmS4gNIJFWTpD3bjfMcK8aQhmv+gKoXwucXCf9sBDVeKcGtvJLTj
	bcO6JAEI2LCBB6TWQj0GfxPXk/46oE4hZZc9LjHtGyFa/con6mGBSOTqsR2/9z4dfMNT467rQAjj1
	qJmiCUF3l0/zn4AiV0cckjE1sRHUA216SxPn/nnfZKly3u9ZsxTniN+YtbAx5+GAqomWjqfqnlaUw
	qICOJ3Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pZY-00000006sC3-2U9c;
	Mon, 21 Oct 2024 10:23:36 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pZU-00000006sB9-07XG
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 10:23:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23F401F811;
	Mon, 21 Oct 2024 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729506210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FtLlTjPQAQg7HRUtUwoTVXA27J2UGZv9Oyyy6k+i6M=;
	b=yxUnvTmRYh0jSoYjjdVTRptwX7XUUGAsVEwV02cv0M5Z1J7yz4AJUJUHBDDjjaP5qd3mfo
	n4iH1IfKsLzVc+WW0WaBiF/yFhaYCsj77xPG2D0/qRbOSWv7qZ4hhst/DNLRj+JBbofHf5
	QUvrs/7lJ8gRCaCnSbnf3ic0ZCxyua8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729506210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FtLlTjPQAQg7HRUtUwoTVXA27J2UGZv9Oyyy6k+i6M=;
	b=0E3yRcazDPUnbwahoPjK8M7cklQomrTLwV812rnnMdMor0lBX86/gc9IZmm83tVHRN6G5K
	XOfGl9mEW+UdLeDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yxUnvTmR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0E3yRcaz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729506210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FtLlTjPQAQg7HRUtUwoTVXA27J2UGZv9Oyyy6k+i6M=;
	b=yxUnvTmRYh0jSoYjjdVTRptwX7XUUGAsVEwV02cv0M5Z1J7yz4AJUJUHBDDjjaP5qd3mfo
	n4iH1IfKsLzVc+WW0WaBiF/yFhaYCsj77xPG2D0/qRbOSWv7qZ4hhst/DNLRj+JBbofHf5
	QUvrs/7lJ8gRCaCnSbnf3ic0ZCxyua8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729506210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FtLlTjPQAQg7HRUtUwoTVXA27J2UGZv9Oyyy6k+i6M=;
	b=0E3yRcazDPUnbwahoPjK8M7cklQomrTLwV812rnnMdMor0lBX86/gc9IZmm83tVHRN6G5K
	XOfGl9mEW+UdLeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A42E139E0;
	Mon, 21 Oct 2024 10:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q8gLAqIrFmeQCAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Oct 2024 10:23:30 +0000
Message-ID: <9761610c-b60e-4e88-a235-6120d80a0b25@suse.de>
Date: Mon, 21 Oct 2024 12:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: defer partition scanning
To: Keith Busch <kbusch@meta.com>, hch@lst.de, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20241015143136.810779-1-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241015143136.810779-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23F401F811
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_032332_238442_DBE2B310 
X-CRM114-Status: GOOD (  12.09  )
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

On 10/15/24 16:31, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We need to suppress the partition scan from occuring within the controller's
> scan_work context. If a path error occurs here, the submission will wait until
> a path becomes available or all paths are torn down, but that action also
> occurs within scan_work, so it would deadlock. Defer the partion scan a
> different one that does not block scan_work.
> 
> Reported-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> will be ignored, and an empty message aborts the commit.
> ---
>   drivers/nvme/host/multipath.c | 39 +++++++++++++++++++++++++++++------
>   drivers/nvme/host/nvme.h      |  1 +
>   2 files changed, 34 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

