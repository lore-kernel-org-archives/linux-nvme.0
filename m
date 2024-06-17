Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F577C27C4F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 05:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3GE3KET7bOf1zcmKKymQ2JPlkXHN91x41000eo5a7lA=; b=zg6lnSqjLOhj4MOf/loZWHIECh
	yxxBGCQ7NGCp5d99HUjifDgQop6u3awQ2XRfo2uh5W95037yHHyJj2zqPP3BPkLTGmWPfhAhR+FlO
	Z67AEvXebEYfhlmPvH6za9X6yTRyh7Mxu0FtC57bjGlrYSJvgbIqoO4dEe9bFZTtcQCEaUWDLwdUb
	qZTpgwsaQdD/xaHflWOsmIi2f9tLo0dqUDKD6fY5OqF6kRq2gGkEPgeAn47ZvguZs52x+YNDEVGSt
	2Vvn5e4XiyoTcHRwcB9HdZsaAMHTCA1Tkqn9iPhwnDM/L8oui1rbyRf9ui8x2KZToQJTQ0iTrPNFw
	5+1ds0Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJRfO-0000000Dgiu-2NOl;
	Tue, 18 Jun 2024 05:46:02 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJG5Y-0000000BvqW-0Z9c
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 17:24:41 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240617172408epoutp01d5cfb621ee9332625028acae497565c9~Z2pDkcxZp2902629026epoutp01O;
	Mon, 17 Jun 2024 17:24:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240617172408epoutp01d5cfb621ee9332625028acae497565c9~Z2pDkcxZp2902629026epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718645048;
	bh=3GE3KET7bOf1zcmKKymQ2JPlkXHN91x41000eo5a7lA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=fIJn20/7wP01siSaq+PLtS0oBmmYBxSsDSsFfL7DTgvB/Cyvr6AGPiMAmQDHX3NVq
	 SiE6szv8tltuVtBjD6MzXNm3tkerE0tHehPd3pd9G2uFY1y2HnDPfalYF3cvn+hXxW
	 UQxx6m06VH4gCCSdAtyw4XVjio8JSs334Wc9gkds=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240617172408epcas5p14cd564ede4e3b176c07c37d1f9b80cc0~Z2pDN_D1I0954009540epcas5p1i;
	Mon, 17 Jun 2024 17:24:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W2xZG0RD8z4x9Pp; Mon, 17 Jun
	2024 17:24:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.C0.06857.53170766; Tue, 18 Jun 2024 02:24:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240617172405epcas5p304fc3cb06e74bae8ef44170bdf73feff~Z2pAjhLuV0869008690epcas5p3c;
	Mon, 17 Jun 2024 17:24:05 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240617172405epsmtrp102e99dc9015645e38ebeee8e5344b312~Z2pAhH4JU0128601286epsmtrp1G;
	Mon, 17 Jun 2024 17:24:05 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-91-66707135ee1d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.2B.18846.53170766; Tue, 18 Jun 2024 02:24:05 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240617172400epsmtip15cdc36d9ff46a830e937444c42522c89~Z2o8ahfCc0277102771epsmtip1W;
	Mon, 17 Jun 2024 17:24:00 +0000 (GMT)
