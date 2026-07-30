Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179F2C531D0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 05:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZQ2NeIfDeMbFrQISIIna9nthNyClUZOb6CjUd6dHoI=; b=soDZzb/8aZVP4urvJRHyLJR16U
	SIeIyihKZfo4HCGgREUaLOQL1LthQFP3qIXjzWfkn3MKDWiNiDeFsRC7o8UEEv+7dFZ/0Fs7ZL9gY
	otVN6QcEr+E1/Uu7Jz+mhMWnGJP4I3LjQsmKjBFi99Yu7RB9BpYxhAEITaXtvOWrAiGgWincFoF81
	ehoKUT7VGIHZBy3uKadbdJKS0BEgEiNCGOeMG0PuTZHe4k1LV0uKEuHc8nUN+X75m4SK41d4rKd3X
	AmPYqsER8Mf3d5qO7PaL7icDRBW0lzC0QxPhhbAFPbEvYCg1GcEy/+ia72K/Qhj82t+wX/OVtbDry
	Pw07NVZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpJ3y-00000009X6P-1cB1;
	Thu, 30 Jul 2026 05:12:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpJ3u-00000009X5Y-2vfN
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 05:12:09 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260730051201epoutp012daab18d290218f8f07e5071d94e5f22~G_Tf3Y-JG0412104121epoutp01r
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 05:12:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260730051201epoutp012daab18d290218f8f07e5071d94e5f22~G_Tf3Y-JG0412104121epoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785388321;
	bh=cZQ2NeIfDeMbFrQISIIna9nthNyClUZOb6CjUd6dHoI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Nk6nvWDWgWWnoXqr3/NFZo6uonvps8BFRYUQ6CzDyzk4OAeT80GxViaYnZpii9o68
	 E50MMFEgqiWya67nDuFRzjCP4jqjYX7BSHeiNZxXOdpyMt8C0q26G11yrmitx3NYue
	 Ar3OzVH/NvnnlOqKlaUxu4f5s+LkmOnmDE7FoVEU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260730051200epcas5p3ddb641b948fead3a225d71dc08e1b849~G_Tfc607q2069920699epcas5p3d;
	Thu, 30 Jul 2026 05:12:00 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4h9ckl1s1hz3hhTB; Thu, 30 Jul
	2026 05:11:59 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260730051157epcas5p155ebe29610e80986741841a2cea9a26e~G_TcZ5DE40525805258epcas5p1G;
	Thu, 30 Jul 2026 05:11:57 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260730051155epsmtip2fc65bae29bda0faa320c7c1128871378~G_TbFS38F1790217902epsmtip2S;
	Thu, 30 Jul 2026 05:11:55 +0000 (GMT)
Message-ID: <f6c67294-adad-4d77-b8cc-a29447506496@samsung.com>
Date: Thu, 30 Jul 2026 10:41:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: fix racy access to FDP placement ID array
To: Hari Mishal <harimishal1@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <CAMmC+=ApjmaGpnsxYBo7C-0BsROWJ=ffDc9FQSs9fn4wr7Amxg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260730051157epcas5p155ebe29610e80986741841a2cea9a26e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260725135125epcas5p26801513d440f066295ef2d44035ce3db
References: <20260725135111.14041-1-harimishal1@gmail.com>
	<CGME20260725135125epcas5p26801513d440f066295ef2d44035ce3db@epcas5p2.samsung.com>
	<20260725135111.14041-2-harimishal1@gmail.com>
	<7c3e3243-0c9a-436b-b5c2-e6092e181435@samsung.com>
	<96dadac7-a072-48ba-b282-356d29ed789a@samsung.com>
	<CAMmC+=ApjmaGpnsxYBo7C-0BsROWJ=ffDc9FQSs9fn4wr7Amxg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_221206_901239_F7DEF0A2 
X-CRM114-Status: GOOD (  14.05  )
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

On 7/29/2026 5:17 PM, Hari Mishal wrote:
> Hi Kanchan,
> 
> I think your patch does solve all the problems. Should I resubmit the
> patch as a V2 or a new one?

If you want to send, v2 with the changelog is better.
Since this is a fundamentally different approach from the original, 
maybe keep me as the author. And your reported/tested-by/fixes tags.

Or, let me know if you'd like me to respin.

