Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513A5CCFA1A
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Nov 2025 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZuM9/lVYSErfL/ws8FIC2iRtqVZqZc7sKgCamFMxYmo=; b=ZWOszaVMTlzm4b1BmuBkEv+mDO
	hCtLk9YXJ9MpwIwTE9UImk91gB9uDC9uRsOerJd4gWS0XWHFjPQolS26ZhAIxmvmKPF9rKSwpzF8f
	k9/rnclNLwvLVrwhUE+iZaoLMAz+IwF0CdnCf87nTlv27SFzZAF7LvO7rlA04aTnCb8rL3zqiDSyx
	5a32rl9dmWunpSMIeMgVOxQymhgmc5MpK83BCPF/DEJIOZDRN6unLkwHtxh9ntIV4xjMQxpdMy3TG
	/69fNqCnQkX6p4NG2NBbYe0/bxZj0xYidxfkOCp+BXuHUcBdX4cQc1aZtlb5Z5//Qr0K1SM7KZkVl
	ByhKYv/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vINFh-00000004z96-3kmc;
	Mon, 10 Nov 2025 08:27:53 +0000
Received: from mx0.riseup.net ([198.252.153.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vINFa-00000004z89-3gGa
	for linux-nvme@lists.infradead.org;
	Mon, 10 Nov 2025 08:27:48 +0000
Received: from fews03-sea.riseup.net (fews03-sea-pn.riseup.net [10.0.1.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4d4jTY0M56z9vZc;
	Mon, 10 Nov 2025 08:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1762763265; bh=ZuM9/lVYSErfL/ws8FIC2iRtqVZqZc7sKgCamFMxYmo=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To:From;
	b=hn4BWne8ldR343in1FwIMHVwPZZOQKhljTphne3tLcgZWyHydVYEQwe6Rj+0teXrQ
	 oAP57aVdy9sl4TJADPAzBzV66nUx4DBGI4QkgeIg0yeKqoVmynjUWr9fmrrP1MUqsi
	 aP9Xcd+Ryw2lVCft1cJKnd6ahnyny30yQ29Sja1s=
X-Riseup-User-ID: A8DE5B88FDCE7E6D4B1020FF1AE95E8AA54A292A615C1D1E75D41E35F356E308
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews03-sea.riseup.net (Postfix) with ESMTPSA id 4d4jTW46zCz1yvy;
	Mon, 10 Nov 2025 08:27:43 +0000 (UTC)
Message-ID: <5e8b265d-7a0a-406f-b165-9f03f90c12b4@riseup.net>
Date: Mon, 10 Nov 2025 01:27:41 -0700
MIME-Version: 1.0
To: axboe@kernel.dk
Cc: axboe@fb.com, ematsumiya@suse.de, gwml@vger.gnuweeb.org, hch@lst.de,
 kbusch@kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
Content-Language: en-US
From: Scar <scar@riseup.net>
In-Reply-To: <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_002746_976889_DF0C36CF 
X-CRM114-Status: UNSURE (   4.64  )
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

Done

https://github.com/scarlion1/nvme-led-daemon


