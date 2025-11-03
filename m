Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B33CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SW3TIGJMIg2vrHloehmaqeDzoU5scfUDSDR1CcoNKng=; b=cZKqrr+hdextN33hIkvOrH8sJi
	LNSSqawhejGdQN1cqVr8PfKL+rUMgAahcnst/SY+dSS6mLjmy2049MvcERG1E+o2jheoWnZAhKGfT
	jrGp/un2s7G+gVPg2PoB05xiO85jLEKleN8kRMEroRZridymFOKkjKJQTOe5KRWbb8P5hhMEV81Xv
	qS/TARkAMddqDKiXpRzs2aCsXW5F2NojMpxRuIx/Tcde28jXlEnS0RSJZgwboqdEfk0x7j7f98rUJ
	eCIwRspVMd5dFj3tOcI08xYIMWt6MuvlOA7hm4NhO+OMj6NGnGO15xA1KQJg1scZ6EFa4SunRArrG
	6G8ied3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFwaF-0000000AAlz-3ClU;
	Mon, 03 Nov 2025 15:35:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFwaD-0000000AAlO-00IC
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 15:35:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 62114404A1;
	Mon,  3 Nov 2025 15:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CBFC4CEE7;
	Mon,  3 Nov 2025 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184100;
	bh=SW3TIGJMIg2vrHloehmaqeDzoU5scfUDSDR1CcoNKng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1SZWNMIZMQHmORDR1eXot94vuaJyuwhm1tY7qBUKwmiMmsXoOEd/WypbgK4UCjzW
	 0wlg2yxf0diQGD2A4gFPynBnUThe/u0TKyKrN13f5yIyYEC0Yz/GNu5WPwcCItdnJC
	 5eFrA1Gy/88eeKfOeyzswLjxrO4c7nlcExPp24S/VBOwTCu5+EWi5j6j4JCTC2bWOk
	 vvz9OsLfLCFYl5vqIWjtVPqP7jt9KiisuGUAVyl/+3ahFF13udAj2ltVW/8uZKO/cy
	 zfsop7INXlem2UbskYIMasQP+J249Y1fQfNuva/YxYMPF6wiTayv83iFsrlE34wjCS
	 2n/sczJuxZLjQ==
Date: Mon, 3 Nov 2025 08:34:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix typo error in nvme target
Message-ID: <aQjLogHkN2hPwsBs@kbusch-mbp>
References: <20251103024131.1855-1-chuguangqing@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103024131.1855-1-chuguangqing@inspur.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_073501_079362_4F88242E 
X-CRM114-Status: UNSURE (   6.25  )
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

On Mon, Nov 03, 2025 at 10:41:31AM +0800, Chu Guangqing wrote:
> Fix two spelling mistakes.

Thanks, applied to nvme-6.19.

