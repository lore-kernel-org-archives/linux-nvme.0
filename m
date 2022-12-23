Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B1C3DA7D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hUea9WDVSuNDkmeR16sw0DHjxwxbUv6Oo+mHubB57HU=; b=ERG5+/lXgBGqi9UPYaPWIMOfH+
	/3XTM3Dtcfli48+h3pW6oRG5r1mrXM/IAuPsAO5I2gzM6FcabXkikyfBUptNKbsDHFW8lnauHQgXh
	vQBhVGRdzJ1D1uaRkuhGaw2vQlV+4pEO9mP+HYTZVSGRp3X9n7jw1kG87rFHGaVJYb8A8RkHUFAke
	gIHFsp16x/cmsi0FRGHuUMR6csaxHmRoSOx/4wE+19sRM9LOBUsHbDeR4Dckp7bi/N7k+LUyBKnH4
	4R6axhRFMuqLEjYwM8DxPBP8MfrrR3Gn7vjyspGoX3kfybTMU1VJ12K/jz19lqq7XxeWF+Diki3TK
	KAsX/vcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8i6x-008PCd-UX; Fri, 23 Dec 2022 13:29:19 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8i6p-008P8V-B3
	for linux-nvme@lists.infradead.org; Fri, 23 Dec 2022 13:29:14 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221223132903epoutp04ce9d63e2aa290946fc015280edcb191a~zbzEITMES1044710447epoutp04d
	for <linux-nvme@lists.infradead.org>; Fri, 23 Dec 2022 13:29:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221223132903epoutp04ce9d63e2aa290946fc015280edcb191a~zbzEITMES1044710447epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1671802143;
	bh=hUea9WDVSuNDkmeR16sw0DHjxwxbUv6Oo+mHubB57HU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FuYxk+r/6rVwP7NFlglYLyCun19a9icH4j+M8x2h5q5xF6TUEZNixA8O4fVs3Ah7H
	 oH4tpZTRA+KWKYIkOUQREFXusizCuBeu0814ph+ReR5CfFpMJiiu42FXzihLk+M18V
	 Mt/u8rWUgFacuPgQzJqNFV45M44YcjIcGxKc2DD0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20221223132902epcas5p48f80ec9d67436784e2e5ae9b7a520f3d~zbzD7d6QR0331503315epcas5p45;
	Fri, 23 Dec 2022 13:29:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Ndp19133xz4x9Pt; Fri, 23 Dec
	2022 13:29:01 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1B.AB.02301.D1DA5A36; Fri, 23 Dec 2022 22:29:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221223132900epcas5p37cc86565ebc3c7ef700ffd163f91c177~zbzCGy9Tl1020710207epcas5p3c;
	Fri, 23 Dec 2022 13:29:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221223132900epsmtrp1081cc41c3d791b882518add7d9394d8f~zbzCGIWwO0384803848epsmtrp1h;
	Fri, 23 Dec 2022 13:29:00 +0000 (GMT)
