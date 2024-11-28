Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F6AD690EC
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzaxmEhR5CfGB6TmjpDVI/DZLl1RdjriSzUy+rjS0w0=; b=yN5NfS1mtPuWgPHjrTS1GJ3t7J
	EOvyRN150hRioY+wK5eEwWyJoZdmawwjhlXlB99ODIeP7AqiTjeIOrVt/AAwY0h8E4xuG+aE1TvMk
	l1YhKVIhmMu/S/WIGmp8d1DggGsMCB5o4RwygyiIPs9rKdqqaouPdYmaHBRVfQOPkMDLPzioT15+w
	XXW+2s3p3CQ+Bja0Aflr8Yf32Zg+wwGkmWAdKqkaYBwdTnTBz7nEMsJHaWDauxQVt2dJQ1wH4Kds/
	F/MQShgMokGoUM7polug7aKAoYuLJDTZ/oqj9N/B/OgmV89cBKI1wGScLdpMKlu3inzFhP1e46NCB
	Q1UhkS+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGaKi-0000000F5Jm-1ODr;
	Thu, 28 Nov 2024 08:57:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGaFg-0000000F4Mu-3AHX
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 08:51:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D06AF5C5A10;
	Thu, 28 Nov 2024 08:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FE4C4CECE;
	Thu, 28 Nov 2024 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732783915;
	bh=IvK1zy/sYlcAsuAagh9WHWt5pI9LVrBWaIhMoNQD9O4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=huPUraNVdlRnc/8SRCQCbFMy8iYIjMB3PAVtxdtrPxXEKBIuk8JVyvQSXKpsyKWuo
	 SvcCUUNE7HC9Ow0pgQqrcSsjRWVD1P/g2f9kgyvtxjXhKVQQl/WoCSjhSVqKvly84z
	 +qbNSYVsjzMQgKzuLerNaymQkOu7/fWI3nFulGMiuFWVjbrMT24B6c3AJbjRYBI9+k
	 2CtCUhK0Q8s7rUZJyzmT8ZAu2XK9xcYNoRWhvchpzCiitbGPplCghEKZHDly179oyw
	 92xIUGP8xGw+tApw4velQg0xPNtB+McQCWkzpwfXXOLdLYy+5+ZsUJFbkvIjOuZIee
	 lCIVOIxNTujeQ==
Message-ID: <9e9ca761-6356-4a97-a314-d08bd5ea0916@kernel.org>
Date: Thu, 28 Nov 2024 17:51:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp>
 <20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp>
 <CGME20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a@eucas1p1.samsung.com>
 <Zy5CSgNJtgUgBH3H@casper.infradead.org>
 <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
 <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
 <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local>
 <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
 <20241112135233.2iwgwe443rnuivyb@ubuntu>
 <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <7835e7e2-2209-4727-ad74-57db09e4530f@acm.org>
 <yq1ed2wupli.fsf@ca-mkp.ca.oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <yq1ed2wupli.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_005156_892442_8E995BDC 
X-CRM114-Status: GOOD (  30.55  )
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

On 11/28/24 11:09, Martin K. Petersen wrote:
> 
> Bart,
> 
>> What if the source LBA range does not require splitting but the
>> destination LBA range requires splitting, e.g. because it crosses a
>> chunk_sectors boundary? Will the REQ_OP_COPY_IN operation succeed in
>> this case and the REQ_OP_COPY_OUT operation fail?
> 
> Yes.
> 
> I experimented with approaching splitting in an iterative fashion. And
> thus, if there was a split halfway through the COPY_IN I/O, we'd issue a
> corresponding COPY_OUT up to the split point and hope that the write
> subsequently didn't need a split. And then deal with the next segment.
> 
> However, given that copy offload offers diminishing returns for small
> I/Os, it was not worth the hassle for the devices I used for
> development. It was cleaner and faster to just fall back to regular
> read/write when a split was required.
> 
>> Does this mean that a third operation is needed to cancel
>> REQ_OP_COPY_IN operations if the REQ_OP_COPY_OUT operation fails?
> 
> No. The device times out the token.
> 
>> Additionally, how to handle bugs in REQ_OP_COPY_* submitters where a
>> large number of REQ_OP_COPY_IN operations is submitted without
>> corresponding REQ_OP_COPY_OUT operation? Is perhaps a mechanism
>> required to discard unmatched REQ_OP_COPY_IN operations after a
>> certain time?
> 
> See above.
> 
> For your EXTENDED COPY use case there is no token and thus the COPY_IN
> completes immediately.
> 
> And for the token case, if you populate a million tokens and don't use
> them before they time out, it sounds like your submitting code is badly
> broken. But it doesn't matter because there are no I/Os in flight and
> thus nothing to discard.
> 
>> Hmm ... we may each have a different opinion about whether or not the
>> COPY_IN/COPY_OUT semantics are a requirement for token-based copy
>> offloading.
> 
> Maybe. But you'll have a hard time convincing me to add any kind of
> state machine or bio matching magic to the SCSI stack when the simplest
> solution is to treat copying like a read followed by a write. There is
> no concurrency, no kernel state, no dependency between two commands, nor
> two scsi_disk/scsi_device object lifetimes to manage.

And that also would allow supporting a fake copy offload with regular read/write
BIOs very easily, I think. So all block devices can be presented as supporting
"copy offload". That is nice for FSes.

> 
>> Additionally, I'm not convinced that implementing COPY_IN/COPY_OUT for
>> ODX devices is that simple. The COPY_IN and COPY_OUT operations have
>> to be translated into three SCSI commands, isn't it? I'm referring to
>> the POPULATE TOKEN, RECEIVE ROD TOKEN INFORMATION and WRITE USING
>> TOKEN commands. What is your opinion about how to translate the two
>> block layer operations into these three SCSI commands?
> 
> COPY_IN is translated to a NOP for devices implementing EXTENDED COPY
> and a POPULATE TOKEN for devices using tokens.
> 
> COPY_OUT is translated to an EXTENDED COPY (or NVMe Copy) for devices
> using a single command approach and WRITE USING TOKEN for devices using
> tokens.

ATA WRITE GATHERED command is also a single copy command. That matches and while
I have not checked SAT, translation would likely work.

While I was initially worried that the 2 BIO based approach would be overly
complicated, it seems that I was wrong :)

> 
> There is no need for RECEIVE ROD TOKEN INFORMATION.
> 
> I am not aware of UFS devices using the token-based approach. And for
> EXTENDED COPY there is only a single command sent to the device. If you
> want to do power management while that command is being processed,
> please deal with that in UFS. The block layer doesn't deal with the
> async variants of any of the other SCSI commands either...
>


-- 
Damien Le Moal
Western Digital Research

