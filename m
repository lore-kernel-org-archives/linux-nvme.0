Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE760A2638
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=5Fab9kzU;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=EiRJee6R;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=D1UCTzXL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=O7zJj+W/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=feaa7WR+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5xl6g/9O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1rPTBO82JSPFKRtnf3rx3ha1Otc+BPA9gRc5dOxQULk=; b=5Fab9kzUNHyb5g
	/NbBNfirGLb6AJS457rjZivy71iFgocvBF73uB8T5d7o6QLHEpcTaPuRHlKTJl/5+QWwVg/kVNP8Y
	rxsFYdtPAy70wFaDW8J9NNxN2i8EQhcXHK4vvBLsMmkF68FXOeEnak1LGEZikSNFZZz0cg9XIyfxd
	DV56VjKeTnrQ966FYcIiAeLtmySEVixJAi/Xs02cnGlDY1mrF4sWP6EA0QEECwyuIeEAqAM1kYbdF
	ETgLdF9inXCYXJIIf6BEaO5JbbwlRCQUbwMM3x15WfNirsF9OA9Nij06n0yAW/CZWZA3tLmaO0dpM
	x9bNk5Y+Vg7d7TeH1yHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQg8C-00000002qQh-40NP;
	Tue, 10 Nov 2026 07:19:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQg7M-00000002pV6-1ysZ
	for linux-nvme@bombadil.infradead.org;
	Tue, 10 Nov 2026 07:18:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1rPTBO82JSPFKRtnf3rx3ha1Otc+BPA9gRc5dOxQULk=; b=EiRJee6RoL6n4IEMrEjb+8SJzv
	8KCfXSpmJ4McAtf2ASHjJOkca59rK+pljQn0T2FDNsJ47IdOg5pSY0QOZk/w/40jWHm2MwwEGyjjI
	bH/xZO/mMfiy4qRvT5Dxqg1UpcT2yHmjNUHO1GqU1byIOS/m9S3BZu4Ioti+DjY3wm9y9vPxhT6QK
	X4fEztNmaEMpiZdI24vXXhNlGk6lW/OHw8+MCykgeEIj9aBt+SmPT1DVqqdd9ELQreknp5Cqbp3O7
	pol4q0kHJ3wVnIgNHUJn+Ts6DL14NoJtPYZfITmv7lmJfoESugeWMyocbdWUAwvvIEV1ZOjn0VWwn
	0jltU7ww==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQg7B-00000007cAv-3MCR
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 07:18:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC8ED1F792;
	Tue, 10 Nov 2026 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794295073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rPTBO82JSPFKRtnf3rx3ha1Otc+BPA9gRc5dOxQULk=;
	b=D1UCTzXLLd5E8BZDVlhfAEpcKzW2ceFGkkHCv3sAOCDOavyZxoFI4TgiMLdyNMTGWX+V+B
	NJIEnl7PtvxlMvRjB/hiPHLUj7w3Lxbz1TDmqe/vdNlBT3C/ZI3Alo+8irTzrImn5PLW7Z
	53bZIeaAigICiUhVha7SUWtZTFPMpg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794295073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rPTBO82JSPFKRtnf3rx3ha1Otc+BPA9gRc5dOxQULk=;
	b=O7zJj+W/NT4yHAztczx1eisfZZH6/zhCp9FchtsjbdC8hwgkoWbYJoOioyWXjInm7DWH5R
	BF2ihB2W3J5OAXAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=feaa7WR+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5xl6g/9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794295072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rPTBO82JSPFKRtnf3rx3ha1Otc+BPA9gRc5dOxQULk=;
	b=feaa7WR+uMo08nFkFrPk9c97lHaiWuLoDV4+WJLaIJC+XoJm1mm7J5a+UfXtg0l8EGIWPd
	SsWtlfR8i02a/wZnsmEJJfSnzJhfOduNwJR+cdYqVAxcDFpVOYwbY+CTjTGoe4YoHVtm0B
	/nToaJjRjjEdgTdfXGgOZs9RYz5WG/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794295072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rPTBO82JSPFKRtnf3rx3ha1Otc+BPA9gRc5dOxQULk=;
	b=5xl6g/9OThn4E5F50gC9lIcocwccHA9rOwVKeHEgTsPOlm1LJki/RC6+JZ1AoS5Z9fZKJO
	cej+QTnPkh/RP+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A24E1339F;
	Tue, 10 Nov 2026 07:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 17rVDyDF8movZgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Nov 2026 07:17:52 +0000
Message-ID: <f4d1c582-8760-4915-87ae-a2f070070d54@suse.de>
Date: Tue, 10 Nov 2026 08:17:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: reject invalid write-protect feature values
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: hare@kernel.org, hch@lst.de, kbusch@kernel.org, kch@nvidia.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
References: <20261109135536.2772-1-sreekuttan2156239@gmail.com>
 <20261109142428.2612-1-sreekuttan2156239@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261109142428.2612-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC8ED1F792
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_071803_332886_A99C28E8 
X-CRM114-Status: GOOD (  16.50  )
X-Spam-Score: -0.2 (/)
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

On 11/9/26 3:24 PM, Sreeraj S Kurup wrote:
> The Set Features handler for namespace write protection currently
> accepts unsupported values. The default case in the write-protect
> switch leaves the status unchanged, causing the command to return
> success even though no valid setting was applied.
> 
> Return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR for unsupported
> values. This also prevents issuing a namespace-change notification
> for an invalid request.
> 
> Fixes: 3a1f7c79ae6d ("nvmet: make nvmet_find_namespace() req based")
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
> ---
> v2:
>   - Add Fixes trailer
> 
>   drivers/nvme/target/admin-cmd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index f12d83098644..ee8be237485e 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -1223,6 +1223,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
>   		status = 0;
>   		break;
>   	default:
> +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>   		break;
>   	}
>   

Please send new versions as individual patchsets, not as replies to the
original patch.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

