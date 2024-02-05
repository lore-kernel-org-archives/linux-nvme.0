Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608DAC4828D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fiaWrbKorKLdEQmGI0yOW3B8AzdFRsYXsKw7zr9ncio=; b=Id2TTrcpPVEV0QH5QGWwR5TDqz
	yVzJ6HrBSIw+ZyWvjJAz0VkfaohmiaFdwfeeAhhby6uLOhklUvt89BNJ7MCmwWExv+WwBQp2jye1x
	70WwgXo+D9Nn7ZWmxN5E0n2trDAyF8vNXtZLM26SfXIjgtEoxSRDvudnIDn516f/AX4+I1yQDrwZI
	Ztgryu+v1mxbV1Ky/abmcEJRIdaRc7sA8lWqyUgWsZFZ8/lta1kmANl43jElHuxmZBNF+pXzuIrJg
	N3qD5xM4JzAaCmZ7Xt18wfO0L5YsBNYT8ZXdCmUMyQCcBjopeFStRSxYqp0Qpoxj6Td8eGaTNSQwL
	Y1S+IgKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX3Ec-00000004HeI-1BN8;
	Mon, 05 Feb 2024 17:58:22 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX3EZ-00000004HbW-1oeQ
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 17:58:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4F143CE0F20;
	Mon,  5 Feb 2024 17:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7265EC433C7;
	Mon,  5 Feb 2024 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707155896;
	bh=yUZCS4T41E4PdknLEBiZ68LWhjoqFYMsfqcxu/Bzrx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNnsoAcsFtO7Jwi7cqUyyaRERKEXj5kL5XjRb34eiZRADbJse4iU2Vycl0NT51SZG
	 r6F8kP66B2px9eZYT/T64QMqa6fqNiKfyl0iW2ZDMtBJrMj6IvUncTYLwtBqKl4Utp
	 rgeQB6V/lop5Bj77rx7Lv4uJDhD1TUcrIqc6REYXeffCMcB/c+6/V0vg6L2sTvKAKE
	 xN1ifF3jji6QIH7MvxdXV8+enhsw7SiFmgnjyrgsu3DGDBvkC8oQFY46Jsi9mv6Jh/
	 NOFV+69/yOIC9Q3yYi9LUfeG2/JeTp1MybvyJob9v2oms3Ag8xD5VFaWN9cX5HZeCb
	 WymRyugedWtXQ==
Date: Mon, 5 Feb 2024 09:58:14 -0800
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe suspend failure
Message-ID: <ZcEhtkAO0LlLmjgJ@kbusch-mbp.mynextlight.net>
References: <294cb317-22b1-4c03-9b12-b19c55ec3163@acm.org>
 <Zb7l5Lk814W4064a@kbusch-mbp.mynextlight.net>
 <ccfbb194-c355-4dd9-8b06-689480f5fb85@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccfbb194-c355-4dd9-8b06-689480f5fb85@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_095819_687248_C87B2939 
X-CRM114-Status: GOOD (  11.44  )
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

On Sat, Feb 03, 2024 at 05:44:03PM -0800, Bart Van Assche wrote:
> On 2/3/24 17:18, Keith Busch wrote:
> > And this is happening during a suspend? What kind of suspend? Like an
> > S3/S4, or idle suspend?
> 
> I'm not sure how to determine this? This is what I found in the logs:
> 
> Feb 03 09:02:20 asus systemd-logind[1208]: The system will suspend now!
> Feb 03 09:02:20 asus systemd-logind[1208]: Unit suspend.target is masked,
> refusing operation.

I am not sure what the "suspend now!" message means to the driver. Your
initial report with the "CSTS=0xfffffff" comes from the nvme request
timeout handler, so I'd want to confirm what command is timing out, and
what path dispatched it: was the command dispatched from nvme_suspend()
path, or is this coming from somewhere else? If somewhere else, was it
dispatched before or after the nvme_suspend?

