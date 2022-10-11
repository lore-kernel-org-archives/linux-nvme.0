Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0487FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 20:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t+VmNSC+kHk3ef3LWmwxbkHyEIwbafiIpzChG3flwl8=; b=eHH7Jm0m2NZs6RSlGzJREUAros
	cB9BpM8y99VUwLjA8dEFvk/5u9Wij2CLIO/ybMGsDX2ECUyfLSpJK83RpfenZUc+/l5j8PuK3f5me
	qpj+jR3AlwVl2RfygOp/ThsXby8I+1qWaJe5OSTb423jAe6L5pbkyxxkppVhD2PJtU3AOVambpg2Y
	0I96oisZuO1fgcb3W9azx/sz01pMzsnsWfpql4W2qKQcpvEJKaukqw+INTpGkSn5Mo7zCiNiLXe6s
	2/qKZJ3S3hJRcpMUCGD7LCBImlx2JuHtytQFWEdHHpVKfs/Mh86wzFPsXJ3eqPA8EDDLNN7L6NIhM
	21FE5XKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiLe3-005kOV-Lq; Tue, 11 Oct 2022 20:14:31 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiLe1-005kO2-IO
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 20:14:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 14A40B811DC;
	Tue, 11 Oct 2022 20:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A540DC433C1;
	Tue, 11 Oct 2022 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665519266;
	bh=n3fFMv1AqgzIYAW4xOtJWudVTm9Dx4Oqka6U8itjMTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdOMYeEbnbotCH7z6WGtFMMOY9byWzoyBurIGZeRtZwfjVGmAd3b9Ig7TxWabLQWh
	 Hm22B6fU6G62S8qYhxaZTFYtAzkk0nWV/wHw6cBafqcaPakndq7sxGf332Mjzgm2Vg
	 2Hu82Un4GVLN+1bI7V1n0uMOFSdBzcHGtNuODiPc9Nd/B4ibqpWQaB3avkgDLSl2LB
	 I8JkXWpvfjhwQ7/+++1A/bMJWILKi8P12ComP31Uu7f66qrIhCcVqB/gCaVjjflc8L
	 yjjmUaOed+icldxqM+F7/AnOyNMrQtYY6AapMJh8b6xK67jmchEzcIW7DAC8N0uACh
	 jLNYGZhPVRslg==
Date: Tue, 11 Oct 2022 15:14:25 -0500
From: Seth Forshee <sforshee@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: nvme-tcp request timeouts
Message-ID: <Y0XOoSmfwAdfOD9g@do-x1extreme>
References: <Y0WMXSv8REysoqFy@do-x1extreme>
 <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_131429_767055_8236C83B 
X-CRM114-Status: GOOD (  25.43  )
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

On Tue, Oct 11, 2022 at 07:30:56PM +0000, Chaitanya Kulkarni wrote:
> Hi Seth,
> 
> On 10/11/22 08:31, Seth Forshee wrote:
> > Hi,
> > 
> > I'm seeing timeouts like the following from nvme-tcp:
> > 
> > [ 6369.513269] nvme nvme5: queue 102: timeout request 0x73 type 4
> > [ 6369.513283] nvme nvme5: starting error recovery
> > [ 6369.514379] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514385] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514392] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514393] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514401] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514414] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514420] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514427] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514430] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514432] block nvme5n1: no usable path - requeuing I/O
> > [ 6369.514926] nvme nvme5: Reconnecting in 10 seconds...
> > [ 6379.761015] nvme nvme5: creating 128 I/O queues.
> > [ 6379.944389] nvme nvme5: mapped 128/0/0 default/read/poll queues.
> > [ 6379.947922] nvme nvme5: Successfully reconnected (1 attempt)
> > 
> > This is with 6.0, using nvmet-tcp on a different machine as the target.
> > I've seen this sporadically with several test cases. The fio fio-rand-RW
> > example test is a pretty good reproducer when numjobs in increased (I'm
> > setting it equal to the number of CPUs in the system).
> > 
> > Let me know what I can do to help debug this. I'm currently adding some
> > tracing to the driver to see if I can get an idea of the sequence of
> > events that leads to this problem.
> > 
> > Thanks,
> > Seth
> > 
> 
> Can you bisect it ? that will help to understand the commit causing
> issue.

I don't know of any "good" version right now. I started with a 5.10
kernel and saw this, and tested 6.0 and still see it. I found several
commits since 5.10 which fix some kind of timeouts:

a0fdd1418007 nvme-tcp: rerun io_work if req_list is not empty
70f437fb4395 nvme-tcp: fix io_work priority inversion
3770a42bb8ce nvme-tcp: fix regression that causes sporadic requests to time out

5.10 still has timeouts with these backported, so whatever the problem
is it has existed at least that long. I suppose I could go back to older
kernels with these backported if that's going to be the best path
forward here.

Thanks,
Seth

