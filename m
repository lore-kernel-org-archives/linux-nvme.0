Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A70C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLBY8RpzTLxrRJJ5JM1DbeKtBr8GLx78ZiwKUNLFkSY=; b=rQSff0L/OJE3mkDplwO8unqXlz
	4WwGZxUtmuxCOKg+iAZ2Vwuc7toY8A9pN+mMDYDH5pGcXsaKE6+3e5FDzKpZj391cebi6qrMuuxTb
	PGVLXO/JlXhEd6ksomkCpbOjb+W/WccMxifxnt6iz6KBEH7fA5WsTyvKE1WSfuHzSnHDOJVCJ6uRh
	l6PfHrDNbW6LwVp5qci+9WNqZli2v36DFZ+hohkajqZFT61lZRp4vBJ324QYqb11zkLaKlbuZI/r7
	p+EZLGL8zm0yEAKBFCAMPe3ABTx2d147z1ck0ExGsKVqqYo5W6GUVtRyCWmx2plUuPeKNgB3aom8g
	5ZtX+V7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCGh-0000000GdIX-35Pq;
	Wed, 12 Aug 2026 16:57:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCGg-0000000GdID-0qyz
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 16:57:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E955B42DB0;
	Wed, 12 Aug 2026 16:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897CC1F000E9;
	Wed, 12 Aug 2026 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786553848;
	bh=PLBY8RpzTLxrRJJ5JM1DbeKtBr8GLx78ZiwKUNLFkSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iuLrL5msXp92iyGYNuxV2tWoCkwGQMDc0Ccpk6CCEn/MK6si58A7RMtnjHUQGxRrA
	 LnnPztsHGLVmHRlIlXI9Z3eh5VYIgopYj/nusmVENpbrbdbwVatUzz9LuYqO8YVAjz
	 RxuaGaLsydAOAnJewjQfWApQl2lgLPL43Si+9oPRHnvsFV4bYBbbhVyWGJsKl/xeXc
	 YxO7RFf020Z2qtMjTHi4CIR2OKm7PKe9hE50e2zfepOgC/UaVQP0RexjNvIWEcA0l0
	 OEV4Evo6fMkrahqevqJM6ywDGaL2ZH3bIscKV/PTeooWNKfy/MqyP2brfG9irjO3xo
	 PogLRXsuIS3ww==
Date: Wed, 12 Aug 2026 18:57:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: syzbot <syzbot+b01a29c8051dcb87f37d@syzkaller.appspotmail.com>
Cc: hch@lst.de, justin.tee@broadcom.com, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nvme?] KASAN: invalid-free in nvmet_fc_alloc_ls_iodlist
Message-ID: <anyl9DkGMw8YUPs6@ryzen>
References: <6a7919ff.9c11d2ce.289b96.00e0.GAE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7919ff.9c11d2ce.289b96.00e0.GAE@google.com>
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

On Sun, Aug 09, 2026 at 05:23:27PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16b813b9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c05be6c9b0d36cb9
> dashboard link: https://syzkaller.appspot.com/bug?extid=b01a29c8051dcb87f37d
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

#syz dup: WARNING in nvmet_fc_register_targetport

