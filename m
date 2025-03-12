Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52383C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 05:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ngAEhgKY4Clg2d4DtzVaHOsEC7Gc3MfDDpegS4C4r/A=; b=1iuLDddGXKoPrK9WGyqcimrrUX
	eJBtKK6pDQw28ysccaQIglYAKqtPgAVYkvltkzo2tZ8tAv8zEt3/dL837D7094oU93wbw4TfJltcZ
	DkFVo1ZqNln/48NTl26fxVGVhT71MXoMlZYXVIMJ73hFMhNVry6ozwF3/Ut1ilZ77gENVxeC9OQ64
	MluchtY46dqQYU0JPfbmKpiz4830P5Grt4ukZqdICtSPn+Z1V6e2AgQptfwcZzVIiGoRhxmiHFrsw
	SfusfU/4YeJGWcxIM1lMYuq6AcvLpSlBEXYGYEMyWw1YbD1QqvLgiUeGNNnQ/O/90RVrIUBtataAG
	Q7qGNXJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEWW-00000007Vpp-2Iog;
	Wed, 12 Mar 2025 05:20:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEVn-00000007Vip-2zk5
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 05:20:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C2DB68AA6; Wed, 12 Mar 2025 06:19:59 +0100 (CET)
Date: Wed, 12 Mar 2025 06:19:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	loberman@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM
 config option
Message-ID: <20250312051958.GA11824@lst.de>
References: <20250228032541.369804-1-jmeneghi@redhat.com> <20250228032541.369804-3-jmeneghi@redhat.com> <20250305143353.GB18526@lst.de> <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_222011_895691_CAF1AC59 
X-CRM114-Status: GOOD (  11.78  )
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

On Tue, Mar 11, 2025 at 10:35:40PM -0400, John Meneghini wrote:
>> What's the point of adding yet another confusing option?
>
> If you'll read the kConfig description, hopefully it's not confusing.

It still is.

> The whole point of this patch series is to remove the core.nvme_mulipath parameter.

Why would a compile time option be preferable over a runtime one?


