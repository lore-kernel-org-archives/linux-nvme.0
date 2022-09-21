Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A9EECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 06:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wfDUlFoqnpRYBKTF1htfo4EKecOrI2K5qgGCq55maYo=; b=05sgbvcknnsxizdO97ZJdhfR8N
	p6znbzlbb00un1czqGGYJzlPtM+ZsfcZmL23ImNmuOwNiMEIs5YPlrBSLowHeKCoMqXsPd6SHVlJF
	QLtotH16iK3HLi08OGWk2bmCu3R54sG2LIhZXKuYteaJB068JlqH+gbs60X7L/2ER29HoHFZFSUXu
	qQbHAyxW40b2FTIJBKRDMoOn0ylDc4BXS90xr3VAzBYi+FkOm+8XcSups1VJNtWnufbdrZbvJaFk3
	lvOegU9hNdTRsq9aK3FE+Qd9HCJvv/0EUptIlqsmri315MqQ5PRsLpboo3fZ7bfRctB5zRCbAnwlC
	LLkuqwLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaszt-009DRo-QM; Wed, 21 Sep 2022 06:14:13 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaszq-009DPX-Qn
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 06:14:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8386A1F747;
	Wed, 21 Sep 2022 06:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663740848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfDUlFoqnpRYBKTF1htfo4EKecOrI2K5qgGCq55maYo=;
	b=d4vjsxrKis9/4G7HrlUQ1MaVZdgXFPqqFyajVXAUuTWSmHYzM5ttqLGlxYkzfbwyzGi0jW
	Q6ho8USII1ZV/2g4O/cVZgJog/VwB/daTjN6GP8mXxwgAVWAxQUxMd/W2b4ubdEdRPuBE6
	U7MV6FwWH5nhmGs0TbuwyESFa7XKuQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663740848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfDUlFoqnpRYBKTF1htfo4EKecOrI2K5qgGCq55maYo=;
	b=yz1oSxL0zdnIDr+FbeJwG8sPFYFriC3mRUNzSbs1V5YL3xbgBHsQvS8F+hFpZXm56nvimQ
	Pif3JTzlE9AG1CDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 670BE13A89;
	Wed, 21 Sep 2022 06:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WhFwGLCrKmN9awAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Sep 2022 06:14:08 +0000
Message-ID: <e3f854b1-a435-2d5a-0f16-cfa9a2203202@suse.de>
Date: Wed, 21 Sep 2022 08:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] nvmet: add helpers to set the result field for
 connect commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171931.1289669-1-hch@lst.de>
 <20220920171931.1289669-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220920171931.1289669-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_231411_053181_A41E146E 
X-CRM114-Status: GOOD (  14.40  )
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

On 9/20/22 19:19, Christoph Hellwig wrote:
> The code to set the result field for the admin and I/O connect commands
> is not only verbose and duplicated, but also violates the aliasing
> rules as it accesses both the u16 and u32 members in the union.
> 
> Add a little helper to sort all that out.
> 
>   Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/fabrics-cmd.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

