Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EB5C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M5uVJdCC+TnA3a1Nlw4p8IUec7XeNhxVQpHsDSw4tfk=; b=UV84ItTa+6gClwr0ijObvLWdQq
	LATFoZ2Py8mNIfiXXhdLtcgccySzg1+jaS/fF5NMl0EmObdKfHwZMhCpixpwdF+Suv3lGJnJvZsFr
	xHyLAsRiddxEpg2LdVl5l+yXsTkxBNThkPXqz3cjk7Vl3gW8Q0z7jlPm+LykvdBPqhCy/3yu6Ty3d
	PQg4c2OfuN+qlzyxhKikGd7PcfQeqOaZMCj/1vXQo9mW7TP4z2MbMHOLGZHV1W2oe4tx7DcazfAuw
	xV2bhEnbbS//QK8Qjsm8VP5R0e/hccwXUfCWXCho4DKwZRXOrHUMWNZxx7Zrx7oFZafYRSjnZ//2W
	WUoSRN6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouyVw-00CcWf-JQ; Tue, 15 Nov 2022 16:10:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouyVt-00CcVv-2b
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 16:10:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3ED5E68AA6; Tue, 15 Nov 2022 17:10:05 +0100 (CET)
Date: Tue, 15 Nov 2022 17:10:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-auth: fix compilation warning when
 CONFIG_NVME_AUTH is not set
Message-ID: <20221115161005.GA20314@lst.de>
References: <20221115143532.1142332-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115143532.1142332-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_081017_276094_CC526899 
X-CRM114-Status: GOOD (  11.85  )
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

On Tue, Nov 15, 2022 at 04:35:32PM +0200, Sagi Grimberg wrote:
> init/exit functions should be empty static inline stubs when
> CONFIG_NVME_AUTH is not set.

I've folded this and another similar fix in.

