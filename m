Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02831C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 09:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:In-Reply-To:From:To:Mime-Version:Message-Id:Subject
	:Content-Type:References:Date:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rxSgwuGzIsEmyghbrvFjO2zv/MUWNeA+OR1hBhENbho=; b=AmtT6AntBxK7Q1wngReL2UjtMd
	E53Cpod70JTTykZ1YXobyVuIgmvsf7bOyWrMvswVmL93VqAYqKZvQoHqtREBCmUBVYG2RYduudisJ
	xD9XxBC2EeZ1bd0GAH6hM/pekPrn1PyEfxxhjSbXSO8LIjTSqFlbmFCPrqYhh7O5UyYbVsA+mvhQf
	gx716QFPqvNSExn07Lfad/IhGWQOhSowNDra7iez7XpejercWCd8ze07lgy/BeOidUcL5Nvs2ZQRR
	pmP5gi248xu8w9NOf0QNhvKrqkDvqGMA2SNfGR8OTJvqwGMpxFe3NOk9hmkQyiagsKEfHXKbp7cWH
	PPYuCE8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlOS-00000001nfj-1CYK;
	Thu, 09 Jul 2026 09:50:08 +0000
Received: from va-2-44.ptr.blmpb.com ([209.127.231.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlOQ-00000001ndL-25aK
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 09:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783590593;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rxSgwuGzIsEmyghbrvFjO2zv/MUWNeA+OR1hBhENbho=;
 b=PqNfl6kfcb7YydGxqmviNJtpbNIlE+Ie3+/dqo8uPbB4Pt6mk2zLIOxjC0WRw/gmcqeULc
 /gv/f7DHOmRX3g9ssWUL1aOR3+reHH/J1M5KHdaicddbPsYGO4eHcXwuGorpZm89JW1gH7
 vTWEf+45x74R9YH0wYw2/h2AbDf1jK03pFXZ9Z8TxG3WJ6ZQPCFazb6ZV0NQghPKVVu6V2
 9JkJMdStsk77hRJAdU0Jk+I67Fuw3/XYgcceCVvwoYSwor1OVDmfiYFs64HZwOp2bXLSoM
 YemL4DCzmLsex12QdK40QQVemyfhb872Mh71fF7rOFjIFTaS4UFI6Jr+8CJkzA==
Cc: "Jens Axboe" <axboe@kernel.dk>, "Tejun Heo" <tj@kernel.org>, 
	"Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, 
	"Alasdair Kergon" <agk@redhat.com>, 
	"Benjamin Marzinski" <bmarzins@redhat.com>, 
	"Mike Snitzer" <snitzer@kernel.org>, 
	"Mikulas Patocka" <mpatocka@redhat.com>, 
	"Dongsheng Yang" <dongsheng.yang@linux.dev>, 
	"Zheng Gu" <cengku@gmail.com>, "Coly Li" <colyli@fygo.io>, 
	"Kent Overstreet" <kent.overstreet@linux.dev>, 
	"Josef Bacik" <josef@toxicpanda.com>, 
	"Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>, 
	<cgroups@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<dm-devel@lists.linux.dev>, 
	"linux-bcache@vger.kernel.org Joseph Qi" <joseph.qi@linux.alibaba.com>
Date: Thu, 9 Jul 2026 17:49:47 +0800
X-Lms-Return-Path: <lba+26a4f6ec1+ae5674+lists.infradead.org+yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Thu, 09 Jul 2026 09:49:52 +0000
User-Agent: Mozilla Thunderbird
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-6-yukuai@kernel.org> <20260709061207.GC16504@lst.de>
Content-Type: text/plain; charset=UTF-8
X-Original-From: yu kuai <yukuai@fygo.io>
Subject: Re: [RFC PATCH v1 05/17] block: add bio_alloc_atomic() for atomic bio users
Message-Id: <1bf1939e-6a7b-4a8d-a316-96812cd6924e@fygo.io>
Mime-Version: 1.0
To: "Christoph Hellwig" <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
In-Reply-To: <20260709061207.GC16504@lst.de>
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_025006_614888_65A64AF7 
X-CRM114-Status: UNSURE (   7.45  )
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
Reply-To: yukuai@fygo.io
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

=E5=9C=A8 2026/7/9 14:12, Christoph Hellwig =E5=86=99=E9=81=93:
> On Sun, Jul 05, 2026 at 03:51:12AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai@fygo.io>
>>
>> Add bio_alloc_atomic() for callers that need a GFP_ATOMIC bio from the
>> default bio set but cannot safely pass a bdev during allocation. The
>> helper returns an unattached bio, leaving callers to set bi_bdev and
>> attach blkcg state explicitly before submission.
>>
>> Use the helper for virtio-pmem flush child bios and OCFS2 heartbeat I/O.
>> Both allocate bios from atomic paths and must avoid creating missing blk=
gs
>> once blkg creation is protected by q->blkcg_mutex. virtio-pmem clones th=
e
>> parent bio's blkg association; OCFS2 binds heartbeat I/O to the root blk=
g.
> Let's kill off the concept of atomic bio allocations instead.
> Joseph already has an outstanding patch for nd_virtio that needs a little
> bit more work, and ocfs2 should be easy enough as well.

Thanks for the notice and good to hear that. This will make this set much
simpler.

>
--=20
Thanks,
Kuai

