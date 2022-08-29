Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5904ECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r1XMK46AHDSc2UjD9u9yfgtvSXCWjbee+KcbGDgAemo=; b=Gce7Rnx4S/T+kxYpOA3YXnv/q0
	NWEeQahoJSueR+JAgefLx5s1iNaFSuRLE4F8t9BuRbtZJaWdokX9pBZ2c/xJ/KuCGTd+mZDl1pmmu
	xv8DoK3ygSby0TXoLEl5dzQiB9LFX/o2J/JcIRSpXFcTT7D/uaUWIhqkpAa4jUbjiV8jHHDoWtfOG
	Xk7hVSiJnMmcudSFfM9JgXqGqQmOrOHJaOJqkHf1PE+2HnN7RvN9s1RJ7vR+WAxvaheCKqkJ9GLzM
	kPd5MadFyQZZDRi3NS5UJ0i6+ulT2tsmpXytKwt4k6EJXRrGOvhl+UHdjaG/J5pT+Pwk8hso88d4H
	YIg0sPKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSajx-006X53-64; Mon, 29 Aug 2022 09:07:29 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSajq-006X25-0r
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:07:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A384621CD6;
	Mon, 29 Aug 2022 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661764040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1XMK46AHDSc2UjD9u9yfgtvSXCWjbee+KcbGDgAemo=;
	b=VqFKucDFGxGGHd2oe5oKeZzG0SHjlcwKE1ue60emQWKQk4LKX/XT53Ir9F3gOj0uktalCJ
	R6wOd444NzI0AV/2kEdxjW03aQrTbmOZw/utfOG3jcFBG1zcj5wpB3PESwaugWJD40z8Wt
	MtiAM9VqdjosBZsTVBu7LgZqzTBOw6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661764040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1XMK46AHDSc2UjD9u9yfgtvSXCWjbee+KcbGDgAemo=;
	b=uCcg9VQ6lA6lZl2zgod6OlJRgPE4QQjw4604eiFJZEskq4DvTMGd8K1mXcNJAD4LtziXVT
	XtAZmZbV31yfGICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B40B1352A;
	Mon, 29 Aug 2022 09:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HlBKIciBDGObIAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 29 Aug 2022 09:07:20 +0000
Message-ID: <10a0f656-644a-de05-466c-32d3cde54869@suse.de>
Date: Mon, 29 Aug 2022 11:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/3] nvme-tcp: Handle number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220829083856.1850-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_020722_233479_B1F94A52 
X-CRM114-Status: GOOD (  15.25  )
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

On 8/29/22 10:38, Daniel Wagner wrote:
> On reconnect, the number of queues might have changed.
> 
> In the case where we have more queues available than previously we try
> to access queues which are not initialized yet.
> 
> The other case where we have less queues than previously, the
> connection attempt will fail because the target doesn't support the
> old number of queues and we end up in a reconnect loop.
> 
> Thus, only start queues which are currently present in the tagset
> limited by the number of available queues. Then we update the tagset
> and we can start any new queue.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

