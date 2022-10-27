Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB78AFA3740
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=M4ReEIrUfP/2MH0U6RQ02CgaHg7RcXV4unMaR3NsHFU=; b=Mk33uksSo4D0UnbozWXYhfVspB
	v7uwvpLBpbxVIyGHZn1AP2DV0ci0mKh8QfXnZOULsZCiH/sbGhZa2R4u0eBqoSyNWQBoMtbKfGkFW
	iLFUzFvvZ+ekAqgdndXjICfKZiJEn1E0iZ9bfKFLe6b2IbSSV+489P3ZLyjp3xglvwraDa9s/zNO+
	eHeOjDeX6mHe+ZeBrmcIyjBQwdaG3xDcXdQfAkRHWiD4jL/b2/w3UDhTwvLKPJ4LHPCpKa6tVUFYp
	BAiqM+qki459GkHxOYuad8Ymd4cSYF39MektbpowmrKx1vA+grjRBOGCXt4GIWdUo4EwXacaAHEeX
	cXhpJJiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5Jm-00E9hl-TP; Thu, 27 Oct 2022 16:01:18 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5Jg-00E9Zm-Vn
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 16:01:16 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221027160104euoutp01af7f1e1eb99664074184fc11c71f6a0f~h_Ghe_DB31665216652euoutp01P
	for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 16:01:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221027160104euoutp01af7f1e1eb99664074184fc11c71f6a0f~h_Ghe_DB31665216652euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666886464;
	bh=M4ReEIrUfP/2MH0U6RQ02CgaHg7RcXV4unMaR3NsHFU=;
	h=From:To:CC:Subject:Date:References:From;
	b=seFhpIsEkNDv8D2F1fKsRFDWie6DiNUUHAOWBbGf6bZsYwBlB6/O6htIoSPhQtkpl
	 0QsQH1JPhkAStYmVEex4PJGvZRT2Q+AqnGyVYilsLm/3//kIoaHF8W1lZcF/uYgv5l
	 aMbX1AW8GqHOmaqlRRbs3S5kd1x0gpf19e5LIgTQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221027160103eucas1p25acfa28dc9c38eddf8e4851b81c75277~h_GgsqLsJ2687226872eucas1p29;
	Thu, 27 Oct 2022 16:01:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.80.19378.F3BAA536; Thu, 27
	Oct 2022 17:01:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221027160102eucas1p1bb39a9a2b8ed6b54f854849532359332~h_GgQ6QIl3124331243eucas1p1v;
	Thu, 27 Oct 2022 16:01:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221027160102eusmtrp22926fe24d471157452ba959be780097b~h_GgQPeOo1530215302eusmtrp2a;
	Thu, 27 Oct 2022 16:01:02 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-e7-635aab3f6132
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.AE.10862.E3BAA536; Thu, 27
	Oct 2022 17:01:02 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221027160102eusmtip1b712000ea3f217da9e02793dd361c8f2~h_GgFuR4v2400824008eusmtip1f;
	Thu, 27 Oct 2022 16:01:02 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 27 Oct 2022 17:01:01 +0100
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <sagi@grimberg.me>, <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<joshi.k@samsung.com>, <javier.gonz@samsung.com>, <p.raghav@samsung.com>,
	Joel Granados <j.granados@samsung.com>
Subject: [RFC 0/3] nvme : Add ioctl to query nvme device attributes
Date: Thu, 27 Oct 2022 17:57:21 +0200
Message-ID: <20221027155724.1161670-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7djP87r2q6OSDVa8EbVYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBkPu9tY
	Cy5LVuxoe87SwPhDpIuRk0NCwETi75UHzF2MXBxCAisYJWZdeskG4XxhlLiz4yMjSJWQwGdG
	iZunrWE6rp99yARRtJxRYm//ZEYIB6ho9o61ULM2M0qcaW1kB2lhE9CROP/mDjOILSJgKTHh
	zX8WkCJmgU2MErc2LmMCSQgLOEt0b53OAmKzCKhKTJ92mBXE5hWwlfjZ9J0dYre8RNv16UDr
	OICaNSXW79KHKBGUODnzCVgrM1BJ89bZzBDlihJb5nxnhbBrJU5tuQV2toTAHg6Jhd3v2EHm
	SAi4SCzuUoOoEZZ4dXwL1CoZif875zNB2NkSO6fsgppZIDHr5FQ2iFZrib4zORBhR4mL/YtZ
	IMJ8EjfeCkJcwycxadt0Zogwr0RHmxBEtZrEjqatjBMYlWchvDILySuzkLyygJF5FaN4amlx
	bnpqsXFearlecWJucWleul5yfu4mRmACOf3v+NcdjCtefdQ7xMjEwXiIUYKDWUmE9+yN8GQh
	3pTEyqrUovz4otKc1OJDjNIcLErivGwztJKFBNITS1KzU1MLUotgskwcnFINTFndat4uRT41
	AqIOX+WObMpvZpue4CZ2+65Jb3Lbri3lop+OXE2riOpTVJW2CgioUFfgPqSzqDKscPOpVUsf
	Tpyt+EOvuKA365bYlYa1qeuPTpO8cmFhog4z+9u5idVf+L8vYT7J8GQC083tEq/cd5dfj3Gc
	pCzzNSRkw+eCnYLfjrPULzKYwHFfhy91+a6ZrU9/MJR/dvaZZV2iPqXxDvN5h88tq1a+ufdA
	aZfuIb8/+ZNPrg7XyVR6ldNQcOR8wcvWpHnvLqXf9ytz/5Ut3eXzoM42a/eDJcul7rztbbx+
	acH3n7arzz1/OC/WOKl1h2aPqH5w2JbaFVfX9U75xBhievDwIc48/tT9l1PkdZVYijMSDbWY
	i4oTAUTOeVCPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xu7p2q6OSDY5MNrVYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkPu9tYCy5LVuxoe87SwPhDpIuRk0NC
	wETi+tmHTF2MXBxCAksZJV7+3MoGkZCR+HTlIzuELSzx51oXG0TRR0aJb40fWCCczYwSxx5v
	YgKpYhPQkTj/5g4ziC0iYCkx4c1/sCJmgU2MErc2LgMrEhZwlujeOp0FxGYRUJWYPu0wK4jN
	K2Ar8bPpO9Q6eYm269MZuxg5gJo1Jdbv0ocoEZQ4OfMJWCszUEnz1tnMEOWKElvmfGeFsGsl
	Pv99xjiBUWgWQvcsJN2zkHQvYGRexSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERg124793LKD
	ceWrj3qHGJk4GA8xSnAwK4nwnr0RnizEm5JYWZValB9fVJqTWnyI0RTom4nMUqLJ+cC4zSuJ
	NzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYDqgkCV1QColjXfbYqtV
	dde3Lg1bu/QSU131+t3vDY/1hZY5zdwae+pQaqiwdlhu2ecvjNXRrk/1pzY9vrZUoza8K+h3
	dd2mGfHSD1yOvd6uODMtrUF+/5fl2t9Wl2Vu2LjxVJNrkalV0d3WmyqvN59eLWx2KIx5nsmG
	hxrWy66UTE7IYxKb+sIndcsa4c0yUUEWh46pnH62xU7Qatem3cbzJuluaV+yJu55ekXkzccH
	qn6yt3m+t4qcKfB6vdO5yqgf61/dW8OStcz2+v2aZ5nOTj1Rc30tJ5yY4fbr2tZb357+eXva
	afvBtje1il41Ch2prfZafpr/vt09/i38aPCrext8XL/3/RRde3ZyyYReJZbijERDLeai4kQA
	Rtxk5iMDAAA=
