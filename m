Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E6C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 08:32:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F260E2078D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 08:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="15idEfnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F260E2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VN3TsXnPBCm5AZr3IhOs9Si+5ZOHREETMT3LeecGeIc=; b=15idEfnGG8xCx8KqLZaKyI4Sp
	otyzBf1xZBuj9qAOOPhdD/0lCrWFQFQiYUcjnFhmiGlRKvIoGV29OkmzGVkdpVig0ykfnp8B5f3tf
	swcrURQiZ+A6IM/pkaU2heirY7UYnTLG6cjbUnXcjg5ChFDMSpN/nMXvSuz8/C7AbQQ3cJxuZhk+h
	KZYg0u4fdPQbNBxqHc/nbbHmZcdfNyPFI3uoevJPg6up8UFYj24REgiPLlE/PBcdmlHFus5dl+b63
	b6qx8lKZwpqEYWpVcc4AwbcTN8fMYoOLyOc3ShZNNH3P0pJmOWol29aoEsyTkKmfZCKDYONz6SCh8
	JdU3iM8og==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPLvB-0000ER-Lm; Mon, 05 Oct 2020 08:32:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPLv0-0000D7-Fr
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 08:32:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F222067373; Mon,  5 Oct 2020 10:32:20 +0200 (CEST)
Date: Mon, 5 Oct 2020 10:32:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 10/20] nvme: freeze the queue over ->lba_shift updates
Message-ID: <20201005083220.GA14548@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-11-hch@lst.de>
 <39b98188-2803-2f49-e225-8d3fbe3bfb1f@grimberg.me>
 <20200929183214.GD12948@lst.de>
 <e6c5bbb7-ea1a-b449-541d-2c8317ed462d@grimberg.me>
 <73932a4a-8618-5058-3d1d-434cf934aa18@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73932a4a-8618-5058-3d1d-434cf934aa18@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_043226_652781_BAAECD77 
X-CRM114-Status: GOOD (  13.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 02, 2020 at 09:03:26AM -0700, Sagi Grimberg wrote:
>
>>>>> Ensure that there can't be any I/O in flight went we change the disk
>>>>> geometry in nvme_update_ns_info, most notable the LBA size by lifting
>>>>> the queue free from nvme_update_disk_info into the caller
>>>>
>>>> The queue is frozen on the queue logical block size, why should
>>>> we care about I/O while ns->lba_shift?
>>>
>>> Because we use it for all kinds of calculations in the I/O path.=A0 By
>>> moving all assignments into the frozen queue critical sections we
>>> avoid all possibly inconsistencies.
>>
>> I'd think that it would be better to never use ns->lba_shift but rather
>> the request queue block size and keep the queue freeze span only
>> that mutation.
>
> ?

So that we'll need to multiply instead of shift in the I/O path?
Maybe we could add a shift in the queue, but that's a much bigger
change..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
