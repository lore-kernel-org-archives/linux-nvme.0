Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138D1C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4esM00lGhHSXOPjLqldeAMwvUxHMJlP7QeOoOsl0YsQ=; b=aCnkNsC5YxlXFw3OFLJnXjK6re
	Uec2z2XKwKPRSwe5C5YUcpoqSoCbO60t6YTq8qW/Apoa6Pbo3H1Zw38gnWfdTwBih7uJwbqzLzQkb
	Nkt6E85H0Dz/qFRidIlzjfFay+IuI8QbGnRv+Ik/sgVY9b2uEey3Xlv0AO7hyBhuywBeTAjdlJ/bK
	H3Tgbw0f09+YeeiTS1ObiamplZLydhILdKjIq3ILPmLSa4IZ6XjA0yyFM2OBmfKWu6EHu5Xqooeov
	NR6GzpJHv8KnjrM2NlkfQsFyHv1WEVEBaDMYrOAH9EIYo6ilVfaM2PQDwkq2/rHkOr28sSfxwNQ7i
	e9PeYeGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q64xg-00EbkP-1K;
	Mon, 05 Jun 2023 07:49:08 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q64xd-00EbjC-13
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 07:49:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17C731F8AE;
	Mon,  5 Jun 2023 07:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685951344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4esM00lGhHSXOPjLqldeAMwvUxHMJlP7QeOoOsl0YsQ=;
	b=ecnLnxZ/oYcUkpYO0SougsN5fMRVnsHRHR5YR9Muvqk9rBm9a6h2ekErmp2QWYUtpVu3B/
	ppL6CIzbcfKWFHXJRx7JamHXmz+DVVxX+NSue8t96vyMJwIa5NU14COg1a2peZAZUXp7ww
	dczCJuikdBNLLpiENQL5KoUChcV28OE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685951344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4esM00lGhHSXOPjLqldeAMwvUxHMJlP7QeOoOsl0YsQ=;
	b=MJZ4zLAgDAPNUQ/RDWFTGkegevEDy0p7akzupS3HPQrnHrg2osG3L+fOfpgh4vkLkC00jX
	l0nzQt9CqELRPjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA905139C7;
	Mon,  5 Jun 2023 07:49:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id IZhWOG+TfWTLdQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 05 Jun 2023 07:49:03 +0000
Message-ID: <ff70d6e9-e77c-4ca1-d0f9-2b48f8d1b029@suse.de>
Date: Mon, 5 Jun 2023 09:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 4/4] nvmet-auth: use correct type for status variable
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
References: <20230605064434.45233-1-kch@nvidia.com>
 <20230605064434.45233-5-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230605064434.45233-5-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_004905_509617_4D0A99DC 
X-CRM114-Status: GOOD (  12.26  )
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

On 6/5/23 08:44, Chaitanya Kulkarni wrote:
> In structructure nvmet_sq dhchap_step member is responsible to hold
Spelling.
Also please drop the 'is responsible for' to just read:

'The dhchap_step member of structure nvmet_sq holds the following values:'

> following values :-
> 
>          NVME_AUTH_DHCHAP_FAILURE_FAILED                 = 0x01,
>          NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE             = 0x02,
>          NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH        = 0x03,
>          NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE          = 0x04,
>          NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE       = 0x05,
>          NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD      = 0x06,
>          NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE      = 0x07,
> 
> These values can never be negative, hence change int type of
> dhchap_step to u16 in the nvmet_sq declaration.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/target/nvmet.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Otherwise the patch is okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


