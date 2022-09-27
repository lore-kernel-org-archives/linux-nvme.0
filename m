Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A62AC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 09:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CG3ypZANOYZFqdiklH3ddw2rMRb5dz9hou6P/Ka7+iQ=; b=m7lBH2i4XMhvJpfmGYM8Uhej5M
	npIRu/8XjKRc/M+Ea+y9/HkciXSex5VgN6rCrSZoagNDJ3CA/vcVI8MgX/dN4WJ4t1nyFCK2Twegn
	kx5ArTytw84a7lo1MmF7E2pALNbpPBeY1JEL8DyWznAh8lp1usoruDVd37JlNY5h1WHOZngDotCJY
	0Vs/2psILUfcNAQ025V/nxacV1RB2KXn1gKQR2bVnB+HEjJB/DBAYj5Wy+ccD6D9qItQAZcpEfrGr
	Vah1yX2ExMUCUqxPmDfgU1y1D01U6blXXx7vPf3tDg+yalWq4M4xj1WZN5M6GFBhzeB6hrP+pXxRi
	XxKKnuWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od7Gh-009gaN-AW; Tue, 27 Sep 2022 09:52:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od7Gf-009gZp-FG
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 09:52:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97A9A21CF3;
	Tue, 27 Sep 2022 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664272361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CG3ypZANOYZFqdiklH3ddw2rMRb5dz9hou6P/Ka7+iQ=;
	b=fYTEvpIsW3vrVbu1nz+3Y3KVhFX9F8LpzLdlfVlIi6upMFq73D5iO5YvALe7B/b/d8Swq0
	+W45QBHZq0Ea5He7cKJqcg6RbIZKMvaEnQnjOnzztN3JiA7kBNANA3Fdi2/1Ye6kbM+wBW
	LN3bZ2p5cwgp2hf5JKaP0yGRm8tC6Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664272361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CG3ypZANOYZFqdiklH3ddw2rMRb5dz9hou6P/Ka7+iQ=;
	b=lOPpsq0NwMjT+5Gn2YfZ4SNvEapxMf7vvjs59KVszbFJ9jCj5mIMb8alvbnYbOE89JWvgr
	WMLTc38rBZbYgUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 897CC139BE;
	Tue, 27 Sep 2022 09:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nuJFIenHMmMrPwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 27 Sep 2022 09:52:41 +0000
Message-ID: <24ef5a47-37dc-82e5-84eb-e6b65433d413@suse.de>
Date: Tue, 27 Sep 2022 11:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] nvme-auth: add a MAINTAINERS entry
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kch@nvidia.com,
 kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20220922063429.1573089-1-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220922063429.1573089-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_025245_694620_6D65AC7C 
X-CRM114-Status: GOOD (  10.60  )
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

On 9/22/22 08:34, Christoph Hellwig wrote:
> Add Hannes as the nvme-auth maintainer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
Acked-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

