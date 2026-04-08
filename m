Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6D210F9958
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33EaTuG0lOnu3JCCqENsBUzQ4rztEmObNIT+Q+NHz4s=; b=euJPSTsTLUWhFIjr0GHaGOM/xv
	Y2x3jXoAX6NvpXYuXQkrAhdmN1whFkWSIOqTVvYTTs3quGzxJV6mSNOpHCLZAM3PRVfqEmcZZw5ko
	sJR6ePVJfJf9zVU0HgvFjfoVOsD1ETHcVdznZiB/mF0+tIst3ShRT7uXwj4KlAfpJ7zxccdgBAJZ1
	yURpJYffCGaqXYM9dS8nOIdvTfS2DvrIb/K8uvfaIijfbzLa9xHfcDKw1XU6XUJ62VhaTw9fNNgh4
	4bYGHmOKyGWshntTQE4Z0nB+XYiAW8PG6lEcLESZkOLA15u687oK+dlxmzDfTeH5n2iLafsZsrXfE
	OA2dgxFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAVeh-000000096mW-1Dlj;
	Wed, 08 Apr 2026 16:21:27 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAVee-000000096lo-2lIl
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 16:21:26 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC364E3A94;
	Wed,  8 Apr 2026 18:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1775665275; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=33EaTuG0lOnu3JCCqENsBUzQ4rztEmObNIT+Q+NHz4s=;
	b=mRzhgaGOBELlN3uEaWZEOMy7gGbMTbHE4QywkpnEQb4kFip1OyuWXbWTTd7y59TAiDVmIb
	gB/qDFi6AlnH2T++YHu7zF1fvs4IIPbfDMBH3/EhHGdDCPLbElGqhFJIpJQI+gsGSrW0R9
	6d36PWPw+ezcBckSMZ9jAUCYeqhuszN8nlVi75eflm+4w1HIDRoyV3W9wbX82zEL9ApFLI
	jM1y4jVYsmOYUOzfGUrNd/DTqIAfqY0ZTbxjfNy+2hpah63tbpZOxXU9ZexvNc+muiqxsT
	FA+Lb+nFydTzaNRnL1x3zu5gnEyNZMpTxB3Qa5IrOkGVkSS7Im+Y2XlFGvip/Q==
Date: Wed, 8 Apr 2026 18:21:07 +0200
From: Daniel Wagner <wagi@monom.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: expose TLS mode
Message-ID: <076475db-0463-40b7-8ee3-5e85c05ae69a@nitrogen.local>
References: <20260408-expose-tls-mode-v2-1-17a25aa414dc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-expose-tls-mode-v2-1-17a25aa414dc@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_092124_974692_36495540 
X-CRM114-Status: UNSURE (   6.98  )
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

On Wed, Apr 08, 2026 at 05:40:36PM +0200, Daniel Wagner wrote:
> As Hannes suggested, tls_mode is only visible when either --concat or --tls is
> used. This avoids the 'none' string. 

I got the visibility condition wrong, this version uses opts->tls_key
which is wrong, it should be opts->tls. v3 fixes this.

