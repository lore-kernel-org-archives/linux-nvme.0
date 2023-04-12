Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77298C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gZN7x0aeXViU4AMoYj+8vlJAW//AFuYDQr6AZiEWd50=; b=YerRtKrs3ou/6cvhe+zsyKaXhN
	OC4gKMYagmZ71r0tfniZWLPi/mMxc567tev334UCHsCvry+r/j0DZnNsNmrp1yTgvQm8ulWxRB7Jt
	YFwr+X76ll4oNwJ6TkIQyVH5xuLzaANxfrrfr81/DBHI6OA0XeUb+TuJORvBMOKIeW5SfysUOuoCx
	MxygENVYvZvNlbefK6Q/JqVIorzjYq1IstCaS4Ijqp2JxnbyEpKJRQ46/Ah3yZsTaE+8YqMJZma1Y
	VqxTIVlsVEquOa9QkCFVc8rKuChqZqD+/uL9hla90RsXkerX9ktHkKh/SoiJ8zPr2V0p2GVNuL8Yj
	5cknyXrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmWcu-002NDs-20;
	Wed, 12 Apr 2023 09:18:52 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmWcq-002NCj-2O
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 09:18:51 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230412091844euoutp0204b1cd620d05d7bc134fb3b2dc282422~VJV6g-k3E1168811688euoutp02c
	for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 09:18:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230412091844euoutp0204b1cd620d05d7bc134fb3b2dc282422~VJV6g-k3E1168811688euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1681291124;
	bh=gZN7x0aeXViU4AMoYj+8vlJAW//AFuYDQr6AZiEWd50=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FwMrGBidzI0/JLegDSF1Z8jOng0H2ryL45HooyES8Rxh7UDwRNARZ+/LxWJ9dm/r8
	 +J8lmm6wlWAEH6B6mFFj1QY/r3GOdNk874AjMoNlh50GjW3Ynozl1iWMVUn94DLU0J
	 sVg6w7lY7kHt8Y+Mq1vTG47KuHK9s4LXNO6jPKcc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230412091844eucas1p2e08ae073da1a0e746cfbebae639c33d2~VJV6abLO82211322113eucas1p2c;
	Wed, 12 Apr 2023 09:18:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 8F.BB.09966.47776346; Wed, 12
	Apr 2023 10:18:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230412091843eucas1p22a4c7c34297c4f260ccc54cff9d67a52~VJV6BPr9G2211222112eucas1p2t;
	Wed, 12 Apr 2023 09:18:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230412091843eusmtrp282b0dca7820052ba234fdefbace2eacd~VJV6Afw8w2698826988eusmtrp2F;
	Wed, 12 Apr 2023 09:18:43 +0000 (GMT)
X-AuditID: cbfec7f4-d4fff700000026ee-a3-64367774454e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F0.3A.22108.37776346; Wed, 12
	Apr 2023 10:18:43 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230412091843eusmtip1c9481af3312de89b4b13fcfd1adc4c2a~VJV53G24A2176921769eusmtip19;
	Wed, 12 Apr 2023 09:18:43 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 12 Apr 2023 10:18:42 +0100
