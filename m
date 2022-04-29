Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844E6C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Apr 2022 05:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8LGWndXkCd882PYNwZdU+9/YnWrK1gI5az0AxzOHa4=; b=fjmLaHmlBs1CjgFJFZCISAcmZO
	7Ox6N25lQEbm5o/S7BZR02xwjzNPSMU1OIhxIrRnnZlX9XD/rwWPN/evSTYKjatq01j3/74lnhGsa
	3rs8rWqOshqakB0DdNI4mo4dCaWdWtersI8j1iyc2ndk3SjdIn5xE6fnEbyknpbeboXRzYbYx+S2U
	gSjGU0Z0o8VWN9MsRmnlJRS+MSWVq80iCq8eU20rM6ubL2eCGUXzwRFqoXTjJPscMCBiIuMYs1MWR
	mnDj65JHsbR3iwBHYjCyed6CE+QZopqjL5sUeykCpKChUYjV7ualUehxSAE3PEVz2ePxGWvxVkwoY
	9yn7sDYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkg7t-00Dk7K-Kj; Sat, 30 Apr 2022 05:58:41 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkg7p-00Dk6l-N9
 for linux-nvme@lists.infradead.org; Sat, 30 Apr 2022 05:58:40 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20220430055832epoutp01c80b1c39b02f7423afbff081a4c208da~qlxDlyq1i0586005860epoutp01S
 for <linux-nvme@lists.infradead.org>; Sat, 30 Apr 2022 05:58:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20220430055832epoutp01c80b1c39b02f7423afbff081a4c208da~qlxDlyq1i0586005860epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651298312;
 bh=P8LGWndXkCd882PYNwZdU+9/YnWrK1gI5az0AxzOHa4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oZ9fsHht9G2cO8x6whEBH4F0u2RailfXoymVRMLQkLieFVjKFl5I7lwC5w4n70bgc
 XfFx/xwWh3b95S1sQK5G53yet6Qc6B2pIll1Cl22AqxuOQKfVFzizv+MkTwxOLv0SA
 sSLftRBaRUz3zsE/gWLHIu04A1n3fifFLhi+asSE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220430055831epcas5p2d11e93a5e42d9e70dca78e08b109693a~qlxC2VEXm0690106901epcas5p2H;
 Sat, 30 Apr 2022 05:58:31 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4KqzDd2J1nz4x9Pv; Sat, 30 Apr
 2022 05:58:25 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D1.36.10063.100DC626; Sat, 30 Apr 2022 14:58:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220429132157epcas5p23832f3eb51db75fb762ea478b223299c~qYK72Urya1406114061epcas5p2q;
 Fri, 29 Apr 2022 13:21:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220429132157epsmtrp2f5fb12f880426a5adc695c4a4586a270~qYK71l6XO0749307493epsmtrp2l;
 Fri, 29 Apr 2022 13:21:57 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-0f-626cd001fcdd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 86.26.08924.576EB626; Fri, 29 Apr 2022 22:21:57 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220429132156epsmtip1c6e1649ccd3237c3393a13e70a7eaadf~qYK6OTugO0251702517epsmtip1T;
 Fri, 29 Apr 2022 13:21:56 +0000 (GMT)
Date: Fri, 29 Apr 2022 18:46:47 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, Pavel Begunkov
 <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Pankaj Raghav <pankydev8@gmail.com>, Javier
 =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>, Anuj Gupta
 <anuj20.g@samsung.com>
