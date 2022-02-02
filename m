Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58A6C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 13:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pepWXB5DvgjMJGEOiNQEx9XrtwsT7XquutmoNVWSlU4=; b=rO+gLgs7pAB4Y/7uGme+/dbIWG
	GV+Rxjq53Ad8EEbhBgGfm5GDxAsWcsx1h1qi73r7u3LQ2HaESfhivtNif7llAoJgYnFTJqf3hA2Oy
	11KCCsppfP7kyd9BFKtg1UrtcxG2OaNcv0RfLkcz7dz6sfmuC2Y9b1BrxIAG5pplSl9Q957ril7Gd
	AQwsZhMrp4Ogm9SnWulhnmVBllcYZNd6qDovabT6cP5Dw9UC+U7tv9ORUGknXuyvPvA8dWbU1faqM
	XJx1yRICT0umNClbr5vY1lilwIjvLmf8YY6oDzsyqlVgQlBI8vIJ7iz2ciXoMgOOb9Q9puOjEnH1O
	66s7EvfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFFTb-00FJZx-7H; Wed, 02 Feb 2022 13:15:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFFTY-00FJYa-Ks
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 13:15:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 69C191F3A8;
 Wed,  2 Feb 2022 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643807707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pepWXB5DvgjMJGEOiNQEx9XrtwsT7XquutmoNVWSlU4=;
 b=rLvqpqtnCiYNIil5Go7svLeylAIK/EEsiClAPmvdv4ttCXiLfYnicBjtG/cnDOlDfOoRyq
 qhB995y++QwMg5Li89skyZD/Yc2RDkshYC/Mkjct8LGK/0zXRTjCGw53IpouRZamrWXK8J
 uhezZb3ePVwOWaoJG4Eg6l7DCwWeogo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643807707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pepWXB5DvgjMJGEOiNQEx9XrtwsT7XquutmoNVWSlU4=;
 b=VDrw+YadqVUsdwACF7urbi3ndmOhUBvTEabGX1G+gvq1l75Q+bA8vCqac7k+0k+NMTefJ8
 2C0zZB7ce9NEF1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55DC213E48;
 Wed,  2 Feb 2022 13:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h92FFNuD+mHuQAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:15:07 +0000
Message-ID: <5bc42a39-9c6a-bf63-9470-ab9e44fa1c68@suse.de>
Date: Wed, 2 Feb 2022 14:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 5/7] asm-generic: introduce be48 unaligned accessors
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Arnd Bergmann <arnd@arndb.de>
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-6-kbusch@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201190128.3075065-6-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_051508_876159_6CB3703D 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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

On 2/1/22 20:01, Keith Busch wrote:
> The NVMe protocol extended the data integrity fields with unaligned
> 48-bit reference tags. Provide some helper accessors in
> preparation for these.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   include/asm-generic/unaligned.h | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
Hehe.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

