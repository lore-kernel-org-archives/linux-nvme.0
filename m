Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09EECD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTOZtf+TSkG7jTuwgr4Xv/jydgZpyrVWr07agLcMSSA=; b=233ua3AG8bOqbyEnP43RL1U74d
	BXy9ItjIeixcsv92fJFj4JnhOKtGfCUnz6YRyNY7H7U0nFrSuiEfeyE8o/uBon8fPSEti1LbnS9bO
	zUBD/gMpIuef++ZemkADPCuOGElrgiqOw2JnLf31igE37xnxozj6NSx6fZdi3daBQ5pic5gKIJv2o
	05qjHzPLao24TfwblLz8vG+ljJmjxV1WAYmu53/mYMEqRSZcxM2GWDmYQ0DnzwOzA9BAC7Lwylic7
	Juea/9MhrBeosF6WEKaRE1j7ptoKIRXiAEqVSnWGffwT6iBFL+cLDiEz3P7EkCYLV/ZWITLoSl8M4
	GzFgmzRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMS8q-0000000DzNu-0azz;
	Mon, 11 May 2026 15:01:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMS8i-0000000DzBa-0sH9
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 15:01:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 558F742A54;
	Mon, 11 May 2026 15:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052AEC2BCB0;
	Mon, 11 May 2026 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511706;
	bh=WTOZtf+TSkG7jTuwgr4Xv/jydgZpyrVWr07agLcMSSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bj6oZWNgwkfGQ3WZ4ZYFSp1IOYmY17je3ZOiSlovT/lnEu83qkJ0nCthY1kbcU7Ix
	 Ad0xQVtMslhZ/Q5LTeLOssrnO12rM9/s1QZ00Q6ggr76GIc63PKHYCloY11IYTRo3H
	 UPzKnIPC6DsAJW2/qoFyXFyhSAnxRY4VGZ3h6sv+/jlyXhlfknsUovmbWBgk+dke3O
	 dLLl3hKlKsXx4AjNm8yZPM5QeNGIU1RevltiPuiJ89bq9XG44erasxcw3XN6MceUoV
	 NJR+HqeGIZBY1uhcJ9u6ZTY0ECJq05BfQsSqMo/Erfj0xXq7iMucVqN1VMUgNmJ1B1
	 Zt/5mFpCR+xpg==
Date: Mon, 11 May 2026 09:01:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: AlanCui4080 <me@alancui.cc>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for
 144d:a808"
Message-ID: <agHvWH9n9xNDOLfa@kbusch-mbp>
References: <EgTEZ7GYRxSc3ZRAxjIuBQ@alancui.cc>
 <af2YtHjq3mhWiyJA@kbusch-mbp>
 <eYKCZ9GBQrCNXs6p0IUx7w@alancui.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eYKCZ9GBQrCNXs6p0IUx7w@alancui.cc>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_080148_363177_7AD68589 
X-CRM114-Status: UNSURE (   6.18  )
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

On Fri, May 08, 2026 at 05:59:12PM +0800, AlanCui4080 wrote:
> This reverts commit 7f991e3f9b8f044640bcb5fa8570350a68932843 ("nvme: add quirk
> NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808")

Applied to nvme-7.1, thanks.

