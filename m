Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83067C07E9B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 12:48:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4773561009
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 12:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4773561009
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lFbZExcrlpV2gmpwpl4O9XKRxPjgnLjvuy6Z5tfh7X4=; b=v6dPXiHBd4Kj9O
	DFrVUL4RtCiLxTBllGXcH9YL/fSYgy6cePAy7+Gu5JbgI3j6tP1EBFPoubVxkHFRRc6Xru9Ky5QS8
	Szmsx6/P8JCsupfAIMW2QHokBX1DgIapiltqueM0ELg415D7BQ0JWj97ytuNeTnCRYcBIbZwSMS1P
	9n/uWt1ITYd6Oo5McrGZumnNki+0ITi0b1cf4YKuuvCHnoZ3Dyp/yJrCs8TvwPcNZnTS2pS0mIPMu
	ADhZPm5mgZQkMwcVm3jnSe/AKo729/0j6v5zcXuaPv2koUOwyWyc0zCaZmy8FrO0E84dpLRI5d6w6
	UENcV2RMcLV3fbfXI74g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5pAL-00CpQS-8A; Tue, 20 Jul 2021 12:48:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5pAI-00CpPQ-Cj
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 12:48:03 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16EB222425;
 Tue, 20 Jul 2021 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626785281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W1zCtGLplWApScXZ1uLwvVrRWFVgIRci4OmMqdayuVE=;
 b=vkN3BTO/2QXkkbQ1s6QpiIBQHDzgm6xgRvLHLbtfT4qBR82xpCIl4r0CrlAvAwweIfiCuO
 kl6dJfP88trk28PP3u/jYKXcFJoRAEJd8/hzF37jCnWvN41Ff+Robvk7GAh7gCHvbpy68n
 mMJcLnk4Sydmks7HCmRRbPnOc/jMtwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626785281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W1zCtGLplWApScXZ1uLwvVrRWFVgIRci4OmMqdayuVE=;
 b=HvuRSFGtw8pDIni1fa4Tztt3vw5dqqFZA6WILCWLMahiFoUNmf+J+8ZRixdg3PQXei8tLP
 qLPdwNSSyk+JXGBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F29EF13AB8;
 Tue, 20 Jul 2021 12:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 1mDHOgDG9mBoZQAAGKfGzw
 (envelope-from <dwagner@suse.de>); Tue, 20 Jul 2021 12:48:00 +0000
Date: Tue, 20 Jul 2021 14:48:00 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 0/6] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210720124800.i2lo3hal7kjfc7rk@beryllium.lan>
References: <20210720124353.127959-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210720124353.127959-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_054802_627809_01021E54 
X-CRM114-Status: UNSURE (   9.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 20, 2021 at 02:43:47PM +0200, Daniel Wagner wrote:
> v1:
>  - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
> v2:
>  - https://lore.kernel.org/linux-nvme/20210708092755.15660-1-dwagner@suse.de/
>  - reviewed tags collected
>  - added 'update hardware queues' for all transport
>  - added fix for fc hanger in nvme_wait_freeze_timeout
> v3:
>  - dropped 'nvme-fc: Freeze queues before destroying them'
>  - added James' two patches

Forgot to add Hannes' reviewed tag. Sorry!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
