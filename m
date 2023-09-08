Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A697EE57D0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 06:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8F49nTEGpcf3Tsrq6gB2cLzMdUH0MJKv89igSWXxnM=; b=pbnxEMbxGwDVG4h3QJTOJn1iDk
	dxjPWNbIdHFvA65o/DlqTvJvt0ClX28MlI85L+uu0Rme006Wgn18ZFWbr1PqPu6HulOVkahbvYOud
	xfIRsvxELbVQpw8/W4vvZvXG6wbxOyJmC224z9Wz+WAcA9tvRlsbOUJJfiEKwiZZjU77YDqF1tj0O
	BpOCQxBBEFwnfxxPuOJi4CQSo1eZNMdqNm0oO4ZKFRk48ipVy0IAf8b7fMG9dGaWCyAIcu2ORYjbO
	8pLGEOLnErUvQ4ofr0A3lKhkIY3EwDtq3FpkKKtzXCLxlylC2qyM116sRIUj4EflutJqTBhUR22Rx
	iVZH9//w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUga-00D89d-31;
	Fri, 08 Sep 2023 06:09:44 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUgY-00D88W-0e
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 06:09:43 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E15C1218EC;
	Fri,  8 Sep 2023 06:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694153380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8F49nTEGpcf3Tsrq6gB2cLzMdUH0MJKv89igSWXxnM=;
	b=la6V6ou/e2WWjCjInvBTAoIcJNjIWTRkB/MPGo7fp92S9XUzGhQztsWsxtL3mRiXZebNqg
	jSfOJ3dBf+xSwlQYFEhtyz9vTWsGbKzIn3yJEhkee4xkwCsVfjrCuXwdeohTJFxt4pifj+
	almdn9+/ZymSpEY/Z9c9PYYdZMCQ7O4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694153380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8F49nTEGpcf3Tsrq6gB2cLzMdUH0MJKv89igSWXxnM=;
	b=zr+gzmkKB3kFLLW5t+GeilEswq5cubBiIPy6C5FCfI+dfXUvPWovxCJSrbnvYpZWqO2Vy3
	UiQzr+UNzhCr3TCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E6A9131FD;
	Fri,  8 Sep 2023 06:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2GXfGaS6+mQYaQAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 06:09:40 +0000
Message-ID: <2b568b29-c4f4-4058-9a83-b1f37290ae34@suse.de>
Date: Fri, 8 Sep 2023 08:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 07/12] nvme: add copy offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com,
 Kanchan Joshi <joshi.k@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164350epcas5p3f9b8bca1a2cb4d452e5c893cd3222418@epcas5p3.samsung.com>
 <20230906163844.18754-8-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-8-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_230942_382980_707B25FC 
X-CRM114-Status: GOOD (  11.42  )
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

On 9/6/23 18:38, Nitesh Shetty wrote:
> Current design only supports single source range.
> We receive a request with REQ_OP_COPY_SRC.
> Parse this request which consists of src(1st) and dst(2nd) bios.
> Form a copy command (TP 4065)
> 
> trace event support for nvme_copy_cmd.
> Set the device copy limits to queue limits.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Javier González <javier.gonz@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   drivers/nvme/host/constants.c |  1 +
>   drivers/nvme/host/core.c      | 79 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/trace.c     | 19 +++++++++
>   include/linux/blkdev.h        |  1 +
>   include/linux/nvme.h          | 43 +++++++++++++++++--
>   5 files changed, 140 insertions(+), 3 deletions(-)
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


