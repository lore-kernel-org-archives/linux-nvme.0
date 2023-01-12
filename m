Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB96BC54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=llv+bppcmQxlziplBzkZsbaKwWibcy3pOBjxewkCvfc=; b=05LycKYEcaDQFmJvXHOcvWObLY
	byqHroyg0lp5lCMRnicMb8cG9aXVumAyv40pgKRGC7hTT2H5mepTd1j2bhN+T5Y0ApSERSSVqU17G
	az+OvDR77+xt6KLZrxGC9ai1SEqGCf9XVomo0OyAiOj0EA7+ka1nnj7F1ZLeVRR6lVrNhme645F9R
	q3tgb5y2tZ/emtKcRf1QQGMfwys8/r5lZpgPOebtpdUVgtbxjjJQz+mZCdKTYZeyvFZ0VhRyywRZZ
	dqmWDvLUBD4DKRsQgHWf7jj1860AREuV/t6PdQOH0aufLdU/XVIeT6KxuQLXPABdbUkE7Xr5DoAdM
	Mu7yHH6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFxVc-00F7jm-PZ; Thu, 12 Jan 2023 13:20:44 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFxVZ-00F7hX-Hq
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 13:20:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C2EF3F428
	for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673529635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llv+bppcmQxlziplBzkZsbaKwWibcy3pOBjxewkCvfc=;
	b=AlRAKsqzTrlWsYk/52HMyi6s2ErG/m6ZeRNz4+kaw+8KCK2ddX8OnpW3t7T3QW7E51q9yJ
	HDci19H6pkpTy0/L3ChKB600Aduo8bvXLKd3JYgJ0AQ3rNwdNWxh6ESvacRNhoTekhPWhN
	YwEF+IblMQdAd8DDeMAe4lyJMfwfLOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673529635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llv+bppcmQxlziplBzkZsbaKwWibcy3pOBjxewkCvfc=;
	b=7w7BfrEm3DJQNxhwafl/N8dxCriLQvzk7qbc1vJA/HC4TDvLJJ9fhbMSslTVKiEKQQL2zN
	sA97qTSLX81AUXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9313913776
	for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 13:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wmFxIyMJwGPxYQAAMHmgww
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 13:20:35 +0000
Message-ID: <2b995082-7521-8acd-457f-6b5bcc82fa19@suse.de>
Date: Thu, 12 Jan 2023 14:20:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] nvme: remove __nvme_ioctl
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20230108165033.380842-1-hch@lst.de>
 <20230108165033.380842-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230108165033.380842-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_052041_787713_1FF400C2 
X-CRM114-Status: GOOD (  11.08  )
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

On 1/8/23 17:50, Christoph Hellwig wrote:
> Open code __nvme_ioctl in the two callers to make future changes that
> pass down additional paramters in the ioctl path easier.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/ioctl.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


