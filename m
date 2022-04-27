Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B504C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKSkMh1NFlREgpw/Z4lEyjoMiYQ3jsbrHfyfpQllbZo=; b=uW6FpjkIF7VkVvrPhE6UPOunXe
	iC6gyZFkxVMuog/j5sNiJLqQHys29jwpDaBMCqzj7htAtmfHJ3B/AOVpqLTWQp21jPSdsm2YeqSg4
	irMMlhUwH2PYk1YWy88L/EwSWrN0rN8Dcd+66jd3kiz9GF8VtSSJmuE0Sqi8sTk00X/IRGpQZUBs5
	+B7QxGeKMbiPG73TZD2FARXZDxHH3mtvK4IV4y3J/9bs2pKOaiUGb/5VHqO2zmzjZ2wGEWzwy6GS9
	k9a3n5p9tF4LlI42iDsFdll07p6XOioFmE3J0kOKvMk02mMmOaMYwzutMd0jWVUrr6NEuqOLkSZ3p
	h0pGbLiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njqnM-003uzP-BJ; Wed, 27 Apr 2022 23:10:04 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njqnI-003uyF-UD
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 23:10:02 +0000
Date: Thu, 28 Apr 2022 01:09:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
 s=mail; t=1651100999;
 bh=l1niBQB3qU2YOu65kYIb2K4hUjsb9Jp80Zjt1m318kE=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=JjgYzNUod1l0ZWSuCDy25hvqFxBysntZxT7lFqye9RCk23sOTOJyG4Qh3ABquhJ8P
 zUkdy4rnpRIbArXmic+AOn1z11YUH5kJSe9QlKXRtZYD51QyIqv1kKyl+8PsMWZfah
 qKbnZqWvIq9gR6LGESP44xK/uk+ryyvN3xqHIUBA=
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: linux-nvme@lists.infradead.org
Subject: Re: Calculation of Host Memory Buffer sizes
Message-ID: <3612ae14-f9fb-46d1-92b9-662f3b15ff26@t-8ch.de>
References: <f94565db-f217-4a56-83c3-c6429807185c@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f94565db-f217-4a56-83c3-c6429807185c@t-8ch.de>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_161001_162480_BC5CBA54 
X-CRM114-Status: UNSURE (   8.78  )
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

On 2022-04-28 00:40+0200, Thomas Weißschuh wrote:
> I am wondering about the calculation of the NVMe Host Memory Buffer sizes.
> It seems to me that the current algorithm to calculate this size does not lead
> to an optimal result.
> 
> [..]
> 
> It seems that the logic to calculate min_chunk in nvme_alloc_host_mem() starts
> with a too small value.

Of course shortly after sending the original mail I probably found the solution:

 static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 {
-       u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
+       u64 min_chunk = max_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);

This would also much better fit the comment "start big and work our way down".

I'll send a proper patch tomorrow.

Thomas

