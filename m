Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DBFC7618E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hhJBJVo6lSGdi5/O4sOXrQaykbKK9fdhVU7edHHlylE=; b=gyo2N3enn7yz156EM/Vq/oUio8
	uHo6zoJyLAvOPPj9gwfyQBOQeP5vLGtEBE7JOYJL120b5ZUVwSwbJaTOyfYB6l8QDIGBL0Ztk7TPa
	1NDQ5gkk8nB7j+VFH17eImCsFITeGSGvQU/Xr5xG0+VbLfQV1IWlAXnoXBNX6Qfd7Hp+Tyov3hsPA
	yYNVUqcOrkskYh3WcHrJ/jynqh20dMnBvuIOr1xLg7xxkHxMelsP4QO1lDCBw02XqLDlN6cY2NUps
	Ld3JrMQcZIoB8dN2h+vsCZiltt1sx0f2pFkTbGvxaQTGQpEkLXKcko4ro/2XzerHaYNbe1kQmF56n
	rFLVkhUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkAy-009oIF-0x;
	Fri, 21 Apr 2023 06:23:20 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkAv-009oHM-2a
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:23:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E85FA1FDDC;
	Fri, 21 Apr 2023 06:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682058195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhJBJVo6lSGdi5/O4sOXrQaykbKK9fdhVU7edHHlylE=;
	b=DSJECFvToHXrTvcCalcTp6/qlzl5C6A0KWrIKo+tgS9UF5JHiPpRo94ZoUkmCGVnYN+9ak
	LT7reZvrfkHdAZMxIzO9QgUyF50kkN5/px+sUSGVsWZqTSOVP8WJUw7F57G6XLz3wVFDmg
	3KHh0tVEJPybx0WpLh2n7V5Uqsn2NPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682058195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhJBJVo6lSGdi5/O4sOXrQaykbKK9fdhVU7edHHlylE=;
	b=A2TpywmWtZvEltYCF/tznTJdkKBug3ZRkn2p05V1TBn+5U3Cy/WJexf9rxzip3kp+2WJns
	y314nDhp4NtJHyBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C69C41390E;
	Fri, 21 Apr 2023 06:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KA2kL9MrQmSjbgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:23:15 +0000
Message-ID: <43e70fe1-dafe-6f15-a41a-a879c2e06b27@suse.de>
Date: Fri, 21 Apr 2023 08:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 2/9] nvme: Do not hard code device size
 for dd test
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_232317_981196_212F4BE7 
X-CRM114-Status: UNSURE (   9.70  )
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

On 4/21/23 08:04, Daniel Wagner wrote:
> Read the block device sizes instead hard coding them.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/014 | 10 +++++++++-
>   tests/nvme/015 | 10 +++++++++-
>   2 files changed, 18 insertions(+), 2 deletions(-)
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


