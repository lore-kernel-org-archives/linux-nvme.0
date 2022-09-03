Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE37ECAAD5
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Sep 2022 09:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+LP9z7rVAj9Y6p3c/2lZz4ZDoRapDZEgkQzmoJ2y0h8=; b=as+oxzc+wr3LTmTLR+tcpQYutS
	1r5yclHcz+5NNb6OI/rrEoILgKOsorPq1vUfgx9r12A9wC8UpgG4BmPN9XWGDZv9s3X4myNRAcCrX
	3t2ZGz4EBi0q00NwwM7eXMDcOHASrYNj8zI1mI4wS/p1YpHf5MSuHL5jXUFhzEpho/0rzgsCLKvqY
	WM1Kjy0TvBtanJ8LsW+0ELDwT0HiMTNrmEcuGfNXy/IEj/QozxMY89CDUug+d7upeHaEzCIXZHOZX
	7v9ynSXDwk4QKmZ6AAkzkp+WgdXM1tRqp1vuoHAR3I7VMuIpuJExnZPNDUH1BWvjpMQWe8pUGd7G2
	Zg2qBmEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUPhs-0088AM-AW; Sat, 03 Sep 2022 09:44:52 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUPho-0087SI-WD
	for linux-nvme@lists.infradead.org; Sat, 03 Sep 2022 09:44:51 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220903094437epoutp04971f9896a8e5cb0b62099258464d420d~RUIbhGLm23152231522epoutp04X
	for <linux-nvme@lists.infradead.org>; Sat,  3 Sep 2022 09:44:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220903094437epoutp04971f9896a8e5cb0b62099258464d420d~RUIbhGLm23152231522epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662198277;
	bh=+LP9z7rVAj9Y6p3c/2lZz4ZDoRapDZEgkQzmoJ2y0h8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iuU+k2Gy5OrpbHx2Z2gYX6TewLZeoFjzbkemG15PD5JG9Qpq0agigQdHqMB0/htyp
	 ObUbOXZsZzJogEfLp3ad7LcZb8Qj8ySWZV9BJOjfgN+I/WP7oev3odu1lVhwIn+52M
	 BJyYmLNRd7vXBXZlYD5KpNEge+FXxpm4EsAJoDFM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220903094437epcas5p38a94fe41524d77e658e535253a057435~RUIbS7Bd80738507385epcas5p3J;
	Sat,  3 Sep 2022 09:44:37 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4MKVHQ55H6z4x9Pq; Sat,  3 Sep
	2022 09:44:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.BB.53458.20223136; Sat,  3 Sep 2022 18:44:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220903094434epcas5p191319b0d20cfa0d58b8399e665be07f9~RUIYbas4o2535725357epcas5p1D;
	Sat,  3 Sep 2022 09:44:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220903094434epsmtrp107e262a4807651b8fe1b9cce4f93fc7e~RUIYaqVCG2957429574epsmtrp1Z;
	Sat,  3 Sep 2022 09:44:34 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-8b-6313220215f0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.CA.14392.20223136; Sat,  3 Sep 2022 18:44:34 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220903094433epsmtip2064bdbe9e7581d87f1f67c0c750ba5fc~RUIXLKxjt1887518875epsmtip2Z;
	Sat,  3 Sep 2022 09:44:32 +0000 (GMT)
