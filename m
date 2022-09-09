Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCE6ECAAD3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 06:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqSWiaNZZLhugGt++TUKQfWhuXpaGcilIly/Fi48aTY=; b=yCM5/w8KqIFOGd945F6eka0yqI
	K7qUrk/1gB0sJiu7g8rcBcItyozx/9Pzek2Tyb2CR2oY7M8CuyOtpEemQpfHbmjw02umtNAoLrXOg
	IrrKM+Cd8u6J3ACMGBZtEb0oehF9N0HVILTiZnLYtQ81k1IpIlxFL0ohtldvImlCCtaByiMEzg/Md
	JcNn3YEuDUCfGD9603EO6UgG6jbyx5bseZnLAkK17utBoYrmKtYADxDUqRpjkD+apJwzNocoGcLL7
	zpn0TtfF0da0q2Mqvn18NVVG5SNgGT8QwwlRytBLi5Gdiq8ATixT6gFIpmNL9jFo3Xit3J35JkuBJ
	GaMykr3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWXwm-00DYkV-Td; Fri, 09 Sep 2022 06:57:04 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWXwk-00DYXV-7l
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 06:57:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A62AE33926;
	Fri,  9 Sep 2022 06:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662706617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqSWiaNZZLhugGt++TUKQfWhuXpaGcilIly/Fi48aTY=;
	b=ZfaNPxxI4aSY9Ij2MiviGcK09795/5Tg404pZkiD9MnvMQPTh5F2Po961ti8fvy2VPVu2J
	u9nsng0cjiVC/PCwF0x563vX7Kn4pjnGIEAJ/46GHqMnPGtyu09OId4INv/UsZXvxBHpCb
	kTivRkRDCU4oVWBWTuyEVeMZC33UREc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662706617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqSWiaNZZLhugGt++TUKQfWhuXpaGcilIly/Fi48aTY=;
	b=6586s47xgKz7DcxVCXU3PSIr9waMirAN2zbhQuIIciisQ0UUWuhPfiPR2vv4xQe/uB5kRV
	Ae5dZfC0UhpZwQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 935D8139D5;
	Fri,  9 Sep 2022 06:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0NrzI7njGmOzJAAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 09 Sep 2022 06:56:57 +0000
Date: Fri, 9 Sep 2022 08:56:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Martin Belanger <nitram_67@hotmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH libnvme 2/1] nvme: Add generic connect parameter support
 detection
Message-ID: <20220909065657.vnf6lzzfcs7y5nis@carbon.lan>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <20220907142411.101950-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907142411.101950-3-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_235702_465634_13EDB927 
X-CRM114-Status: GOOD (  18.52  )
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

On Wed, Sep 07, 2022 at 05:24:09PM +0300, Sagi Grimberg wrote:
> --- a/src/libnvme.map
> +++ b/src/libnvme.map
> @@ -352,6 +352,7 @@ LIBNVME_1_0 {
>  		nvmf_treq_str;
>  		nvmf_trtype_str;
>  		nvmf_update_config;
> +		nvmf_check_param_support;

New entries go to the 'unreleased' section, this would be LIBNVME_1_2.

> +int nvmf_check_param_support(const char *param, bool *supported)
> +{

I was wondering if t would be better to return all supported features in
one go. Not really sure about it though.

> +	int ret = 0, fd, len;
> +	char buf[0x1000];
> +
> +	fd = open(nvmf_dev, O_RDWR);
> +	if (fd < 0) {
> +		nvme_msg(NULL, LOG_ERR, "Failed to open %s: %s\n",
> +			 nvmf_dev, strerror(errno));

'nvme_msg(NULL,' will always write to the stderr which is kind of bad
for libraries. I think it would okay just to return the error codes in
this function and have the caller do the logging part.

> +		return -ENVME_CONNECT_OPEN;
> +	}
> +
> +	memset(buf, 0x0, sizeof(buf));
> +	len = read(fd, buf, sizeof(buf) - 1);
> +	if (len < 0) {
> +		nvme_msg(NULL, LOG_ERR, "Failed to read from %s: %s\n",
> +			 nvmf_dev, strerror(errno));
> +		ret = -ENVME_CONNECT_READ;
> +		goto out_close;
> +	}
> +	nvme_msg(NULL, LOG_DEBUG, "supported opts: '%.*s'\n",
> (int)strcspn(buf, "\n"), buf);

This triggered my question above why we don't return all supported
features up and have the caller added something like this?

Thanks for doing this! This feature is rotting on my TODO list for a
while...

