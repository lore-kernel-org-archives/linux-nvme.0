Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E905C369C2
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 06:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39Gt0bzid+uaCg2bYayys5NnUXat3RGdVmpX8j8hNyM=; b=L8BLibWz7a9hhfZfAK+WmP/Zbd
	EKv97VP5029OLG9bmZtBGpbxb3WMbWfETFXVfSso6b+eaNxTLxgrO0FT1wFqsmmmXES/oPlSkghCb
	7KJzSaUHuxv55Hl0nLAG81bQD8o4M4piBuvEQuPNF2KpEHmexpVePPw78RjqQTj/R2RKVMiXbpdiq
	cHgZTeZNbcQbb8LpAoKo3ZjhLY9XnuYibHi+r24wgs8oGU3R1dgcxvnRVicu9Eb4aBMkWZP3m2DMf
	aGQlIw7cNw3HQnQWUly7+vz6nzAV73Ez4Ei4qJQL4LIVMglvXC/rQUNZK68DMimjrdw12GSUVEG3P
	F+oo7G0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBpUU-00000006Xga-18EL;
	Mon, 05 May 2025 06:39:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBpUR-00000006Xg3-2wQl
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 06:39:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40E591F387;
	Mon,  5 May 2025 06:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746427186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39Gt0bzid+uaCg2bYayys5NnUXat3RGdVmpX8j8hNyM=;
	b=nLam4uEvIZaK4mvpjctnqjDr7E+Su9NDG9llsf/egcL9t/yqHS63c4wXgicKCjGKu0HyJq
	ajRcJSNnxPH5M8vkwvLBWWlNRGifvLh/kd5Gk5hV3v1CRBvsjbyRkdkQQkRsQI/KIdYM07
	ugUlPGludGWqacRCcbn0OVsElDbmVQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746427186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39Gt0bzid+uaCg2bYayys5NnUXat3RGdVmpX8j8hNyM=;
	b=o0DWz1ZcxraIukQyzFl+VpujWc8ySxfGfXJ77LaSE4DQZGUILFTugVFvJPQppMia1klFvt
	XuDpwIkIeNVlvgAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746427186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39Gt0bzid+uaCg2bYayys5NnUXat3RGdVmpX8j8hNyM=;
	b=nLam4uEvIZaK4mvpjctnqjDr7E+Su9NDG9llsf/egcL9t/yqHS63c4wXgicKCjGKu0HyJq
	ajRcJSNnxPH5M8vkwvLBWWlNRGifvLh/kd5Gk5hV3v1CRBvsjbyRkdkQQkRsQI/KIdYM07
	ugUlPGludGWqacRCcbn0OVsElDbmVQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746427186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39Gt0bzid+uaCg2bYayys5NnUXat3RGdVmpX8j8hNyM=;
	b=o0DWz1ZcxraIukQyzFl+VpujWc8ySxfGfXJ77LaSE4DQZGUILFTugVFvJPQppMia1klFvt
	XuDpwIkIeNVlvgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6AFE1372E;
	Mon,  5 May 2025 06:39:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tGPiMTFdGGjxNwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 05 May 2025 06:39:45 +0000
Message-ID: <11068aa2-8473-4bab-b24c-d6f663d3b1ef@suse.de>
Date: Mon, 5 May 2025 08:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 3/3] nvme: rename nvme_mpath_shutdown_disk to
 nvme_mpath_remove_disk
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250504175051.2208162-1-nilay@linux.ibm.com>
 <20250504175051.2208162-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250504175051.2208162-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250504_233947_885531_14C40019 
X-CRM114-Status: GOOD (  12.01  )
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

On 5/4/25 19:50, Nilay Shroff wrote:
> In the NVMe context, the term "shutdown" has a specific technical
> meaning. To avoid confusion, this commit renames the nvme_mpath_
> shutdown_disk function to nvme_mpath_remove_disk to better reflect
> its purpose (i.e. removing the disk from the system). However,
> nvme_mpath_remove_disk was already in use, and its functionality
> is related to releasing or putting the head node disk. To resolve
> this naming conflict and improve clarity, the existing nvme_mpath_
> remove_disk function is also renamed to nvme_mpath_put_disk.
> 
> This renaming improves code readability and better aligns function
> names with their actual roles.
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  4 ++--
>   drivers/nvme/host/multipath.c | 16 ++++++++--------
>   drivers/nvme/host/nvme.h      |  8 ++++----
>   3 files changed, 14 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

