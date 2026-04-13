Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7007EBFD0F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 07:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NLhhof7kbH+AItDTP9nCMJIRs3nHC+6fCAilTQ4zMbE=; b=X6yFUpuMJpzDlG/e5lR/6OCo88
	gX+P8JyEJ9hp8r3vNpCqjgOC3Ag0N63cosfjCmUGXIG4laMrpxc0nSh5vx0Nl932EKnaUYEnzwAjZ
	WKV7dDEYvd1aGv4pNQbJL8DIHtzmJ4jxYtFBykzd9ktoHTSE+v5xW0egKdFe/C4PyzG5jMhQq7dN7
	y0OlyjnQAEmufgTxtTARLTbBOuIlJc99JIqWMUvooT4qs8WCtq/r96tB20AkQfgAm+ST3D2aaRHB3
	JCnaiKsi4r78NvnQ3UDjNt00x1EeI5yAwGCQxW0bKzDZLLDbIZlqqCEXRy73MD0miZ+vdUfFTFCII
	QejGzxCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCBxb-0000000FAjN-1pK9;
	Mon, 13 Apr 2026 07:43:55 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCBxY-0000000FAhp-2GBH
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 07:43:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0633B5BD09;
	Mon, 13 Apr 2026 07:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776066229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLhhof7kbH+AItDTP9nCMJIRs3nHC+6fCAilTQ4zMbE=;
	b=EPnnlutFvLz5fJAcS6UO7vtOVwH/KfwUhCKmIaSumUy/2tjmQuAW5cr/J/86DWRaGqQ87D
	O+us0HgMZPOVUqROsWXdBhtDHA6GpECN9VtEVN5FadD87vZ5G6r5YVoX93HHm8/ugm4K5C
	ztw455gaU5YtAlQYCG6k6C5Umpx9p6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776066229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLhhof7kbH+AItDTP9nCMJIRs3nHC+6fCAilTQ4zMbE=;
	b=dgYNZNUV3FNQ/sdgZmBms+OK/cXoX/1mlmxr+FIHXyTRXzbzMqJwbrDNFtFYqtfggIb1k/
	aArrkjeS9c2B98AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776066229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLhhof7kbH+AItDTP9nCMJIRs3nHC+6fCAilTQ4zMbE=;
	b=EPnnlutFvLz5fJAcS6UO7vtOVwH/KfwUhCKmIaSumUy/2tjmQuAW5cr/J/86DWRaGqQ87D
	O+us0HgMZPOVUqROsWXdBhtDHA6GpECN9VtEVN5FadD87vZ5G6r5YVoX93HHm8/ugm4K5C
	ztw455gaU5YtAlQYCG6k6C5Umpx9p6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776066229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLhhof7kbH+AItDTP9nCMJIRs3nHC+6fCAilTQ4zMbE=;
	b=dgYNZNUV3FNQ/sdgZmBms+OK/cXoX/1mlmxr+FIHXyTRXzbzMqJwbrDNFtFYqtfggIb1k/
	aArrkjeS9c2B98AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4E9F4AD8D;
	Mon, 13 Apr 2026 07:43:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MAWvLrSe3GlWYAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Apr 2026 07:43:48 +0000
Message-ID: <6036790e-99d0-4f89-9112-6b0c65d0a566@suse.de>
Date: Mon, 13 Apr 2026 09:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: expose TLS mode
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260408-expose-tls-mode-v3-1-b869da028eff@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260408-expose-tls-mode-v3-1-b869da028eff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_004352_726737_07FCC90A 
X-CRM114-Status: GOOD (  27.64  )
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

On 4/8/26 18:19, Daniel Wagner wrote:
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
> Fixed visibilty condition, the previous version used opts->tls_key but it should
> opts->tls.
> 
> Original cover letter (with fixed example):
> 
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
> $ nvme connect --transport tcp --traddr 192.168.30.30 --trsvcid 4420  \
>    		--hostnqn nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36  \
> 		--nqn nqn.io-1 --concat  \
> 		--dhchap-secret=DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:   \
> 		--dump-config --output-format json
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
>              "concat":true
>            }
>          ]
>        }
>      ]
>    }
> ]
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
>              "concat":true
>            }
>          ]
>        }
>      ]
>    }
> ]
> 
> $ cat /sys/class/nvme-fabrics/ctl/nvme1/tls_mode
> concat
> ---
> Changes in v3:
> - Fixed visibilty conditions to opts->tls instead of opts->tls_key
> - Link to v2: https://patch.msgid.link/20260408-expose-tls-mode-v2-1-17a25aa414dc@kernel.org
> 
> Changes in v2:
> - fixed the example output
> - tls_mode only visible when either tls or concat is enabled. avoids 'none'
> - Link to v1: https://patch.msgid.link/20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org
> ---
>   drivers/nvme/host/sysfs.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 16c6fea4b2db..df25c8fef063 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -841,10 +841,26 @@ static ssize_t tls_keyring_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(tls_keyring);
>   
> +static ssize_t tls_mode_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	const char *mode;
> +
> +	if (ctrl->opts->tls)
> +		mode = "tls";
> +	else
> +		mode = "concat";
> +
> +	return sysfs_emit(buf, "%s\n", mode);
> +}
> +static DEVICE_ATTR_RO(tls_mode);
> +
>   static struct attribute *nvme_tls_attrs[] = {
>   	&dev_attr_tls_key.attr,
>   	&dev_attr_tls_configured_key.attr,
>   	&dev_attr_tls_keyring.attr,
> +	&dev_attr_tls_mode.attr,
>   	NULL,
>   };
>   
> @@ -866,6 +882,9 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
>   	if (a == &dev_attr_tls_keyring.attr &&
>   	    !ctrl->opts->keyring)
>   		return 0;
> +	if (a == &dev_attr_tls_mode.attr &&
> +	    !ctrl->opts->tls && !ctrl->opts->concat)
> +		return 0;
>   
>   	return a->mode;
>   }
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

