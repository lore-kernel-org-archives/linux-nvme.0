Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A98C282EC
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKwwbHKyp4Ga/0e4HrTJnXyioSsxsbAB+spkL99CSzM=; b=sabNAO6iyetZGS1v13QHa3GvGL
	Pc1kVrEDB4zdgBmcqLIUh6w+eiprjoSUgIg8VgifGCPhBRNOkK64YwUx9ALVtPE59iBuIAZHXvL/z
	OymDOcof5vDJC/76d63N4Q+LoaDcfmIIADcsXZW/KzGPS3+2bi6jw6raReEvfdtt1E4/wqueAPvyH
	/2GES330x39w9fPBB+yXp4f4BPK0+UVOCo9zNVvRcdUpSWlqYkQHabNHJBe0dFn54L74E3XVr6Z/Q
	BnXFXoLj0rjK9uZdS7Fa2Mjqu5jf89RVeom0y6bOh99t5M+/8unDisflYyeZ5xU0Q6vPMk1ZZC0mA
	I2kTLgqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqD00-0000000BITZ-3hYe;
	Thu, 06 Mar 2025 15:19:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqC3j-0000000BBGn-0a0H
	for linux-nvme@bombadil.infradead.org;
	Thu, 06 Mar 2025 14:18:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OKwwbHKyp4Ga/0e4HrTJnXyioSsxsbAB+spkL99CSzM=; b=aROVYhdThMUK6uCYU+vCkL+A1U
	QAMLZh9MUo19sX/NpglFrOm7q0qrLoLspl3MYAmk7CtTeIX4hI8hVr6/fT80pFAg2f+a25ircNMXt
	P5ydF0tFBsYSp9qVufDGog0SAem++9biJ4HJOuQPfjcnqLO787adOvpV4bvKu5ASo84nblGTTueC5
	nBQZzbYTHyHDN8euRKTC+HuQgj0QoRjZ9C1sZ9uuxc9++hhZQCKIv08M+30i0RHAl+LOtRb+pt27W
	Kq3G+gOCrRqY97cgwcrWYM6kgZ9mHLPKjUqIDImsN9gowJ5ryaSKDP9jyXl8q1sqmn++wUEKwV0Pc
	s97m3nfA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqC3g-000000017CU-0a7Q
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 14:18:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B41668AA6; Thu,  6 Mar 2025 15:18:38 +0100 (CET)
Date: Thu, 6 Mar 2025 15:18:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <20250306141837.GA21353@lst.de>
References: <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com> <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me> <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de> <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de> <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_141844_306944_81C03144 
X-CRM114-Status: GOOD (  12.11  )
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

On Thu, Mar 06, 2025 at 08:12:03AM +0100, Hannes Reinecke wrote:
> Single ported.
> There is a range of Samsung NVMe where one is a normal, single ported,
> NVMe, and one with a nearly identical model number reporting CMIC.
>
> Causing _quite_ a lot of confusion with the customer (and L3) when
> used under MD, as for the first hotplug works, for the second ... not so 
> much.

If the device is indeed entirely single ported and Samsung can confirm
the setting is incorret and not easily fixable by a firmware update
we can quirk it.


