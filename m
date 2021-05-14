Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F251C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 21:09:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E7761285
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 21:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E7761285
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GOW278mXwXMv7YYlbsIsXQOIrtmv9T0tLnjmFicdndc=; b=dbrULTAUaZAE5b7J+vAnTQHAC
	ueoszRVcOe130hbDZ2ssF8MMr/xc0SIrF1pkDllx+HfnNgUPUroYHCgyJA8XQUpnuiu/1fo2v7dYS
	3yPcd/RYMnY0loaSsr+C86gTdKIhFuPFGI/wyjzXGjfkjtxvFD3NMToYZdzdx1WjfOxjw0Qz8VM5W
	dimP9Xqby7LDVGm2y/3oGOpA05WHo0Oj0hirlhjkwByz/uAVOBt/VRZmWyeZ4GvqM/uqbq09RQaFQ
	cHDJ4a3bifZngUZea7OtKxR9tnIbvYb2e6XVgEmId01qmHXK5EmSYo/K8BA+OdqYkrrFff3N8cB4b
	vkYWjCbmg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhf31-0090zt-4j; Fri, 14 May 2021 21:08:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhf2w-0090z3-Bd
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 21:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=2gN6DjNUnPqJjQNcCPJl7Zw4fpNjTFuelOSQGFcoyBE=; b=SwT19cc3TyeOxzHGxSCq0EPi9Q
 FjmGg+Yo4Qq22fIi0H/ONAt39HpwWlIEYbI1WWJKg98//D0+86KxkIBErVfvz284Iya6YNCzZhj69
 g7AJM8EcRmND4bSee+9w+n+f9Yz0GOw83xq/E3RnNRUYJKuukkzBB/ABVxjpSlxlKlmLL5yyos4sv
 /6UGxL+cUFkIYv856dqSL1boIRTJv9yHgnWmtNARb7IsgvDHA1og8KfPhnf9mwgXuzup4xLBiRQTR
 EpePSg7ZzJTF21zYnInMvSJoEaKaI9AdKt7k6upoysA/SkXsYWzXu+fd6K1NZiE4pLtp/nntjhcxh
 CT1JJmRg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhf2t-00CGQc-GS
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 21:08:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1621026506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gN6DjNUnPqJjQNcCPJl7Zw4fpNjTFuelOSQGFcoyBE=;
 b=r9s9Yq7J0EH+P9q8CmHwSqX/TiDTDPBesJawBYDzARjcuu5nzj8exI+yL/O9OnXRqhtX7g
 JXUBg/tfG02MKWsFYomWOdOViLB3Fcv46cD6oFimprc/AH0BuqxS4tmJeyANmjHb3nFkLL
 4QnstP75dJ7/1KOzDvRZwtfY7Im7Gg4=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7A5C6AD80;
 Fri, 14 May 2021 21:08:26 +0000 (UTC)
Message-ID: <23286bbda8b62afcb8bc0ce0d4deb655197cf8a7.camel@suse.com>
Subject: Re: [PATCH] nvme-multipath: fix double initialization of ANA state
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <daniel.wagner@suse.com>, 
 kbusch@kernel.org, sagi@grimberg.me
Date: Fri, 14 May 2021 23:08:25 +0200
In-Reply-To: <bc0a9cbf4567ee3ec96615fec56cd4899d5d496e.camel@suse.com>
References: <20210506134823.2566853-1-hch@lst.de>
 <bc0a9cbf4567ee3ec96615fec56cd4899d5d496e.camel@suse.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_140831_866193_EAEF324D 
