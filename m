Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B655C43327
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D840VFEVgPNYwMMZypjFrPBEq/0kLAE/iZ7hhiKqImY=; b=kYub3lEhAxM29+znDM9RWoYkoj
	6vz3gt64o5WvMAPtT1GFB70/yLMdzY2yiigxDcTuyUrzLJkhHol7sD/QWCvdry8NRbLdAHQZqEFus
	l52eRmySL8NVcVqSDIDDPrWI+kjfjZdwPjiF5rXol0JKnXFf0MkRMMQZomHhdFSUIw+6sKPgC8RXV
	XI/FvOdvL+eWjAP0kDMjCS1/cpoiAqm8j4mLHS4H59Blk2LSsXJO93G1jtYt9gp0TLOdFqGxAVufe
	paFSzBFhLS6m4HB3gDgq6b+tFBa5LaHDIel4X9C8gzFXoAjCSUiDofAvAigDHobS7s3dzea8lfGDn
	Ax3Kg0jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBPJ-0000000EcJu-0ueu;
	Mon, 29 Jun 2026 12:48:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBPG-0000000EcH4-2OxJ
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 12:48:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCC7B68B05; Mon, 29 Jun 2026 14:48:07 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:48:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 11/17] nvme: add Clang context annotations for
 nvme_queue::sq_lock
Message-ID: <20260629124806.GD23417@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-12-nilay@linux.ibm.com> <20260626064721.GA11106@lst.de> <CANpmjNNc0YaFWv9yW_AT3fPX1cOY7k5no2kKqvSTijnp_GV=Gw@mail.gmail.com> <09fb5b3d-e5d0-4c7b-a333-9ca51286929b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09fb5b3d-e5d0-4c7b-a333-9ca51286929b@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_054810_764885_B504145D 
X-CRM114-Status: GOOD (  13.93  )
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

On Fri, Jun 26, 2026 at 08:42:04PM +0530, Nilay Shroff wrote:
> On 6/26/26 3:20 PM, Marco Elver wrote:
>> On Fri, 26 Jun 2026 at 08:47, Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> On Sun, Jun 14, 2026 at 06:45:26PM +0530, Nilay Shroff wrote:
>>>> Accesses to sq_tail used solely for tracing are annotated with
>>>> context_unsafe(), as they only require a lockless snapshot of the
>>
>> This sounds like an intentional "benign" data race...
>>
> Yes, agreed. For the tracing case this is an intentional data race,
> so it can simply be written as:
>
> trace_nvme_sq(req, cqe->sq_head, data_race(nvmeq->sq_tail));

Sounds good.  I didn't know data_race already knew about context
tracking, so this is a good solution.


