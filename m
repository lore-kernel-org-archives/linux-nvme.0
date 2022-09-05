Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8668ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=e2oKanbExksVLxOD9dqWv1XzOM
	xKPe5ZCjPiC9mzIPf/0NIvE+mIRJY0SEinhZSlBc7h4cOZhDBofDxTYzmH9EbAqx+Rywkto4mQON5
	giuNGAV4rcXeoYHgF7+hqLOGKkITRBRZZ3pJOXoE/9zS9/jBchhgBPMirN2lNG1yo7TnBTV8K69ct
	3iHRuC7Ayx+QYupzrcskxqoFjGli2MuBAt1nr2iLZdja0GkpCunO9eancl5UndCKM1Kr+eTxnHSMr
	5BRMkLHDt6x1WdcZnjdLpTBbzi2O/2mvsFZ1c5BFi87o2SwDwy+AQJUO7CX5ybDkp28Yc682MY0MB
	PvHgCp8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCp8-004DM1-FO; Mon, 05 Sep 2022 14:11:38 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9yU-000u90-0t; Mon, 05 Sep 2022 11:09:07 +0000
Date: Mon, 5 Sep 2022 04:09:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3] nvme: consider also host_iface when checking ip
 options
Message-ID: <YxXY0ckMqygfQngO@infradead.org>
References: <20220729142630.13504-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729142630.13504-1-dwagner@suse.de>
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

Thanks,

applied to nvme-6.1.

