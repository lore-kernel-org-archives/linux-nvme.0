Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26032E64015
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 21:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aNNR6WRAI3KtDJCf3ZPceoJmF1QvFNbsZL3CSMQQu/o=; b=Atbe449mllLEgp3ztVWgKDXrq/
	ECTFuGGStamiUvWDw9YpaXApBGPcJjO92/CmRtn3cv4eAEBn+ZXkIHkv498eW3O8tG+kYSnOdiABa
	mNtb73tFsZ4BllCgrf6dOKlxsg5MGvUCq6k+z0YpK/IrhJW5AGYledQ8ssXMDotji7NGFgXflxYGi
	5nJfyH55CRbCiftI7wG55AzskXCgLGGJR9M08ldsusrqV8mt8rNRNz4uoPM+5q9OfhT0Zmw0R9pvd
	V28iJXlM/c6IdX5WkvGBCrOfsGBSVWMJYaX92Zm30ZbGY81jqJ88J5yJIWzfYwTgGEfF8vxQJlSNC
	V/013jCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEEaY-00000000xtJ-2dUO;
	Thu, 21 Nov 2024 21:19:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEEaW-00000000xsj-1j13
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 21:19:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732223983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNNR6WRAI3KtDJCf3ZPceoJmF1QvFNbsZL3CSMQQu/o=;
	b=VwdSIWc3J2iN8U5Fv7NegFKGIJcDOhk1QuSNosGnMRVmJ0hz36u4tBxlM54eUCIIZqpYDk
	0U1mBbcpKSqI3YV+vQ7UoZFyCPAk6w3fOYnuQnkUr7ciBit7eLvC5NotnUgzkxGzvHHO20
	MBAucne2tFL9vPn+hn+xJgU7dM4Zw54=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-FG-I4naKN_S5YwZeBwIgPg-1; Thu,
 21 Nov 2024 16:19:39 -0500
X-MC-Unique: FG-I4naKN_S5YwZeBwIgPg-1
X-Mimecast-MFC-AGG-ID: FG-I4naKN_S5YwZeBwIgPg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D9B8195608B;
	Thu, 21 Nov 2024 21:19:36 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.137])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83FFE1956086;
	Thu, 21 Nov 2024 21:19:33 +0000 (UTC)
Date: Thu, 21 Nov 2024 16:19:30 -0500
From: Phil Auld <pauld@redhat.com>
To: Paul Webb <paul.x.webb@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <20241121211930.GF394828@pauld.westford.csb>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
 <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_131944_522678_DD2F5BD3 
X-CRM114-Status: GOOD (  40.82  )
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

On Thu, Nov 21, 2024 at 09:07:32PM +0000 Paul Webb wrote:
> Hi,
> 
> To answer the various questions/suggestions, I'll just group them here:
> 
> Phil:
> can you try your randwrite test after
> "echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"
> 
> Performance regression still persists with this setting being used.
>

Okay, thanks. Different FIO randwrite issue I guess.  Nevermind, I'll
go back over to scheduler land...



Cheers,
Phil

