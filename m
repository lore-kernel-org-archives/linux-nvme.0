Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C9AC61CE8
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=thFh6Ia0PsT+Kq2zHBJM813Mt7IhgQv9Q3wFoz6qDrM=; b=RtrNhrsuYOHd/4XN8HvIDHIqPE
	Xt5jbGAg3aRCfJ/x93IkDqLbwRcbBDwBVw2x45EsJUc9SNARP//d6/jMfjooDdFFEd/5nkW0l/Ypl
	3Gn+GjRreuhjBIRYi3zQc4tKv814ZYcqP4oBF4MK08CPVCly7c2Ik8X/pRYlFy8gO09oXjL6Djtfa
	s0CPHn9EpSFH7kjb5KJFAGo2q8iE6sdQjDZAoKvQO21u0CJPnnOc/0L4Uh4lpB5BZ5qzPzvm9yNoq
	LMrZYVqT/Ik/gSqF3rUQyJ5+vUVAR4NLheXc06vT1dYE7Hp9H5x/ZAUG05Xh4SpQdLTaBouS6rZ0S
	go3Wu/1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOg9l-00000004nCe-31Ek;
	Mon, 09 Jun 2025 17:19:33 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOfAb-00000004dRy-3eYU
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 16:16:23 +0000
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-606ddbda275so8321816a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Jun 2025 09:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749485780; x=1750090580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thFh6Ia0PsT+Kq2zHBJM813Mt7IhgQv9Q3wFoz6qDrM=;
        b=mqFzdAHK1QDXhcEn/wPCstpJkynTa9crBOg/TlYy7k8M4Z1D79a2/SGuSHscDFOACx
         5ZZdT8/Zycp61IwXTR+XM5rUOPzAZYTFHMwOY+2na44cZpZ3gGyB1hfNyfEBIpIVPuv2
         1zHvoBe6G+dYc/nUbSdfxuynDCIoanNmS+1M4tYG98kVoTGDXgIP7sfBSlsgVzRB50eN
         jTszWYzEl0wbfurYH6hPEVFFRbRRdveOvfy6izIRljCjzH3FiivyUS9upNPpMr9sc8cB
         /gyaE7eyiNJGm9y49AMcYc8oAOBcU+NBRzpzb0bP6gFEnsxBXt0tkl5qi+xGYvVMn/y4
         rC1w==
X-Forwarded-Encrypted: i=1; AJvYcCVjT4lG2bkgV2Uj1dH+aadqgziSwy9+rZBE/qvPqFeQgUh7XWY8pKy2B2raymYz0JNSjRe4eNjN9h2Q@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8x1p7yOQCTDaL67JqsCOLjbjvsjJCvu6AtBrDOPthWKePQ71P
	P+TYCWmlAFR+v9sgdg/RIjkDQsGqRfjg0AD8gEGhLUb36cu3ACUXZ0G5U0mP6g==
X-Gm-Gg: ASbGncvd6MaDGbPZK2vKN5ySh5m2Q/JuYYn/wcJIYgHZ5SbbOrOPoGayomZGKjaLBbA
	iTCCQuQPDG/93EQxD+sl+CJd8c6dCADbQK3Dm1WvvPKXWVL8cFH96UT5kxnLuenLKl2BGjqNyag
	QDNMNELMfV5g82go0QrmtgW0NigLXydTCcCR88jDEl9QYYGMJf4bWz2URFBL8ZBRoD6OyB+UcyB
	77y9tI+1kCeo7MrIlgiZUv9xeqx7VAG6ErJ6xlZbLE80Vu2KlH/pLz99KVgo92BukaAmuTvcRBQ
	c+/vfNnBJ0fZQEdpEx+JXyAeEvCn8L1L4JvWh2TmHKCThjB0bTfBtw==
X-Google-Smtp-Source: AGHT+IEJrrVL+bvR3Y34262/z3ACr9105EMVi0sh16Wa1iO72vEb3q/YevFzJosrrP4BCJo9/6DIOA==
X-Received: by 2002:a17:906:ef03:b0:ade:3a7a:26cb with SMTP id a640c23a62f3a-ade3a7a539emr998204266b.58.1749485779989;
        Mon, 09 Jun 2025 09:16:19 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade399c1887sm444538466b.93.2025.06.09.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 09:16:19 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:16:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aEcI0ck4tqkHkXkb@gmail.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <28f59f4a-7ac6-4c27-ab68-b6621260c760@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28f59f4a-7ac6-4c27-ab68-b6621260c760@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_091621_909864_845FC232 
