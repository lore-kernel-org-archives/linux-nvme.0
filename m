Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463A606A33F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F1jdET+u;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=g7S0/80V;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=md2KzU+L;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=g7S0/80V;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=md2KzU+L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HaLYJhSTkNjizIEyz4raXHjkF7Mcm54Yi7yMX0V+C2E=; b=F1jdET+ulKICUN
	t7qfZloG94t118oOkRGf/igqW+4UCDrQwp8jeDwlT82I+a7LHZCeOTEKo+MaUBlEKzM8XrmC+pCa8
	hBhFNVeuwgEBhiqFycuqfCLpFfSfY87o0O+vg5c+OWYiUVCVZXGXdb7d38jlsak82tSbbSmS8PgiW
	DiDJE85KhtYn8En+XlBF/AeCXaS2kglpKzs5YTp5MlBRjvP+LVuhFq343iPGHbNd6XNr6S1dnnANC
	+FgaTNlmNeRNCoB4FRSB4joZKYtZ5cgeSk13P9IVlgVK/v1uQ6z6mO7Q04CY8fnsPJ96kFVOZm9Pd
	l6SbznqEWHHU7/f/QO/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoTn-0000000CMHf-183B;
	Fri, 13 Nov 2026 10:25:59 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoTk-0000000CMGO-31qP
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:25:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C60EA1F898;
	Fri, 13 Nov 2026 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794565554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaLYJhSTkNjizIEyz4raXHjkF7Mcm54Yi7yMX0V+C2E=;
	b=g7S0/80VzZencT3Cmkq3Ge9GYEW6SXD9GZeEm3rtmKUaC5+8+vR5qAaKL2lLijFAlsQoN3
	LXrw0ORrpWZyv6lT7+bCvWJG+NFx+fsXjcfOr6O690L50GpOhbGGuVNj1BCA8ZxcztBjbm
	Vzfps28vThQ6avsmclyT73ADLqJaUnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794565554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaLYJhSTkNjizIEyz4raXHjkF7Mcm54Yi7yMX0V+C2E=;
	b=md2KzU+LupZw3MTmIIGbP9ew/wibziYPKrhMbFAzAlOYxP6xZJtfKFwVWxCxw4EzO9gmqH
	fzZrVVqmnzf1HMDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794565554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaLYJhSTkNjizIEyz4raXHjkF7Mcm54Yi7yMX0V+C2E=;
	b=g7S0/80VzZencT3Cmkq3Ge9GYEW6SXD9GZeEm3rtmKUaC5+8+vR5qAaKL2lLijFAlsQoN3
	LXrw0ORrpWZyv6lT7+bCvWJG+NFx+fsXjcfOr6O690L50GpOhbGGuVNj1BCA8ZxcztBjbm
	Vzfps28vThQ6avsmclyT73ADLqJaUnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794565554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaLYJhSTkNjizIEyz4raXHjkF7Mcm54Yi7yMX0V+C2E=;
	b=md2KzU+LupZw3MTmIIGbP9ew/wibziYPKrhMbFAzAlOYxP6xZJtfKFwVWxCxw4EzO9gmqH
	fzZrVVqmnzf1HMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 779D0134C3;
	Fri, 13 Nov 2026 10:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id crkoE7Ll9mrKfQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 13 Nov 2026 10:25:54 +0000
Message-ID: <aead1f29-eb58-4e44-b4f6-a8dfa7d7c193@suse.de>
Date: Fri, 13 Nov 2026 11:25:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: clamp the last ANA group index against the real
 array size
