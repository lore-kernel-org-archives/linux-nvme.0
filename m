Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8A7C48BF6
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Feb 2024 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:Cc:To:Subject:From:MIME-Version:Date:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=Aw0IMN9Y7pRYo0SHD+2VVrkD9QVYuIV0fmU55u7YJW8=; b=vGXJGIUfpZcijPFzyoqUkZZgvi
	XnLNLKRGZXYoXrB7dyQBugYvgp9d2Q8FLWrEyq2h16k5nvZKCSMPsLMtcXYZxo8QgHEmsG3f0Ti7M
	CcMY9/MtqAxkS6rLhJLHIIFiVzbTMR/gk6s5UQ61PvdhHrm1eg4XiSNNZgvnkuuuneojULpzWFG+l
	M8Dg5j/M+Wwm/1CX+2kcUOT7bdAO/phSrcHr657HMBAWpaC9KH2S+1JJ7tQ2dX3RYxfpnduiU50sJ
	jUFgcC0jwivJJkk5+xkjzhkSFUdQPkyRxW9Z4LbtYIAXDpHWP9VwiuZS1BBJpeV1JY1duSxVmHAkA
	CpMxYKUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdwTl-0000000DOkZ-3qo2;
	Sat, 24 Feb 2024 18:10:29 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdEoi-00000006LAs-1XgS
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 19:33:15 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240222193306epoutp03234bf501fc046f764ba1fecd2219b7a5~2RkigqXfp1736917369epoutp03k
	for <linux-nvme@lists.infradead.org>; Thu, 22 Feb 2024 19:33:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240222193306epoutp03234bf501fc046f764ba1fecd2219b7a5~2RkigqXfp1736917369epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708630386;
	bh=Aw0IMN9Y7pRYo0SHD+2VVrkD9QVYuIV0fmU55u7YJW8=;
	h=Date:From:Subject:To:Cc:References:From;
	b=HuVnE2RXGIl94gGbSgJDqFy7aRTz19YcHesp479Slg9iUL9SqVulUenVIxhqYNwJ1
	 jCjM6+fkR2l4PLlUwnVQDw+JM1Ce3uPpRnP4MurosB8+DdEkbqETX1630mgq3fywNH
	 bRNkBtTw5xfDBGhZeMqQuKt2YTPCQ7kv7UZV/5vc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240222193306epcas5p38944d24b27616360f9254edac8265e4d~2RkiQp2Zo2280222802epcas5p3j;
	Thu, 22 Feb 2024 19:33:06 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Tgjwc3864z4x9Pp; Thu, 22 Feb
	2024 19:33:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.C8.09634.071A7D56; Fri, 23 Feb 2024 04:33:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240222193304epcas5p318426c5267ee520e6b5710164c533b7d~2Rkgafdyu2224022240epcas5p3x;
	Thu, 22 Feb 2024 19:33:04 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240222193304epsmtrp2d5f711e63645fc3832984ffd1f5e3a18~2RkgZyPyc0855908559epsmtrp2C;
	Thu, 22 Feb 2024 19:33:04 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-37-65d7a1706e98
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.E5.07368.F61A7D56; Fri, 23 Feb 2024 04:33:03 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240222193302epsmtip2f9f507d5b8b30595c8713be2ad9bfa8a~2Rkek6Tnc3199931999epsmtip2P;
	Thu, 22 Feb 2024 19:33:02 +0000 (GMT)
