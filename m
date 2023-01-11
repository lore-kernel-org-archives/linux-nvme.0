Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D89C5479D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 11:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ghqUcxg9FcKck0SVZ+GPhcOgqDHbAjj1Lcy4shAMxtU=; b=Pw1YQcKtFYX651MJag5wG76DNi
	kwnWvFMw9fXLdY/xp1huM8LpokAJn6AiTwuKOGos2oqYAVHjz0G50303mRFFE4aimqCEmY3PpJMPY
	TnQ3LlphEhzwR/jmCmHGMJRDwWSJ72nFE9fcWUy49t0Spik1x3tm5moJ3Uoxg1XlEKJqo0tWhhOX5
	fcGMPjYe0IIxR4afON04IAv6chDKT88bMwK2Pf4NlvrEQWH30mNy9pEopSf9SP4B7PLmY4e7tHaEZ
	6v7kRGDLHdgdoh8VpjvkJHUc3B1pEWOJ02BV6t2k3Rc6qIIHB3PBmEKwjb+QRpOdbExcVJhRdxQAA
	VqNWOnVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFZcA-00B9s8-Ar; Wed, 11 Jan 2023 11:49:54 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFZc6-00B9oF-Hv
	for linux-nvme@lists.infradead.org; Wed, 11 Jan 2023 11:49:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8365D4780;
	Wed, 11 Jan 2023 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673437783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ghqUcxg9FcKck0SVZ+GPhcOgqDHbAjj1Lcy4shAMxtU=;
	b=1b9FNfULXbF4zKzFs6oNlq8ghnE8lbi/0jzKT3kMyOPbpBp5igM2L1lWwR7TyVGCHBtSWV
	5NUnXresvFLts2WCsWuZ6upEBUJfTi722xmhphRmwF7uGDoiCEh8rTPTpLzGzbuv51bVUG
	+P7shv4pji9lcV7ErgyOaKubzAwcork=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673437783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ghqUcxg9FcKck0SVZ+GPhcOgqDHbAjj1Lcy4shAMxtU=;
	b=rF12AgP3ADEOSGgBhI7qiptyz8PBaVH1l3ZO2AsdsSdMnbTk/++ilnCBJLweWhUzqZYtFq
	G4opZU/6V3PnSRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 694AD1358A;
	Wed, 11 Jan 2023 11:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id n6jiGFeivmOwMwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 11 Jan 2023 11:49:43 +0000
Message-ID: <06e4d03c-3ecf-7e91-b80e-6600b3618b98@suse.de>
Date: Wed, 11 Jan 2023 12:49:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To: lsf-pc@lists.linux-foundation.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] Limits of development
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_034950_797092_596C062D 
X-CRM114-Status: UNSURE (   7.38  )
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

Hi all,

given the recent discussion on the mailing list I would like to propose 
a topic for LSF/MM:

Limits of development

In recent times quite some development efforts were left floundering 
(Non-Po2 zones, NVMe dispersed namespaces), while others (like blk-snap) 
went ahead. And it's hard to figure out why some projects are deemed 
'good', and others 'bad'.

I would like to have a discussion at LSF/MM about what are valid reasons 
for future developments, and maybe even agree on common guidelines where 
developers can refer to when implementing new features.

Cheers,

Hannes

