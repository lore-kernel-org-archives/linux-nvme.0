Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA246C6FA86
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 07:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ULNJp33CyCucLl+yeKsYqGRdd70y7HWUwE8ChHWnzQE=; b=VnMvGd42w6juC5QgYH9QOXZagt
	AjC2QMkgOV6TiE30kbI98hkzPpKzeoBw1BNeiP+YDRKcTBVrC8pmqJ8tdyVAD0y4apgSiZxNpH7GX
	cg57Nc/UKgA/TQedMRcA+ZfbFwiRL+ndarGNXlfmTHxWPj1eMx6MC4JTVeYjRTFdZq70uO2OkkIU9
	GCJXq8Czk3TDsoi/S3x+rUIP5ZlRUn622Fqp7uKcYfnYZiQEBtujOa7hzC4tk8AM8fdztwdinj4BF
	vcQsXn5NLpulacbN6pfSNaLM2OYyCv3iIvhR/YL0Y5d5P1DhO/34zI1qPU1CeHGJqPKoxqYoIEQeN
	iohSmduQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5O9-008tCb-BR; Tue, 27 Sep 2022 07:52:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5O5-008t9I-Hf
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 07:52:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BC9821D5E;
	Tue, 27 Sep 2022 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664265134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULNJp33CyCucLl+yeKsYqGRdd70y7HWUwE8ChHWnzQE=;
	b=jfNbzBFBAinjrDXUlYFgq4dUYVG9LCL1pmdxWFTblUFbVGKKgzGybs+v9o08EF4GuHystJ
	jXnkkpvdMIVvWGj96UfpgjFy5O+Wt3JF4sFBDzqfZPJm2jkZztpjxOREz0FqTv2geZlDNa
	VbCbzPgEEqhcFgQzXtFhUKIMYOOK4Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664265134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULNJp33CyCucLl+yeKsYqGRdd70y7HWUwE8ChHWnzQE=;
	b=Md4Pqw2gKEj4lZI6ELfG9ly9HO6jlQuZ71d7m083Sw0W5aTBGJf0AYFxvwWRutiorkPmMH
	UUVocNKT6gNRpXDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C9FD139B3;
	Tue, 27 Sep 2022 07:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YRqTFq6rMmMXBwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 27 Sep 2022 07:52:14 +0000
Date: Tue, 27 Sep 2022 09:52:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Belanger@carbon.lan, Martin <Martin.Belanger@dell.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <james.smart@broadcom.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/2 nvme-cli] fabrics: re-read the discovery log page
 when a discovery controller reconnected
Message-ID: <20220927075213.6idrtq4sbiobtr3m@carbon.lan>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922081538.13364-4-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_005217_811901_3D0F25EB 
X-CRM114-Status: GOOD (  20.93  )
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

On Thu, Sep 22, 2022 at 11:15:38AM +0300, Sagi Grimberg wrote:
> When using persistent discovery controllers, if the discovery controller
> loses connectivity and manage to reconnect after a while, we need to
> retrieve again the discovery log page in order to learn about possible
> changes that may have occurred during this time as discovery log change
> events were lost.
> 
> Upon reception of a udev EVENT=rediscover we can kickstart discovery on
> the existing discovery controller device node that generated the event.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> index 434cc080ffe3..93e438863672 100644
> --- a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> +++ b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> @@ -17,3 +17,10 @@ ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_AEN}=="0x70f002",\
>  ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
>    ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
>    RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=none\t--transport=fc\t--traddr=$env{NVMEFC_TRADDR}\t--trsvcid=none\t--host-traddr=$env{NVMEFC_HOST_TRADDR}.service"
> +
> +# A discovery controller just (re)connected, re-read the discovery log change to
> +# check if there were any changes since it was last connected.
> +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="rediscover", ATTR{cntrltype}=="discovery", \
> +  ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
> +  ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
> +  RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=$kernel\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"

I was about to apply the change. Though I just added the change from
Martin where the --host_iface argument is added to the first nvme
rule.

https://github.com/linux-nvme/nvme-cli/pull/1675

I wonder to we need to it to append the --host_iface argument as well.

Daniel