Message-ID: <faaa5c15-a80d-339a-d9dd-2dd05fb26621@samsung.com>
Date: Mon, 17 Jun 2024 22:54:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v8 10/10] nvme: Atomic write support
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
In-Reply-To: <20240610104329.3555488-11-john.g.garry@oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TezDcVxTH5/72tw+b2XS7qBudKd1oWhKPZcmVIVExmd+MTkcnTTujD93a
	H6vYXfvog6YRStiKx0rSUkKXprJRml31CBGhniGEIaJBvRLirTVFQrprN6n/Puec75nvPefM
	ZVA4rXRbRoRYQcrEgigujYlXNjk6OnvGSMPcaje9UHlHCwXVZXRg6MpwBg3NNq0A1PUon476
	JnejQk0+juo0agxdvtKMoYWk2zj68ftEDLXfWKQhzWAlhno2qgFSNw4AdO5CAkDXh/aj3okS
	Oqq73o6jvmt5NFRwaYqOvrtbTUO/tG5hKCulH0MVWUsYKrp8At3sSKGjstlFHLUNvYyS0tbp
	qHuzlYoer+XR/OyJmtxhOlGoUxLdI1dxQl/iRPR1KQmdNpVG6FbUdCJT0wAIffEpYlqfA4ja
	e/E0IqGzmUIsTw3hxGJ9P43oLPyDTuhvxQVxgiN9RKRASMrsSXGoRBghDvflBh4PORri6eXG
	c+Z5o4Nce7EgmvTlBrwV5HwsIsqwMq7954IopSEVJJDLua6HfWQSpYK0F0nkCl8uKRVGSflS
	F7kgWq4Uh7uIScUhnpubu6dB+EmkqCg7AUi7dn25sdpEiQenLVTAggHZfDjeU041ModdC2Cy
	1l8FmAZeAfDe/QbwPOg/PU591jHZp8ZMhRoAqxJqqKZgHsDiO5OYUcViH4b9czPAyDj7Ndgy
	p8ZN+Rdhe87kNluzQ+G6qoFmZEs2gj/rzm3nKWwbODRZsO1gxV4CsDd9xlxIxWH+QrgKMBg0
	tiPsyVYa0xZsPzjQm2aW2MGq+TyKsReyE5hwsKoMMz07AA4Xq3ATW8JHrRV0E9vCmYxkM4fC
	3pzbZr0CTtTdNPMRmNSRQTH6Ugy+5ddcTV674dnHxnkZBgkLpiRzTOpX4Yh6yrwsGzj2Q7GZ
	CajTNZp31QbgmeR1kAnsc3esJXfH+Lk7xsn937kQ4Fqwh5TKo8NJuafUQ0x+8fzgoZJoHdj+
	UU6B1WD8ryWXRoAxQCOADArXiuV/QRzGYQkFX8WSMkmITBlFyhuBp+E+WRRb61CJ4UuKFSE8
	vrcb38vLi+/t4cXj2rBmk/KFHHa4QEFGkqSUlD3rwxgWtvGYAzcraCxudT3Yg0j97dchQae6
	/lPrwvsX97WOxul9XKZK872ZeIV+7aX1wY3pIlL4ysz8g4eaaJ275Rssb61deKe2ZfWS9L1/
	V45w0otOXlw6+8BpoPlD7ZnXr7pvWf3ps7b36Te5dls/zYq+bjlh0fzmydhjTbYHSP7ykn/s
	0XjPz/75QKtKYwavpRxini/Wl80dGFRnfjvN8x2q4sut2pYdRgpu7Cvd//fB2bDRJ4GtoofB
	Y9k2kpg9512O7yL0kVVPtQ2F7y9UUp6AmHcCEjSuPol+JZruUepdlkPzx5tbsW+/W6p9ge7N
	LOoMyaqPsmT8fsuXqD8VILZIl31EnVhPvBPHxeUiAc+JIpML/gPSz14u2gQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7bCSnK5pYUGawcvnfBbrTx1jttjTf4rJ
	YvXdfjaL14c/MVqcfTWX3eLyEz6LBYvmsljsWTSJyWLl6qNMFu9az7FYzJ7ezGRxcv97NotF
	N7YxWVz4tYPRYtKha4wWU6Y1MVrsvaVtcenxCnaLPXtPslhc3jWHzWL+sqfsFt3Xd7BZLD/+
	j8liYsdVJostEz8wWSxeGWpx8FQHu8W61+9ZLE7ckrZo7fnJbnH+73FWi98/5rA5KHjsnHWX
	3WPBplKP8/c2snhsXqHlcflsqcemVZ1sHps+TWL3mLDoAKPH5iX1Hi82z2T02H2zgc2j6cxR
	Zo+PT2+xeLzfd5XN48yCI+wem09XBwhFcdmkpOZklqUW6dslcGUsntzEWHCWu+LX18PMDYyN
	nF2MnBwSAiYSTy5PYupi5OIQEtjOKPGt+zcrREJcovnaD3YIW1hi5b/n7BBFrxkl3t1uZwFJ
	8ArYSVx985IRxGYRUJU49mYSVFxQ4uTMJ2C2qECyxMs/E8EGCQtYSCzdNAUszgy04NaT+WCb
	RQQ+MEq82biGBcRhFuhkkTg/rZMNYt0JRokzP/cCreDgYBPQlLgwuRSkm1PAQeLapR6oSWYS
	XVu7GCFseYntb+cwT2AUmoXkkFlIFs5C0jILScsCRpZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ
	+bmbGMGpSCtoB+Oy9X/1DjEycTAeYpTgYFYS4XWalpcmxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwNRlt0Zv8lLTCy4LfqXs1eTVClHb8Wm3WGLuFsk1
	jbNY1B37Jzo7vDrVP/H21QLlN5H3PFuDORvOtdZVvBEyTd/pN6Fxq9imc4es1H3//zQ5ZOkp
	dvq1kN6ulTxc8p4JWQz2hc7Gvuxdn68fFdAvW+NmlCaiHvXHtfdagVruy93n9ptmX7nBZZLO
	vjlYfNau2m9920p7z/PmTC+RNf7K8XCpUVOAsHP2rXie5SbidTOMXVRqJznlVKu/dj2SX7yX
	T1BrWqm4Zvv7251CvUtvZm5qdDym7Kcuxt/mnnJmwszzlxJSZ/2U2NOv7WM3wSc5iWdhs+ZZ
	//e8qp054ndZJ9odPhMnnfZbYnLZ5xolluKMREMt5qLiRACuq6SitAMAAA==