X-AuditID: b6c32a49-201ff700000108fd-f1-63a5ad1db2cc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.B3.02211.C1DA5A36; Fri, 23 Dec 2022 22:29:00 +0900 (KST)
Received: from green (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221223132859epsmtip1bb71a6b7183a4765d679e37ef5138689~zbzBRY9Wu1455314553epsmtip1E;
	Fri, 23 Dec 2022 13:28:59 +0000 (GMT)
Date: Fri, 23 Dec 2022 18:58:56 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: only allow unprivileged passthrough for commands without
 effects v3
Message-ID: <20221223132856.GB27984@green>
MIME-Version: 1.0
In-Reply-To: <20221223074545.GA5356@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTQ1d27dJkgz2vWS1Wrj7KZDHp0DVG
	i6dXZzFZzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRmXbZKQmpqQW
	KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
	K+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ+w9upex4DVL
	xdTLPewNjLNZuhg5OSQETCRuTv3E2sXIxSEksJtRYuGNp1DOJ0aJezN+MkM43xglji7YzQbT
	cnTTE6jEXkaJntlNjBDOY0aJvxf3M4NUsQioSty8NwcowcHBJqApcWFyKUhYREBJ4umrs2D1
	zAI9jBLn2leygiSEBYIk9r1fywhi8wpoSZyfOYMZwhaUODnzCdixnALaEo+WzgarFxVQljiw
	7TgTyCAJgbfsEmd3/YH6yEXi55Yn7BC2sMSr41ugbCmJl/1tUHayxKWZ55gg7BKJx3sOQtn2
	Eq2n+sEWMwtkSLQefQRl80n0/n7CBPKMhACvREebEES5osS9SU9ZIWxxiYczlkDZHhJnvh+E
	htBhRokPB8+wTGCUm4Xkn1lIVkDYVhKdH5pYZwGtYBaQllj+jwPC1JRYv0t/ASPrKkbJ1ILi
	3PTUYtMCw7zUcngsJ+fnbmIEJ0gtzx2Mdx980DvEyMTBeIhRgoNZSYR3y+PFyUK8KYmVValF
	+fFFpTmpxYcYTYHxM5FZSjQ5H5ii80riDU0sDUzMzMxMLI3NDJXEeVO3zk8WEkhPLEnNTk0t
	SC2C6WPi4JRqYLL0Of5No+Sd7p83vguZRHskOTfq5V/f+TG3KOloTLZ+a/dRq+XpIiUbum4J
	v3DujSyPkLw8PWr+Ntnuin9VkjUC+98kNHD2lzjuWev1+Nqm6wti5Hu2vHHUO1tvtFTt/+cf
	v/kUM9MM71WkRLmvte058fpXRrsZjz5n5R4W/w16W0611r6YJlC/RW2dAYOy8VQx96b10x+f
	OvNnqd3ezdkbTs11WcMUcXJj1nfhLYon8sx7nnw1r5qelzMzt3nRmZtGXyNE/2/bo7CoOihu
	12w1/hNGk0qcHPv25/tti3m537drzRsey3D3kEPO97iXpr48ucZuhsVM6cRvU7WCr/VYPlvg
	9LOV59XfO4eKYpRYijMSDbWYi4oTAZxOnmQZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnK7M2qXJBnt6DC1Wrj7KZDHp0DVG
	i6dXZzFZzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRnHZpKTmZJal
	FunbJXBlbDq+l61gLlPFhIM3mRsYnzN2MXJySAiYSBzd9IQZxBYS2M0o0TU1EiIuLtF87Qc7
	hC0ssfLfcyCbA6jmIaPEHm6QMIuAqsTNe3MYQcJsApoSFyaXgoRFBJQknr46CxTm4mAW6GGU
	ONe+khUkISwQJPHy6n6wVbwCWhLnZ86AWnuUUeLSiXqIuKDEyZlPWEBsZgEziXmbHzKDzGcW
	kJZY/o8DJMwpoC3xaOlssJGiAsoSB7YdZ5rAKDgLSfcsJN2zELoXMDKvYpRMLSjOTc8tNiww
	zEst1ytOzC0uzUvXS87P3cQIDnQtzR2M21d90DvEyMTBeIhRgoNZSYR3y+PFyUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwTb9ZY/YhOWBeSY+IyKHD
	lryR/xzPfxH6JtHBUetQVT07Y9aKLRcyWM2ETjJ7eO+ZlVAommWSs4JT55WgN9/7/F7OSUbf
	j5X909fZ/vn7vbP5K3+yWa5nWJ0j+iD+6+UDs7SYjbI3/H1y5tJHy+U3V+35ukjA8cI9s8TE
	sD2JEecE4+avFGxPY+ISk3gw7c7Js23Vc2+Yr2FPTlDr+LB/57Wqxx+ztH9ufZQxdZ9x9/u1
	n+YXeFYK65Xu81WZlXT5nbJu5xXGp3/606VPrHr3rzL2OOs3a7nDgRPrK62fnzygmvvU82HZ
	hZu7m3Znqe5/Vv+q4r5iZ/Wmpp27JijuifAN6kzek1S/buust9ejM5VYijMSDbWYi4oTAVp8
	AaHjAgAA
X-CMS-MailID: 20221223132900epcas5p37cc86565ebc3c7ef700ffd163f91c177
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_558d4_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221221145321epcas5p4ff234021b074bf0a513d1cb233135656
References: <CGME20221221145321epcas5p4ff234021b074bf0a513d1cb233135656@epcas5p4.samsung.com>
	<20221221101050.759606-1-hch@lst.de> <20221222081904.GA4413@green>
	<20221223074545.GA5356@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221223_052912_938243_1C118917 
X-CRM114-Status: GOOD (  11.00  )
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

------dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_558d4_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Dec 23, 2022 at 08:45:45AM +0100, Christoph Hellwig wrote:
>Btw, any chance you could write some tests for blktests to verify
>the unprivilged passthrough operations?

Good point, will look into that.

FWIW I tested v3 with fio/liburing test and few nvme-cli commands. 

------dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_558d4_
Content-Type: text/plain; charset="utf-8"


------dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_558d4_--

