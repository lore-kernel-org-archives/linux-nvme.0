Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB10C41535
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 05:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3shKBIvhLWjsCiSjY85TEmaxzTG7BMW14R+xGNs9tzU=; b=So0NR0BLabt6ViP9084FtyLkIh
	8BN01Aka7nUk/cIgI82FYvbeWvOUKQTwUPWrB9j3M75dO8O6g3PCSzluYUzAO8csrhhGWzLuYqBfB
	9mxvihdre2EjjCbi4LcqLfw+zbpTJZmC1uXkvDmp/E1Y0n36iU5zXX9voXM/jt5QkDAoXqZx8Xq7r
	3Cop3qF/btxcPZoSaF/NBYIP0VS55u3Wc+vnqkPg2otEo7RgEC7uZK+gk687g1fOnUEC4uPStLe6i
	VZM3YoYawZ0rEOChq6B739U9FMjtyoyNVAqAmEqrgX4uSdIBLtKECrL4XLD6/yETVbsiSUtzSH4I1
	4UYZz8RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGXr2-004wxC-2X;
	Fri, 22 Dec 2023 05:13:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGXr1-004wwc-0B
	for linux-nvme@bombadil.infradead.org;
	Fri, 22 Dec 2023 05:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3shKBIvhLWjsCiSjY85TEmaxzTG7BMW14R+xGNs9tzU=; b=FJLHiuOd8g/VKYYccOIaQxdGOZ
	+2fuv1sq672PBRaBDJFiQ4jDPcXQawRxmtlcgIoSZivPkVN/d+Y2jCaL0VQ8l4EHJ7En0Ts5mJeIy
	K1Ey6aZexE84ec/5gTBJNZnAIZhArgxCdoUcH1PN1PkPduPdUT5DjEu2Mb4oFe9G/ya1wI1fyb/SH
	Slza91DDVfucNamH/zqB6RwD9U6YCgQ9o+nOer4YNxItcpBjFRbcPF0P1lR9sXQY3DZHeXMXBDnG0
	gn/E3zZYaMd1M1z4Eeg0luXFDWlqsVI3A7Q8W4bo4tqf7o23+KRqXrt/EBxGDtyI8blwCaInQyHAB
	zL+mUu4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGXqx-007AOG-3A; Fri, 22 Dec 2023 05:13:43 +0000
Date: Fri, 22 Dec 2023 05:13:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZYUbB3brQ0K3rP97@casper.infradead.org>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
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

On Thu, Dec 21, 2023 at 12:33:08PM -0800, Bart Van Assche wrote:
> I'm interested in this topic. But I'm wondering whether the disadvantages of
> large blocks will be covered? Some NAND storage vendors are less than
> enthusiast about increasing the logical block size beyond 4 KiB because it
> increases the size of many writes to the device and hence increases write
> amplification.

I've been mulling this over for a few hours and I don't really understand
it.  The push for larger block sizes is coming from (some) storage
vendors.  If it doesn't make sense for (other) storage vendors, they
don't have to do it.  Just like nobody is forced to ship shingled drives,
or vertical NAND or four-bit-per-cell or fill their drives with helium.
Vendors do it if it makes sense for them, and don't if it doesn't.

It clearly solves a problem (and the one I think it's solving is the
size of the FTL map).  But I can't see why we should stop working on it,
just because not all drive manufacturers want to support it.

