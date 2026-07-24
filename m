Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247AAC531FA
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZNQaYBhxmRPRp3MSD4orn4lVQITWPI7vJhQDea9WLWA=; b=kq8BKl2XFtLVWY
	tdxMwtrTx5dsMnr+s/m2+iL6E7cSNvaFgh7LYna9bYvbbxlzInNTrv8Ifz+PbkNxoVxuiIHEb3yqq
	S+XXWkLezr1znapihbXJLmVU+V7jkz0eO0YAB77rSlVPb21vbe+h1kvLE8FI31aJuyPLpyZxtnIOd
	dRiVoX+hYbLfK7aQr/7SZQK0f30J2SaY+DGXK/xCl8a/2AyR+lIYXcfMwitoR2g1D2k9hWdpe7KVk
	Dh7y/8OUT5mPW+lXXh8XGquHTf09wCH99sSLO9yaosIeRPRuhUW0qA2m4WpFUbtkBwnEIDdx8qF9T
	hy9ubIhmWTNCDhlxSaag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnHaT-0000000Gfyz-2Vks;
	Fri, 24 Jul 2026 15:13:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnHaS-0000000GfwV-0cXt
	for linux-nvme@bombadil.infradead.org;
	Fri, 24 Jul 2026 15:13:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZNQaYBhxmRPRp3MSD4orn4lVQITWPI7vJhQDea9WLWA=; b=MfM7kFBUHvW7vPwhf/TNNTv7bf
	TsZJRelZKm71GWI3d/IsHnKiwjxaLXW+S/o83bnhOtuOFSeuOjiBl6BQJbgfxzH944gRWT05OEGJR
	BQAhi7wxarNzJVJCzB0Q9bT7c9Fz8Gf62Uo5V97ceJvKv6/GA1pV2GH2STz8hUdE0HUUuIJVtC+zi
	kvuqI/QcT680OShjdu5wM/aWi9pkTOnbG+XWFhE1cMxx4HJGaMFTPRtwnpXipPJsyvaVxoZs3reWi
	4F0OuSp6pMx7BhjWh+YuVMgJwbq3XjfZikaIJdaZbrkcgxzwzeIDosf6jI7HkImND9d3K9A0z+0Kl
	E0oVEutg==;
Received: from ale.deltatee.com ([204.191.154.188])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wnHaO-00000002g4O-0iBe
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 15:13:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=ZNQaYBhxmRPRp3MSD4orn4lVQITWPI7vJhQDea9WLWA=; b=cWmRFP83Y7oPZwBv2BLRKVl1HD
	D8rIMDnGdgxr1yVtuC+jeiGi7dT25yeEYXLQa5VBnxPIjaaiyQD5kqefwtNR8JP5td2qaCWlapYtw
	Vd2lB/XyAkRJ2ZYbDE31HdlR0rB9YHNMJYPHrxkeOOKcfuwUzhQbWPqu0eghgt2IWpDxyjsQs1s8d
	EB2c2EoWjQB8/ZBKMgtiZt+tj/HCdbS3B8MSQR9XpzXaLeng7EChYiemPYUadTVebvcIttEkCRR1t
	n1T4l23fiGPBBRgawhsx7Y5uaX/BZmHaiB575OBeptxUHZa0Y0Ysymx0XcHzwlA3gqqS1dl5ECFhz
	VU6pA5+A==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.8])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wnHaC-0000000DzHJ-0tXv;
	Fri, 24 Jul 2026 09:13:05 -0600
Message-ID: <47954eca-63e6-401b-82d7-d5969207ded9@deltatee.com>
Date: Fri, 24 Jul 2026 09:11:43 -0600
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
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260723204206.76930-1-mykola@meshstor.io>
 <20260723204206.76930-8-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260723204206.76930-8-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 07/10] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_161316_673355_902A49C0 
X-CRM114-Status: UNSURE (   9.89  )
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



On 2026-07-23 2:42 p.m., Mykola Marzhan wrote:
> BLK_STS_P2PDMA reflects the peer/member pairing, not member health:
> retrying the same pages on the same member cannot succeed.  Keep
> WriteErrorSeen so the range stays fenced, but skip WantReplacement and
> FailFast eviction, as commit f7b24c7b41f2 ("md/raid1,raid10: don't fail
> devices for invalid IO errors") did for BLK_STS_INVAL.
> 
> The failure is whole-range and deterministic, so narrow_write_error()'s
> block-by-block submit_bio_wait() retries are pointless.  Record the
> whole range as a bad block in the completion handler instead.
> 
> Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

Change my no longer correct first Signed-off-by to:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan

