Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21589C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 11:53:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971E76102A
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 11:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971E76102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lh3J/zl9H+YzMhX8BVBws3rPvXloFn58ejp96CtOWT0=; b=edpD1PB6FKnoS1o4an/bQyQu8
	PuUmoyYOU9m5UCIb69eWzZCYoFC+frAqxOaIFVixKnegs8ijOhmF84i83gqYDq61Q6dJXhI0oDY9W
	xEP0v5uWnD91094bOzR6QunCspA9lZcht0v17VC72Ij8OIUS2IBkOvDwtqmPtdX5Du4hO9yhtM2d6
	XfRhZD/1NFovH288prNXi6qZpFzALof8p27JpIYSegABhjktGR73kbWV45R99k48mYuLIfcpYgv1I
	Th0JnOSIv9ZSPVQD5mS/MZXzLNuAfIGgchHzztCUZjlvHFpvgnxRHe1DyhCDGnfwmA+Akm95xVx09
	0vDRjBz9w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVv7u-006bzz-3g; Mon, 12 Apr 2021 11:53:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVv7o-006byu-Lx
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 11:53:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Content-Type:
 MIME-Version:Message-ID:Subject:CC:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FGDi3a4Op76WiG2S8K9BXB233AGh1TJV5f62zYg3WIs=; b=dJMWXm/JPTZq1jTAgmJwGdWGWD
 RqXxsQXm8TXOYb55QGQ57H0Spn3a6L7o3tzbymg9q/eE1mf010i2NjkkJdV6LNuD/z2w64MXLqCbJ
 ic43H/4cLzVOQyn11A/KwX8wWPACQwQCrvsBA6F9gyrnXJcF7uawr2KnvoNab3t1cSbfuLgQRK1LH
 ylqYFN0MiXniP/K4TuYSLb1lQUS7EZzQi6VYA0p9S/323akUITfHwKB7AWEkiJpAKAB9u+5f9XbSl
 RU17CC5hHUMmnHpzkXYIEcCyIs9AiwkXyMWGEI8yrud/09hSr0f2bpodV70NfPe9G1T4Yw3mvPBlJ
 3wIqjXEA==;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVv7j-006CA2-E1
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 11:53:03 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210412115250euoutp0148d72e4d8a8d222e6dddd5827a964fec~1GiESO4tS0455204552euoutp01Z
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 11:52:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210412115250euoutp0148d72e4d8a8d222e6dddd5827a964fec~1GiESO4tS0455204552euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1618228370;
 bh=FGDi3a4Op76WiG2S8K9BXB233AGh1TJV5f62zYg3WIs=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=i3BYN2E4g/TFmEoKTLGy3UyyvfeUvy/k1pPsBb8dzHK7EzPCFb2PI3lDh8294aTO1
 fQmAJW+0D1yeOa0UxyG8dXvBn2JdnEmal38EtCfTse78aCLgHfLBQ0oX7ZJ9wA+l6H
 dq+xEq6YCcYqhREEUulYUZZN4lBO1T5shZ5ZWYxE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210412115249eucas1p2b4a1ac8fd8a0f86e36cca8e0c8ece1d6~1GiDgZ36x1245712457eucas1p2l;
 Mon, 12 Apr 2021 11:52:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.73.09439.19434706; Mon, 12
 Apr 2021 12:52:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210412115249eucas1p22423a69545fc83ecaea46ffa1e1c8386~1GiC8Ky490722007220eucas1p29;
 Mon, 12 Apr 2021 11:52:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210412115248eusmtrp27691be911986b23798e76354c9b5ee8a~1GiC7b-sO2016620166eusmtrp2C;
 Mon, 12 Apr 2021 11:52:48 +0000 (GMT)
X-AuditID: cbfec7f5-c1bff700000024df-c9-607434918055
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.8D.08696.09434706; Mon, 12
 Apr 2021 12:52:48 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210412115248eusmtip2812bf0ccee86cc279be698f76f15260a~1GiCvvRGg2217122171eusmtip2e;
 Mon, 12 Apr 2021 11:52:48 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 12 Apr 2021 12:52:48 +0100
