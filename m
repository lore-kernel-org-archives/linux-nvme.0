Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C3BC7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bXd/2FqEzjuH6UBMdAI+ESk7hbFXHTow9uEyQsdrSN0=; b=PDYyM4sZEs/XEeLGMXfcluseY0
	8REn6Y3WfO+AGUT6TGd0Af8/PnTBFlY57mfjR5ivBuW/1nrJHbNnIyv84BVYvPJDa8aQ7ZK9unuxo
	SLMVsxN11ReTEcNiy7wD9OYw+X9ntFU4fd9B2BvTUHZ4dwaOmzplkQ5hl16oHiZxxidtNXwqy2+QS
	nl0oMF9r7EylpcvqZE7NZTNtj3JBNeKKpRAeLThTC7iBfHWXQyWm/ao3UfOLNf9HcDcsyiiQHLc8M
	4wx0Vaokvhk8/zFASJVi2Pf7oX/qudRRiAAEZIMAcwEbeTTz2Ni5awafRlmBj3NLWkM3ZsXYZmdqA
	r+P/qsrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxBNF-009lCD-2d;
	Thu, 11 May 2023 18:50:45 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxBNC-009lBK-0S
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 18:50:43 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9724C21FAF;
	Thu, 11 May 2023 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683831040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXd/2FqEzjuH6UBMdAI+ESk7hbFXHTow9uEyQsdrSN0=;
	b=Onxf/2q0Bfv44CBBMTSDdahOmi8+PC/vHb4K/1W0fSmyehvbNDLuTWtOh/Xz2YgPQKOvIg
	7dGU21LU1cgYzJTTVI4CuspvCe/cCE2yN3GxBDeNnVIsi0QUj+XjHsHgYNGokjkEuWQdWn
	fQbyop6ooq3v5GDGw/zfJ9aRCj6fWJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683831040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXd/2FqEzjuH6UBMdAI+ESk7hbFXHTow9uEyQsdrSN0=;
	b=nsg8I1s+vBtSkUdu3LQXBlUnB7P4kvW923jNv3SWRC8Q+L1gqnxzmEqaZRqSWgHlXLiH5L
	g4F/qYURF0yHbXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9593A134B2;
	Thu, 11 May 2023 18:50:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0aVvF/44XWSgTwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 11 May 2023 18:50:38 +0000
Message-ID: <583bbc61-58d8-d950-a179-16c6807f38bd@suse.de>
Date: Thu, 11 May 2023 20:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/3] nvme-fabrics: prevent overriding of existing host
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
References: <20230511165441.30005-1-mgurtovoy@nvidia.com>
 <20230511165441.30005-4-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230511165441.30005-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_115042_330939_BB763AA0 
X-CRM114-Status: GOOD (  35.79  )
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

