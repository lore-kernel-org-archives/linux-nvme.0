Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCFCC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 07:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XJRcUH7u3DaEMgTKLF6tW5ZsG6oSp1UAe0x1gEU0UQk=; b=bagu7JUXQ61ft2fjMoO2ladEZc
	ugbpldy1/RPqARt5ygg84OdhsYGQI1rcWlYVb4HU1cusoh0zt0zJvI58CdE1KyJlBw0CWNeHoso7B
	025EV4zTZ/DDTLRrGgdO4cv3Dv2PmvHreW0oT4oY6OyqoIodqPHko0ZFZEJdJ1IqeabggLewz7kuS
	PkY4KD8E6lfHgUKr4w1JMVfuBClrlwa5aNCn8ieGCDxcpKjk4QatVc8heeP1Fqe3XtEJCimPcGpa6
	dm3dpZ2zKXV0GHWy6pNsRBDBert2NE6eD9KQbWEPQp1aMBg6bcTWPbqToBiS7wzGauM+pXskuCNMk
	0FQCNycw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfbh-00BZwW-Kn; Wed, 09 Nov 2022 07:34:45 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfbd-00BZuS-3L
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 07:34:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77E602237B;
	Wed,  9 Nov 2022 07:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667979277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJRcUH7u3DaEMgTKLF6tW5ZsG6oSp1UAe0x1gEU0UQk=;
	b=yT1R5QhwXGjP9CzifaRWYiKGkb6YXua9XF6o3T42rePQKll+ZlxYCEoX0oe2F7MDHmo6if
	9HnaspOV2/a0utUS67QG/xhRqidmGTuum4IUgXSNwz5wTSe/tN57ja6IEse18BRj/Q0FIG
	7DmV2H1lI1KznMXu+SIWBVQ1SiO0yKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667979277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJRcUH7u3DaEMgTKLF6tW5ZsG6oSp1UAe0x1gEU0UQk=;
	b=1cg4e5qclI+3XQhCVBpNp5NYHyvu72PpEFUdvt6CaOGXGcJm0kZHafBbSuWA05jgrHqlRb
	sUWR2v3KFRGbp4Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DE0F139F1;
	Wed,  9 Nov 2022 07:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HcNOEQ1Ya2ObNQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 07:34:37 +0000
Message-ID: <593f3689-719f-30df-b337-01ced3007808@suse.de>
Date: Wed, 9 Nov 2022 08:34:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 07/16] nvme-auth: remove redundant if statement
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-8-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-8-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_233441_307591_0CC17BC5 
X-CRM114-Status: GOOD (  15.65  )
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

On 11/9/22 04:44, Sagi Grimberg wrote:
> No one passes NVME_QID_ANY to nvme_auth_negotiate.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a6312a8846f8..07d497f49e4b 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -874,7 +874,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>   		mutex_unlock(&ctrl->dhchap_auth_mutex);
>   		return -ENOMEM;
>   	}
> -	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
> +	chap->qid = qid;
>   	chap->ctrl = ctrl;
>   
>   	/*
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


