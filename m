Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C1C43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 19:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CA3206F6
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 19:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NUVkgpNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CA3206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tZj0ffqi7v4UdvfFsyxhETrXL8pinQRu7XdOFGx/04s=; b=NUVkgpNAit62o5Z78Dm28CIvQ
	seDuMOoEP+4GSsBsh/HHfzttCG3bXaUK+kJxhcsMCiIRHEPlwCNbzpjo9uT674BoE5EmuWIueaiSX
	rDyUjTcSqDIwBuWRPlEr+YEXXl75odW7XDg0HFBbfOVQtQTUTturwXsajevzD/89TE87ApRYb76nc
	+4GLGZK/V3ckv9j+Jr4I2JfzrVA5fO2R/SCUKNbZfjTUG3RoodZsACCDJJDppyc1ygqig/bHyCZMX
	4pSfM2dODUBB9WOI56n6klM7yqHNdiB/lvMVP4uCd6ln1LUkfaJLkOaohkrHWxlfbp13DHGS6jndA
	JYq8eOYBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJilh-0007vG-S1; Wed, 01 Apr 2020 19:11:17 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJile-0007uL-Du
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 19:11:15 +0000
Received: by mail-pj1-f68.google.com with SMTP id nu11so468655pjb.1
 for <linux-nvme@lists.infradead.org>; Wed, 01 Apr 2020 12:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9ekGkD2IlLQBhkQzaSBHBTkrc7NdLrPJO/D7tB34FXs=;
 b=NpAJUm8I9GJiq0tIkNOmopZqSschxVsx4qq+gkYRdVIwaBOKyCFp5UJBDrWiFeZwnu
 cToWd4mgA2ymc37fGSjFT3WhH614qRsuSzDcUg7IPDcJEBFbBhA0mHJfTSydy8uUJLQj
 ljnexo7aqaWSwwcY9QWuEj+m6ri78oiEhCy81C11J1d3m8D4QAMwM0uV5RSgURWlbtXf
 ibfrsT1I6THB7qsXBBBGVW5H6XExrDEiwbY8mtGmxUGxC5Q98kLQq3QZ/kL7Zcvw9vf2
 t7SI415ZI3FZZxPz1cS51xoFGFOFSorQIaNMIjKEChCq5nqta+iSjAPUzMh72j7Uxv2d
 gquw==
X-Gm-Message-State: AGi0PuYfxQ1zpgx4TqgoFOmE/yUV7UUH4J95ldFBtSeYCs+wT57BUFCg
 j11r+DiYMt89ikG9rYtbE8xOnLY8
X-Google-Smtp-Source: APiQypJFHGU29tvohQudGh4GCyv/2BvNJT90yAH5ccNA203n7VNqQTA251XzdLQ1XASA3Ycl6T3m8A==
X-Received: by 2002:a17:90b:8c:: with SMTP id
 bb12mr6408096pjb.59.1585768272007; 
 Wed, 01 Apr 2020 12:11:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a836:db4c:a7ac:3d7c?
 ([2601:647:4802:9070:a836:db4c:a7ac:3d7c])
 by smtp.gmail.com with ESMTPSA id r186sm2119474pfc.181.2020.04.01.12.11.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Apr 2020 12:11:10 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: inherit stable pages constraint in the mpath
 stack device
To: Christoph Hellwig <hch@lst.de>
References: <20200401060625.10293-1-sagi@grimberg.me>
 <20200401090542.GB31980@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <469eb075-2a6f-3386-f843-90525590fcba@grimberg.me>
Date: Wed, 1 Apr 2020 12:11:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200401090542.GB31980@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_121114_468840_03D00711 
X-CRM114-Status: GOOD (  14.99  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> @@ -1907,6 +1907,13 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>>   	if (ns->head->disk) {
>>   		nvme_update_disk_info(ns->head->disk, ns, id);
>>   		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
>> +		if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
>> +			struct backing_dev_info *info =
>> +				ns->head->disk->queue->backing_dev_info;
>> +
>> +                        info->capabilities |= BDI_CAP_STABLE_WRITES;
>> +		}
> 
> I think this needs to go into blk_queue_stack_limits instead, otherwise
> we have the same problem with other stacking drivers.

I thought about this, but the stack_limits has different variants 
(blk_stack_limits, bdev_stack_limits) but only the first takes a
request_queue...

I see that dm-table does roughly the same thing, drbd ignores it.
In general, dm is doing a whole bunch of stacking limits/capabilities
related stuff that are not involved in blk_stack_limits...

I could theoretically add a flag to queue_limits to mirror this, is
that what you are suggesting?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
