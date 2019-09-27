Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC06C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 22:51:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B812082F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 22:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hGFrjGQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B812082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FBo+j3/GGPAz1P5TdMItpp6lOyuhM5NfKaG5w5A/kG8=; b=hGFrjGQRV+ownW
	uoJoKeqnFCpTY/aWIW2Sm7CWgzjuMtvi0zavj70xWRNwfgUTndJkrCEai7EgHjQJkHEaGFgaJxsUM
	VIMWmjqri5Ee4tTOlsUNU0LMqT62Chb+ETTTi6ncj3tWn0WUNjTeEJN+rlZBeI8pAW3XOkXlv7Nru
	QMJ3y0SH1wCYh1fItTygirLPfQH+jzIqlIB18HdmE7dJf+MXiHtN52U2O9Yx4y65bFYPuK9TWSE+5
	4sp2jQFl3vMUM7N5/tZgp7QVv7Z7mmMSE4mmIKaeCa/QbTTGp1QZ9PNxxsj29Q5jcvtDwjjz9RKa0
	yXjvMIvKptAFzJlXEzOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDz4w-0004k3-EU; Fri, 27 Sep 2019 22:51:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDz4t-0004jN-Af
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 22:51:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1149468B05; Sat, 28 Sep 2019 00:51:03 +0200 (CEST)
Date: Sat, 28 Sep 2019 00:51:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Message-ID: <20190927225102.GA18434@lst.de>
References: <20190926231940.7494-1-m.malygin@yadro.com>
 <80c2509b-bd48-c3c4-13bf-8ad6b1c0f77a@grimberg.me>
 <20190927221352.GA17568@lst.de>
 <d969c277-a14e-4155-7cee-e5e5af995449@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d969c277-a14e-4155-7cee-e5e5af995449@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_155107_516874_972AA340 
X-CRM114-Status: UNSURE (   8.73  )
X-CRM114-Notice: Please train this message.
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Mikhail Malygin <m.malygin@yadro.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 27, 2019 at 03:34:24PM -0700, Sagi Grimberg wrote:
>> Well, even if there was a udev rule we can't directly rely on it.
>
> What do you mean we can't rely on it?
>
> I do understand that we'd have no triggers for file-backed namespaces.

Do we have any generic way supported by all block device drivers to
notify resizes?  For files we could at least use dnotify/inotify/fsnotify/
etc in userspace.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
