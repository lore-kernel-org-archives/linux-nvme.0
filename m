Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E16D2F02C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Tk7WZKNgrGVlnRKk66nUVreQ4SKcg29FRzHaQdskg8=; b=Zhu57p3DjW64iyn5fP/nVJg1PC
	1PD5pAOTDwKjBSVNp8gRIvN4isddqB9w2Ry3/WhPBxTauGzFTyt0j4S9uaZMq+TZLV6A0giya7Un+
	MHk+ThFgGqnhuIFJinWPBUZlUuzLpkx6ajSPKkDJO7+wAE8Isj0e1xWKHMHxgk5RNJhKNPHmGaEuo
	H1v7RqorMfhBsfRfBmdU3jRXlQZaCghtm4YEeCB4rlwuC970tlTf+o1MirmioifpbNjoV+1FEng+f
	aZcHnGsvw/+ry4YViQULDnCvchbqQw8FFA8+HdgVZQl0BtQtHU1wqurjdbeZEw6vKdN8xchhzjGZG
	MfHYiFUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkjbE-0000000ELyE-33p4;
	Tue, 27 Jan 2026 13:59:20 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkjbB-0000000ELwp-2lp3
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 13:59:19 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 592562ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Jan 2026 14:59:08 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 14:59:08 +0100
Message-Id: <DFZFBKPGNCD4.3EKJ4G1H2GBDC@bsdbackstore.eu>
To: "YunJe Shin" <yjshin0438@gmail.com>, <kbusch@kernel.org>
Cc: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
 <gregkh@linuxfoundation.org>, <security@kernel.org>, "YunJe Shin"
 <ioerts@kookmin.ac.kr>
Subject: Re: [PATCH v3] nvmet-tcp: reject H2CData before ICReq
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
X-Mailer: aerc 0.21.0
References: <1a3d4d2d-db0c-4358-8229-c7d6f5e83bbe@grimberg.me>
 <20260126064248.591202-1-ioerts@kookmin.ac.kr>
In-Reply-To: <20260126064248.591202-1-ioerts@kookmin.ac.kr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_055918_040601_8369E8C3 
X-CRM114-Status: UNSURE (   5.08  )
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

On Mon Jan 26, 2026 at 7:41 AM CET, YunJe Shin wrote:
> If H2CData arrives before ICReq/CONNECT, queue->connect is used but its
> iov is not initialized yet, which can lead to a NULL dereference when
> building the PDU iovec. Reject such requests early with -EPROTO.

Is it actually reproducible?

Doesn't nvmet_tcp_done_recv_pdu() reject all unexpected PDUs
when the queue is in connecting state?

Maurizio


