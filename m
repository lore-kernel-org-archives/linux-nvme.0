Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA83C77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BHeW4tyVf6oZPDGbJB4iNrMzQR3MDrxIFhpfg5MiMc0=; b=Chml6F1TDHBPRIHD4nMMxSdf/s
	2shx/sFmrJPsViaEU5umEUmx7S1oH939iy3UXfCFNHuDHq2yl/dHLMs3kc0HMlVBsIKEVP2cpz+U7
	9/oRnQdyxHeRP2UMi+6v7RuSFFZl0e/C4A2z1oTLya7JYoYXIF5sogI5aNGH8Xv9y65fA2MukpzzP
	ZGb5RbOEa7Tl7wQdqOWMJF7bebr6ZdTIFvdCFZzagkCDZYL/hMpLHT/ulzFZrRfIg9ZV1zTEscgJl
	T5ZoTLqv04rZ9ssgA/md67YQhauGyLte/e1o6UtA9/dmCjqRp7ArSvVR6gPR3Nz5V6OpuQNU/FG2A
	lwknNmsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkS7-009rQz-17;
	Fri, 21 Apr 2023 06:41:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkS5-009rQK-0x
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:41:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD42E1FDDD;
	Fri, 21 Apr 2023 06:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682059259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHeW4tyVf6oZPDGbJB4iNrMzQR3MDrxIFhpfg5MiMc0=;
	b=TI10JoXOCETKcLdoHwCSSmjUSD0s+KhCsOCKZWEm6aF9qey+mWIF7PMOjBIh2zAl2OlhDs
	jQ83Fr0g9RFjL5FDBNw/1pixy4ZWNxOYBfn+albxGN52AzJZt4Sx0oG6p7stg1Nl+2S8Of
	OLOT24pfa0+cqX/hkDaT/1Oi+mU9OrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682059259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHeW4tyVf6oZPDGbJB4iNrMzQR3MDrxIFhpfg5MiMc0=;
	b=rYxfHKWXWHAyca0XcV9vAzS406UfBt0IOFG2LpjbVeMsNApqsKd3vmbLMYI96v3uMn9DSw
	0obmq5fULuLFc9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 886E313456;
	Fri, 21 Apr 2023 06:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yKzjH/svQmRBdgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:40:59 +0000
Message-ID: <23cd059e-c7d5-79ff-c95d-c156ed204a20@suse.de>
Date: Fri, 21 Apr 2023 08:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 1/9] nvme-rc: Auto convert test device
 size info
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_234101_493893_85E59ADC 
X-CRM114-Status: GOOD (  11.72  )
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

On 4/21/23 08:04, Daniel Wagner wrote:
> Introduce a convert_to_mb() helper which converts the size argument
> to MBytes and use in test device require function. This makes it
> possible to use user input strings in future.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   common/rc      | 30 +++++++++++++++++++++++++++---
>   tests/nvme/035 |  2 +-
>   2 files changed, 28 insertions(+), 4 deletions(-)
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


