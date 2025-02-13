Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19580C021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mNvtysCKnSJQOOBHCoqk/LCqlR3UeGeWmQeJQTZazlI=; b=wWjEbQgLGiNt3zy3M+l37wU0oy
	FSpD720LKeO9TK+VTFtu30N28Yz1xzCffSoZIZmdFQYlSgEFi/0XQW1ALbhgs8KG9BHO99WrpP/Hd
	WGoLkur5gRCu20DlcSk4rWBIOv5uH21YcqIyyhh/VbZT2bMnUy0IZX3tZ5uPC8pYRoSkgIOx2fklQ
	w3V5kjD22R6Gz940N6GbJJ7FFZ07bH00l/BFewaaieHs9xfWNsJUqKos49/0pqB62CxUYmprNNUNb
	86+AB5BI4G4MdoQCVLTpi9Dua/ObKZF7yUS6/a9+bQ4lipfxSoaJ6GZOq5ceVuV/bqvKJ1gWpLOPc
	IJadn9PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSel-00000009vr8-2I6H;
	Thu, 13 Feb 2025 06:25:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSej-00000009vq8-2Ewh
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:25:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 54CB15C09ED;
	Thu, 13 Feb 2025 06:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8F4C4CED1;
	Thu, 13 Feb 2025 06:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739427900;
	bh=KjzybRVWtBB1jcf+OqFlxofYcSKym1afinO7ZoGwOGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fsVFn/BesQE+jkk//Zv98vIAgiHnWcSafiH+Cpc/JC5DblkI3UdtH71ia/yk7IOqK
	 aY9cKbXzznojIiEL4fnJpty9Q5HNcP07xJ2hObjbGm6dBaM/kIpvK2ZETpNKtPd6Me
	 5QcCAFkgw/dmftJ+Q0poW15DWCZF8DfQB7tSkllOSJAVdx97RK0sy3sd5u1pp9Wf9s
	 D0dxlMH4AecIGa5/7n/9pXLhzKvbbCWUs2FpDPw/bdRGghnlAEssoXbm/DPHsT/AR7
	 oVJZt/u9RKhb59k/bMGF1LS/CDOjdt8tMLKsDLHeqjXOaCSUslm2GP5krsCgbjfBd4
	 UsC4B6k8tECjg==
Message-ID: <0bbe229f-c00f-46b1-8b1b-736577b96b5d@kernel.org>
Date: Thu, 13 Feb 2025 15:24:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: Cleanup the definition of the controller config
 register fields
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20250210002935.1744249-1-dlemoal@kernel.org>
 <20250210002935.1744249-2-dlemoal@kernel.org> <20250213060051.GD19506@lst.de>
 <9455ccc9-75d4-4329-938f-e5691d92caa5@kernel.org>
 <20250213062329.GA20095@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250213062329.GA20095@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_222501_635764_DA4F9236 
X-CRM114-Status: GOOD (  12.69  )
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

On 2025/02/13 15:23, Christoph Hellwig wrote:
> On Thu, Feb 13, 2025 at 03:07:51PM +0900, Damien Le Moal wrote:
>> I find the single enum for all the fields of the same u32 register to be a nice
>> grouping of things. But I agree that more comments would indeed be nice.
>> I can add that. But do we really need separate enums for each field ?
> 
> Ah, not really for each sub-field.  But the nvme code traditionally
> also used a single enum for multiple register or struct fields.  If
> I read this to quickly and that's not the case here all is fine.

Yep, the enum I changed is only for the CC register. Nothing else in there.
So I will just add comments.


-- 
Damien Le Moal
Western Digital Research

