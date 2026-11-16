Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3427606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v4t0nTSY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dkZP1rOW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AlKlKGFI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dkZP1rOW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AlKlKGFI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=P6Kgjdi/pAbVpUuDjMbGv1GPRBn/+hsT2H5v3cbG1b0=; b=v4t0nTSYKXnrzt
	UdJ71MSgmqLmljyKEWU1Tkr8ijQ+AWqDWB4yF8gjCeIRUG3V11YoXl8oS3FKefRIk/5UwTqAzMK7r
	mdBzJDaw9P7OR1CapYOoIC1kPewrnKSI6/NQhl36IzsLIm3Quo5Bud0mX7xaXCwNymv4pVT1S0Cyn
	+ad7XaMwz4RT5iNSqDtDg8wp99v8FtCq+ke2ZnGTUBUCGj5Lna7wUsl+fbE0+X2j0dheQ2/WhWumh
	Gcn3dXraZNiMGkW4E7nQjeiHf/mrJg6q8e+ymr5IVhhm0JkVquewy8WZgdSlp4j4yqYFHzNpNNSd8
	/Lk8SpPDYt7uuG/DFasA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSx1J-00000002gSB-2H1n;
	Mon, 16 Nov 2026 13:45:17 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSx1H-00000002gR6-1oZC
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 13:45:16 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A88D51F7D3;
	Mon, 16 Nov 2026 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794836713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6Kgjdi/pAbVpUuDjMbGv1GPRBn/+hsT2H5v3cbG1b0=;
	b=dkZP1rOWk9u+oeNpRHVwJEPqJ0CoRDxDizZqcRZ5b+k8ECqC+f6j/yV6NCmI6hBaWALI5S
	5iQzrKzRrekzRfYB6piLsHLDaNndp0nZ/53RsCZmAKgmlBSHoVawiHpuBS3l7riAfAMOjS
	8pSFgDmXN1NkS0JN5m2Ecn4S1j4E444=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794836713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6Kgjdi/pAbVpUuDjMbGv1GPRBn/+hsT2H5v3cbG1b0=;
	b=AlKlKGFIeZogrZQ3L13JJtxSOXSDsJ8jr6R02tV/jkpeM4Pt58lvbUKXnsOL8e6nAvfrHr
	beMNiaoJgoDRF9AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794836713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6Kgjdi/pAbVpUuDjMbGv1GPRBn/+hsT2H5v3cbG1b0=;
	b=dkZP1rOWk9u+oeNpRHVwJEPqJ0CoRDxDizZqcRZ5b+k8ECqC+f6j/yV6NCmI6hBaWALI5S
	5iQzrKzRrekzRfYB6piLsHLDaNndp0nZ/53RsCZmAKgmlBSHoVawiHpuBS3l7riAfAMOjS
	8pSFgDmXN1NkS0JN5m2Ecn4S1j4E444=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794836713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6Kgjdi/pAbVpUuDjMbGv1GPRBn/+hsT2H5v3cbG1b0=;
	b=AlKlKGFIeZogrZQ3L13JJtxSOXSDsJ8jr6R02tV/jkpeM4Pt58lvbUKXnsOL8e6nAvfrHr
	beMNiaoJgoDRF9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 295D91334C;
	Mon, 16 Nov 2026 13:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f1V3OugI+2qEOQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Nov 2026 13:45:13 +0000
Message-ID: <0288068a-3086-4483-995e-ca4e9abca8fc@suse.de>
Date: Mon, 16 Nov 2026 14:45:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-fabrics: use kfree_sensitive() for the old
 DH-HMAC-CHAP secret
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@kernel.org
References: <20261116100244.7824-1-marting@netapp.com>
 <20261116100244.7824-3-marting@netapp.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261116100244.7824-3-marting@netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,netapp.com:email,suse.de:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,netapp.com:email]
X-Spam-Score: -11.79
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_054515_615607_2CDF2570 
X-CRM114-Status: GOOD (  13.97  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 11:02 AM, Martin George wrote:
> When a connect string overrides dhchap_secret or dhchap_ctrl_secret,
> nvmf_parse_options() frees the previous raw secret with plain kfree().
> The invalid-input path already uses kfree_sensitive(), so do the same
> for the replaced secret.
> 
> Signed-off-by: Martin George <marting@netapp.com>
> ---
>   drivers/nvme/host/fabrics.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index c262538523fb..5ed91557f070 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1026,7 +1026,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				ret = -EINVAL;
>   				goto out;
>   			}
> -			kfree(opts->dhchap_secret);
> +			kfree_sensitive(opts->dhchap_secret);
>   			opts->dhchap_secret = p;
>   			break;
>   		case NVMF_OPT_DHCHAP_CTRL_SECRET:
> @@ -1041,7 +1041,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				ret = -EINVAL;
>   				goto out;
>   			}
> -			kfree(opts->dhchap_ctrl_secret);
> +			kfree_sensitive(opts->dhchap_ctrl_secret);
>   			opts->dhchap_ctrl_secret = p;
>   			break;
>   		case NVMF_OPT_TLS:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

