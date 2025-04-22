Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96390C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 06:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SxM9aSwhNuEjWSq22kC9+2qGlgP/3YfWZI2yxIAf8LU=; b=D3RpVco4fPT5+r8JtoCZGS1+OK
	/jWQewjjYm/VSVLlm3kr3KPfV1MCQ5aSSpKRP2Pgb9LEeNCu8ybUmE4gPmaN/GsO+DzL18m94nXIq
	kYrM7pKy5F0TANzWfLTXjyEfbPQo2+69eNDZKHl66mpsZGUbk/q+T16yBjy7V7s4rL2QCt1cHCNhk
	uCJYWrWXK5AsgBSTR97YJKP9mpZOHADmjRkX3G5jxCqPRva+YcJSZ4zMLT5HoZwdMLwuFffjP3J1K
	7E6B6d/c5UvqxtbJEky8OHpW936RbByeI5UuXFAeC7XT4/jXgjPMKsoktecZdFdSYJz/ZPqFg9bZw
	RSoeM9IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u778W-00000005xde-1R0d;
	Tue, 22 Apr 2025 06:29:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u773c-00000005wln-0kGi
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:24:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C72D721237;
	Tue, 22 Apr 2025 06:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxM9aSwhNuEjWSq22kC9+2qGlgP/3YfWZI2yxIAf8LU=;
	b=fekLQfonW1GbTkRuvdoi7OOxaa8jRaUFamvstKA+rNJFvyk8AeIAVExVZCpUkEG1WMgN+w
	x2YaSP7NZaNCjbIXhbZCFBDBgYFath5Aji0Ji9ffBLWEZ9883rrpCrkUFyueIhRK6rRSHb
	Zmk/CVwlZrH2N228e77/vKfLRDPFe3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxM9aSwhNuEjWSq22kC9+2qGlgP/3YfWZI2yxIAf8LU=;
	b=4dNt0V8P3DryXDLZ9Sxt9P3hnvtTy0MJa3yy/a9e2bx4GZjzCGb8ghOpGV2USbmec8eL/m
	ABj2ivJWsbjjLECQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxM9aSwhNuEjWSq22kC9+2qGlgP/3YfWZI2yxIAf8LU=;
	b=fekLQfonW1GbTkRuvdoi7OOxaa8jRaUFamvstKA+rNJFvyk8AeIAVExVZCpUkEG1WMgN+w
	x2YaSP7NZaNCjbIXhbZCFBDBgYFath5Aji0Ji9ffBLWEZ9883rrpCrkUFyueIhRK6rRSHb
	Zmk/CVwlZrH2N228e77/vKfLRDPFe3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxM9aSwhNuEjWSq22kC9+2qGlgP/3YfWZI2yxIAf8LU=;
	b=4dNt0V8P3DryXDLZ9Sxt9P3hnvtTy0MJa3yy/a9e2bx4GZjzCGb8ghOpGV2USbmec8eL/m
	ABj2ivJWsbjjLECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 749E2137CF;
	Tue, 22 Apr 2025 06:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ipinGiA2B2iwJwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:24:32 +0000
Message-ID: <8e5fbde2-849b-4eab-b7b1-6b3e81f9b66d@suse.de>
Date: Tue, 22 Apr 2025 08:24:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/4] tree: add support for discovering nvme paths using
 sysfs multipath link
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250417135951.239447-1-nilay@linux.ibm.com>
 <20250417135951.239447-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250417135951.239447-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_232436_523493_40C5812B 
X-CRM114-Status: GOOD (  39.04  )
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

