Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397F2CDB474
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Oct 2023 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y9uZ51ZUb5gL4y/Lhq+1cbuZunfyPPyvTfq17MbiPl8=; b=PBHClRQ49llAcptQguPHn32qFG
	KxfZBwsPDbUUmnh5AO47ZOSKSUqpvguNmoVjkm8ZBcRBKaAu2CwpQ6hWrxGHf3vjn99lKZv7dC0vs
	Sw4k5yZye9sW06Tb4qGYbEm+s6YgHYSAjgAXyeL5T7m+dJ+tXK+phGi4uKCfIz6gjZTn0vK3haZrk
	SuxsL+8ItujxMRJ7t3sZPq51FuScNCwOkZ2wYpXdJGfa+T7rUla/xc7AFBjdXYECNee1+BRKKsztx
	hGqobdcvNnM80qtMeZr/lng33sMbACDZvUEQRAIIA3dv67dN5n/EbFxFqF9GCICwzz3gzRl37lkdc
	iJlQXjLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrd1e-005HwB-1G;
	Sat, 14 Oct 2023 11:41:46 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrd1c-005HuV-0O
	for linux-nvme@lists.infradead.org;
	Sat, 14 Oct 2023 11:41:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DDE921A99;
	Sat, 14 Oct 2023 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697283698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9uZ51ZUb5gL4y/Lhq+1cbuZunfyPPyvTfq17MbiPl8=;
	b=KMi9ugVkDPC+8MgANOzVmNvZv+4MdqoxeIuFxiHS8RBVaASoawOwgRLLtA3Llf419h5gSe
	tzHz/p1c4cf/7uQ5ncnj2XKKI+HU3UjTAf2f9IPqztdVdehU3IkQy5uVUAx0fBGHGa0U9K
	1jzTplltV9Vi9b89GKkM8H+pn2KLkrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697283698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9uZ51ZUb5gL4y/Lhq+1cbuZunfyPPyvTfq17MbiPl8=;
	b=GQWDRth9A5gxQOmTOsERHf1BKbyHpVz1ypNdqyreaHSb75yHcN+eQjUbdLJy7DG0uByLnQ
	lqXCZE8JIbQG9VBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F4091377D;
	Sat, 14 Oct 2023 11:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id eLy+IHF+KmWzNAAAMHmgww
	(envelope-from <hare@suse.de>); Sat, 14 Oct 2023 11:41:37 +0000
Message-ID: <ed5dd7d7-9795-40fe-bc4a-5bf4e99f9266@suse.de>
Date: Sat, 14 Oct 2023 13:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-auth: allow mixing of secret and hash lengths
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, kbusch@kernel.org, Akash Appaiah <Akash.Appaiah@dell.com>
References: <20231013202827.2262708-1-shiftee@posteo.net>
 <20231013202827.2262708-3-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231013202827.2262708-3-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-9.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.61)[92.49%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231014_044144_309494_AA9BBC47 
X-CRM114-Status: GOOD (  16.70  )
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

On 10/13/23 22:28, Mark O'Donovan wrote:
> We can now use any of the secret transformation hashes with a
> secret, regardless of the secret size.
> e.g. a 32 byte key with the SHA-512(64 byte) hash.
> 
> The example secret from the spec should now be permitted with
> any of the following:
> DHHC-1:00:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
> DHHC-1:01:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
> DHHC-1:02:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
> DHHC-1:03:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
> 
> Note: Secrets are still restricted to 32,48 or 64 bits.
> 
> Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
>   drivers/nvme/common/auth.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index d90e4f0c08b7..176855f86f0d 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -187,14 +187,6 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
>   		goto out_free_secret;
>   	}
>   
> -	if (key_hash > 0 &&
> -	    (key_len - 4) != nvme_auth_hmac_hash_len(key_hash)) {
> -		pr_err("Mismatched key len %d for %s\n", key_len,
> -		       nvme_auth_hmac_name(key_hash));
> -		ret = -EINVAL;
> -		goto out_free_secret;
> -	}
> -
>   	/* The last four bytes is the CRC in little-endian format */
>   	key_len -= 4;
>   	/*

That, however, looks good.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


