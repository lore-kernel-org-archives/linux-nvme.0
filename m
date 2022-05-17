Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B897C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xx6LiI2N7zXzXe6D47VeoDmtSPAgM7x9gfv66x7nXf4=; b=eiJeM0ZA2ZcMkucKtejkqNhL9c
	/j4+E20S7XL3IWw/vibey9eTFDIZu/j8V5LN0MoV73IGzkVmrytyXRm5+rP/U+MfsxBgNIsy3kzj3
	fY2ayAslAXRQOSwVuanITRvbFWUQ8bbNogpSjICqM1UQ1pz4ZZE6l2mwrw0Dd088CJGFAJbNN4EFa
	4mKt1jl75ji9uWlsCKTr+BP7GrIt0l8YIf9VqBRWfODW7zbiV5jnTCQzq8+DBJNFeWrL9CjWx2XBB
	GJUQpVetbBVego8uF2JnpuKVSd9jH7SbE6nRuIqNpwwQMpdDisGz9QunwxO5wLz7XDX5FU5CFOw7m
	b4C/xvbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqtLt-00ChcE-BL; Tue, 17 May 2022 09:18:49 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqtLp-00ChZ9-9s
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 09:18:48 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220517091836euoutp02a5e5b3b17c78f968633516bd239feaf0~v2dmdUHCG0490604906euoutp02s
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 09:18:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220517091836euoutp02a5e5b3b17c78f968633516bd239feaf0~v2dmdUHCG0490604906euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652779116;
 bh=Xx6LiI2N7zXzXe6D47VeoDmtSPAgM7x9gfv66x7nXf4=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=hMgYG7XvevVMTdKyCW0VFsYHH8VnAGJ6cLJYur6m512PL0lmLh8XaRH7mTTifQgup
 MbMx1U/jJHUNdjZLywNzwlIepPFXGJ7iKpKe8TLMKDHUtRaVhmjbWxj8fZ4M8urrs7
 6ln00CUCifBThwd+G7OUFOsVT8d7oQCVhraPp+cg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220517091836eucas1p1b4f31c8b471be4cec69d428e87500289~v2dmHOtrc0676506765eucas1p1o;
 Tue, 17 May 2022 09:18:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 44.CF.09887.C6863826; Tue, 17
 May 2022 10:18:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220517091836eucas1p29b087b757e6368110a993b6161f558a4~v2dlr-o5d1027210272eucas1p2Z;
 Tue, 17 May 2022 09:18:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220517091836eusmtrp268345fd5a35205b6ac7f4519dcde07ee~v2dlqyygZ0823508235eusmtrp28;
 Tue, 17 May 2022 09:18:36 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-c5-6283686c6c70
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.C7.09522.B6863826; Tue, 17
 May 2022 10:18:36 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220517091835eusmtip22dc882ff288673a913e1a719db7c1311~v2dlik-a70904809048eusmtip2V;
 Tue, 17 May 2022 09:18:35 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 17 May 2022 10:18:35 +0100
Date: Tue, 17 May 2022 11:18:34 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Pankaj Raghav <p.raghav@samsung.com>, <axboe@kernel.dk>,
 <damien.lemoal@opensource.wdc.com>, <pankydev8@gmail.com>,
 <dsterba@suse.com>, <linux-nvme@lists.infradead.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
 <jiangbo.365@bytedance.com>, <linux-block@vger.kernel.org>,
 <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
 <dm-devel@redhat.com>