X-CRM114-Status: GOOD (  21.28  )
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

Hello Jens,

On Mon, Jun 09, 2025 at 08:22:35AM -0600, Jens Axboe wrote:
> On 6/9/25 3:14 AM, Breno Leitao wrote:
> > On Fri, Jun 06, 2025 at 11:31:06AM +0800, Yi Zhang wrote:
> >> Hello
> >>
> >> The following WARNING was triggered by blktests nvme/fc nvme/012,
> >> please help check and let me know if you need any info/test, thanks.
> >>
> >> commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
> >> 'block-6.16' into for-next
> > 
> > I am seeing a similar issue on Linus' recent tree as e271ed52b344
> > ("Merge tag 'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").
> > CCing Jens.
> > 
> > This is my stack, in case it is useful.
> 
> What does your storage setup look like? Likely not a new issue, only
> change is that we now report/warn if these counters ever hit < 0. Adding
> Yu to the CC as he recently worked in this area, and added the patch
> that triggers the warning now.

Basically a host with a bunch of nvme:

	# lsblk
	NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
	nvme1n1     259:0    0 238.5G  0 disk
	├─nvme1n1p1 259:2    0   243M  0 part /boot/efi
	├─nvme1n1p2 259:3    0   488M  0 part /boot
	├─nvme1n1p3 259:4    0   1.9G  0 part [SWAP]
	└─nvme1n1p4 259:5    0 235.8G  0 part /
	nvme0n1     259:1    0   1.6T  0 disk
	├─nvme0n1p1 259:6    0 838.4G  0 part
	└─nvme0n1p2 259:7    0 838.4G  0 part

	# dmesg | grep nvme
	[  435.301782] nvme nvme0: pci function 0000:b4:00.0
	[  435.412268] nvme nvme1: pci function 0000:64:00.0
	[  435.459601] nvme nvme0: D3 entry latency set to 8 seconds
	[  435.848628] nvme nvme1: 32/0/0 default/read/poll queues
	[  435.944582] nvme nvme0: 52/0/0 default/read/poll queues
	[  436.135123]  nvme1n1: p1 p2 p3 p4
	[  436.316921]  nvme0n1: p1 p2
	[  500.912739] BTRFS: device label / devid 1 transid 2052 /dev/nvme1n1p4 (259:5) scanned by mount (837)
	[  501.583187] BTRFS info (device nvme1n1p4): first mount of filesystem 0568aa14-1bee-4c76-b409-662d748eefad
	[  501.602891] BTRFS info (device nvme1n1p4): using crc32c (crc32c-x86) checksum algorithm
	[  501.618986] BTRFS info (device nvme1n1p4): using free-space-tree
	[  562.737848] systemd[1]: Expecting device dev-nvme0n1p3.device - /dev/nvme0n1p3...
	[  567.865384] BTRFS info (device nvme1n1p4 state M): force zstd compression, level 3
	[  603.745650] EXT4-fs (nvme1n1p2): mounted filesystem 57120c82-6f1a-4e1f-a8c3-6aa17bffb1f2 r/w with ordered data mode. Quota mode: none.
	[  604.103672] FAT-fs (nvme1n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
	[  658.986835]        nvme_alloc_ns+0x204/0x2ee0
	[  658.986842]        nvme_scan_ns+0x53f/0x8b0
	[  660.888749] nvme nvme0: using unchecked data buffer
	[  859.589752] Adding 2000892k swap on /dev/nvme1n1p3.  Priority:5 extents:1 across:2000892k SS
	[ 1698.294280] block nvme1n1: No UUID available providing old NGUID
	[ 1698.356183] block nvme1n1: the capability attribute has been deprecated.
	[ 1807.416851] Adding 2000892k swap on /dev/nvme1n1p3.  Priority:5 extents:1 across:2000892k SS

This was happening while a HTTP server was being executed.

Does it answer your question?

Thanks for the reply,
--breno

