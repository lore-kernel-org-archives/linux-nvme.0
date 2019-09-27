Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08162C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 22:14:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77942075D
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 22:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Odv+v4jN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77942075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/g/atWGatq1Rfv7rjLvazips6M72CGkE9skNjHX86Fs=; b=Odv+v4jNQUifN9
	C0ahZs6DUNzkkqvwy3fbAowKysANWxcc1mCWWACTYtpwIKq8OKangAfD4z+xsVqXEK/Tty7UnZZRZ
	Er/BWxWNt/m1i/sjROL2ZdcxSkJROBP+jP0EquwUMvFUGblb9g2cH7EqieY23Xv8vsEs78q5g2gwK
	L1mVGtLxDxjB36kZAqk+zssDYjb4P/Lg7rcFjxrIcOzws1Zlr0vHbNZWDZBZ72xb/eUR7HAOgk/5x
	7Bwxmkpimn6lj9Zw6A0XSGgSMFuuMigjET/c0BglparIb+Tc+mxUkL+64Xbfl0Lzwhb91jtg0CfoM
	djBSTaPkYT66WeVH9zig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDyUw-0007ei-VO; Fri, 27 Sep 2019 22:13:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDyUt-0007eJ-Tb
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 22:13:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7FDF168B05; Sat, 28 Sep 2019 00:13:52 +0200 (CEST)
Date: Sat, 28 Sep 2019 00:13:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Message-ID: <20190927221352.GA17568@lst.de>
References: <20190926231940.7494-1-m.malygin@yadro.com>
 <80c2509b-bd48-c3c4-13bf-8ad6b1c0f77a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <80c2509b-bd48-c3c4-13bf-8ad6b1c0f77a@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_151356_104030_9D9AEBBB 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: Mikhail Malygin <m.malygin@yadro.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 27, 2019 at 10:24:17AM -0700, Sagi Grimberg wrote:
>> +int nvmet_ns_revalidate(struct nvmet_ns *ns)
>> +{
>> +	struct nvmet_subsys *subsys = ns->subsys;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&subsys->lock);
>> +	if(!ns->enabled){
>> +		goto out_unlock;
>> +	}
>> +
>> +	if(ns->bdev){
>> +		ret = nvmet_bdev_ns_revalidate(ns);
>> +	}else if(ns->file){
>> +		ret = nvmet_file_ns_revalidate(ns);
>> +	}
>> +
>> +	nvmet_ns_changed(subsys, ns->nsid);
>
> Shouldn't that happen only of the size changed?

s/of/if/ ?

I guess we could do a sanity check first.

> So what is the model here? have some udev rule to
> trigger this?

Well, even if there was a udev rule we can't directly rely on it.
Mikhail actually talked with me about this at SDC, and I suggested to
just implement a simple file to revalidate from userspace, as we have no
good way to figure out if it changed in the kernel code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