Date: Sat, 3 Sep 2022 15:04:50 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v3 0/4] fixed-buffer for uring-cmd/passthrough
Message-ID: <20220903093450.GA10373@test-zns>
MIME-Version: 1.0
In-Reply-To: <c62c977d-9e81-c84c-e17c-e057295c071e@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmui6TknCywfFGdYs5q7YxWqy+289m
	cfPATiaLlauPMlm8az3HYjHp0DVGi723tC3mL3vK7sDhsXPWXXaPy2dLPTat6mTz2Lyk3mP3
	zQY2j74tqxg9Pm+SC2CPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
	tVVy8QnQdcvMATpJSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqX
	rpeXWmJlaGBgZApUmJCd8frwA5aCLQoVdy+vY2tg/CLVxcjJISFgInH+5BT2LkYuDiGB3YwS
	U6YcZYFwPjFKbP05jw3C+cYosXjHJWaYlkNHlzJDJPYySvx4fB6q6hmjxPOFk5lAqlgEVCQO
	32wHGszBwSagKXFhcilIWERAQaLn90o2EJtZYBXQvl/SILawgLdEU98DsAW8AroST9bugbIF
	JU7OfMICYnMK2EpsOz2LEcQWFVCWOLDtOBPIXgmBiRwSh3afZoO4zkXi0bmj7BC2sMSr41ug
	bCmJl/1tUHayxKWZ55gg7BKJx3sOQtn2Eq2n+pkhjsuQaFq2kAnC5pPo/f2ECeQXCQFeiY42
	IYhyRYl7k56yQtjiEg9nLIGyPSSO9M+CBuNvJomrCzazTGCUm4Xkn1lIVkDYVhKdH5pYZwGt
	YBaQllj+jwPC1JRYv0t/ASPrKkbJ1ILi3PTUYtMCo7zUcngkJ+fnbmIEp1Itrx2MDx980DvE
	yMTBeIhRgoNZSYR36mGBZCHelMTKqtSi/Pii0pzU4kOMpsDomcgsJZqcD0zmeSXxhiaWBiZm
	ZmYmlsZmhkrivFO0GZOFBNITS1KzU1MLUotg+pg4OKUamPY+rtHq7yn89ueJ8L7GZt5TvqxZ
	2XYHMy4Js7XaLV3JG2A3pWV6ioT6tPTLBz/reHAW6r5IyZiftKZnKfeBqPmTr6ZqCp/PMT2u
	tc/2VIDD91kyk3Ze+nX/tdPXNwln1y9dV7SkYYrkT8eFc3wUTkr5WNzlMxJfcvx8kSLjidV/
	S9Me85cslvDQPZmwRkxKmVNPUKjS7n2Xo8Ei9sD8vPzJPZyZfM0WF4xjRRcwcFznDWGTMxeQ
	5bHZ9ts6++eUwPURV30kknS0LEWu/limHVi3qcP4f7nc+S2+k17znU3ucjhz/sy/AK8cXZM0
	QVu+X91zH5/X+VIuUlCV9auq25eh7TTX/2rlqD8TXjcpsRRnJBpqMRcVJwIAeGi6Ti4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvC6TknCywck9fBZzVm1jtFh9t5/N
	4uaBnUwWK1cfZbJ413qOxWLSoWuMFntvaVvMX/aU3YHDY+esu+wel8+Wemxa1cnmsXlJvcfu
	mw1sHn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXx7+IG5oJnshUHfrayNTAekOhi5OSQEDCR
	OHR0KXMXIxeHkMBuRokJ96YwQSTEJZqv/WCHsIUlVv57zg5R9IRR4tSlPWwgCRYBFYnDN9uB
	EhwcbAKaEhcml4KERQQUJHp+rwQrYRZYxSgx5Zc0iC0s4C3R1PeAGcTmFdCVeLJ2D9Ti30wS
	vQ8Os0AkBCVOznzCAtFsJjFv80NmkPnMAtISy/9xgIQ5BWwltp2exQhiiwooSxzYdpxpAqPg
	LCTds5B0z0LoXsDIvIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzg2tDR3MG5f9UHv
	ECMTB+MhRgkOZiUR3qmHBZKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpa
	kFoEk2Xi4JRqYGIoiNctcEidfDfEO2v9nKslYlOu/QzRObvPf2/igeebfO6o7lj8cN3f04aB
	y2y3rXxV8Xuyd+L/i/eN/KpyGt0zvQO2FqV3u90/mGLKqvTqqFTuhEK7aRO5iuV/Lj1zra5u
	UbYJ0wdRQc8P6buqb9+//+pOTtpx7Q18n+2yfNXPvAkWnyuwdo3xp0Rf3dPnOhd+bbtw7Ixj
	VdzKna6KH5W4C3Nlvr+JNbj3iVPRQlDmBNe+s3zBnKLiSo9/xNcfj9aZ96CEnetQVOnE94tY
	rHIsPndmBB+NlDxxhu92fNfJPU/Clgj/i4t7d+5WGEODTDfH9b5/8QsDYuY8n/9xud3BK1pv
	b+/re1p/+PyeK3OVWIozEg21mIuKEwHFNfeI/AIAAA==
X-CMS-MailID: 20220903094434epcas5p191319b0d20cfa0d58b8399e665be07f9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----zvU9B7RYhoxo0n0NtQiMJbd43ri29uhJZ9UzgKuz80Y8n-YR=_45fb5_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220902152701epcas5p1d4aca8eebc90fb96ac7ed5a8270816cf
References: <CGME20220902152701epcas5p1d4aca8eebc90fb96ac7ed5a8270816cf@epcas5p1.samsung.com>
	<20220902151657.10766-1-joshi.k@samsung.com>
	<f1e8a7fa-a1f8-c60a-c365-b2164421f98d@kernel.dk>
	<2b4a935c-a6b1-6e42-ceca-35a8f09d8f46@kernel.dk>
	<20220902184608.GA6902@test-zns>
	<48856ca4-5158-154e-a1f5-124aadc9780f@kernel.dk>
	<c62c977d-9e81-c84c-e17c-e057295c071e@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220903_024449_548149_98143156 
X-CRM114-Status: GOOD (  22.19  )
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

