Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92DDC7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WIoQkdygJMCN8xAouK6/HnrD9yaZKvzvAh0QSIQnYV4=; b=cp036Y6xsb7PGVP/2sP9muVwji
	Ov8g2YGHCWzka5T1U5huF0kVpV3qFfcRtOTzlTgodg49LjB8cc1muC0Lr0Qq87zL/3Xo8AaCGdW8n
	pXN3MjowJfNryGxoghc6hjOCcT6gvsZbwx7xeCJCZTvEhyycgtbC3tUUJjyTR8Obm1DP8G0nOhstq
	DRufvCz2o/xZCiEHFg8Pwkrlt3caEpa+FveaQQpvdglrxbubeM7kOz1oSyaATmudfvueWYqX+sGi7
	cyNIVThzGSVQ52nKppxRO6gi7B7NN6iY3D3qqZc4ffcuMnPsnR8J3gJa8CWxWcAQ52XFgpwNf57Om
	/gUVagvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6511-00EcXL-1g;
	Mon, 05 Jun 2023 07:52:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q650z-00EcW6-0k
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 07:52:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCC9E1F8AE;
	Mon,  5 Jun 2023 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685951551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIoQkdygJMCN8xAouK6/HnrD9yaZKvzvAh0QSIQnYV4=;
	b=jdNmURYv9e81txjyy4CHcvJQ0TjTQBxhC4Rn7POVsjLsVPORcB43MOLdJRE3rY5+PhMdiW
	2vEEvx45v3Qbg0rODTuGPTVOnHLe5b3WalXw/OMnwnhVQOe7V6tSXKBd9DxihEZwSjwj6t
	TRZQ3e6zQyab1ytoVncReWAdS3x5wa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685951551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIoQkdygJMCN8xAouK6/HnrD9yaZKvzvAh0QSIQnYV4=;
	b=seH83FmiNFSsRA64yWkjOAR7J+O2+CfuTFFgHELCkftBsLA3uBk65Pujn2m4eLM/eyMu/V
	xWhjoKqP3C3BbfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC3C2139C7;
	Mon,  5 Jun 2023 07:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id eQogKT+UfWSIdwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 05 Jun 2023 07:52:31 +0000
Message-ID: <33dc45ef-2fec-2db7-6c5c-d473f01b9479@suse.de>
Date: Mon, 5 Jun 2023 09:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/2] nvme: add generic helper to store secret
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20230605065125.47563-1-kch@nvidia.com>
 <20230605065125.47563-2-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230605065125.47563-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_005233_410904_29ED56EC 
X-CRM114-Status: GOOD (  14.45  )
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

On 6/5/23 08:51, Chaitanya Kulkarni wrote:
> Refactor code to avoid duplication and improve maintainability:
> 
> Consolidate the shared code between the functions
> nvme_ctrl_dhchap_secret_store() and
> nvme_ctrl_dhchap_ctrl_secret_store(). This duplication not only
> increases the likelihood of bugs but also requires additional effort for
> maintenance and testing.
> 
> Introduce a new generic helper function called
> nvme_dhchap_secret_store_common() to handle the storage of the
> dhchap secret. Update nvme_ctrl_dhchap_secret_store() and
> nvme_ctrl_dhchap_ctrl_secret_store() to use newly introduced helper.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/sysfs.c | 96 ++++++++++++++++-----------------------
>   1 file changed, 39 insertions(+), 57 deletions(-)
> 
Hmm. I distinctly remember having it coded that way once, but later
have it split off into two functions.
But anyway.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


