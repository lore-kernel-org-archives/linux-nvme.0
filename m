Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7585EC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 14:41:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B90060F4A
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 14:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B90060F4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2sBV32tXpc90xEeTwS7+xs6VUALIZIvfqGfzfwplcc=; b=TRkhOp8Brb1aLcDbgDXO3WrEtQ
	0TpRAdw2exiAhsTqaRA5d2/ALHP1Dlf7IuUApHMYLSDQGlzcI6NqB+iXqYdJgc10yw50t30pg+2aH
	yf8RXRlIwr+pOJmSRvSdsoE31Y/6YTNPkRliz/i3baOIMhbsLpjDgptAkfkvFK7qd+xPcrno6oavJ
	UCkVECvqkJs/Ei4717tk2Txmh3bbg7v3fh6gvnjwp9pCo61LDCfjLPNgYcrC5sfGyVVADGcPoyrUK
	LVhXCchCKu5zTZzQPRsD68OY+VtNc06bfTmgn7ZQnVnFZ8ZPgOi1m9W5KfIjOExEjSggJa9FSttrx
	GscWVfAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUVLQ-000iNH-EE; Sun, 26 Sep 2021 14:41:32 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUVLN-000iMs-LR
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 14:41:31 +0000
Received: by mail-wr1-f46.google.com with SMTP id r23so18570851wra.6
 for <linux-nvme@lists.infradead.org>; Sun, 26 Sep 2021 07:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1q1Fq4eAq3/VVAlZgNVK+jA+Ox1AkV0eY9EAPoZVSiI=;
 b=Wmc13X/En2JY9G2gwr/fMeIqcJlVkDx+BT8wd9IYDbh18u5duSINtVqKibkDa1h6F8
 c6MmYcsFNlnb8zh5wlgmAmy0vsVKJbdSxkUFJOLE3CWuxQKs9TRqB4qb4kmkpxcQrPou
 vLm7JybrDQ3gXZu7SORPHRJnbBQ9HZGMMBX1DFdjYomOxvL8JYqTIUEfszrkRMB77L4o
 uf9Cd2nkNxTxmwUGU7HK3QOPlHG2nwqMJQmvmsoW2/dSmlLE87SHnV72J6pDN50vMVnO
 jgzd3PJmKWJYOZRtnfV00X0UwbZaOhUIKWqGmUJYVz/LurtA+nLrZoa2e6K4s8Lc3idS
 Njmg==
X-Gm-Message-State: AOAM530YKenmeRQjK1y2RzJKl1LKNQcuUAHvGs4F3HF18pTG7ZoELXTq
 A+Cy6wqlRGbbG6sp+jYh7EK/AWCEGEc=
X-Google-Smtp-Source: ABdhPJygoyT1ULAO0IFYSKsszrVIfyAHYJo776vuiiqqug7GIwiqw8Hpgx3M8bbkuVHzKF1iNoAS2w==
X-Received: by 2002:a05:600c:489a:: with SMTP id
 j26mr10423382wmp.111.1632667287090; 
 Sun, 26 Sep 2021 07:41:27 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o17sm10696538wrs.25.2021.09.26.07.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Sep 2021 07:41:26 -0700 (PDT)
