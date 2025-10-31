Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27462CCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RXJelptsntvFFlhc8jcKDb1xEUWF4wc2LihHJXooal0=; b=i/QybFLAE93SnbzzjW/40gC/tn
	5bQFCLBa+gz1Q2eVlUMh4WSPDQ5xcSLxnQevFRc92ndvjB2lNsSY+TmSpgVgm8tlnnuReNrUFF1wC
	6EiKsKN2ZGXkN6ftiaermHa9mKdegcexHWZ4S4Y7207SrrHQRJFk+QFdvsCdCXolO75UFTiuI6OWA
	WplGgl2KPsNxYnTM6WNQ2gqvXmXvpPCMSJ3PQg7yduhCRoNY0KzO22cWPEjNviiUh/O4dtEgwcCvK
	s2Ruq5WOFWkl2D7k8WFg6Zcb1h5OVzy+wX8FNs9SJBa5Epbv3uutv5qIIDfnmVvROS7tQodcaj1n3
	8VDwzp7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEw9h-00000006ne7-2GCP;
	Fri, 31 Oct 2025 20:55:29 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEw9f-00000006ndi-2Nch
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 20:55:29 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cytXt5lb3zlvylD;
	Fri, 31 Oct 2025 20:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761944124; x=1764536125; bh=RXJelptsntvFFlhc8jcKDb1x
	EUWF4wc2LihHJXooal0=; b=KjMlI0TV+UmybbZqq0hABBz7D7B+mZtbJsaEP7c6
	+AKYo7kLpb1AWqWaIM9FiTQCar0Re5+4/1yDtUk5/1cv35nSGQndExdDPayKfOha
	LYfkDOdU8FzjQ5VHhyFV1IdzcyT88OZxV23DP8DKkkVeYrnzDjm+Gw1fXrT3+r+q
	u5ouP8wG3EHIOImTndJWsh3jkXrBeYaSn+lSOB/iM7bIX3UQmWL7EeRRMjHvKdc/
	jTVq3BaddT+WuwgKYpXDRSFQbrjiNDul0GezqLwvY4TNc8zNCAxA2RLKQZkQah28
	RP+SkqEUpxbFw818CcmYsRNv14+r62Zv5TeC3XwBpKyd0w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YW4wV6VTFvhK; Fri, 31 Oct 2025 20:55:24 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cytXd6ygFzlrwfr;
	Fri, 31 Oct 2025 20:55:12 +0000 (UTC)
Message-ID: <fe191362-1fa2-44dd-a3a6-bf5a29e50027@acm.org>
Date: Fri, 31 Oct 2025 13:55:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] block: reorganize struct blk_zone_wplug
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-6-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_135527_681483_F881631A 
X-CRM114-Status: UNSURE (   6.91  )
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

On 10/30/25 11:12 PM, Damien Le Moal wrote:
> Reorganize the fields of struct blk_zone_wplug to remove a hole after
> the wp_offset field and avoid having the bio_work structure split
> between 2 cache lines.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

