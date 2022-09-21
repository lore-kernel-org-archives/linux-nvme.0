Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCA9C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 06:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0zU9LWElHXCb6c971cAb9eeWt1Yoy1gEGL5MY5/zMe0=; b=XICUCzNNe6IZDpiPXA4/brOsb4
	1JQcohgrLUYtHkVuMqgDaUo6ic9F+NFYqWGU/XihDZ93iAZFCa+AlNL5JrsiSppnoe5T3nCbkoYMZ
	Tlmz7Qfz+skCfuJ6CHgbt+j/grxwiqVouum9Ao9+3XeeBm2f+qOcFAiYF1oMvu4hmZSTbBiJX/I6r
	bsx9eyfhR2/cLivX8rsJoN/YENwfC8zU2gCQsqL2vPamtDKHgeggyOgVO/jN5XTFapW1KIJFhj2QH
	Q6opdgFH0e6C9gz5w+oDyr7AI6B738Z3YqxjmKVxf1+cK7i4pb+BckZjgpTnGTwOCLPE6BryCYlS2
	r4wlgbkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oat0s-009Dvm-0d; Wed, 21 Sep 2022 06:15:14 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oat0o-009DtB-Gc
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 06:15:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B7DC1F388;
	Wed, 21 Sep 2022 06:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663740909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zU9LWElHXCb6c971cAb9eeWt1Yoy1gEGL5MY5/zMe0=;
	b=z75AasnKgLHqUxtzNHkPO4MizmtANCZlF8RsPvp5rOBjMeZv3V/duRXmVgZ994CxqatNkH
	jJBV7aiuDzrR2wf/go5cwTdy11sM0cGZtXjqnZAJg7NeE3GrylM2WNhe9FFHdJvFNkTJnQ
	yP0IErnxvfFTKL0Rj1AX9ENUBWTG4yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663740909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zU9LWElHXCb6c971cAb9eeWt1Yoy1gEGL5MY5/zMe0=;
	b=c0La/g57T3b2YN0kikpk8D3f9gnPgxNNOH6ilekW2UeKWGpZpTjEsPbEHYB7oNHwYsa09d
	aZG1CoBCQTgFdjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EF1613A89;
	Wed, 21 Sep 2022 06:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id smpEB+2rKmPiawAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Sep 2022 06:15:09 +0000
Message-ID: <ac85552d-a3b9-27f5-2936-3616705d8311@suse.de>
Date: Wed, 21 Sep 2022 08:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] nvmet-auth: don't try to cancel a non-initialized
 work_struct
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171931.1289669-1-hch@lst.de>
 <20220920171931.1289669-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220920171931.1289669-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_231510_736528_DA7F466D 
X-CRM114-Status: GOOD (  16.42  )
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

On 9/20/22 19:19, Christoph Hellwig wrote:
> Currently blktests nvme/002 trips up debugobjects if CONFIG_NVME_AUTH is
> enabled, but authentication is not on a queue.  This is because
> nvmet_auth_sq_free cancels sq->auth_expired_work unconditionaly, while
> auth_expired_work is only ever initialized if authentication is enabled
> for a given controller.
> 
> Fix this by calling most of what is nvmet_init_auth unconditionally
> when initializing the SQ, and just do the setting of the result
> field in the connect command handler.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/core.c             |  1 +
>   drivers/nvme/target/fabrics-cmd-auth.c | 13 ++++---------
>   drivers/nvme/target/fabrics-cmd.c      |  6 ++++--
>   drivers/nvme/target/nvmet.h            |  7 ++++---
>   4 files changed, 13 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

