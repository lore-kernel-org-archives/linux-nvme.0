Return-Path: <SRS0=WNIw=MR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A92C432BE
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Jul 2021 09:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB0B6056B
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Jul 2021 09:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CB0B6056B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strugglers.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RBu7Vpm9Z7Z5PpNKtM/L/LNG2iFo3HcXqTQ+dt7tjfo=; b=D83ay0Yoi0TAdN
	8jPHa3dTCI5jdBa7U8T072knEfu7ufLxjKsA8IO/U2ArGN7xPpGhJaH2ucpvV74s2GWi4tYIqR3md
	nWTKSt+0PM9maSCzJTgKUiq0SNPstQCtgw6H3+ZP0h1uy74Oyo8sUNdFYaCcL4ROfhzsXKIEnNizo
	v5cM6X1iZSZuunTj9sMygDggXSNdRRpG6Azdp4YrzEKIN9z9OsLRX3LsTwlnXER6q3jLvpxY5BCNJ
	ut1+lzaxsAUwo30Lmxfs6hvXrvfAFGNaQN7riIyvLQMrrFxfO2mJbsZ1FIbKVBwaLD9Sq+SSGj+AM
	OG2ulNIq0tGftS5d+Vyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m7aix-008SZs-Tu; Sun, 25 Jul 2021 09:47:07 +0000
Received: from mail.bitfolk.com ([2001:ba8:1f1:f019::25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m7aiI-008SZJ-Jk
 for Linux-nvme@lists.infradead.org; Sun, 25 Jul 2021 09:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
 ; s=alpha;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NpNghdiHumiwHw3pmLVsCSW8s6jr7L9FH12FRhaCGCQ=; b=dwD4rNPu1mVEKAMdJm//txQiQN
 LH7xa/eFWN8tHRLbaKQkC9bhfHGXF+tddJBCe6kQPnEFPuZJO9EUjfRsajrJIlmI604iI9n/Z2PY5
 0ZFrFpJX8JAKm1rQjbFgco9tvzdfio9+XmPwbLG4R4zxOEZ3XQwtOfTKeos+UP6iKvjpfh6BOvbpx
 ajW3WiJVuYZe+1UZk1JY1ijWfz4AoRsytw1u2prNLwanchXFCpAqaxdUAVRmTKyu9pR7dlrBWh2QJ
 nf7J2RNkmevq9raZx+QHx1b72p+MlT4fl/PSB4QHs9Po9jvBxAFpNcxfzlny5k1YFo1dlLd3vMoxc
 E4fCeYZw==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
 (envelope-from <andy@strugglers.net>)
 id 1m7aiC-00070T-BP; Sun, 25 Jul 2021 09:46:20 +0000
Date: Sun, 25 Jul 2021 09:46:20 +0000
From: Andy Smith <andy@strugglers.net>
To: Ming Lei <ming.lei@redhat.com>
Cc: Linux-nvme@lists.infradead.org
Subject: Re: 5.10.40-1 - Invalid SGL for payload:131072 nents:13
Message-ID: <20210725094620.ip2kyymvumzryyza@bitfolk.com>
References: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
 <YPt/HXOuzZzg3QXf@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YPt/HXOuzZzg3QXf@T590>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210725_024626_861789_84DCDA35 
X-CRM114-Status: GOOD (  24.75  )
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

Hi Ming Lei,

On Sat, Jul 24, 2021 at 10:46:53AM +0800, Ming Lei wrote:
> On Tue, Jul 20, 2021 at 10:07:33PM +0000, Andy Smith wrote:
> > Hi,
> > 
> > I have a Debian stable machine with a Samsung PM983 NVMe and a
> > Samsung SM883 in an MD RAID-1. It's been running the 4.19.x Debian
> > packaged kernel for almost 2 years now.
> > 
> > About 24 hours ago I upgraded its kernel to the buster-backports
> > kernel which is version 5.10.40-1~bpo10+1 and around four hours
> > after that I got this:
> > 
> > Jul 20 02:17:54 lamb kernel: [21061.388607] sg[0] phys_addr:0x00000015eb803000 offset:0 length:4096 dma_address:0x000000209e7b7000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.389775] sg[1] phys_addr:0x00000015eb7bc000 offset:0 length:4096 dma_address:0x000000209e7b8000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.390874] sg[2] phys_addr:0x00000015eb809000 offset:0 length:4096 dma_address:0x000000209e7b9000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.391974] sg[3] phys_addr:0x00000015eb766000 offset:0 length:4096 dma_address:0x000000209e7ba000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.393042] sg[4] phys_addr:0x00000015eb7a3000 offset:0 length:4096 dma_address:0x000000209e7bb000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.394086] sg[5] phys_addr:0x00000015eb7c6000 offset:0 length:4096 dma_address:0x000000209e7bc000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.395078] sg[6] phys_addr:0x00000015eb7c2000 offset:0 length:4096 dma_address:0x000000209e7bd000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.396042] sg[7] phys_addr:0x00000015eb7a9000 offset:0 length:4096 dma_address:0x000000209e7be000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.397004] sg[8] phys_addr:0x00000015eb775000 offset:0 length:4096 dma_address:0x000000209e7bf000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.397971] sg[9] phys_addr:0x00000015eb7c7000 offset:0 length:4096 dma_address:0x00000020ff520000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.398889] sg[10] phys_addr:0x00000015eb7cb000 offset:0 length:4096 dma_address:0x00000020ff521000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.399814] sg[11] phys_addr:0x00000015eb7e3000 offset:0 length:61952 dma_address:0x00000020ff522000 dma_length:61952
> > Jul 20 02:17:54 lamb kernel: [21061.400754] sg[12] phys_addr:0x00000015eb7f2200 offset:512 length:24064 dma_address:0x00000020ff531200 dma_length:24064
> 
> The last two segments are physically continuous, which should have been
> in same segment, otherwise virt boundary limit may be violated.
> 
> But __blk_bvec_map_sg() doesn't make the two into one segment, can you
> collect the queue limit log?
> 
> (cd /sys/block/$NVME/queue && find . -type f -exec grep -aH . {} \;)

