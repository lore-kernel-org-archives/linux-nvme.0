Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B34C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 02:02:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1658B65010
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 02:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1658B65010
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rTNvbE1GusfeBoB8pLGvo39BsCZOA701aGkq5+Xrc60=; b=Nh7aZEQ6V/nJdFq2HfqrWBk0L
	Mto45ZiG+0jHiyKwP/psL4wtYY+cNyggEbuIz4I6aFMJ537P0CtUNENgyST/xeiKU/U+AclHHnluh
	Kh+8/wUOT3uJr9bJqLFrZ/s2M1XeXkMSyIEgA/wUrvZ50Sa8s4Bit7QjplBB6Ht93SU0yb5DUYhVl
	7yNwbS88bo7rqAs0JLF5JGYShkt5WaZefoxrlRvpN6d/U3WHuRNozEwzYKndQ90lMGuxO0foGsnDX
	TNL4RHTvgu1ctwS4gf2LUiUQtvnil+2ZecDXog9QEyJ7er5ojKAF6wPQDMbuonh694Zy+8c9W2+Bb
	TSkUvTlwg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLz2b-00HDIm-NN; Tue, 16 Mar 2021 02:02:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLz2X-00HDIN-0u
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 02:02:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6595065011;
 Tue, 16 Mar 2021 02:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615860151;
 bh=GvwPPgTZ/iZQU1OT7FZPptb3NYUP6SAgZm0hzBa4gVc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CRKMmkhRwXcwE0eueEIukRHFtZ2+tL0P4ZX+DNwvKFsQLvhB7MSIuqWSo9VjS4iVh
 /j2nsetHmZRFNUgXzmGktjgmBbh8ywQ9ymOmNd9H+I7YU3RmNBVloukiBGUKrGqDOO
 qI4cyeeJMWa1XKDKHjzsZ+GhwSzGjUFAMLPlDsR1I8ErTS0u6Y8H5AqgHB8lxiw/Xg
 V62S/hvxh+nq94Y+asoLNcfxXKIEIjFDr+d0UZ/kEU9mJ/dG8fj0WF2poBsh46b48C
 ODjIDG489qhhdBIYmQR94pKRxBSY3+t6H83dzHbeSpzJbfUMVs+xsjFxxk7uCjtgnQ
 SSHX6fC7+CFug==
Date: Mon, 15 Mar 2021 20:02:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 axboe@fb.com, hch@lst.de
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
Message-ID: <20210316020229.GA35099@C02WT3WMHTD6>
References: <20210304005543.8005-1-lengchao@huawei.com>
 <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
 <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
 <45d16780-79a0-c2e2-8e90-246dae0b3e23@grimberg.me>
 <aac125ec-561a-002d-7054-782ee450067e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aac125ec-561a-002d-7054-782ee450067e@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_020233_396077_75A4797C 
X-CRM114-Status: GOOD (  24.83  )
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

On Tue, Mar 16, 2021 at 09:23:21AM +0800, Chao Leng wrote:
> 
> 
> On 2021/3/16 1:08, Sagi Grimberg wrote:
> > 
> > > > > A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
> > > > > over rdma(roce) reconnection, the reason is use the queue which is not
> > > > > alloced.
> > > > > 
> > > > > If queue is not live, should not allow queue request.
> > > > 
> > > > Can you describe exactly the scenario here? What is the state
> > > > here? LIVE? or DELETING?
> > > If seting feature(NVME_FEAT_NUM_QUEUES) failed due to time out or
> > > the target return 0 io queues, nvme_set_queue_count will return 0,
> > > and then reconnection will continue and success. The state of controller
> > > is LIVE. The request will continue to deliver by call ->queue_rq(),
> > > and then crash happens.
> > 
> > Thinking about this again, we should absolutely fail the reconnection
> > when we are unable to set any I/O queues, it is just wrong to
> > keep this controller alive...
> Keith think keeping the controller alive for diagnose is better.
> This is the patch which failed the connection.
> https://lore.kernel.org/linux-nvme/20210223072602.3196-1-lengchao@huawei.com/
> 
> Now we have 2 choice:
> 1.failed the connection when unable to set any I/O queues.
> 2.do not allow queue request when queue is not live.

Okay, so there are different views on how to handles this. I personally find
in-band administration for a misbehaving device is a good thing to have, but I
won't 'nak' if the consensus from the people using this is for the other way.
 
> From a service continuity perspective, I think it is better that failed
> the connection when unable to set any I/O queues.
> Diagnose is less important, I prefer service continuity, because if failed
> the reconnection and then try new reconnection, it is possible to recover.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
