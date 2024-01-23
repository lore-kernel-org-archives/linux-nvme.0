Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E136C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DUTuT3YWtZO4umiy/Y+WhSjGzAPutOLSE45WsEOBHMU=; b=YzMWhmWvHNl++u2hcLanb9Cglw
	JCt/nQ5MGu11WLMlQKFDvki24BnVM+E9uhEsdxU9aexP+cLrx8OuRXnvX5GhEI3BXv3UAlVNQFMzu
	CE+SGrTohFppvH2pqbD/W4VHd9I6dJbBj8CCGC2PdBdKkHzSS7/gRRMPYwF0iS/XKO5+NKqkkHBXY
	WoZArtfUugvjeOZUgtK/SLmPz6D8/YUfNcCdz/+jEPLL9LBwGjU+eivP5pr3+wkSbIpKPjAlSwTJP
	FGrWQA0Sf03//4ds7tUPy8amCmQimtPRcALEn2s6yJbURBX+OqGyxgd30yFprUfCkUSyXYFUyHy/J
	rqMwiDlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9Lh-00F9KT-1z;
	Tue, 23 Jan 2024 05:29:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9Le-00F9Jp-12
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:29:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9F58560B46;
	Tue, 23 Jan 2024 05:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A6FC433C7;
	Tue, 23 Jan 2024 05:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987731;
	bh=GuoueqnTFJPG1iNvVXaPu2ynYxAiDk0ADDDfkdnKKgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=umIknSPcCQME7cm1J4/2wqtlPNDKrz83Pt+L0nsAG1+hS5iMH1TDDtKGCJr+Akk+d
	 p0J6ZAop8LWHaa1kdEmVlHtc88GzDbMBtUGxGHSgA+wACrwF4FI0fGvB0f0Nxx+uMM
	 eJa4OmIgn38EVGajU2objX+8Fv+4IlTBbCSjJQnmYQ1WFQTJUkRZNY4GSYht+rm8gL
	 9Dg82aj5aooLS2A5BRHmHvyo5QkUeBgjWAxLJr8Yl9ilq7EFcx49Se81n24tUeyvhc
	 Qe6vKHhiY03C0BZpRdUBxJXge1MRrrSsNkIXJIdnL+T7r+Mi3p51VmFHcRTQ8twbQS
	 JLvHmD6GR+Jmw==
Message-ID: <d67be298-6e87-45e0-878f-c692b1ac9c99@kernel.org>
Date: Tue, 23 Jan 2024 14:28:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] loop: cleanup loop_config_discard
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-14-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_212922_409232_16C315F2 
X-CRM114-Status: UNSURE (   8.03  )
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

On 1/23/24 02:36, Christoph Hellwig wrote:
> Initialize the local variables for the discard max sectors and
> granularity to zero as a sensible default, and then merge the
> calls assigning them to the queue limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