Subject: Re: [RFC 5/5] nvme: wire-up support for async-passthru on char-device.
Message-ID: <20220429131647.GA10057@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220425173803.GA2454@test-zns>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTZxzHfe7a68HsclYIz7rMwRFD6FZotYWDgBJFPTczMSxZIEvgKBdg
 LW3ptehY4hikC21kgxmidio0YpkVkPCq1DJShgwIiHNkvsFkA5lOkEF0UeaytgeL/32e7+/7
 e3necFTSj0nxIr2ZNekZHYmFCroHYmPlYEKXp/h1eSNVUfMSpU67uwF1ceprjLpwcRChFq3j
 Aso2OoFQ1xcGEKreNSeibtXMAcp3vBKhmm/PCdJeo684pkR0ZcM9AX1zzEK3u20Y3dH4Oe25
 XY7RT/omMfqrTjegV9q3ZIRka1MKWSafNUWyeo0hv0hfkEq+n5mzO0edoFDKlUlUIhmpZ4rZ
 VDL9QIZ8b5HOPywZWcroLH4pg+E4Mn5HislgMbORhQbOnEqyxnydUWWM45hizqIviNOz5mSl
 QrFN7Tfmagvd7hHUuAKPPG5eFZYDp8QOQnBIqOCfZ7qAHYTiEsID4OCtJRAISIhlAH97sI8P
 rABYO+kD6xnD1i6ED/QC2O56KuIXDwCsH5oNugTEVtjkcvhdOI4RsXDiuCUghxEknHs0FmyH
 Es8Q2PXEiwQCm4lD0P7iAgj4xYQctnqwgCwmNsHhU7OCAIf4ZfvIiaA9nIiG/d1DwSEgcRWH
 i813UX66dNjy/K813gwfDXWKeJbClUUvxrMGWntuigK9IGGGjQ0xvLwT3rj6MlgfJQphX2/1
 Wpm3YN1I65r+OqxenUV4XQwvn13nKDj9zZyQ5wg4c7JxjWk42lSzdrx1AjhzulZUA952vLI3
 xyv9eE6GtqUKocM/Hkq8CZv+xXmMhZd64xuA0A3eYI1ccQHLqY1KPXv4//vWGIrbQfApy/Zf
 BlP3l+J8AMGBD0AcJcPEX7bp8iTifObTMtZkyDFZdCznA2r/VdWi0nCNwf8X9OYcpSpJoUpI
 SFAlbU9QkhHi0YI2RkIUMGZWy7JG1rSeh+Ah0nKEybl35JcPbWFJunc3rPQ/Gx67FPPYJ/0D
 23iuqkM04jn1T9q5o5hr+Xl56KLEmxypVmXNf/CJrMQoX27DhRsUit8H5NnyqJ8enmmk45ey
 EresUoeiq+vQPTsSNTKZvbT0KWZNqx2yzLBlZd95SoTOvM+wA3enFnKzXWevOQejJ1zXShbu
 bD0Zu0uVfDhrcr85/du0o+PbuWmPPpcoMn9clVRq02p3ZfzYr2j9e19ZRd/B+coqb+b3o9o8
 q02VvTs8pqV+flp5LGKb+uB4aO2LO97RY1E/vLdn5/lNP3/kvN/Tgj/0ntdk+vDpnht5q1cM
 e11VUtU7ndnhbV90XO9ypohIAVfIKGWoiWP+A8bso6RTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTrf0WXaSwdk5xhZNE/4yW8xZtY3R
 YvXdfjaLlauPMlm8az3HYtF5+gKTxfm3h5ks5i97ym5xY8JTRotDk5uZLNbcfMriwO2xc9Zd
 do/mBXdYPC6fLfXYtKqTzWPzknqP3Tcb2Dze77vK5tG3ZRWjx+dNcgGcUVw2Kak5mWWpRfp2
 CVwZy26dZixYKlYx+/FzlgbGt/xdjJwcEgImEidbtzJ1MXJxCAnsYJS4vXYrM0RCXKL52g92
 CFtYYuW/5+wQRU8YJe7P3cYCkmARUJVYvmwWUDcHB5uApsSFyaUgYREBJYmnr84ygtQzC/xi
 kth4+AwbSEJYIFCi69dKRpB6XgFdiXW72SBmzmSR6Lz7C2wZr4CgxMmZT8DmMwuYSczb/JAZ
 pJ5ZQFpi+T8OkDAnUGvXqelMILaogLLEgW3HmSYwCs5C0j0LSfcshO4FjMyrGCVTC4pz03OL
 DQuM8lLL9YoTc4tL89L1kvNzNzGC40lLawfjnlUf9A4xMnEwHmKU4GBWEuH9sjsjSYg3JbGy
 KrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYm5qnK0xnPKJjWO534
 FtBgWnab6+fZg/FPRQWO8y7sFmHJMWQJ+h5blzc/VytMt2vup8xDzJ47jdPOyc2Y5zk3PLff
 0vk0g3f6UeOMJo6JLH+/Z9RMXrfngelXab9Jx9b8+uva737zt/T7SEu1gx3zzi0M2FA9K2P3
 vxfb7m74sZFNp1X4U0JGjV3C/xmGeRZXn5o9PONV9zeq8Jrf42UygjrKLLYnGeo/CYlLsc4x
 f+Jh8SvyxbXPJ5/esfJtyz5gcedxd+DxvHs/PFRTi+NnFUkZZr15wz/rxcNXZlmzrjWYPrY2
 7q+6bV8yJYbp57uXl2yDN0sc3PpNrMvc0+JgZxHvjrnCudJOn442+k9VYinOSDTUYi4qTgQA
 Hr5qNhYDAAA=
