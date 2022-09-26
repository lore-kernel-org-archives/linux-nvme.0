Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361F0C07E9D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=Ot9WMoh93UEdgJl+eMHq01415Jxr9YT73Of/c/+pnD0=; b=CPE+Jn4hm8gQxSOM6Vcns6h4MX
	0WgUxfxOeKRoN2bU+iWCVh/Ss/da4XqyfXUaOEvpRKIKapc9DyT7/p3vMi6l/539HYKT0CgNemZsQ
	r7oqfmEsdYgMhA31/I/tLEYIvFhqB3eBU6ALVEBDTgsDt13SfqyBz21eZAZ9XCQVWSXI/yddB/B0i
	JQEJQSnuK9m0cOm+T6kLFF5dyVw619IjF7EwUpcno+b1r9n5a1hY976JhUn+xKL8kPuqcE13HJN7X
	AoZCrkflRLUE4I/x7wzbe33rLYGpuJ6PAIo5GgBMTIGPv+Ou790cC6iyh44cea28D7QlzlQrtNZ6y
	OLvbrEJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpfF-005YtJ-FA; Mon, 26 Sep 2022 15:04:57 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpfB-005Yqk-82
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 15:04:55 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220926150439epoutp03b0713cbec4bea521abaca498223e8e67~YcVaeHKVn1805818058epoutp03h
	for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 15:04:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220926150439epoutp03b0713cbec4bea521abaca498223e8e67~YcVaeHKVn1805818058epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664204679;
	bh=Ot9WMoh93UEdgJl+eMHq01415Jxr9YT73Of/c/+pnD0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HfyBnnrYGElqYdSNsKt+WNZCwEF0lbVbTi064xSm0QZq/159Nav6XsfNaH0TTndlt
	 o/C8WLKyQJJBTjQjHAblaMQyo+o8nnGJISznOp4RKBjXMnt+TvvZGWNBNkkUbGAAG1
	 FoI6gF3xuIPF/vrJAc5Pt1CXbyF/jQMdpAamDaUQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220926150438epcas5p106581b87686e1afce8d770833acef239~YcVZoBWR21517115171epcas5p1r;
	Mon, 26 Sep 2022 15:04:38 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4MbmJ43Znxz4x9Pp; Mon, 26 Sep
	2022 15:04:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.1D.26992.48FB1336; Tue, 27 Sep 2022 00:04:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220926150436epcas5p4fd7f1945793cded05910da5c5094805e~YcVXpCfyq1526015260epcas5p4E;
	Mon, 26 Sep 2022 15:04:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220926150436epsmtrp1d35adeb12ec9cde0a63988f6df1d90e3~YcVXoL9J90808308083epsmtrp1l;
	Mon, 26 Sep 2022 15:04:36 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-8a-6331bf84b306
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.13.14392.38FB1336; Tue, 27 Sep 2022 00:04:35 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220926150434epsmtip2d669ee37b55d2495b7ee551e44bb23d4~YcVWIZKUX1214312143epsmtip2Q;
	Mon, 26 Sep 2022 15:04:33 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next 0/2] Fine-granular CAP_SYS_ADMIN
