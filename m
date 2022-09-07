Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D498C38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 06:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KElftQv1GOmAP81or2QifAkrWt9+9TmZ+Sosu0YbZvE=; b=uKzpUKeEZLdMUwEbO65NQU57rr
	uF/o24XFIKckkmIOemAckf2OGvPVeZ86k4l9q/oyi/27c3UmZFvlgBu7i72/WnNicH+u/Myjq1fi1
	bX6mwDqNkXCEXoMYxA4QKfwSYTYDGQjTuCzIttFUagZvBzz4kSIiWe/DakSOXRLm5jgYklvNlTe9Y
	Ggzg2cdHrCDwwE3BJbKjGFa9YBuSC7Mfar+vZyUDEZkiPFxMDptnv500pp5jvmg7dS2ZRWV1f/3UB
	0Ecs4vv3MTmZj0v74W1Y1czyklqBTaGoPHTT6VZ1ru3RTYHY/nf0AoiBQg7Wvcn24aoWtFlHBGdhV
	LvjYR3Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVowe-003OdY-VL; Wed, 07 Sep 2022 06:53:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVonO-003KJZ-0E
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 06:44:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B62C68AA6; Wed,  7 Sep 2022 08:44:18 +0200 (CEST)
Date: Wed, 7 Sep 2022 08:44:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Martin George <marting@netapp.com>
Subject: Re: [PATCH 1/2] nvme-auth: retry command if DNR bit is not set
Message-ID: <20220907064418.GA21620@lst.de>
References: <20220830124925.40711-1-hare@suse.de> <20220830124925.40711-2-hare@suse.de> <db927303-525f-6925-7b26-a0f4d8545dad@grimberg.me> <d13ce9ac-e851-369a-fe58-1bfebe5cb7c7@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d13ce9ac-e851-369a-fe58-1bfebe5cb7c7@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_234422_242643_7AD4BCBF 
X-CRM114-Status: GOOD (  13.31  )
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

On Tue, Sep 06, 2022 at 04:16:53PM +0200, Hannes Reinecke wrote:
>>>       ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
>>>                        qid == 0 ? NVME_QID_ANY : qid,
>>> -                     0, flags);
>>> +                     0, BLK_MQ_REQ_RETRY | flags);
>>
>> Surely there is a local way to have this than to leak a flag to
>> blk-mq...
>>
>
> Sigh. That was the first attempt I did. Which got rejected by Christoph, 
> who wanted to have it generic.

I think you and Sagi are talking about difference means of "local".
Your original version just retried in the caller.  Which is a bad idea.
The place where this code retries is the right one, and I think Sagi
agrees.  Abusing a blk-mq level flag for controlling this retry in core
nvme code is not, and I agree with the suggestion form Sagi.