X-CMS-MailID: 20220429132157epcas5p23832f3eb51db75fb762ea478b223299c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----0ZLlJYeDNsXsa2iHVDx88FJSiXNelWJlSsIznY99o6DAaXg4=_25518_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220401110838epcas5p2c1a2e776923dfe5bf65a3e7946820150
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110838epcas5p2c1a2e776923dfe5bf65a3e7946820150@epcas5p2.samsung.com>
 <20220401110310.611869-6-joshi.k@samsung.com> <20220404072016.GD444@lst.de>
 <CA+1E3rJ+iWAhUVzVrRDiFTUmp5sNF7wqw_7oVqru2qLCTBQrqQ@mail.gmail.com>
 <20220405060224.GE23698@lst.de>
 <CA+1E3rJXrUnmc08Zy3yO=0mGJv1q0CaJez4eUDnTpaJcSh_1FQ@mail.gmail.com>
 <CA+1E3rK3EzyNVwPEuR3tJfRGvScwwrDhxAc9zs=a5XMc9trpmg@mail.gmail.com>
 <20220423175309.GC29219@lst.de> <20220425173803.GA2454@test-zns>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220429_225839_135286_8ED59694 
X-CRM114-Status: GOOD (  23.72  )
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

------0ZLlJYeDNsXsa2iHVDx88FJSiXNelWJlSsIznY99o6DAaXg4=_25518_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Apr 25, 2022 at 11:08:03PM +0530, Kanchan Joshi wrote:
>On Sat, Apr 23, 2022 at 07:53:09PM +0200, Christoph Hellwig wrote:
>>On Wed, Apr 06, 2022 at 10:50:14AM +0530, Kanchan Joshi wrote:
>>>> In that case we will base the newer version on its top.
>>>But if it saves some cycles for you, and also the travel from nvme to
>>>linux-block tree - I can carry that refactoring as a prep patch in
>>>this series. Your call.
>>
>>FYI, this is what I have so far:
>>
>>http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-passthrough-refactor
>>
>>the idea would be to use these lower level helpers for uring, and
>>not really share the higher level function at all.  This does create
>>a little extra code, but I think it'll be more modular and better
>>maintainable.  Feel free to pull this in if it helps you, otherwise
>>I'll try to find some time to do more than just light testing and
>>will post it.
>
>Thanks for sharing.
>So I had picked your previous version, and this one streamlines meta
>handling further. But the problem is bip gets freed before we reach to
>this point -
>
>+static int nvme_free_user_metadata(struct bio *bio, void __user *ubuf, int ret)
>+{
>+       struct bio_integrity_payload *bip = bio_integrity(bio);
>+       void *buf = bvec_virt(bip->bip_vec);
>+
>+       if (!ret && bio_op(bio) == REQ_OP_DRV_IN &&
>+           copy_to_user(ubuf, buf, bip->bip_vec->bv_len))
>
>Without bip, we cannot kill current meta/meta_len fields.

And by this I mean we cannot keep io_uring_cmd this way -

+struct io_uring_cmd {
+       struct file     *file;
+       void            *cmd;
+       /* for irq-completion - if driver requires doing stuff in task-context*/
+       void (*driver_cb)(struct io_uring_cmd *cmd);
+       u32             flags;
+       u32             cmd_op;
+
+       void            *private;
+
+       /*
+        * Out of band data can be used for data that is not the main data.
+        * E.g. block device PI/metadata or additional information.
+        */
+       void __user     *oob_user;
+};

Rather we need to backtrack to pdu[28], since nvme would need all that
space.

+struct io_uring_cmd {
+       struct file     *file;
+       void            *cmd;
+       /* for irq-completion - if driver requires doing stuff in task-context*/
+       void (*driver_cb)(struct io_uring_cmd *cmd);
+       u32             flags;
+       u32             cmd_op;
+       u32             unused;
+       u8              pdu[28]; /* available inline for free use */
+};

+struct nvme_uring_cmd_pdu {
+       union {
+               struct bio *bio;
+               struct request *req;
+       };
+       void *meta; /* kernel-resident buffer */
+       void __user *meta_buffer;
+       u32 meta_len;
+} __packed;


------0ZLlJYeDNsXsa2iHVDx88FJSiXNelWJlSsIznY99o6DAaXg4=_25518_
Content-Type: text/plain; charset="utf-8"


------0ZLlJYeDNsXsa2iHVDx88FJSiXNelWJlSsIznY99o6DAaXg4=_25518_--

