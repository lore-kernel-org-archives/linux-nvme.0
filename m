Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53389EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atHh4oZI3Lsgj++bTTX/cCma79tEArLh42dujofeoy4=; b=SZSzsx8VH76SjtF0J9twvi9SSO
	uuI8vsCJSb5Ua9/rTBp6D5SAV1tvp/KlxySM5IqxpgqFjnBuLIFb7V/NBXEHIP+O2PhukVuDQ9OcM
	SeNIbROkMKicevOrQjL1oSiR6QKgVgOBebUJuhmqsMi5vpLVDx8T2wIjMXCIYw7AqhlKLZRZhMEc/
	wfXiPJxtcbijWMpGTKNoqB0JLHt3QTxxrCHVN7MLSN9SiTf1OJI3/W++Jxqto3Xh5Pxt1lp+GPCMl
	qn4yuOPoO2WKt/35ul7oSf+QRbxY47vtr13ZRVFEXYP3NyBBx7Nw+wJCO0IImW0ap2g5yNlH5yox1
	eGbG2DBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9jrj-00EPJm-0p;
	Thu, 15 Jun 2023 10:06:07 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9jrg-00EPIb-15
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 10:06:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA87D1FE03;
	Thu, 15 Jun 2023 10:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686823562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atHh4oZI3Lsgj++bTTX/cCma79tEArLh42dujofeoy4=;
	b=GpVS4WSngjatjfN3tY/rif++DZgurobmGiLntZx3MnP37Rd7fCeizQ7YNdcCpmrhkjX/uc
	cokIdZHX2Nikwhn4zWEX2PJ4PY4MtHOZ1qB8HZG0a1dO7r9LgOSCI8KcfIOCE7GQCsU/jB
	hTw1idddJ2d8t9qrkCyPOteOxuPQflM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686823562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atHh4oZI3Lsgj++bTTX/cCma79tEArLh42dujofeoy4=;
	b=QLf5mIhi+VSkUhJXZM3R0anBQSteqJFIAYNWOxTvxK/shYcp5SRNOclkMRlnmHcmAc4FiJ
	y4kgsj+Wa/UJitCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C426C13A47;
	Thu, 15 Jun 2023 10:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id y6ufL4riimQVZgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 15 Jun 2023 10:06:02 +0000
Message-ID: <5d652560-cd80-228d-a107-a2cf8abda45d@suse.de>
Date: Thu, 15 Jun 2023 12:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/2] nvme-fc: Do not wait in vain when unloading module
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>
References: <20230615094356.14878-1-dwagner@suse.de>
 <20230615094356.14878-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230615094356.14878-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_030604_524515_09212F10 
X-CRM114-Status: GOOD (  13.15  )
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

On 6/15/23 11:43, Daniel Wagner wrote:
> The module unload code will wait for a controller to be delete even when
> there is no controller and we wait for completion forever to happen.
> Thus only wait for the completion when there is a controller which
> needs to be removed.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



