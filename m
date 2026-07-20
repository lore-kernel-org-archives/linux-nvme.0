Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D39DC44520
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UejnvKJ6g9gMJanunWLrrKhYBZB1/JIBg8RLC+bnqec=; b=FGmSylPu5sZzIE
	QIKb53zT5xPkHXE05MzQzItaneTJgMSfR1Sv8OaVPiIIi8IFLEfKIk5Tl0GWd5+Tm3Hqr0JqzOQGV
	qpQJYg8M+qnZZHbPWopaAp+KVcwWlOPDjtejYQdpqBWzJOsH55ojGEECo37i8bMCz3phcNWWGqA3G
	0Bchc3l3ZyBCi+S0EmQN0Dts0Eskh2Gb+Uhau2SM7v1oVDr0PT93b5JSzxaZH8KiulqdnOH0V4mL9
	IwMEwjOd4mTes46Jp0fBs7Y3DMUp0eJun16vhKulT7L6vfcvwF8F4hPjPfX9jOdqZt1bRUgTV4pUX
	i+uIPKsWThF1mm5+XVPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlqur-00000007OPm-0Fl2;
	Mon, 20 Jul 2026 16:32:29 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlquo-00000007ONv-0G2x
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 16:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=UejnvKJ6g9gMJanunWLrrKhYBZB1/JIBg8RLC+bnqec=; b=XfEJilhz7K3/u1syeao1OiBuv7
	cPb46Ie3iKQCESnfHFjcSvEiS51mxQmcWQHidb5UeslC/dPkvy6x5rsSd69D5FYW4CzGWS+soUzm3
	qG+YSRRP3+YlDlsvF6eiuALUNxqhRts/xTm6JhYu2C4XJIZD19Aqi9ZItYNeGLBh0aNNBmZAQMXR0
	IqaAdBGQGwJpUDTA1ouAkyK0aqkGW/S+VFhHWLeEbOo4yvlMrgXt6G83ACdLa5rv5FPXqOcGXgo7z
	CKbU8WGpdp07CWbVn/17UUeJA9cq/ZIBxJlNVzThwKgJX/Zv7qWjjAQsGRll2EO7jlMUv9D0leJMj
	Fx2gI0Lw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wlquk-0000000B6S8-0KRQ;
	Mon, 20 Jul 2026 10:32:22 -0600
Message-ID: <8e34f60f-c45b-4455-9486-7c1eba60c0a2@deltatee.com>
Date: Mon, 20 Jul 2026 10:32:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260719105327.864949-1-mykola@meshstor.io>
 <20260719105327.864949-6-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260719105327.864949-6-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 5/7] md/raid1,raid10: keep REQ_NOMERGE on
 narrow_write_error() retry clones
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_093226_103255_00FBDD68 
X-CRM114-Status: UNSURE (   9.13  )
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



On 2026-07-19 04:53, Mykola Marzhan wrote:
> narrow_write_error() re-issues a failed write in badblock-granularity
> chunks, cloning from the master bio and resetting bi_opf to a bare
> REQ_OP_WRITE. For a P2PDMA bio that reset drops REQ_NOMERGE, which is
> the only request-level protection against the member queue merging
> P2PDMA segments across pgmaps or with host memory (see the preceding
> md_submit_bio() fix): the retry path would quietly reopen the hole
> the submission path closes. Restore the flag on P2PDMA retry clones.
> 
> Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Looks correct, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

