Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91356F9D0FB
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 23:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:From:
	To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f8ysig4HrR6q3pf1wGXHMfZICW3zKYZ2jcIAnSG39Uc=; b=K+EPneVRhsin6w2hjAaqd7LiP6
	KB4ZONNEt75i2LKFYCmg+lGA0TBsEPyK6W4WUE0Q6mfZCznR1TqvUXqxg6n0bn5mtMgSh2NERAx+u
	3lIuAcTWptyUVGpDp+GU7vi8WGpzqzDk+eliFzD51XXZWh264+o7DMdLuYWI6DslBTIDpJL8IFHUK
	dKvJ3pxPbJkB6DJZU93j9trItDJ/K6ew5+tV/qfclIS/BpJx0EELIx/CQmyf3OyWURFrCXv0Cd1/S
	/tlf/FPEuetzHdgo0cx/xrQESvsfYgI0oAjTz2MAnFnLg14qXZb6kIHuv2f0IUiMvlSplNwiCmAxt
	Pseu5uIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCnGE-00000000KsX-2QVo;
	Tue, 14 Apr 2026 23:33:38 +0000
Received: from mail-4323.protonmail.ch ([185.70.43.23])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCnGB-00000000Ks9-1i1T
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 23:33:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1776209611; x=1776468811;
	bh=f8ysig4HrR6q3pf1wGXHMfZICW3zKYZ2jcIAnSG39Uc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BCLB93Yw2DmRNQGnT4ppfVLVsd5woKzTrwQJUuXFM+wU0FTWyywFR0evXcoSnvkku
	 wLvJxntiv1nSqkN8Aw5FlxIstXjkLtH2hlYQzbFGSH4KXD4xWWJeVVe7+xW94Ll4gK
	 d5lOiXiis/16psjz+D1z6c9nyowI7vOOKQzDiOn61akyAiwJfn8HVrUASYlw5sNJnc
	 Bxeng9hfmNgB5raF4K45s9dHajrUoU11OAc1AzGljbpz7iVed0OnTItHzw/By1ET77
	 7yqW6FEl/KD3zOFjUgRaGFIQx39yI2JwJobyU4r3bNbPi0VQ/kjBhKb9oxp5G6mfIV
	 UJC3XnnYXajnA==
Date: Tue, 14 Apr 2026 23:33:26 +0000
To: Olga Kornievskaia <okorniev@redhat.com>
From: Paul Moses <p@1g4.org>
Cc: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme: fix handling of tls alerts
Message-ID: <FkWRHE0LXb6mMM4_IGAHzlpaFbKBmo32surD_p8nsLEQqTLpKyyV-5j-_AaObld0oWubIQPJetPy-d3-unkgn7ieV5X3xHDeJQOZ7oxFeJw=@1g4.org>
In-Reply-To: <CACSpFtD5K8K8x4aqtBxCWUmwygCHcO=YkzUBJb=rgoqEStPGGA@mail.gmail.com>
References: <Ozwl9wDbyugg3Ytnr80omDUS6JPqCHgq_k8gkqtMIP2KbHBMt6CYRRMk6LKGOTNPwtj_wNimbH0mZiAe8-9zcRmS_UgArtcI6poZ1PZjMoU=@1g4.org> <2026041239-engross-edition-66eb@gregkh> <N8h5xrK8_cznpQNTzRIDl6Ofz_nN1Hvl1DVSXnL9rSR6zHyQGIPDKEDURE7uf2PgGOCe2jTRcEiamFmAzw-xhQPCBdbPoUu_BelZ8Mrzmg0=@1g4.org> <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com> <207e1c3e-2a99-4085-81c0-7853f3d09f78@suse.de> <CACSpFtD5K8K8x4aqtBxCWUmwygCHcO=YkzUBJb=rgoqEStPGGA@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: ece7702332c7cbae186d4ef40017673a8e3a756f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_163336_119635_8222AE82 
X-CRM114-Status: GOOD (  11.06  )
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

> I guess I'm not surprised it was never merged. To answer another
> question: Was it ever reproduced? The answer is: I did not because I
> lacked NvME expertise to create such an enviroment that would trigger
> it. In NFS it was easily reproduced by modifying openssl to perform
> extra steps when establishing an NFS over TLS connection. Perhaps
> openssl could have been modified to do what's needed when NvME over
> TLS starts, but as I said I dont have the expertise. But the iter
> problem is the same for NFS as well as NvME so the problem is real.

On the nvme side, it used unmodified openssl 3.0 branch at commit=20
068f2ff. It used the nvme command capsule to structure the data,
normal close_notify is used as payload to ensure the crash occurs=20
100% of the time.

> I'm not attached to my patch and I would be happy for the issue to be
> resolved in whatever way is best suited.

How should I attribute your work? "Co-developed-by:"

Thanks,
Paul

