Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F05C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 05:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x3CdUsIbYGNyvw50qdPV+8GGHAqPpR0OCLhptpB4Uzc=; b=Fi54YlPA57YSE977fOU4TM3axv
	SEzklKl1OhOiKOHue5yv5d6NRAYOciIS67Sl+CktED50dNZg4KCoxxP5y2fBOUQbUOjy3DiuufZM+
	JnzZvRNeu3JrY8GaB1p4Ce68j7BdtZPxnwhoc7BWc3hXeq43zwdVudHNXmgOqm9VOKeJww1+xw7Qg
	U+Z6wM+w+MXsrbiN9yKKUPLESNEPzXkvNbqakjba37JkcHswd/zs3H09FYBfcMmGJ4qCkhCIgyxx0
	v5zPOHErLuaZ3HtDT5GFjsL/yya9pXJrWGinGAjl6M5+Fio2xCGvhdjU9vQyZWdMKBrNyJEzKzYA+
	DrBRd/Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4mX-0000000E5Mq-2thZ;
	Wed, 14 May 2025 05:35:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4mV-0000000E5MH-2YbY
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 05:35:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F0CF68AA6; Wed, 14 May 2025 07:35:47 +0200 (CEST)
Date: Wed, 14 May 2025 07:35:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org,
	kch@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v3 2/2] nvme: all namespaces in a subsystem must adhere
 to a common atomic write size
Message-ID: <20250514053546.GA24782@lst.de>
References: <20250508223802.277311-1-alan.adamson@oracle.com> <20250508223802.277311-3-alan.adamson@oracle.com> <9ae170fd-0f27-4da7-b475-61530b061c85@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae170fd-0f27-4da7-b475-61530b061c85@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_223551_791014_D5AF0FC9 
X-CRM114-Status: GOOD (  18.74  )
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

On Tue, May 13, 2025 at 10:45:33AM +0100, John Garry wrote:
>> +		 * Set subsystem atomic bs.
>> +		 */
>> +		if (ns->ctrl->subsys->atomic_bs) {
>> +			if (atomic_bs > ns->ctrl->subsys->atomic_bs) {
>
> I am not sure why use > and not !=
>
>> +				pr_err_ratelimited(
>
> could dev_err() be used?

Yes and yes.

>
> "%s: Inconsistent Atomic Write Size,
>
> we could mention that this is the powerfail atomic size, and not "normal". 
> But I suppose that we don't use "normal" values anywhere, so it could be 
> assumed.

I'll keep it as-is, the message is already borderling too long as is.

>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -410,6 +410,7 @@ struct nvme_ctrl {
>>     	enum nvme_ctrl_type cntrltype;
>>   	enum nvme_dctype dctype;
>> +	u16 awupf;
>
> was it intentional to lose the " 0's based awupf value" comment?

I'll add it back.

Can I get a formal review tag after this?

