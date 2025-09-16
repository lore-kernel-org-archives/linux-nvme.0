Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8D7CAC597
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 00:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ONGLoJVIPHA/jW9FBJpkiyr52N/UW11YGEOInd3wTgQ=; b=YeCBKPkbVyozq/rltCluRJfmef
	sFyJMwNLy/e4+NEwF9kDihyVAHwRA4NunXHAEouur6WEi1O+4SJcH9d0p8S7Oae4w74jTFbin23u0
	B16cxqWaMhzK6+q43BkOfOTSTVJFAQ/um8bD/VchPjsuaV+drpC34gdpgRnWYbNNW4BPOn49Rdn/I
	tkCFxMpuAtcTe26l06fyU3qOpAtax4uqRu3Ot21jxBA4zL8IdnlsSS+E+DSb5zYJWbq7USVEMBlt0
	ZiZfPJPlzNxSAarJE8DwMQK6xYbKWLuutAEUJg3OSD+USqjlu7i3zK40cDT4QwJpQ8xQE3gWVR+tG
	0d14eefQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyJ9K-00000005wjP-1mNV;
	Tue, 16 Sep 2025 00:02:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyJ9J-00000005wjJ-35mK
	for linux-nvme@lists.infradead.org;
	Tue, 16 Sep 2025 00:02:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D5FA0600B0;
	Tue, 16 Sep 2025 00:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE7BC4CEF1;
	Tue, 16 Sep 2025 00:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980940;
	bh=ONGLoJVIPHA/jW9FBJpkiyr52N/UW11YGEOInd3wTgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0/6wZG893erg9AIbf20nqptKxAybqZHTut4JbpTBcYxD/BVa0OfaV+d2tby3akAW
	 2SeQIrwRhc5gT44hFylRU7+/jn0/ruIsLztE1UZdxMVA8FmEToIVCRXnrlb8aItJDM
	 YTN83o68jZPkJ9nT4nInGNCaA/OHopcxnKhT2H/tpOcJ7qwM+egveXrjU9HF/9LlGF
	 6Mn39XjX27KXnrx+8tErCuO9yUOCJpUhAuabCSu9FgpbhP3x+tWn0Iy/tz5B2Rvte6
	 aCbhOU8fjMAk62ICphW4M33wIFeAYEsjyv3qQnNtbMmgjFznQhsOsO/4XwRwmwzZ1H
	 2CiwXAtNjqlJA==
Date: Mon, 15 Sep 2025 18:02:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/2] nvme: fixup HKDF-Expand-Label implementation
Message-ID: <aMipCom_QsczFx9I@kbusch-mbp>
References: <20250821204816.2091293-1-cleech@redhat.com>
 <20250915-expectant-limb-a1464f3a1076@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-expectant-limb-a1464f3a1076@redhat.com>
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

On Mon, Sep 15, 2025 at 04:17:49PM -0700, Chris Leech wrote:
> Bump and a polite review/merge request.
> There's been no feedback requiring changes in v2.

Sorry, I misunderstood the conversation to suggest this was incomplete.
Applied to nvme-6.18, thanks.