> 
> Christoph:
> To check for weird lazy init code using write zeroes
> 
> Values in the 5.15 kernel baseline prior to the commit:
> $ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
> 0
> 0
> 0
> 0
> 
> Values in the 6.11 kernel that contains the commit:
> $ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
> 2199023255040
> 2199023255040
> 2199023255040
> 2199023255040
> 
> 
> 
> Chaitanya:
> 
> Run the same test on the  XFS formatted nvme device instead of ext4 ?
> - XFS runs did not show the performance regression.
> 
> Run the same test on the raw nvme device /dev/nvme0n1 that you    have used for
> this benchmark
> - Will have to check if this was done, and if not, get that test run
> 
> repeat these numbers for io_uring fio io_engine
> - Will look into getting those too
> 
> 
> Another interesting datapoint is that while performing some runs I am seeing
> the following output on the console in the 6.11/6.12 kernels that contain the
> commit:
> 
> [  473.398188] operation not supported error, dev nvme2n1, sector 13952 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> [  473.534550] nvme0n1: Dataset Management(0x9) @ LBA 14000, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> [  473.660502] operation not supported error, dev nvme0n1, sector 14000 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> [  473.796859] nvme3n1: Dataset Management(0x9) @ LBA 13952, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> [  473.922810] operation not supported error, dev nvme3n1, sector 13952 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> [  474.059169] nvme1n1: Dataset Management(0x9) @ LBA 13952, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> 
> 
> Regards,
> Paul.
> 
> 
> 
> On 21/11/2024 14:49, Jens Axboe wrote:
> 
>     On 11/21/24 4:30 AM, Phil Auld wrote:
> 
>         Hi,
> 
>         On Wed, Nov 20, 2024 at 06:20:12PM -0700 Jens Axboe wrote:
> 
>             On 11/20/24 5:00 PM, Chaitanya Kulkarni wrote:
> 
>                 On 11/20/24 13:35, Saeed Mirzamohammadi wrote:
> 
>                     Hi,
> 
>                     I?m reporting a performance regression of up to 9-10% with FIO randomwrite benchmark on ext4 comparing 6.12.0-rc2 kernel and v5.15.161. Also, standard deviation after this change grows up to 5-6%.
> 
>                     Bisect root cause commit
>                     ===================
>                     - commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard?)
> 
> 
>                     Test details
>                     =========
>                     - readwrite=randwrite bs=4k size=1G ioengine=libaio iodepth=16 direct=1 time_based=1 ramp_time=180 runtime=1800 randrepeat=1 gtod_reduce=1
>                     - Test is on ext4 filesystem
>                     - System has 4 NVMe disks
> 
> 
>                 Thanks a lot for the report, to narrow down this problem can you
>                 please :-
> 
>                 1. Run the same test on the raw nvme device /dev/nvme0n1 that you
>                     have used for this benchmark ?
>                 2. Run the same test on the  XFS formatted nvme device instead of ext4 ?
> 
>                 This way we will know if there is an issue only with the ext4 or
>                 with other file systems are suffering from this problem too or
>                 it is below the file system layer such as block layer and nvme pci driver ?
> 
>                 It will also help if you can repeat these numbers for io_uring fio io_engine
>                 to narrow down this problem to know if the issue is ioengine specific.
> 
>                 Looking at the commit [1], it only sets the max value to write zeroes
>                 sectors
>                 if NVME_QUIRK_DEALLOCATE_ZEROES is set, else uses the controller max
>                 write zeroes value.
> 
>             There's no way that commit is involved, the test as quoted doesn't even
>             touch write zeroes. Hence if there really is a regression here, then
>             it's either not easily bisectable, some error was injected while
>             bisecting, or the test itself is bimodal.
> 
>         I was just going to ask how confident we are in that bisect result.
> 
>         I suspect this is the same issue I've been fighting here:
> 
>         [1]https://urldefense.com/v3/__https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/__;!!ACWV5N9M2RV99hQ!PXJXp0zosonkV7jeW9yE0YL-uPElcYI-G-bvm69COWR1Tbl9w9puGc1tLR_ccsDoYPBb9Bs3waNVuuf9Lg$
> 
>         Saeed, can you try your randwrite test after
> 
>           "echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"
> 
>         please?
> 
>         We don't as yet have a general fix for it as it seems to be a bit of
>         a trade off.
> 
>     Interesting. Might explain some regressions I've seen too related to
>     performance.
> 
> 
> 
> References:
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/__;!!ACWV5N9M2RV99hQ!PXJXp0zosonkV7jeW9yE0YL-uPElcYI-G-bvm69COWR1Tbl9w9puGc1tLR_ccsDoYPBb9Bs3waNVuuf9Lg$

-- 


