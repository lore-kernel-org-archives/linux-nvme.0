Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34EDC88E72
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LLVhb726Wd6VctkKYcfyvFb50durPjk31wXuFNm8ji4=; b=4Dv7KUXE8zre3qhhwEsjUyFTLW
	9yuundMVqT2FiOCSw83FLCxmdrC5n+z2OT+5wOV7hl0SDK4VeK9ewR5BC3PMm+pVuZTq82OSpsh85
	7LzhhmJN6NlL14eoVoRnWT4lY+SBc921HTMri+q3zhXJiEZwX8byy4n1MglzYNKtCGnbGpWhHZpUA
	Umt7Wujz8/bial9XQOsORb+UmrDWvHP6cEg/tDPB6hUXBbte89ggVLi7kFm668J1DNhx095MBTNhh
	jynY/PskjqCwQF/BxQhIUs9R1+Eui4kip84QRnal1SdCjGlRM/bJz7GxcR2v2ntidlovFJDXx0LNV
	suByC+sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x68ZG-000000049XJ-2xH2;
	Mon, 14 Sep 2026 15:26:02 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x68ZE-000000049WT-1mdM
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 15:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=LLVhb726Wd6Vct
	kKYcfyvFb50durPjk31wXuFNm8ji4=; h=in-reply-to:references:from:subject:
	cc:to:date; d=arkamax.eu; b=FDLkArDkHUwCtOM/m7r3cFF7UhZKwVUsF4n+bOpX+0
	qG2yMKlc7cID72h3LvC0Mb6EjYfc5uN4kQQfZMVMjdTG1hYLaJjjEoLpZvugyTUGTFMHXz
	Xs51WHTLa3q7mXzy5zrAEFAmKixNPwh/PAKCT6dasn5Sr8sSuv3BuqTGdizgGm0mW9SUWm
	XhcoMGqoGybMtueU63tatps/agcz2ROypwGc+uY8I828LFRohFNABkUBcAiQMtd5cgVujT
	dVEBSQS+6/mljzeXDW4TkVDqQvkKaspj7YcRfitH8sqrr4ThSczXGT0KkrbyVP0FAr6Byb
	LND6dzYTXmjuftVpmTzQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 3fef3a6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Sep 2026 17:25:57 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 17:25:57 +0200
Message-Id: <DLF57C50HQ3U.2IK671IPAW179@arkamax.eu>
To: "Keith Busch" <kbusch@kernel.org>, "Maurizio Lombardi"
 <mlombard@arkamax.eu>
Cc: "syzbot" <syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com>,
 <hch@lst.de>, <kch@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [nvme?] WARNING in nvme_loop_reset_ctrl_work
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.22.0
References: <6a9ed559.6e6c5f9e.240462.0003.GAE@google.com>
 <6aa6c282.4c28b7d0.c1bba.000d.GAE@google.com>
 <DLEXGM8VZOW9.1J9A20FEP43RM@arkamax.eu>
 <DLEYMPA5WF42.2GHC28RDZX90E@arkamax.eu> <aqgQvIG17WgKKoFs@kbusch-mbp>
In-Reply-To: <aqgQvIG17WgKKoFs@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_082600_804914_22074F0D 
X-CRM114-Status: GOOD (  10.93  )
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

On Mon Sep 14, 2026 at 5:20 PM CEST, Keith Busch wrote:
> On Mon, Sep 14, 2026 at 12:16:53PM +0200, Maurizio Lombardi wrote:
>> Maybe moving the controller to CONNECTING state before exposing it to
>> sysfs will prevent the warning:
>
> I think all the transports set CONNECTING after adding the controller,
> so this would have to be duplicated for all of them, right? But why do
> we allow going from NEW to RESETTING? I don't think any of the
> transports do that anymore, so we can remove that transition instead.

Yeah, this is indeed what I was preparing to submit.
The diff I sent earlier today was just a bad idea.

Maurizio

