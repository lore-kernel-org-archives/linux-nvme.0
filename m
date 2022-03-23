Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB57C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Q3H81FvdLjR6wAVp3YwYXFIzKK8WM+vSItTdaSihKY=; b=38beTMVlFQ3jm+Ki1acItivVXC
	m+TSlR4dmich0e8fQXxKpSS8NQTseMGdLRvWh8SDWLjDsjC62JqkOgv62hHpNtqKubWS/rTG+CagU
	ZMCDFPnEBOz/3KhUgDS/PBguoyMFK8IA0Rly6+6ERqTQ0nvLFnmhm/waLuypPg47UMsDFPP5dMEOm
	1gb2y8nu7az65Xfci3/WRXYaxbHK2T/zvN+luqZsKPwreHmEYNNIh7guJkOMbvGzhptiCrj72vvWQ
	z1ycpiHZ42tHxi5QBjZSq0rf2Kx1IWEQ3nMy9Gy+tuADTgJkw8DpgQw5+JUfi/bKveZSNqByOBRAV
	F+dZZ7Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX30A-00E8Qg-8x; Wed, 23 Mar 2022 15:34:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX306-00E8Pg-Sn
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 15:34:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A45C268B05; Wed, 23 Mar 2022 16:34:14 +0100 (CET)
Date: Wed, 23 Mar 2022 16:34:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, lengchao@huawei.com, dwagner@suse.de, hare@suse.de,
 mlombard@redhat.com, jmeneghi@redhat.com
Subject: Re: [RFC PATCH] nvme: fix RCU hole that allowed for endless
 looping in multipath round robin
Message-ID: <20220323153414.GA440@lst.de>
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-4-cleech@redhat.com>
 <7d9771f2-d86c-25e5-5bee-504e33c5aae7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d9771f2-d86c-25e5-5bee-504e33c5aae7@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_083419_127939_99127AD6 
X-CRM114-Status: GOOD (  20.24  )
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

On Wed, Mar 23, 2022 at 04:54:26PM +0200, Sagi Grimberg wrote:
>
>
> On 3/22/22 00:43, Chris Leech wrote:
>> Make nvme_ns_remove match the assumptions elsewhere.
>>
>> 1) !NVME_NS_READY needs to be srcu synchronized to make sure nothing is
>>     running in __nvme_find_path or nvme_round_robin_path that will
>>     re-assign this ns to current_path.
>>
>> 2) Any matching current_path entries need to be cleared before removing
>>     from the siblings list, to prevent calling nvme_round_robin_path with
>>     an "old" ns that's off list.
>>
>> 3) Finally the list_del_rcu can happen, and then synchronize again
>>     before releasing any reference counts.
>> ---
>>   drivers/nvme/host/core.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index fd4720d37cc0..20778dc9224c 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3917,6 +3917,15 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>   	set_capacity(ns->disk, 0);
>>   	nvme_fault_inject_fini(&ns->fault_inject);
>>   +	/* ensure that !NVME_NS_READY is seen
>> +	 * to prevent this ns going back in current_path
>> +	 */
>> +	synchronize_srcu(&ns->head->srcu);
>> +
>> +	/* wait for concurrent submissions */
>> +	if (nvme_mpath_clear_current_path(ns))
>> +		synchronize_srcu(&ns->head->srcu);
>
> Nothing prevents it from being reselected again.
> This is what drove the placement of this after the
> ns is removed from the head->list. But that was before
> the selection looked into NVME_NS_READY flag...
>
> This looks legit to me...

Yes, this looks pretty sensible.  I'm tempted to just queue it up
for 5.18.

