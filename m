Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE52ECAAD3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 06:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yeSvb1pCRtH3BQQai97dt5xxpLT7+yWQj/okWPsOwjk=; b=aBOV0baVwvxxZxvEvQgNkaJ1Rv
	nD701KpsCPAaN15G6YPNktn+otGFiBqN8ERxooiNL0OAulWlrd6Q7dkCQt4mIdLGqNNyFAPA6f5zi
	6xMMVnI3jH1xc3NL0LGjhHddTaL280+knUu0hGNvb56kUx72aVHiN/XylSYpX2U7diPVKPhcrDsrG
	cl/MLBm9HSgJ9cJrc8zniuYVv5b+IjqVHsTWTiu0ps92+C5xveSb5B3JnEMqRzXWRR3+pnbcUXb7v
	oOdIBpAZJPSFOJMzSeyCtbBdZDJtm22HK7wK2XaIMBSt1F+V8GPfRP1isTi2CGNfimPa7DhOXaYZC
	6ec2sOmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWXyW-00DaUw-Jw; Fri, 09 Sep 2022 06:58:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWXyU-00DaQf-1C
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 06:58:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F8D21F8C6;
	Fri,  9 Sep 2022 06:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662706727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeSvb1pCRtH3BQQai97dt5xxpLT7+yWQj/okWPsOwjk=;
	b=WzReiACdirUs6q/QDJL7IbtomXBwUkzOveWtGg+6uVF60iMhKrJoUepJir5g+d/kps+Z3H
	imyygdtmxe1qKcewvvaTVw4AnBRo4ompXSD4p4A79UCPuXrkA3ZWDa//FCp0paECi0rt0/
	rjHhj2LF/VXhc1LcATZQJBNXsaY86ZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662706727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeSvb1pCRtH3BQQai97dt5xxpLT7+yWQj/okWPsOwjk=;
	b=lAXfBM6DvWSWOgPC1yXD1T+mY1ceT7uEm2AfjnAfRSSfyWzbPYq1xkBRhTeuqFJvOOZKzk
	RNyMJYMUWbWnSoDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 602BA13A93;
	Fri,  9 Sep 2022 06:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2rjqFifkGmNJJQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 09 Sep 2022 06:58:47 +0000
Date: Fri, 9 Sep 2022 08:58:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Martin Belanger <nitram_67@hotmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH libnvme 3/1] fabrics: add notify_rediscover parameter
Message-ID: <20220909065846.b7fu53pvyvp6qtpp@carbon.lan>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <20220907142411.101950-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907142411.101950-4-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_235850_245390_80653BB2 
X-CRM114-Status: GOOD (  10.64  )
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

On Wed, Sep 07, 2022 at 05:24:10PM +0300, Sagi Grimberg wrote:
> @@ -481,6 +482,8 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
>  	    (hostid && add_argument(argstr, "hostid", hostid)) ||
>  	    (discover && !discovery_nqn &&
>  	     add_bool_argument(argstr, "discovery", true)) ||
> +	     add_bool_argument(argstr, "notify_rediscover",
> +			       cfg->notify_rediscover) ||

If notify_rediscover is not supported by the kernel, wouldn't this end
up with an EINVAL when we try to connect? I thought we need to make this
conditional.