------zvU9B7RYhoxo0n0NtQiMJbd43ri29uhJZ9UzgKuz80Y8n-YR=_45fb5_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Sep 02, 2022 at 03:25:33PM -0600, Jens Axboe wrote:
>On 9/2/22 1:32 PM, Jens Axboe wrote:
>> On 9/2/22 12:46 PM, Kanchan Joshi wrote:
>>> On Fri, Sep 02, 2022 at 10:32:16AM -0600, Jens Axboe wrote:
>>>> On 9/2/22 10:06 AM, Jens Axboe wrote:
>>>>> On 9/2/22 9:16 AM, Kanchan Joshi wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Currently uring-cmd lacks the ability to leverage the pre-registered
>>>>>> buffers. This series adds the support in uring-cmd, and plumbs
>>>>>> nvme passthrough to work with it.
>>>>>>
>>>>>> Using registered-buffers showed peak-perf hike from 1.85M to 2.17M IOPS
>>>>>> in my setup.
>>>>>>
>>>>>> Without fixedbufs
>>>>>> *****************
>>>>>> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
>>>>>> submitter=0, tid=5256, file=/dev/ng0n1, node=-1
>>>>>> polled=0, fixedbufs=0/0, register_files=1, buffered=1, QD=128
>>>>>> Engine=io_uring, sq_ring=128, cq_ring=128
>>>>>> IOPS=1.85M, BW=904MiB/s, IOS/call=32/31
>>>>>> IOPS=1.85M, BW=903MiB/s, IOS/call=32/32
>>>>>> IOPS=1.85M, BW=902MiB/s, IOS/call=32/32
>>>>>> ^CExiting on signal
>>>>>> Maximum IOPS=1.85M
>>>>>
>>>>> With the poll support queued up, I ran this one as well. tldr is:
>>>>>
>>>>> bdev (non pt)??? 122M IOPS
>>>>> irq driven??? 51-52M IOPS
>>>>> polled??????? 71M IOPS
>>>>> polled+fixed??? 78M IOPS
>>>
>>> except first one, rest three entries are for passthru? somehow I didn't
>>> see that big of a gap. I will try to align my setup in coming days.
>>
>> Right, sorry it was badly labeled. First one is bdev with polling,
>> registered buffers, etc. The others are all the passthrough mode. polled
>> goes to 74M with the caching fix, so it's about a 74M -> 82M bump using
>> registered buffers with passthrough and polling.
>>
>>>> polled+fixed??? 82M
>>>>
>>>> I suspect the remainder is due to the lack of batching on the request
>>>> freeing side, at least some of it. Haven't really looked deeper yet.
>>>>
>>>> One issue I saw - try and use passthrough polling without having any
>>>> poll queues defined and it'll stall just spinning on completions. You
>>>> need to ensure that these are processed as well - look at how the
>>>> non-passthrough io_uring poll path handles it.
>>>
>>> Had tested this earlier, and it used to run fine. And it does not now.
>>> I see that io are getting completed, irq-completion is arriving in nvme
>>> and it is triggering task-work based completion (by calling
>>> io_uring_cmd_complete_in_task). But task-work never got called and
>>> therefore no completion happened.
>>>
>>> io_uring_cmd_complete_in_task -> io_req_task_work_add -> __io_req_task_work_add
>>>
>>> Seems task work did not get added. Something about newly added
>>> IORING_SETUP_DEFER_TASKRUN changes the scenario.
>>>
>>> static inline void __io_req_task_work_add(struct io_kiocb *req, bool allow_local)
>>> {
>>> ?????? struct io_uring_task *tctx = req->task->io_uring;
>>> ?????? struct io_ring_ctx *ctx = req->ctx;
>>> ?????? struct llist_node *node;
>>>
>>> ?????? if (allow_local && ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
>>> ?????????????? io_req_local_work_add(req);
>>> ?????????????? return;
>>> ?????? }
>>> ????....
>>>
>>> To confirm, I commented that in t/io_uring and it runs fine.
>>> Please see if that changes anything for you? I will try to find the
>>> actual fix tomorow.
>>
>> Ah gotcha, yes that actually makes a lot of sense. I wonder if regular
>> polling is then also broken without poll queues if
>> IORING_SETUP_DEFER_TASKRUN is set. It should be, I'll check into
>> io_iopoll_check().
>
>A mix of fixes and just cleanups, here's what I got.

Thanks, this looks much better. Just something to discuss on the fix
though. Will use other thread for that. 

------zvU9B7RYhoxo0n0NtQiMJbd43ri29uhJZ9UzgKuz80Y8n-YR=_45fb5_
Content-Type: text/plain; charset="utf-8"


------zvU9B7RYhoxo0n0NtQiMJbd43ri29uhJZ9UzgKuz80Y8n-YR=_45fb5_--

