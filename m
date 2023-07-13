Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B4C001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cxp9+COznwbTgYfW9nqSCY9XZ4iLnNgxeafAem4NdlY=; b=knye4OlTTHAHhHp0ikxQQVErRv
	0qRzaiCKNolZhw7u2FRnRroVLyVGPtgg8/J0QZvDFSJpZq0amczeUKk0ewUd0rCKMUCDipxgUVqDO
	Wql0KUSsFc2gTvb0suMd0spyHe0FX8TRquLzW0HkBuP5rnSNqgVEmy9PxjF3V2BQmX6f30lrgYxBB
	uE4j8kpZC76qqAX8Yyl1gsAYLrxbrBbv0rs3zReAo/SnUifwTtTN4SKw2WU6WXuYPi6IG2UGZH8w+
	rXrMy8Glbaw/i9ib/WJxINq1Gy+MhlPEh3Br0Nwb7cToexExMi5vGPJITkTFvyXfI7l1/NFXKUNn8
	XJ+W3aYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJwx8-003VH8-0r;
	Thu, 13 Jul 2023 14:05:54 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJwx4-003VDq-1m
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 14:05:52 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230713140523epoutp035616e4a97a126455c61a0771e5ab862b~xcmdLA8vQ1998019980epoutp03M
	for <linux-nvme@lists.infradead.org>; Thu, 13 Jul 2023 14:05:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230713140523epoutp035616e4a97a126455c61a0771e5ab862b~xcmdLA8vQ1998019980epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1689257123;
	bh=Cxp9+COznwbTgYfW9nqSCY9XZ4iLnNgxeafAem4NdlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g8ax/RmueYeDRDWc9Bq7fGFvgMVsBHKPBaUr+XQAMwN8H/oi5zgBVebwhXcONdw+Q
	 kWqJsTmS7F2KE1kLhaNO6t3/XR0oGplZhjjWC/EY914mncCgYQ/si4IX5Ku2n1ZGAH
	 w2cRKdns+ZITnKddYe4N+ZXWcaKJALm+8klil234=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230713140522epcas5p1f5a3c0c7f854951c7d68a43042ae3a5b~xcmcE4-mm1852618526epcas5p1a;
	Thu, 13 Jul 2023 14:05:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4R1xFr6X86z4x9Pp; Thu, 13 Jul
	2023 14:05:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.4D.06099.0A400B46; Thu, 13 Jul 2023 23:05:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230713140520epcas5p1e6e9a481ab9e8d8976f946a49fc0c5e5~xcmaU_e5h1921519215epcas5p1Q;
	Thu, 13 Jul 2023 14:05:20 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230713140520epsmtrp1c04505c45d3381a405dd36a005ea13f9~xcmaUGtVb0036500365epsmtrp1p;
	Thu, 13 Jul 2023 14:05:20 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-6c-64b004a07f44
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.E9.64355.F9400B46; Thu, 13 Jul 2023 23:05:19 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230713140519epsmtip1e75fc262b7c65736a9191842d73ebee1~xcmZbMERP0745507455epsmtip1l;
	Thu, 13 Jul 2023 14:05:19 +0000 (GMT)
Date: Thu, 13 Jul 2023 19:32:06 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: don't reject probe due to duplicate IDs for
 single-ported PCIe devices
