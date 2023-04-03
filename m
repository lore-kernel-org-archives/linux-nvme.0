Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5714CC761A6
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 08:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VmzGLzECXb2L3bmIxAT7Rjhm8GFDndrmGlQzPL+eJZM=; b=0vBERinpJjg6sVg7T4SWA4RONo
	M2LivQP9Vm0h13OUk2NQ6QBm0u2epx9eRuVkw0FjUbS+btTzxqxjsrNwk0TfE5Fvy2EFlZ4D80w+x
	HyRWUzofhUdCQdXVONlkwGM5pdmmbtwuoto+Pq04ZqZkgUGlLPew24981lFILkA0CzWR5rtF98S9s
	F2SyfzbM2r7BsIEwDO6oFUq5IEg1SztrPRF3QQfYWDzDLvgMCIfBeUDCReZevXMWwvvipKkXBdzwc
	ON9SEHhXReHoQKuwuxHXjbOy2Gb3Oofi76GCxorty1COY6xTHveQC9Bwzx/FUcZeGwmFHW7QZrNwm
	t2xOzbHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjFeR-00EY1q-2u;
	Mon, 03 Apr 2023 08:34:55 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjFeL-00EXzV-1c
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 08:34:54 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230403083443euoutp027e08300764bebd5fe2a2f20a629105fd~SX77ENIGp1840718407euoutp02s
	for <linux-nvme@lists.infradead.org>; Mon,  3 Apr 2023 08:34:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230403083443euoutp027e08300764bebd5fe2a2f20a629105fd~SX77ENIGp1840718407euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680510883;
	bh=VmzGLzECXb2L3bmIxAT7Rjhm8GFDndrmGlQzPL+eJZM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qIvIf23iWK8+2y2rN23p+EAZV5a59JW+wVqAw1mDZ/f0DoRsooY2RMOT13hBmXbOO
	 rNY5pcsYHnr1qHVe3W264icq73EuCd8NLk3xVs4moOYhDCjJbV1AlDquYPycKij6Iv
	 7W5E+aMbsY0BBa+gDDgk+1Cakp9a8MftYUVQmOe4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230403083443eucas1p172635d42a48d48724cb678ff12d6e83d~SX766ZdyN0237702377eucas1p1v;
	Mon,  3 Apr 2023 08:34:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E1.2E.09503.3AF8A246; Mon,  3
	Apr 2023 09:34:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230403083443eucas1p225993f889610c6c070dcb24e232aa526~SX76fNLvp0919609196eucas1p28;
	Mon,  3 Apr 2023 08:34:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230403083443eusmtrp13ec1bae85b2186c793ac39abc932aa52~SX76ei9zf2966929669eusmtrp1_;
	Mon,  3 Apr 2023 08:34:43 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-75-642a8fa377a0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A3.4A.09583.3AF8A246; Mon,  3
	Apr 2023 09:34:43 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230403083443eusmtip2b7c02911f5df4bd1b74ab9b875858325~SX76VkWuH0174301743eusmtip2O;
	Mon,  3 Apr 2023 08:34:43 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 3 Apr 2023 09:34:42 +0100