X-CRM114-Status: GOOD (  15.93  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello Christoph,

On Wed, 2021-05-12 at 16:53 +0200, Martin Wilck wrote:
> On Thu, 2021-05-06 at 15:48 +0200, Christoph Hellwig wrote:
> > nvme_init_identify and thus nvme_mpath_init can be called multiple
> > times and thus must not overwrite potentially initialized or in-use
> > fields.=A0 Split out a helper for the basic initialization when the
> > controller is initialized and make sure the init_identify path does
> > not blindly change in-use data structures.
> > =

> > Fixes: 0d0b660f214d ("nvme: add ANA support")
> > Reported-by: Martin Wilck <mwilck@suse.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> =

> Thank you. I'll prepare another test kernel for our partner.

Our partner reported a crash during NVMe controller initialization with
the kernel I built with this patch applied. I'm still looking at the
dump,=A0and it's not impossible that I made a mistake backporting your
patch. But I thought I should inform you anyway.

[ 1010.869437] nvme-fabrics ctl: Failed to read smart log (error -5)
[ 1010.869444] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping down
[ 1010.879383] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discov=
ery", addr 192.168.1.14:4420
[ 1010.929700] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.d=
iscovery"
[ 1011.041659] BUG: kernel NULL pointer dereference, address: 0000000000000=
010
[ 1011.041665] #PF: supervisor write access in kernel mode
[ 1011.041666] #PF: error_code(0x0002) - not-present page
[ 1011.041668] PGD 0 P4D 0 =

[ 1011.041672] Oops: 0002 [#1] SMP PTI
[ 1011.041675] CPU: 13 PID: 0 Comm: swapper/13 Kdump: loaded Tainted: G    =
           X    5.3.18-6.g7ea043c-default #1 SLE15-SP2 (unreleased)
[ 1011.041678] Hardware name: FUJITSU PRIMERGY RX2530 M2/D3279-B1, BIOS V5.=
0.0.11 R1.20.0 for D3279-B1x                    06/15/2018
[ 1011.041689] RIP: 0010:bio_copy_kern_endio_read+0xc6/0x130
[ 1011.041691] Code: c0 75 87 8b 4e 0c 44 89 df 89 ca 81 e1 ff 0f 00 00 c1 =
ea 0c 29 cf 48 c1 e2 06 89 f9 48 03 16 e9 6f ff ff ff 48 8b 3e 4c 89 c5 <49=
> 89 38 4a 8b 7c 0e f8 4b 89 7c 08 f8 49 8d 78 08 4d 01 c8 48 83
[ 1011.041695] RSP: 0018:ffffab41804c8ee8 EFLAGS: 00010212
[ 1011.041697] RAX: 0000000000000000 RBX: ffff9ff1b73e1500 RCX: 00000000000=
01000
[ 1011.041699] RDX: fffff2b810ce1240 RSI: ffff9ff1b3849000 RDI: 00000000000=
00000
[ 1011.041701] RBP: 0000000000000010 R08: 0000000000000010 R09: 00000000000=
01000
[ 1011.041702] R10: 0000000000000001 R11: 0000000000001000 R12: ffff9ff168a=
ce140
[ 1011.041703] R13: 0000000000004810 R14: 0000000000000000 R15: 00000000000=
00000
[ 1011.041705] FS:  0000000000000000(0000) GS:ffff9ff1ff2c0000(0000) knlGS:=
0000000000000000
[ 1011.041707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1011.041708] CR2: 0000000000000010 CR3: 00000001de60a006 CR4: 00000000003=
606e0
[ 1011.041710] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1011.041711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1011.041713] Call Trace:
[ 1011.041716]  <IRQ>
[ 1011.041722]  blk_update_request+0x8a/0x3a0
[ 1011.041726]  blk_mq_end_request+0x1a/0x130
[ 1011.041729]  blk_done_softirq+0x8f/0xc0
[ 1011.041736]  __do_softirq+0xe3/0x2dc
[ 1011.041744]  irq_exit+0xd5/0xe0
[ 1011.041747]  call_function_single_interrupt+0xf/0x20
[ 1011.041749]  </IRQ>

bio_copy_kern_endio_read() means that this was a command sent via=A0
__nvme_submit_sync_cmd(). I don't know yet which one.

Regards,
Martin





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
