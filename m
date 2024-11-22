Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A6CD75E30
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FgF8xyhSodxEkX7852xSiCfTvnMhIGwCQQ9kBHCCs6I=; b=Tx6Q2XWfiQvIqFKmRZdnXDjizM
	O/26Zu74bgi52qiLpFPEQ3lmM09pbm8ZuUGy5st7GTW6Nm5u1paixmnHOrk2miZPm7Gpx4zc2H92m
	zY4s18xOY6vrsNqKrQNjlt5ACWaqhqmb7rEi0a1D6fnnKjCGMJV1LsZbH9ZX5J8MsrSx3C8ha+3mw
	+mJKPCD2V8/Ta+SEMLeVaLzMlWFciXqMrXazPpGuJrcbdiy4qGAHcHD+tTSnzMYGt0/NYmIExsKn1
	Znfi0shOfy4ZGfaqQQ6ITGFo17ZMF+RddvBXFhfk5Q0hB1cIan/OWuI3bMwJDyNrfu1HkVhSXlNfT
	zxL5yC9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tESX8-00000002Qg4-09gX;
	Fri, 22 Nov 2024 12:13:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tESX5-00000002Qff-3Hf8
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 12:13:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EB1168D0A; Fri, 22 Nov 2024 13:13:04 +0100 (CET)
Date: Fri, 22 Nov 2024 13:13:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paul Webb <paul.x.webb@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>,
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
Message-ID: <20241122121304.GA25877@lst.de>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com> <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com> <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk> <20241121113058.GA394828@pauld.westford.csb> <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk> <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_041307_987097_C1604E30 
X-CRM114-Status: GOOD (  16.81  )
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

On Thu, Nov 21, 2024 at 09:07:32PM +0000, Paul Webb wrote:
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

Thanks!  So 6.11 actually enables write zeroes for your controller.

> Another interesting datapoint is that while performing some runs I am 
> seeing the following output on the console in the 6.11/6.12 kernels that 
> contain the commit:
>
> [  473.398188] operation not supported error, dev nvme2n1, sector 13952 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0

.. which it doesn't handle well.

> [  473.534550] nvme0n1: Dataset Management(0x9) @ LBA 14000, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR

.. and interesting this is for a Deallocate, which should only happen
with the quirk for certain Intel controllers from the very first days of
nvme.

What controller do you have?  Can you post the output of lspci and
"nvme list"?


