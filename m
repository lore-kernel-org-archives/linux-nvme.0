Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9E0C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Ia1dj7NKl9o22jOQRJtZotlEsC74MJf4jTUCXUipxI=; b=IKIOorJUPcMQAEBDDS/Pi8M5+0
	ZV53wgjn3Y6RaL2GKoZYLU39yWyVf7xBrr0NgTk2kNwoYZIRI1lh8XJjH90vZQrTHIva8sDQeQ+gN
	GZy2UdP2cG108i1IXxq8hE9P6A7o7RxiUDoUyQR4GqEfmNDJ6v+/CIkEC0VIjGp1MT71YJQiznxIH
	xwWhtt83rL7yoauQLL/2GlowwgX0b5qUjdiwt2U6PjfuREgQU1lt/N2FJonec3v53mD1hf127ZXO3
	Da/vdiFvGtU4GcSFR1wp2SSenuDiqEH7SUo9wBK15vXQbzKqqZsmCl9OLiY4gRtwIP6PbhUk19loh
	keEM74ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrE2F-0003fD-9q; Wed, 18 May 2022 07:23:55 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrE2C-0003cv-Dw
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 07:23:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 466F421B2D;
 Wed, 18 May 2022 07:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652858626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ia1dj7NKl9o22jOQRJtZotlEsC74MJf4jTUCXUipxI=;
 b=lf/rAgKJlIAOh6UbzeaA+xjTlgKj3QZvOhO685zod1i/MUQ+6qQYMljvppuQ3TH+w3WjEz
 yAb0WmBuw79o88Py0/CfUowE1qbI+h/NSGv/hgwjqZWtwYc9oERvSV+S67TmEFlYhF9k3P
 NTwCWW0UBc3Paesu8xXHQDEMQE8fFSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652858626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ia1dj7NKl9o22jOQRJtZotlEsC74MJf4jTUCXUipxI=;
 b=H0h3B0xdeetM+GN5/gE06wvaNm+pQ/I75Hl2L3iT95BrqDBbduNaCtfpOgEgOC9qDWCIJX
 cbvCnhkjC3oX85AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 232BA133F5;
 Wed, 18 May 2022 07:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LrhcBwKfhGIATQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 18 May 2022 07:23:46 +0000
Message-ID: <8ff06ce2-0aa7-5999-8987-1f9d9935e4e5@suse.de>
Date: Wed, 18 May 2022 09:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL] nvme updates for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YoSWZoB1/38DdP4S@infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <YoSWZoB1/38DdP4S@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_002352_623872_9DAFD206 
X-CRM114-Status: UNSURE (   9.31  )
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

On 5/18/22 08:47, Christoph Hellwig wrote:
> The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:
> 
>    loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)
> 
Hmm. So how do we progress with the authentication patches?
Shall I resubmit them?
Will you be picking them up?
Is there anything I need to fix up?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