Subject: Re: [PATCH nvme-cli] nvme-connect: Add 'dhchap-secret' and
 'dhchap-bidi' arguments
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210913094201.18729-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7d831d6d-7b35-f19c-8293-7a21f0d4c3d6@grimberg.me>
Date: Sun, 26 Sep 2021 17:41:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913094201.18729-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_074129_745626_D58E3E53 
X-CRM114-Status: GOOD (  27.78  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/13/21 12:42 PM, Hannes Reinecke wrote:
> Add 'dhchap-secret' and 'dhchap-bidi' arguments for nvme-connect
> to enable NVMe In-Band authentication.
> This is the nvme-cli patch to support NVMe In-band authentication as posted
> on the linux-nvme mailinglist.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   Documentation/nvme-connect.txt | 14 ++++++++++++++
>   fabrics.c                      | 29 ++++++++++++++++++++++-------
>   2 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
> index 4d7bb52..8cfc34e 100644
> --- a/Documentation/nvme-connect.txt
> +++ b/Documentation/nvme-connect.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>   		[--host-iface=<iface>     | -f <iface>]
>   		[--hostnqn=<hostnqn>      | -q <hostnqn>]
>   		[--hostid=<hostid>        | -I <hostid>]
> +		[--dhchap-secret=<secret> | -S <secret>]
>   		[--nr-io-queues=<#>       | -i <#>]
>   		[--nr-write-queues=<#>    | -W <#>]
>   		[--nr-poll-queues=<#>     | -P <#>]
> @@ -28,6 +29,7 @@ SYNOPSIS
>   		[--disable-sqflow         | -d]
>   		[--hdr-digest             | -g]
>   		[--data-digest            | -G]
> +		[--dhchap-bidi            | -B]
>   
>   DESCRIPTION
>   -----------
> @@ -92,6 +94,14 @@ OPTIONS
>   	UUID(Universally Unique Identifier) to be discovered which should be
>   	formatted.
>   
> +-S <secret>::
> +--dhchap-secret=<secret>::
> +	NVMe In-band authentication secret; needs to be in ASCII format as
> +	specified in NVMe 2.0 section 8.13.5.8 'Secret representation'.
> +	If this option is not specified, the default is read from
> +	/etc/nvme/hostkey. If that does not exist no in-band authentication
> +	is attempted.
> +
>   -i <#>::
>   --nr-io-queues=<#>::
>   	Overrides the default number of I/O queues create by the driver.
> @@ -140,6 +150,10 @@ OPTIONS
>   --data-digest::
>   	Generates/verifies data digest (TCP).
>   
> +-B::
> +--dhchap-bidi::
> +	Enable bidirectional authentication (TCP).
> +
>   EXAMPLES
>   --------
>   * Connect to a subsystem named nqn.2014-08.com.example:nvme:nvm-subsystem-sn-d78432
> diff --git a/fabrics.c b/fabrics.c
> index b132546..d1386c3 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -60,6 +60,7 @@ static const char *nvmf_htraddr		= "host traddr (e.g. FC WWN's)";
>   static const char *nvmf_hiface		= "host interface (for tcp transport)";
>   static const char *nvmf_hostnqn		= "user-defined hostnqn";
>   static const char *nvmf_hostid		= "user-defined hostid (if default not used)";
> +static const char *nvmf_hostkey		= "user-defined hostkey (if default not used)";
>   static const char *nvmf_nr_io_queues	= "number of io queues to use (default is core count)";
>   static const char *nvmf_nr_write_queues	= "number of write queues to use (default 0)";
>   static const char *nvmf_nr_poll_queues	= "number of poll queues to use (default 0)";
> @@ -72,6 +73,7 @@ static const char *nvmf_dup_connect	= "allow duplicate connections between same
>   static const char *nvmf_disable_sqflow	= "disable controller sq flow control (default false)";
>   static const char *nvmf_hdr_digest	= "enable transport protocol header digest (TCP transport)";
>   static const char *nvmf_data_digest	= "enable transport protocol data digest (TCP transport)";
> +static const char *nvmf_dhchap_bidi	= "enable bidirectional authentication (TCP transport)";
>   static const char *nvmf_config_file	= "Use specified JSON configuration file or 'none' to disable";
>   
>   #define NVMF_OPTS(c)									\
> @@ -82,6 +84,7 @@ static const char *nvmf_config_file	= "Use specified JSON configuration file or
>   	OPT_STRING("host-iface",      'f', "STR", &host_iface,	nvmf_hiface), \
>   	OPT_STRING("hostnqn",         'q', "STR", &hostnqn,	nvmf_hostnqn), \
>   	OPT_STRING("hostid",          'I', "STR", &hostid,	nvmf_hostid), \
> +	OPT_STRING("dhchap-secret",   'S', "STR", &hostkey,	nvmf_hostkey), \
>   	OPT_INT("nr-io-queues",       'i', &c.nr_io_queues,       nvmf_nr_io_queues),	\
>   	OPT_INT("nr-write-queues",    'W', &c.nr_write_queues,    nvmf_nr_write_queues),\
>   	OPT_INT("nr-poll-queues",     'P', &c.nr_poll_queues,     nvmf_nr_poll_queues),	\
> @@ -93,8 +96,8 @@ static const char *nvmf_config_file	= "Use specified JSON configuration file or
>   	OPT_FLAG("duplicate-connect", 'D', &c.duplicate_connect,  nvmf_dup_connect),	\
>   	OPT_FLAG("disable-sqflow",    'd', &c.disable_sqflow,     nvmf_disable_sqflow),	\
>   	OPT_FLAG("hdr-digest",        'g', &c.hdr_digest,         nvmf_hdr_digest),	\
> -	OPT_FLAG("data-digest",       'G', &c.data_digest,        nvmf_data_digest)     \
> -
> +	OPT_FLAG("data-digest",       'G', &c.data_digest,        nvmf_data_digest), \
> +	OPT_FLAG("dhchap-bidi",       'B', &c.dhchap_bidi,        nvmf_dhchap_bidi)
>   
>   static void space_strip_len(int max, char *str)
>   {
> @@ -296,7 +299,7 @@ static int discover_from_conf_file(nvme_host_t h, const char *desc,
>   {
>   	char *transport = NULL, *traddr = NULL, *trsvcid = NULL;
>   	char *host_traddr = NULL, *host_iface = NULL;
> -	char *hostnqn = NULL, *hostid = NULL;
> +	char *hostnqn = NULL, *hostid = NULL, *hostkey = NULL;
>   	char *ptr, **argv, *p, line[4096];
>   	int argc, ret = 0;
>   	FILE *f;
> @@ -369,10 +372,10 @@ out:
>   int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>   {
>   	char *nqn = NVME_DISC_SUBSYS_NAME;
> -	char *hostnqn = NULL, *hostid = NULL;
> +	char *hostnqn = NULL, *hostid = NULL, *hostkey = NULL;
>   	char *host_traddr = NULL, *host_iface = NULL;
>   	char *transport = NULL, *traddr = NULL, *trsvcid = NULL;
> -	char *hnqn = NULL, *hid = NULL;
> +	char *hnqn = NULL, *hid = NULL, *hkey = NULL;
>   	char *config_file = PATH_NVMF_CONFIG;
>   	enum nvme_print_flags flags;
>   	nvme_root_t r;
> @@ -434,6 +437,8 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>   		hostnqn = hnqn = nvmf_hostnqn_from_file();
>   	if (!hostid)
>   		hostid = hid = nvmf_hostid_from_file();
> +	if (!hostkey)
> +		hostkey = hkey = nvmf_hostkey_from_file();
>   	h = nvme_lookup_host(r, hostnqn, hostid);
>   	if (!h) {
>   		ret = ENOMEM;
> @@ -445,6 +450,8 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>   		else if (!strncmp(device, "/dev/", 5))
>   			device += 5;
>   	}
> +	if (hostkey)
> +		nvme_host_set_hostkey(h, hostkey);

Hannes, where is the implementation of this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