Date: Mon, 26 Sep 2022 20:24:28 +0530
Message-Id: <20220926145430.81658-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmum7LfsNkgxv3JS1W3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	fVtWMQawRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
	5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQw
	MDIFKkzIzjh06yRjwXuOik9HGhkbGPvZuxg5OSQETCQ+n2sGsrk4hAR2M0psePWfGcL5xCjx
	ZvlRJgjnG6PExKv7gTIcYC0LjhtAxPcySjR/2MMI4XxmlLi7+hkbSBGbgKbEhcmlICtEBFwk
	PvdcYAWxmQXiJW7+3QxWIixgKTH9jiuIySKgKtGxnR+kglfAQqJpwWFGiOPkJWZe+s4OEReU
	ODnzCQvEFHmJ5q2zwe6UELjELvG4bzsLRIOLRP+h3awQtrDEq+NboL6UknjZ3wZlJ0tcmnmO
	CcIukXi85yCUbS/Reqof7EVmoOvX79KH2MUn0fv7CRPE57wSHW1CENWKEvcmPYXaJC7xcMYS
	KNtD4sjPDWwgtpBArERH50fmCYxys5B8MAvJB7MQli1gZF7FKJlaUJybnlpsWmCYl1oOj8jk
	/NxNjOAUqOW5g/Hugw96hxiZOBgPMUpwMCuJ8KZc1E0W4k1JrKxKLcqPLyrNSS0+xGgKDNWJ
	zFKiyfnAJJxXEm9oYmlgYmZmZmJpbGaoJM67eIZWspBAemJJanZqakFqEUwfEwenVAOTmnMt
	d4p46bwZRy5X67IqPV7SuMdk7rutKbFFd7MunGy8lb2QKY3riq/oDPv8eXOkhJIfL5woMftV
	vboc7127ddH7bseciZsxJTdl8jXGL6n7dt8Q2+uV9lirbXt5p2eWv0ly69obv5q3KR0O5Dg3
	995X1227ePRFMndf3bFsw9drBW7xHwSkNq/etTtq8berHA6MiW/FbR+HO9md/nv9s2nIjguP
	1F8tDvv68qEHs9feVwHHZbTua5k28KTm2Ty46c4yX+WaUa26wJ487X/ap/nvHjv8fF6ok1eT
	/sFYx6XfLj+V8Mr++Ofk7dlf5x7UD/46y+4fv9wTIYG8qb8/7cwqzzwsOv0sE19fbznLLSWW
	4oxEQy3mouJEAHoh78oKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvG7zfsNkg8MzbCxW3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	fVtWMQawRXHZpKTmZJalFunbJXBlHLp1krHgPUfFpyONjA2M/exdjBwcEgImEguOG3QxcnEI
	CexmlLjyeDJLFyMnUFxcovnaD3YIW1hi5b/n7BBFHxkljjafYgVpZhPQlLgwuRSkRkTAS+L2
	y+fMIDazQKLE+6OPwUqEBSwlpt9xBTFZBFQlOrbzg1TwClhINC04zAgxXV5i5qXv7BBxQYmT
	M5+wQEyRl2jeOpt5AiPfLCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525i
	BIepluYOxu2rPugdYmTiYDzEKMHBrCTCm3JRN1mINyWxsiq1KD++qDQntfgQozQHi5I474Wu
	k/FCAumJJanZqakFqUUwWSYOTqkGprnB4uc/LA0tSbp24Wfc0qhnMrXcS9r8jhfsWNs8455J
	0TRGVWmD7WHLJkRKxQnf/f7mXUrwfEG3xMeWkue/zbp60WpN9t49U/2qykrTRJn35ac2srKE
	KVrMOud0Rn3R7zq7mtDlBdO1ebYxTrhQyniQY+MPfY72wiUXZobGh1fvNXfOSYg9xZqsprhg
	s8WCrkDWQP/U7nY3dtnFJVciM7d81Y90EE6UM7x3edqKEr8rW1tLzI7MKVm/bNmFTD+vG6xJ
	b/TWPv5f+FhhpfkhvuKvPol+zueXnKiXU0hp0uxYuzJNyT3ryrqHJnafQpvXPXi2xNdkUebM
	o/d0JPZ+/62bLMoqPvGphIpf+op4JZbijERDLeai4kQAAQZCEsICAAA=
X-CMS-MailID: 20220926150436epcas5p4fd7f1945793cded05910da5c5094805e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220926150436epcas5p4fd7f1945793cded05910da5c5094805e
References: <CGME20220926150436epcas5p4fd7f1945793cded05910da5c5094805e@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_080453_778495_9B554667 
X-CRM114-Status: GOOD (  11.84  )
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

Current nvme passthrough interface is more useful than it used to be.
Now that user-space has more reasons to pick this path, the existing
CAP_SYS_ADMIN based checks are worth a revisit.

Currently both io and admin commands are kept under a
coarse-granular CAP_SYS_ADMIN check, without any regard to file open
mode.

$ ls -l /dev/ng*
crw-rw-rw- 1 root root 242, 0 Sep  9 19:20 /dev/ng0n1
crw------- 1 root root 242, 1 Sep  9 19:20 /dev/ng0n2

In the example above, ng0n1 appears as if it may allow unprivileged
read/write operation but it does not and behaves same as ng0n2.

The series attempts a shift from CAP_SYS_ADMIN to more fine-granular
control for io-commands. This is somewhat similar to scsi whitelisting.

Patch 1: contains the new policy for io command control
Patch 2: changes the callers to use that

Kanchan Joshi (2):
  nvme: add the permission-policy for command control
  nvme: Make CAP_SYS_ADMIN fine-granular

 drivers/nvme/host/ioctl.c | 89 +++++++++++++++++++++++++--------------
 include/linux/nvme.h      |  1 +
 2 files changed, 58 insertions(+), 32 deletions(-)

-- 
2.25.1


