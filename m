Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF6BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 11:26:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE75E6136A
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 11:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE75E6136A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pd2LXhLysqIwYk2qNhjBf/ddwQ3G6Py0T7hOi66OYos=; b=sK/UQpOBAyVAG+y9lwrV4dRsaG
	VBvJhK/K1Klj+xNV/OFIjyKargcSk3OtgCUn2+KYwpUg/Mjf9gn3CefD7D6+fjBpl3FTdJSiGlxz1
	GFoPOQDtJdCUPkX5fnKUdX3BxCZqYOkKW1bkzWl4U/JsT0xhkkxZ8TcOIqgPkrYhQqx8ACjpGq+kQ
	Y6elKkOqdzIz2fKF283FKYE8raRufcexJ2IJLXPEsX7J/5tBUg+XkmVGk7xlUi6RcnBoDjJTQfWe9
	70wtMV9ttUiDRltuBor4egdMCYIw6x6OYpxRB0yo9jDe5+lF+AN6FozV9C01FVNeqkdJeASz6xTwq
	MsSR3mdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md9QH-004Ezv-3Q; Wed, 20 Oct 2021 11:06:17 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md9Pe-004EsL-6w
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 11:05:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F216219D0;
 Wed, 20 Oct 2021 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634727935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pd2LXhLysqIwYk2qNhjBf/ddwQ3G6Py0T7hOi66OYos=;
 b=R49xzJiXqqFkfOUBp/LDMC5NOCAL7edCjbVeUypviogPbkFYR028ZXYycR47sEHKr6R+13
 WfpOwWLmy9WhFo/33qIVZgBm3wPMxjZ0oeITyaGnkMabunKgm7gX9hj9yOzxtiw8SsPC57
 Af8j5Gixt9DNIuRQodhsW5QfzJavOhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634727935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pd2LXhLysqIwYk2qNhjBf/ddwQ3G6Py0T7hOi66OYos=;
 b=Tq24wnAaUBv56mQE8rvYi9ubuMJzss0HM6ah6f0NaiDxn6/9+7btj6qA/ZzYV1XPgKgX47
 aTrot2p+V1L71+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55EA813F89;
 Wed, 20 Oct 2021 11:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xWHaE//3b2GGMQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 20 Oct 2021 11:05:35 +0000
Subject: Re: [PATCH 03/10] nvme: add err_work attribute to nvme ctrl
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-4-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a131949c-f0ed-3aae-f58d-82a7b5e9bd90@suse.de>
Date: Wed, 20 Oct 2021 13:05:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211020103844.7533-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_040538_439090_04D451A4 
X-CRM114-Status: GOOD (  14.65  )
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

On 10/20/21 12:38 PM, Max Gurtovoy wrote:
> This structure is duplicated for RDMA/TCP fabric controllers. Move it to
> common code.
> 
> FC controllers might use this attribute in the future instead of a local
> ioerr_work attribute.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/rdma.c |  9 ++++-----
>   drivers/nvme/host/tcp.c  | 12 +++++-------
>   3 files changed, 10 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

