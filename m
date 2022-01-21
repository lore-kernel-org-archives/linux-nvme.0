Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99CCC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jan 2022 21:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OXAm1qEiIkYNaPU2i0B3YKih+9jiO+IlXNTpahNVR8w=; b=zMSLdFOZ4lk3o01N3AJoXTbt8T
	qe7rTGB5T4f/R3yx7LSnjhgOQgzfVF5t4FvBuTp3UWpQ7juM+LJkOWjkdf+zKS85Vsl7ua94v3aRk
	yiLt/nuHLnpPmO+khqFFLx9QNX9abaqMORkxx9rjrWXZIwndpOCGztR3qtM72hpVAJa6ndvWQ7+wW
	IhYnMyVeRsVzIYpjlqbuKjLfL085ZlJXewn3XLUi5XFVPhWvjtd7jpy7ZiUP7WolsZLIPa+dZHm2e
	BPetLSdrwxcRoM6WDucrI2q+EREfzMwCWr47S/SRzAgUaaQn1iI/wXY+6B07CKMYVHpUNjqAhI/lb
	T5s7a2Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nB19x-00G5A2-0J; Fri, 21 Jan 2022 21:09:25 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nB19j-00G597-1h
 for linux-nvme@lists.infradead.org; Fri, 21 Jan 2022 21:09:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 19BCBB8116D;
 Fri, 21 Jan 2022 21:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D19CC340E1;
 Fri, 21 Jan 2022 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642799347;
 bh=R9IH1HO9BhkurxhbfZ/tA3xkofYRaHlskaeE4j+DY68=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ebzQK3QhDgT/T2L/u8OlnNiGo3KbbTl6h5ztLuRo1EU0Nh4K9UOFn3pXR7raSTmaG
 zE3L4EdP2ms0NyP6lev85hl9EIsezgehE/pUfqaLG0gXcC3+/2A+SjmPIbGa2sP1pk
 bKGXZgtEWFaXVNC7112ut1J7kKrMo+Himt6b7mB9SFooC4k09b7wEelxbAQZ5aEyqE
 JWLhRSyRXJUhUT8f3B/Ze08E0f7ZogB7WGNplgY5cWZndUY8Li3DPefIfG7mpRHxRj
 KIP+WqjvZelxRCAkMN0e4ih4MMKnYbIwrlgRxeOztyM+sQ8S9ENjbX7yPWI81WI/RV
 rafEKwoAeV3lA==
Date: Fri, 21 Jan 2022 13:09:05 -0800
From: Keith Busch <kbusch@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 m.heingbecker@googlemail.com, linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Message-ID: <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220121_130911_261547_ACAEEB79 
X-CRM114-Status: GOOD (  21.53  )
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

On Fri, Jan 21, 2022 at 08:00:49PM +0100, Rafael J. Wysocki wrote:
> Hi Keith,
> 
> It is reported that the following commit
> 
> commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Tue Jul 27 09:40:44 2021 -0700
> 
>    nvme-pci: disable hmb on idle suspend
> 
>    An idle suspend may or may not disable host memory access from devices
>    placed in low power mode. Either way, it should always be safe to
>    disable the host memory buffer prior to entering the low power mode, and
>    this should also always be faster than a full device shutdown.
> 
>    Signed-off-by: Keith Busch <kbusch@kernel.org>
>    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>    Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> is the source of a serious power regression occurring since 5.15
> (please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).
> 
> After this commit, the SoC on the affected system cannot enter
> C-states deeper than PC2 while suspended to idle which basically
> defeats the purpose of suspending.
> 
> What may be happening is that nvme_disable_prepare_reset() that is not
> called any more in the ndev->nr_host_mem_descs case somehow causes the
> LTR of the device to change to "no requirement" which allows deeper
> C-states to be entered.
> 
> Can you have a look at this, please?

I thought platforms that wanted full device shutdown  behaviour would
always set acpi_storage_d3. Is that not happening here?

