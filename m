Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1A6C6FD1F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 22:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=; b=bDwzTU+MnEE5QUDxq7aH0zb7Uq
	8LxWcWqg+nmVmSWWJTL7ESPiW/eGA/DIQNiLGMOcSfZ3+TVndQYD6iiKipshLpps1bOP+fqA4RIqW
	mqgef95kvBBgpndhik5yvK92VjdOWnfa9760l4D6xtq+vA81s7hLruUwi+AIpGnPylXROsA9HZoxD
	AGiAR2kLM2B9jzI9UFZw46Sxef+4eLqeui7MCXA3d8asY0EiYVGHF0GCgRYDEBfxypJkpBrD/Pt4O
	jPgO3B45DrkPuWZ4/C6r1MyhqBQ5jbCOi1+xQx9l+CbG+787R1hR03nzlQkEO/5CsuC8tQIqWU3OO
	8iOSHNpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqL2P-00000002Ca3-3ow9;
	Fri, 29 Mar 2024 22:49:29 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqJyx-000000025Qf-3cBA
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 21:41:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5v4b23hyzlgVnN;
	Fri, 29 Mar 2024 21:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748509; x=1714340510; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=YlzdRFkBVs8NBMYil6mQ99PIvJbZUhyhHRthugtO
	CVFRi7fsFaydTEAKHOxZjjzLX7dr2clq4LeYKP+506+tO4cuWe1kRMAFCrDrDjvr
	LDRtwiR1dxK1Z3eA+P0HDX19TgcYc+o+R1E8sjptExIO2hdNYRATqvDyUMwtv5Yz
	f/QduFby1blvpQGsaw8hR97WxoZdbp4KE00gcYPryKNlPwTlcBWX/ePahcYgoGlm
	uC0qxAQhZDm8Unau9qM3Xij9vjM/l9O0JrUygQ/CWvoJkHMh7X/4ngKlM1D4koU4
	djoO4rTVE3M40/XDnHkbvW1ehCI33GA8xmVKeJpBEe32ng==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fZm0OVdQGTpd; Fri, 29 Mar 2024 21:41:49 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5v4V2Ks9zlgTGW;
	Fri, 29 Mar 2024 21:41:45 +0000 (UTC)
Message-ID: <27230b62-b02d-4b4b-862c-e2302446b6ee@acm.org>
Date: Fri, 29 Mar 2024 14:41:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/30] block: Simplify blk_revalidate_disk_zones()
 interface
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-23-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-23-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_144151_927236_C27E8158 
X-CRM114-Status: UNSURE (   5.61  )
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

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

