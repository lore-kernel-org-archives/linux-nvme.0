Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437BAC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Apr 2024 08:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+VPZlBEtIkTjLj1Oh3TQ3pUDN00LGEiywwTXx1HGmM=; b=U1wiMeO8pqXWoUtC30T8ePGG4n
	/LuxSJg692XY4cbYFCFywRGfUtX9XA4GrPaGM8QMKqPnbYmzYrd1Dzo6lD/iQkwMaOsHeIyKvr0Im
	Y9SYE6rI2RPnSFH32COSUXUNAUGS6b2jRai60bUVP8tAe//PLZAdXTzcFJj/x4KksA0HWgoCKq8D6
	fHF0EMpAGg6yB2K3R5uXFyVvStC8zLhK30X2j4MrXmrqk+RouZ/c/5i8c2RWSZyT9cBhhujSTkl5c
	diolaAzHetrg5p0KsN9Sut3cw0U2Il1eEU+E29Ak28mOtWGMJSULehkzR5O7d3vhu0z29i+2+4P/O
	il+6NQ9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxjAt-00000004rkp-0yDf;
	Fri, 19 Apr 2024 08:00:47 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxjAn-00000004riM-1YQb
	for linux-nvme@lists.infradead.org;
	Fri, 19 Apr 2024 08:00:46 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240419080025epoutp045bd528d48d51d2ac5db87d2c5f0c827a~Hn5BGva9x1879018790epoutp04K
	for <linux-nvme@lists.infradead.org>; Fri, 19 Apr 2024 08:00:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240419080025epoutp045bd528d48d51d2ac5db87d2c5f0c827a~Hn5BGva9x1879018790epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713513625;
	bh=W+VPZlBEtIkTjLj1Oh3TQ3pUDN00LGEiywwTXx1HGmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M12pFF9u7dNc1OPmGKZ+29b6vF1p79iP8Ro7/ztKQs7EGtQzHdfN+Go3ErtP4D/UG
	 0mayMrfjSaCSd3/+KzF5F/kR2/eXuOKom6XfiJOi6QvSa6uhqvXnVUYnLpGa7ycW9T
	 /qn9rYSCKk2M7Juwk4bsC8JlZ8Qe49b25aboeLVc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240419080025epcas5p2665e5c53faa5dbc846c2aa538bc64284~Hn5A8xxvY1082610826epcas5p27;
	Fri, 19 Apr 2024 08:00:25 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VLRs32C9Sz4x9QY; Fri, 19 Apr
	2024 08:00:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.94.09688.79422266; Fri, 19 Apr 2024 17:00:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240418194325epcas5p2c88282729c2cb0715d7343428217de8d~Hd1irdNTa0307403074epcas5p29;
	Thu, 18 Apr 2024 19:43:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240418194325epsmtrp122bd6807d6848440a1955b1553136ebe~Hd1iq0Jnv0347303473epsmtrp1B;
	Thu, 18 Apr 2024 19:43:25 +0000 (GMT)
X-AuditID: b6c32a4a-5dbff700000025d8-1a-66222497e101
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.90.07541.DD771266; Fri, 19 Apr 2024 04:43:25 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240418194324epsmtip11ec6f81e4cb2e6651686bc000b81d91e~Hd1hpe-o50627206272epsmtip1I;
	Thu, 18 Apr 2024 19:43:24 +0000 (GMT)
Date: Fri, 19 Apr 2024 01:06:34 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, Daniel
	Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v2 00/11] support test case repeat by different
 conditions
