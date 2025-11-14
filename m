Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EEFCDE019
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 07:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7AY/BhDqFCWJX0nQdTNN0uKI7uocSILLvpS/ffLAsX8=; b=sDvZ38MTlWEGGmRQTtxWP3JfxV
	xBHOC1uaUIDWNGGADg+bMGzOVmqgVGCw6dZla931GuctBjyBpxUQB23fJCNg6qEWaZkl4QekMowGW
	rW9qKQyibPJOjDnjiPkbWHGdsYRqIYlnqgXVNrbNOHbziuO8or5+H7AHvs/2zMPkAxqbcqxK72q+p
	vj04f4ms2mocJWP94Y3JIESm8MlkF3arJGE3/8/jZ9+0K2WsONaoFk0GOXuBl12xf0fN1clUYvm/9
	ygsRcTXqHzdGv5XEf61L2ev5774jfB27bX4eHVSEKg8WrN2GIqJPvfXI7uDCrFAmuhT9qTjcDMpXz
	0WAcG6jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJo2C-0000000Bjea-2GUc;
	Fri, 14 Nov 2025 07:15:52 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJo29-0000000Bje0-23hW
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 07:15:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2702B1F394;
	Fri, 14 Nov 2025 07:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763104547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7AY/BhDqFCWJX0nQdTNN0uKI7uocSILLvpS/ffLAsX8=;
	b=OUaqsBPoxiOOPereyGLE1+hdlB2F3KdSvWN9rPggYrZqGlm8X6zl7M30uTiFFd2WU3N7er
	C79sYEbgdwOKgRvWErYnihAPVY8lD+i9vbfEzn682KoT5wJU6INn/+Nbo9VapEEOxy0R7L
	YY/z3uTWLe6ZfDdovn6hhSGF94+qyo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763104547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7AY/BhDqFCWJX0nQdTNN0uKI7uocSILLvpS/ffLAsX8=;
	b=9c/P9RsdipbeB0LeyTLtwH5iqnrskfdhNOQMI1r2wCj/yvVEgdECiHE40Sls5N2lhPt+LC
	sR5Ps7x2dRJEykDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763104547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7AY/BhDqFCWJX0nQdTNN0uKI7uocSILLvpS/ffLAsX8=;
	b=OUaqsBPoxiOOPereyGLE1+hdlB2F3KdSvWN9rPggYrZqGlm8X6zl7M30uTiFFd2WU3N7er
	C79sYEbgdwOKgRvWErYnihAPVY8lD+i9vbfEzn682KoT5wJU6INn/+Nbo9VapEEOxy0R7L
	YY/z3uTWLe6ZfDdovn6hhSGF94+qyo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763104547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7AY/BhDqFCWJX0nQdTNN0uKI7uocSILLvpS/ffLAsX8=;
	b=9c/P9RsdipbeB0LeyTLtwH5iqnrskfdhNOQMI1r2wCj/yvVEgdECiHE40Sls5N2lhPt+LC
	sR5Ps7x2dRJEykDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDF193EA61;
	Fri, 14 Nov 2025 07:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DAwYLCLXFmmlUgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 14 Nov 2025 07:15:46 +0000
Message-ID: <e15b39ad-bfdf-4177-86b7-99c84975825e@suse.de>
Date: Fri, 14 Nov 2025 08:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] nvme: Allow reauth from sysfs
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
 <20251114045850.1898865-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251114045850.1898865-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,infradead.org:email,wdc.com:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_231549_697104_6B0107EE 
X-CRM114-Status: GOOD (  26.07  )
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

On 11/14/25 05:58, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing  a zero to the sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>   - Only trigger if a 0 is written to `tls_configured_key`
>   - Add documentation
> v2:
>   - Trigger on any value written to `tls_configured_key`
> 
>   Documentation/ABI/testing/sysfs-nvme | 13 +++++++++++
>   drivers/nvme/host/sysfs.c            | 34 +++++++++++++++++++++++++++-
>   2 files changed, 46 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-nvme
> 
> diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/testing/sysfs-nvme
> new file mode 100644
> index 000000000000..16aaf0dca9e2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-nvme
> @@ -0,0 +1,13 @@
> +What:		/sys/devices/virtual/nvme-fabrics/ctl/.../tls_configured_key
> +Date:		November 2025
> +KernelVersion:	6.19
> +Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
> +Description:
> +		The file is avaliable when using a secure concatanation
> +		connection to a NVMe taget. Reading the file will return
> +		the serial of the currently negotiated key.
> +
> +		Writing 0 to the file will trigger a PSK reauthentication
> +		(REPLACETLSPSK) with the target. After a reauthentication
> +		the value returned by tls_configured_key will be the new
> +		serial.
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 6d10e12136d0..7ff9a5053c3f 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -806,7 +806,39 @@ static ssize_t tls_configured_key_show(struct device *dev,
>   
>   	return sysfs_emit(buf, "%08x\n", key_serial(key));
>   }
> -static DEVICE_ATTR_RO(tls_configured_key);
> +
> +static ssize_t tls_configured_key_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	int error, qid;
> +
> +	error = kstrtoint(buf, 10, &qid);
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * We currently only allow userspace to write a `0` indicating
> +	 * generate a new key.
> +	 */
> +	if (!qid)
> +		return -EINVAL;
> +
> +	if (!ctrl->opts || !ctrl->opts->concat)
> +		return -EOPNOTSUPP;
> +
> +	error = nvme_auth_negotiate(ctrl, 0);
> +	if (error < 0)
> +		return error;
> +
> +	error = nvme_auth_wait(ctrl, 0);
> +	if (error < 0)
> +		return error;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(tls_configured_key);
>   
>   static ssize_t tls_keyring_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)

Hmm.
Now we are just running (re-) authentication, but that does
not affect the TLS connection (which continues to use the
original key). So you would need to reset the connection
here to re-establish a new TLS connection.

Also: if the authentication fails you need to tear down
the connection (cf NVMe Base Spec 2.1, section 8.3.4.5.1
Protocol Operations).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

