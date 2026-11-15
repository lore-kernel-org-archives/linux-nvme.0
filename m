Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55334606A32C
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dT4ULF4B;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=MtrtZZDp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=57qg6lfcglp0N4Mj4NgnwPYExZR+gKFM0e2d2Eu9fTw=; b=dT4ULF4BekZFS6
	EgiclG1yBoVUmYMh7GhPX/9IN88gMUubq777IdWvciJU6R5nCD7Y12f7sIhNULV5DRaOmK3954HNw
	giwFlJ7TsIhSTI4hwbC5FZC3dIfZdYRQeobIGEiIexRw6SyZ9UdoVuDrVvbiipG5/mb6aQS9bcaDb
	XpMJ7FKY7mZAfDrqyFUEZ4nKY0DJrQSLtNoxwsqO0L22T2YgyKetRg7gJzPUGM97/m7WLIfpdWlCj
	nx4/xoAA7yIRC8KcZyGhx///QOoNTUBbdYnGH3jwLADSS6Pwksn52M9BwO7A8XqWK48wuwq1I/GN2
	7oLo7k7e3RorNQq7JxOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSh3R-00000000SIC-0XA2;
	Sun, 15 Nov 2026 20:42:25 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSh3O-00000000SHt-1kyr
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 20:42:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jSNGP1ZRhz1XMYJW;
	Sun, 15 Nov 2026 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794775338; x=1797367339; bh=57qg6lfcglp0N4Mj4NgnwPYE
	xZR+gKFM0e2d2Eu9fTw=; b=MtrtZZDp7qD5J70HXAoNolpn2WpTDUFn9OAxViit
	MNMoaLQwo7v93ZvYmGTUTW9Uh5m7jF2b44pKa8Yh6aEkXrqri1jswKQloo9cLMuY
	7vm8JaIcOqIvARuhsXQ3xaDAHkatT9DZb0aCD/hijDM8A424SAguqOLyLWR9dXdF
	Wo0HvXpTB1bi+mRGNAwkAm0lByzqJBA05dmWhWcVXvF+wTXAbd/vUltAJlItI4IG
	ZH7aeDiWYCb3+ccfzyy/QEKtjJnCYgLoKdGU2KW2gt5IN5/i2QiTkS07sz4vcgqj
	z2P2XAQnmxp9SzpfZfibWtcKogMmcey8hgPuwkGDgIwoaA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8BFVPczuCpW4; Sun, 15 Nov 2026 20:42:18 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jSNGL25W2z1XM311;
	Sun, 15 Nov 2026 20:42:18 +0000 (UTC)
Message-ID: <a3a40995-613f-4bbb-8de4-7d087649bad0@acm.org>
Date: Sun, 15 Nov 2026 12:42:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/29] scsi: core: Clear cmd->flags for terminal
 queuing error
To: John Garry <john.garry@linux.dev>, james.bottomley@hansenpartnership.com,
 mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de,
 michael.christie@oracle.com
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-2-john.garry@linux.dev>
 <060d5e0d-764e-40bd-8bb7-ead8d4ada5b0@acm.org>
 <84b50119-cb4a-4bda-9ab8-7b590216858e@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <84b50119-cb4a-4bda-9ab8-7b590216858e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_124222_484617_15DB5F4A 
X-CRM114-Status: UNSURE (   7.12  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/15/26 10:37 AM, John Garry wrote:
> Hi Martin, I would really rather not post yet another version of this 
> series. How about send the extra change which Bart requested separately?
How will this approach affect bisectability of the SCSI core?

Thanks,

Bart.

