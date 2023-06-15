Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70D2EB64DB
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WH1mOxnVXww19hxVqg6mJd5pC69heDnq/9XJzwgco1Q=; b=DOYhTXamdQXQ1nwauMrpaUEyba
	vP6rGve+KIhk9iYIceUGKBvyNSvODdcHS3ZL7csC8HIQyanpr7OZyZXcMoNpyGZxzhyPkp09yZk5N
	gjLvtamkZG1OoTBs0NtoOvVkFUtM3yHBJ9mqgDQuV+XP4Xl1Uw59Ruhq+/BBhuMxMnli9I4MTE9tf
	rXD/Hr2H8KY979noJrP2YrC+0MQWIkLLqRO14+Uik7j3bu4uL+/69SB5lN8tsSezBZCYPINZT8jhw
	nr+yQQjSjeGcDJHIxfeGOc5VIE/l/4TJdiiDgeJlN1PKjbZr1wrlt5j84nE9rEGCkWX+ae+OSbxMH
	9BsePe4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9jsB-00EPPI-2B;
	Thu, 15 Jun 2023 10:06:35 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9js9-00EPOh-1L
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 10:06:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE699223EE;
	Thu, 15 Jun 2023 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686823591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH1mOxnVXww19hxVqg6mJd5pC69heDnq/9XJzwgco1Q=;
	b=cYn/C7bZx8ySP+HeQK+9vk+yZsclzMHDTS/BPwkBDk8Eyr7DDHdgLwAx3xvjXrfgF35Y/7
	nSfrPw4++G1yZupHofx73GKVy2tYII05Zq5TMfDRMtN6i4bzLzNsJ7PEOuSJVuZgsLusuh
	XQRe2LRKrOaYEGZE6j71Yicp2+vkydA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686823591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH1mOxnVXww19hxVqg6mJd5pC69heDnq/9XJzwgco1Q=;
	b=25u5d22tQ+jkIbkpeLqw76KNimb7pmyI6sWsCH5usLZaYGB9qteRVdzibS76e8yV4iAkDr
	nP2/kFLITUyObCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE34513A47;
	Thu, 15 Jun 2023 10:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ivIFMqfiimRNZgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 15 Jun 2023 10:06:31 +0000
Message-ID: <457be842-a975-9ab5-8aca-02141e99b6a0@suse.de>
Date: Thu, 15 Jun 2023 12:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/2] nvme-fcloop: queue work items correctly
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>
References: <20230615094356.14878-1-dwagner@suse.de>
 <20230615094356.14878-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230615094356.14878-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_030633_604780_A84837F3 
X-CRM114-Status: GOOD (  11.95  )
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
> The arguments passed to list_add_tail are reversed. The new element is
> first argument and the queue/list is the second one.
> 
> Fixes: 38803fcffb5b ("nvme-fcloop: fix deallocation of working context")
> Fixes: 437c0b824dbd ("nvme-fcloop: add target to host LS request support")
> 
> Cc: James Smart <jsmart2021@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