Date: Mon, 3 Apr 2023 10:26:13 +0200
From: Pankaj Raghav <p.raghav@samsung.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, <p.raghav@samsung.com>
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Message-ID: <20230403082613.owr5wshccoy2uw4z@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230331221823.2806192-2-alan.adamson@oracle.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOd3F/VopBt3dqhZ7+k8xWaxcfZTJ
	YtKha4wW85c9ZbdY9/o9iwOrx/l7G1k8Nq3qZPPYvKTeY/fNBjaPj09vsQSwRnHZpKTmZJal
	FunbJXBlPHtwja1gDVvF2uN/WRsYp7B2MXJySAiYSPT+bGUGsYUEVjBK3F0o28XIBWR/YZRo
	3LyKGcL5zCixbdk0JpiOeWtnskAkljNKLD0A4wBVXdz0A6plM6PE9qMv2EFaWARUJN53LWHs
	YuTgYBPQkmjsBAuLAJlX/uwC280sUCpx58xMNhBbWMBFYtuub4wgNi/QtsZD/VC2oMTJmU9Y
	IOp1JBbs/sQGMpJZQFpi+T8OkDCngL3E0Y7PbBCHKkk0bD7DAmHXSuxtPsAOYV/hkGhd7g5h
	u0h0fD8BVS8s8er4FqgaGYnTk3ugeqslnt74DfaWhEALo0T/zvVgeyUErCX6zuRA1DhKLPs+
	lREizCdx460gxJV8EpO2TWeGCPNKdLQJQVSrSexo2so4gVF5FpK/ZiH5axbCXwsYmVcxiqeW
	FuempxYb5qWW6xUn5haX5qXrJefnbmIEppTT/45/2sE499VHvUOMTByMhxglOJiVRHhVu7RS
	hHhTEiurUovy44tKc1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTDxCrbVN1UX
	JPQulo+/26l2bvUGA93QKMVFHNa6KTOPWUpMeWjrIHtOUnLKw3dcFV8sWf8u//b76tGn00XF
	NQ+/CXj1k1XULUCjWl1e9jFLTpCj3CKPlEfpsxIyl/OuOrr7vaDUPVvvDRdTX/6tPqqf8eLE
	5Ynu0dGVyUVv/AuFeXjPV3xmnXM6ksn0XYd8cPrR5a/U/k6sX12x/6T1qfwDHHevXd6lq/6E
	RZQh9PQV4ff+OySezT8tEjzp0m77LSvrT1+Yt665XmBDiEuUW9wUhXw3b4GvVXZnlB7f430S
	UGmZYfd50t5Z8YyT5sxkKGQ26pudEKgz03qh0qddGlPC+Pk37hDTiBL9oNW6l0+JpTgj0VCL
	uag4EQDPOjQtmAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7qL+7VSDHq381ns6T/FZLFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8Pj69xRLAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8ezBNbaCNWwVa4//
	ZW1gnMLaxcjJISFgIjFv7UyWLkYuDiGBpYwSf08tYYJIyEh8uvKRHcIWlvhzrYsNxBYS+Mgo
	cb+rEKJhM6PE+e+vWEASLAIqEu+7ljB2MXJwsAloSTR2gvWKAJlX/uxiBrGZBUol7pyZCTZH
	WMBFYtuub4wgNi/QEY2H+hkh5hdL9F+ZzA4RF5Q4OfMJC0SvjsSC3Z/YQMYzC0hLLP/HARLm
	FLCXONrxmQ3iTCWJhs1nWCDsWonOV6fZJjAKz0IyaRaSSbMQJi1gZF7FKJJaWpybnltspFec
	mFtcmpeul5yfu4kRGFvbjv3csoNx5auPeocYmTgYDzFKcDArifCqdmmlCPGmJFZWpRblxxeV
	5qQWH2I0BQbERGYp0eR8YHTnlcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0
	MXFwSjUwZbg8Dc+v+3pOLfORdbjzO+8LOluV7Hul/0SevzVpwv3i26Unzy9c/uhS2ObmhRdP
	P53z7vgshzPy3kK91443+B7gq9Xc+OJjvYbDAneviqI5svo91m87yrbPvVASO8OlgmHv11X5
	moXzAtc96I62cl7BV2FwtFisLPtt2brfWmJs6yY5/t3hYdmRYrvA8XLyK60brb+1LygtPfmO
	q+4CwxuNRfqt90omzPlp77phLvvDz+aaib2N+V9tzK3V+4WvKZ2+tNTav87i9OqHO/4lTuK8
	K67q5/S+nEv5iFWB0t7/11IPbEvTvTEj8Pvvik2t/y7KfNqj+dLGtjyTZff9eDeVj7qORu49
	p6td3m6SU2Ipzkg01GIuKk4EAMiGz+82AwAA
X-CMS-MailID: 20230403083443eucas1p225993f889610c6c070dcb24e232aa526
X-Msg-Generator: CA
X-RootMTR: 20230403083443eucas1p225993f889610c6c070dcb24e232aa526
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230403083443eucas1p225993f889610c6c070dcb24e232aa526
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
	<20230331221823.2806192-2-alan.adamson@oracle.com>
	<CGME20230403083443eucas1p225993f889610c6c070dcb24e232aa526@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_013450_134525_33C33B81 
X-CRM114-Status: GOOD (  11.69  )
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

On Fri, Mar 31, 2023 at 03:18:23PM -0700, Alan Adamson wrote:
> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") disabled error
> logging for user passthrough commands.  This commit adds the ability to opt-in
> to passthrough error logging.
> 
> To enable passthrough error logging:
>         echo 1 > /sys/class/nvme/nvme0/passthrough_logging
passthrough_logging is a bit misleading as it doesn't indicate it is
going to log only passthrough errors. `passthrough_error_logging` is a bit
verbose but it is more apt for what this sysfs entry is doing. Maybe
an abbreviation for passthrough_error_logging?
> 
> To disable passthrough error logging:
>         echo 0 > /sys/class/nvme/nvme0/passthrough_logging
> 
> By default, passthrough error logging will remain disabled.
> 

