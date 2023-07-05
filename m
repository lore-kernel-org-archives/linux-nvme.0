Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41359EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jul 2023 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3vVlGJQ27Btaxno/y4XfNAdrLohNHbso1OOosK2CsLs=; b=z9tcG76YRC29mDWm/tYbZ1xQuL
	FhkQ18j5j7dFxhFpk6nHPaZ7cJsOWbZeIPdA0XDyrSmeHLynRk4ncoK7qK/JtC7cA+0OsBNdY0s4x
	KyXKo/ePLZy6ajrl90mf6QzN7dMq/S7KPFAzM7Ibf6ixtxGidYJV7KN7SHPJTpVFaHBQO+DpjK32V
	rxhL+ILT/QilfHbNUua7/pioQhOZGqHyshkdSmxEpWajnJ6L7DDi4yfgC0v3HA39OPsOjn3VFsvq0
	urJ7nCa1oRUiODEKovtDCNHT8xDJqN0c3w5dCjhBEt7rTc1CfiYYidcFAi9Jcx62CAIRLa+2rr5lW
	V/YurUqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGyiE-00FLEh-1v;
	Wed, 05 Jul 2023 09:22:14 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGyiB-00FLDS-24
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jul 2023 09:22:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FF631F890;
	Wed,  5 Jul 2023 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688548928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3vVlGJQ27Btaxno/y4XfNAdrLohNHbso1OOosK2CsLs=;
	b=gRGZnUXtZLcK2Zo2NNt9cuHj8m4ts1MbN3di6SzJVb91plPhfRSgbW6H7Fr8QeqtOfiqV9
	7vu1fnO9rBY4Sq6WESuuQ1ZnsOZ1rTJWLn/gLbFh3K7Iw6/I2a01bwj3fQT/hz+AsCv/NG
	+FfBEszmWsCb0axhwMGT3Fo/wcmOkv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688548928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3vVlGJQ27Btaxno/y4XfNAdrLohNHbso1OOosK2CsLs=;
	b=Kz50OS9CEoKlbyXswVdHzip3S9eMGDNBx3H33vRG8NKM/yDNMOASr9lkr7sWETrDB19Xx6
	ui7sjMNaALuPYxCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67442134F3;
	Wed,  5 Jul 2023 09:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Hw0mGUA2pWSxagAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 05 Jul 2023 09:22:08 +0000
Date: Wed, 5 Jul 2023 11:22:07 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH nvme-cli] fabrics: Use corresponding hostid when hostnqn
 is generated
Message-ID: <rehxjlrcqlihlxgcrnezbbludfxdlmqpo2jyemau7g7yhswic3@ueewl5oraqbu>
References: <20230702022346.3150889-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702022346.3150889-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230705_022211_849572_F217FC0D 
X-CRM114-Status: GOOD (  22.42  )
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

Hi Shin'ichiro,

sorry for my late response.

On Sun, Jul 02, 2023 at 11:23:46AM +0900, Shin'ichiro Kawasaki wrote:
> After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
> of existing host"), kernel ensures hostid and hostnqn maintain 1:1
> mapping and "non 1:1 mapping will be rejected". This makes 'nvme
> discover' and 'nvme connect' commands fail when they generate hostnqn,
> since it does not use corresponding hostid.
> 
> To avoid the failures, prepare and use corresponding hostid to the
> generated hostnqn, taking the hostid from the hostnqn string. Also warn
> when the hostid is different from that in hostid file.
> 
> Link: https://lore.kernel.org/linux-nvme/l7vk7fnzltpmvkwujsbf2btrzip6wh7ug62iwa3totqcda25l6@siqx7tj6lt3l/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  fabrics.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/fabrics.c b/fabrics.c
> index ac240cad..2eeea48c 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -677,6 +677,26 @@ static int nvme_read_volatile_config(nvme_root_t r)
>  	return ret;
>  }
>  
> +char *nvmf_hostid_from_hostnqn(const char *hostnqn)
> +{
> +	const char *uuid;
> +	const char *hostid_from_file;
> +
> +	if (!hostnqn)
> +		return NULL;
> +
> +	uuid = strstr(hostnqn, "uuid:");
> +	if (!uuid)
> +		return NULL;
> +	uuid += strlen("uuid:");
> +
> +	hostid_from_file = nvmf_hostid_from_file();
> +	if (hostid_from_file && strcmp(uuid, hostid_from_file))
> +		fprintf(stderr, "warning: use generated hostid instead of hostid file\n");
> +

As mentioned in my my other original mail, I'd say it makes sense to have the
check after ...

> +	return strdup(uuid);
> +}
> +
>  int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>  {
>  	char *subsysnqn = NVME_DISC_SUBSYS_NAME;
> @@ -753,8 +773,10 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>  	hostid_arg = hostid;
>  	if (!hostnqn)
>  		hostnqn = hnqn = nvmf_hostnqn_from_file();
> -	if (!hostnqn)
> +	if (!hostnqn) {
>  		hostnqn = hnqn = nvmf_hostnqn_generate();
> +		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
> +	}
>  	if (!hostid)
>  		hostid = hid = nvmf_hostid_from_file();
>  	h = nvme_lookup_host(r, hostnqn, hostid);
> @@ -966,8 +988,10 @@ int nvmf_connect(const char *desc, int argc, char **argv)
>  
>  	if (!hostnqn)
>  		hostnqn = hnqn = nvmf_hostnqn_from_file();
> -	if (!hostnqn)
> +	if (!hostnqn) {
>  		hostnqn = hnqn = nvmf_hostnqn_generate();
> +		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
> +	}
>  	if (!hostid)
>  		hostid = hid = nvmf_hostid_from_file();

... here

>  	h = nvme_lookup_host(r, hostnqn, hostid);
> -- 
> 2.40.1
> 

The rest looks good.

Thanks,
Daniel

