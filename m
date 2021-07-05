Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EB5C07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 13:05:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F59461351
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 13:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F59461351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L+vAwUo5U+ug+WuhnWKoZay5BZZC+D2ZHHMCH7kryIU=; b=qE4Kk7yLOjKpS7
	i/yLl62WIfHxuBun/jNPFTFSWz6ATknYvRIBBTuEYZMJyjHEZqb2kEzBWrMqkbVtFnE2YVtOLcaYx
	Y6MVBrtHiOos85i724cnEQQ7uTjJdVyDZAwB3KSxLpl+lAI3+vufTuyz0sGT2clotrZ/ktB5e6vWy
	uH+6IWjXIZXOCu43Baj24TntXTMWlI+XLWOSnOQ8umqoI1Ta0HY/q5FSLV2U4XD6CkFZKOF/NrjY5
	obGZLhZPke8yBsHG1LR9LZlB7RXKvYlVi+hI2LxU8FqP7KwXwKuhqQHhnNt+JYMQ20wrb/MG56t4L
	J5BxmhLhHEssbTSPnzzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0OHX-008yhH-0s; Mon, 05 Jul 2021 13:05:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0OHT-008yfv-FU
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 13:05:00 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5144761351;
 Mon,  5 Jul 2021 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625490298;
 bh=rhu2C/NJvXmLufyGGG+4o0IrZSoZN3Ig3jMmdCKp5jA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q42OkISM7qr/q4hU1YD3VWodsnnzFtDU4z9IBaNMxDxhi2gssatq4DRiLh3EbhR7f
 I7G73KlI0NysDPfSySe84LItkb7lwE9LwsW6tRiF3oQNP4/zilgAin0CLFJsS1fRf3
 WK0FzcQiA6iE4I5aX9X51vvepkv0IhWG62MP7DeLqnifvToH1lhvkaS26BXElAoVZ8
 3kftJKkJPj4wU4nJJSQa3ONRvjMCQJAInj/44wVOc8Ysa4mg7hV+7Z7KYDj+AU2fSu
 8yqDgexORymmdZVabVUvejAR3PGFpJJ8/rnKOaiEVpG7BQiuaHPqbQNtzr9kldJblP
 kC62oemhgBo4g==
Date: Mon, 5 Jul 2021 06:04:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: Re: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Message-ID: <20210705130456.GA239714@dhcp-10-100-145-180.wdc.com>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
 <20210705101554.GA12803@lst.de>
 <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705104208.GA14891@lst.de>
 <BLAPR08MB690003D5D175FC784DE844F8B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705115349.GA20266@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705115349.GA20266@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_060459_582010_BBCF7EF7 
X-CRM114-Status: GOOD (  15.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 05, 2021 at 01:53:49PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 05, 2021 at 11:15:51AM +0000, Shivamurthy Shastri (sshivamurthy) wrote:
> > For systems with passive electronic components to handle power-loss/battery-removal,
> > CC.SHN=10b will help to achieve safer shutdown with relatively lower power back-up 
> > requirements (at lower cost).
> > 
> > The module parameter gives flexibility to the host to decide shutdown type even during
> > boot failure. 
> 
> If you have a device that always prefers an abrupt please introduce a TP
> in the NVMe technical working group so that the hosts automatically
> do the right thing.  Requiring sysadmin intervention using a global
> kernel parameter is not the way to do this.

Is it the device that wants an abrupt shutdown or the platform? If the
platform's power is running on limited back-up supply, and could inform
the kernel's power management subsystem of this, then a driver could use
that to determine if the quick shutdown is appropriate.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
