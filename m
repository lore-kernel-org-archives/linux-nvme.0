Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2701FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 21:54:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB5264E41
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 21:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB5264E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+kmQ9YabkmkPRORLiMpslHAZSCfDv4bkyahHfaGZ7Yw=; b=N7Oq7kDRJ+h08XAS3B/7wEY2s
	ekh4bvzhHDIETYM6xMVLFFc0bnh3ytXuptZu5QMX+KdJhFZKasbJVq5oGffBMkbVgvdg+HX0mNysJ
	ZvWv+pmC/xFZAQ8fRPFY5RRxJsgJiXxBal/jc1mTtQtJZCCR/W3VDbhQtCh0bsslTKUcP4RVdDPah
	jPqZNqjFhoeKLRLVjQ6f8uxefrFUHM2Y+K3KaEzCFvEMPdNdOlGpzurMdkQc2gDHtXINAOGDYfgkW
	D94iu1lksPlKwxc80I6f5+2kgp3IG4jlWNihKlVaf0scxzjjPkS1VUjo9T5GTVV9SFc8uG4LbKJbr
	UK5uIb8IA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHZRK-006eyQ-Fr; Wed, 03 Mar 2021 21:53:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT9v-005KNf-2L
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6pmpCODVvyfWxynvbMUIqLc4SMK6uUVFR5RuKF32QjA=; b=AS5nwHWL5V0VD0yQP3SesqgxZJ
 SP4THnDicu9l6RXeygQheOFU0zT7isL1PdbZWle26Zne6c+Qq6bO47P8pXbeXYnwpb6oSNQn4pgJD
 90Zo65VI0PXfl59yXrAXbyVXkwhCqDOwDmIVJkkwi82f1mDoDdbCSzOsDcphcCdybUHc1nqedxsYC
 +WsdCm1pM21jj01x7my9tHk1LXmBLeufqF++xguVcEv20aCIi7lUqNxvRbiNb2WxxnklreahGcJUw
 6byMfSumBDbLe+sNuZV8b3jSufwBumX/CnuiF++5ntgJYjko4IW6/M+Otp8ZF+YOU7oWFIGZha1mD
 KhKDKivg==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHHxx-0015sq-F9
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 03:14:26 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B74F600EF;
 Wed,  3 Mar 2021 03:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614741260;
 bh=6pmpCODVvyfWxynvbMUIqLc4SMK6uUVFR5RuKF32QjA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LOrDrxjLlz2TXRmvCwxrVw55UZjpjhH5JjhBWNXzNffRxXjTUVw8IyNTNOw9eW0FC
 cqwLc79jZNrTnQwD7XQt+/OpP3OcZrKUbs/qPlPvk4R4Vg2PG3aPR2vpYkvrkhK46p
 +JON30J0wNJWDR93csM9aPfbFi5B2G4htBPvjtI0PZiX4HVB+SJm3RxfR/B8Yj7P5T
 jljaeEomiT81hEQTeuS7TbsytEUmnu5pSwm/0IeMKnWFgfWoplfyul5/lMzqTqZg93
 FqikxFzjnfOg7vD5maejKITmhQ/AKGGAyW2Y4dCa2cA4157wCNoUmXBVU7Ge2h910l
 RTxKPV7POD9Kw==
Date: Wed, 3 Mar 2021 12:14:16 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
Message-ID: <20210303031416.GD22346@redsun51.ssa.fujisawa.hgst.com>
References: <20210223072602.3196-1-lengchao@huawei.com>
 <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
 <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
 <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
 <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
 <fe262778-4d30-176a-b6c5-a17f023ac22f@suse.de>
 <8ceff1a9-8015-feab-6c02-fd22ec3346de@huawei.com>
 <20210302182418.GA22346@redsun51.ssa.fujisawa.hgst.com>
 <399fd796-64c2-7d25-b0d8-0f445c4bb2dd@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <399fd796-64c2-7d25-b0d8-0f445c4bb2dd@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_031426_556375_3CC4FBE2 
X-CRM114-Status: GOOD (  10.17  )
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

On Wed, Mar 03, 2021 at 10:27:01AM +0800, Chao Leng wrote:
> On 2021/3/3 2:24, Keith Busch wrote:
> > We can continue to administrate a controller that didn't create IO
> > queues, but the controller must provide a response to all commands. If
> > it doesn't, the controller will either be reset or abandoned. This
> > should be the same behavior for any transport, though; there's nothing
> > special about PCIe for that.
> Though I don't see any useful scenarios for nvme over fabric now,
> Reserved for future possibilities may be a better choice.

The admin queue may be the only way for a user to retrieve useful
information on the malfunctioning controller. The telemetry log isn't
unique to PCIe.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