To: Yuehong Wu <wuyuehong@cmss.chinamobile.com>,
 linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Maurizio Lombardi <mlombard@redhat.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Randy Dunlap <rdunlap@infradead.org>,
 Aurelien Aptel <aaptel@nvidia.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Jesse Taube <jtaubepe@redhat.com>, Rongzheng Wang <testwrzwrz@gmail.com>,
 Kees Cook <kees@kernel.org>, Rosen Penev <rosenp@gmail.com>,
 Guixin Liu <kanie@linux.alibaba.com>, Qing Zhang <diasyzhang@tencent.com>,
 Eric Biggers <ebiggers@kernel.org>, Julian Sun <sunjunchao@bytedance.com>,
 Yu Zhang <yuz08559@gmail.com>, linux-kernel@vger.kernel.org
References: <20261106-nvmet-ana-grpid-1-yuehongwu@cmss.chinamobile.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261106-nvmet-ana-grpid-1-yuehongwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,grimberg.me,nvidia.com,kernel.org,redhat.com,purestorage.com,samsung.com,infradead.org,linux.ibm.com,gmail.com,linux.alibaba.com,tencent.com,bytedance.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,chinamobile.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_022556_959899_BDE08839 
X-CRM114-Status: GOOD (  24.54  )
X-Spam-Score: -4.4 (----)
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

On 11/6/26 7:40 AM, Yuehong Wu wrote:
> NVMET_MAX_ANAGRPS is the highest valid ANA group id, not the size of
> nvmet_ana_group_enabled[]: the array has NVMET_MAX_ANAGRPS + 1 entries
> and the controller advertises anagrpmax == NVMET_MAX_ANAGRPS.  Both
> array_index_nospec() calls however pass NVMET_MAX_ANAGRPS as the size,
> so for the last group the mask is 0 and the index quietly becomes 0:
> 
>   - nvmet_ana_groups_make_group() increments enabled[0] while the group
>     keeps grpid == 128, so the later nvmet_ana_group_release() decrements
>     enabled[128], which underflows to 0xffffffff.  The ANA log page then
>     reports group 128 as inaccessible forever even though the configfs
>     group no longer exists, and the increment on enabled[0] is never
>     undone.
> 
>   - nvmet_ns_ana_grpid_store() accepts 128, stores 0 in ns->anagrpid and
>     returns success, so the namespace silently stays in the default ANA
>     group instead of the one the user asked for.
> 
> Both failures are silent, and they change what the target reports in its
> ANA log page, which is what a host uses to select paths.
> 
> Pass the real array size in both calls, so the masking is kept but the
> last group is no longer folded onto index 0.
> 
> Fixes: 20dc66f2d76b ("nvme: prevent potential spectre v1 gadget")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
> ---
> Verified with nvme-loop in QEMU/KVM on 7.3.0-next-20261027, with two
> kernels built from the same tree and differing only in these two lines
> (no instrumentation):
> 
>   - before the patch, a group created as ports/1/ana_groups/128 is absent
>     from the ANA log page (ngrps=1) even though configfs accepted it, and
>     it is reported as expected afterwards (ngrps=2, group 128 optimized);
>   - 128 written to a namespace ana_grpid reads back as 0 before the patch
>     and as 128 after it, and the namespace is accounted to group 128;
>   - removing the group again adds a phantom group 128 (state inaccessible,
>     0 namespaces) to the ANA log page before the patch, and leaves no
>     trace after it, even when creating and removing it repeatedly.
> 
>   drivers/nvme/target/configfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 8aea64d..48d3f68 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -701,7 +701,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
>   
>   	down_write(&nvmet_ana_sem);
>   	oldgrpid = ns->anagrpid;
> -	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS);
> +	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS + 1);
>   	nvmet_ana_group_enabled[newgrpid]++;
>   	ns->anagrpid = newgrpid;
>   	nvmet_ana_group_enabled[oldgrpid]--;
> @@ -2074,7 +2074,7 @@ static struct config_group *nvmet_ana_groups_make_group(
>   	grp->grpid = grpid;
>   
>   	down_write(&nvmet_ana_sem);
> -	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS);
> +	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS + 1);
>   	nvmet_ana_group_enabled[grpid]++;
>   	up_write(&nvmet_ana_sem);
>   
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

