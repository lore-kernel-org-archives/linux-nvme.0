Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764FBC43217
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7U+h+b6X88tHLW6uMojSI7Bu+195dkvtIOVen1egQAk=; b=VkVFWdT+yeJe7P5QMXAW8fvHru
	rM1f1tEFiKTcN75AhitR+c+hTLIGYB6BSTnw1gGJuYhyA6m1+ZBdGVwADo73wPZExPgKyM1Sx+KKR
	aAX64C+Xo2ppygvRJ/JZpLx5T7uCiTmrxOcCkiCM4n1UOpSmQ2Ov6LdJJrZmAyjge+X/XAbx9PbTe
	bYnejyw1LY1qF6qPCfZh3dSMaJF9D9+rNEJoxb7GihJqoBUvxEW9dExGYgSJxYJ+VSPH7KZT4UWG/
	qvX/YF9sSzqjFrfL0BiWgKw9iN98bH85ycb8lA94q6GzYdrCk7peGfzuOEVOFIdJHQJOXeWy1wNYJ
	KjsI59Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4Gn-00GTIT-8k; Wed, 19 Oct 2022 08:17:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4Gg-00GTEr-JT
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 08:17:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9149F68C4E; Wed, 19 Oct 2022 10:17:34 +0200 (CEST)
Date: Wed, 19 Oct 2022 10:17:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221019081734.GA15255@lst.de>
References: <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1> <20221017153105.GA32509@lst.de> <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1> <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590> <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me> <20221019072535.GA11402@lst.de> <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me> <20221019073231.GA12035@lst.de> <c791d0d8-80b5-d25c-f8d6-f93bf6c840a6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c791d0d8-80b5-d25c-f8d6-f93bf6c840a6@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_011738_806856_67493F58 
X-CRM114-Status: GOOD (  15.28  )
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

On Wed, Oct 19, 2022 at 10:57:11AM +0300, Sagi Grimberg wrote:
>
>
> On 10/19/22 10:32, Christoph Hellwig wrote:
>> On Wed, Oct 19, 2022 at 10:30:44AM +0300, Sagi Grimberg wrote:
>>> iscsi defers network sends to a workqueue anyways, and no scsi lld sets
>>> BLK_MQ_F_BLOCKING.
>>
>> Yes, but Mike had a series to implement a similar fast path as nvme-tcp
>> as while ago that included supporting BLK_MQ_F_BLOCKING in the scsi
>> midlayer.
>
> Hmmm, didn't see that, pointer?

https://www.spinics.net/lists/linux-scsi/msg170849.html

>>  We'll also need it to convert the paride drivers to libata,
>> but those are single request_queue per tag_set as far as I know.
>
> didn't see paride even attempting to quiesce...

The block layer might.  But it really does not matter for our
considerations here..

