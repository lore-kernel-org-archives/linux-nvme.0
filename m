Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7223C77B6F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qedrEto6BSbibuzJ5+x2W25dAPzn8X5JdYmSaRBrZLc=; b=B3ir/YmEH4beXOBnyApiTM2pjB
	GnHmfCOWV9DyZgzpRa9nUztPY7fjZDkiT3gXx2pwge6AC7P93/2PxhZEwoVEAbAueE0nXdw6gnY70
	S1jb+tpTYy+SvvOWvEIL6hwluHBw0K/96RuIVLivHjma5ntxQMBz6PG/OazbSvSXBT4EjpdmqeAdy
	kByD+xd4rusPEOhNfjjZM0kxFT0ZfhE38dGuC5LGkgetWmOOS4R/2qmMoxZFkMBJv0mWBEQppOXdg
	52DLz4KSpD/znVubP7R/pdwXyrjbVsQDc8TWWnztyeYZ7BGg8MwtZ4S1h7giGYBoRcEFhYE2H8c1n
	/LAoMC4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Dn-00GgPN-33;
	Tue, 11 Apr 2023 07:15:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Dl-00GgMo-1G
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:15:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F332E1FE0B;
	Tue, 11 Apr 2023 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681197316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qedrEto6BSbibuzJ5+x2W25dAPzn8X5JdYmSaRBrZLc=;
	b=Dc5EpZpBH/ZJJFa3TKbbpnvKMC4/1OEsMW+rD8BXmbb04VVNFuYSyazz9qsMmuHaeHBFjs
	jxZ0ORzuKGjr/IqtV/pHJ355oVgFUBcbGFmJcDsVNI9WrSnPRl7G3+oP/7Niib5r6rD02n
	CtbBQE61seBEBTzb/p8/5pzzh6wxxSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681197316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qedrEto6BSbibuzJ5+x2W25dAPzn8X5JdYmSaRBrZLc=;
	b=9Q+m+4oyCJCpXuiSbBSh6Cx3zz2ZltnZADWGLsaOE5V/xsxZJ29K6rzwWQgPYLvGaa1Khl
	UbJO8UMMz8PDnzBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9FA313519;
	Tue, 11 Apr 2023 07:15:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 77sRKAMJNWQXXgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:15:15 +0000
Message-ID: <7ceeaeec-64c8-f58c-b792-1f43647887a1@suse.de>
Date: Tue, 11 Apr 2023 09:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 07/18] nvme: Fix reservation status related structs
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-8-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-8-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_001517_582709_BFA9CC1C 
X-CRM114-Status: GOOD (  12.39  )
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

On 4/7/23 22:05, Mike Christie wrote:
> This fixes the following issues with the reservation status structs:
> 
> 1. resv10 is bytes 23:10 so it should be 14 bytes.
> 2. regctl_ds only supports 64 bit host IDs.
> 
> These are not currently used, but will be in this patchset which adds
> support for the reservation report command.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   include/linux/nvme.h | 38 ++++++++++++++++++++++++++++++--------
>   1 file changed, 30 insertions(+), 8 deletions(-)
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


