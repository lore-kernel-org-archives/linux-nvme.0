Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862ADC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k6llfxhinC14v65EC9H3YLA0PjXg+aeSgA+YOVCCaw0=; b=mHa8FZ/Iok69NrIZSwQN4TJzBO
	pzfyydXRj/ZW6TluryKyDMmUJE98OBNJHD4vvVG/KjIZ+yvIZOTVQrQ9+PMYMrg4EQkVkQldPjiHG
	hM3HrfB2iPczzVXvgDGzoHCZWfQZDvhuXpBw8s1fHEw0Biph3aQZ1wMzV58rxDUKORsgGXA4Y5vTt
	KdD/d7GGcgr4uzFnCGOeQ5KG5ODKRVwdrKXmVEp3L/HddzRgxCAfguRWOwzQmemFIWCKxNLg/dNlp
	OaYbR1ef323vLOlJ67Beg2i2bzwcqqZ5UWVaarzsg85kV/5V17fmSWVPe0J5hjhvs8/cP5AvOy8gF
	0Z+b2Jug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osp1D-00FcsX-1W; Wed, 09 Nov 2022 17:37:43 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osp19-00FcpD-WC
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 17:37:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F4B922C49;
	Wed,  9 Nov 2022 17:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1668015457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6llfxhinC14v65EC9H3YLA0PjXg+aeSgA+YOVCCaw0=;
	b=R5ehzJPbeZ3UY0aIYs8a2W8SqWvK2ZrFjA8fAgG6Gsh2nH8gbBlmCfFpiAmv/fZj4WHbmY
	6Tm5vyLhc+mWC7P2W4wNDZahG4IsqXrqFhpopVgFx4L3LNLJlYlo2l0KPfyjv6iH098wHZ
	RUxtxrBTYQkMVZ5SrU2v/a9/kLna0/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1668015457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6llfxhinC14v65EC9H3YLA0PjXg+aeSgA+YOVCCaw0=;
	b=tvi4kl5j2Pnlbbz8Rp6eIdeGJOomjVGScGGZ8tHsMv0aa3A/RjkKdpGnf7WVTRbQ/vrTWx
	PMHZR73/l2gJotAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACA78139F1;
	Wed,  9 Nov 2022 17:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CbL2JmDla2PsFwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 17:37:36 +0000
Message-ID: <632d861c-a763-77fa-59bd-11a003504815@suse.de>
Date: Wed, 9 Nov 2022 18:37:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/16] nvme-auth: don't keep long lived 4k dhchap buffer
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-9-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-9-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_093740_237396_2E9652AE 
X-CRM114-Status: GOOD (  13.28  )
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

On 11/9/22 04:44, Sagi Grimberg wrote:
> dhchap structure is per-queue, it is wasteful to keep it for the entire
> lifetime of the queue. Allocate it dynamically and get rid of it after
> authentication. We don't need kzalloc because all accessors are clearing
> it before writing to it.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


