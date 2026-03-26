Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A492E10A62DA
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y5Pjy4k64ZDVJcCgJ9wS3Tl680xCo3F/CfTrExmvzvU=; b=z2yRGSkWGSN8s4wzx0PwMcHqXd
	0KN/y2IQa3QppeDp+4imETXKuQB9f8c65gaCl76dtO2hSd2SNafa/zv29P1CISC3VNQbKIscXmt9F
	zscmZ3Q+JnYIRJD6JmdE4Afcjn2IEURRYp6zUo+YWPyxh2q+QUOUZeErycXUmuR/H5z+C4d+yK+p4
	Q2+OoADhqeVwWNkaltJ/gsZUs4BhUeFdnCz3LljbWJmJFLdHC6DvtJjLXFIRZ9656eYUdmPGa37pB
	Gvo9362pzsFi9MfgU5tNbO9VI08RT0BeqMw0k34VOw7aMYINuR3bFFQQ0ZfqrVNGURnORHQETkihn
	xKkiEDgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lZv-00000005dJj-3vCH;
	Thu, 26 Mar 2026 14:20:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lZs-00000005dIo-2xyz;
	Thu, 26 Mar 2026 14:20:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A842468AFE; Thu, 26 Mar 2026 15:20:47 +0100 (CET)
Date: Thu, 26 Mar 2026 15:20:47 +0100
From: "hch@lst.de" <hch@lst.de>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
Cc: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Justin Tee <justintee8345@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>,
	=?utf-8?B?7Lm47LCs?= <joshi.k@samsung.com>
Subject: Re: [PATCH v5] nvme: Skip trace complete_rq on host path error
Message-ID: <20260326142047.GA16787@lst.de>
References: <20260326061443.GA23850@lst.de> <acQxjZMOqj74yIJf@kbusch-mbp> <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4> <945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com> <20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6> <CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com> <20260326014429epcms2p135ffd3c2b2fface6423d045e9614c262@epcms2p1> <CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p5> <20260326065152epcms2p51a18d3bbecb6eb6dc2ddba09651e5152@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326065152epcms2p51a18d3bbecb6eb6dc2ddba09651e5152@epcms2p5>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_072052_888357_115D2592 
X-CRM114-Status: GOOD (  10.77  )
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

On Thu, Mar 26, 2026 at 03:51:52PM +0900, 전민식 wrote:
> Hi hch,
> 
> I added a comment about why I do trace skip if it's host path error.

The patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But such note go below the '--' so that don't end up in git history.


