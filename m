Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3672D374B8
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eOvuzv/ivWqYohoOrZsk5GZxXsPGRis/218uLdUYAGI=; b=RJGjwVo+rovKPsOgZUSSKPAYIb
	a0np0SFBbZuduk+dy6WsqEaMN2vTklCJx/0vSCahXQvF4Rc2X3RsDR1d4Qu3oWFxofTyIl6b96nd6
	83UJX3wiLdbG58ThjkTeWY6hqYNJnw6FUAnZHP0StlqWZACNYyEBziQ+VpV3Cub+mBpo7cKFiMUf9
	eYbEtOGV8J8LpgzCOe9PXGTDZCk/II4PZ7OBAEE4CaUzdtpMacFf/VtugQGkSS9FrsH1DqyfNSPF7
	asL1gk3suIjVJz73ScD16uFCkLGyBs3abitTD2LvVZueK5ohpUPb9iVWm7f3OEWbVhDaFVfzLSuNG
	5u4SA3fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1TAD-0000000FS7o-36h4;
	Thu, 17 Oct 2024 16:15:49 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1TA8-0000000FS6h-1n2x
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 16:15:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XTtH262R8z6ClY9q;
	Thu, 17 Oct 2024 16:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729181730; x=1731773731; bh=eOvuzv/ivWqYohoOrZsk5GZx
	XsPGRis/218uLdUYAGI=; b=Wchb2Z5XYlvD9yLHrkWMJ6WZ18gP6EzjpoiMon7w
	/ioP2BWSDakTfnlY9OKkoEjRyzCE2NOOA18+7w41OSCq0uXcSnxahdlv9J0aiPEW
	QgakT5aZFbr0akzCcs2YLtQ65bxWjFRd42Uw4sow2fAxYDW7xum2vunzfqAbpOdN
	wAvlVAszWgYMPxmJkBivBK0AyykLmVV2k+9Znv/0hwxsQlvsKVePSBGAyJBX01e+
	QZS1/pTpqYT9bJvAKIITbijxh8ut7514vlLSZeturgZkOCEfwQroFlQvQC8d1wSb
	gsv59uKMu29HvZspqvF5XwKGHg8pluu4iD6ys3S5/VrpBA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tuKOjPfACqLi; Thu, 17 Oct 2024 16:15:30 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e14:8:c8b0:b4d2:d689:c93d] (unknown [104.135.204.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XTtGj6bSlz6ClSqH;
	Thu, 17 Oct 2024 16:15:25 +0000 (UTC)
Message-ID: <37af5088-6f09-4e75-b5d0-559e92d625bb@acm.org>
Date: Thu, 17 Oct 2024 09:15:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hare@suse.de,
 sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org,
 dhowells@redhat.com, asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241015055006.GA18759@lst.de>
 <8be869a7-c858-459a-a34b-063bc81ce358@samsung.com>
 <20241017152336.GA25327@lst.de>
 <ZxEw5-l6DtlXCQRO@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZxEw5-l6DtlXCQRO@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_091544_556613_413059A0 
X-CRM114-Status: GOOD (  16.87  )
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

On 10/17/24 8:44 AM, Keith Busch wrote:
> On Thu, Oct 17, 2024 at 05:23:37PM +0200, Christoph Hellwig wrote:
>> If you want to do useful stream separation you need to write data
>> sequentially into the stream.  Now with streams or FDP that does not
>> actually imply sequentially in LBA space, but if you want the file
>> system to not actually deal with fragmentation from hell, and be
>> easily track what is grouped together you really want it sequentially
>> in the LBA space as well.  In other words, any kind of write placement
>> needs to be intimately tied to the file system block allocator.
> 
> I'm replying just to make sure I understand what you're saying:
> 
> If we send per IO hints on a file, we could have interleaved hot and
> cold pages at various offsets of that file, so the filesystem needs an
> efficient way to allocate extents and track these so that it doesn't
> interleave these in LBA space. I think that makes sense.
> 
> We can add a fop_flags and block/fops.c can be the first one to turn it
> on since that LBA access is entirely user driven.

Does anyone care about buffered I/O to block devices? When using
buffered I/O, the write_hint information from the inode is used and the 
per I/O write_hint information is ignored.

Thanks,

Bart.