Message-ID: <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
Date: Fri, 23 Feb 2024 01:03:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
Subject: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
To: lsf-pc@lists.linux-foundation.org, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	josef@toxicpanda.com, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmum7BwuupBsceiFqsvtvPZrFy9VEm
	iz8PDS0mHbrGaLH3lrbFnr0nWSzmL3vKbrHv9V5mi+XH/zE5cHpcPlvqsWlVJ5vH5iX1HpNv
	LGf02H2zgc3j49NbLB4TNm9k9fi8SS6AIyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ
	19DSwlxJIS8xN9VWycUnQNctMwfoNiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpO
	gUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdkbH8s9sBZf5KzZ23WBqYLzC08XIySEhYCLRcvg9
	axcjF4eQwG5GiR1HOlkgnE+MEree3oTKfGOUmPh+FhNMy5XGTYwQib2MEju3dkJVvWWUmN17
	nQ2kilfATuLi804wm0VAVeLIwsWsEHFBiZMzn7CA2KICSRK/rs5hBLGZBcQlbj2ZD7SBg4NN
	QFPiwuRSkLCwgL/Ei4l9TCDzRQRuM0pMfT8BbDMzyOa+DT1QzfIS29/OYYY4byKHRNsWaQjb
	RWLjl+ssELawxKvjW9ghbCmJz+/2skHYyRKXZp6Deq1E4vGeg1C2vUTrqX5mkIOYgQ5av0sf
	YhWfRO/vJ2B3SgjwSnS0CUFUK0rcm/SUFcIWl3g4YwmU7SHx4/IJsE1CArESu+atZJ3AKD8L
	KSRmIfl+FpJnZiEsXsDIsopRMrWgODc9tdi0wDAvtRweycn5uZsYwclVy3MH490HH/QOMTJx
	MB5ilOBgVhLhZSm/kirEm5JYWZValB9fVJqTWnyI0RQYJROZpUST84HpPa8k3tDE0sDEzMzM
	xNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqZ5awzPH5Jr600PqYpbt/jM5jVmbkr6
	IhaGz1K9W58vFTu5+0DIWj9XcYvN6Rc/eU3jsQsynrzhY17QZE9tQ3nWVQeTvqZ8u7Om94gI
	b+YUdkFlOz5DgX03pCK3Mt6TXem6PPqi1FyR5b+LS+/t/1kqdjbQXKRz7YtrcQ2mvrO3i+z/
	kCWgV/3z9n4+YZGVhbHsCc/DYtbdNFd6+y3q9u2TmVWaeQV/5ZT2Wkzd/sEgZc6duJOmpc8j
	PLma/rLdyQy71Ss+8VnGew0lzVmBVz5Z7vtokZz8LFvVc/mnzPt5axx2RWbHhZ/45BF4LrM+
	YNaWIMuT+ueFJJbdtmyKNI7VPtdrev9y9zVRqdP/+ZVYijMSDbWYi4oTAW9lYek3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvG7BwuupBv8CLFbf7WezWLn6KJPF
	n4eGFpMOXWO02HtL22LP3pMsFvOXPWW32Pd6L7PF8uP/mBw4PS6fLfXYtKqTzWPzknqPyTeW
	M3rsvtnA5vHx6S0WjwmbN7J6fN4kF8ARxWWTkpqTWZZapG+XwJXRsfwzW8Fl/oqNXTeYGhiv
	8HQxcnJICJhIXGncxNjFyMUhJLCbUeLa8YXMEAlxieZrP9ghbGGJlf+es0MUvWaU2LjtFCtI
	glfATuLi8042EJtFQFXiyMLFUHFBiZMzn7CA2KICSRJ77jcygdjMQENvPZkPZHNwsAloSlyY
	XAoSFhbwlehu3wJ2hIjAbUaJPRsvgDnMAnsZJbrWP2SEaDaT6NraBWXLS2x/O4d5AqPALCT7
	ZiHZMQtJyywkLQsYWVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgRHjJbGDsZ78//p
	HWJk4mA8xCjBwawkwstSfiVViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2amp
	BalFMFkmDk6pBqbZL9Ujfm3YFenw8+r2zfPvihyt2uh8PNRkIc927ZAXLaZPepSjP0kXz5Pj
	W9FWIjBnyyvlIz/iVW2aZCekS/P2OyoJROp9Xue2Z6Jqr71Ec0POMdH7IRMSnhl4zuC+Z5+0
	q6/lTfGEZIVDBgfSex8eELf8cWCm7MRTERrznt8Sr5IRW2m+ZGZlzTIh3/vnryTxcWev3n03
	TvLm6ulylwRfBFj9ONKSuNbI06p9WvKZZOEylnMOuXnrDNy+rT639MZC79I3B1xLZs5MjPw0
	ZfsjpzTmyR3f8xceM3kSKNv0Z5F5zse1FTPj162rMnA6U8q069fyIyHLV22/c0cntfLhCb7c
	iMhvh3lWxG4r7VmsxFKckWioxVxUnAgAH+X/XwcDAAA=
X-CMS-MailID: 20240222193304epcas5p318426c5267ee520e6b5710164c533b7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240222193304epcas5p318426c5267ee520e6b5710164c533b7d
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
X-Bad-Reply: References but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_113313_069485_EBA3952F 
X-CRM114-Status: GOOD (  16.62  )
X-Mailman-Approved-At: Sat, 24 Feb 2024 10:10:24 -0800
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

With respect to the current state of Meta/Block-integrity, there are
some missing pieces.
I can improve some of it. But not sure if I am up to speed on the
history behind the status quo.

Hence, this proposal to discuss the pieces.

Maybe people would like to discuss other points too, but I have the 
following:

- Generic user interface that user-space can use to exchange meta. A
new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
direct IO. Buffered IO seems non-trivial as a relatively smaller meta
needs to be written into/read from the page cache. The related
metadata must also be written during the writeback (of data).


- Is there interest in filesystem leveraging the integrity capabilities 
that almost every enterprise SSD has.
Filesystems lacking checksumming abilities can still ask the SSD to do
it and be more robust.
And for BTRFS - there may be value in offloading the checksum to SSD.
Either to save the host CPU or to get more usable space (by not
writing the checksum tree). The mount option 'nodatasum' can turn off
the data checksumming, but more needs to be done to make the offload
work.

NVMe SSD can do the offload when the host sends the PRACT bit. But in
the driver, this is tied to global integrity disablement using
CONFIG_BLK_DEV_INTEGRITY.
So, the idea is to introduce a bio flag REQ_INTEGRITY_OFFLOAD
that the filesystem can send. The block-integrity and NVMe driver do
the rest to make the offload work.

- Currently, block integrity uses guard and ref tags but not application 
tags.
As per Martin's paper [*]:

"Work is in progress to implement support for the data
integrity extensions in btrfs, enabling the filesystem
to use the application tag."

I could not figure out more about the above effort. It will be good to
understand the progress/problems.

I hope to have the RFC (on the first two items) for better discussion.

[*] https://www.landley.net/kdocs/ols/2008/ols2008v2-pages-151-156.pdf

