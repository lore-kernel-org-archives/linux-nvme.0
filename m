Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D71EEE57D7
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdwtPaTuyo58tUcfUZ9XA6FpwT3BPUD2ICHDkD0BNZw=; b=uRgC/kb8Q+RL7iN1ZsA5ZBqaLU
	FqpRFP1rnpGMPv7qXrNSfw5XXsYzLdO0PnemnIftCJHCRv8GUD2WSY8dtiP/kOuVGszNFhdcOU/nQ
	T/m1zHtsUpP/cBQTN0+Nsu5M+K7TlbIo1sKzrCnmnVp+oC26keaz+KBCzDAByHCDVCbv9cLCKgKWl
	LkpCgUKgURNPCDewHsPt5F4xGwr4OkcOmmEqkQAP6ZZPyYWNRliOP7ifTHIQmxk3os2AoN5GGdNTr
	LB8RJOfmQRdigOhEulJ1nYPqhj0e/jTEkpxWZMGKI6KilOLT2qAJhSFDt2ykt5mg/cE0X27JPtLiY
	o5E/KNrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeVeD-00DDt0-1m;
	Fri, 08 Sep 2023 07:11:21 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeVeA-00DDsM-22
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 07:11:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D49E31F45A;
	Fri,  8 Sep 2023 07:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694157074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdwtPaTuyo58tUcfUZ9XA6FpwT3BPUD2ICHDkD0BNZw=;
	b=R0XdwYc32xamO85VueMJIcakVphIbAgo949pItRm7y/0b10+bkQygAi9y5EKbrUD32ZNyg
	pGMeslAgYO0QcF4WQvEMw1mTp1azY0m/8kgFHi3Pg/N5ZjSa0gddGsmBH2sdOtYqtGh3m2
	/unYBzQQh3FM4Es0oFyUQwreXUj2oMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694157074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdwtPaTuyo58tUcfUZ9XA6FpwT3BPUD2ICHDkD0BNZw=;
	b=Te6evBqmrosJl1ydhK+qRK7sVCN/Em+0msiyupEsgvoHgPt6K7PwuD5+eQ4EjajLtL5Kx7
	CsSWJ3TqaROdxcDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9EB1132F2;
	Fri,  8 Sep 2023 07:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /tJ+KBLJ+mR6BgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 07:11:14 +0000
Message-ID: <a1086bcb-6600-43cb-95e9-479096555a18@suse.de>
Date: Fri, 8 Sep 2023 09:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: use chap->s2 to indicate bidirectional
 authentication
Content-Language: en-US
To: mwilck@suse.com, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>, "George, Martin"
 <Martin.George@netapp.com>, "Kumar, Arun" <Arun.C@netapp.com>
References: <20230904152638.28311-1-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230904152638.28311-1-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_001119_023513_47368CE1 
X-CRM114-Status: GOOD (  13.83  )
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

On 9/4/23 17:26, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> Commit 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
> replaced the condition "if (ctrl->ctrl_key)" (indicating bidirectional
> auth) by "if (chap->ctrl_key)", because ctrl->ctrl_key is a resource shared
> with sysfs. But chap->ctrl_key is set in
> nvme_auth_process_dhchap_challenge() depending on the DHVLEN in the
> DH-HMAC-CHAP Challenge message received from the controller, and will thus
> be non-NULL for every DH-HMAC-CHAP exchange, even if unidirectional auth
> was requested. This will lead to a protocol violation by sending a Success2
> message in the unidirectional case (per NVMe base spec 2.0, the
> authentication transaction ends after the Success1 message for
> unidirectional auth). Use chap->s2 instead, which is non-zero if and only
> if the host requested bi-directional authentication from the controller.
> 
> Fixes: 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   drivers/nvme/host/auth.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


