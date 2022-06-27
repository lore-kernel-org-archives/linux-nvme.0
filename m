Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C927CC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 06:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDEjGBvw2GYKOCwjKU8l8oMHXkrn1dqLdPuGYHlZYWw=; b=oS6TEvByt4qB1iIegbMCdtztd3
	gtQ5tr5OiYn3hKM36DUGkVh108rso4/4wBgw+4SjcK0zWN5cm+21yZcTMFb7mDCFa2nheJMNYEFGk
	vNDNELwTcMD8asdnWzp3cBOdyugKhnuHC65bx9jREjUM0QatH+qeBulr13svccDNvsWUf9WcBAubh
	r0WTjuw7RdWdU0CBLmTPJ02sWPv+f4c6TGpSs68cm6SH7l1DUY19M3ecj1f+ViXvcgO9VPdGu5Kk+
	ashoXiMI4pP4GH8SSY8Hx9bum/axlPesxBE58mitPgPIEg+l8ddXYXlxiDolpFjfKOqSsnFuUH0qu
	lvMVtQGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5iCB-00G4Vu-SG; Mon, 27 Jun 2022 06:26:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5iC8-00G4Ug-FX
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 06:26:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E54F68AA6; Mon, 27 Jun 2022 08:25:53 +0200 (CEST)
Date: Mon, 27 Jun 2022 08:25:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv17 00/11] nvme: In-band authentication support
Message-ID: <20220627062552.GA9466@lst.de>
References: <20220623061730.51490-1-hare@suse.de> <19c905e8-963e-5720-b18a-d050217d40de@grimberg.me> <f1e33a3f-c3e2-e6da-7314-f0a926dd98a5@suse.de> <3ea29952-4969-8622-7275-fa64b26b845d@grimberg.me> <c196e653-f5b4-c2c8-ae8b-1bd8b1120144@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c196e653-f5b4-c2c8-ae8b-1bd8b1120144@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_232600_701800_B2CC10C0 
X-CRM114-Status: GOOD (  11.33  )
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

On Sun, Jun 26, 2022 at 04:22:35PM +0300, Sagi Grimberg wrote:
>>> Hmm. Looks like a generic nvme issue, so unlikely it's introduced by this 
>>> patch. We still should fix it, though :-)
>>
>> I'll have a look.
>
> CC'ing Ming, this came back since commit:

Should be fixed in -rc4 with "block: disable the elevator int del_gendisk"

