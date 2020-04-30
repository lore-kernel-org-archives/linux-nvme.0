Return-Path: <SRS0=L5xI=6O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA4CC47257
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2020 21:35:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B175F2071C
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2020 21:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AnA6u28A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B175F2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QkXEOJmhyNY50vszb3Yh47p1AhhHmt67An4+c7s1LkU=; b=AnA6u28AxLkZKG
	ff3wlc5BYMV0+N1QgiwdlOIjh5SVrxLEalFpIsyaFGXVbCLtHl3X14tRJDb8K1/ccleHibbRmnDYf
	y7sJgKFX96g+q9SemV59QR8bGNnwmHYkLp2cgJpWpBcy8i+Whb31UXX1VvJUYOFwTub9HOCB6Z+Bo
	rhxrTHExIqn2IQ8wcNYgMV6qf+ewXbsUMaExoh3mnOzVBYk1VvHC6CNAxsWml8lNbS+T5eQbUxxji
	OP86KsjnxKm/KpcQbrYQIiE7zLnrjLfxFSBzEVba7adjcULC7wAUzqmb4SYT1fvFyzpWfX85mEfnx
	FtB29eYGxTi6Nbwj+d8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUGq4-0000Aa-QB; Thu, 30 Apr 2020 21:35:24 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUGo6-0005Np-LT; Thu, 30 Apr 2020 21:33:24 +0000
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MmlCY-1imznH36yU-00jrwf; Thu, 30 Apr 2020 23:31:17 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] gcc-10 warning fixes
Date: Thu, 30 Apr 2020 23:30:42 +0200
Message-Id: <20200430213101.135134-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:d0r1T0atJ0fP6VC0lsoU2Nb50uVHm7+C7HFBKxo5Oh9FT7cjF4F
 56LFacsuF89qNSNIhAKt16YSLWAlWssvN8MtPe8NN45LaPwc/cCelzxDkHr4+0tFL6+Sa9G
 a57V34rwqixwafD6sE/njElSMiK55+3n3WBVw4f5PpMdpEy2CNFI8yBkDaQox92MxOq478P
 ATheht8WQuHpTQRLL5ZEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qtjOffXScL0=:Yde/YTTIyDLV71HcVFV/g8
 5aCgJ4X4xNzxI3sDnVHzb+4x1iuaUyj/FDU6axm1cC5dNjOHg+8xAyvhGoryNPJJFdXCQ9E8u
 /vBjaVgpQi6NvTWJp+z0wFIoWkqjlRGR2wCLBCvG5ImhRZo6H4jl5uiqg/TUea1BRC5KOAUug
 NLH3+1SoQ96QZaVVmYPbql6nsHgFb4uZYdjCp8JTVI2L30Rp4+0Uw3uwnSsZJuLBGqAnsFaeh
 k7gAnZ02jIaJcsH2V+TwomCcLBG4OX9P3yetdeZWPtDSychl7RC+/gMGRpPt2beTcJXb7Sr4/
 wgqf3CYR6/N2vUz2MhXS9Sl+HtdkF3gKvKsNTp2mw9draDW6IVxA+E16ianBs3s2/Jj86Cp4d
 ehuoj5P2KJYrz+9tZ+et7SchBa5i/iGqThgNGHpUmVXaAI8nZHkjO7rEce0Ctm42WVr0HLTd4
 o1jt4fwG8tpZvziYdVKKK9x4WQWsYAq2xx0LoedsVxg8abX+ql1c1UVSezkM6FJvLsBYSOqLC
 Wl2wmpwXK3rQEhxxX4Sh0+p7vR68f1MiX8v4GGJjHzQvAfDgNp//3vXmnFa9OfQMY1+J5Oamt
 RKC21TWUo81CDfLbGJUutjWh36LNJfa+N4p4bSAvqbx+J8urAAoBgP4lL7BwvnjawPWVT3bQ7
 nx782MGIljH805ldEh/1deDsyPsEUVqES3Wx9pJakt2RNm+5lKUyzj8TLjsuKM9bM+MwiaVGP
 y3sVYv2Jji3wkCZuDo3KR4124HQta8GSeSFOnIEeWuWxcaFbOJf9loaB0IyqLaH/bv1s0C1At
 ctEvneGxLk11FkM6cOL//qiBQ4ws+UB1hR0Fmjp4sHdhGtlvK4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200430_143322_992756_330535EA 