On 5/11/23 18:54, Max Gurtovoy wrote:
> When first connecting a target using the "default" host parameters,
> setting the hostid from the command line during a subsequent connection
> establishment would override the "default" hostid parameter. This would
> cause an existing connection that is already using the host definitions
> to lose its hostid.
> 
> To address this issue, the code has been modified to allow only 1:1
> mapping between hostnqn and hostid. This will maintain unambiguous host
> identification. Any non 1:1 mapping will be rejected during connection
> establishment.
> 
> Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> 
> changes from v1:
> - address comments from Christoph
> - allow only 1:1 mapping between hostnqn and hostid
> - add error prints in case we fail a connection for user to understand
>    the reason of the failure
> 
> ---
>   drivers/nvme/host/fabrics.c | 98 ++++++++++++++++++++++++++-----------
>   1 file changed, 70 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 0c0172bdc4dc..f8e47c7d6188 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -21,35 +21,77 @@ static DEFINE_MUTEX(nvmf_hosts_mutex);
>   
>   static struct nvmf_host *nvmf_default_host;
>   
> -static struct nvmf_host *__nvmf_host_find(const char *hostnqn)
> +/**
> + * __nvmf_host_find() - Find a matching to a previously created host
> + * @hostnqn: Host NQN to match
> + * @id: Host ID to match
> + *
> + * We have defined a host as how it is perceived by the target.
> + * Therefore, we don't allow different Host NQNs with the same Host ID.
> + * Similarly, we do not allow the usage of the same Host NQN with different
> + * Host IDs. This will maintain unambiguous host identification.
> + *
> + * Return: Returns host pointer on success, NULL in case of no match or
> + *         ERR_PTR(-EINVAL) in case of error match.
> + */
> +static struct nvmf_host *__nvmf_host_find(const char *hostnqn, uuid_t *id)
>   {
>   	struct nvmf_host *host;
>   
> +	lockdep_assert_held(&nvmf_hosts_mutex);
> +
>   	list_for_each_entry(host, &nvmf_hosts, list) {
> -		if (!strcmp(host->nqn, hostnqn))
> -			return host;
> +		if (!strcmp(host->nqn, hostnqn)) {
> +			if (uuid_equal(&host->id, id)) {
> +				// same hostnqn and hostid
> +				return host;
> +			} else {
> +				pr_err("found same hostnqn %s but different hostid %pUb\n",
> +				       hostnqn, id);
> +				return ERR_PTR(-EINVAL);
> +			}
> +		} else if (uuid_equal(&host->id, id)) {
> +			// same hostid but different hostnqn
> +			pr_err("found same hostid %pUb but different hostnqn %s\n",
> +			        id, hostnqn);
> +			return ERR_PTR(-EINVAL);
> +		}
>   	}
>   
>   	return NULL;
>   }
>   
> -static struct nvmf_host *nvmf_host_add(const char *hostnqn)
> +static struct nvmf_host *nvmf_host_alloc(const char *hostnqn, uuid_t *id)
> +{
> +	struct nvmf_host *host;
> +
> +	host = kmalloc(sizeof(*host), GFP_KERNEL);
> +	if (!host)
> +		return NULL;
> +
> +	kref_init(&host->ref);
> +	uuid_copy(&host->id, id);
> +	strscpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
> +
> +	return host;
> +}
> +
> +static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t *id)
>   {
>   	struct nvmf_host *host;
>   
>   	mutex_lock(&nvmf_hosts_mutex);
> -	host = __nvmf_host_find(hostnqn);
> -	if (host) {
> +	host = __nvmf_host_find(hostnqn, id);
> +	if (IS_ERR(host)) {
> +		goto out_unlock;
> +	} else if (host) {
>   		kref_get(&host->ref);
>   		goto out_unlock;
>   	}
>   
> -	host = kmalloc(sizeof(*host), GFP_KERNEL);
> +	host = nvmf_host_alloc(hostnqn, id);
>   	if (!host)
> -		goto out_unlock;
> -
> -	kref_init(&host->ref);
> -	strscpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
> +		return ERR_PTR(-ENOMEM);
>   
>   	list_add_tail(&host->list, &nvmf_hosts);
>   out_unlock:
> @@ -60,16 +102,17 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn)
>   static struct nvmf_host *nvmf_host_default(void)
>   {
>   	struct nvmf_host *host;
> +	char nqn[NVMF_NQN_SIZE];
> +	uuid_t id;
>   
> -	host = kmalloc(sizeof(*host), GFP_KERNEL);
> +	uuid_gen(&id);
> +	snprintf(nqn, NVMF_NQN_SIZE,
> +		"nqn.2014-08.org.nvmexpress:uuid:%pUb", &id);
> +
> +	host = nvmf_host_alloc(nqn, &id);
>   	if (!host)
>   		return NULL;
>   
> -	kref_init(&host->ref);
> -	uuid_gen(&host->id);
> -	snprintf(host->nqn, NVMF_NQN_SIZE,
> -		"nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
> -
>   	mutex_lock(&nvmf_hosts_mutex);
>   	list_add_tail(&host->list, &nvmf_hosts);
>   	mutex_unlock(&nvmf_hosts_mutex);
> @@ -633,6 +676,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	size_t nqnlen  = 0;
>   	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
>   	uuid_t hostid;
> +	char hostnqn[NVMF_NQN_SIZE];
>   
>   	/* Set defaults */
>   	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
> @@ -649,7 +693,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	if (!options)
>   		return -ENOMEM;
>   
> -	uuid_gen(&hostid);
> +	/* use default host if not given by user space */
> +	uuid_copy(&hostid, &nvmf_default_host->id);
> +	strscpy(hostnqn, nvmf_default_host->nqn, NVMF_NQN_SIZE);
>   
>   	while ((p = strsep(&o, ",\n")) != NULL) {
>   		if (!*p)
> @@ -795,12 +841,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				ret = -EINVAL;
>   				goto out;
>   			}
> -			opts->host = nvmf_host_add(p);
> +			strscpy(hostnqn, p, NVMF_NQN_SIZE);
>   			kfree(p);
> -			if (!opts->host) {
> -				ret = -ENOMEM;
> -				goto out;
> -			}
>   			break;
>   		case NVMF_OPT_RECONNECT_DELAY:
>   			if (match_int(args, &token)) {
> @@ -957,13 +999,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				opts->fast_io_fail_tmo, ctrl_loss_tmo);
>   	}
>   
> -	if (!opts->host) {
> -		kref_get(&nvmf_default_host->ref);
> -		opts->host = nvmf_default_host;
> +	opts->host = nvmf_host_add(hostnqn, &hostid);
> +	if (IS_ERR(opts->host)) {
> +		ret = PTR_ERR(opts->host);
> +		opts->host = NULL;
> +		goto out;
>   	}
>   
> -	uuid_copy(&opts->host->id, &hostid);
> -
>   out:
>   	kfree(options);
>   	return ret;

Hmm. Remind me again: what's the supposed behaviour if I do _not_ set 
the hostid from userspace and try another connection with the same hostnqn?
If I read the code correctly I will be getting a new 'host' structure 
(as the hostid is not identical).
Is this the behaviour we're aiming at?
I would have thought that I would be getting the same host structure ..

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


