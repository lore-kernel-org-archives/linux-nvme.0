Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74F6C41535
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 05:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MET1rK6m4uSg+pjKk7i8yy4yXYItUii1yK0ipiQ0oPE=; b=Q9ejNg1S9Q8fSRFTmSsY2Ex2TK
	SaIIp5CaSudYgjNr6soVkBKOzAQh/UNZEpCOSscuyRHrDa6HZ/hy2NZjUlXx6RxQ77nMQpkhor93t
	eEa4mvvewzskjqQtN/BVdpCOSphtE8m1YryiOxsOawAooCnIRylhmQD1UlFVF3eEmZZguJV6gxAPs
	1XmwqcIxRaE28SmD8sZwdeLx1/Hf+vOvcBQ08oo/rrq7Hvtv9klOsrHrDLQKAtApLv8xTR6+DTnrN
	wCVOV8B/cpjC7Cwp0nOY+qzVK6db//5nhtJY+bz/RGFCplAAp1AV2l8O9QF5eZEDHxx7Bfcdi8MUV
	yS/4hQvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGXml-004wLb-1L;
	Fri, 22 Dec 2023 05:09:23 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGXmi-004wKg-3A;
	Fri, 22 Dec 2023 05:09:20 +0000
Date: Thu, 21 Dec 2023 21:09:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZYUaAMrdzveBuroa@infradead.org>
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

Then they should not increase the logical block size for the products
where they worry about it.  It's not like larger blocks are a feature
the Linux wants, it's want that makes hardware vendors life easier and
is thus pushed by them.  Of course it doesn't make sense for every
product line, but it's not like Linux is going to stop supporting
512 byte or 4k blocks.


