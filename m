Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F05C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 07:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZjALB8pxLjxbzlkUdIb3jBcygJpARcYAiDKjOG6+M8=; b=TDix+q9pClTXGzM9ui/YdHLRRP
	SaBfKWLe/WDEpOxsnuLnFHAhyHEaFm2QbQck5bIEbVnsLslZNMjQcNOhyVUbVa0/kvSxhvWsXW7p/
	WtzxKDNXEiafIkr3hEl53jDz4EWkEiLEKZdSpyMVRMlq4y5wKXHt7C1RpTUVsY7QTX4KO09kAM+v4
	pOw883O4X48QlpHMAuNxVqlAFPsbumRMX8SDPdimO7Zd29EoppOWGaLIBpnFtzZmZVGbKHZ5YEMTM
	cj4bQkapRiakN0mia1XDmxaH4wqAVphMqIoV0z56huILK8cFoJYIwSTf9r51svV3fd4+ppSR7fTNE
	O71ysokQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfal-00BZg8-S9; Wed, 09 Nov 2022 07:33:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfae-00BZeb-GP
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 07:33:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40B6E2244F;
	Wed,  9 Nov 2022 07:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667979219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZjALB8pxLjxbzlkUdIb3jBcygJpARcYAiDKjOG6+M8=;
	b=ELG7ToNa2co7ljIpCcW8LNxKtRAFD2ant31O30gXhongDeksasigLB7FRMBCe9KkTUSoOb
	s4/uVfqDO/ewFFWZ84XrD5Bk0m68l4wegN0ltwWWM34BUWxoqrfJG/tGSG0T02QK2PhZp2
	ZVqCb0MOwktsfrmHn5qPGmj8BECI0as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667979219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZjALB8pxLjxbzlkUdIb3jBcygJpARcYAiDKjOG6+M8=;
	b=YBDmF4++61Bs6Z4D7XlGpNEcbX27V+pVV45+Uc82H78kKMbM5HfkaS6SEsXgEMUB/RV09k
	kx9WMpqSuR4qtCCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B85C139F1;
	Wed,  9 Nov 2022 07:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 32MRBtNXa2MlNQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 07:33:39 +0000
Message-ID: <7723377a-912d-997a-5d41-184eeccacfd9@suse.de>
Date: Wed, 9 Nov 2022 08:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 05/16] nvme-auth: don't ignore key generation failures
 when initializing ctrl keys
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-6-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-6-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_233340_715215_FDCA1ABE 
X-CRM114-Status: GOOD (  11.57  )
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
> nvme_auth_generate_key can fail, don't ignore it upon initialization.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 19 +++++++++++++++----
>   drivers/nvme/host/core.c |  6 +++++-
>   drivers/nvme/host/nvme.h |  2 +-
>   3 files changed, 21 insertions(+), 6 deletions(-)
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


