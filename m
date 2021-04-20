Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B58C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 15:37:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1274F613AE
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 15:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1274F613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=urNvPHe2bnlOKRlRCpPRxqdwuH1NEo9KXPWVtUJSBi0=; b=JEJTSfmY5igf2aRJi3XpdYD5b
	LmEh5Ru2rGGOs0IqVjFAQg7+ceZLSfpiSq0tHtwhCf/PS78bJJfNqcSDCGEE09HuvDjNdtypQzXJB
	GyMqv8+GjCfh6LgczyNmnq73igbgHxGbw+1KKxc3IVRLizGkD2pj7Upe8B+y2G2g7h/VelPq0KVmt
	nN5kqFmlb9Tx6qZdb5qB704OI8tvnKi2rK70ywWiBqG7Q4B/NUDOsl296nYSjJTulPZ9FVZXHg4gv
	Tpo3CN9tpiZnAyv2zHcHPm1ThXxJlsVcbT1/8LpdoC1MqLEPF+wBl/Ybq2NOYf5wWcFalQkBm7u9Y
	hUU4KfwJg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYsQX-00CVQM-Lx; Tue, 20 Apr 2021 15:36:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYsQV-00CVQ6-Th
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 15:36:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=J/6aSRjHwBEmMywzlrZVSOhpAMviMii4sFz2+AcLaEw=; b=uTolYr5VMtcG1/yHnWqyVoMfVB
 5yxhGwmxucy5GSSy6z6dScsAgAHfS14XOXEhv4bXYrpdsgXKDQz+0eXB+skaNt7Bfb9eSknM6lZN2
 iRQRND6e5Ebzoe+ptXOausQ/jFMVaINWHeM5H8u+3pIl0iGepIqBlJ/akkMHaAZfBt/wjOaWZLQAz
 MwB3xwmAb6n1DE007r0qAx62AUOKmvVjrQkJ6KMfGvMR+HfJEhEVKRosfMk7wWllTcwWh5VCZ/JYS
 tQFuNqMRF+Ca9LaCVw7J4gvAdGw3Wn2Im9GQrQ6z7FxxeT4zXEJGpN0mKTS43Pj/fyLJJ/I7RDWNH
 K+LYLOKQ==;
Received: from [2601:1c0:6280:3f0::df68]
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lYsPq-00FKaG-7q; Tue, 20 Apr 2021 15:36:11 +0000
Subject: Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Nilesh Javali <njavali@marvell.com>, Arun Easi <aeasi@marvell.com>
References: <20210419100014.47144-1-dwagner@suse.de>
 <cb00b188-31bf-d943-8f82-31c8c966c728@infradead.org>
 <20210420123723.bregf4debvyincpo@beryllium.lan>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d7e3cdb-3603-0b3e-9f46-46cf4310520c@infradead.org>
Date: Tue, 20 Apr 2021 08:35:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210420123723.bregf4debvyincpo@beryllium.lan>
Content-Language: en-US
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

On 4/20/21 5:37 AM, Daniel Wagner wrote:
> Hi Randy,
> 
> On Mon, Apr 19, 2021 at 09:19:13AM -0700, Randy Dunlap wrote:
>>> +int ql2xdev_loss_tmo = 60;
>>> +module_param(ql2xdev_loss_tmo, int, 0444);
>>> +MODULE_PARM_DESC(ql2xdev_loss_tmo,
>>> +		"Time to wait for device to recover before reporting\n"
>>> +		"an error. Default is 60 seconds\n");
>>
>> No need for the \n in the quoted string. Just change it to a space.
> 
> I just followed the current style in this file. I guess this style
> question is up to the maintainers to decide what they want.

I see what you are saying, but the file has no consistency
of style in that regard. :)

oh well.
-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
