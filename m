Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C4CC44520
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T40zLSnGBy2hqHl7tiJhrkhW2pKsi4efBFaej6HGMec=; b=voz5QrHc+bI406
	8hf13chVR0kWnU98iSBhS2GYHXM6MO4u3yLib6xU2MiVyTF2Xmnx49ii+iQkxVpM1aGAYruYr0jqP
	GWh9x+GGaaK1O4tBbdo1DY6I2FE0XfCiGS8LM0Zp/yZ91Er1Ro6XAaWV4Xw2gaaERl8MuO8MRoEfZ
	vZVLBEZ45wo7VlyWus7fEUBjeFEflxJv2OE24c27051RAm0mUStz8H/U1zDZLlX9EnCuBTh4Y4+Lh
	MSVHxWUMpC1jvP99qZ1GeLWOHUMFYejfHjFV/cHB5j+hJszub2z0g9MkNvPSNPKdNZDfy0jWIHQjd
	ISb772iB7SxdhkCuJbyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlqTb-00000007Ivn-1W5n;
	Mon, 20 Jul 2026 16:04:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlqTZ-00000007IvS-4Av3
	for linux-nvme@bombadil.infradead.org;
	Mon, 20 Jul 2026 16:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=T40zLSnGBy2hqHl7tiJhrkhW2pKsi4efBFaej6HGMec=; b=o5rT0XdQ0MYMDYGVcpLURipJpU
	I14OYOLM1DZ+kMgXLILCjlLZakOA7xhIAkANzIhA135xR97AMhAW3TeGk4WKfFz+f47K12mRoXobi
	hpvmTWSgOiPoxWlaht4xj38Ijhqk5B13MuiwAow+OGhh3FLy59f9UQTZWHpDpnWsr0WtvGnJPk4sF
	OsdRRGxo+jcPIT17qDoSGKEDc1zh7OJcBKFRXlWmURnj4bNyyxvWDUL6nMm9sjwPuuNUsicmtYlkX
	s4wd3zfL4N722DxcFNUCD8e2maj+8vJ3/AxP4GqvkCK5V0afqmc/iIXiyWBPJg/+V7oXaInnxomuB
	p4xYTgDg==;
Received: from ale.deltatee.com ([204.191.154.188])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wlqTW-0000000GluU-4Big
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 16:04:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=T40zLSnGBy2hqHl7tiJhrkhW2pKsi4efBFaej6HGMec=; b=j3o8JOj7B/uTCnqOrY71I6s6MT
	4Uh+dKozXnsM8NdZw4ta/ExCHzOQByj+AHRZbALajjKdcg/BpbL5Tt1X8WkEDwX06kfa2bI4ociYl
	1h1Kf8uyQkd7TtHGm4Pphe8ueAaGakzS8V/KCJBp2lXDiwD4wE7wxDfwwz6mYlgmdYk+iLZW3qMS+
	DGBAOupX5dEpMOl7lyQsycgaVS+VRR57F77wgg5Vq8bq8RnGD+b/YfQD5NcqD6r70VIQzwPnh+1FS
	S2/gP0194XnfJEN6DJdsLJP489/TwajgsH+oXBgm05Z49yYSFulasjT4D5jgrWQPVgtGOZ9MdVG2N
	NtlrjWZQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wlqTH-0000000B6Il-3Oce;
	Mon, 20 Jul 2026 10:04:00 -0600
Message-ID: <eded3e25-eb53-417a-8040-fcad3854c1a3@deltatee.com>
Date: Mon, 20 Jul 2026 10:03:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260718162547.448892-1-mykola@meshstor.io>
 <20260718162547.448892-3-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260718162547.448892-3-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, leonro@nvidia.com, jgg@nvidia.com, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/6] md: ensure REQ_NOMERGE is set on P2PDMA bios
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_170415_156850_522A471D 
X-CRM114-Status: GOOD (  13.04  )
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



On 2026-07-18 10:25, Mykola Marzhan wrote:
> md_submit_bio() unconditionally strips REQ_NOMERGE before passing the
> bio to the personality, an optimization from commit 9c573de3283a ("MD:
> make bio mergeable"): a bio that md has split may become mergeable
> again below md.
> 
> For PCI P2PDMA bios the flag is load-bearing, not a hint. The block
> layer sets REQ_NOMERGE on P2PDMA bios (__bio_add_page(), and the
> extraction path of bio_iov_iter_get_pages()) because the DMA mapping
> type of a request is resolved once, from its first segment
> (blk_dma_map_iter_start()), and request-level merging is prevented
> only by REQ_NOMERGE. Stripping it allows the member queue to merge a
> P2PDMA bio with a bio carrying pages of a different pgmap, or host
> memory, mapping the merged segments with the wrong bus address:
> silent data corruption on the member.
> 
> Set the flag for P2PDMA bios instead of merely preserving it. No
> in-tree path currently submits P2PDMA pages through the bvec-iter
> path (bio_iov_bvec_set()), which skips the flagging -- but nothing
> structural prevents one, so setting rather than preserving hardens
> md against that gap at the cost of one branch. Everything else keeps
> the original optimization of clearing the flag. This covers every
> personality that advertises BLK_FEAT_PCI_P2PDMA (raid0, raid1,
> raid10), which is why the fix lives in the shared md_submit_bio()
> path.
> 
> Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

Makes sense to me. Matches the similar check in nvmet_bdev_execute_rw().

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