Date: Mon, 12 Apr 2021 13:52:46 +0200
From: Javier Gonz??lez <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 13/13] nvme: introduce generic per-namespace chardev
Message-ID: <20210412115246.ocqdoejpfiswajqu@mpHalley.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210412074455.GA3653@lst.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c45bsfV5DjL3rQypjO6LVOh04UsNZ2goDDogqVTT1rpis3r
 IjS7kBqmFqyOlZmmNq3IWm2ZYhOzcqHZTaMLpUWs5jSLStTyeOjy3+99n/fhex74SFxS5ORB
 7lCnMxq1KlUqEBE37v7sWloamB7vt7/fk75Y347RXfY2jC6zPEN0Rc17IT1aMI2+/MlBrBMo
 zOwroaLr9VVC0WgoECiuVecqmvryBNFOW0RrkpjUHZmMZtnaeFHK+MdG4R6ra/b3l1aUhwpd
 CpEzCVQg6J86hIVIREqoOgTNNVeEnCChviIwdG/khREEXd/sTn8clU01GC/UIigunxD8vaoy
 DBH8YETQ3tCOcxaCkkFNWdUUCyg/+MyyGMczKCm8tz1EnAHnDN2tYwJOcKMUYM+rQhyLqWC4
 YDlO8OwK908NTDFOrYKCofzJTOQke0LtBMmhM7UYDjr2cgiUN9Tqo/jQ++DSXetUTaBeklB8
 bAzjhVDo6THhPLuBreO6kOc58MtcgfGGAwisDU9wfjiKYKysDvEvrIZiaypvWA/Pbz8g+LUL
 9Npd+ZQuUHZDj/NrMRw5LOGvfcGUb0QlyJv9rxf7Xy/2X69zCDegWUyGNi2Z0QaomSy5VpWm
 zVAnyxN3pzWiyf/SOdHxzYTqbMNyC8JIZEFA4tIZ4oQcbbxEnKTK0TGa3XGajFRGa0GeJCGd
 Jb5lbIiTUMmqdGYXw+xhNH9UjHT2yMP85Yaz+3eWP3bPTJ7XWbfdS2eWtcvCB47nHJGFLOzb
 Ryv9RSKbKMjTMfjDNwj8Bm7FxBgeKSubc92/62pfRyr7xlvemnvl04tjT0R7fWYTjfeyTMNs
 eHi280cP/6MhLaGGbkd/c8Cbueq4HtGGmfElXx742HWR8ndbm4wRqs60qJ06FDZ/TnXwiqCR
 0RY01Nt6R6fvd094vOombOo9HVsU1kDRKStppX52gE9SUsRDaun0yvrB/MjzKW2B+pGScL9t
 peUfhB/Ip9ctocos90NUepgXpmPzb28OabVlLrj2vMDcj34g/5Nkm2moKFd22GeJ9cmZaLOl
 Y9qhyBdKKaFNUS1fhGu0qt9H6a7engMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7oTTEoSDCb2W1qsXH2UyeL828NM
 FpMOXWO0mL/sKbvFr05ui3Wv37M4sHnsnHWX3eP8vY0sHptWdbJ5bF5S77H7ZgNbAGuUnk1R
 fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbfF5vYC84I
 Vny/c4axgbGLr4uRk0NCwERi4e5lTF2MXBxCAksZJZbfOcsGkZCR+HTlIzuELSzx51oXG0TR
 R0aJGTN/sEI4WxklJq07wwhSxSKgKrFs0mJmEJtNwEDizaxZTCC2iICSxNNXZxlBGphBGtof
 rQJbISzgIfG2YTFYM6+Ak8TSQ5NZIKb+Y5I4tLqZBSIhKHFy5hMwm1nAQmLm/PNADRxAtrTE
 8n8cICangLZEy/tqEFNCQFli+XRfiKNrJV7d3804gVF4FpI5s5DMmYUwZwEj8ypGkdTS4tz0
 3GIjveLE3OLSvHS95PzcTYzAONt27OeWHYwrX33UO8TIxMF4iFGCg1lJhDepsjhBiDclsbIq
 tSg/vqg0J7X4EKMpMCQmMkuJJucDIz2vJN7QzMDU0MTM0sDU0sxYSZzX5MiaeCGB9MSS1OzU
 1ILUIpg+Jg5OqQamDRuVLBwV7q3m3/BUvGnjfG4TL4tHRwpiwmUvHSrsnv1HNWnR3Ic3nu2+
 IFmRwMZdzlX4btLHN4f2BT3tTdhVen5p5M/Ya+Ht8d6sPJxFqTNFBB+YVi9LufZAKkh5Xfer
 hOkN13f+P21Wqs+S/LF8ydLKW2GSKr+3sIW/fvqgpuDETtVCuV8Tnk6UFH4revFea9r5Jc5V
 E06fCuhTubO+6Y/Rvs3O+SaZt+8sOe3sNTssqqTloXakfNTU3CVvLylEOS79tSxXs+Gts8wH
 /Y5tYau2iMzJYWbde/14vfDdUp52Ga6zjL8Wvl8zdUl4t3nyw7LFj1/O7NitoLxLZJ1dn+bh
 Lf1cHMeELu22nWoYpMRSnJFoqMVcVJwIALNVybY8AwAA