$ (cd /sys/block/nvme0n1/queue && find . -type f -exec grep -aH . {} \;)
./io_poll_delay:-1
./max_integrity_segments:0
./zoned:none
./scheduler:[none] mq-deadline 
./io_poll:0
./discard_zeroes_data:0
./minimum_io_size:512
./nr_zones:0
./write_same_max_bytes:0
./max_segments:127
./dax:0
./physical_block_size:512
./logical_block_size:512
./zone_append_max_bytes:0
./io_timeout:30000
./nr_requests:1023
./write_cache:write through
./stable_writes:0
./max_segment_size:4294967295
./rotational:0
./discard_max_bytes:2199023255040
./add_random:0
./discard_max_hw_bytes:2199023255040
./optimal_io_size:0
./chunk_sectors:0
./read_ahead_kb:128
./max_discard_segments:256
./write_zeroes_max_bytes:2097152
./nomerges:0
./wbt_lat_usec:2000
./fua:0
./discard_granularity:512
./rq_affinity:1
./max_sectors_kb:1280
./hw_sector_size:512
./max_hw_sectors_kb:2048
./iostats:1

> Meantime can you try the following patch and see if it can make a
> difference?
> 
> commit c9c9762d4d44dcb1b2ba90cfb4122dc11ceebf31
> Author: Long Li <longli@microsoft.com>
> Date:   Mon Jun 7 12:34:05 2021 -0700
> 
>     block: return the correct bvec when checking for gaps

I applied this patch to 5.10.40 and I am no longer able to reproduce
the issue, thanks!

I see this patch made it in to 5.10.50, but Debian's
buster-backports kernel is based on 5.10.40, the forthcoming
bullseye is 5.10.46 and neither have this change. I will enquire
about backporting.

This is the fio command line I am using to reproduce:

fio --name=randread \
    --filename=/srv/fio/test \
    --size=35g \
    --numjobs=1 \
    --rw=randread \
    --direct=1 \
    --ioengine=libaio \
    --iodepth=16 \
    --blocksize_range=4k-4m \
    --blocksize_unaligned=0 \
    --gtod_reduce=1 \
    --iodepth=64 \
    --time_based \
    --runtime=4h

Where /srv/fio/ is an ext4 filesystem that is the first partition of
a block device deliberately misaligned by starting at sector 63.

I haven't been able to reproduce without this misalignment, but with
it I can reproduce within a few seconds. I've run it for several
hours (read 17TB off the device) with
c9c9762d4d44dcb1b2ba90cfb4122dc11ceebf31 and had no issues.

Thanks,
Andy

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
