Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273D6D637AC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WY1//Dv0xL6oHsuk0rzAeANzhX2FGxtVbxtuH+0TpY4=; b=R2dxT5qBqIyqTMSvjJY8V+fKaB
	iH+Qudf3VqBW1bdaSnFdZclfHmdbdPAnOnu+1qrAXmBUUSY4BcoYNJhH15/kTEeveWgW31/SIaO1E
	0dUZfq0HGn2to4ptp6wtkFkP1jxJgDYUwwdMiVfzmp0sTnaBiMSQSZM7/yLls6ivEcyVW8ffOA5Wi
	T//1FxGVQTShYY4nU+MEXk7aug0ZG8l/pUbn/ucX/Tp5dG95cWKe3M3oPTF+dBld/s1Ot8jm5/7hZ
	KQEGE7z1NAwdnbT1YGceA8qKP29gyW0Qxkx0dR7Gt/8dp9K8Bq1IDAGSzKlEr+R/AJHL6E7J5SJdx
	CVzLifBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIoP-00000007oq0-1VTS;
	Wed, 13 Nov 2024 19:13:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIlR-00000007oNv-19A6
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 19:10:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7CF015C5567;
	Wed, 13 Nov 2024 19:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F2FC4CEC3;
	Wed, 13 Nov 2024 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731525052;
	bh=U5mxNLV0SHjT1ykqhZxsaYkGqsbIpfIhRjrw4HyI1bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dm3k+LWb6/toGQUBpgxcAWnL08tMjamqR6pJHHBdZ2rID2pk5Y0MioCeVgFmE7exh
	 58XdkdK8EGaRukiKYDMTMQLAZmlTtQ7eTBVDfGOrHGdyRIVlU6re1RqwKnNuGygyd1
	 bafzpoSc/DhBylGYW7Na5DTu3dVU+LnWxo64E3I0XMV1ktrsJuAJ5+YBz1Y8pdX9tj
	 SvmRd8bG3aY3ysDnnSgPsm1SNGmwI+bahCEOC2vQssujk5AkMLVV3ZLol9zhWXS8Ey
	 o2QvnjJOYt1tJSFldgQn0dhsuTbG1lpEam9ygjGBk5V7obNiy7lP0WXMwNVwgurTrg
	 eVWCMW8CCmSdA==
Date: Wed, 13 Nov 2024 12:10:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 1/6] nvme-pci: reverse request order in nvme_queue_rqs
Message-ID: <ZzT5ubYLImyhNrCp@kbusch-mbp>
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113152050.157179-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_111053_376680_511F2C7F 
X-CRM114-Status: GOOD (  14.14  )
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

On Wed, Nov 13, 2024 at 04:20:41PM +0100, Christoph Hellwig wrote:
> blk_mq_flush_plug_list submits requests in the reverse order that they
> were submitted, which leads to a rather suboptimal I/O pattern especially
> in rotational devices.  Fix this by rewriting nvme_queue_rqs so that it
> always pops the requests from the passed in request list, and then adds
> them to the head of a local submit list.  This actually simplifies the
> code a bit as it removes the complicated list splicing, at the cost of
> extra updates of the rq_next pointer.  As that should be cache hot
> anyway it should be an easy price to pay.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

