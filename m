Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2A0EDB7F2
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxwlNxQdC9flJRNusgvHrRLd9XlseS96nRkGKLydNW0=; b=riuRiX9AGEOXR+reWP3FQ26DAP
	mOuGxZWxxuKwBSd0HDXYdG8+lLGQaJM/n8jO2ZoSJy0wSRoHzHX2Rqlj2breozGW3va3b0ivUwLLx
	MdCvalL/FQJuAHC/DIMfwUQkdJWrS0IrxMp7xqBP1PoL6QtH/+254Gt+8GmygfXt2iP3LPE1RhVw7
	ftEPq80xC0llOctGFMwYRy3aBwky/X/n2kH2Beb30DlnXmj37TeSJEgm0LhIa7HXSdd47L6qGJGlQ
	DAvTWvmiE6jY/YTdz9w85+s2qrAABBRVkTA02cT9qTil18YbtOFVOgxS8JIQ7EbKCLrogrTrnMNiF
	i/PyObAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA3yV-00000006Keo-0ODN;
	Tue, 07 Apr 2026 10:48:03 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA3yS-00000006KeP-0ukP
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 10:48:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D4534E3F2;
	Tue,  7 Apr 2026 10:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775558878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxwlNxQdC9flJRNusgvHrRLd9XlseS96nRkGKLydNW0=;
	b=DZ34gODjKN5AzG4TIinRbNrs0kRJvppb+LEsSh0cHx5JRZTMeZzH96tGyL3u0Wmo8sbGP5
	/Y0QbSD5GHvlfbnUaYA7L82v7QOdKAJFbqBy7ofk+t5QR1cZbVZ4WjV6w6Zf9DFSc8hm16
	IbrFMgWgzXN8mOdcA5k5/FjwNj5KEV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775558878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxwlNxQdC9flJRNusgvHrRLd9XlseS96nRkGKLydNW0=;
	b=ycieUkG64m2B4M9VqFhOgmbkwIU7mR5iLgIzEW/eGghjjUix9zsWck2k+8UxkOwj/72fE7
	CLD7xN0mE+IK5sCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775558878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxwlNxQdC9flJRNusgvHrRLd9XlseS96nRkGKLydNW0=;
	b=DZ34gODjKN5AzG4TIinRbNrs0kRJvppb+LEsSh0cHx5JRZTMeZzH96tGyL3u0Wmo8sbGP5
	/Y0QbSD5GHvlfbnUaYA7L82v7QOdKAJFbqBy7ofk+t5QR1cZbVZ4WjV6w6Zf9DFSc8hm16
	IbrFMgWgzXN8mOdcA5k5/FjwNj5KEV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775558878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxwlNxQdC9flJRNusgvHrRLd9XlseS96nRkGKLydNW0=;
	b=ycieUkG64m2B4M9VqFhOgmbkwIU7mR5iLgIzEW/eGghjjUix9zsWck2k+8UxkOwj/72fE7
	CLD7xN0mE+IK5sCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48A634A0B0;
	Tue,  7 Apr 2026 10:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cvhFEd7g1GlNLQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 10:47:58 +0000
Message-ID: <77b7fc41-840e-43cc-a417-cbd78a9ba6aa@suse.de>
Date: Tue, 7 Apr 2026 12:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: expose TLS mode
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_034800_490369_BC1A0B50 
X-CRM114-Status: GOOD (  25.29  )
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

On 4/1/26 10:52, Daniel Wagner wrote:
> It is not possible to determine the active TLS mode from the
> presence or absence of sysfs attributes like tls_key,
> tls_configured_key, or dhchap_secret.
> 
> With the introduction of the concat mode and optional DH-CHAP
> authentication, different configurations can result in identical
> sysfs state. This makes user space detection unreliable.
> 
> Expose the TLS mode explicitly to allow user space to
> unambiguously identify the active configuration and avoid
> fragile heuristics in nvme-cli.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
> I am extending the test suite for nvme-cli to cover the use case of
> nvme connect --tls/--concat.
> 
> Currently, nvme-cli uses heuristics to determine whether --tls was used
> to initiate the connection. With the introduction of --concat, these
> heuristics are no longer reliable.
> 
> By exposing the TLS mode explicitly, nvme config can now generate a
> configuration based on the currently active connection.
> 
> $ nvme config --scan --dump --output-format json /dev/nvme1
> [
>    {
>      "hostnqn":"nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36",
>      "hostid":"befdec4c-2234-11b2-a85c-ca77c773af36",
>      "dhchap_key":"DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:",
>      "subsystems":[
>        {
>          "nqn":"nqn.io-1",
>          "ports":[
>            {
>              "transport":"tcp",
>              "traddr":"192.168.30.30",
>              "trsvcid":"4420",
>              "dhchap_key":"DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:",
>              "dhchap_ctrl_key":"DHHC-1:01:uTcIEwLZsEoVJucx7sKVvzfwOTAfJ9ZGcvYWswHwF41mMSW1:",
>              "tls":true,
>              "keyring":".nvme"
>            }
>          ]
>        }
>      ]
>    }
> ]
> ---
>   drivers/nvme/host/sysfs.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 16c6fea4b2db..c4b5241371d6 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -810,6 +810,23 @@ const struct attribute_group nvme_dev_attrs_group = {
>   EXPORT_SYMBOL_GPL(nvme_dev_attrs_group);
>   
>   #ifdef CONFIG_NVME_TCP_TLS
> +static ssize_t tls_mode_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	const char *mode;
> +
> +	if (ctrl->opts->tls)
> +		mode = "tls";
> +	else if (ctrl->opts->concat)
> +		mode = "concat";
> +	else
> +		mode = "none";
> +
> +	return sysfs_emit(buf, "%s\n", mode);
> +}
> +static DEVICE_ATTR_RO(tls_mode);
> +
>   static ssize_t tls_key_show(struct device *dev,
>   			    struct device_attribute *attr, char *buf)
>   {
> @@ -845,6 +862,7 @@ static struct attribute *nvme_tls_attrs[] = {
>   	&dev_attr_tls_key.attr,
>   	&dev_attr_tls_configured_key.attr,
>   	&dev_attr_tls_keyring.attr,
> +	&dev_attr_tls_mode.attr,
>   	NULL,
>   };
>   
> 
Why not modify the 'is_visible' function to hide the attribute
when TLS is not enabled?
That would avoid the awkward 'none' setting ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

