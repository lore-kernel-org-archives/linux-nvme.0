Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C1EE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jan 2025 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9xF+PuOEfKZN/GnOx7iiU818IkOMnzXqqXF/E0z4/gA=; b=q4+3tNu4dHPgvS6y80rlL3AD1t
	rcCWwjoz6vpIdxJVwGOGIBCjHyzfYXl4aeSrg94MpBm85rXXq3qqBD8QBS3sdyK7VF2z3m4N4Bhc4
	Ae6/kx4INX0+d6FaieaLy4oD+liAeWxpEWtrmjxeXUvpw7olpvjrutMORC3YtEyL7LvApO4KmtOEA
	9jRAUlTusRsBXSxu2MdhFey717+Pi6ub2+x4wYMIv9cm4Asdoxexm0VL9yLI7Q8l1JsJb1QLsblLv
	3fBLjkxb558HgUIzFfxgFVQ54DSb4lEB6dKhpKK9avIMXcKslhKAhTXk5xWjHtcqWgjTN3QWo56PY
	pJEDV7hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXjzS-0000000941m-3iTv;
	Tue, 14 Jan 2025 16:42:06 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXjy9-000000093ed-0fNG
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jan 2025 16:40:47 +0000
Received: from [192.168.42.116] (pd9e5946e.dip0.t-ipconnect.de [217.229.148.110])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 327BB2FC005D;
	Tue, 14 Jan 2025 17:40:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1736872839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xF+PuOEfKZN/GnOx7iiU818IkOMnzXqqXF/E0z4/gA=;
	b=hZ8Z4SKk+kXQwVmikIdUPTuSwbC1xCNhp4lGE3nUJs+PVUotFeYJdFMyOU76BjAywel1yv
	ehtsP6aexG3D6VHLSIlKAuqNKAt3EM2pWw82Nm5c/fpnsdDZQd1osXpDaTrbfQB3rs9xrH
	rOj8V07ZWhs6vM4Fydj1wMzPLf2hwRg=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <d0cdca4a-583a-4dde-9fbe-3d64fe749ff9@tuxedocomputers.com>
Date: Tue, 14 Jan 2025 17:40:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: ggo@tuxedocomputers.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20241216223145.135942-1-wse@tuxedocomputers.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Add TUXEDO InfinityFlex to Samsung sleep
 quirk
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20241216223145.135942-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_084045_637186_50563D45 
X-CRM114-Status: UNSURE (   5.78  )
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

gentle reminder for these two patches to make sure they weren't forgotten over 
the holidays.

Best regards,

Werner Sembach


