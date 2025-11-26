Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EFFD10390
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JBejsC+JPhSGeQtZPmZRWV9tCCyalitmA1XjJ7nCkss=; b=1GwV3Tjglk8r16cxa/GHEzKKxW
	k+/x4ZWDHea0EY1ZTR10iBENUGRiDzeA/68CkJ28Gd5DnjCmVTHSj00fTEzCQ+l2geMyD0pE3TQVw
	ITJOn3ehpjWWZVU3x2xauVE2MD6rsLZFOH8JagF7CxcLvuNNTQeCx0ibnPq5XlP1VHCiKQGS/rL74
	h8EmIILalKio/RGoYH5d8CM8j0jhQzk69qumVK+ZzEmprCv1K2DpIJb9IXKtC7OND8IIQHWFmG+6q
	NH058Busn26Ju2wdjYGPnYE4Q92RqNNdnuwe3bCxe35I84u45ciDG/0Lu9/cbIdiuOPGzSFNLi1lm
	zOc/oJ0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBrW-0000000EiMX-14D3;
	Wed, 26 Nov 2025 09:30:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBrU-0000000EiMP-3pro
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 09:30:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EA95D6016D;
	Wed, 26 Nov 2025 09:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F28C113D0;
	Wed, 26 Nov 2025 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764149452;
	bh=rvAFQp/faQsWmqG5lWB+/qsMqMuI5z5YHmDfU6uEkF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tfamtFo1RaMpb1YTFVTdd+c4JdiuPUAKmY22K0Bh+XtC7jGR9e5K/FItW6P+de8Ca
	 2xrkw4O2ZmB39hfCmDLis+XMDtlSIKs9cGW8mk7RZLGTUy7GLCEL+7D5hrzbRamwaJ
	 T8+zsGzGW/+Sxg/LKtfoH6Mk5wSQcRfPYhLoo2KcxiLn3iPqZJ0apjkthqfGtVBW+y
	 UeY1uy/gVK+RcmZraH3A8sERKIi5Y7XKc4qj2I2yHfDGa17BbRWh/Z607juBkN8MZC
	 UivIL3OEC4ViCjB1l0qBIeKQUheEiGzY15J7HRY8FCx1iv2/aoIW3iOwpkZG3tDWJx
	 hbjU2ly4jHJsQ==
Message-ID: <7cec7231-33f7-44ec-b82e-f12fba15392f@kernel.org>
Date: Wed, 26 Nov 2025 18:26:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
 <20251124025737.203571-3-ckulkarnilinux@gmail.com>
 <2f356d3564524c8c8b314ca759ec9cb07659d42a.camel@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <2f356d3564524c8c8b314ca759ec9cb07659d42a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/26/25 8:41 AM, Wilfred Mallawa wrote:
> On Sun, 2025-11-23 at 18:57 -0800, Chaitanya Kulkarni wrote:
>> __blkdev_issue_discard() always returns 0, making all error checking
>> at call sites dead code.
>>
>> For dm-thin change issue_discard() return type to void, in
>> passdown_double_checking_shared_status() remove the r assignment from
>> return value of the issue_discard(), for end_discard() hardcod value
> 
> Hey Chaitanya,
> 
> Typo here s/hardcod/hardcode. Otherwise, with the split as other have
> suggested:

s/hardcod/hardcoded

> 
> 
> Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Regards,
> Wilfred
> 


-- 
Damien Le Moal
Western Digital Research

