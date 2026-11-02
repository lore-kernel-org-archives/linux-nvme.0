Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDF606A326
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lzZLiTKc;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4pVkKWB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8kqF3ntzYW3hP6K+8Zi1mBskB8D2QgCHbNZ8Jdf9/+4=; b=lzZLiTKc6NioE4
	oXxaqbLz+RA7Iplzs53JvwCUE45Du1OM0JHtMHKRYMEwnPMSFFb3qwg87HpOO6MXm3CtGbtbGMY9a
	2r/s6t/tbKgtmg6eQc+ANp0565lbS7CloQRBOLw8zqd//A94TbBURLQx9rh4FFU4UZ5JMQGvvysWq
	IGFAZGSRn6dR8gSrEiOtQt3ALUdtYYP9ieD9FQgaidKmcUNOw3IVaDKvN2+zznhuTpUuCGFhU04zL
	e6aK2RlRf0/j1WRPQi493/DpN7QLgfw3kQYs7SAMJv7dZY0hyeItJfqlco56lb/oWqYv5O4FDPwyn
	jusuue2MCchBP6EuC9EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmyJ-0000000Fody-2IeO;
	Mon, 02 Nov 2026 08:00:51 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmyG-0000000Fodd-3eax
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 08:00:49 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3902595eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 00:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793606448; x=1794211248; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kqF3ntzYW3hP6K+8Zi1mBskB8D2QgCHbNZ8Jdf9/+4=;
        b=x4pVkKWB0WqmSPRM5fAzkUmSDpov3bHW7lC2PRVp7kClXPShaW1EJlMgXC0NPfvP6i
         ZVufGOtwCtJUYwv22fQpG+FUxde+HD5wOMoccihX8OgwUeTG47fY/U8uIKC7JauwDrAN
         Pa9+MKZSmysJXo6tbk3+3v8MPx6SFfcJF9NdBBYHDoqW3APQhZe8bKjjH5n5rJcgAWPZ
         u6syqJ64MBvZwFVdomIBkdQzpCJV/PNQk5xLue9cl9q1GOq+wXPZBWOYw8kUJ1QBuAmA
         yZtExzgBKNtaUU47Z7z3pPeig/S8C72aNK+pIw8GjYo6rrAMtnsAP8EjuYZA4T/axr2W
         JCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606448; x=1794211248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kqF3ntzYW3hP6K+8Zi1mBskB8D2QgCHbNZ8Jdf9/+4=;
        b=u3FmWNfgrYicZqZ1D+P1OGzODZljiNqV/DdKfjIXfOytbDYUVxSXXgMgdBz1UhcZBX
         HKopjd5ArHuBHOEaCtf28sacOKJTSjSBD+HwT699JW0TKH7vOiNgULKInpUxSmVASEQW
         KK/z7pepgxNF7NXAH1vyRbn2I/DW+tb8ZpBVoClcxZFKeQvCmlFZAagTK90R1CYG2WvE
         OLZLVMhalWwIEFu7NCXITs/F26y9yo5MNSQKXGr6dxjzOjOd/8aghgP/4XnjFO/Xh4VL
         Rpw/4PzzXrie++7XuynTbeKkGLKlvz3bakTAdLfnhMiySIrL9EMJceC4dYULv8rwsW+M
         Ey/w==
X-Forwarded-Encrypted: i=1; AKwUvBxU+Jg3cNtMXMVhT7Eud0R/Q8gORD6x5Yv/PXI4j0U08Y0TlBt4GMrhEUx9rZA5N98uOXnWFDsh3RIb@lists.infradead.org
X-Gm-Message-State: APuU4Z8AI7yOyYi0H4L1IAWx//zjWsZR4jJRTZ2YMdxhANoaf9wNFsfQ
	RBJOE8ZWmTe+q1g0cBGrg+NiqjVECCpfDKtmE8hhJFLKWmRgRF9Z+0DA
X-Gm-Gg: AYBFou2/yt61zwWafrZwAGgirZuKsHb7wDXqc4fyAz10pINUy1rNziubZIRlWY4RdZi
	tCMlOx6u/GZy6eKenxYrv1Hz2yxLOhwQbrD6UpRh5ybEOGx3+vE2UMQIbl02dtisJBsXu9M2i2q
	dJjLWBemPOcpv7WxKVlwcGCvTmFfq85waMu9/LVxXqUi7iknpSyG0sgQ/KIq1LYF+VrHdcVnv3E
	sb/lM228Vk2PpZbFVqCRy3k9MzmzsHb3sV8OOkCk43TB3uXc9sWR2t/wUdc2b8N69NM1ero7iQg
	MvEY8Bz8P2zAIq2p7NXJCTI87cbw5zeTTrI/D7/v0VsOiIoOY778Cd0iSBFGgIz88bnxGBaTMKF
	f299578vp03Uu2L2V5y2bojdU+Bn5OKnyoKa32c5nTwO5pKtlGv12yXbL0RZvDMv4SrqIKL0gQw
	Cv/B6wbDQhGw3nR4B2eymzH96b7U3oXFS6j6HRJuJyipmauw1Qf1z78u5UmTZNY/UjpmIQdSxqV
	5aYQIZ1aWf8IBHcKhN4bI//XrYd9AbTI4+VTqGAAFvOyAbMlOrikyeEvNV84lhwuaFId9MgsrOX
	nYapK1ZOigip7ipzkdrP
X-Received: by 2002:a05:693c:4152:20b0:36a:1807:75a4 with SMTP id 5a478bee46e88-36a423cacb4mr16532556eec.20.1793606447377;
        Mon, 02 Nov 2026 00:00:47 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428aed76sm36371585eec.9.2026.11.02.00.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:00:46 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH 1/2] nvme: remove namespaces in parallel
Date: Mon,  2 Nov 2026 03:00:41 -0500
Message-ID: <20261102080041.1269654-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6e9e6f78-4bd7-46f0-bf57-5c227a65a69e@suse.de>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com> <20261102-bug-nvme-remove-ns-async-v1-1-61780fee111c@gmail.com> <6e9e6f78-4bd7-46f0-bf57-5c227a65a69e@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_000048_911128_362176C9 
X-CRM114-Status: GOOD (  12.50  )
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 08:26:57 +0100, Hannes Reinecke wrote:
> On 11/2/26 7:14 AM, Qiliang Yuan wrote:
>> nvme_remove_namespaces() removes the namespaces of a controller one
>> after another. Each removal waits for RCU grace periods in
>> del_gendisk() for the namespace and for its multipath head, about
>> 20 ms in all.
>>
> But that isn't changed by calling async_schedule_domain, isn't it?

Right, each removal still waits about 20 ms. What changes is that the
waits overlap. A grace period is system-wide, so removals that wait at
the same time are released by the same grace periods instead of each
needing its own. Disconnect time over tcp, from the table in the
patch:

  namespaces  before              after
           8   170 /  171 ms       85 /  91 ms
          32   628 /  628 ms      294 / 293 ms
          64  1201 / 1308 ms      533 / 550 ms

> Other than that it looks fine.

Thanks for the review.

Qiliang

