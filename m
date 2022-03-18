Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74F2C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Mar 2022 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KxjqWFBERSi2oHdVFKiGE5cX6oF4ziBxopi3WrsJs8E=; b=TOLd32WHNEaAW+cC88ozJYK2nO
	8jg/F20KvUnUwFMPEMNqKYdOjGLGQPk5jIw2VI8aYjyyx8CNIjB/GV30L2V0O5P4cQKvQldqo1qCG
	5OYDUNZORnYUNuRPVyUKmS6oIp4Cm48bCABVT0dCaOHTtkv6Fq5yQnAcwbpym29/1nsZwEly+H/eB
	98ELxRpS28qudTFJpb+0EMncUXDz2gzWK+gc+3crWh9pIzYGoMraF4OnYxEztv1BtWoYdb7jQUuXX
	EAzAUo0BF8wG5IlMbCZ3V7O1GGTcoqr6WCHKm86ypNkBAvtuVqz3Rtd7r0VyqJfnSXEtcAgiyjSj6
	KuJQMz8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nV7ga-000kKD-HD; Fri, 18 Mar 2022 08:10:12 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nV7gX-000kI8-6U
 for linux-nvme@lists.infradead.org; Fri, 18 Mar 2022 08:10:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D52D21F38E;
 Fri, 18 Mar 2022 08:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647591005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxjqWFBERSi2oHdVFKiGE5cX6oF4ziBxopi3WrsJs8E=;
 b=qwK6/JOrQbT5hNYsx2jKgTJN8fxXDRiXDFh0YI2ZVbsM8Hc+gZDgSDD4trE3ld5Hhx1DV8
 Xpz6S4Ja4MqcKDmLq/OBhnlzOBxHYxiECZauZOtLNm1bmqhAs1zkTdfulOiZM8qBEMtSvm
 po1x/hAtr8f7bnYaPxmIg4jSihKwjUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647591005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxjqWFBERSi2oHdVFKiGE5cX6oF4ziBxopi3WrsJs8E=;
 b=9RjMzJoyZC+rJXu+M9QQ4yKreh48VXdlxoGqPHYCyvPKoW31ocKSYtuFeZygrvtDu0r64X
 /Sx04GessjTsgEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C834413BB5;
 Fri, 18 Mar 2022 08:10:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hCvXMF0+NGKmHwAAMHmgww
 (envelope-from <dwagner@suse.de>); Fri, 18 Mar 2022 08:10:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	kbusch@kernel.org
Subject: Re: [PATCH nvme-cli] fabrics: keep the backward compatibility
Date: Fri, 18 Mar 2022 09:10:02 +0100
Message-Id: <164759099582.29639.407645274457065972.b4-ty@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318012408.24779-1-kch@nvidia.com>
References: <20220318012408.24779-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220318_011009_435446_06B6D69B 
X-CRM114-Status: UNSURE (   7.61  )
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

On Thu, 17 Mar 2022 18:24:08 -0700, Chaitanya Kulkarni wrote:
> Don't print the message while disconnecting it is breaking blktests,
> see below without this patch :-
> 
> nvme/005 (reset local loopback target)                       [failed]
>     runtime  6.799s  ...  6.814s
>     --- tests/nvme/005.out	2021-08-29 01:09:20.287901783 -0700
>     +++ /mnt/data/blktests/results/nodev/nvme/005.out.bad	2022-03-17 18:11:16.198191553 -0700
>     @@ -1,2 +1,3 @@
>      Running nvme/005
>     +Disconnected nvme1
>      Test complete
> 
> [...]

Applied, thanks!

[1/1] fabrics: keep the backward compatibility
      commit: aeca69dcb807071545cee31d195c16fc6da23168

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

