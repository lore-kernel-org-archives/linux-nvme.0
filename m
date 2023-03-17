Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF22FC6FD1D
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Mar 2023 07:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GbC2caWx/uj3zGSB2ZEuJa+sIjMof8wjzlAhu8aE7oU=; b=QMpscunoCR5+tZOk7hPSlZDl27
	l8Uk2ue33HEyrzfv1sqVtxJSdANPLeCPZOoupRoXRyQya9uY+6wPWttUqsWAn/2BjuKSNbcqTU4OZ
	+/TAu5b9nE6qji1l61Yk9fqJK4rk/wssLitLHqvC5GooquzkT9PmYaCodiX07/z69sPHV+QDkmlkB
	A9W9noAhZlQLtqMbB14SpTnxdpKGq39o8bxPd3MJXk9dJBpKfaWgL8T8DtWban9DDzmq5sb4HsFqd
	uccmkQIqWY1/2AhNt480aQYpO61M3abWocN3nPjbsjeTMZGistHV8KX+C23UCQP+I3JeEAhlqKURU
	gE5dmENw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pd4b1-001Iti-1R;
	Fri, 17 Mar 2023 07:33:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pd4aw-001Is8-2w
	for linux-nvme@lists.infradead.org;
	Fri, 17 Mar 2023 07:33:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD55D68AA6; Fri, 17 Mar 2023 08:33:33 +0100 (CET)
Date: Fri, 17 Mar 2023 08:33:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "# v4 . 16+" <stable@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung
 PM173X
Message-ID: <20230317073333.GA14827@lst.de>
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com> <20230316051508.GA8520@lst.de> <930CF361-37C2-4625-B5FA-245248544F92@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <930CF361-37C2-4625-B5FA-245248544F92@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_003347_120642_765C2F36 
X-CRM114-Status: GOOD (  12.60  )
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

On Thu, Mar 16, 2023 at 09:31:38PM +0000, Saeed Mirzamohammadi wrote:
> 
> eui64 values are not unique. Here is an example:
> namespace1
> nguid   : 36554630529000710025384500000001
> eui64   : 002538191100104a
> namespace2
> nguid   : 36554630529000710025384500000002
> eui64   : 002538191100104a
> namespace3
> nguid   : 36554630529000710025384500000003
> eui64   : 002538191100104a
> namespace4
> nguid   : 36554630529000710025384500000004
> eui64   : 002538191100104a

Eww, that's really a grave bug.  Interestingly enough the nguid
works, so I wonder if we should just quirk the EUI so that we have
a least some uniqueue identifier.

> I haven’t yet contacted Samsung. Do you recommend any one to reach out to?

We have plenty of Samsung folks here on the list, maybe someone can
reply?