Message-ID: <20230713140156.GA2143@green245>
MIME-Version: 1.0
In-Reply-To: <20230713133042.3981-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTS3cBy4YUgweH9S1W3+1ns1i5+iiT
	xaRD1xgt5i97ym6x7vV7FgdWj/P3NrJ4XD5b6rFpVSebx+Yl9R67bzawBbBGZdtkpCampBYp
	pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
	6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnzF/TzFrwjKPi
	SbdtA+MO9i5GTg4JAROJa0+fsHUxcnEICexmlLi5sA3K+cQocfb7O0Y4Z+u8PaxwLUfeQ1Xt
	ZJR4vGA3O4TzjFGif8ZKsMEsAqoS/1oXM3UxcnCwCWhKXJhcChIWEVCSePrqLCOIzSwQJbG4
	/T8TiC0skCzR8OE82AJeAR2JyRfPsUHYghInZz5hARnDKaAvsflhHkhYVEBZ4sC240wgayUE
	3rJLtD06wgRxnIvEw3cXoX4Tlnh1fAuULSXxsr8Nyk6WuDTzHFR9icTjPQehbHuJ1lP9zBC3
	ZUj8W/IE6k4+id7fT8BekRDglehoE4IoV5S4N+kpNEzEJR7OWAJle0i8ffwGbKSQQBOjxJIz
	ThMY5WYh+WYWkg0QtpVE54cm1llAG5gFpCWW/+OAMDUl1u/SX8DIuopRMrWgODc9tdi0wDgv
	tRwew8n5uZsYwWlRy3sH46MHH/QOMTJxMB5ilOBgVhLhVdm2LkWINyWxsiq1KD++qDQntfgQ
	oykwciYyS4km5wMTc15JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxS
	DUwld6/0uQVWpojd2bRm3wlWi8CN69d1Tp/hv2HrsyefzVr/vF7+pf79stS5TtELGN9XWPxQ
	+7ZPouZBgJdtj75I4/lti5YF+jQ57uAN3Pvpz7J3cxYsuVLJm33YZ+q/hed3PvnHOPmWrt36
	Z9kycxkCne0lpuvzVnT1upd2H9ZzznZK07Oy266q9q9u8w5nvswpxje0T8oybFV27OW9s8Vj
	39urIvNjzN+zpLD/mTtb62pzDZeQtO+r10mRYUuPsNZXz038JFrt0Gp18gbjv6/J8hNWnDP3
	8mlZbffuY8HvQ7aJaQXmYQYHZokaO+/9GWByp+f8lZf7jpYs6hSwPFqVlGJ26sjXuVfvzvVf
	bNapxFKckWioxVxUnAgA75+frRQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnO58lg0pBud/2lisvtvPZrFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTxuHy21GPTqk42j81L6j1232xgC2CN4rJJSc3JLEst
	0rdL4MqYdPc2a8EMtoqlaz6xNDC2sHYxcnJICJhIXDvyng3EFhLYziixanM1RFxcovnaD3YI
	W1hi5b/nQDYXUM0TRon7rf/AmlkEVCX+tS5m6mLk4GAT0JS4MLkUJCwioCTx9NVZRhCbWSBK
	YnH7fyYQW1ggWaLhw3mwVl4BHYnJF8+xQcxsYpS4uuQHC0RCUOLkzCcsEM1mEvM2P2QGmc8s
	IC2x/B8HiMkpoC+x+WEeSIWogLLEgW3HmSYwCs5C0jwLSfMshOYFjMyrGEVTC4pz03OTCwz1
	ihNzi0vz0vWS83M3MYIDXCtoB+Oy9X/1DjEycTAeYpTgYFYS4VXZti5FiDclsbIqtSg/vqg0
	J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgUnOeunN3yFGU7abHwxprOmce/AY
	88aVc71Mq77t3hG2MVEwNnaZuM+5J8v99ogJOQhu2b7e6Pr1txk/br87X7xJMT/87JKNtkez
	VlTkb1p1YKVO1i2xA2fNny9QEty88dyx5H03pJ933tqgdON8s/oCNnm/NVuDLjz8sKI8O6HE
	5FDFrr8qFX6fHkg1rVF+/Y1j9uWYGWIra953sZilGhrJtB+UVXFbHbz2jel2y/srY75utpjm
	NdHa6V/ytM6XIWJTys62OMjMO9tpXr307EPf66tz9Xdcv9m1K+9AitvTKYvuXj7du0jv2c/N
	107O5md84HRj6o2Cas/19kcWNyafurVCzfas7bwljPzLPufUSyixFGckGmoxFxUnAgBO39TW
	3wIAAA==
X-CMS-MailID: 20230713140520epcas5p1e6e9a481ab9e8d8976f946a49fc0c5e5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----zUAFM1k0MeHfMyR4CoO9aTysOnQiUYGsRe6BfqD0GhfqR3ws=_48889_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230713133859epcas5p2b0de1a117d69f54f2d1dcf027f73afef
References: <CGME20230713133859epcas5p2b0de1a117d69f54f2d1dcf027f73afef@epcas5p2.samsung.com>
	<20230713133042.3981-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_070551_211675_DF3FF248 
X-CRM114-Status: GOOD (  12.71  )
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

------zUAFM1k0MeHfMyR4CoO9aTysOnQiUYGsRe6BfqD0GhfqR3ws=_48889_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Jul 13, 2023 at 03:30:42PM +0200, Christoph Hellwig wrote:
>While duplicate IDs are still very harmful, including the potential to easily
>see changing devices in /dev/disk/by-id, it turn out they are extremely
>common for cheap end user NVMe devices.
>
>Relax our check for them for so that it doesn't reject the probe on
>single-ported PCIe devices, but prints a big warning instead.  In doubt
>we'd still like to see quirk entries to disable the potential for
>changing supposed stable device identifier links, but this will at least
>allow users how have two (or more) of these devices to use them without
>having to manually add a new PCI ID entry with the quirk through sysfs or
>by patching the kernel.

Should this go for backport? For the commit 2079f41ec6ffa.

------zUAFM1k0MeHfMyR4CoO9aTysOnQiUYGsRe6BfqD0GhfqR3ws=_48889_
Content-Type: text/plain; charset="utf-8"


------zUAFM1k0MeHfMyR4CoO9aTysOnQiUYGsRe6BfqD0GhfqR3ws=_48889_--

