Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1E9CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KOya9xCztn9m1Qwe21aHdaX4JPjjppokz/WAIXPtlZ4=; b=hvp2u8oPYSOF/v4QrlX29gtWX2
	2i8krFXiH0EiT8KGSJapbefnfBUfjGtiNOBfQ+ys/Hz6TywmfMEE0yTUK9xpjNGKELSOB4FB6Je1+
	gPYHh5gN+Wvg0NQwcKOAB99n6AYcSUQCwRMrjnRI1wNfb79ppo91hk7wjwOGx4yWt//R2zaWzChSX
	7NOfilBFNxqZlDlb+WSug/YAmQCqLqy6JzaHtMZwzq96znzWI/cg+qYTE9dJoUXwjR7bjE6gLGq6a
	0p/TYQf6GV9T3PPmEj7o+ydXWSh7RwcgHi1SlW0Ywr+B7qyEYfdkzUANnN0n+jwkLcAD6SOQcvlu1
	j9G3jDOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLnY-000000086xC-1UCW;
	Wed, 10 Jun 2026 16:29:00 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLnW-000000086wo-19lI
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 16:28:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gbB6x65Gfz1XLyhV;
	Wed, 10 Jun 2026 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781108933; x=1783700934; bh=KOya9xCztn9m1Qwe21aHdaX4
	JPjjppokz/WAIXPtlZ4=; b=LbROMwSVRm/8L8NxmThR8xpKuy47zKuBY7zJJam5
	ecelH8ecxDJgfTIYgDt3/WW7bKIof0ZiJOs6r8BLyqLgV2WvqRxtw4djqcPQBb1q
	SMffOhKxXADO07FvMCkr7wu/TSF0c/vChRzCOoi9WYEk99xM7njqkab2pxGSdZUH
	avSMpnlSaxmGsdii+8Ufx6Gh6h9W9QjdcShzI8f6pgwHJ51JLXik8J+4PthdI/gk
	jjfajJvX7bEJUU9zIxrNLSGnZLkn404J8rp1Nl0WwelVKeyBXzHOActLoBAsd9Ir
	/71ep4x807OLOil3TWF+ATBb/hQxqHbxYwpI/20E0Ek2+Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QgLivcy8P4SC; Wed, 10 Jun 2026 16:28:53 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gbB6q4G4Jz1XLyhT;
	Wed, 10 Jun 2026 16:28:51 +0000 (UTC)
Message-ID: <bd51432e-616a-4a87-b006-3ff7e5aaaa27@acm.org>
Date: Wed, 10 Jun 2026 09:28:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] nvme: add Clang context annotations for
 nvme_subsystem::lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
 elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-8-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260610142743.115898-8-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_092858_350620_616A294E 
X-CRM114-Status: UNSURE (   5.85  )
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

On 6/10/26 7:27 AM, Nilay Shroff wrote:
> +	mutex_lock(&ctrl->subsys->lock);
>   	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
> +	mutex_unlock(&ctrl->subsys->lock);

Has it been considered to use scoped_guard()?

Thanks,

Bart.