Message-ID: <20240418193634.lw4k5ab24rplclad@green245>
MIME-Version: 1.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTXXe6ilKawZI9fBZXHyxjs3h6dRaT
	xd5b2hbzlz1lt9g3y9OB1WPzknqP3uZ3bB6bT1d7fN4k59F+oJspgDUq2yYjNTEltUghNS85
	PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaLGSQlliTilQKCCxuFhJ386m
	KL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj3Ym5bAWdKhU//l5g
	a2C8I9vFyMkhIWAicfLzfKYuRi4OIYHdjBLrnt5jAkkICXxilJizWBMi8Y1RYtWMRhaYjk3d
	j1kgEnsZJdb8ecUI4TxjlHj/qZERpIpFQFVi39ND7F2MHBxsAtoSp/9zgIRFBMwkrhx7ww5S
	zyzQzijxYPFlsKnCApESv/8dZAOxeYGKnjw9zAxhC0qcnPkErIZTwFni8deFYHFRARmJGUu/
	MoMMkhB4yS5x8clnNojzXCQOzH7ACGELS7w6voUdwpaSeNnfBmWXS6ycsoINormFUWLW9VlQ
	DfYSraf6mUGuZhbIkLh6ThciLCsx9dQ6cLgwC/BJ9P5+wgQR55XYMQ/GVpZYs34B1A2SEte+
	N7KBjJEQ8JBY/dYeEkDTGCVur2xlmsAoPwvJb7MQts0C22Al0fmhiRUiLC2x/B8HhKkpsX6X
	/gJG1lWMkqkFxbnpqcWmBUZ5qeXw+E7Oz93ECE6WWl47GB8++KB3iJGJg/EQowQHs5IIrxmH
	YpoQb0piZVVqUX58UWlOavEhRlNgVE1klhJNzgem67ySeEMTSwMTMzMzE0tjM0Mlcd7XrXNT
	hATSE0tSs1NTC1KLYPqYODilGpgs0japNCtpL597vflP8lPbZ075eie/Jhc4P9zB6yRbosa5
	146piFvwpFr/70lSzOtdUy5Hvg3XPxPTeOd4+VznO9rLN+zw3y393km4MHa237I/k5s9N8wW
	T7t3T/atiOT2fZriD3d4n/QoP1T3/8jKHy66Wn8uHvs57U5MU97J6vv/Tkhcy5M8fj39o3Km
	v3z5cc7VNtkP41XLDl1lOx4z9Wb/qb7c+A/+L2vX7vr6q9Pd2vnU75IAub1+glrP1aqSm6R8
	N9t+Lrzk9zilQmKtO/8Hv/M2q86GHH4icUjkxSz7fcnnz/fP8tjedmHu5cwJ7DPqtSbINnTM
	nSQTzX56c6bCeh6HokvFrN46r1qUWIozEg21mIuKEwGjLvtkHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSnO7dcsU0gy3PdCyuPljGZvH06iwm
	i723tC3mL3vKbrFvlqcDq8fmJfUevc3v2Dw2n672+LxJzqP9QDdTAGsUl01Kak5mWWqRvl0C
	V8aMC1dYCnYrVnSdms3YwLhCuouRk0NCwERiU/djli5GLg4hgd2MEs0LZjJDJCQllv09AmUL
	S6z895wdougJo8TO5YvYQBIsAqoS+54eAkpwcLAJaEuc/s8BEhYRMJO4cuwNWD2zQCejxJ7e
	m2D1wgKREr//HQSzeYGKnjw9DLZASMBJ4njvAWaIuKDEyZlPWEBsZqCaeZsfMoPMZxaQllj+
	D2w+p4CzxOOvC8HKRQVkJGYs/co8gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJuem2xYYJiXWq5X
	nJhbXJqXrpecn7uJERzmWho7GO/N/6d3iJGJg/EQowQHs5IIrxmHYpoQb0piZVVqUX58UWlO
	avEhRmkOFiVxXsMZs1OEBNITS1KzU1MLUotgskwcnFINTHYXrx53yziwJrWa5WiU13Jj0fzw
	1C31TRm9uw0VVvw5Zrt0Smft9UOPl/78Fr79vsUs5q7OS4t5HytFs17UqbxVJKX0e9rW9a5C
	mW/2n0lSYLTZfu2vkzjH+4Z9/QFnH0rIXmE6v0ucMTXsvq/mokrZee/XRzRJLdPVXHwz+XnI
	vw1fYwoWHNyyZJpf0Bnb/wtOK8x1nREhI6cX3BQY4hQ8RXvFe9NZnTmTs5p+bGN1Srw9N27h
	hXarwp/n3tw5nM6QtJSvvE+x3N5neYpJxJqz/4s/ZWxMP1AZ6b19m+YK9QM5u2N/avh8XBFr
	LCPzh6t8/iz13gPzW287LeDrXn5hl5jkrP0xrF0aH9ZMYVZiKc5INNRiLipOBADHJjRM4gIA
	AA==
X-CMS-MailID: 20240418194325epcas5p2c88282729c2cb0715d7343428217de8d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_96e99_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240418194325epcas5p2c88282729c2cb0715d7343428217de8d
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
	<CGME20240418194325epcas5p2c88282729c2cb0715d7343428217de8d@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240419_010041_738873_3DADCFD0 
