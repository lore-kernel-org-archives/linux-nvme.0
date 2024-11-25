Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765ABD3B7E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=18IGRqr2sH18Yw8Dns6wwvEbCyz0frk0N+Mj3sUT6dw=; b=Y+QXymU5UXCIaN7EWbSgWTf8d6
	9bKxRjiECSy1BZ3loA0bblWBC4AbHQxbR73xEx3hf+qxiOJLV7kYf8zlc8+JimUUteEKzxKG0fEj+
	gFpjooh0VwGG7PsbrIxujgS32tvUksE6Qwp0FdSypDrS9bn9DopwJX11R0ghV76L9xPtED4pHdIC+
	ijL0IQsM65KrS9RWozQ7ucVeRrsDQIrnGL1oHsF4U6QkyBhhegiC4SHJsigYHSeoqYblL0mzHvOOL
	G3Y3Atfn/kB3buXMIFdZuoVN3k8zQX7kcBNWjdkpOerMQARRJt8Pb28PAsGZziIdsm/4szbAl9Tuh
	UPdC0Buw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFT24-00000007CZn-38RL;
	Mon, 25 Nov 2024 06:57:16 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFT21-00000007CZ8-3Hkj
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 06:57:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732517832; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=18IGRqr2sH18Yw8Dns6wwvEbCyz0frk0N+Mj3sUT6dw=;
	b=Fyhk3tYE+6VDaaIffUOg+tnLMTVKbEkK6luRtF14H0SAH3V+orjSYp2K+uGRVmqBiw10uWXInYg1Xyq0AnnrDmKnWyuw0cSxFfAFMvAAnadTj8ciRCGOClh6TIgqB6mLhMR+gTt/KBKgF31rZEzjjHwgsaD4zecP7WpbCxu89IY=
Received: from 30.178.81.212(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WK76qF9_1732517829 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Nov 2024 14:57:10 +0800
Message-ID: <9918cd94-9998-451c-ba43-1119f5f05d94@linux.alibaba.com>
Date: Mon, 25 Nov 2024 14:57:09 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet: handle rw's limited retry flag
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241121102454.122247-1-kanie@linux.alibaba.com>
 <20241122120959.GA25831@lst.de>
 <a336007f-88c1-41e3-826b-e080a4d78213@linux.alibaba.com>
 <20241125065617.GA15161@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241125065617.GA15161@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_225714_132004_ECB62629 
X-CRM114-Status: UNSURE (   4.25  )
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


在 2024/11/25 14:56, Christoph Hellwig 写道:
> Can you add this to the commit log, please?

Sure, I will send a v2 patch.

Best Regards,

Guixin Liu


