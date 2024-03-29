Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D219FCD1283
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 20:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jMLgFwpxBdFq0TFc0DHNHDX6cPOMxB7QBIM6UOuMfPI=; b=Nzi406PN2y+e1iyhiRm4LkLFI2
	RA5C0gYsYnnWeugcpRiIG3DuwIQLusRt8grozBYnt871YsCppYUOXYcpvGBKvTF66okFMgfVKk852
	V750qXqZ1tZsHsoUk4pK2sIPaOWN5y53EjBu9jNWqadg02J/L55NTIkqv4+0OqyFTn5in3QgzXVm5
	hnMTzyuVE4Qt6t+FNrheUEwkwBH+kIzDSE6l9gx+hSBmvYV5dpsrBHigbpmjEa0Cdih1WC8YxPOqn
	4BYB1uFpONKgueFLaYcSPnBNjyvosysNKWS6qX/dVa/Y0R2MwxYovp521XdMXyGQMAL9BS59TAeJb
	h3VjjZkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqJBg-00000001wzW-2psF;
	Fri, 29 Mar 2024 20:50:56 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqJBd-00000001wyp-14HG
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 20:50:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5sxm5xVhzlgTGW;
	Fri, 29 Mar 2024 20:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711745450; x=1714337451; bh=jMLgFwpxBdFq0TFc0DHNHDX6
	cPOMxB7QBIM6UOuMfPI=; b=UqnpTApglH539cBh1pI5bWpp6+banvNYVn7WUBhK
	rZZTP45cT2KgZSi4cX8iWLD9+nlzvqYgnyaZc9YqdX5sDNUZd7g6t4pclARv+gMw
	P2sv1icCXZUEDbTqkDlZrC9L2EicIb+/zTwLN/g9Mj91O1MaaocEgc6QFXWX4Z6a
	kkKFJb3A5eES5ET6vBQ8x8ASXjhweerDce18kjj8hzaQOaZZNrQheVPUtektnuUk
	+BeM7DPHMCq8UMXzR/t4ib51znpdCFx+EhtwkebI51kSOiDeZ2CoVd1i0/N9OO9m
	7PD2k5dsCpOwWT+A5bH/TugqQoT0x8twaXUeQEj1c7ibyQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eb5u15kDXwiH; Fri, 29 Mar 2024 20:50:50 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5sxg553dzlgTHp;
	Fri, 29 Mar 2024 20:50:47 +0000 (UTC)
Message-ID: <38c6905b-85fe-49b9-b5d4-92ca233c1656@acm.org>
Date: Fri, 29 Mar 2024 13:50:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/30] block: Allow zero value of
 max_zone_append_sectors queue limit
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-12-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_135053_346507_715414D5 
X-CRM114-Status: UNSURE (   9.41  )
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

On 3/27/24 5:43 PM, Damien Le Moal wrote:
> In preparation for adding a generic zone append emulation using zone
> write plugging, allow device drivers supporting zoned block device to
> set a the max_zone_append_sectors queue limit of a device to 0 to
> indicate the lack of native support for zone append operations and that
> the block layer should emulate these operations using regular write
> operations.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>



