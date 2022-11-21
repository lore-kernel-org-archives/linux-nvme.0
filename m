Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C59C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mi5AOnkNDd5+Yw+FClfum/TPQGJ1wsJfNK1UjN5PLpY=; b=JjB1DrVwQefhxWCSb0nTEaWoxz
	IwVu1VnEamX3EVc7oZBVMGc86275B9r/mk25Hdl6lR+ICRZ8my8mIxB+WNA56N/KC59rLu1lCOUgh
	QBr2Xs8vqFOGo1rbFQKAlmYBf8JQJBQ9akElucpwiaOg57/8yNAXgPSYCZsQReGlE1TwUAZPicf2L
	2bQ0IJY+XV9bSKaQZp8Mgr6VZCu+7TKECnyBfIcg9+CT88H8ocb+Zv3yCacp2jRaQR/JDCZ8doxLO
	3QJqlKvYI5Du2zWXZdBrCexasQsfOcikFYfxheB7iG6aoHtNx+Pi5mCQCn1nLDOe8pAH/S52384cG
	6VeQ7TXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxFNQ-000pd1-BS; Mon, 21 Nov 2022 22:34:56 +0000
Received: from out0.migadu.com ([2001:41d0:2:267::])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxFNN-000pbN-Bb
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 22:34:55 +0000
Message-ID: <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1669070087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mi5AOnkNDd5+Yw+FClfum/TPQGJ1wsJfNK1UjN5PLpY=;
	b=gEGNcd8+SurevPmIEcSmpmYBwWGnRLMXmOL8nUq3XOjVb0tJtb44Ajoy8xHkV5L8po5z64
	lSXbiOCb9t9HgOj/6TRHl3xuLs7D34tZrXupBZz8p2DsnRMe/htuTjJpjwc6BonJ33LUUH
	tXQsG5modsChaFE7JXeJRmbR1MGX1iE=
Date: Mon, 21 Nov 2022 15:34:44 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
 <Y3vlsF7KcRrY7vCW@kbusch-mbp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <Y3vlsF7KcRrY7vCW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_143454_141531_99E52102 
X-CRM114-Status: GOOD (  19.14  )
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



On 11/21/2022 1:55 PM, Keith Busch wrote:
> On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
>> I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
>> reliably segfaults my QEMU instance (something else to look into) and I don't
>> have any 'real' hardware to test this on at the moment. It looks like several
>> passthru commands are able to enqueue prior/during/after resetting/connecting.
> 
> I'm not seeing any problem with the latest nvme-qemu after several dozen
> iterations of this test case. In that environment, the formats and
> resets complete practically synchronously with the call, so everything
> proceeds quickly. Is there anything special I need to change?
>  
I can still repro this with nvme-fixes tag, so I'll have to dig into it myself
Does the tighter loop in the test comment header produce results?


>> The issue seems to be very heavily timing related, so the loop in the header is
>> a lot more forceful in this approach.
>>
>> As far as the loop goes, I've noticed it will typically repro immediately or
>> pass the whole test.
> 
> I can only get possible repro in scenarios that have multi-second long,
> serialized format times. Even then, it still appears that everything
> fixes itself after a waiting. Are you observing the same, or is it stuck
> forever in your observations?
In 5.19, it gets stuck forever with lots of formats outstanding and
controller stuck in resetting. I'll keep digging. Thanks Keith

> 
>> +remove_and_rescan() {
>> +	local pdev=$1
>> +	echo 1 > /sys/bus/pci/devices/"$pdev"/remove
>> +	echo 1 > /sys/bus/pci/rescan
>> +}
> 
> This function isn't called anywhere.

