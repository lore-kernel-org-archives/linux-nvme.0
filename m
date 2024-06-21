Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F80C2BA1A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=yPX9zqbCkPt8relVL/K5b7QkTY
	UfeU01GSI63s1qPGk2P/2RgjY8M6AVZtq9eHxf8IxbUFbkanSDTCgqLfin3R4EuBP3XiBeXk6t0LL
	g0xXgfolwIao9dZ4TYlApoRMmjuF/jNjxBg7lHMkQ1viEaHhpiBEPS/4uyexD7yonyoeFWuOnw271
	UMFWQnDRVtjKRsVX+uWBxDO25JCoZkjba9z2UoU3RWI/PcouYDKMeqp/N2BM/ITJ90XvR5QxMeJnu
	2xJSxpSdkpd+t7ExXwuocDemT2DJd98HSYbaOCqyECN+hL/JpYGM9rUP0dDVYcMkSZ3ldfPoHWFYA
	k9U6+4bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKfjT-00000009cxL-1F1p;
	Fri, 21 Jun 2024 14:59:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKakr-00000008bEr-0wwT
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 09:40:32 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240621094017epoutp01e5024adbb5c4943331c36ea7f2622f4c~a_5MmQoD_1107311073epoutp01S;
	Fri, 21 Jun 2024 09:40:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240621094017epoutp01e5024adbb5c4943331c36ea7f2622f4c~a_5MmQoD_1107311073epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718962817;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=gF5Mn5Cs05hIZubDGl6N8HjV7/n3HUJ2xybSyGKT8ltlPNHWt40g89LHuiHboeYo3
	 XwwIlyOtVYv4eQy/w96F2WssGZrLB6cS47xlEk8bpi6jUhLf+D/k7SxRrO5OClpPRQ
	 +ZEj6Rf5xkruuha3als/5FIWVgJem2u6/+Xx+WqY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240621094016epcas5p37e30c7a723101b07dad0e3c3fea25975~a_5MMdLDU0813208132epcas5p31;
	Fri, 21 Jun 2024 09:40:16 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4W5C5C4m5dz4x9Pt; Fri, 21 Jun
	2024 09:40:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.1E.19174.F7A45766; Fri, 21 Jun 2024 18:40:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240621094015epcas5p4ffcbc601f9a3ebe9ceb13a5fdac237bd~a_5KnhYrl2058420584epcas5p4c;
	Fri, 21 Jun 2024 09:40:15 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240621094015epsmtrp2a861ecb2d60954e0a50a639e09564028~a_5KmUyur3234432344epsmtrp20;
	Fri, 21 Jun 2024 09:40:15 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-94-66754a7f85b5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.A5.18846.E7A45766; Fri, 21 Jun 2024 18:40:14 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240621094009epsmtip1b013110a146e68d8e804e1eeeb926ab7~a_5FqZwgd2003020030epsmtip1e;
	Fri, 21 Jun 2024 09:40:09 +0000 (GMT)
