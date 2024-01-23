Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C31C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zp1PH4ajPrsJQ2p3i6c7WwRuYKiK/j9iPa+NTQ9K7P0=; b=GS7qO0KQr1zclEfWo/J99fV+iA
	w1/pIjuTlmw9vjeEhbnLzhmQjQVxSpv2eLCwC1YHTy5Q6xNjwxcnmj2c3UordquHyrPlBSA+NhEEf
	oDYFPx8fDLysDYpoIZp28W4STAVXshtpmrW+GEMkVsAZJD+hCwc8NItzDANN4mkMijeZFrZ79CxV9
	NRCp2WZioxvnBkFKINEgEKjFdgoBfcinTbR6rzqIhgCcKjFc7AIupBjvKLMtvebpyAQOVsGaneCkc
	1IPNqDX7CvNZT0ek1knwMiX2eSGgpwvdULUfTo4FWS4+WRu0Xw7ke/T3mIZ+859AHJy47SWzJdgNs
	dqn45UWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCiX-00Fh55-1V;
	Tue, 23 Jan 2024 09:05:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCiT-00Fh43-2G
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:05:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0932168BEB; Tue, 23 Jan 2024 10:05:07 +0100 (CET)
Date: Tue, 23 Jan 2024 10:05:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <20240123090506.GA31535@lst.de>
References: <20240116232728.3392996-1-alan.adamson@oracle.com> <20240118072419.GA21315@lst.de> <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_010509_884212_65001953 
X-CRM114-Status: GOOD (  14.31  )
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

On Thu, Jan 18, 2024 at 09:02:43AM -0800, alan.adamson@oracle.com wrote:
>
> On 1/17/24 11:24 PM, Christoph Hellwig wrote:
>> On Tue, Jan 16, 2024 at 03:27:27PM -0800, Alan Adamson wrote:
>>> It has been requested that the NVMe fault injector be able to inject faults when accessing
>>> specific Logical Block Addresses (LBA).
>> Curious, but who has requested this?  Because injecting errors really
>> isn't the drivers job.
>
>
> It's an application (database) that is requesting it for their error 
> handling testing.

Well, how about they then insert it into the real or virtual hardware.
The Linux nvme driver isn't really an error injection framework.


