Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44FCC3ABDD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9oIwMKcBufveYc9ju8oUFp2RqO/sfgU8Fa2ydk0QLw=; b=yIjplKb1HI06c9PS+se1vzo+xU
	5VYbuyAtoj/hlyK8eEYHO1V1NLUTObwTCQikq6j8jRF5JwzK8tEhE+1G2u66CNOQhXI8WNMFWKBEV
	I8E5Srra2KIQV078j9U+k3WdedI4/k0n7puUnp4QR5N6A3xBEJyJ3vhRz798DofnGsi6Gj1NemX/o
	l1gGLvWJUz/jeIth4bsTA/qkdWUONZ8vP7a1LJB7N0IQi5yv1G8U1vRpVbL/Ia1tIEMSTSdHfKWga
	WFgderU4/QV275kOB1Cbw4G4HneDLVkp49njbRTyNYQkLYMnP+cMjNInCIYwPqnJStjl5q5FE8RvU
	EP2YpIMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFfA2-00000001nQa-134r;
	Thu, 15 May 2025 20:26:34 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFemo-00000001kdu-00CE
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 20:02:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4Zz1Mr2tZQzltNPr;
	Thu, 15 May 2025 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747339350; x=1749931351; bh=B9oIwMKcBufveYc9ju8oUFp2
	RqO/sfgU8Fa2ydk0QLw=; b=aKcj9GWg8ob8btrWjZQvv0QBqnsP73vAIZ5E+ASO
	x9Yhy9gzQ4YxC+0vKPq+lZTOkLuXPlyOib1yd9p9BNBufSC+NYqFKCusKrobTsts
	0mGZgCsq2wTZkID84zE8w9PSUp9W0MtrfFpfL6OL64WfSw0vftSvZIgmzie7ybvw
	yei8qNCjd2enGtQQOSzqtsexcdAXo3TMhA235xtBzKO3ob6dwTv0To2w9faaJ0TS
	MSp+I3RN0t+rPF+a0meReYCv8Vkbc0lGWShCeBQ2yfoRwdvHh7/SgH/P7cvNg1rP
	1qsF95gyonUymwo0yzey+3aSprvUj3hWjjbDD0LsDYWPKg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WeYH8QwpxN3W; Thu, 15 May 2025 20:02:30 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4Zz1Mf6pCZzlvt1v;
	Thu, 15 May 2025 20:02:21 +0000 (UTC)
Message-ID: <69341806-3ffd-41f0-95d6-6c8b750a6b45@acm.org>
Date: Thu, 15 May 2025 13:02:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
 Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250511004110.145171-5-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_130234_144953_EDFB9344 
X-CRM114-Status: UNSURE (   8.50  )
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

On 5/10/25 5:41 PM, Eric Biggers wrote:
> Instead of calling __skb_checksum() with a skb_checksum_ops struct that
> does CRC32C, just call the new function skb_crc32c().  This is faster
> and simpler.
Bernard, since you are the owner and author of the siw driver, please 
help with reviewing this patch.

Eric, do you already have a test case for the siw driver? If not,
multiple tests in the blktests framework use this driver intensively,
including the SRP tests that I wrote myself. See also
https://github.com/osandov/blktests.

Bart.