X-CMS-MailID: 20221027160102eucas1p1bb39a9a2b8ed6b54f854849532359332
X-Msg-Generator: CA
X-RootMTR: 20221027160102eucas1p1bb39a9a2b8ed6b54f854849532359332
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221027160102eucas1p1bb39a9a2b8ed6b54f854849532359332
References: <CGME20221027160102eucas1p1bb39a9a2b8ed6b54f854849532359332@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_090113_619471_6AD9C844 
X-CRM114-Status: GOOD (  19.16  )
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

What?
In this patch I add an ioctl that provides nvme controller attributes to
the user that can open the char device file. We also provide them for the
block devices for convenience.

Why?
Applications with write permissions should not need to be privileged to
write to the device. With Kanchan's latest patch
(https://lore.kernel.org/linux-nvme/20221020070205.57366-1-joshi.k@samsung.com/)
the nvme IO and identify commands in passthru now follow device
permissions; however there are still some controller attributes like
minimal data transfer size (MDTS) which need a privileged user to be
queried.

How?
Added an ioctl (NVME_IOCTL_GET_ATTR) that fetches attributes from the nvme
driver. It sends both nvme_identify_ctrl and nvme_identify_cs_ctrl commands
to query the attributes that are not contained in nvme_ctrl already.

I have rebased this on top of Kanchans "nvme: identify-namespace without
CAP_SYS_ADMIN" (https://lore.kernel.org/linux-nvme/20221020070205.57366-3-joshi.k@samsung.com)
because this only makes sense if we can also do IO as unprivileged.

I have made the call extensible by embedding the struct size as the first
member and using it as a version. As more members get added, the switch
statement gets populated with more checks. For this I followed in the steps
of the openat2 system call [1] and the extensible ioctl for vfio [2].
Another interesting reference for this is here https://lwn.net/Articles/830666/

The first patch in the series is a fix to a potential bug in a return
value. This was in a section of the code that was getting changed so I
decided to include it in this series.

Questions:
1. I started by providing members that have relevant attributes like mdts,
   and mpsmin for regular writes as well as wzsl, wusl for more specialized
   write commands like write zeroes and also dmsl, dmrsl, dmrl for dataset
   management commands.  Have I missed an attribute that should definitely
   be there? Or have a included one which should be removed?

2. Naming is always important. We called it "GET_ATTR" because it "gets"
   nvme specific attributes. This is fairly general for whatever we want to
   add in the future, but do we need to be more specific here? Alternatives
   are  "NVME_IOCTL_DEV_ATTR", "NVME_IOCTL_DRV_ATTR" or
   "NVME_IOCTL_CTRL_ATTR". Thoughts?

3. I have named the communication structure "nvme_get_attr" to be
   consistent with the ioctl name. Are there alternatives?

4. I have made the ioctl call extensible because I believe that this ioctl
   might grow in the future as ppl see that there might be more data needed
   to do an nvme write.

[1] https://github.com/torvalds/linux/commit/fddb5d430ad9
[2] https://github.com/torvalds/linux/blob/master/include/uapi/linux/vfio.h#L56

Joel Granados (3):
  nvme: Return -ENOMEM when kzalloc fails
  nvme: Move nvme identify CS to separate function
  nvme : Add ioctl to query nvme attributes

 drivers/nvme/host/core.c        | 35 ++++++++++------
 drivers/nvme/host/ioctl.c       | 58 ++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        | 10 +++++
 include/uapi/linux/nvme_ioctl.h | 74 +++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 13 deletions(-)

-- 
2.30.2


