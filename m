Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFBFC44501
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 09:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	References:Cc:In-Reply-To:Content-Transfer-Encoding:Subject:To:Mime-Version:
	Message-Id:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HOGu0DcVoj6IGMDLrDh2fK8YIc1W/aNya5uNQNN/KKs=; b=H/bU/jSF/JrY7cdvYKkG3MnTHq
	KmkSu3uMl6yUkrNBTK/SZA342PjtOuEmRCiKepBlAD64lmHl0xNkPZr7cGJNwp2x1sOun8Kq56/7n
	6h3FiZWIh0rZphsnuGJlTTGFeW0MsVN2KJ3+g6o41Maea9UT2rv6MgHLibCxXXao4+iRcOmJN3H2N
	++OHUpNWqpEeXNWvEPawe2nzVkA1vlC6OheZbAphqlVpWltVbT2xm1Fkg7aE0y4KlGm4a+N0RGh/C
	JKHt/GlsJJpoZBnEcKScAY6zSNxnoNbCy5Yr7OUoL4v1aQIW+mi6JdjZQYcNOd77/NnkgxLCEHmij
	8k1Kl1OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlVe-00000001ofp-31Gb;
	Thu, 09 Jul 2026 09:57:34 +0000
Received: from va-2-48.ptr.blmpb.com ([209.127.231.48])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlVb-00000001oeH-2G8o
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 09:57:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783591040;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=HOGu0DcVoj6IGMDLrDh2fK8YIc1W/aNya5uNQNN/KKs=;
 b=GKr+YBcv0NFr3xoiiCd7poxeeFYuqJw3Ssw/t0vRxeohJnXWLEBUUOLgO4sXJvs/1SWT9j
 ZjAdreVVOJuzGQofpZTmAECG0IVX0xb/2EZchMjOa25K4U3p/VEECoRuxp/GwjnN9rV5mQ
 QcG6NulqKgrLJ+rsthrOPE4LYVv7KdtDhauSFIKDpX3ekCGczn3YHRNRckWIOxRxMU/EPD
 JcFdw8uQjIeirkRxl3Lz3rf71q53c39Up0LgV2lwdH76qMdIPOFoznH5Dmyr7qh6Q48G3z
 9oaQJAfdFBbzY0+QLFjjE2rqf5YXQB+smaNvRxLDvDeXpzmRNtBc4zbEhi+CEw==
From: "yu kuai" <yukuai@fygo.io>
Date: Thu, 9 Jul 2026 17:57:13 +0800
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Thu, 09 Jul 2026 09:57:18 +0000
Message-Id: <e2ae59dc-14b9-48fa-a945-0b15acff338d@fygo.io>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a4f707f+db77d1+lists.infradead.org+yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
To: "Christoph Hellwig" <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Subject: Re: [RFC PATCH v1 15/17] blk-cgroup: remove blkg radix tree preloading
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260709061837.GF16504@lst.de>
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
	<dm-devel@lists.linux.dev>, <linux-bcache@vger.kernel.org>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-16-yukuai@kernel.org> <20260709061837.GF16504@lst.de>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_025731_637458_C69F07C4 
X-CRM114-Status: GOOD (  10.33  )
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

=E5=9C=A8 2026/7/9 14:18, Christoph Hellwig =E5=86=99=E9=81=93:
> On Sun, Jul 05, 2026 at 03:51:22AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai@fygo.io>
>>
>> blkg creation is now serialized by q->blkcg_mutex and no longer runs
>> under q->queue_lock.  The radix tree is initialized with GFP_NOWAIT, so
>> radix_tree_insert() cannot sleep while blkcg->lock is held and the old
>> preload dance is no longer needed.
>>
>> Remove the preload calls and the associated unwind path.
> Isn't the GFP_NOWAIT a bit of a problem because it can fail way too
> easy?

I think GFP_NOWAIT should not be a problem because it's only possible to
allocate blkg when the thread is issuing the first IO. And it's not a big
deal to fail nowait in this case because the caller should fall back to
sleepable context to issue this IO, and then blkg will be created. The foll=
owing
nowait IO issued by this thread should no longer hit blkg allocation path
anymore.

>
> What about converting both the radix tree and list to an xarray
> using the internal xarray to deal with sleeping allocations?
>
--=20
Thanks,
Kuai

