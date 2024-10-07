Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA8BCED245
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ru8asnOYDU3WujVBK1w6S/i9k0wtwOQpI9vGdS19tOs=; b=IzU0rSzKPR7M3av8aVbboW2nJH
	1+DGC9Z/wq1n5mdyk/KyewytfU65d1XBNsnUItdgVws+ULWw9225J6iS0bg7Gc8srJc0f3DBUB4XQ
	IZzzHg6xhI15QuI65BhZsOKKmyQyjiMkzoabNrIefSEphvgJrIR/szoxoegjMI33m9SMa2V2tgcKX
	/sxs5YRHtumqYypN5egLpGquhv8EBq6p01+PDq3iYhv86cBTrC4UySvMy1CHOzua2XjW6Bo6YvBM8
	yXS89jjMz3Ii3NdO14G9E2ccQ0LOmgVwZOE7VjEfkKZpBx/9EtZcAJKcQ43f7msbwMJyjPBFGhLSE
	pAejuEnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxwOO-00000003wEg-1OZk;
	Mon, 07 Oct 2024 22:39:52 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxwOL-00000003wDq-1HFC
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 22:39:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XMvGr1CHqzlgTWP;
	Mon,  7 Oct 2024 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728340786; x=1730932787; bh=Ru8asnOYDU3WujVBK1w6S/i9
	k0wtwOQpI9vGdS19tOs=; b=cndvcR3U7OQrh/du6POpyfABhBgf5xZ7cD0gtMQj
	/BRUfeesRooORFPF37FOeoSpvC9FfLBUXoIZ9JQwNJsPywUD2Zn0rf5EIGq+9b9u
	fBPeuYS8qR1L+T3J2VUgh9kA9zeGz51vx06LSjGnXpPWJmvvwZpKJlmGjn6dXdSG
	SzImQ5blcONVUCdtitEr7KD/vhHKV2MODxD7umzaj7etloE73V30wl1u2fsGVy/N
	zdVEM/q+75qn8eLifFzgZZ4+5NCIHPzz/LSzCRBJAacsROt61RQ7D3d2LURapi7l
	jAutcG5UohwAyIhYxYvbmaX4OrkcgWA3vPwjBF0Wzx7rBQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id k0OZxxM_TW1i; Mon,  7 Oct 2024 22:39:46 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XMvGn0QP5zlgTWM;
	Mon,  7 Oct 2024 22:39:44 +0000 (UTC)
Message-ID: <1e0ad5fd-2d90-4a0a-bb5c-0b270dd8ddd8@acm.org>
Date: Mon, 7 Oct 2024 15:39:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] requests are submitted to hardware in reverse order from
 nvme/virtio-blk queue_rqs()
To: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <ZbD7ups50ryrlJ/G@fedora> <ZbO9T_R4lN_7WkwQ@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZbO9T_R4lN_7WkwQ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_153949_446006_6C1624B4 
X-CRM114-Status: GOOD (  20.56  )
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

On 1/26/24 6:10 AM, Christoph Hellwig wrote:
> On Wed, Jan 24, 2024 at 07:59:54PM +0800, Ming Lei wrote:
>> Hello,
>>
>> Requests are added to plug list in reverse order, and both virtio-blk
>> and nvme retrieves request from plug list in order, so finally requests
>> are submitted to hardware in reverse order via nvme_queue_rqs() or
>> virtio_queue_rqs, see:
> 
>> May this reorder be one problem for virtio-blk and nvme-pci?
> 
> It it isn't really a problem for the drivers, but de-serializing
> I/O patterns tends to be not good.  I know at least a couple cases
> where this would hurt:
> 
>   - SSDs with sequential write detection
>   - zoned SSDs with zoned append, as this now turns a sequential
>     user write pattern into one that is fairly random
>   - HDDs much prefer real sequential I/O, although until nvme HDDs
>     go beyong the prototype stage that's probably not hitting this
>     case yet
> 
> So yes, we should fix this.

(replying to an email from January)

For my patch series that supports pipelining for zoned writes, I need
the submission order to be preserved. Jens mentioned two possible
solutions:
- Either keep the approach that requests on plug->mq_list are in reverse
   order and reverse the request order just before submitting requests.
- Or change plug->mq_list into a doubly linked list.

The second approach seems the most interesting to me. I'm concerned that
with the first approach it will be difficult to preserve the request
order if a subset of the requests on plug->mq_list are submitted, e.g.
because a queue full condition is encountered by 
blk_mq_dispatch_plug_list().

Thanks,

Bart.

