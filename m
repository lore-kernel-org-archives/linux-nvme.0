Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ED0C9833F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PuVEngSQheLYbH2VdZ2dStj0xXMV8yzBD03OSKW1OAA=; b=rkAw/G3qOZhhZASH5LdbV2IhJ4
	7QHtowtBnYlg5I3cyyvpF0GiXcJ+BaRfSD9y6HvPO7Ume3n/3RveFLQVwtDraze+EyvY9gfyuAzu5
	N6r0JW6A8DeggEyJvOLZgNBccXvbmQ73fJdp1Xhxm8RiOfPcAV5u9fYrD6RC1ZKoIdyqptjdA484Q
	Z5KTLfvmEHlFKEWjcAxVFdcmVZPAiOJdZ2VY1KUcxDkFpKACMhGsdYeU/eMpkja/hHEJIQHzWlLzc
	NOLPxChpQ2F9QMSRXLVwNImyebqwSCeG1yh4hjydbKLmR8n8esUuMYS1h8C5AlxGOL7+D2FwyadDU
	GMlByBKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB8Q0-00000000KUf-30aA;
	Mon, 28 Sep 2026 10:17:08 +0000
Received: from out-27.mta1.migadu.com ([2001:41d0:203:375::1b] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB8Px-00000000KU6-0fiq
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 10:17:06 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=S7HtiBzV+yUVKZNtjNQwGaJxuNAlauHZCZOJNOl8s7s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790590621; v=1; x=1791195421;
 b=Y6upoHwc6VjsB+I/0qej22oAk62TU/tvo3je1v8OdNaw4n+f20gmyR+sJ2P+R92+2R7oYQlZ
 NxFhL9++y/+h1VTBzeq2imwKUQQwd5DwQKoqHhx7M658X3EPbs11NVHKdbqvNHibpHtub8GgGyj
 GKw9cSCKQE6r812oopxQ1Hvg=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 951cb6a3c28291de;
	Mon, 28 Sep 2026 10:17:00 +0000
X-Mizu-Trace-ID: 951cb6a3c28291de
X-Migadu-Flow: FLOW_OUT
Message-ID: <2258be48-9e35-4139-b423-82400746db8c@linux.dev>
Date: Mon, 28 Sep 2026 11:16:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] fix NVMe multipath partition diskstats
To: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260921083752.1154316-1-john.garry@linux.dev>
 <5fe0a938-aaf4-46cb-8fba-3524586ac5b4@oracle.com>
 <20260928091428.GA29876@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260928091428.GA29876@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_031705_365871_DCE08DD3 
X-CRM114-Status: GOOD (  11.28  )
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

On 9/28/26 10:14, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 08:30:10AM +0100, John Garry wrote:
>> On 21/09/2026 09:37, John Garry wrote:
>>
>> A reminder on this one ... or are we just going to leave this broken?
> 
> I find the amount of overhead and relatively invasive code very
> offputting, and I still don't understand why we now have a strong
> urge to address this after 10 years.

Nobody noticed (that the values are not maintained), I guess.

It may also be useful to have the per-path disk partition table in 
future for other reasons.

Anyway, your call, so I'll leave it for now.

