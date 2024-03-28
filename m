Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75E7CD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 22:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J5EShaWpE9jHmQcfxOwHNuuU+aQl/RglSXF/ix8VP1E=; b=F3TnjvZmtS4MhKbIKO9vIZ+m+q
	90DF/2y9EoXVPXFsf+w+pU3fskauUAGPKNXRMC1rqgN3Er89In1JRx2ywR2DmOxm9AEJG8pHp7rCF
	bXu4Kj4PMEYdz8zX+ZPy15qottbOEZRQBDDWI4ErLL+MuyIUvO25EGBJ9ElhZ3xoX5qYnKV6Q8gLm
	kMu1j3xgspZxopV02cTskl5FhE1GzjrZBwacbfvN6ApNGAxSkKEj9+BZuB5VUpVTyQbCjYh4Ru9+L
	ljIpigbyC6/9jkuqkHwDkU9pBi4qqIgpOCzqIMdRJryzn5BwjIFCcjAJdYGgfAHsS7Wt87l1GL8tw
	zx9wskWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyBb-0000000Fw7G-10z2;
	Thu, 28 Mar 2024 22:25:27 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyBY-0000000Fw6U-2SW9
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 22:25:25 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5J5H5NWpzlgTGW;
	Thu, 28 Mar 2024 22:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711664720; x=1714256721; bh=J5EShaWpE9jHmQcfxOwHNuuU
	+aQl/RglSXF/ix8VP1E=; b=s0vj/K9X9KhI6py6zwGuDXPLxewcaYA9G0fZ2t1E
	ByemSM4p5Vv0pmDOoOsShrkQ2rGaPPx22strVEnSL1X60/fwJIPZRbBrnQyxygol
	leU2is+RlifeFHMb6MuApx7yXo6Vu7zWPt+nj27ESc1c4t3JiBhVAdRihooKfRsu
	cRaOnu4k14iBW280127Cwe0mhu8pdY/5f5uW1dveRr39HLyOJRDLt4uAbJEf2TYo
	jl6DWejvHCBA1uRbVTwK74spYWXaJkjC/bM2gPsEtp4Yg12y8UqRM/F6eoJqhhg9
	CeJGS1mdaeJrlVYPxvb5rj45cB/4MV39m9RschazfPjn/g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2COEEicsZIZx; Thu, 28 Mar 2024 22:25:20 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5J5C3msbzlgTHp;
	Thu, 28 Mar 2024 22:25:19 +0000 (UTC)
Message-ID: <711ee94e-7cf6-4a5d-8979-f20e48b5348a@acm.org>
Date: Thu, 28 Mar 2024 15:25:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-10-dlemoal@kernel.org> <20240328043016.GA13701@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328043016.GA13701@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_152524_675759_D1878669 
X-CRM114-Status: GOOD (  13.85  )
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

On 3/27/24 9:30 PM, Christoph Hellwig wrote:
> Please verify my idea carefully, but I think we can do without the
> RCU grace period and thus the rcu_head in struct blk_zone_wplug:
> 
> When the zwplug is removed from the hash, we set the
> BLK_ZONE_WPLUG_UNHASHED flag under disk->zone_wplugs_lock.  Once
> caller see that flag any lookup that modifies the structure
> will fail/wait.  If we then just clear BLK_ZONE_WPLUG_UNHASHED after
> the final put in disk_put_zone_wplug when we know the bio list is
> empty and no other state is kept (if there might be flags left
> we should clear them before), it is perfectly fine for the
> zwplug to get reused for another zone at this point.

Hi Christoph,

I don't think this is allowed without grace period between kfree()
and reusing a zwplug because another thread might be iterating over
the hlist while only holding an RCU reader lock.

Thanks,

Bart.

