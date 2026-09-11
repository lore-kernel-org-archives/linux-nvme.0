Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76EBC88E4C
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIQLIPW/lG0A5eiA6gfbl3WMg1gE62YchZlK8GU+8C0=; b=BV56ZnNEALL0HxItt2fixnzQ4b
	3NLedQlgdy2UPeDlZ8hJRCfHxtZOnT8hQgRpcf1AufWSsaWcnD2SaYOiUGrOcPmrDUEtMbOchYX2r
	mK46mpwBEorEK1C5ufT9tnmcSY9DR+VCXz0fk9+gpCEtK21udtmTQ/3M+andn2RNgUaNWxqMgFyNn
	ygDyY0IAUfAM6wZqRSW67K+VdEiKs5rmGe3HjWFMw+mCz4TlpaHQcYNXY9pHz0SCHWllcOqH8mUgS
	wV595opEDUq3JvsukU3EdD4XeC+4uiJuuE31C5qPhnhKxJ3icJgFvazLQLtSC+4EHyvpRm5IyscX8
	37O1YxmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4x7R-0000000GCkL-3qS4;
	Fri, 11 Sep 2026 09:00:25 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4x7O-0000000GCjF-2ll6
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 09:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1789117210; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=obQGEe9jww7dY+YaZBh9EEUOtpQ3rqCkpVDbAlG1vnc3bHO5K7+7nXnN3/yiFj+qbX
    /SW5bW31HDeKUCMtmM7mXbjJW/OXf8zvxYiH9f3bZB1NzkQiR9SE+AK9p2siWBajTzXZ
    qvLdYlIcVDn9VULwMyt7M4gb4YYGnO8fZlPx/Zt1DG1BwH348aNdZjO2TRyVj56MbdsO
    UQ7vfTIuW3Hj16EkPXJDTHuOr12JDwD1Ls6Vt2HWthWB3Gv9MW2EJ65vEbroreG8+RnX
    LJTY/lujQPsfRFDlwlQmz5mbr5kdVAFTANnzmvaxWmrXBUsmAtCnFRvSBGlFE08v+l3X
    rvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789117210;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RIQLIPW/lG0A5eiA6gfbl3WMg1gE62YchZlK8GU+8C0=;
    b=otuk6ExhE+x+8VYFy9rYBl6BzmdXKUIB86z8WdPj3uA1N1Z3YMBDcS3kO4P6prAqQb
    d4ABUfPcJATGrHAod46P9VSbmjNjnxe6R59cHnPBRviSoZloABhtspOuzEPqzXmOQ2dS
    hCK6Nlsrzckoly2MUOy5bMn8EM/CHulBGqcGaLGZOxr8ZjwmDYTqs61YY1clQbR7asY+
    CxwuZS8yUnvpDIUymoBQk/jx9VH/+SyG7QSz4/LyUokVFR7Ly2DG/t38gH4A1vPXofq+
    cv5O1GAnlztXVyprJRqlAnfnTaS3CfT4ql+XGK+gkanxVl3gon3hXHnI4yQ9MoXqMOgw
    1a7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789117210;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RIQLIPW/lG0A5eiA6gfbl3WMg1gE62YchZlK8GU+8C0=;
    b=bV1pnWzVIns0ap0W2bbMbaxErPCZledc3x4vtnP58RC97MYNlQWgB+gm2gLcvYaBPi
    eE4gDsleJ630lKM3TaAFW5GMLU8lGGB40gLkHeBbl8v/00XqMoecC4dWOI9PH5Zvo3OR
    +e5x7uUaa96wgYEI61uesXHf/PQc+bti5o9a+r6J3karurs3Xv+qJF73EjXMT/vE0CqO
    jNk4w5xB7eRNv9rmgGQUan8+5nJJdQHY02etf4nghQ/QlLrV+cOtCo7iB8Cdad86zjDn
    AWGiPbUDlUuXUROKflYkq5/mIm0HU04IjY6NOHU8IJtuJzAU9UuMLbCnLAps9izcgKD/
    U4yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789117210;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RIQLIPW/lG0A5eiA6gfbl3WMg1gE62YchZlK8GU+8C0=;
    b=tUDgNbwduPzEaXa+94TdD9Qcp3iv87hKt9Tq8O4g/Edlntar0RnNF9qaOHwI/+7sys
    3YbfWpqnTV/JQb5XmFDg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RP/6IXJ0LLxyHglCTuLc+iTpLgXEQ+UPkzrd1E="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze37e128B909Sb5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Sep 2026 11:00:09 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: beanhuo@iokpp.de
Cc: axboe@kernel.dk,
	beanhuo@micron.com,
	bob.beckett@collabora.com,
	gsinha@micron.com,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron 4100AT
Date: Fri, 11 Sep 2026 10:59:58 +0200
Message-Id: <20260911085958.1255102-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904105155.1402065-1-beanhuo@iokpp.de>
References: <20260904105155.1402065-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_020022_952406_B900CE19 
X-CRM114-Status: UNSURE (   6.71  )
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

Hi,

A gentle ping on this one. It is a single id table entry for the
Micron 4100AT, reusing the existing NVME_QUIRK_DMAPOOL_ALIGN_512.

Happy to respin if you would prefer a Fixes: tag, or a different
form for the stable prerequisite lines.

Thanks,
Bean

