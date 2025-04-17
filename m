Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DA6C369B2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z0ynRYUIgaJXcQyriomLOXBIpymzdpVMk3ysK0HRsBg=; b=s0kxo9OtxLITO5uCDPXJKhjQD0
	KmtLf/Ek/2oNuPLeQNyCoIdgFCwjHPUtMSwmfnf0Owz8l8EDUttr92+M+KNNFFOghAsz0SB/p6I67
	mzlbxZ2+07KeoI6gltkxKjLK26PqS3YhzJO+F2HVYf9LC7H+aH4kitKPXsi6pnTEdx7r3v6JnfJ0N
	nTqlaATOBrlnPVPAMfDMpupKFsXhsoj5SXpzFuLGgY4BxQ5ACdb4qkmJt94ygLXCKwt8bMODpWj6I
	MyLa4GcnOl0cYf/jl1+9ase1IwQe4dGXkzl9k0V/ZC8VL+Qnq/gqKyyfA+gFVwsvtH8/9YJ4SZYpc
	ZRm7gLxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5QEE-0000000DJW2-0Xlm;
	Thu, 17 Apr 2025 14:28:34 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Ouk-0000000D4n6-14zL
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 13:04:24 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 09d13b07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 15:04:16 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Apr 2025 15:04:14 +0200
Message-Id: <D98XO9X62V98.1OGPR20IUZ9EO@bsdbackstore.eu>
Cc: <hare@kernel.org>, <linux-nvme@lists.infradead.org>,
 <zhang.guanghui@cestc.cn>, <loberman@redhat.com>
Subject: Re: [PATCH V4 1/2] nvme-tcp: Prevent infinite loop if socket closes
 during CONNECTING state
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@meta.com>
X-Mailer: aerc
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
 <c4695327-0a0d-4b8c-a852-ee2ce4beb924@grimberg.me>
 <D966L87J0CQ2.2WV0U5JZEMZ9Q@bsdbackstore.eu>
 <fc197a49-32f9-44ff-be3c-4efa1d42d0b0@grimberg.me>
In-Reply-To: <fc197a49-32f9-44ff-be3c-4efa1d42d0b0@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_060422_632709_170041C7 
X-CRM114-Status: UNSURE (   9.12  )
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

On Mon Apr 14, 2025 at 11:35 PM CEST, Sagi Grimberg wrote:
>
> I see the issue, but we need to make sure that if the connection closes=
=20
> before
> the controller finished establishing, then it cleans up correctly.=20
> Because at some
> point in the past - it wasn't the case. Things have changed in that path=
=20
> so it might
> be ok now... Just need to check. I'd trigger the race while the admin=20
> queue is establishing, as well
> as in the middle of the sequence of IO queues are establishing.

I believe my earlier testing for this patch already covered this scenario,
but I can rerun the tests to confirm and report back.

Either way, any fixes needed should be unrelated to this patch in my opinio=
n,
as this one covers the case where the controller
has already finished establishing the admin and I/O queues.

Maurizio

