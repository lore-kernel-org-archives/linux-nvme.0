Return-Path: <SRS0=dtL6=PK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E39C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Oct 2021 03:12:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD807613A9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Oct 2021 03:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD807613A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W0LD9iPvxxhEJ3MC2BpmyEY64d7qaINAGgTsXYSy428=; b=e9MBbENtwHUn46aoSi60b2f+ID
	Dr03zVB/qYVZvN/Y9emTiKnwaBrgpeyH146DEbvCLQ5FZNwveKbGarrkUeyic0bk0lOFxDAJd5rIF
	IAvXY5jQJrHPuzcEfNwTw+qj1d9IWkCacPQyXLwhAnNKuyxvTiXDKRynkIyraDr/dAg5ooyf0KyLH
	/PXhBchtzJUiNoY05ygU7bRvilb1mXDu96PLUxVi99wAO6K6NI1sIq8YbbPgpaWeYoTin68bUtgSf
	yJ1VYHPbjUro0APEplZ9kqi78vdaMAiWUp8zJP1+uAqodrCwrk+Pcui8JUUgjUKr0icwsuVcC+Ys1
	CMsr8uPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdkyr-009fCW-5L; Fri, 22 Oct 2021 03:12:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdkyq-009fCH-B5; Fri, 22 Oct 2021 03:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=W0LD9iPvxxhEJ3MC2BpmyEY64d7qaINAGgTsXYSy428=; b=cYDUUwCiDlFw5AzyRMN9tlggeH
 9bieqFxqnVXkwZshKFtrCWiWTRj42Do3v3duec5Oh2NeBr/KtY2JFs19YrFYe0pjKgkjitbcJVU74
 3L08/bDkVn1tUvxtnfojRZTI4YQuqf0qGPiYnvURf63sODp5N4b02/KHuPw9GCLRd3M6EmVk8Ojgu
 oBS83rFU7lxFzpRkPtkVGxQiFpQdqzIyU3p0je/yXb3QsaRNe4eexfYRYdsHlsX8Pbp3yHsoQjWpz
 Wurr52oXnhVFBC7Wm/ZyMZRdkLB1Q5ijXqsDPwyM11+aSkVj9GJTqnh7As2hIZpDy+Zf5omesnM5z
 tH6JZAqw==;
Received: from [2602:306:c5a2:a380:b27b:25ff:fe2c:51a8]
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdkxM-00DffH-LH; Fri, 22 Oct 2021 03:11:19 +0000
Subject: Re: [PATCH 00/13] block: add_disk() error handling stragglers
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, jim@jtan.com, minchan@kernel.org, ngupta@vflare.org,
 senozhatsky@chromium.org, richard@nod.at, miquel.raynal@bootlin.com,
 vigneshr@ti.com, dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <a31970d6-8631-9d9d-a36f-8f4fcebfb1e6@infradead.org>
 <YW2duaTqf3qUbTIm@bombadil.infradead.org>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <24bc86d0-9d8d-8c8a-7f74-a87f9089342b@infradead.org>
Date: Thu, 21 Oct 2021 20:10:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW2duaTqf3qUbTIm@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hi Luis,

On 10/18/21 9:15 AM, Luis Chamberlain wrote:
> On Sun, Oct 17, 2021 at 08:26:33AM -0700, Geoff Levand wrote:
>> Hi Luis,
>>
>> On 10/15/21 4:52 PM, Luis Chamberlain wrote:
>>> This patch set consists of al the straggler drivers for which we have
>>> have no patch reviews done for yet. I'd like to ask for folks to please
>>> consider chiming in, specially if you're the maintainer for the driver.
>>> Additionally if you can specify if you'll take the patch in yourself or
>>> if you want Jens to take it, that'd be great too.
>>
>> Do you have a git repo with the patch set applied that I can use to test with?
> 
> Sure, although the second to last patch is in a state of flux given
> the ataflop driver currently is broken and so we're seeing how to fix
> that first:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20211011-for-axboe-add-disk-error-handling

That branch has so many changes applied on top of the base v5.15-rc4
that the patches I need to apply to test on PS3 with don't apply.

Do you have something closer to say v5.15-rc5?  Preferred would be
just your add_disk() error handling patches plus what they depend
on.

Thanks.

-Geoff