On 4/17/25 15:59, Nilay Shroff wrote:
> With the upcoming Linux kernel v6.15, NVMe native multipath now provides
> a simplified mechanism for discovering all paths to a shared namespace
> through sysfs.
> 
> A new "multipath" directory is created under each NVMe head namespace
> device in "/sys/block/<head>/multipath/". This directory contains symlinks
> to all namespace path devices that access the same shared namespace.
> 
> For example, consider a shared namespace accessible via two paths under
> nvme-subsys1:
> 
> nvme-subsys1 - NQN=nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057
>      hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
> \
>   +- ns 1
>   \
>    +- nvme0 pcie 052e:78:00.0 live optimized
>    +- nvme1 pcie 058e:78:00.0 live optimized
> 
> The head device `/dev/nvme1n1` will now have the following structure:
> 
> /sys/block/nvme1n1/multipath/
> ├── nvme1c0n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme0/nvme1c0n1
> └── nvme1c1n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme1/nvme1c1n1
> 
> This clearly shows that namespace 1 is accessible through both nvme1c0n1
> and nvme1c1n1. This new sysfs structure significantly simplifies multipath
> discovery and management, making it easier for tools and scripts to enumerate
> and manage NVMe multipath configurations. So leverage this functionality to
> update the path links for a shared NVMe namespace, simplifying path discovery
> and management.
> 
> This change adds a new struct nvme_ns_head to represent the head of a shared
> namespace. It contains a list head linking together struct nvme_path objects,
> where each path corresponds to a shared namespace instance. Additionally,
> struct nvme_ns has been updated to reference its associated nvme_ns_head,
> enabling straightforward traversal of all paths to a shared NVMe namespace.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   src/nvme/filters.c |   6 ++
>   src/nvme/filters.h |   9 +++
>   src/nvme/private.h |   9 ++-
>   src/nvme/tree.c    | 162 +++++++++++++++++++++++++++++++--------------
>   src/nvme/tree.h    |   9 +++
>   5 files changed, 143 insertions(+), 52 deletions(-)
> 
> diff --git a/src/nvme/filters.c b/src/nvme/filters.c
> index ceaba68f..4a8829db 100644
> --- a/src/nvme/filters.c
> +++ b/src/nvme/filters.c
> @@ -105,3 +105,9 @@ int nvme_scan_ctrl_namespaces(nvme_ctrl_t c, struct dirent ***ns)
>   	return scandir(nvme_ctrl_get_sysfs_dir(c), ns,
>   		       nvme_namespace_filter, alphasort);
>   }
> +
> +int nvme_scan_ns_head_paths(nvme_ns_head_t head, struct dirent ***paths)
> +{
> +	return scandir(nvme_ns_head_get_sysfs_dir(head), paths,
> +		       nvme_paths_filter, alphasort);
> +}
> diff --git a/src/nvme/filters.h b/src/nvme/filters.h
> index 4ceeffd5..9e9dbb95 100644
> --- a/src/nvme/filters.h
> +++ b/src/nvme/filters.h
> @@ -94,4 +94,13 @@ int nvme_scan_ctrl_namespace_paths(nvme_ctrl_t c, struct dirent ***paths);
>    */
>   int nvme_scan_ctrl_namespaces(nvme_ctrl_t c, struct dirent ***ns);
>   
> +/**
> + * nvme_scan_ns_head_paths() - Scan for namespace paths
> + * @head: Namespace head node to scan
> + * @paths : Pointer to array of dirents
> + *
> + * Return: number of entries in @ents
> + */
> +int nvme_scan_ns_head_paths(nvme_ns_head_t head, struct dirent ***paths);
> +
>   #endif /* _LIBNVME_FILTERS_H */
> diff --git a/src/nvme/private.h b/src/nvme/private.h
> index 33cdd555..f45c5823 100644
> --- a/src/nvme/private.h
> +++ b/src/nvme/private.h
> @@ -36,12 +36,19 @@ struct nvme_path {
>   	int grpid;
>   };
>   
> +struct nvme_ns_head {
> +	struct list_head paths;
> +	struct nvme_ns *n;
> +
> +	char *sysfs_dir;
> +};
> +
>   struct nvme_ns {
>   	struct list_node entry;
> -	struct list_head paths;
>   
>   	struct nvme_subsystem *s;
>   	struct nvme_ctrl *c;
> +	struct nvme_ns_head *head;
>   
>   	int fd;
>   	__u32 nsid;

Why isn't 'nvme_subsystem' moved to 'nvme_ns_head'?
That certainly is how the kernel structures are laid
out, and it would make sense to follow it here...

> diff --git a/src/nvme/tree.c b/src/nvme/tree.c
> index b0a4696f..bd7fb53e 100644
> --- a/src/nvme/tree.c
> +++ b/src/nvme/tree.c
> @@ -564,12 +564,12 @@ nvme_ns_t nvme_subsystem_next_ns(nvme_subsystem_t s, nvme_ns_t n)
>   
>   nvme_path_t nvme_namespace_first_path(nvme_ns_t ns)
>   {
> -	return list_top(&ns->paths, struct nvme_path, nentry);
> +	return list_top(&ns->head->paths, struct nvme_path, nentry);
>   }
>   
>   nvme_path_t nvme_namespace_next_path(nvme_ns_t ns, nvme_path_t p)
>   {
> -	return p ? list_next(&ns->paths, p, nentry) : NULL;
> +	return p ? list_next(&ns->head->paths, p, nentry) : NULL;
>   }
>   
>   static void __nvme_free_ns(struct nvme_ns *n)
> @@ -579,6 +579,8 @@ static void __nvme_free_ns(struct nvme_ns *n)
>   	free(n->generic_name);
>   	free(n->name);
>   	free(n->sysfs_dir);
> +	free(n->head->sysfs_dir);
> +	free(n->head);
>   	free(n);
>   }
>   
> @@ -916,25 +918,6 @@ void nvme_free_path(struct nvme_path *p)
>   	free(p);
>   }
>   
> -static void nvme_subsystem_set_path_ns(nvme_subsystem_t s, nvme_path_t p)
> -{
> -	char n_name[32] = { };
> -	int i, c, nsid, ret;
> -	nvme_ns_t n;
> -
> -	ret = sscanf(nvme_path_get_name(p), "nvme%dc%dn%d", &i, &c, &nsid);
> -	if (ret != 3)
> -		return;
> -
> -	sprintf(n_name, "nvme%dn%d", i, nsid);
> -	nvme_subsystem_for_each_ns(s, n) {
> -		if (!strcmp(n_name, nvme_ns_get_name(n))) {
> -			list_add_tail(&n->paths, &p->nentry);
> -			p->n = n;
> -		}
> -	}
> -}
> -
>   static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
>   {
>   	struct nvme_path *p;
> @@ -973,7 +956,6 @@ static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
>   	}
>   
>   	list_node_init(&p->nentry);
> -	nvme_subsystem_set_path_ns(c->s, p);
>   	list_node_init(&p->entry);
>   	list_add_tail(&c->paths, &p->entry);
>   	return 0;
> @@ -2250,8 +2232,8 @@ nvme_ctrl_t nvme_scan_ctrl(nvme_root_t r, const char *name)
>   		return NULL;
>   
>   	path = NULL;
> -	nvme_ctrl_scan_namespaces(r, c);
>   	nvme_ctrl_scan_paths(r, c);
> +	nvme_ctrl_scan_namespaces(r, c);
>   	return c;
>   }
>   
> @@ -2323,6 +2305,11 @@ const char *nvme_ns_get_sysfs_dir(nvme_ns_t n)
>   	return n->sysfs_dir;
>   }
>   
> +const char *nvme_ns_head_get_sysfs_dir(nvme_ns_head_t head)
> +{
> +	return head->sysfs_dir;
> +}
> +
>   const char *nvme_ns_get_name(nvme_ns_t n)
>   {
>   	return n->name;
> @@ -2749,7 +2736,11 @@ static void nvme_ns_set_generic_name(struct nvme_ns *n, const char *name)
>   
>   static nvme_ns_t nvme_ns_open(const char *sys_path, const char *name)
>   {
> +	int ret;
>   	struct nvme_ns *n;
> +	struct nvme_ns_head *head;
> +	struct stat arg;
> +	_cleanup_free_ char *path = NULL;
>   
>   	n = calloc(1, sizeof(*n));
>   	if (!n) {
> @@ -2757,6 +2748,32 @@ static nvme_ns_t nvme_ns_open(const char *sys_path, const char *name)
>   		return NULL;
>   	}
>   
> +	head = calloc(1, sizeof(*head));
> +	if (!head) {
> +		errno = ENOMEM;
> +		free(n);
> +		return NULL;
> +	}
> +
> +	head->n = n;
> +	list_head_init(&head->paths);
> +	ret = asprintf(&path, "%s/%s", sys_path, "multipath");
> +	if (ret < 0) {
> +		errno = ENOMEM;
> +		goto free_ns_head;
> +	}
> +	/*
> +	 * The sysfs-dir "multipath" is available only when nvme multipath
> +	 * is configured and we're running kernel version >= 6.14.
> +	 */
> +	ret = stat(path, &arg);
> +	if (ret == 0) {
> +		head->sysfs_dir = path;
> +		path = NULL;
> +	} else
> +		head->sysfs_dir = NULL;
> +
> +	n->head = head;
>   	n->fd = -1;
>   	n->name = strdup(name);
>   
> @@ -2765,15 +2782,17 @@ static nvme_ns_t nvme_ns_open(const char *sys_path, const char *name)
>   	if (nvme_ns_init(sys_path, n) != 0)
>   		goto free_ns;
>   
> -	list_head_init(&n->paths);
>   	list_node_init(&n->entry);
>   
>   	nvme_ns_release_fd(n); /* Do not leak fds */
> +
>   	return n;
>   
>   free_ns:
>   	free(n->generic_name);
>   	free(n->name);
> +free_ns_head:
> +	free(head);
>   	free(n);
>   	return NULL;
>   }
> @@ -2836,6 +2855,71 @@ nvme_ns_t nvme_scan_namespace(const char *name)
>   	return __nvme_scan_namespace(nvme_ns_sysfs_dir(), name);
>   }
>   
> +
> +static void nvme_ns_head_scan_path(nvme_subsystem_t s, nvme_ns_t n, char *name)
> +{
> +	nvme_ctrl_t c;
> +	nvme_path_t p;
> +
> +	nvme_subsystem_for_each_ctrl(s, c) {
> +		nvme_ctrl_for_each_path(c, p) {
> +			if (!strcmp(nvme_path_get_name(p), name)) {
> +				list_add_tail(&n->head->paths, &p->nentry);
> +				p->n = n;
> +				return;
> +			}
> +		}
> +	}
> +}
> +
> +static void nvme_subsystem_set_ns_path(nvme_subsystem_t s, nvme_ns_t n)
> +{
> +	struct nvme_ns_head *head = n->head;
> +
> +	if (nvme_ns_head_get_sysfs_dir(head)) {
> +		struct dirents paths = {};
> +		int i;
> +
> +		/*
> +		 * When multipath is configured on kernel version >= 6.14,
> +		 * we use multipath sysfs link to get each path of a namespace.
> +		 */
> +		paths.num = nvme_scan_ns_head_paths(head, &paths.ents);
> +
> +		for (i = 0; i < paths.num; i++)
> +			nvme_ns_head_scan_path(s, n, paths.ents[i]->d_name);
> +	} else {
> +		nvme_ctrl_t c;
> +		nvme_path_t p;
> +		int ns_ctrl, ns_nsid, ret;
> +
> +		/*
> +		 * If multipath is not configured or we're running on kernel
> +		 * version < 6.14, fallback to the old way.
> +		 */
> +		ret = sscanf(nvme_ns_get_name(n), "nvme%dn%d",
> +				&ns_ctrl, &ns_nsid);
> +		if (ret != 2)
> +			return;
> +
> +		nvme_subsystem_for_each_ctrl(s, c) {
> +			nvme_ctrl_for_each_path(c, p) {
> +				int p_subsys, p_ctrl, p_nsid;
> +
> +				ret = sscanf(nvme_path_get_name(p),
> +					     "nvme%dc%dn%d",
> +					     &p_subsys, &p_ctrl, &p_nsid);
> +				if (ret != 3)
> +					continue;
> +				if (ns_ctrl == p_subsys && ns_nsid == p_nsid) {
> +					list_add_tail(&head->paths, &p->nentry);
> +					p->n = n;
> +				}
> +			}
> +		}
> +	}

Can't you just use the existing nvme_subsystem_set_path_ns() function
here instead of deleting and open-code it?

> +}
> +
>   static int nvme_ctrl_scan_namespace(nvme_root_t r, struct nvme_ctrl *c,
>   				    char *name)
>   {
> @@ -2861,33 +2945,9 @@ static int nvme_ctrl_scan_namespace(nvme_root_t r, struct nvme_ctrl *c,
>   	n->s = c->s;
>   	n->c = c;
>   	list_add_tail(&c->namespaces, &n->entry);
> -	return 0;
> -}
> -
> -static void nvme_subsystem_set_ns_path(nvme_subsystem_t s, nvme_ns_t n)
> -{
> -	nvme_ctrl_t c;
> -	nvme_path_t p;
> -	int ns_ctrl, ns_nsid, ret;
> -
> -	ret = sscanf(nvme_ns_get_name(n), "nvme%dn%d", &ns_ctrl, &ns_nsid);
> -	if (ret != 2)
> -		return;
> +	nvme_subsystem_set_ns_path(c->s, n);
>   
> -	nvme_subsystem_for_each_ctrl(s, c) {
> -		nvme_ctrl_for_each_path(c, p) {
> -			int p_subsys, p_ctrl, p_nsid;
> -
> -			ret = sscanf(nvme_path_get_name(p), "nvme%dc%dn%d",
> -				     &p_subsys, &p_ctrl, &p_nsid);
> -			if (ret != 3)
> -				continue;
> -			if (ns_ctrl == p_subsys && ns_nsid == p_nsid) {
> -				list_add_tail(&n->paths, &p->nentry);
> -				p->n = n;
> -			}
> -		}
> -	}
> +	return 0;
>   }
>   
>   static int nvme_subsystem_scan_namespace(nvme_root_t r, nvme_subsystem_t s,

Similar here; better to use the existing functions.

> @@ -2917,7 +2977,7 @@ static int nvme_subsystem_scan_namespace(nvme_root_t r, nvme_subsystem_t s,
>   			list_del_init(&p->nentry);
>   			p->n = NULL;
>   		}
> -		list_head_init(&_n->paths);
> +		list_head_init(&_n->head->paths);
>   		__nvme_free_ns(_n);
>   	}
>   	n->s = s;
> diff --git a/src/nvme/tree.h b/src/nvme/tree.h
> index 25d4b31b..9f382e9c 100644
> --- a/src/nvme/tree.h
> +++ b/src/nvme/tree.h
> @@ -27,6 +27,7 @@
>    */
>   
>   typedef struct nvme_ns *nvme_ns_t;
> +typedef struct nvme_ns_head *nvme_ns_head_t;
>   typedef struct nvme_path *nvme_path_t;
>   typedef struct nvme_ctrl *nvme_ctrl_t;
>   typedef struct nvme_subsystem *nvme_subsystem_t;
> @@ -1091,6 +1092,14 @@ void nvme_ctrl_set_dhchap_host_key(nvme_ctrl_t c, const char *key);
>    */
>   const char *nvme_ctrl_get_dhchap_key(nvme_ctrl_t c);
>   
> +/**
> + * nvme_ns_head_get_sysfs_dir() - sysfs dir of namespave head
> + * @head: namespace head instance
> + *
> + * Returns: sysfs directory name of @head
> + */
> +const char *nvme_ns_head_get_sysfs_dir(nvme_ns_head_t head);
> +
>   /**
>    * nvme_ctrl_set_dhchap_key() - Set controller key
>    * @c:		Controller for which the key should be set

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

