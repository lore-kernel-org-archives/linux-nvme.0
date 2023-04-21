Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400EDC7618E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PtI5FsWIo7eS0MfsXeWP2DccH1Y9ik4GSJZ5dtRpXbM=; b=njU/PFBgINkFAVXgU1D/yPsFBP
	+F/MVJUiTiVgRG1hhNlJtOoyLqlX1pPTiBLNBGi5HlHP2CyvX1HVgXKnP23k7nhjDsjTxCYBVkAad
	FNqcaHXvpHR5zrA5DL1KXZcp2S7qGFnQB6Gz3dxNwGH9ainfXB4eJYYi+/qRfBIYRNMpznO6FWaBp
	X4W/i2u38q5XLyuQv0BpR/SjIHdXrWfX8qqpd9oKVPy84Rm0dxPPDFlaRiTi8dIRcmIixzuhRzvYF
	c2LDas/sgoeV4jipC7wxQXVX8QNxUQJ0Ks+2Mk+C7juhhW2xAMYGU850nLKJ7dpUzs9PfpXzsrUkI
	QKdt855g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkQD-009r6w-13;
	Fri, 21 Apr 2023 06:39:05 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkQA-009r6J-0u
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:39:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 052931FDDC;
	Fri, 21 Apr 2023 06:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682059141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtI5FsWIo7eS0MfsXeWP2DccH1Y9ik4GSJZ5dtRpXbM=;
	b=UcvZxfBYk144jFxyAF78oS1m2sQece6AviBda1qJyTTf76FX7EFgdPEQR3pNfsjP/nEYFY
	nNA5sW5bI3Es85PuIqLiT4DWfvuEmq0F2Fpt2BX6dWLW1tO/YaXxgQns8VhTArSt8UDYM5
	sc/VYE7YL5rhm7E7dP+Kt/bmb6ZNEwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682059141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtI5FsWIo7eS0MfsXeWP2DccH1Y9ik4GSJZ5dtRpXbM=;
	b=hmWTq2sQ1y/r8w9SBFihB7nL2/dvz5pjJ7E9iM1BVShCkv39DDwuHa1wkeR5GFC6jrTriU
	oETECvkSU8hEKJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5B1113456;
	Fri, 21 Apr 2023 06:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yzVWM4QvQmRhdQAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:39:00 +0000
Message-ID: <c5a5cf4b-ba96-1e55-26ac-d2da9ab7117d@suse.de>
Date: Fri, 21 Apr 2023 08:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 9/9] nvme: Make the number iterations
 configurable
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-10-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-10-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_233902_470866_8594A2C3 
X-CRM114-Status: GOOD (  11.18  )
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

On 4/21/23 08:05, Daniel Wagner wrote:
> Some tests hard code high values of iterations. This makes them run
> relatively long compared to the other tests. Introduce a new environment
> variable nvme_num_iter to allow tune the runtime.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/002 | 2 +-
>   tests/nvme/016 | 2 +-
>   tests/nvme/017 | 2 +-
>   tests/nvme/rc  | 1 +
>   4 files changed, 4 insertions(+), 3 deletions(-)
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


