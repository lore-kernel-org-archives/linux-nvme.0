Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7C2C2D0F0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 19:39:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E146920678
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 19:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ka361Nri";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehgbm8I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E146920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IrKW2R1hToF73XiDOf93efXnQw5H0fTnTtrRatfstto=; b=ka361NrinHRxzJ
	SgDx/k4QbCjhaftO8S3UijihV8LI3gECEgCg07v0jjpAN5LhyYswlZFssueF1J81njJZNzb24WYdV
	27wg2stR+np/iwoN5PKoHQm0hTGcVBJewVTjbSaEPDOmpwPbFDtTltX5pwfL2sARiqjxP8D4G48QL
	++IoqkJaDTwgx+o2Ywi6YliHcRtQRD8R433diE2phdS0RinVjBXM+GNPVpTnjtSdYehk5LoAwaE7M
	iQhKAHgFEwboyAXmgzHsVfuR8cAXeblVrQSnFolQ5iXd9iXjF3alyNFAB3F8AGO3nkl5rxUSjo8p/
	L8mwpkUoNWfyXP1uGvrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJjCl-0006SQ-Gi; Wed, 01 Apr 2020 19:39:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJjCi-0006Re-0v
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 19:39:14 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CFEC820714;
 Wed,  1 Apr 2020 19:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585769951;
 bh=PR/HWxRCYnY19Lmc2CJ1jBiN1kMwh3K5/3tcP8yLUsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ehgbm8I1LhfGSKY3jqH9Wq24q66fWeBt9X1tOyXgaX1uR9JuZAXNnLO2zRJanqmSu
 OgysLGwdKlbTzVWN3aMFXt3P9nZaiKb7Pq85VUAPNmKc8hWX7zwoUgpeLHbVi9SJWu
 Q6NKqfZ1WjWOTjgYYorzYBCBfZfI5UvI65v1GVZI=
Date: Wed, 1 Apr 2020 12:39:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH rfc 2/2] fabrics: allow user to pass hostname instead of
 traddr
Message-ID: <20200401193908.GB1144965@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200324090324.24459-1-sagi@grimberg.me>
 <20200324090324.24459-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200324090324.24459-3-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_123912_107640_B019B07D 