X-CMS-MailID: 20210412115249eucas1p22423a69545fc83ecaea46ffa1e1c8386
X-Msg-Generator: CA
X-RootMTR: 20210412074505eucas1p25b22f056d13499848000c89579304556
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210412074505eucas1p25b22f056d13499848000c89579304556
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-14-hch@lst.de> <20210409072901.GA2085@localhost>
 <20210409075415.GA6991@lst.de> <20210409080214.GB2085@localhost>
 <20210409095205.GA15931@lst.de> <20210409112401.GF2085@localhost>
 <CGME20210412074505eucas1p25b22f056d13499848000c89579304556@eucas1p2.samsung.com>
 <20210412074455.GA3653@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_045300_001412_2FE143AA 
X-CRM114-Status: GOOD (  16.77  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12.04.2021 09:44, Christoph Hellwig wrote:
>On Fri, Apr 09, 2021 at 08:24:01PM +0900, Minwoo Im wrote:
>> I think if we don't have a route to the live controller from the
>> multipath node /dev/ng0n1, how does application figure out controller
>> node to request admin commands like Identify Namespace before their
>> own I/O ?
>>
>> We have sysfs, but it does not provide every information about the
>> namespace.  Or is there any charming way to find out the live
>> controller from a head node through sysfs or something that I missed
>> here ? :)
>
>The devie links points to the subsystem, which then points to the
>controllers:
>
>root@testvm:/sys/class/nvme-generic/ng0n1# ls -l device/
>total 0
>-r--r--r-- 1 root root 4096 Apr 12 07:43 firmware_rev
>-rw-r--r-- 1 root root 4096 Apr 12 07:44 iopolicy
>-r--r--r-- 1 root root 4096 Apr 12 07:43 model
>drwxr-xr-x 3 root root    0 Apr 12 07:43 ng0n1
>drwxr-xr-x 3 root root    0 Apr 12 07:43 ng0n2
>lrwxrwxrwx 1 root root    0 Apr 12 07:44 nvme0 -> ../../nvme-fabrics/ctl/nvme0
>drwxr-xr-x 9 root root    0 Apr 12 07:43 nvme0n1
>drwxr-xr-x 9 root root    0 Apr 12 07:43 nvme0n2
>lrwxrwxrwx 1 root root    0 Apr 12 07:44 nvme1 -> ../../nvme-fabrics/ctl/nvme1
>drwxr-xr-x 2 root root    0 Apr 12 07:44 power
>-r--r--r-- 1 root root 4096 Apr 12 07:43 serial
>-r--r--r-- 1 root root 4096 Apr 12 07:44 subsysnqn
>lrwxrwxrwx 1 root root    0 Apr 12 07:43 subsystem -> ../../../../class/nvme-subsystem
>-rw-r--r-- 1 root root 4096 Apr 12 07:43 uevent
>

It seems like a limitation that we have to transverse sysfs to make an
in-application enumeration to submit namespace-specific admin commands.

Ideally, applications that are already using IOCTLs should be able to
directly work with the char device. If this is not the case, I am afraid
that the applicability will be limited.

I understand that identifying the live controller in multipath is
something that we need to improve. The question is that if this is a
reasonable thing for you. If there is no fundamental limitation here, I
think we can work the details of enabling namespace admin commands
through and merge the same support for the block device and the char
device.

What do you think?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
