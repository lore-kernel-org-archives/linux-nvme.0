Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE62C636D4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iGWD+SprfSOlldl+B/Tyy/ypI5TBkfbmJRTiKDPGmr4=; b=y2RC+zl6IPgXMDyVMgJL8+jO0r
	ZOazwGGQ6wNKpdhOcV5j70fCfOQ+5OvvuEpHsup/qzl9hk6R7Hz+hZEHbiSPEQNccu77vmFxHr/gR
	ewiPNn3BPnD6xVaXKpbvvHrEWmDwQISl6HrRJgkLdZ9wRVYRqET8cHtHxZwg7LvfaN/+LhpiW0qpl
	UiUGgkiQQ/U1YWgdhOuHxi+l0eQ8aZ3cDFusBJkmCjmS/wA7wm1ctoGJaLsLwes0UtlY+390dtB0C
	3iulRXhodJDhwnQ+7fdSCbiHRgnKHyAIokv86tKv4WDDTHkHSGhyE3ViOmmNwhYmUM7XJpytBaLlB
	Toa6DBug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSErm-005QgR-IH; Wed, 15 Feb 2023 10:18:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSEri-005Qfo-MU
	for linux-nvme@lists.infradead.org; Wed, 15 Feb 2023 10:18:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2424D2056F;
	Wed, 15 Feb 2023 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676456297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGWD+SprfSOlldl+B/Tyy/ypI5TBkfbmJRTiKDPGmr4=;
	b=VKhWDp/SFFnaHOAlhyTFlE3Z4LYovGPgS/Puuac4rA2ZhaprutA4KSboAnDRiT/KtLsj7W
	fRpRBrsCklfgRy7vwDnQXLuKeQvWM6g4Ps86dM3C1tLAcZYR4dD2Jr7e9Lq6Ysgat4EluV
	XBpt/FJNJ0ezAYXDrfIjOkfRb62KMxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676456297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGWD+SprfSOlldl+B/Tyy/ypI5TBkfbmJRTiKDPGmr4=;
	b=fqK21/Jy4fB9EBHvdoKUWYHZnHJuEOixP/fOZYTdKax0FF/v4nrZNRC/zvNnvcES2yDfDZ
	LvBJM/ZEcsmAcpCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 180AC13483;
	Wed, 15 Feb 2023 10:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pMzeBWmx7GNDDgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 15 Feb 2023 10:18:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Martin Belanger <nitram_67@hotmail.com>
Subject: Re: [PATCH] nvme-print: print the nvme generic name in json output as well
Date: Wed, 15 Feb 2023 11:18:15 +0100
Message-Id: <167645627462.19686.1711215919099142360.b4-ty@suse.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215090020.620994-1-sagi@grimberg.me>
References: <20230215090020.620994-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_021818_920019_38850E9C 
X-CRM114-Status: UNSURE (   7.79  )
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

On Wed, 15 Feb 2023 11:00:20 +0200, Sagi Grimberg wrote:
> For both simple and detailed outputs present the nvme generic
> chardev name/path similar to how the ns name/path is presented.
> 
> 

Applied, thanks!

[1/1] nvme-print: print the nvme generic name in json output as well
      commit: a7c8f55e8518051da9742981607e1771839d2d8f

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

