Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C7DD59D7F
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 23:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gYn7SNmvOgRtVyBpUwpt9+SLl1/GKJuJp2r+ZPcDOn8=; b=LN28RZQHT1pT1Z0WeNA+gZKO09
	4sIY+ObKH7SqmvYVenpbxA2ysCv2zyo6LAxZB5OJ0b16F+uz9V0FilqRJ0DFDFKlcSQHPPJ4P2n+G
	7Sc6VV+I6tifHfNVDBomFhWkXUVF1V6bAtq9v3IfXC0akZtIltt0G9fc04jfPkYora9K0QoJnfepz
	fHgfnfGecy29YFVbEA13xbLvrKbCVWWnxmcy2TYTQ5xceGrAvWFo5aoCE+T00jOe6vZwVCuoVrYzV
	EBpgZlmsU3CwlC8vVcY66PwZRDcp8de5Ccquao64Cm0rHm4HRWYz/0wISnyNuQquUOb0ke7eu/BNS
	gHpgsq3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFiP6-00000009HLQ-2t6E;
	Mon, 25 Nov 2024 23:22:04 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFiP3-00000009HKo-3AcE
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 23:22:03 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Xy1tx0rF8zlgVnN;
	Mon, 25 Nov 2024 23:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732576915; x=1735168916; bh=gYn7SNmvOgRtVyBpUwpt9+SL
	l1/GKJuJp2r+ZPcDOn8=; b=hcZeOtsJw9MqKA073h8LluDpnwkJA8502Ny5K5xF
	5PfmkXqYsr98J6k8bsoVBWRhGvfkc8AmRW/jDo1Bkx23NRvqBjqvo1+x3qCSF9KX
	V1DsxVXZzyBgwsnE+LebnaFkNCluTDTt33itJcqDiVtQT5W4WCVezcse/lbJ2kpF
	hueFUBl0hPqsa7JlnOJ/4Q/EFdNKAUAfnWBGZYntZngXkgtqKzBBT/NdITW9LzNx
	5XMbsPPGsxYddl6z0XmbqEqeeMIRjdtL6M8cQM6IAJBqmeaA60Ja7AsV9Xz0wwIk
	WNeXb7FqSUA7IOjgr6amIp0EtKAqVWbwD0H7uIS2/5AmMw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7mH7bJMGB4rO; Mon, 25 Nov 2024 23:21:55 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Xy1tk4CG6zlgVXv;
	Mon, 25 Nov 2024 23:21:50 +0000 (UTC)
Message-ID: <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
Date: Mon, 25 Nov 2024 15:21:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Cc: Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp>
 <20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp>
 <CGME20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a@eucas1p1.samsung.com>
 <Zy5CSgNJtgUgBH3H@casper.infradead.org>
 <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
 <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
 <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local>
 <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
 <20241112135233.2iwgwe443rnuivyb@ubuntu>
 <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_152201_811608_160930BB 
X-CRM114-Status: GOOD (  16.49  )
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


On 11/18/24 6:03 PM, Martin K. Petersen wrote:
> In my experience the payload-based approach was what made things work. I
> tried many things before settling on that. Also note that to support
> token-based SCSI devices, you inevitably need to separate the
> read/copy_in operation from the write/copy_out ditto and carry the token
> in the payload.
> 
> For "single copy command" devices, you can just synthesize the token in
> the driver. Although I don't really know what the point of the token is
> in that case because as far as I'm concerned, the only interesting
> information is that the read/copy_in operation made it down the stack
> without being split.
Hi Martin,

There are some strong arguments in this thread from May 2024 in favor of
representing the entire copy operation as a single REQ_OP_ operation:
https://lore.kernel.org/linux-block/20240520102033.9361-1-nj.shetty@samsung.com/

Token-based copy offloading (called ODX by Microsoft) could be
implemented by maintaining a state machine in the SCSI sd driver and
using a single block layer request to submit the four following SCSI
commands:
* POPULATE TOKEN
* RECEIVE ROD TOKEN INFORMATION
* WRITE USING TOKEN

I'm assuming that the IMMED bit will be set to zero in the WRITE USING
TOKEN command. Otherwise one or more additional RECEIVE ROD TOKEN
INFORMATION commands would be required to poll for the WRITE USING TOKEN
completion status.

I guess that the block layer maintainer wouldn't be happy if all block
drivers would have to deal with three or four phases for copy offloading
just because ODX is this complicated.

Thanks,

Bart.

