Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922B4CCFA03
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4uVN2m2Fn19Sh1MsTnyiUqWKIDdvRLIGGU21jVU8o9o=; b=tX2mP9dVg3TS9J6EOGNcwg40yt
	dPKCiavJoauyLUKEWjdRoHcov0WSt2x/hphZYXGq75siRNZUif4kskopJ0RNyVUzDgibc9v3bByuj
	wNLci3oCCfW9DYMZO2tEYnCjuCVU37oKcHdTHXebpmswEX+b6gJIMy38JfzUcp/v3VESqqyH2soVu
	4oZIc0MF9d811eSmw9kS0jVxdj1SVqBXbburP6j+xfcVN7n2fmUIoSn/MVqm+LCV7qt64oS9FVktA
	WRoGbCa+iMQPcZQg7+9F0IqOEvXvFmLuf4TFcEKbeSAOXm8KyMo8rytKwU3ObvmqhxgM3hbOS5HK/
	VIBJ/T/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5Qt-0000000AsBp-47L8;
	Tue, 04 Nov 2025 01:01:59 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5Qr-0000000AsBS-1aMS
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:01:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d0qsv6HQMzmGHJp;
	Tue,  4 Nov 2025 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762218113; x=1764810114; bh=4uVN2m2Fn19Sh1MsTnyiUqWK
	IDdvRLIGGU21jVU8o9o=; b=HMzBYxa34839lAyty5SHRbqUdyMIghBmpSKVLfM/
	I4wQqOIVRHnpeleTXG1JgkCOxFSIo8nIIZEW0hdEfxSxb+uHvlOOC9XSK7laTfCU
	aJ/nLII/IXn0QTJONfXOSCBMS+LxaW+V3UE4FtvqPuTgYSiMUGLbVTDcAQcrbnIO
	KJa+h1k/6M7lBGlhccXt8+3AAoySkoSzq5mhOFSqTGIv0mpIhA5MvTX5Dqg/ZopS
	Gw5MFLa5QjH1rM31nYz/XbaqaPkem4hCsEF0aD1JIT/XTYf2xTtPVuh/Ju7POLoC
	9BnTbiDle6s878qpxR44hnb6UWHD8QZALmWCNDnrjSdGLA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XBhzvaiVaNxT; Tue,  4 Nov 2025 01:01:53 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d0qsQ17HHzlyNp4;
	Tue,  4 Nov 2025 01:01:26 +0000 (UTC)
Message-ID: <a6d95da9-afdc-4885-bcc7-246d6d133ba7@acm.org>
Date: Mon, 3 Nov 2025 17:01:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Jens Axboe
 <axboe@kernel.dk>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, hch <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
 <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
 <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_170157_519838_25AB6B2F 
X-CRM114-Status: UNSURE (   7.27  )
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

On 11/3/25 4:15 PM, Damien Le Moal wrote:
> The old one is needed to allow getting the precise imp open, exp open, closed
> conditions, if the user cares about these. E.g. Zonefs does because of the
> (optional) explicit zone open done on file open.

How about adding the above information in include/uapi/linux/blkzoned.h?

Thanks,

Bart.

