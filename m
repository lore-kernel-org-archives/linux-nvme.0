Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806ACC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:54:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4107561168
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4107561168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4fKsdRoxADPreSwOWUDRba7IfdIUAdcjlp4Iw5AMJqk=; b=JvJrE4NRurTh7sjMnI6/NJd6UP
	57dbvZJDE5UKIRNuOe3tp+lihfiG7bMrghlyxVggIRr1sLrtq1dr7ueRFV8f016upKDCOXUVg7yQg
	3M0oXLUM2iby3seVk4nGG9uiY6OJv5+fELV04HRXWPQh/PaqZqDwFHLLShWnJS4GITeKdKWBLrdlK
	1bDSSXarWJzba1wHrtv8BPTz9fiujilOu5JgbHXArBpZr63ENxizYLVawsG2+Lqpspef2mkDAY7ds
	p5mG8MInfi00owi8BecmeGdUd92pQkUYM8Uen9wu4PTkoHsxc/yuiK7h122GOHAEx/8NcK5KEzPaE
	vxIKNogg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1magZw-00HSOm-AK; Wed, 13 Oct 2021 15:54:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1magZt-00HSO7-CO
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 15:54:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D2D061168;
 Wed, 13 Oct 2021 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634140441;
 bh=i4508OYXyLbeY8gTV77p+GKbLzVc43Dq4rHzRwreF+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cao+ulCo6DQFkZozH7oVHRAWNMagrpAGhrnzwgGUOZ6Kbvo56olmdXE+ZNRvc4JAe
 JAAFF2+0Cs7dQ2zri4LteTSi63p1/k8xDoZ/owQtVO9puWW/iM9Y+e3J+EXtEALTwY
 Gl4sXvRwf8JOoCeOqzG7w/A4OX+rj80SD9g0cTXsAUSc58fc6P7OHAuh34GdGSyjb/
 Wrq+lfw54mIFDK7+mySwsTzibk8dojNgM5hx4rh/v70mbEou5kBWgE2lrlnV9vidM6
 j+rujYl2hFe2aeliM4YpH3HQoTA4+lrYBguo+6mHN+HsR7ATb1xknpoykMT3ZobkWa
 PW+4QzqI4SHvg==
Date: Wed, 13 Oct 2021 08:53:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] nvme-pci: calculate IO timeout
Message-ID: <20211013155358.GB1594461@dhcp-10-100-145-180.wdc.com>
References: <20211013022744.1357498-1-kbusch@kernel.org>
 <YWb8iVY74vWZiMCU@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWb8iVY74vWZiMCU@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_085401_467040_7C92F676 
X-CRM114-Status: GOOD (  19.01  )
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

On Wed, Oct 13, 2021 at 11:34:33PM +0800, Ming Lei wrote:
> On Tue, Oct 12, 2021 at 07:27:44PM -0700, Keith Busch wrote:
> > Existing host and nvme device combinations are more frequently capable
> > of sustaining outstanding transfer sizes exceeding the driver's default
> > timeout tolerance, given the available device throughput.
> > 
> > Let's consider a "mid" level server and controller with 128 CPUs and an
> > NVMe controller with no MDTS limit (the driver will throttle to 4MiB).
> > 
> > If we assume the driver's default 1k depth per-queue, this can allow
> > 128k outstanding IO submission queue entries.
> > 
> > If all SQ Entries are transferring the 4MiB max request, 512GB will be
> > outstanding at the same time with the default 30 second timer to
> > complete the entirety.
> > 
> > If we assume a currently modern PCIe Gen4 x4 NVMe device, that amount of
> > data will take ~70 seconds to transfer over the PCIe link, not
> > considering the device side internal latency: timeouts and IO failures
> > are therefore inevitable.
> 
> PCIe link is supposed to be much quicker than handling IOs in device side,
> so nvme device should have been saturated already before using up the
> PCIe link, is there any event or feedback from nvme device side(host or
> device) about the saturation status?
> 
> SCSI have such mechanism so that queue depth can be adjusted according
> to the feedback, and Martin is familiar with this field. 

Device side saturation should be achieved lower than the depths
considered here, and that usually happens without reaching link
saturation.

We do not really have event feedback for the NVMe driver to react to
though, so I had this patch cautiously assume 50% throughput for timeout
consideration.

I suppose we could react to the IO completion times and try to adjust
queue depths accordingly, though that is probably more aligned with a
longer term project.

