Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28A606A746
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gdTVSUgv;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RtpxTKTH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Zx6uh58w;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RtpxTKTH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Zx6uh58w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ghl34wq1FtNUPiIhhVNQsPvTyYStJNLS7xbQDw74B5w=; b=gdTVSUgvh85r3Z
	/HfJK1MQcXZZ8GNgn+RTh4x5nsCqgT5whvaapYUOYe1mSMyvwtxhyfup0MM3SkfxOiBYY0KqqA1G3
	RcWTkfyNSc+/MKdrqJFyA6b/JQnG4nUMVSHZXwP49RFiC8vpj7Lxw33mB8+RH2mcH5SK8kVPL5vC2
	Ztqu0XbCu2u5koH2HfkQkRiMElM/z62QjhoJqNV2QCc5oNgpbVqk80ns68/r6zQ5AsqucsAsM9tnV
	IAl8WC6S2Vnbdztf+0u8Cnh40vknkg8erKYy7RPCLsjiwS3XQ56QamMI0Fppbc00DUWV/XDom1oSZ
	3M7HlIH/BXuOYfSV41YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlV3-00000003xXG-1IK4;
	Tue, 10 Nov 2026 13:02:57 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlV1-00000003xVf-0KeT
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 13:02:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 362331F458;
	Tue, 10 Nov 2026 13:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794315773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ghl34wq1FtNUPiIhhVNQsPvTyYStJNLS7xbQDw74B5w=;
	b=RtpxTKTHgtiC40dwWI6SrYO03JXnh3WgpzIj4HwAwNJj8Ln2GcBWQBbLNM5KFZ4W/djg/9
	olbIXaQZbtIpoMOw4g5DWjnPHfBrne92q4YWD5vFGwyMdQwlTOrpTBjgFSo35HQzoe7xVA
	nhBAh4zWf6OoBjTIQf0ZGxKmMBCaC80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794315773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ghl34wq1FtNUPiIhhVNQsPvTyYStJNLS7xbQDw74B5w=;
	b=Zx6uh58w7OGwRG9wTjMOaw7uGfBvHw/NcBCNI/o10SqVWoS4zCZ2/znUH+1MUofYqTMK6x
	qM9nEqw3rKyIUwAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794315773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ghl34wq1FtNUPiIhhVNQsPvTyYStJNLS7xbQDw74B5w=;
	b=RtpxTKTHgtiC40dwWI6SrYO03JXnh3WgpzIj4HwAwNJj8Ln2GcBWQBbLNM5KFZ4W/djg/9
	olbIXaQZbtIpoMOw4g5DWjnPHfBrne92q4YWD5vFGwyMdQwlTOrpTBjgFSo35HQzoe7xVA
	nhBAh4zWf6OoBjTIQf0ZGxKmMBCaC80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794315773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ghl34wq1FtNUPiIhhVNQsPvTyYStJNLS7xbQDw74B5w=;
	b=Zx6uh58w7OGwRG9wTjMOaw7uGfBvHw/NcBCNI/o10SqVWoS4zCZ2/znUH+1MUofYqTMK6x
	qM9nEqw3rKyIUwAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB8A71339F;
	Tue, 10 Nov 2026 13:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jIacLPwV82qLSgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Nov 2026 13:02:52 +0000
Message-ID: <739b20b7-6921-4b37-8712-433ba19e5b84@suse.de>
Date: Tue, 10 Nov 2026 14:02:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: clean up DH group state on initialization failure
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>, hare@kernel.org,
 hch@lst.de, kbusch@kernel.org, kch@nvidia.com, sagi@grimberg.me
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20261110084832.3508-1-sreekuttan2156239@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261110084832.3508-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lst.de,nvidia.com,grimberg.me];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_050255_436471_C9F4BF91 
X-CRM114-Status: GOOD (  16.46  )
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

On 11/10/26 9:48 AM, Sreeraj S Kurup wrote:
> nvmet_setup_dhgroup() leaves the DH transform and group ID
> initialized when private-key generation, public-key allocation,
> or public-key generation fails.
> 
> A subsequent invocation with the same DH group incorrectly
> returns success because the existing transform and group ID
> are treated as proof of successful initialization.
> 
> Release the transform and reset the group state on initialization
> failures so that subsequent attempts can properly retry setup.
> 
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
> ---
>   drivers/nvme/target/auth.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index ccba84b1344e..7733d50de708 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -105,6 +105,10 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
>   		if (ret < 0) {
>   			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
>   				 __func__, ctrl->cntlid, ret);
> +			crypto_free_kpp(ctrl->dh_tfm);
> +			ctrl->dh_tfm = NULL;
> +			ctrl->dh_gid = 0;
> +			ctrl->dh_keysize = 0;
>   			kfree_sensitive(ctrl->dh_key);
>   			ctrl->dh_key = NULL;
>   			return ret;
> @@ -115,6 +119,10 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
>   		if (!ctrl->dh_key) {
>   			pr_warn("ctrl %d failed to allocate public key\n",
>   				ctrl->cntlid);
> +			crypto_free_kpp(ctrl->dh_tfm);
> +			ctrl->dh_tfm = NULL;
> +			ctrl->dh_gid = 0;
> +			ctrl->dh_keysize = 0;
>   			return -ENOMEM;
>   		}
>   		ret = nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
> @@ -122,8 +130,12 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
>   		if (ret < 0) {
>   			pr_warn("ctrl %d failed to generate public key\n",
>   				ctrl->cntlid);
> -			kfree(ctrl->dh_key);
> +			kfree_sensitive(ctrl->dh_key);
>   			ctrl->dh_key = NULL;
> +			crypto_free_kpp(ctrl->dh_tfm);
> +			ctrl->dh_tfm = NULL;
> +			ctrl->dh_gid = 0;
> +			ctrl->dh_keysize = 0;
>   		}
>   	}
>   

Can't we make this a helper?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

