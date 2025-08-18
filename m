Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5105ECA0EE4
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 07:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+1u6ZhvizloivawWc7WUC03OmQVISx5ht3gNss4Law=; b=PewS+VhKQWwtujyq9qLSHqshey
	Y+cEkNC7gGjmufe9T3lt5d5ZSDrF7uaJIqIUKbuXO5ELJQJP71lfTaDsJpyd4cFmmRDFzFeTcLan2
	0bPUTZgAYtgieV8RiwCe93zQ+8NJacqzouw2wb5tlt50ai09V+vQLnqjbLIPEcNq5F+HRuP604F+X
	PYr7jES+TBe/vAQTwbzhEuIIAGWwPzkIjOGMppLU6zgOKHBXE12T/7OI/QOsSs1fLTThXuwH0Tl5Q
	gvkdWv3+H0Ctsnb6kqzimhsS/oDk/JHUALkn+r9C4JgPcamGFL5WFQ5GKpY8DJWjrIzY6Pjyag9FZ
	Nt+9KNPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unueZ-00000006pj3-0nX8;
	Mon, 18 Aug 2025 07:51:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unu38-00000006lgS-2iGn
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 07:12:59 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09E852124D;
	Mon, 18 Aug 2025 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755501177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+1u6ZhvizloivawWc7WUC03OmQVISx5ht3gNss4Law=;
	b=cNITb3emWgmOm+2NrOW0vGZ/ReJHLzfD0me9Dtha9cS584HYJKN7ZybHzbklkbKO5rGzut
	sx5v8jjvxa8o8YA2Za02KA3xQj5xs1R4aMSpgyQGr46+0B52mcddJA0xlHlti7XMaKYXAT
	XJV7P5VbkNdHQ+YOnv9H/U4rcuOGpAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755501177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+1u6ZhvizloivawWc7WUC03OmQVISx5ht3gNss4Law=;
	b=6Cp3Zzx5ewafzEtNjso/zEhGZ9XA+3kyQCjYC9y/36sUupZLWnX0ZrTpBaCO+HwjvxXpCI
	dkac/TjLs36senDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VKx+ibXx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1E2otm8y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755501176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+1u6ZhvizloivawWc7WUC03OmQVISx5ht3gNss4Law=;
	b=VKx+ibXxH2UqJ5G5z1KfUwk/0NMl9kgSaJmbQj2ttD7LnRXXUykEKN8C1M/JbpqsdAgupm
	sL9iVVAUN1D8hw/tqAtqhUV7xMOuxaHmPvqcnDWQc5v8ZQecmg86cVw9tYM+EOfG7//wAO
	9tiWPoaJgms304j1mRxckg7g7EyAooI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755501176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+1u6ZhvizloivawWc7WUC03OmQVISx5ht3gNss4Law=;
	b=1E2otm8yP6XROqOI3BOzOcVXLvcN21BKqI7cfuqlybSbYyJuYcCre2rXxM8GaV5FH1SAjQ
	dBlr0TpeqowdNqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97FB313A55;
	Mon, 18 Aug 2025 07:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3tzVInfSomgXDwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 07:12:55 +0000
Message-ID: <39506d0c-9205-4638-a516-0cfe0de9a8ff@suse.de>
Date: Mon, 18 Aug 2025 09:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/4] nvme: support <device> option in show-topology
 command
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250812125614.164445-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 09E852124D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_001258_832278_B63CA056 
X-CRM114-Status: GOOD (  19.24  )
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

On 8/12/25 14:56, Nilay Shroff wrote:
> Although the help text for the nvme show-topology command indicates
> support for a <device> option, this option has no effect in practice
> — specifying an NVMe device name does not filter the output.
> 
> This commit adds proper support for the <device> option, enabling users
> to filter the topology output based on the specified NVMe device.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   nvme-print-stdout.c |  9 +++++++++
>   nvme.c              | 17 ++++++++++++++++-
>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
> index c597b608..eb56349a 100644
> --- a/nvme-print-stdout.c
> +++ b/nvme-print-stdout.c
> @@ -5683,6 +5683,15 @@ static void stdout_simple_topology(nvme_root_t r,
>   
>   	nvme_for_each_host(r, h) {
>   		nvme_for_each_subsystem(h, s) {
> +			bool no_ctrl = true;
> +			nvme_ctrl_t c;
> +
> +			nvme_subsystem_for_each_ctrl(s, c)
> +				no_ctrl = false;
> +
> +			if (no_ctrl)
> +				continue;
> +
>   			if (!first)
>   				printf("\n");
>   			first = false;
> diff --git a/nvme.c b/nvme.c
> index 27dac37b..c6779cf4 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -10155,6 +10155,8 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
>   	const char *ranking = "Ranking order: namespace|ctrl";
>   	nvme_print_flags_t flags;
>   	_cleanup_nvme_root_ nvme_root_t r = NULL;
> +	char *devname = NULL;
> +	nvme_scan_filter_t filter = NULL;
>   	enum nvme_cli_topo_ranking rank;
>   	int err;
>   
> @@ -10197,7 +10199,20 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
>   		return -errno;
>   	}
>   
> -	err = nvme_scan_topology(r, NULL, NULL);
> +	if (optind < argc)
> +		devname = basename(argv[optind++]);
> +
> +	if (devname) {
> +		int subsys_id, nsid;
> +
> +		if (sscanf(devname, "nvme%dn%d", &subsys_id, &nsid) != 2) {
> +			nvme_show_error("Invalid device name %s\n", devname);
> +			return -EINVAL;
> +		}
> +		filter = nvme_match_device_filter;
> +	}
> +
> +	err = nvme_scan_topology(r, filter, (void *)devname);
>   	if (err < 0) {
>   		nvme_show_error("Failed to scan topology: %s", nvme_strerror(errno));
>   		return err;

While I welcome this change, we've had discussions that
'nvme show-topology <device>' really should _not_ print out
anything if the device does not exist.
Have you checked this for your patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

