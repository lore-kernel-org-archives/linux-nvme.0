Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469DDC27C40
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DH+2hxPtncvNxefGoVKSbMNn+tUkPE31WVZ7cQnz3uM=; b=myWsNjsL+avjifE5tIa5lMUlIN
	2c1jmi794EK4KV0ozoZNXIYltgkhAunuZQ+cHcFB1o+BXz71x9Dtb0SJi/XkL6vpZXGUNNCVkQJz5
	ei/7Wfonb7yhQPkTfbVKKYuEB9wGDY97/xm4Bb4FBi7WiUfXYqI+Uti4QTEaUoLjz5CTrxXwMRYC9
	ZyJMwNDrUPzNCnnYb8qKNbHsjey8Ax/WjvVRvAt7Ts4+7CuZjg1HTCalbvXXkv6ii6xJ8qkhdI3MV
	4exO1xXvBeBv3pN4o8tU3ditk0Zs84EJ5ZuOFEuTCvWyNI3f8yTG0MYolOLEM3cbgb8M3mUjtgw6H
	Z2XVFDyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZ6x2-002jGX-17;
	Thu, 24 Aug 2023 09:48:28 +0000
Received: from s1.sapience.com ([72.84.236.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZ6x0-002jEx-0N
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 09:48:27 +0000
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 33C18480AD7;
	Thu, 24 Aug 2023 05:48:21 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692870501;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=DH+2hxPtncvNxefGoVKSbMNn+tUkPE31WVZ7cQnz3uM=;
 b=elXfSiHKv+C9D0FuyBc7c4iEIMwFkXo5xHhmFfPuhFwOb+uJKDR2+LYosPnHKYZgQ08Fb
 ddnxTr+J+0GX03RAQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692870501;
	cv=none; b=SZpail3ei3u0Nj3lfSfttHYH8ahVk1ZJuHQP0Q//kOz/lT3FwWGGdFrQ30+CB78sjy72dk4BhkjyYPpa+xLfFyYi9cr1KOJIOtBylnYtjU8DwujzhXHf8sfeQaoD0hvVvbguf2aBh4hjgX1ivYXH4XhqRGlvLso7looigZQcafGXtVitDe7cZdEvT2AfTIxWJ9juYXxjESw6ZQw67eL/YkjaZwIPpV3k7Agrfupw8K5nk7M7TZ5dkvVfYIySiY1d3eaWOuz2i1mGzcjAF1jShaBzlmd00hCVcYa3amDXfZMWFObDK3aUbGloELQaFnreNg7JbY8lV2cumxLHPGu7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1692870501; c=relaxed/simple;
	bh=Zaj1r2D/y9d6w3HtH46woGegOcwHSMooJRyRFEO2cBU=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=agmVIBlWB1zpRPX/6cz/KUX6gq8IDc21uNFGLwaxv6VwZKpLNJXEFjpAGj98l1B02YqNY6bmwK7BnVExTedVZSVX0EyAqdG5++C7Sg75TN1XrB2AUdalm5r5Eon+rZOI7L7uHoRgCt6WNDeYyVoghAkKa7IzK9iXCLfi+oRkSkjkXbijBDrZgGqSBHqzMBRbufse1dTvhH9UeAuLiD+s0dCvHfrwr3S4vRGfAly44c9UUj4pZNCBNsNiWOzoK8RJQzxx1og6LRdYsEFRqLHVNugio2FArRP+aQgWzfwuy04w4+bWBf/MHi+mX5ObqDdlHiCxSdvSZJzLSgJKShBfKQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692870501;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=DH+2hxPtncvNxefGoVKSbMNn+tUkPE31WVZ7cQnz3uM=;
 b=P3HtSFYvDtEkexs5noFljLJ/gp2UQS3pOnCATCOJsAdlk12H3Vydh4CWQCZITbe6yLN0q
 Hr6/1/o+h+OxVHFFKIJ/paNUgyEhPZ/YMyLPomY+wuw0kU4af9Z03xt+UJ07OI+VwRhnbou
 TSG3UrmAp6UyZBooCd+QmhszKng994MAqVenHwL9Os9CSPn8boPOlj3MgKTFidwDSlpT/Jz
 UiaURf/N+Ra6ujozpUq0SpXgqKy42r5GMSjuFwA3fFf44oK6lR4CiOg9zZ8d2zFkSV6U7L/
 s7K0BekI23PORNUyLJjRCODEW94WiK60aisPGuxUGNUIdgIcdE5LtkqMH0qg==
Message-ID: <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
Date: Thu, 24 Aug 2023 05:48:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
To: Ricky WU <ricky_wu@realtek.com>, Keith Busch <kbusch@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
 <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
 <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
From: Genes Lists <lists@sapience.com>
In-Reply-To: <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_024826_225358_B2F04F09 
X-CRM114-Status: GOOD (  14.07  )
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

On 8/23/23 22:44, Ricky WU wrote:
> Hi Gene,
> 
> I can't reproduce this issue on my side...
> 
> So if you only revert this patch (69304c8d285b77c9a56d68f5ddb2558f27abf406) can work fine?
> This patch only do is pull our clock request to HIGH if HOST need also can pull to LOW, and this only do on our device
> I don’t think this will affect other ports...
> 
> BR,
> Ricky

Thanks Ricky - I will test revering just that commit and report back.  I 
wont be able to get to it till later today (sometime after 2pm EDT) but 
I will do it today.

FYI, i see one mpre report of someone experiencing same problem [1]

gene

  [1] https://bugs.archlinux.org/task/79439



