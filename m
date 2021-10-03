Return-Path: <SRS0=iTsx=OX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57685C433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Oct 2021 02:05:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B783E6136A
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Oct 2021 02:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B783E6136A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kbTuG/a79Ye1CN5kM4QPfc0g7YNnYzC82F7PWajrOMA=; b=UbFNSYhIv3hMxQ
	QnJS6Gox95JTKQdjOsDogLC5tHrMgLKYoxHA7xAyLdO0BLJujrNrKbPw2yYP/9n2tg6iwmbitHFMW
	y4/hh0GMADM05PvTe95nDWcTTrTft0gNpO5sdPJFCxoqFjdacF5p9dd1EDOo9z1LoQICdDooesdFV
	L2UaVMHQsa9SwT8IHni6eB6Nv50dvhkexog9NFKTB8pNvQs2PGw+0/J0XOsf3HYIdsI5MxodsrTva
	9Dt7MSqSW1a7yRlcUHzqQKpAck6bmI/4Ar9OX2hg0L9YwnWjEPk0c/LROhA2YWTFceUjdyTtn72n6
	vu4NlKM7HaFWVbcb4Grw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWqrq-0032l4-2p; Sun, 03 Oct 2021 02:04:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWqrn-0032kF-7j
 for linux-nvme@lists.infradead.org; Sun, 03 Oct 2021 02:04:40 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 884286136A;
 Sun,  3 Oct 2021 02:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633226677;
 bh=URiAkiH5aJsr/wk48nkcA3RKt2/FRXxhZ844hbHUgjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JHk2PmQi2q5L/FYFcRS60TWuA7xNotlX6YabBX5egLYqlaKTVaHXjUWNNjjjQmWJH
 TKBG3FyG83NoBARv2uS0gc57ovJmNqN+ciAu0Kx3XfU9tRkWgwcjIPH6YKTvjvaREU
 3erqtbfOnstSSA72rnoqzfjFfC47i9bShnDcRBmR27bGa3pGA9xxKbfaNhcoEzk590
 OxwIBVmjLg+YStOCxSF5ef6X4uJp4K3eCg5DHMSSAOhVvpYXAMnVyHfQg4lDbN3uI4
 OIIXVHz303o6YAgV49DrHseeGbsBqOfRvsuogPIF0GUON9v1GXR3L7WOswUnx2jlyF
 HtRoqf7IrKvCQ==
Date: Sat, 2 Oct 2021 19:04:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
Message-ID: <20211003020434.GB410131@dhcp-10-100-145-180.wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
 <20210928204052.GA390773@dhcp-10-100-145-180.wdc.com>
 <d969a4b7-4d3c-9df7-5a7d-9700bff37d50@grimberg.me>
 <20210930201510.GA94540@C02WT3WMHTD6>
 <0dedfd62-d61b-cfe3-8b5f-13c213323b46@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0dedfd62-d61b-cfe3-8b5f-13c213323b46@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211002_190439_321900_309AA39A 
X-CRM114-Status: GOOD (  14.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Oct 03, 2021 at 01:19:28AM +0300, Sagi Grimberg wrote:
> > Unfortunately this was unsuccessful. The same issue is still occuring. Please
> > let me know if you have another patch to try. I'll also keep looking for a
> > solution as well.
> 
> Really? That's unexpected, this patch should ensure that the request
> is not advanced after the last payload send. The req->data_sent and
> req->data_len are recorded before we actually perform the send so
> the request should not be advanced if (e.g. last send):
> 	(req_data_sent + ret == req_data_len)
> 
> So I'm surprised that the same issue is still occurring.

Only thing I thought of so far is if req_data_len is not aligned with
nvme_tcp_req_cur_length(). When this was working, the request would not
advance based on the nvme_tcp_req_cur_length() value; now the criteria
is based on 'req->data_len'.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
