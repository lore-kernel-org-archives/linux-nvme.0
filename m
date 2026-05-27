Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52019CD5BDE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fu7SwKejosxfShWByynM9fz41NNpN22/tzNj47zEmCA=; b=tweGVsjIzZtdVvE7pzZlZuoayy
	/JEiPxH1XtgcPJNgnpROkvjm/ADdobF/OQeM42AR07sBXb6bjHUeXEOWuioK1vqLAl9yZkZ6iYPZ7
	nSEIjdw7hhUTRJNZFwZ1aWWpFnrGHnIJEwOaWAnP/103WuYZklM6przRFS5OfJTxAt9gCwZMSEtz0
	VPXrIk26zmC/4OCWYJL/w+wK6d/FkTgmpoTYLcchz1QuCD07p7JT0PLxi0tI6TpKNgQgmhL/B/pee
	lTNRbfveuZ6PGRxcXs33slAvEVj+ydwFbW06CTry0MlE0DSbdFLRzJeEBgQsGx/cW78E0EpTOH3Sp
	pAlPw+pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSA7y-00000003aTi-15Wu;
	Wed, 27 May 2026 09:00:38 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSA7v-00000003aSq-0aYH
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 09:00:37 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260527090028epoutp03998ad0e2678703471b47bb6328403fb3~zYIsMZxgg0148101481epoutp03W
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 09:00:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260527090028epoutp03998ad0e2678703471b47bb6328403fb3~zYIsMZxgg0148101481epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779872428;
	bh=fu7SwKejosxfShWByynM9fz41NNpN22/tzNj47zEmCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DKRC2pcr/yR/eZ7ksmyrKhSMT/o0+dUa1hMDg0EwhLd/ncvxx0SXLhPDCNGaQGvfO
	 GOwpgNa8aEKSgQW0qnKAxOJjhlqvvzvdL9IKELxi8SrW2ku+3XlKK422qHX7A9k2wL
	 SMBcvrX6Zzg8AnoaUQmrp3uN8j1TX0dnCCqCibeI=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260527090027epcas5p436bdc6377520ea93446b51a6d90854e2~zYIr8KXnC1883018830epcas5p4_;
	Wed, 27 May 2026 09:00:27 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4gQNqt5znmz3hhTD; Wed, 27 May
	2026 09:00:26 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260527090026epcas5p301bb017af42ab37a1e69e50b30df387e~zYIqnJkg80631506315epcas5p3Y;
	Wed, 27 May 2026 09:00:26 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260527090023epsmtip18188aa832c83ce4c7ff9f98273772c32~zYIoYRz5_2415224152epsmtip1Q;
	Wed, 27 May 2026 09:00:23 +0000 (GMT)
Date: Wed, 27 May 2026 14:23:56 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: liuxixin <gliuxen@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: fix FDP configuration log parsing
Message-ID: <20260527085356.qbbhjglmvmg35pna@green245.gost>
MIME-Version: 1.0
In-Reply-To: <a989258938de2d1fb01e70fd5ea2e50185cc6899.1779848573.git.gliuxen@gmail.com>
X-CMS-MailID: 20260527090026epcas5p301bb017af42ab37a1e69e50b30df387e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----.QJaJpFk2dExoxNM_QAx5.J_4xoCBWJDLrNtQrOUGpq3YaPW=_800e3_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260527090026epcas5p301bb017af42ab37a1e69e50b30df387e
References: <ahWw_09BJkQi9zQe@kbusch-mbp>
	<a989258938de2d1fb01e70fd5ea2e50185cc6899.1779848573.git.gliuxen@gmail.com>
	<CGME20260527090026epcas5p301bb017af42ab37a1e69e50b30df387e@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_020035_671381_D5724AF4 
X-CRM114-Status: UNSURE (   8.36  )
X-CRM114-Notice: Please train this message.
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

------.QJaJpFk2dExoxNM_QAx5.J_4xoCBWJDLrNtQrOUGpq3YaPW=_800e3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 27/05/26 10:29AM, liuxixin wrote:
>	<cover.1779848573.git.gliuxen@gmail.com>
>From: liuxixin <gliuxen@gmail.com>
>Date: Wed, 27 May 2026 10:22:32 +0800
>Subject: [PATCH v2 1/1] nvme: fix FDP configuration log parsing
>
>The fdpcidx bounds check sets n = NUMFDPC + 1 but used > instead of >=,
>incorrectly accepting fdp_idx when it equals n (i.e. NUMFDPC + 1).
>
>Also validate descriptor sizes while walking the list so dsze == 0 or a
>descriptor past the log end cannot cause unbounded iteration or reads past
>the buffer.
>
>Fixes: 30b5f20bb2ddab013035399e5c7e6577da49320a ("nvme: register fdp parameters with the block layer")
>
>Signed-off-by: liuxixin <gliuxen@gmail.com>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------.QJaJpFk2dExoxNM_QAx5.J_4xoCBWJDLrNtQrOUGpq3YaPW=_800e3_
Content-Type: text/plain; charset="utf-8"


------.QJaJpFk2dExoxNM_QAx5.J_4xoCBWJDLrNtQrOUGpq3YaPW=_800e3_--

