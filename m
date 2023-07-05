Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFBDEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jul 2023 09:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QUx+G9Ikc1JcrkULELUyJhcCdeD93Kd+JwIOZOQVEPo=; b=CAuK9vS/kVMisFyAxSyhinXyJ3
	D9FobRPAwVCSE1eirzDv2WGSyVXhFke4otFBVF7uwoEoi/U5uJPqGIay1YNVkgzxC83opyg2ENjgP
	gKqjcT/W9wmiExtuG38vN43wZT6tm3gxmMbGFQ+Qx+Sfw7Mo0SC8sZdEUreIUxIMNK/KtgiDgeouB
	I0rvE5KZ3+xs9yn6eWiS2CVA+CRdoAYBljM+o63fomOUcNYwlYbuKSlE7mXmMrWlG6nKacT4m3oCx
	s/r3uUWCS/bsIDmY5Pw3NEbn3ZMgA+hR3VTFI/1rePTifKQR5a6ksg1FR2sBWDdRQho4m7MkaURNp
	z9p2OP8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGyY9-00FJiW-2A;
	Wed, 05 Jul 2023 09:11:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGyY4-00FJhY-1T
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jul 2023 09:11:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E5EC22422;
	Wed,  5 Jul 2023 09:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688548300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUx+G9Ikc1JcrkULELUyJhcCdeD93Kd+JwIOZOQVEPo=;
	b=wqN58WNBWlHAO9OXbYJtpheItBWrHWGwEo47PaYvozDMyFfbXNwxDC4QeKrufVG+qoba3k
	da0adc/jyMLYjS5pvcAWDq2HmZlISTg7JHfAnstLV3/ELZDHdBPFKfuicwwRWWn6Ig3135
	CZrMF2ezCKXl+sbd2oPgorEAi6QtDwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688548300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUx+G9Ikc1JcrkULELUyJhcCdeD93Kd+JwIOZOQVEPo=;
	b=bQmoS0BDHSY+2qmHWf9lVBW6yHNjkSodYRrXPggyZl2wCfBRkiza0vH/bRoA2qTAOewIDX
	YmPVwz7oYfDXLuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FBAF134F3;
	Wed,  5 Jul 2023 09:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UChrE8wzpWTaZAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 05 Jul 2023 09:11:40 +0000
Date: Wed, 5 Jul 2023 11:11:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Message-ID: <4rzx7tets37h3tifirq3i63nh5n45cbmiu4xdwvoojhdmqquv2@rwnidq3hbuwg>
References: <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <lfwwdbrtexufmsjbrw5j36jay2m56kdnuzwcrmcwnickzmgb4i@b5d32kl3oaps>
 <zftdt4pmjiwnbkje2zpl2kp5oraapsrawpbwf3l5qppmegpylj@so52n3f5zd6u>
 <l7vk7fnzltpmvkwujsbf2btrzip6wh7ug62iwa3totqcda25l6@siqx7tj6lt3l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l7vk7fnzltpmvkwujsbf2btrzip6wh7ug62iwa3totqcda25l6@siqx7tj6lt3l>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230705_021144_658797_A1759ADB 
X-CRM114-Status: GOOD (  15.73  )
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

On Fri, Jun 30, 2023 at 08:48:55AM +0000, Shinichiro Kawasaki wrote:
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
> +	return strdup(uuid);
> +}

Maybe we should move the check after ...


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

... here so that we also catch the case when the /etc/nvme/hostnqn and /etc/nvme/hostid
do not match

