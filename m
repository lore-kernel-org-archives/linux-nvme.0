Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701DDC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J20yElFyG38Yg0LxYkTM/X7iqHo6h3ZATFrgAzRNxiE=; b=f3q4FB62MG40lQ8BvZoJSP6sYE
	YYhhfbOugilIo32QOw5m/fopMr06PUSz9Ac40z2Ahd2FUVipFjy7qqoIDX8pi8ewN/kr9+k0jepd9
	Pm71wx4MNRH7XmURK/y/ixSkt7lNWTS3TkUXkBNVTSuRlD0I8FjyDTp76YaFFhZYF8GugvZ5m5iRZ
	wVulQSa5kwHQVX2TMY0d9UO9OpqOQDPRpPOnkEHm5W9bRS4DrvVR7ncuXRtZQ77e4KPOoOjb+U6NZ
	UYCH1F+G2y32DF05DNrQHygW9ez1/9+gpLJOKcfJW5Wz+/37VQ/D51Id2zWNEuOn4BHJyxPAe/F9Y
	0kQaqlNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNdv-006RXB-Rg; Tue, 25 Oct 2022 17:23:11 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNdo-006RUp-S5
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:23:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D82E21FE0;
	Tue, 25 Oct 2022 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666718583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J20yElFyG38Yg0LxYkTM/X7iqHo6h3ZATFrgAzRNxiE=;
	b=1QX0WqFNvNPi37VAozW9Tf+/SdFtGBG+AGSnG2MgJOvakN0sl7Nrqs+Wit7CKVu9EVC9lX
	+P1JLuVOaJgeUzPSs1weFD2KtQzhG3YY1PmIlP6ZNWLEt9/WGH/4Op5lC4jZ3SIyv3+CO8
	r/e0ksHdm9Jhl9zg5d5vA00NQBGGHXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666718583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J20yElFyG38Yg0LxYkTM/X7iqHo6h3ZATFrgAzRNxiE=;
	b=jE1a60xft1z37muQmfZQhE3nlEoVzEDKBPgzSCm+lZo+ancb7VGNB4gcrRCauvgSgokRBf
	KWwpxFS46+pz3WAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A7E013A64;
	Tue, 25 Oct 2022 17:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cbF2HHcbWGPENgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 25 Oct 2022 17:23:03 +0000
Message-ID: <3d3e77ae-4d58-f955-c1e4-91ff89c5574b@suse.de>
Date: Tue, 25 Oct 2022 19:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/6] nvme-auth: remove redundant buffer deallocations
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-5-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221025134330.1028352-5-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_102305_120393_20A0131F 
X-CRM114-Status: GOOD (  14.78  )
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

On 10/25/22 15:43, Sagi Grimberg wrote:
> host_response, host_key, ctrl_key and sess_key are
> freed in nvme_auth_reset_dhchap which is called from
> nvme_auth_free_dhchap.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 93c0fc71bc7c..15cddc2bb14d 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -683,10 +683,6 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
>   		crypto_free_shash(chap->shash_tfm);
>   	if (chap->dh_tfm)
>   		crypto_free_kpp(chap->dh_tfm);
> -	kfree_sensitive(chap->ctrl_key);
> -	kfree_sensitive(chap->host_key);
> -	kfree_sensitive(chap->sess_key);
> -	kfree_sensitive(chap->host_response);
>   	kfree(chap->buf);
>   	kfree(chap);
>   }
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

