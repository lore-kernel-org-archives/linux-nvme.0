Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67706E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 12:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oth5A1D9jgFnEXtptoy/yP7DVl4PHu0H9U4yvomeIh8=; b=InavLRKPO7TR+2VgA69smE2PzA
	2YC8TD3xiUlFn2HzDwwfdXBxTEhrBqzpDZkmdzm/vX1PmM16szJLphfVFbAT5mONq7baBTHfKHj4X
	PmcJPt6nwMCgfu174ZdtzBBtLqrR80QqK7i3zegsz9/wYq/2RHFfl3Lo0nbufVAO3eMixINDzjBTA
	LZAFozqnYRKbOkHsKTeWdMc44a1/hQ/uXSMxAyGMmw5zz+DIANj1Q6cLuo4V3dzDOob3IEybsSU1W
	uTvEGrQD9apgpMVgT1KrvDuCSqyYBbmn2wSFA6LrsOGMCTjZ+zOc02AFe4b4hITZe/73lGZuep02e
	jOIK7Jaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV8Kj-00000004ge1-0TyH;
	Tue, 07 Jan 2025 12:05:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV8CI-00000004ecL-39gb
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 11:56:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B7F2B5C6132;
	Tue,  7 Jan 2025 11:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE4DC4CEDD;
	Tue,  7 Jan 2025 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250993;
	bh=8y0Je0pqvXm9t1GqxnskLMb507K1rpFqrSNkfQC6rHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3W1zkIrUcEjR+Ho9KxTL5eChUAV7id+pGjhUsfn4eWrOQ1aTSLW1nh+zAYuJ/ikP
	 uE/GyhcGITOarD3rED0hfaqn8SaD2IHqgZnzp0eYr0wqWRXRQvJhqz70ptVdoJ1O5u
	 5qWhP0IzabzVBsTSDzd1ABBZJrsKm2luMUkCrc9WU3LgrVcRpTBfk46YFTS/sUmMQV
	 c2AfOLrcFfneevGJ6KrXGi0qog53a0AGN+t9A9TuSJmkAAmREQSeTHJkiT71BuqP3w
	 T+gOv9dL4gOtapieUeS4q8lnj8ZpKdnWiR+eLw8wCnB+xn2cRA1zMLP9JgpRsw9glS
	 P4K0PDMTzJt2A==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <wagi@kernel.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH nvme-cli] make: fix make rpm target
Date: Tue,  7 Jan 2025 12:56:17 +0100
Message-ID: <173625094282.34393.6851575438975247814.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107112711.192068-1-sagi@grimberg.me>
References: <20250107112711.192068-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_035634_831327_AA5CDA39 
X-CRM114-Status: UNSURE (   7.27  )
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


On Tue, 07 Jan 2025 13:27:11 +0200, Sagi Grimberg wrote:
> Not specifying 70-nvmf-keys.rules as a known spec file results in this
> error from make rpm:
> error: Installed (but unpackaged) file(s) found:
>    /usr/local/%{_udevrulesdir}/70-nvmf-keys.rules
> 
> 

Applied, thanks!

[1/1] make: fix make rpm target
      commit: 839e3d3dc9fff4623b0f5de6810a1c4c0ef305cb

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

