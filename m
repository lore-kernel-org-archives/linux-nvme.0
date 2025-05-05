Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C93C3ABB0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=wsdRjg0wTbG5mwjlM4FzD7c683
	i+68N+BCuhy6PeRzS6KlWHvUwXtU4y9V91JGGLkmpby01c6VsVmSskZd0TuAVyE/EhS6nIjKFm6qr
	Zu+zpNnAA+xis3YUqVRyyOVjj1Mp5oyH6FVZsQgcONLhgjpR+Od40UO8mw5E2WpOOTjQrl0fnSYjn
	K2c/rJclF8Vn/XUkon/BZiu/lDVRaARu6iqxriV3ZaOPUB50n2j67geV90hB2b9W1XJjDXA8Jopvm
	/oyRjnffgBCkDaw/ixdmd7SJ3mA3mn5J3wMXdFdqXuSNTrKX1juaSSfo9lkLCojf6+1/OKLKqHF5z
	/0r8FLgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBtDL-000000074It-2mYB;
	Mon, 05 May 2025 10:38:23 +0000
Received: from [203.254.224.34] (helo=mailout4.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBtBa-0000000745J-2PAS
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 10:36:39 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250505103629epoutp04564b3e07e9fcfa83551213fcff8b7922~8mzDX5G0_1392013920epoutp04h
	for <linux-nvme@lists.infradead.org>; Mon,  5 May 2025 10:36:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250505103629epoutp04564b3e07e9fcfa83551213fcff8b7922~8mzDX5G0_1392013920epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746441389;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=E9wpWJoQden2vOwQw51YNjmTXEiRBr3KZ+SaMz6SG7eJNJoliQk7TCFjWZbRurqsS
	 wBhlUUnmVvvcq9fo20wAgewWlAk3uYIybwv+d5gHTuRsuuoHKGayf78GCKwJE3lTFf
	 AIr03QsArPjyBAKhNIA4n5zoIxFdLCbvnODkz3GA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250505103629epcas5p2cebdec83246112bd0d618da720615dc2~8mzC6NrOm3077230772epcas5p2S;
	Mon,  5 May 2025 10:36:29 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.181]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZrdHJ35VTz3hhT3; Mon,  5 May
	2025 10:36:28 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250505103627epcas5p1321c559fa1d43e6ba3bc1987ebb8fd26~8mzBtX5qd1445214452epcas5p1u;
	Mon,  5 May 2025 10:36:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250505103627epsmtrp1e1065657d498c1112dcd9b1cf10f2f61~8mzBssUsg2818828188epsmtrp1K;
	Mon,  5 May 2025 10:36:27 +0000 (GMT)
X-AuditID: b6c32a2a-d57fe70000002265-05-681894abe4ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	96.D7.08805.BA498186; Mon,  5 May 2025 19:36:27 +0900 (KST)
Received: from [107.111.89.174] (unknown [107.111.89.174]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250505103626epsmtip2ad9941614a8c1952e2de724a5c9e89fb~8mzALBqRt2714027140epsmtip2q;
	Mon,  5 May 2025 10:36:26 +0000 (GMT)
Message-ID: <cf6cda9b-bbbd-43c2-b67b-297cc64e671d@samsung.com>
Date: Mon, 5 May 2025 16:06:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dmapool: add NUMA affinity support
To: Caleb Sander Mateos <csander@purestorage.com>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Andrew Morton
	<akpm@linux-foundation.org>
Cc: linux-nvme@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250426020636.34355-2-csander@purestorage.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO7qKRIZBiuvaVrMWb+GzWL13X42
	i/8L57JarFx9lMli0qFrjBaXd81hs7i35j+rxfxlT9kt1r1+z+LA6XH+3kYWj8tnSz02repk
	89j0aRK7x4kZv1k8Ni+p99h9s4HNY9vDXnaPz5vkAjijuGxSUnMyy1KL9O0SuDJO7VjKVGBU
	cW1uH1MDo24XIyeHhICJxK2J19i6GLk4hAR2M0psf/ibHSIhLtF87QeULSyx8t9zMFtI4C2j
	xLf/fCA2r4CdxJSzHWBxFgEViYNfH7FBxAUlTs58wgJiiwrIS9y/NQOsRhio/sz7Tcwgy0QE
	HjNK7Dr9jRkkwSwQJtHybykjxBWHGSV+/1vADpEQl7j1ZD5TFyMHB5uApsSFyaUgYU4BW4mb
	F96yQJSYSXRt7WKEsOUltr+dwzyBUWgWkjtmIZk0C0nLLCQtCxhZVjFKphYU56bnFhsWGOWl
	lusVJ+YWl+al6yXn525iBMealtYOxj2rPugdYmTiYDzEKMHBrCTCG2MgnCHEm5JYWZValB9f
	VJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QD04z8pV91+DmPu9VV72mrtbL0
	fyIVXR+s/n3P06T3S3YujtSVCNY5ybEoqqCUby2nzhpJqyWHndz/vvtpuq35tMDaz5v2b/bR
	u1nRlN0kZ8bR5b38lXloW8HugJLk5JfOa+Yu17Y/w5q5YvWjB50+gsIsbWoF15P+HDmy0T+d
	d1J8lgjvzA9ZbQXFrCkhnf92rbDVv1ucfH+JfP8MgQleCxrU1uoLrJ2genTjr5PaPWzsqtsO
	Xct4z3uRobZ06VnPkhPcq9s13l6f871f6mqubetT2ywDTmmBi2s6TqV3lx/cOL3bh8Mloior
	pqzMcsXWl3Gq+3tmvPAsuWqpahR1IDZ429SOcO7JvRPsf9UpsRRnJBpqMRcVJwIAKTObNiQD
	AAA=
X-CMS-MailID: 20250505103627epcas5p1321c559fa1d43e6ba3bc1987ebb8fd26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250426020759epcas5p1f4717e48a5969fc951c17e22bb02b32f
References: <20250426020636.34355-1-csander@purestorage.com>
	<CGME20250426020759epcas5p1f4717e48a5969fc951c17e22bb02b32f@epcas5p1.samsung.com>
	<20250426020636.34355-2-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_033635_292723_45AAB579 
X-CRM114-Status: UNSURE (   8.98  )
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

