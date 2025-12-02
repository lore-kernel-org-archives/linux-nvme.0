Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3090CFD2F6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 15:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h6kQNbPeKf4oy5KKXviez7TCTV6nNtW3S9FWe5RYWv0=; b=rKqKe8D6g/J3glkSf5rZj0P5MY
	nOd7dfM/USFywPm+0NXgoPbb7txJpug7J/kyYWCiclxMK7Z2tRM/aDZwjalfHJmnEV0i7A8aAz5aP
	vLHxsJU8D2/1ydB3bVi+BgQ1DvGif3QeTN8yfTg0lYZbGkVDbVeYmvd5N1uNPqsdZEWrALm6jwFLr
	7Ab4liFNErWqwKbCNB9aKAD0NbC4wNnqoxg43c0Fm9IrS6FHcEONMhVG5S3UxrLO43tmknBvnllI1
	X928aMkIc5G+R2rU2O81LAfqCPYVcGlpWBE0J7B9bU7bHMeJWc9u7QKKb9Ev82KT6FSUt7lcGclUf
	wF2Pgenw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQSKx-00000005YQ6-3H5W;
	Tue, 02 Dec 2025 15:30:43 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQSKu-00000005YPL-42gF
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 15:30:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE7C25BCCB;
	Tue,  2 Dec 2025 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764689437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6kQNbPeKf4oy5KKXviez7TCTV6nNtW3S9FWe5RYWv0=;
	b=tQeX+UhJmvqREkSx0DCWXLQX+wysKl+Kf51g+lFn2N7Bx2eYNiesuo3hW8resS6LsIF0o4
	vbnd8T2RE4RTNhowB5laTglyG5OUFE5BFS2TsqvmuctVq745BpnO8qZznIulm21bhsiqUB
	N2rhlUlyepkoBtoeh7Jciw7PdSCs9DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764689437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6kQNbPeKf4oy5KKXviez7TCTV6nNtW3S9FWe5RYWv0=;
	b=esgK5jMtmfwzt0xfB4agcZcUEOJtaaOdfoV4QNRYxnyr/sL+C3B+soXpPgESRoVt4B05vY
	x7g6dEN5yj9M+1Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764689434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6kQNbPeKf4oy5KKXviez7TCTV6nNtW3S9FWe5RYWv0=;
	b=hPmLkwIn+fNuETiEUjbdC/BOMxZCVMCHbh3G+7Cu57lDAyspdcUmjckI6gEL02EgUayWEg
	njJC2mqmh6OE2Sjyr5l8T7wyuomPFpuBNhZN2u9mjKfAO4E69kZ0MfGXSlZd40xOjB/LSH
	xVcW3njqINsRtcZIOoydkElvu1xXswk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764689434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6kQNbPeKf4oy5KKXviez7TCTV6nNtW3S9FWe5RYWv0=;
	b=dGJPRmBBoGCT3VIjC3UNM8nC9ay7sLELZb67tg7EkigyC2O/ZZyfU+1yTPc4gEP8Q7uwWM
	UGrs9eOItWKcQkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D5E13EA63;
	Tue,  2 Dec 2025 15:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9NiYFRoGL2nKLwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Dec 2025 15:30:34 +0000
Message-ID: <6ee5d2e8-71c3-4aae-be63-759c8e56a742@suse.de>
Date: Tue, 2 Dec 2025 16:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] nvme: Allow reauth from sysfs
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
 <20251202051755.1312158-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251202051755.1312158-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.965];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,infradead.org:email,wdc.com:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_073041_174026_2ABE2030 
X-CRM114-Status: GOOD (  25.58  )
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

On 12/2/25 06:17, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing  a zero to the sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
> 
> In order to use the new keys for the admin queue we call controller
> reset. This isn't ideal, but I can't find a simpler way to reset the
> admin queue TLS connection.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v4:
>   - Forcefully reset the connection
> v3:
>   - Only trigger if a 0 is written to `tls_configured_key`
>   - Add documentation
> v2:
>   - Trigger on any value written to `tls_configured_key`
> 
>   Documentation/ABI/testing/sysfs-nvme | 13 ++++++++
>   drivers/nvme/host/sysfs.c            | 44 +++++++++++++++++++++++++++-
>   2 files changed, 56 insertions(+), 1 deletion(-)
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
> index 6d10e12136d0..caf853a0da33 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -806,7 +806,49 @@ static ssize_t tls_configured_key_show(struct device *dev,
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

'indicating generate a new key' is a bit awkward; maybe
'indicating that a new key should be generated'?

Otherwise looks good.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