X-CRM114-Status: GOOD (  20.52  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 24, 2020 at 02:03:24AM -0700, Sagi Grimberg wrote:
> Some users would like to use well known hostnames instead
> of remembering ip addresses. So, allow users to pass --hostname
> and we will attempt to resolve against the DNS.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  fabrics.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/fabrics.c b/fabrics.c
> index a7d628b1f0c9..7bd95c4b0d10 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -33,6 +33,10 @@
>  #include <sys/stat.h>
>  #include <stddef.h>
>  
> +#include <sys/types.h>
> +#include <arpa/inet.h>
> +#include <netdb.h>
> +
>  #include "util/parser.h"
>  #include "nvme-ioctl.h"
>  #include "nvme-status.h"
> @@ -60,6 +64,7 @@ static struct config {
>  	char *nqn;
>  	char *transport;
>  	char *traddr;
> +	char *hostname;
>  	char *trsvcid;
>  	char *host_traddr;
>  	char *hostnqn;
> @@ -857,6 +862,54 @@ static int build_options(char *argstr, int max_len, bool discover)
>  	return 0;
>  }

The code looks fine.

I realize 'hostname' in this context is referring to the remote host and
resolves the target's transport address, but it just sounds potentially
confusing given we have "host_traddr". I'm not sure of a better name,
though, so if this is normal convention, then okay.
  
> +static int hostname2traddr(struct config *cfg)
> +{
> +	struct addrinfo *host_info, hints = {.ai_family = AF_UNSPEC};
> +	char addrstr[NVMF_TRADDR_SIZE];
> +	const char *p;
> +	int ret;
> +
> +	if (cfg->traddr) {
> +		fprintf(stderr, "hostname and traddr cannot be passed together\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = getaddrinfo(cfg->hostname, NULL, &hints, &host_info);
> +	if (ret) {
> +		fprintf(stderr, "failed to get host info for %s\n", cfg->hostname);
> +		return ret;
> +	}
> +
> +	switch (host_info->ai_family) {
> +	case AF_INET:
> +		p = inet_ntop(host_info->ai_family,
> +			&(((struct sockaddr_in *)host_info->ai_addr)->sin_addr),
> +			addrstr, NVMF_TRADDR_SIZE);
> +		break;
> +	case AF_INET6:
> +		p = inet_ntop(host_info->ai_family,
> +			&(((struct sockaddr_in6 *)host_info->ai_addr)->sin6_addr),
> +			addrstr, NVMF_TRADDR_SIZE);
> +		break;
> +	default:
> +		fprintf(stderr, "unrecognized address family (%d) %s\n",
> +			host_info->ai_family, cfg->hostname);
> +		ret = -EINVAL;
> +		goto free_addrinfo;
> +	}
> +
> +	if (!p) {
> +		fprintf(stderr, "failed to get traddr for %s\n", cfg->hostname);
> +		ret = -errno;
> +		goto free_addrinfo;
> +	}
> +	cfg->traddr = strdup(addrstr);
> +
> +free_addrinfo:
> +	freeaddrinfo(host_info);
> +	return ret;
> +}
> +
>  static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
>  {
>  	char argstr[BUF_SIZE], *p;
> @@ -1230,6 +1283,13 @@ static int discover_from_conf_file(const char *desc, char *argstr,
>  		if (cfg.persistent && !cfg.keep_alive_tmo)
>  			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
>  
> +		if (cfg.hostname) {
> +			ret = hostname2traddr(&cfg);
> +			if (ret)
> +				goto out;
> +			cfg.hostname = NULL;
> +		}
> +
>  		err = build_options(argstr, BUF_SIZE, true);
>  		if (err) {
>  			ret = err;
> @@ -1259,6 +1319,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
>  	OPT_ARGS(opts) = {
>  		OPT_LIST("transport",      't', &cfg.transport,       "transport type"),
>  		OPT_LIST("traddr",         'a', &cfg.traddr,          "transport address"),
> +		OPT_LIST("hostname",       'A', &cfg.hostname,        "transport address in a hostname form"),
>  		OPT_LIST("trsvcid",        's', &cfg.trsvcid,         "transport service id (e.g. IP port)"),
>  		OPT_LIST("host-traddr",    'w', &cfg.host_traddr,     "host traddr (e.g. FC WWN's)"),
>  		OPT_LIST("hostnqn",        'q', &cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
> @@ -1295,6 +1356,13 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
>  	} else {
>  		if (cfg.persistent && !cfg.keep_alive_tmo)
>  			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
> +
> +		if (cfg.hostname) {
> +			ret = hostname2traddr(&cfg);
> +			if (ret)
> +				goto out;
> +		}
> +
>  		ret = build_options(argstr, BUF_SIZE, true);
>  		if (ret)
>  			goto out;
> @@ -1315,6 +1383,7 @@ int fabrics_connect(const char *desc, int argc, char **argv)
>  		OPT_LIST("transport",         't', &cfg.transport,         "transport type"),
>  		OPT_LIST("nqn",               'n', &cfg.nqn,               "nqn name"),
>  		OPT_LIST("traddr",            'a', &cfg.traddr,            "transport address"),
> +		OPT_LIST("hostname",          'A', &cfg.hostname,          "transport address in a hostname form"),
>  		OPT_LIST("trsvcid",           's', &cfg.trsvcid,           "transport service id (e.g. IP port)"),
>  		OPT_LIST("host-traddr",       'w', &cfg.host_traddr,       "host traddr (e.g. FC WWN's)"),
>  		OPT_LIST("hostnqn",           'q', &cfg.hostnqn,           "user-defined hostnqn"),
> @@ -1339,6 +1408,12 @@ int fabrics_connect(const char *desc, int argc, char **argv)
>  	if (ret)
>  		goto out;
>  
> +	if (cfg.hostname) {
> +		ret = hostname2traddr(&cfg);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	ret = build_options(argstr, BUF_SIZE, false);
>  	if (ret)
>  		goto out;
> -- 
> 2.20.1
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
