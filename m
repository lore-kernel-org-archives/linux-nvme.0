Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BA1ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 06:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=npEXYXU0ogSBATFFkniPPlbEA6sj/5/YYEn6g0w7VDo=; b=2KSvZZsqg1+KE2s4g1hL6Ky4X0
	0HR8ozwyXcAeGkqD08qrF0pzhBDgErpZDgWzxG4VO/kJiVUr3LVbjPWhRDk+gIXmbnYMvdjjzB2PY
	ef+mOaRfvWYpJLqDwEehJWnbfjmvaflL3Am9w9phEoL69+J2t8x67eHj4vJ9YMtqyd1nxWBc64Bjl
	nGNgm/YuFf+omJqgwbEKTc8En4JszfcIYrTdbgr2fTYc0w1v3uVd4M5bSuXDVCb6N/sSFjT8tauMK
	HLyYcmvBBFupOEQlYDq4jk+EvtbtAwKcS8RALvvirKcAt4oubY4w0nUn9PWtmvUAsq6EXDDd9xOOC
	uFuBng7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaswL-009CLS-II; Wed, 21 Sep 2022 06:10:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaswI-009CKD-SM
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 06:10:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F9621F747;
	Wed, 21 Sep 2022 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663740624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npEXYXU0ogSBATFFkniPPlbEA6sj/5/YYEn6g0w7VDo=;
	b=P+pMSEaHhHSkGPkAn+Y39z3qqzjAOqffwwjROXyYsxfdRM/ngP4yQgo14DZP3oTV30/324
	AgYU5gpNdSDJGko0xmY+IdsQcts4pS43KOzpLY338gEAVqzp1ri8e/XB+0/4tIB2YWf2Ni
	ggSXAT8g3xTzYuBz6bKiUvxbSq7a+e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663740624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npEXYXU0ogSBATFFkniPPlbEA6sj/5/YYEn6g0w7VDo=;
	b=D36pfzJOdvgFwPL3ZI81nEsT/3bEV55ScWOu5ODh2epElMQA1zFzhNac8FifQFQiMeGNan
	NhxX4yvcFqYlNFAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32C3313A89;
	Wed, 21 Sep 2022 06:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id oglXCtCqKmMNagAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Sep 2022 06:10:24 +0000
Message-ID: <32da470d-2ebc-cd95-75c2-9ba1c707679c@suse.de>
Date: Wed, 21 Sep 2022 08:10:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: nvme fabrics authentication fixups
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171931.1289669-1-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220920171931.1289669-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_231031_087645_FF960969 
X-CRM114-Status: GOOD (  10.75  )
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
> Hi all,
> 
> this little series fixed a debugobjects complaint with the new
> authentication code, and some other bits while looking at it.
> 
> Btw: Hannes, can we add you as a co-maintainer for the auth code?
> 
Sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

