Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304C4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f7qsl0wuzlN+We+YckfR1ZlSyXconLmQzfiazp6GcNQ=; b=gGBbyPd0/v9t0SHof86Mp2HAwX
	8RU/GPo7EVA2/2Q55ePbrqWfNgQ14BwLZuKiE5S85Den2alP/LbpJQIUe+OrJk5qCXUluYk4j9mwo
	DXMJZD5A06wMD2z8GfI7OVXy4ZhDC/+lrE7FefAqb8/wDDOqIaKWbwo7M5pXVLi4rr9+5/N8wpoiE
	zxYDo+7lCtigcaFxQRZYva1oc3/Sa/O1bhAiqSOsV4YBf5pj9aXANC5I8GbnV9WzlzAQPAIO+JJd9
	/06dSFMd0IIU3A0Evk0a5sVMk7Lwpo0vvt/gq2HL4lpPMvNWNPjaCsPgeqO5G/Dj1Wasw0pJHF3qj
	xDr79RKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhb2r-00EWPi-Lj; Thu, 21 Apr 2022 17:56:45 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nhb2p-00EWPR-Du; Thu, 21 Apr 2022 17:56:43 +0000
Date: Thu, 21 Apr 2022 10:56:43 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: can't run nvme-mp blktests
Message-ID: <YmGa2yzufsI1TLiC@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
 <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
 <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
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

On Fri, Apr 15, 2022 at 11:09:33AM -0700, Bart Van Assche wrote:
> On 4/15/22 10:59, Luis Chamberlain wrote:
> > That's about 3 block folks not being sure whether or not it helps. And
> > the complexities of it, to test it, requiring a different kernel seems
> > just stupid. So I'm going to drop the tests from kdevops and not bother
> > with them.
> 
> How about modifying the nvmeof-mp tests such that these use NVMe
> multipathing instead of the dm-multipath driver?

Patches welcomed, I'm just going to ignore nvme-mp for now.

  Luis

