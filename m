Return-Path: <SRS0=Wzp6=IS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B379DC433C1
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Mar 2021 06:11:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD4C61996
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Mar 2021 06:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD4C61996
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2M4WmEK2ATjU96AYbYoh8uW+BV8vRITp+DRuKpYVPGs=; b=Poy/Ev1nJWUFsI+e7/e41quw9
	MNfiWV1fmfwSKGW8nBKvQz7vhhjlhgjADDli9+FRqkzIHV0bEihOnRQxaN1kyyzlTwZtOjcYxoBIw
	Vty5AhxNUJ6vuKhsNW9Ui8ELC/jK7L+X8lL+saIYkHC+UIgTrMKnZbixXnkKfj1MhoNo1iAjGZn2b
	m5UfIpzWb/mZhrKkk1QC8m3VQdFQT1GWEVlH0gxy4m/BUpfJo09J0aA+9VSfWJ0ArCRc1ZvpO7jSa
	4tklEW+TSqNgKjBS1W5xIrBAB8xGDHu/O7iWOGuFdBeO91agXZf9Y0DzC26Maeq3wKz46g7cTfWN0
	U1IBSFkbw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNUpg-008Zxp-Iu; Sat, 20 Mar 2021 06:11:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNUpb-008ZxO-Rt
 for linux-nvme@lists.infradead.org; Sat, 20 Mar 2021 06:11:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AFF5E68B05; Sat, 20 Mar 2021 07:11:23 +0100 (CET)
Date: Sat, 20 Mar 2021 07:11:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Message-ID: <20210320061123.GA20852@lst.de>
References: <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
 <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
 <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
 <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
 <20210319140532.GA7019@lst.de> <20210319172817.GA23660@lst.de>
 <ac05c7cc-3613-ec8c-a718-6f3e74710b42@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac05c7cc-3613-ec8c-a718-6f3e74710b42@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_061128_032893_1441CB76 
X-CRM114-Status: GOOD (  15.26  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 19, 2021 at 12:34:25PM -0700, Sagi Grimberg wrote:
>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index a1d476e1ac020f..92adebfaf86fd1 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -309,6 +309,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>>   	 */
>>   	blk_queue_split(&bio);
>>   +retry:
>>   	srcu_idx = srcu_read_lock(&head->srcu);
>>   	ns = nvme_find_path(head);
>>   	if (likely(ns)) {
>> @@ -316,7 +317,12 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>>   		bio->bi_opf |= REQ_NVME_MPATH;
>>   		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
>>   				      bio->bi_iter.bi_sector);
>> -		ret = submit_bio_noacct(bio);
>> +
>> +		if (!blk_mq_submit_bio_direct(bio, &ret)) {
>> +			nvme_mpath_clear_current_path(ns);
>> +			srcu_read_unlock(&head->srcu, srcu_idx);
>
> Its a bit unusual to see mutation of a data protected by srcu while
> under the srcu_read_lock, can that be problematic somehow?

Hmm.  I don't think head->srcu is intended to protect the current path.
We also call nvme_mpath_clear_current_path from nvme_complete_rq or
nvme_ns_remove, which has no locking at all.  The srcu protection is
for head->list, but leaks into the current path due to the __rcu
annotations.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
