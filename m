Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BB6C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 04:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FfzE3Y1T8sHGPyUVbGFeusJ9UbDrQ4wJYd7IalK6cn4=; b=lQbuX8Boh/wOoEabu2wg3hy306
	wjT0ugdh255DVuDM8ye3pF/Jr78eNtPXkW7B/vCJGkO/lpaC4aeoJknYIsb7OYVFD4neT36X9Dcvq
	oIokx1Hdnyk1MKwRc0H5WbQQZKsa87F+K+4VEEuXJu2SRcRF0wsIluI6ivG56/sucrfQZxq2cLe00
	2dLYHhcow3OV/GWWJ8w11g14+T3Ucyyv+COlXOK9fVuY/qPQ8REUtIrf84+oLpuoQ7pvmNnnQh8Jr
	Ivnj0tNtW5wiq/3mzhlRGnrsTcLxW/6BqfbBmw/31Tw2f2fwOk130CUfctA30IDpX25ZpJy4c6mEY
	NnyPDC1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLbqL-00FubM-25;
	Fri, 05 Jan 2024 04:30:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLbqI-00FuaN-2w
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 04:30:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CB6968B05; Fri,  5 Jan 2024 05:29:55 +0100 (CET)
Date: Fri, 5 Jan 2024 05:29:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jra@samba.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jeremy Allison <jallison@ciq.com>,
	tansuresh@google.com, hch@lst.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] driver core: Support two-pass driver shutdown
Message-ID: <20240105042955.GC23630@lst.de>
References: <20231221172257.2234320-2-jallison@ciq.com> <20231227203337.GA1509884@bhelgaas> <ZZRQ4oSUdP/i4Pfg@jeremy-HP-Z840-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZRQ4oSUdP/i4Pfg@jeremy-HP-Z840-Workstation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_202959_099214_5A525B01 
X-CRM114-Status: GOOD (  14.26  )
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

On Tue, Jan 02, 2024 at 10:07:30AM -0800, Jeremy Allison wrote:
>> But I'm not a workqueue expert and I do see the scary warning at
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/workqueue.h?id=v6.6#n619,
>> about not flushing system-wide workqueues, so maybe this wouldn't be
>> workable.
>
> This is a bigger change than I'm comfortable with
> (or indeed understand :-) right now. Can we fix
> the immediate problem first please and then look
> for improvements later ?

It's also a lot less efficient.  Assuming NVMe isn't alone and other
hardware interfaces also have a shutdown/disable busy wait (and I've seen
quite a few that do) as their limiting factor the two-pass shutdown seems
much nicer than spawning tons of work items.

