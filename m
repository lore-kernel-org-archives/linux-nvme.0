Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F62BC47E49
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35mM6I4/a8/AAfo6vEpCkUubuJeihuMJQkFca3EvMAM=; b=yDvfd+mEVk4ndKlRTWFPmHJmOT
	4Mrzk2U2kZ/RwMibqSDB1NeekYlao1L8R21pATlAlj1+1V1JijRsVvESFGjY/dSxFpgud6PrTLNxP
	sxNTcLuVm0gJ9pXMzEnT7DFC+2Xsc6RKvuXBsAIZcr2Idfc6MtF9mYvIRLx2s1yKumUrL7v+ZOtdr
	eN6al2TkI5AfnfdEUkBP6Orm/w9PyavSOjhinWUwO2o8QUxwD2Hnk1Ebi0BUMMCg0rAF+W+nH34J/
	xrghXz523uTmERskDuQmdUoEs2/vNMGVfRAjzZP/HGstxO6srA3wAnBJhF1XZbNyjvSr1Wf7+tZJV
	T3E5qcKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSiZ9-004oHo-2g;
	Wed, 24 Jan 2024 19:05:39 +0000
Received: from gentwo.org ([62.72.0.81])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSiZ6-004oFn-2m
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 19:05:38 +0000
Received: by gentwo.org (Postfix, from userid 1003)
	id C086040A94; Wed, 24 Jan 2024 11:05:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id BFEA640787;
	Wed, 24 Jan 2024 11:05:33 -0800 (PST)
Date: Wed, 24 Jan 2024 11:05:33 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Matthew Wilcox <willy@infradead.org>
cc: David Rientjes <rientjes@google.com>, Pasha Tatashin <tatashin@google.com>, 
    Sourav Panda <souravpanda@google.com>, lsf-pc@lists.linux-foundation.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
    linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
    bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
In-Reply-To: <ZbFPIidl6dK5cR0W@casper.infradead.org>
Message-ID: <52821f7a-bb6f-308c-38b0-e5e9904d4f8c@linux.com>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org> <b04b65df-b25f-4457-8952-018dd4479651@google.com> <Za2lS-jG1s-HCqbx@casper.infradead.org> <aa94b8fe-fc08-2838-50b5-d1c98058b1e0@linux.com> <ZbFPIidl6dK5cR0W@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_110536_916571_5EC99D43 
X-CRM114-Status: UNSURE (   9.09  )
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

On Wed, 24 Jan 2024, Matthew Wilcox wrote:

> On Wed, Jan 24, 2024 at 09:51:02AM -0800, Christoph Lameter (Ampere) wrote:
>> Can we come up with a design that uses a huge page (or some arbitrary page
>> size) and the breaks out portions of the large page? That way potentially
>> TLB use can be reduced (multiple sections of a large page use the same TLB)
>> and defragmentation occurs because allocs and frees focus on a selection of
>> large memory sections.
>
> Could I trouble you to reply in this thread:
> https://lore.kernel.org/linux-mm/Za6RXtSE_TSdrRm_@casper.infradead.org/
> where I actually outline what I think we should do next.

Ahh... ok. Will do.


