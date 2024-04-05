Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED66C67861
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 20:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pf5hVeBCPXQE5mwDi3AN+qOMNB5RT09FSmucmQChsqU=; b=l8Zia5nMd4Or4AMOTfUvv4aTt1
	XWKF0fQXGtkek6j/i/hMlgD4WwoF4V46PBm3eXxa9JZxm2cN4vDbEGY7fLfLcJTFN8JBR8EOyjsIA
	MTowNHhf+ht+C9VGetoNyGC3t9+IzrmER7XQ9tiUVRtMhBtwLkgS2RKYc+PwQGdKjm/XJXHsPHKmt
	Gwe8Nm+r4MuXdqxjmGWCSQx2VnySAUbtslrsHAsp7xOUIov9nevO3V3AadA3leAEJg0cujMtW5Ogt
	QY6xzvMyuLonwJqj0q4NarmNHHxbge+0qLS2mcIM1Sf4cGsEE4BWvAk6BLEj3+nPCyFo0S24JXdeb
	bZ1t5y5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rspsQ-00000008jZR-397b;
	Fri, 05 Apr 2024 20:09:30 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rspsM-00000008jXI-1SCg
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 20:09:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VB8hZ2fBSzll9bq;
	Fri,  5 Apr 2024 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712347756; x=1714939757; bh=Pf5hVeBCPXQE5mwDi3AN+qOM
	NB5RT09FSmucmQChsqU=; b=fs9T8bPUClU8lCb+CrrnF/Ok1joLoaWk1nmqJX6z
	sIqfJEPaztR5kZwl6wYEgAJX49gMszGr9TQWxxhLqyTUPBrGy7fOnrAebFYy7Vew
	nRDsaMHoqskb+eWk4kAVrusY8Fjl3EDacCBE8atIOrnB5OQkxkX/GIhTekvpL9xe
	+XE8ZxCz/H/fxibb0KJMS1wMPdUOs5UFkD9n7866+eV9vSfUYPvsAA3dHs5+RC6Y
	+//HixGKHeh1eNeRDGQHBF04+VvNifeAn3UaxBKWqcTgTe4m00tirBjISi6Xl6ug
	h0M27jYicC3Ys3emW+fCa1VxKaHEswTSJ3MX7hiJiCKQUA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vQ2p2-5vNCAk; Fri,  5 Apr 2024 20:09:16 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VB8hT0bgZzll9bs;
	Fri,  5 Apr 2024 20:09:12 +0000 (UTC)
Message-ID: <1eb43f25-10ab-4d38-94d5-9557856c2933@acm.org>
Date: Fri, 5 Apr 2024 13:09:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/28] block: Introduce zone write plugging
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
 <20240405044207.1123462-8-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240405044207.1123462-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_130926_440916_A5EC5B22 
X-CRM114-Status: UNSURE (   6.29  )
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

Thanks a lot for having implemented zone write plugging!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