Subject: Re: [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220517091834.dvkrab5l63v3b2zn@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20220517081048.GA13947@lst.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djP87o5Gc1JBqubpC1W3+1ns/h99jyz
 xd53s1ktLvxoZLJYufook0XPgQ8sFntvaVtceryC3WLP3pMsFpd3zWGzmL/sKbvFmptPWRx4
 PP6dWMPmsXPWXXaPy2dLPTYvqffYfbMBKNJ6n9Xj/b6rbB7rt1xl8fi8SS6AM4rLJiU1J7Ms
 tUjfLoErY/3CFSwFS/gqGtdvZ2xg7OXuYuTkkBAwkbi48RZLFyMXh5DACkaJLdPmskI4Xxgl
 fs/fxgzhfGaU2Nl7kBGmZfu2j0wQieWMEl+vXGWEq7o7Zy4bhLOVUWJOywZ2kBYWAVWJ/iur
 wWw2AXuJS8tuMYPYIgJKEk9fnQXrZhZoZpaY9PAckMPBISzgJLH4NzOIyStgK/HvcDRIOa+A
 oMTJmU9YQGxmASuJzg9NrCAlzALSEsv/cYCEOQV0JG4uew/WKSGgLLF8ui/EzbUSa4+dYQdZ
 JCGwmFNi8ssrbBAJF4nH+14xQ9jCEq+Ob2GHsGUk/u+czwRhZ0tcPNMNVVMisfj9Maj51hJ9
 Z3Igwo4S7bf2skOE+SRuvBWEOJJPYtK26VDVvBIdbUIQ1WoSO5q2Mk5gVJ6F5K1ZSN6ahfDW
 AkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIGp6/S/4192MC5/9VHvECMTB+MhRgkO
 ZiURXoOKhiQh3pTEyqrUovz4otKc1OJDjNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFIN
 TNLvJ7dJB5YJ3Ft9kyUzz/vAopyD/gszri+vVDXbyqlSF8b9u8f9vairXnCEaMDJvDv8KZMZ
 XQ7ePhlb2h94bs0JkeOt0hmHwqb8ivq17N8+hatf1NX/+cuGT8sL+znD97bc4mYuo+wTG9eX
 3YtNeeN7LtPrukz3ks48mZaMx+H6M/O/K00NVHReac3ycgf3Nn0Wbv7X+klczr8rJ+z/8WfL
 1MORqS+tF3wRDnBWLHYJW+QrFp6s6nPqmeDJrJUBbzTZhW9HrFP58NNp9Z+l9a+teayFmULf
 /t5yXjDHtkBdOMQjoVlw4reT+57on7CffqGFkdFhu9i2KwKe3O3m73a5mX6OXrp7j2B6+uN5
 SizFGYmGWsxFxYkALkktKMwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7o5Gc1JBiuvMVmsvtvPZvH77Hlm
 i73vZrNaXPjRyGSxcvVRJoueAx9YLPbe0ra49HgFu8WevSdZLC7vmsNmMX/ZU3aLNTefsjjw
 ePw7sYbNY+esu+wel8+WemxeUu+x+2YDUKT1PqvH+31X2TzWb7nK4vF5k1wAZ5SeTVF+aUmq
 QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvqFK1gKlvBVNK7f
 ztjA2MvdxcjJISFgIrF920emLkYuDiGBpYwSPWdWM0MkZCQ+XfnIDmELS/y51sUGUfSRUeLo
 27WsEM5WRom9T2+CdbAIqEr0X1kN1sEmYC9xadktsLiIgJLE01dnGUEamAUamSUm3loGNIqD
 Q1jASWLxb2YQk1fAVuLf4WiQciGBDUAzF3uC2LwCghInZz5hAbGZBSwkZs4/zwhSziwgLbH8
 HwdImFNAR+LmsvdgUyQElCWWT/eFOLlW4tX93YwTGIVnIRk0C8mgWQiDFjAyr2IUSS0tzk3P
 LTbUK07MLS7NS9dLzs/dxAiM4W3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeA0qGpKEeFMSK6tS
 i/Lji0pzUosPMZoCw2Eis5Rocj4wieSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqem
 FqQWwfQxcXBKNTBxKyapr3/1xatW42ms5seT5RF/fSMv7JBKztHe2BZ9RFZytQ6vJntxf9Yf
 t4f9YazrkoTyOKvedWhfvcLXc6d6i8pxnzRN3SMH/9vbv2EPYM/yP/7hvE3gOmmnY3fy1bKZ
 dxTyf7y9qT+xb4vErgk9mr7Jcsv/8Tx3uhGg79+dcLQuxS6zaWtzwONbf5bs0m+am3j74OG0
 byr3rxzJevDgzDWBovDEP4xMO8x+pPwtVUstVz5e7s2W5O22e/b6vfYv75p90v45xUd669eQ
 697u9SbhD5vDLdcan69KLJRimP97+z179ckq/yXZYlddVZtVpJWx7NbLhntL3glK1sVYx8nZ
 Of68deT8ro8t65RYijMSDbWYi4oTAbuoZDFqAwAA
X-CMS-MailID: 20220517091836eucas1p29b087b757e6368110a993b6161f558a4
X-Msg-Generator: CA
X-RootMTR: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_021846_025829_E595C622 
X-CRM114-Status: GOOD (  12.22  )
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

On 17.05.2022 10:10, Christoph Hellwig wrote:
>I'm a little surprised about all this activity.
>
>I though the conclusion at LSF/MM was that for Linux itself there
>is very little benefit in supporting this scheme.  It will massively
>fragment the supported based of devices and applications, while only
>having the benefit of supporting some Samsung legacy devices.

I believed we had agreed that non-power-of-2 zoned devices was something
to explore. Let me summarize the 3 main points we covered at different
times at LSF/MM:

   - This is not for legacy Samsung ZNS devices. At least 4 other
     vendors have reported building non-power-of-2 ZNS devices to meet
     customer demands on removing holes in the address space. It seems
     like there will be more ZNS devices with size=capacity out there
     than with PO2 sizes. Block device and FS support is very desirable
     for these.

   - We also talked about how the capacity not being a PO2 is the one
     introducing the fragmentation, as applications that already worked
     with SMR HDDs will have to change their data placement policy. The
     size is just a construction, but the real work is adopting the
     capacity.

   - Besides the previous poit, the fragmentation will happen from the
     moment we have available devices. This is not a kernel-only issue.
     We have SMR, ZNS, and soon another spec for zone devices. I
     understood that as long as we do not break any existing support, we
     would be able to expend the zoned ecosystem in Linux.

>So my impression was that this work, while technically feasible, is
>rather useless.  So unless I missed something important I have no
>interest in supporting this in NVMe.

Does the above help you reconsidering your interest in supporting this
in NVMe?

