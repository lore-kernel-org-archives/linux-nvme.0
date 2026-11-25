Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75376606A33F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Nw+xKy1l;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=mi7xmyv8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Unsubscribe-Post:
	List-Owner; bh=aol/YqFRk4VDFuOdOrJ3/H+/AAewZsmUni4kor0IGao=; b=Nw+xKy1lXzOAfA
	DN/1h+FOh5+JrRi7pzsAHjgfVvmKBjnlmT1B622uC1IhinmLE7LlidqdssGi2MBdUM/CIGUpdD8aE
	/ZRtsrvk0KC0eM7syAGpA98e97R8Rr3LjIxJWxOdCxMI4V3HNHVZCObN7tKfK+ffQD8A5XRB8zQhh
	RjkN9zAHaVkCjXMoI1QRAVitFxE59tny2P4h6W80N1mkTH7YrKYawZT7U1rmP4PLVC1aPdj6X9Doe
	7/OqqR85cxbg2i/LyREva2aTl0ivHKCHsZws32PWBfXPtH+al1AUJVJF72rXBgmRDJswdjvQ9YR4w
	20skGnSntPBN1Y9EmyMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWB1y-00000009ZQN-2SAY;
	Wed, 25 Nov 2026 11:19:18 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWB1t-00000009ZNx-3EWH
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 11:19:16 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261125111907epoutp049fd0732459edc9f9ce05971e59258ad0~rRbtjNqQ82971329713epoutp044
	for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 11:19:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261125111907epoutp049fd0732459edc9f9ce05971e59258ad0~rRbtjNqQ82971329713epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795605547;
	bh=aol/YqFRk4VDFuOdOrJ3/H+/AAewZsmUni4kor0IGao=;
	h=From:To:Cc:Subject:Date:References:From;
	b=mi7xmyv8qCtkuiWVFS1WmHypp1B+5LuE/Onl2ebD59v8iDInV6Id5ZoH609GzZGWI
	 F+lqmxW/EE3mo6VYy1LjHcms5nMt9q6M66ehdngemO/F3tsVCwt3rRkDoK1u2ePUd5
	 Ha+SV2YHemHMj+pNDH0NMrhl3JhgMspyl0E4rtR0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261125111906epcas5p3ad070fe44b9392c0c2bc262258b274bb~rRbsMuv6b2807028070epcas5p3Q;
	Wed, 25 Nov 2026 11:19:06 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jZHHs0qfmz6B9m7; Wed, 25 Nov
	2026 11:19:05 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261125105614epcas5p4386cb5bb9966904c9ac38382eb6c753c~rRHukvjxj2438724387epcas5p4f;
	Wed, 25 Nov 2026 10:56:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261125105612epsmtip1d13c7f175a618d2175756dfce5229682~rRHsoqeWQ1560715607epsmtip1c;
	Wed, 25 Nov 2026 10:56:12 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Cc: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>, Kanchan
	Joshi <joshi.k@samsung.com>, "Martin K. Petersen" <mkp@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexander
	Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@infradead.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, Pavel Begunkov
	<asml.silence@gmail.com>
Subject: [LSF/MM/BPF TOPIC] io_uring dmabuf storage I/O: next steps
Date: Wed, 25 Nov 2026 16:25:16 +0530
Message-Id: <20261125105516.2160670-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261125105614epcas5p4386cb5bb9966904c9ac38382eb6c753c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261125105614epcas5p4386cb5bb9966904c9ac38382eb6c753c
References: <CGME20261125105614epcas5p4386cb5bb9966904c9ac38382eb6c753c@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_031914_518954_4C377437 
X-CRM114-Status: GOOD (  10.23  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Nitesh and I would like to propose a joint Storage and Filesystem
session to discuss the next steps for io_uring dmabuf storage I/O.

Pavel's raw block device support landed in 7.4[1]. We would like to
use the session to discuss the following:

1. Filesystem I/O: RFCs have been posted for XFS[2] and ext4[3], and we
   are working on a combined series[4]. Open topics include files
   spanning multiple devices and support for additional filesystems.
2. NVMe/RDMA: we posted an RFC[5] for direct I/O between accelerator
   memory and storage over NVMe/RDMA.
3. Vectored I/O: support readv/writev with dmabuf registered buffers.
4. Polled I/O: enable polling for workloads that need the lowest
   latency and overhead.
5. NVMe multipath support.

[1] https://lore.kernel.org/linux-block/cover.1791975048.git.asml.silence@gmail.com/
[2] https://lore.kernel.org/linux-block/20261016091919.971295-1-anuj1072538@gmail.com/
[3] https://lore.kernel.org/linux-block/20261113070621.273953-1-mengmeng.zhao@linux.dev/
[4] https://lore.kernel.org/linux-xfs/20261124084025.2101804-1-anuj20.g@samsung.com/
[5] https://lore.kernel.org/linux-nvme/20261118103327.1788667-1-anuj20.g@samsung.com/

Thanks,
Anuj

