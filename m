Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A671DC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 23:12:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A4922D06
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 23:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A4922D06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y3C3EFdJbyj3IPmIqD+qmZ7uFPckLYOYHy0jvlguunk=; b=0vKJAJuCaqeHjTK7gcFWiQwLX
	E/lbJkJaEsIJWMsc2SXy4ew7QGC0CNLVtiGoTz1fyR/MDoHxYQEBmmaugBnxCSMoZkDhV+7Qjdu96
	lB7psqpKJ5bffbQpJMlkcWNcsKbcIC+L4zjjF/4js5vGZZ75EgWqPLLsgVm/4uL0UObkgua9mcR/K
	K97ErKJEnJ/oA8Xb94/856Fi3eWpH6Ghnj2u/o9LjwlP7M09GfK+SDgPyZHSa/UlZe5WMKPtb4I5+
	sJEegskF1VPNmRVIv+DosO3WYS1K6A6At4HzNlXwKH/IfoRs0rLxW+G41YeRotJfDgRvUsuGb3Jyt
	4Ei9onIKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knra4-0006NX-K0; Fri, 11 Dec 2020 23:12:08 +0000
Received: from smtp1.emailarray.com ([65.39.216.14])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knrZy-0006NA-Vm
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 23:12:03 +0000
Received: (qmail 2808 invoked by uid 89); 11 Dec 2020 23:05:21 -0000
Received: from unknown (HELO localhost)
 (amxlbW9uQGZsdWdzdmFtcC5jb21AMTYzLjExNC4xMzIuNw==) (POLARISLOCAL) 
 by smtp1.emailarray.com with SMTP; 11 Dec 2020 23:05:21 -0000
Date: Fri, 11 Dec 2020 15:05:15 -0800
From: Jonathan Lemon <jonathan.lemon@gmail.com>
To: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
Message-ID: <20201211230515.n5i2i2w23zdwnl6q@bsd-mbp.dhcp.thefacebook.com>
References: <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
 <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
 <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
 <20201210180108.3eb24f2b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <5cadcfa0-b992-f124-f006-51872c86b804@gmail.com>
 <20201211104445.30684242@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <281b12de-7730-05a7-1187-e4f702c19cda@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <281b12de-7730-05a7-1187-e4f702c19cda@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_181203_056629_6FC76681 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 yorayz@nvidia.com, Boris Pismenny <borisp@nvidia.com>,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 edumazet@google.com, linux-nvme@lists.infradead.org, davem@davemloft.net,
 axboe@fb.com, Boris Pismenny <borispismenny@gmail.com>, ogerlitz@nvidia.com,
 viro@zeniv.linux.org.uk, netdev@vger.kernel.org, kbusch@kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 11, 2020 at 12:59:52PM -0700, David Ahern wrote:
> On 12/11/20 11:45 AM, Jakub Kicinski wrote:
> > Ack, these patches are not exciting (to me), so I'm wondering if there
> > is a better way. The only reason NIC would have to understand a ULP for
> > ZC is to parse out header/message lengths. There's gotta be a way to
> > pass those in header options or such...
> > 
> > And, you know, if we figure something out - maybe we stand a chance
> > against having 4 different zero copy implementations (this, TCP,
> > AF_XDP, netgpu) :(
> 
> AF_XDP is for userspace IP/TCP/packet handling.
> 
> netgpu is fundamentally kernel stack socket with zerocopy direct to
> userspace buffers. Yes, it has more complications like the process is
> running on a GPU, but essential characteristics are header / payload
> split, a kernel stack managed socket, and dedicated H/W queues for the
> socket and those are all common to what the nvme patches are doing. So,
> can we create a common framework for those characteristics which enables
> other use cases (like a more generic Rx zerocopy)?

AF_XDP could also be viewed as a special case of netgpu.
-- 
Jonathan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