X-CRM114-Status: GOOD (  11.37  )
X-Mailman-Approved-At: Thu, 30 Apr 2020 14:35:23 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-wireless@vger.kernel.org, Bob Copeland <me@bobcopeland.com>,
 Alexei Starovoitov <ast@kernel.org>, Amitkumar Karwar <amitkarwar@gmail.com>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, James Smart <james.smart@broadcom.com>,
 ath10k@lists.infradead.org, coreteam@netfilter.org,
 Jakub Kicinski <kuba@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 linux-media@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 Intel Linux Wireless <linuxwifi@intel.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Neil Horman <nhorman@tuxdriver.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Florian Westphal <fw@strlen.de>, linux-karma-devel@lists.sourceforge.net,
 Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
 Jan Kara <jack@suse.com>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Here are a couple of fixes for warnings introduced with gcc-10.
If you wish to reproduce these, you can find the compiler I used
at [1].

If you like the fixes, please apply them directly into maintainer
trees. I expect that we will also need them to be backported
into stable kernels later.

I disabled -Wrestrict on gcc in my local test tree, but with
the patches from this series and the ones I have already sent,
I see no gcc-10 specific warnings in linux-next when doing
many randconfig builds for arm/arm64/x86.

      Arnd

Arnd Bergmann (15):
  crypto - Avoid free() namespace collision
  iwlwifi: mvm: fix gcc-10 zero-length-bounds warning
  mwifiex: avoid -Wstringop-overflow warning
  ath10k: fix gcc-10 zero-length-bounds warnings
  bpf: avoid gcc-10 stringop-overflow warning
  netfilter: conntrack: avoid gcc-10 zero-length-bounds warning
  drop_monitor: work around gcc-10 stringop-overflow warning
  usb: ehci: avoid gcc-10 zero-length-bounds warning
  udf: avoid gcc-10 zero-length-bounds warnings
  hpfs: avoid gcc-10 zero-length-bounds warning
  omfs: avoid gcc-10 stringop-overflow warning
  media: s5k5baf: avoid gcc-10 zero-length-bounds warning
  scsi: sas: avoid gcc-10 zero-length-bounds warning
  isci: avoid gcc-10 zero-length-bounds warning
  nvme: avoid gcc-10 zero-length-bounds warning

 crypto/lrw.c                                  |  6 +--
 crypto/xts.c                                  |  6 +--
 drivers/media/i2c/s5k5baf.c                   |  4 +-
 drivers/net/wireless/ath/ath10k/htt.h         |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 14 +++----
 .../net/wireless/marvell/mwifiex/sta_cmd.c    | 39 ++++++++-----------
 drivers/nvme/host/fc.c                        |  2 +-
 drivers/scsi/aic94xx/aic94xx_tmf.c            |  4 +-
 drivers/scsi/isci/task.h                      |  7 ++--
 drivers/scsi/libsas/sas_task.c                |  3 +-
 fs/hpfs/anode.c                               |  7 +++-
 fs/omfs/file.c                                | 12 +++---
 fs/omfs/omfs_fs.h                             |  2 +-
 fs/udf/ecma_167.h                             |  2 +-
 fs/udf/super.c                                |  2 +-
 include/linux/filter.h                        |  6 +--
 include/linux/usb/ehci_def.h                  | 12 ++++--
 include/net/netfilter/nf_conntrack.h          |  2 +-
 net/core/drop_monitor.c                       | 11 ++++--
 net/netfilter/nf_conntrack_core.c             |  4 +-
 20 files changed, 76 insertions(+), 73 deletions(-)

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/10.0.20200413/

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Bob Copeland <me@bobcopeland.com>
Cc: Jan Kara <jack@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Cc: linux-scsi@vger.kernel.org
Cc: linux-karma-devel@lists.sourceforge.net
Cc: bpf@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org



-- 
2.26.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
