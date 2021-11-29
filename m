Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DADCC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Nov 2021 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsk6SyRSsTfqfjpICPSerEh5Cbyd40I5poC6DaH97xI=; b=W19bpO1t9b4+cu3SF03Ybw0xoD
	gpwGaMvBbYK12dSt4y/rZ0H9qGKcCfz3YUHx3ueGFUlXP7GALrlXWwILJ4fATGrylx/WPkCBwbHcS
	XwGMGTzYMo0CEQigiGveWm357HQM33JIaXtuHSjUFaUnj076WkIHih3c/jKzLM9m6xvBcDLnTD/8Y
	zZH4xowHvH3+/yZs/Esar0tc1EDkRQA0/qDaplCqW+LogeTXpwRGgSQ4179HibCosBcpGEHAM9DF7
	bGHghsCJoJTP+6VE2P+wwg9++tvYOVGgLop7fY+n2O/kUu0yltea4kNcf2loGk6eeceFHUs1zeR66
	OBZwOQow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrgPc-000nrS-GX; Mon, 29 Nov 2021 13:09:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrgPZ-000nq0-9W
 for linux-nvme@lists.infradead.org; Mon, 29 Nov 2021 13:09:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 055911FCA1
 for <linux-nvme@lists.infradead.org>; Mon, 29 Nov 2021 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638191374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jsk6SyRSsTfqfjpICPSerEh5Cbyd40I5poC6DaH97xI=;
 b=uYmmOvyhmol+guQr31x6xNfyli2voyK/6ZamtcoW0qPJZ8ihJx2cJJHH7L79FIiMOA6jNQ
 J5DTgJR9pN1+5qq9hkaN/a3bMkYBARhB3CiiqjgzmEevhrQssSsoXsLONu4STgveVBsEjL
 ZMPjWa2dsWuG4k5yOFeIXaR/aW8wBUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638191374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jsk6SyRSsTfqfjpICPSerEh5Cbyd40I5poC6DaH97xI=;
 b=TkKw9AgjofH3i3J7ztNfEcITTCHQSBU56Wfmaka8adqh2mBtONq3WQlmap2knk4Do1cYce
 qOdxqYgHEcjWyNAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBF4B13ABC
 for <linux-nvme@lists.infradead.org>; Mon, 29 Nov 2021 13:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Zd6MKQ3RpGF+SgAAMHmgww
 (envelope-from <hare@suse.de>)
 for <linux-nvme@lists.infradead.org>; Mon, 29 Nov 2021 13:09:33 +0000
Subject: Re: [PATCH libnvme v2] fabrics: fix endless loop in connect-all for
 NVME_NQN_CURR
To: linux-nvme@lists.infradead.org
References: <20211128130303.490972-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f36c1d47-f0bc-7d29-18b4-4643b093c6cf@suse.de>
Date: Mon, 29 Nov 2021 14:09:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211128130303.490972-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_050937_560110_FF934AF8 
X-CRM114-Status: GOOD (  22.01  )
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

On 11/28/21 2:03 PM, Sagi Grimberg wrote:
> For a discovery log page entry that indicates the discovery controller
> that returned it (i.e. itself), we need to set the controller as
> discovered (because we got the discovery log page by connecting to it).
> 
> Without this connect-all goes in an endless loop keep connecting and
> retrieving the log page from the same discovery subsystem port.
> 
> Fixes: 06a8f001d314 ("tree,fabrics: detect discovery loops")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - add break as we don't need the discovery ctrl setting
> 
>   src/nvme/fabrics.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> index 686a5641aa9c..9207296ba957 100644
> --- a/src/nvme/fabrics.c
> +++ b/src/nvme/fabrics.c
> @@ -657,8 +657,10 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
>   	}
>   
>   	switch (e->subtype) {
> -	case NVME_NQN_DISC:
>   	case NVME_NQN_CURR:
> +		nvme_ctrl_set_discovered(c, true);
> +		break;
> +	case NVME_NQN_DISC:
>   		if (discover)
>   			*discover = true;
>   		nvme_ctrl_set_discovery_ctrl(c, true);
> 
Merged with https://github.com/linux-nvme/libnvme

Cheers,

Hannes