X-CRM114-Status: GOOD (  24.28  )
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

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_96e99_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 16/04/24 07:31PM, Shin'ichiro Kawasaki wrote:
>In the recent discussion for nvme test group [1], two pain points were mentioned
>regarding the test case runs.
>
>1) Several test cases in nvme test group do exactly the same test except the
>   NVME transport backend set up condition difference (device vs. file). This
>   results in duplicate test script codes. It is desired to unify the test cases
>   and run them repeatedly with the different conditions.
>
>2) NVME transport types can be specified with nvme_trtype parameter so that the
>   same tests can be run for various transport types. However, some test cases
>   do not depend on the transport types. They are repeated in multiple runs for
>   the various transport types under the exact same conditions. It is desired to
>   repeat the test cases only when such repetition is required.
>
>[1] https://lore.kernel.org/linux-block/w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72/
>
>One idea to address these pain points is to add the test repeat feature to the
>nvme test group. However, Daniel questioned if the feature could be implemented
>in the blktests framework. Actually, a similar feature has already been
>implemented to repeat some test cases for non-zoned block devices and zoned
>block devices. However, this feature is implemented only for the zoned and non-
>zoned device conditions. It can not fulfill the desires for nvme test group.
>
>This series proposes to generalize the feature in the blktests framework to
>repeat the test cases with different conditions. Introduce a new function
>set_conditions() that each test case can define and instruct the framework to
>repeat the test case. The first four patches introduce the feature and apply it
>to the repetition for non-zoned and zoned block devices. The following seven
>patches apply the feature to nvme test group so that the test cases can be
>repeated for NVME transport types and backend types in the ideal way. Two of the
>seven patches are reused from the work by Daniel. The all patches are listed in
>the order that does not lose the test coverage with the default set up.
>
>This series introduces new config parameters NVMET_TRTYPES and
>NVMET_BLKDEV_TYPES, which can take multiple values with space separators. When
>they are defined in the config file as follows,
>
>  NVMET_TRTYPES="loop rdma tcp"
>  NVMET_BLKDEV_TYPES="device file"
>
>the test cases which depend on these parameters are repeated 3 x 2 = 6 times.
>For example, nvme/006 is repeated as follows.
>
>nvme/006 (nvmet bd=device tr=loop) (create an NVMeOF target) [passed]
>    runtime  0.148s  ...  0.165s
>nvme/006 (nvmet bd=device tr=rdma) (create an NVMeOF target) [passed]
>    runtime  0.273s  ...  0.235s
>nvme/006 (nvmet bd=device tr=tcp) (create an NVMeOF target)  [passed]
>    runtime  0.162s  ...  0.164s
>nvme/006 (nvmet bd=file tr=loop) (create an NVMeOF target)   [passed]
>    runtime  0.138s  ...  0.134s
>nvme/006 (nvmet bd=file tr=rdma) (create an NVMeOF target)   [passed]
>    runtime  0.216s  ...  0.201s
>nvme/006 (nvmet bd=file tr=tcp) (create an NVMeOF target)    [passed]
>    runtime  0.154s  ...  0.146s
>
>
>Changes from v1:
>* Renamed NVMET_TR_TYPES to NVMET_TRTYPES
>* 1st patch: reflected comments on the list and added Reviewed-by tag
>* 5th patch: changed NVMET_TRTYPES from array to variable
>* 7th patch: changed NVMET_BLKDEV_TYPES from array to variable
>* Reflected other comments on the list
>
>
>Daniel Wagner (3):
>  nvme/rc: add blkdev type environment variable
>  nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type
>    tests
>  nvme/{021,022,025,026,027,028}: do not hard code target blkdev type
>
>Shin'ichiro Kawasaki (8):
>  check: factor out _run_test()
>  check: support test case repeat by different conditions
>  check: use set_conditions() for the CAN_BE_ZONED test cases
>  meta/{016,017}: add test cases to check repeated test case runs
>  nvme/rc: introduce NVMET_TRTYPES
>  nvme/rc: introduce NVMET_BLKDEV_TYPES
>  nvme/{002-031,033-038,040-045,047,048}: support NMVET_TRTYPES
>  nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
>

Acked-by: Nitesh Shetty <nj.shetty@samsung.com>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_96e99_
Content-Type: text/plain; charset="utf-8"


------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_96e99_--

