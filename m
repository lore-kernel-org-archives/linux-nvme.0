Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B05CAC5A5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 22:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0tuLYoWloCkn14jhRcWN28f9t8c1ombIlTWERc7378=; b=WLo0BmJZPUCPyCzU1ID6NmfTba
	PEQycnzdLbdr3i2tNCrrlpU4kW40Rytkj7OnnURULqrwcGy/NxUYe9FZkOsilxqT4X305ycpBhil3
	1izNmKQi1Vh3h8m6iU66kVlhF/8F5z120jo3vO+Il4bQ5GDc3lvpO2Tn3/5q4RVCmS3hPKQHCzQru
	79AmbiY5dlO8sFx+z9L7QvFxIjLG7P1CDY+2rV2R4OdetXlY5YX9yXzI0I1xPXaJouCzLEMuiJD6w
	rn/7IAqoj44MVDPAotzg2aJWGT2tVWoneu/P/HHhtvc1yG7NQ3RtWc02Vkc0tI5SABPi7TXMQfEgy
	zrKti/yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Xkw-00000004CKk-0IcF;
	Wed, 24 Sep 2025 22:14:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Xku-00000004CJF-0ERx
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 22:14:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B839444A23;
	Wed, 24 Sep 2025 22:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42861C4CEF8;
	Wed, 24 Sep 2025 22:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758752071;
	bh=u0tuLYoWloCkn14jhRcWN28f9t8c1ombIlTWERc7378=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fg8+Z5LLd3C+dO8pk8KMLZsYL+o96nJHNXukXF01d9AArzGQNzVYvTR6g4Ua7FcR6
	 o0H+iDfpeyZ3KK4HHp29YCUR8hn9rZGzt5fN0L07EdnwDFJfFT+Ia+CUKB1z/rM3el
	 p/yxAEl/Luw7YwZ0hoQ9HRJrj0fYvRcGZGtZFvN9I9W/pEApyjkqbM5zDK9uekT8W3
	 yy1lVWmNkDia0ZYyGqXCr/t2bvXAsAt+b+507MpbZ/PNdz7i1EnQkpaM/YLTqwmzWr
	 Vb0AUL82q7uOx03+v7yxAUTk2tlZ09Vldp3RBkpImWc6jb98K4s6BpJXP7yCLuXJwx
	 dibKtcq5DS9Hw==
Date: Wed, 24 Sep 2025 16:14:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 1/1] nvmet: add sanity checks when freeing subsystem
Message-ID: <aNRtRVvKBd3J3qF5@kbusch-mbp>
References: <20250924203544.11494-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924203544.11494-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_151432_128397_43BC9D65 
X-CRM114-Status: UNSURE (   7.64  )
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

On Wed, Sep 24, 2025 at 11:35:44PM +0300, Max Gurtovoy wrote:
> Add WARN_ON_ONCE checks in nvmet_subsys_free() to ensure that the
> ctrls and hosts lists are all empty during subsystem release. This helps
> catch resource leaks.

Looks good, applied to nvme-6.18.

