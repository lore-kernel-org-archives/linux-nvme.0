Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA6C432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 03:58:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E042154A
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 03:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BCLaNDUS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew3mhVvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E042154A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D79D1SRc1RpqxFxM34TJ9AhdugHhnnLqTFUypgQpAkw=; b=BCLaNDUS44fMoH
	Cv/Q1hmKruW1j+2BIB/TwzAGdWw+xh2d1u8O98ZTJgmbj4G1RTLF3Q9RZ0QMMD0pgYqzcBfcD57WV
	M9UZSMWoOeh6/PvIpiZMyygTQWcoVA+5EkIuav3Ctetz2ru6wQlF4CNENgxZXQf9pOuygHLnyCQIo
	e5yO0JydYkXVQUNXG0uKLHp5zyFzXhQYUWMmCQULMYxwdpNT+ZV94ZMz8nvNoDDu6+mwh8O+2dtxs
	8xt2H89ZegGaUvSgZbuxk4LL0FqfCHG83xMhSExMhrKqi0hQyqCmiyjozoCbYlg96v6/poDU3lLuZ
	vCtix9SRLR9dBtYUJedQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaAwT-0003QH-Cc; Thu, 28 Nov 2019 03:58:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaAwQ-0003Pz-HI
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 03:58:07 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50003208E4;
 Thu, 28 Nov 2019 03:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574913486;
 bh=NDBMtX0J/CmDTNiRvjdji6fwgPtpVfscg5M3ZlNsQ+Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ew3mhVvviPIN6hxnGf6RgdZBPx6XCAFoFjKSvetklZrWZia58PL43BWDZZcWQLry8
 L5aXga5no8lTFoAOf3VePnJ8P7ataZDUzOiXmEvckXgk0NyqKrjWspd5wtlS+tSc8N
 hqQ4xXcS6BSeB1snIqSrG+Gl6XdK92I81OO00vHo=
Date: Thu, 28 Nov 2019 12:58:03 +0900
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/4] nvme/pci: Spin threaded interrupt completions
Message-ID: <20191128035803.GA1947@redsun51.ssa.fujisawa.hgst.com>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-5-kbusch@kernel.org>
 <11325d8e-e9f8-408e-18c3-182c69e90eab@grimberg.me>
 <20191128032843.GA1738@redsun51.ssa.fujisawa.hgst.com>
 <20191128035139.GE3277@ming.t460p>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191128035139.GE3277@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_195806_596611_F0369ABA 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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
Cc: bigeasy@linutronix.de, helgaas@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 28, 2019 at 11:51:39AM +0800, Ming Lei wrote:
> On Thu, Nov 28, 2019 at 12:28:43PM +0900, Keith Busch wrote:
> > 
> > When you have two or more devices with queues mapped to multiple CPUs,
> > their threaded interrupt handler affinities will not share the same CPU.
> 
> They still may share same CPU if there are many enough NVMe drives, the
> threaded interrupt handler actually takes the effective hard interrupt's
> affinity, which still may point to same CPU, in case of:
> 
> 	nr_nvme_drives * nr_hw_queues > nr_cpus

Yeah, that's true. I'm just a bit constrained on devices, so having some
difficulty testing Sagi's scenario. I assume the cond_resched() provides
appropriate fairness here, but will need more time to instrument such a test.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
