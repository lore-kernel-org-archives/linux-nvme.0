Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15572CD1283
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 18:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5qj+CGEo3kCIwcFnzWLiZGVe4rTmDz0G9iv3+MSmWr4=; b=zdWPu+rZpkJTejdbj00kkWF5KR
	kzF87gmbhCrozotD3gBVz4Yz2MnH5ZmwUc5xG4MOgr6shFgyGvE9GiUd2O1EH+H2KVzUAIL8p+QlD
	geKOYEScoZQVSI4DYm+Ovb1zKhz6iWcviKc6650hoQQ6vzLgLZGHD1sjeG1uHUXP57oCKFOyJTlP7
	pzP+/jgtMraV25PJvLh7jTU1KfdEumRrjyA4GlT+Qzc5396gDCQFjWsID5lJXsmlH0h/pAIYD4GD0
	VjKY02nddhOjv3hjRm5wNm3Onf3NMgOKhs2eLyKoUQm5vyOqgDkJTeP83qgU1m/ITTQhO5I3pWHGd
	5rOY2Jfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqHQr-00000001gWN-1IVY;
	Fri, 29 Mar 2024 18:58:29 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqHQo-00000001gVq-3BCh
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 18:58:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5qS21xVtzlgTGW;
	Fri, 29 Mar 2024 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711738702; x=1714330703; bh=5qj+CGEo3kCIwcFnzWLiZGVe
	4rTmDz0G9iv3+MSmWr4=; b=aZK3ck9k96DkGCo++TkJg93Z9sLPP8i0leIhQMlj
	q4EYZA0FtdpxI+TH505xfcSHMHNoAP6qkZ6nI87CfT15/yEBwWC9q22tBvq+vg9v
	0fZR4Eaj1lIEGMdOD2zPVmWYr7gtA5kABe6laYhUigJltmo/5Efkn+r0J0BMNnge
	3L7KzbTNar4k4a43bcpSBgNmHRwul/6nnfBT/3YBoXy67U8HSmQyydUia9uUIBT8
	yUKyRT+d24yBLXAEST6ya7QBTg8SHEPIiN5fNJsgVPF/tC4dsi6pmUM1KmhBZUQP
	lTJVoF15v4PgmJepBkWgjSDDC1fBaw1Dt7sNJhCPV9lZ9g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XlDOypg29ZJo; Fri, 29 Mar 2024 18:58:22 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5qRw31PXzlgTHp;
	Fri, 29 Mar 2024 18:58:20 +0000 (UTC)
Message-ID: <e02798a5-ce10-4ff1-9fb0-38980b8c5e72@acm.org>
Date: Fri, 29 Mar 2024 11:58:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/30] block: Do not special-case plugging of zone
 write operations
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-31-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-31-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_115826_872970_0B623038 
X-CRM114-Status: UNSURE (   9.74  )
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

On 3/27/24 5:44 PM, Damien Le Moal wrote:
> With the block layer zone write plugging being automatically done for
> any write operation to a zone of a zoned block device, a regular request
> plugging handled through current->plug can only ever see at most a
> single write request per zone. In such case, any potential reordering
> of the plugged requests will be harmless. We can thus remove the special
> casing for write operations to zones and have these requests plugged as
> well. This allows removing the function blk_mq_plug and instead directly
> using current->plug where needed.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