Message-ID: <c890111a-08a0-4afe-dd3e-5ce41d64f54b@samsung.com>
Date: Fri, 21 Jun 2024 15:10:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [Patch v9 10/10] nvme: Atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz
Cc: djwong@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org,
	linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de, Alan Adamson <alan.adamson@oracle.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240620125359.2684798-11-john.g.garry@oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUZRT3u3u5u1CrtxXiGypZt8iRhsfSQh+MICXpHWpGymkqnQbusJeF
	WC47+8gsZ2AIdAXiKSSvFlYskDGUJVyeIkQrDwVZQSNhgJYSUCAYS0GzXXYz/vudc37n+53z
	O/PxOIIergcvgVUzSpaWiwgXvKl7p7dPSqQmzn9Utx3V9/3MQW25fRiqG88l0Hz3MkBX5yq4
	yGzZjCr1FThq0xdgqLauB0MLGddwVPbNVxjqvbRIIP2tJgwNrRoBKugaBehkcRpA7WOvoeHf
	ariorb0XR+aWcgLpvpvhoqybRgJ9b/oHQ/naEQw15i9h6HTtB+hyn5aLfphfxNGVsRdQRvZD
	Lhp8bHJCaw/KiXAh1Vw6zqUqGzTU4MQFnDLUeFPmqxqq4ewJgmpYLuBSefpOQBmqU6g7hhJA
	tf6SSlBpAz0c6s+ZMZxa7BghqIHKn7iUof/LKMHBxF3xDC1llEKGjU2WJrCyUNE7B6L3RAcG
	+Yt9xMHoDZGQpZOYUFHEu1E+exPkVstEws9oucaaiqJVKpFf2C5lskbNCOOTVepQEaOQyhUS
	ha+KTlJpWJkvy6hDxP7+AYFWYkxifJ/xDKYI+Hy0IgdLBT6ZgMeDpATm1FihC09AtgGY2X8G
	twfLAHa0joCngXbW5JQJnNc7hv8qc7IXmgF8cvG6I7gH4MV754GNxSfDYHnJFG7DOOkFaycG
	OPb8c7C3xLKedyNj4cPMTsKGt5IIZg7Nrec5pDscs+gw26Ou5BKAwzmzjsIJHFYsyGyDE+RO
	OFSosUFnMhxmX9piZ3haRyjn2FohecwFakdvEPapI2DjtTzHBlvhnKmRa8cecGWh3cFJhJPT
	k7gdH4VGQ46DvxumPrrlZNPiWGXrW/zsWpvh12sWzG4jH2qPCezs7XCiYMbR6Q6nTlU7MAV1
	VUUcu1VXADx+cwbPA8LSDa6Ubti+dMM6pf8rVwL8LPBgFKokGRMbqBD7sMzhp+eOTU5qAOv/
	yTvKCOrOP/btAhgPdAHI44hc+X9kKuMEfCl95AtGmRyt1MgZVRcItN4nn+PhFpts/ZCsOlos
	CfaXBAUFSYJfDxKL3PnzGRVSASmj1UwiwygY5X99GM/ZIxXbv1+ofHFLnvZk1Hs1z9QTAcWH
	/J5VzQ6NZJhD467HxNxOg4+Ga9NbDv5440h3moYNia+MNMd/+3KuXpdwZ4fkbc99xYlD52Se
	ZEi1CQtH+sKelN2LNeLTnU0FFCOxSNnf2xOchaq28qLbvzZ3RMqXYpwf+D0xpm86F9L3t3BV
	2n/gsltHcNWq7vkpk2BTWSTqYF85tCDaMzIiyxodPHV/bPKljyan3yxP/zC2acUjomj28I4s
	stN1lbvNq10XtjfJws5/vMzPCvLeF76GvD4lh2m2qG5F09rdlA3i3lJM8wprL1TRVcb3B7R3
	zTN3PzHef3WparOBHhccjQstK9x2XISr4mmxN0epov8Fognji9gEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7bCSnG6dV2mawZmdNhbrTx1jttjTf4rJ
	YvXdfjaL14c/MVqcfTWX3eLyEz6LBYvmsljsWTSJyWLl6qNMFu9az7FYzJ7ezGRxcv97NotF
	N7YxWVz4tYPRYtKha4wWU6Y1MVrsvaVtcenxCnaLPXtPslhc3jWHzWL+sqfsFt3Xd7BZLD/+
	j8liYsdVJostEz8wWSxeGWpx8FQHu8W61+9ZLE7ckrZo7fnJbnH+73FWi98/5rA5KHjsnHWX
	3WPBplKP8/c2snhsXqHlcflsqcemVZ1sHps+TWL3mLDoAKPH5iX1Hi82z2T02H2zgc2j6cxR
	Zo+PT2+xeLzfd5XN48yCI+wem09XBwhFcdmkpOZklqUW6dslcGWc2rGUqcCo4trcPqYGRt0u
	Rk4OCQETiUvfZrN2MXJxCAlsZ5T4PeMKI0RCXKL52g92CFtYYuW/5+wQRa8ZJeZfuc8GkuAV
	sJOYM/MhC4jNIqAqsfLeGWaIuKDEyZlPwOKiAskSL/9MBBskLGAh0XXhFVicGWjBrSfzmUCG
	igh8YJR4s3ENC4jDLNDJInF+WicbxLoTjBJz3j4FuomDg01AU+LC5FIQk1PAQaJnPz/EIDOJ
	rq1djBC2vMT2t3OYJzAKzUJyxywk+2YhaZmFpGUBI8sqRtHUguLc9NzkAkO94sTc4tK8dL3k
	/NxNjOAkpBW0g3HZ+r96hxiZOBgPMUpwMCuJ8D7vKkoT4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zquc05kiJJCeWJKanZpakFoEk2Xi4JRqYGLn73xfPdNvWjyjYlpgq4t67Oc9q/4ElmUuDHzf
	EFawMKIjzb7J9vFS4RvvJ9j/sBSRbtT7XlJl9Psoo31UYdqFMwfP1BSw/bLebRSmXCam/KB9
	1tsci68HFeIPdlhEV9Se5dDrnH1J2XjRs+RjyZafVcPb6iYtK/6VGrXswtM6XnMnL4fzs6Ys
	U3tz5cGxOboV3FXK9tEdc3e/bM0J1M3ZfEB674rTwlPjTttseSkV983+U8msBQcTvY982uK0
	x3XboXdVud4HP17XPfw9r3ezjfWLGcdXXcu8kv/7+u/sz8JMj/5lPo38887v5u25b5cwPRRt
	e1Zy79zNXXsP/Ah/+P0y274P+3Xnr/7BF2+sxFKckWioxVxUnAgAflXwpbEDAAA=
X-CMS-MailID: 20240621094015epcas5p4ffcbc601f9a3ebe9ceb13a5fdac237bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240620130128epcas5p4fcf2266e390bc02fec23c89c9a3cf460
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
	<CGME20240620130128epcas5p4fcf2266e390bc02fec23c89c9a3cf460@epcas5p4.samsung.com>
	<20240620125359.2684798-11-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_024027_663190_65DAB494 
X-CRM114-Status: UNSURE (   8.57  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 21 Jun 2024 07:59:16 -0700
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