X-CMS-MailID: 20240617172405epcas5p304fc3cb06e74bae8ef44170bdf73feff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240610162108epcas5p27ec7c4797da691f5874208bfcfa7c3e3
References: <20240610104329.3555488-1-john.g.garry@oracle.com>
	<CGME20240610162108epcas5p27ec7c4797da691f5874208bfcfa7c3e3@epcas5p2.samsung.com>
	<20240610104329.3555488-11-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_102418_545457_12742964 
X-CRM114-Status: GOOD (  17.54  )
X-Mailman-Approved-At: Mon, 17 Jun 2024 22:43:56 -0700
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

On 6/10/2024 4:13 PM, John Garry wrote:
> +static bool nvme_valid_atomic_write(struct request *req)
> +{
> +	struct request_queue *q = req->q;
> +	u32 boundary_bytes = queue_atomic_write_boundary_bytes(q);
> +
> +	if (blk_rq_bytes(req) > queue_atomic_write_unit_max_bytes(q))
> +		return false;
> +
> +	if (boundary_bytes) {
> +		u64 mask = boundary_bytes - 1, imask = ~mask;
> +		u64 start = blk_rq_pos(req) << SECTOR_SHIFT;
> +		u64 end = start + blk_rq_bytes(req) - 1;
> +
> +		/* If greater then must be crossing a boundary */
> +		if (blk_rq_bytes(req) > boundary_bytes)
> +			return false;

Nit: I'd cache blk_rq_bytes(req), since that is repeating and this 
function is called for each atomic IO.

> +
> +		if ((start & imask) != (end & imask))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>   		struct request *req, struct nvme_command *cmnd,
>   		enum nvme_opcode op)
> @@ -941,6 +965,12 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>   
>   	if (req->cmd_flags & REQ_RAHEAD)
>   		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
> +	/*
> +	 * Ensure that nothing has been sent which cannot be executed
> +	 * atomically.
> +	 */
> +	if (req->cmd_flags & REQ_ATOMIC && !nvme_valid_atomic_write(req))
> +		return BLK_STS_INVAL;
>   

Is this validity check specific to NVMe or should this be moved up to 
block layer as it also knows the limits?

