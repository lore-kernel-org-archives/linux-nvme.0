Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CCDC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xy2zn/oJ1OvaHxEFjUpWmruC/WUIHQizpSxfYR7XJ1Q=; b=NvDT8H3XGxe08bKhVytyjM1gEk
	+YNpNN8509Ok5zd0UXfY5QZeQ5AB+xomDF/W2BX4wJLjrjGw0Hqy90W2NNgKl1y7JdH551Wc4gUbI
	ixg/4bqAt0kS2iDacw9C3G11tHpTU3RQKl+lsgO/rIMvwyArgkSvWQp2ryLCD5eB81FiMVpl16iGp
	qhGQaTYwVLlgStsYIcVLSAJ8Rk8dJ4XwZYwcD+heuA4eYPEQOyioGqsyU3STn6KtACCAwgkKlig+u
	MF1gIW3F6R0G/o48f7Gaoox8QNgvasBNWkZlQaX2LKLERNTlQE7r5RZHzbdp7AAFEjr5cTXjZon1f
	TuqhmQGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofb8c-008crB-Jw; Tue, 04 Oct 2022 06:10:42 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofb8U-008coT-Kb
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 06:10:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0A2E219B8;
	Tue,  4 Oct 2022 06:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664863820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xy2zn/oJ1OvaHxEFjUpWmruC/WUIHQizpSxfYR7XJ1Q=;
	b=jL/uP1FJ4Vg8uGyZgrH+yVaVpPg9vPxbKKGh5xJHdYD7mBWVvVj2pc6irWf/ZrmZHvRUda
	6z0tji3ki4P3rMq5JJqpm2PCODJsrsGpFe5QHisUp582WOtsI5CbhJAK1g7mTFZjz7w6kg
	PkoC152+FsEoTk8gqvkf6jbz/ZYjuGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664863820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xy2zn/oJ1OvaHxEFjUpWmruC/WUIHQizpSxfYR7XJ1Q=;
	b=ZHWTe9cDG8rFEoKiSUSf98R5myMxx7wfTvKv/38TIGZMlGfGsft/N+PRugymLz0ZHXD0PX
	T24rvXImwOU7zJBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFF96139EF;
	Tue,  4 Oct 2022 06:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id hfc1LkzOO2NrFQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 04 Oct 2022 06:10:20 +0000
Message-ID: <3618fce9-7ac0-2cb5-df46-3ec0559c392f@suse.de>
Date: Tue, 4 Oct 2022 08:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] nvme: introduce nvme_start_request
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-2-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221003094344.242593-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_231034_862865_44F0B149 
X-CRM114-Status: GOOD (  13.11  )
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

On 10/3/22 11:43, Sagi Grimberg wrote:
> In preparation for nvme-multipath IO stats accounting, we want the
> accounting to happen in a centralized place. The request completion
> is already centralized, but we need a common helper to request I/O
> start.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/apple.c  | 2 +-
>   drivers/nvme/host/core.c   | 6 ++++++
>   drivers/nvme/host/fc.c     | 2 +-
>   drivers/nvme/host/nvme.h   | 1 +
>   drivers/nvme/host/pci.c    | 2 +-
>   drivers/nvme/host/rdma.c   | 2 +-
>   drivers/nvme/host/tcp.c    | 2 +-
>   drivers/nvme/target/loop.c | 2 +-
>   8 files changed, 13 insertions(+), 6 deletions(-)
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


