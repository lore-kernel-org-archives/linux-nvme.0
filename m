Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB6C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 15:36:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99DE260ED4
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 15:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99DE260ED4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=youngman.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QNOndtAPRGpqhXTX2FJjLHZSEuRxoMnhwtpO2+N6L0Q=; b=y1dzMZVkOdG3NYLvL2lVEzWUjC
	ITYFzv0dB0A2rEI/b88m7OuJA5mbHhd5nZ4C9dtuG0CH2WtlFoPir0oVynN5PXQ28fVwPRonEfy7S
	+IOXXoCKMIFsGktDhy1OPoliyFYcx7rwj4Y8sRFD9Hro8ywJrrUSIGUxYgtPMTprz6U+Zp6Bs016D
	zh7ttLoJZ5fyb5/68wc5x6EIoGL4u4PTEetWz99h2Q+KuE9PWV5vb2xlxKRzGmr57TrvIAsNK6c1a
	5Ofd3haJQuUmE/7WcpfNfe32/ltEviXBkr2xMkPP0yyHUvSXigcQq4HzePQ/ebOANmrrN3smOzNSx
	Twiqe9Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb2m1-003hGX-HP; Thu, 14 Oct 2021 15:36:01 +0000
Received: from smtp.hosts.co.uk ([85.233.160.19])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb2lx-003hE5-CT; Thu, 14 Oct 2021 15:35:59 +0000
Received: from host86-155-223-151.range86-155.btcentralplus.com
 ([86.155.223.151] helo=[192.168.1.65])
 by smtp.hosts.co.uk with esmtpa (Exim)
 (envelope-from <antlists@youngman.org.uk>)
 id 1mb2lr-0006Lw-DM; Thu, 14 Oct 2021 16:35:51 +0100
Subject: Re: don't use ->bd_inode to access the block device size
To: Kees Cook <keescook@chromium.org>, Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "jfs-discussion@lists.sourceforge.net"
 <jfs-discussion@lists.sourceforge.net>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
 "linux-ntfs-dev@lists.sourceforge.net"
 <linux-ntfs-dev@lists.sourceforge.net>,
 "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
 "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211014062844.GA25448@lst.de>
 <3AB8052D-DD45-478B-85F2-BFBEC1C7E9DF@tuxera.com>
 <a5eb3c18-deb2-6539-cc24-57e6d5d3500c@oracle.com>
 <202110140813.44C95229@keescook>
From: Wol <antlists@youngman.org.uk>
Message-ID: <e3d2f358-be1a-3413-fdb8-2e86718cde3e@youngman.org.uk>
Date: Thu, 14 Oct 2021 16:35:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <202110140813.44C95229@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_083557_469320_316406DC 
X-CRM114-Status: UNSURE (   3.42  )
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

On 14/10/2021 16:14, Kees Cook wrote:
>> I don't really mind bdev_size since it's analogous to i_size, but
>> bdev_nr_bytes seems good to me.

> I much prefer bdev_nr_bytes(), as "size" has no units.

Does it mean size IN bytes, or size OF A byte? :-)

Cheers,
Wol