Date: Wed, 12 Apr 2023 11:10:13 +0200
From: Pankaj Raghav <p.raghav@samsung.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: <alan.adamson@oracle.com>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Message-ID: <20230412091013.5eckb4if2jiy6ms5@blixen>
MIME-Version: 1.0
In-Reply-To: <20230409212538.18647-1-kch@nvidia.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOd2ScrMUg+aLLBZ7+k8xWTy9OovJ
	Yv6yp+wOzB6bl9R79Da/Y/P4+PQWSwBzFJdNSmpOZllqkb5dAlfGsrshBX18Fce657A0MF7h
	7mLk5JAQMJFYNH0rI4gtJLCCUaLtkFYXIxeQ/YVRorf/EyOE85lRYtHlhcwwHed+XmKBSCxn
	lPi4YgEzXNXNtR+ZIGZtYZR4eq8AxGYRUJX42jwVKM7BwSagJdHYyQ4SFhFQl5h6oIcVxGYW
	sJfYOuMiWKuwgJPE7Q2bwMp5gZbtuMICEuYVEJQ4OfMJmM0JFD70ZTIrxD1KEg2bz7BA2LUS
	e5sPsIOcIyGwg0Ni5ccZbCBzJARcJHa/KYeoEZZ4dXwLO4QtI/F/53wmCLta4umN38wQvS2M
	Ev0710P1Wkv0ncmBODNDYum3B2wQ9Y4SJ6c/Y4Yo4ZO48VYQooRPYtK26VBhXomONiGIajWJ
	1ffesECEZSTOfeKbwKg0C8lfs5DMh7B1JBbs/gRkcwDZ0hLL/3FAmJoS63fpL2BkXcUonlpa
	nJueWmyUl1quV5yYW1yal66XnJ+7iRGYUk7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4f3hYpoi
	xJuSWFmVWpQfX1Sak1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1OqgSl+ssKMy3lR
	8R/YtC87bP4158ttmfKjq+z8td8vWjTrVnAqq9GlFHut0/93nX/TfmnTF35V3n/Lfp17O/2u
	U5nOhceyJjvqjdNEfx7bX/fhqleMUNzFuLPmOu98VPmel86My5u2qED+7xnNyv9/D/wVkJ7l
	I73kv9rGIqGiGWUtSpvEnueGfVSdn3T1fdfWq1dCTPkv8ZjLJBi46l948FWmoD1uDoOdUHk0
	67aso37PZp1+sPxcatNM8eUhd9YE3T2QOOnS7/B+Tr93lx33Wi6Rr+L9IrCXxXbmDY2Csh32
	cn/Deufo71Qo3LH90MTLof7aRzQ7zpo1FAtWiWuvXj5tKusr+QdZixf+0iiOrLmtxFKckWio
	xVxUnAgAeqAy7pgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Xd3icrMUg8vv1C329J9isnh6dRaT
	xfxlT9kdmD02L6n36G1+x+bx8ektlgDmKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj
	81grI1MlfTublNSczLLUIn27BL2M2/uesRSc46649PoBSwPjWs4uRk4OCQETiXM/L7F0MXJx
	CAksZZRYsfkZK0RCRmLjl6tQtrDEn2tdbBBFHxklmjuOQ3VsYZRY9r2DEaSKRUBV4mvzVKYu
	Rg4ONgEticZOdpCwiIC6xNQDPWCDmAXsJbbOuMgEYgsLOEnc3rAJrJwX6IodV1hAwkICxhLX
	rn1kBrF5BQQlTs58wgLRqiOxYPcnNpByZgFpieX/OEDCnECdh75MhjpTSaJh8xkWCLtWovPV
	abYJjMKzkEyahWTSLIRJCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGzLZjPzfvYJz3
	6qPeIUYmDsZDjBIczEoivD9cTFOEeFMSK6tSi/Lji0pzUosPMZoCw2Eis5Rocj4wavNK4g3N
	DEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpiC0nYkmAgYmgheP3r8tdPR
	2WfPnyxNXXjg844tSd0ebNHqub7b2o7nRn4++/aXTnpGeIBcVbmhV96sCeHet04e+535/3dh
	95f/5U2SNza18bS+1tl4dNH/CdyzF0uFmvRs/zG7dZ/Xn6WclX0/Q5PfLOm+ZWkQ8NtNsNjz
	U+qaPzfvHb4V+JD3fv7utVkTK7curpSS4Oe5zi+6Qvnp8sUuM+pbd5R+62jULz7s2yYo03HZ
	zpLfvcP4xVGL0xvL5obKBhdk+c/L5ZNY2+XSpFObouFUv27C4x3/Xn3MTDkQErJnldvaJ5zT
	4xac9N5+1DBT7/jp1GkfhMXVbl/bxRq2IXq20OmO2Ycm2gXl/8lWYinOSDTUYi4qTgQA73Hm
	FCIDAAA=
X-CMS-MailID: 20230412091843eucas1p22a4c7c34297c4f260ccc54cff9d67a52
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_68601_"
X-RootMTR: 20230412091843eucas1p22a4c7c34297c4f260ccc54cff9d67a52
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230412091843eucas1p22a4c7c34297c4f260ccc54cff9d67a52
References: <20230409212538.18647-1-kch@nvidia.com>
	<CGME20230412091843eucas1p22a4c7c34297c4f260ccc54cff9d67a52@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_021849_409902_CCD31980 
X-CRM114-Status: GOOD (  17.01  )
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

------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_68601_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Sun, Apr 09, 2023 at 02:25:37PM -0700, Chaitanya Kulkarni wrote:
> 
> -ck
> 
> Chaitanya Kulkarni (1):
>   nvme: allow passthru cme error logging
> 
>  drivers/nvme/host/core.c | 83 +++++++++++++++++++++++++++++++++++++---
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 79 insertions(+), 5 deletions(-)
> 
> v5:
> 
> - Trim down code in the nvme_log_error_passthrough().
>   Use following to get the disk name as an arg to
>    pr_err_ratelimited() :-
> 	ns ? ns->disk->disk_name : dev_name(nr->ctrl->device),
>   Use following to get the admin vs I/O opcode string as an arg to
>   pr_err_ratelimited() :-
>        	ns ? nvme_get_opcode_str(nr->cmd->common.opcode) :
>        	     nvme_get_admin_opcode_str(nr->cmd->common.opcode),
> - Rename nvme_log_error_passthrough() -> nvme_log_err_passthru().
> - Remove else and return directly in nvme_passthru_err_log_show().
> - Generate error on invalid values of the passthru_enable variable
>   in nvme_passthru_log_store().
> - Rename passthrough -> passthru.

> - Rename sysfs attr from passthru_admin_err_logging -> passthru_log_err.
Curious to know why `admin` was removed from the sysfs attr. We enable
logging for admin commands using this attr but IO errors are always logged.

I tried out the patch and I was surprised to see IO err was logged for
passthru requests without me enabling it explicitly. Having the sysfs
attr to be passthru_log_admin_err would have been more clear IMO.

------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_68601_
Content-Type: text/plain; charset="utf-8"


------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_68601_--

