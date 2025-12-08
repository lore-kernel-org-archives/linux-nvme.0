Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72382D3B7EA
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 19:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HDG2uAXVi3aBUveh41tkplU2mdOLTj6LlZHJwXiWifk=; b=TOdr6agYBMFDam80L0BxaqXyii
	y2+1EFFIzD9bq7zIn93zxJ9wyS9xQjvBtWNfjFYge44yRstduq+Bg8xqFUEDp4R12724kAgNhi1TZ
	OZHV7cCraIWzDgO+sUbw1Dq9pPz9f0JaC4UwuZkhCrXw/n7kVdtPA/buW9jhSF/7Z5Osdzv0tvRgu
	Uzv6cdvT39gVoCtbPuIAD6mSY5jKVavHZtT40VmWkB/Bk2PqUGi3zZNcA2v2pE/mzEKyhBYKrWonK
	0In0GS5KmTPhvKqpVtbs0GOvigNQQ28dd3HNyqmk7YiYcmBuLF4Rxi1ziC86nl5fy8ChGOEDu6rap
	RNqUwdyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSguV-0000000DT65-0eEB;
	Mon, 08 Dec 2025 19:28:39 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSguS-0000000DT5U-0S5m
	for linux-nvme@lists.infradead.org;
	Mon, 08 Dec 2025 19:28:38 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dQBq74rTlzllB6W;
	Mon,  8 Dec 2025 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1765222112; x=1767814113; bh=HDG2uAXVi3aBUveh41tkplU2
	mdOLTj6LlZHJwXiWifk=; b=b9fAYPbaqu7ggMD7kMyMnXKY7btF9Igt3HnAVlhq
	l6d8nhs+OaR90pdkfB4/yTy089e3+907XiWDXyiMTQifwBWa5sJihnrBm4Gzz3fz
	/oTULTg2YY37EGjOZsYgF5O+bxFQq8cM/FJJn9TOkk931ccSyxbyGh8tvZnJ8U4R
	gdPlkOxWYr4e8NEJqS4yGw45efTeDna8r9JZiOhgtIWdt7s/O2S4KOU9doIb0ptV
	eQmvi1zb8Bc0dVZO9UYhw/DpnKMAU7+H6Me2R/fY7f+pMVAozpCqTz52gzeToTGM
	kpRK+te3CvjrLESeUJ2ZsMEdRWkkGVAquNXbzexmdKHi9Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5RbHWmiYFzdk; Mon,  8 Dec 2025 19:28:32 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dQBq05xgrzllB6J;
	Mon,  8 Dec 2025 19:28:28 +0000 (UTC)
Message-ID: <3e559a9d-9867-4262-903f-d54e37141d38@acm.org>
Date: Mon, 8 Dec 2025 11:28:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
 <20251205211738.1872244-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251205211738.1872244-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_112836_172674_3EB4ED26 
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

On 12/5/25 2:17 PM, Mohamed Khalfella wrote:
> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> tagset, the functions make sure that tagset and queues are marked as
> shared when two or more queues are attached to the same tagset.

The above is hard to understand and probably should be split into two
sentences. Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

