Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD32AD5B841
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Dec 2025 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1SIbo5gsrFw/49WZUB9+/6kb3koas7oJqYCp1fcr7tk=; b=4IZaZ1phz3Qt8zBLVspwhhXKTn
	5w3LmkrtaGOwUhCrfHEcUehocl4LBGun5f7jPw5jH3jqlljt6PAQ6dxfpZGZr3Yw4fbjeY2CvSk7d
	OfBJtgmKN6QiR1BMx0WpTpugNGraTnovt/cyBRuTQLDHnvHzJwxrcrVsJGHfJTuBfmWPp6DhYtwPW
	jSxrcrbeyOM+ylt8ItpJU0wsBDRcgJa6y7etpxVBQPXJVIqg8z2r64EhMKe4+my8oA9ffAopt7DjC
	L+T8d9PYk385YBER/SD3RN1I+sJ4jlP8bVVG3WMaLSd/5UBPTm5glnFmIiP6Uwb3frOeYM9t5FxwR
	4KoHDn3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVAZ8-00000003tvx-2eZB;
	Mon, 15 Dec 2025 15:32:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVAZ5-00000003tvY-38ru
	for linux-nvme@lists.infradead.org;
	Mon, 15 Dec 2025 15:32:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 431AE418F6;
	Mon, 15 Dec 2025 15:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2342C4CEF5;
	Mon, 15 Dec 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765812766;
	bh=aEQVMiLbvDRSXHO/8bGJyPa2l7Ci/SRkpraFLP/Lxc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+4bq+mhKwot8aSJYeW0tdN0x+gxVdcVpZtnse60m5xOxnKjUZatO+dWukN5A1QmI
	 tqZNR1Hhoe9PYIbd01Quy9sesiTrhd2xtP7sBzB9/mX/2wC2i8aKoZBXRUJV+6l9VP
	 bczCfpdQAVicEkiL0abzB5MnRzB8Yqnkya/prkgVjPHRScSHKdNU6xezdIba/w/05p
	 8WUU8fxHM6Wot6VMSok+zL2uYXUAuJCuRpXgp2XINXl8dUMx+uGKrrm/H4KNjVTzMs
	 e977KYL5eKsAGcwvWzKCx8VX7twfBrnxoRUpY8FJ6x6zzfB5MICaKOUthAGFppHwgV
	 aIreOqAPniyow==
Date: Mon, 15 Dec 2025 23:32:40 +0800
From: Keith Busch <kbusch@kernel.org>
To: Ilikara Zheng <ilikara@aosc.io>
Cc: linux-kernel@vger.kernel.org, Wu Haotian <rigoligo03@gmail.com>,
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: add quirk for Wodposit WPBSNM8-256GTP to
 disable secondary temp thresholds
Message-ID: <aUAqGO7GXRrTk4Vq@kbusch-mbp>
References: <20251208132340.1317531-1-ilikara@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208132340.1317531-1-ilikara@aosc.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_073247_811867_65DD300B 
X-CRM114-Status: UNSURE (   7.81  )
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

On Mon, Dec 08, 2025 at 09:23:40PM +0800, Ilikara Zheng wrote:
> +	{ PCI_DEVICE(0x1fa0, 0x2283),   /* Wodposit WPBSNM8-256GTP */

I'm not finding vendor 1FA0 registered on the public pci-ids, nor in the
pcisig.com members list. I just want to make sure the identifier is
officially registered.

