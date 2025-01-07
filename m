Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61485E7719A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GS1ScjfSNktWLHTP+v87aAWeEwnS7bOrCzMF7rqddYQ=; b=T8/vPR5v50IloKABuJcb7vsVNa
	ZNIv8GJOo70SFMb1m1KrhcR+rbkW7A4xaWMcbJfajikPx8nUXlA7xknN84488Gi4JI4cFHn0hvOrg
	M14v06XIuMMXKO32QxW9smlzz2n2fVDgJuUniZXMEfdNZzsDlmlYobH2sJ1J/80nbdmmLCUtIWaFi
	HxXVA8HmMYCn4OHbHrAvV3x7sB9jL8mwZ3K2gUo7LMhHgc6pEtxfVmNrDsT8yrzuusk1spPc4M/8W
	RBTq/Qow2KgIITvBUmPj9fpLg0oVsNTszrGiWm8140crw5aDrkOfM7c/V1ne1Q/Rn8goCW4RKjE+M
	iB2YDxlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6ll-00000004KLu-0qFx;
	Tue, 07 Jan 2025 10:25:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6Nw-00000004FLB-2Ooj
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 10:00:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E191D5C5D6A;
	Tue,  7 Jan 2025 09:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E30BC4CED6;
	Tue,  7 Jan 2025 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736244027;
	bh=lqv2dPlcm26U+MhnC+L7UtWKIn/g+usaTKVohReAGkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p2GYuq1vIzDhN7/wB2Kt1c6pdyVYofLr777705ynGJGNfbUCW9SrAdxP6RHps/AbE
	 9M0ln9Z4jvdNuZWck4sdsGiw5lapULOeoNpqn1ozha3AvmRCtlo+TE5B257a44K6aB
	 j/syb6Gi+5xuAkhzjkkblVdrVN+FCh7QUKpccpUn7lt31aeGBH7iAQ/Mj/1wmUThWI
	 OFG3kbx2mjeBg5xEZMOXzu0MYf738ERXUfP0XtfaD2jP/wYXKZc7RxfVkvoJQ2Kz6g
	 shVFdDwwdQyxjz13qMWGVMh49oi8HGNcp3CMHo0jwz/CRM7TnC1aGh/hyhYGGjF/bg
	 lplKfjA4e6LAA==
Message-ID: <f450d490-c820-47a4-8a29-316b6dab855c@kernel.org>
Date: Tue, 7 Jan 2025 19:00:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] usb-storage:fix queue freeze vs limits lock order
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-9-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250107063120.1011593-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_020028_655799_7DFA8523 
X-CRM114-Status: UNSURE (   8.02  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/7/25 15:30, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock using the
> queue_limits_commit_update_frozen helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

