Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF98C35274
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kyEOp7p+SwhUdh+7VqO9qwuDWqD0HeNMJBO1n4ubOEc=; b=df++rrI7njmbo6Uq7s84N+tcAt
	GWmCv8bw5+fZgf3jvR/dqYfFeLMV401jkURUjTjHozMwmVNOIWjx0nKfhxaCEMhqJPjOMAWUm//OO
	dUOBrFfmANPSAyC20Clf2CWpGKsFoi4upqr00VUb9slRi3SkDGy/Pu1ztrcUtMMAmC6DM5zJmDhWI
	Gt0RnjrP27b0K+i3lZnkODXwtatZWMLaS3xhj/huy6gsP1LXmHySAFw1sL/v1v+nnvlEiWZbuNJ/f
	VnSrXooLj7LyzNo2UlsEeoRI8iTzo4oaE8tJ2tXNpOt9y2U83BNiJgDa97uyEeJpeWnm6t/D1Xusk
	eMWQv/2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE7LG-003EYO-29;
	Fri, 15 Dec 2023 12:30:58 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE7LE-003EX5-1Y
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 12:30:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E801A220DF;
	Fri, 15 Dec 2023 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyEOp7p+SwhUdh+7VqO9qwuDWqD0HeNMJBO1n4ubOEc=;
	b=eL3i886ZtgBrVT6O7omOSIchpi5B8YPjo0Vgl0M21RqJKGmIb9QrzKOnsKAS4c2EALUp3x
	sYWRTlQZMRqpP6KDU+d9+QTu7EFUmsKRbYh9hhrJOGtQDXDxbrCRqzIOPX+LrdahMurImq
	bvyoAWz+i+SfWkQNe9KQYbWUlP9bSHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyEOp7p+SwhUdh+7VqO9qwuDWqD0HeNMJBO1n4ubOEc=;
	b=amn4rnL3oV4CtzFbKe1Ylf8nMAj2Vf7TjrQq36gujlOyXXXQmRknRuG9NrdaaHRdarlSDR
	MJGEGVGbKXI/gZCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyEOp7p+SwhUdh+7VqO9qwuDWqD0HeNMJBO1n4ubOEc=;
	b=kL4sl63EP8S/ygXZa08wSgHunPdRs4/9TVI0KHlRhWnMnkxlNPdY/feje8NxUTgv2gpZsA
	AsanecyMr0jLmfwTWj4xTyhbDTs7YnZi0qMSbIfFG1y0k+V32uzOUs5Mq0z2DfU44Q2OW3
	pb/11dQm9RJOwtapIK0supRTFhdN3bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyEOp7p+SwhUdh+7VqO9qwuDWqD0HeNMJBO1n4ubOEc=;
	b=1ffHgSGUEtZb5qbJdouCE06/SmFp9fS8paCpv3xODB7HuXi5w2rPygZWh395GXL3ozKFa1
	PuU1NU7qJl4Sw+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C71E0137D4;
	Fri, 15 Dec 2023 12:30:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AE6dL/xGfGXrBAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 15 Dec 2023 12:30:52 +0000
Message-ID: <a6dbe713-3234-4fc9-8d5d-3f090f9f712e@suse.de>
Date: Fri, 15 Dec 2023 13:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: validate maxcmd before use it
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, james.smart@broadcom.com,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <1702629808-96718-1-git-send-email-kanie@linux.alibaba.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1702629808-96718-1-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.54)[92.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_043056_698089_E313FDBC 
X-CRM114-Status: GOOD (  11.21  )
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

On 12/15/23 09:43, Guixin Liu wrote:
> According to the NVMe specification, if the 'maximum outstanding
> commands' (maxcmd) field is not utilized, it must be set to 0h.
> When a host connects to a target that does not employ the maxcmd
> field, the queue size (sqsize) gets set to an excessively large
> value due to the calculation (u16)(0 - 1) = 65535.
> As a result, such a misconfiguration leads to the failure of the
> connection establishment.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/fc.c   | 3 ++-
>   drivers/nvme/host/rdma.c | 3 ++-
>   drivers/nvme/host/tcp.c  | 3 ++-
>   3 files changed, 6 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



