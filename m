Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B47C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 09:54:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47686615E2
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 09:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 47686615E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AI7YV5Cvn5mzOQlVqHrRnq8d5E8gl5B6GqhY07GqASI=; b=rq3B7Q7pXErWfxaQWe+WG1+F85
	1qb9j5+w/WfUpXOXlhhkA+94pPpo8ziTJkTYvSjm+/rPAV1fvJcx8Ao/29rwzCSJ9jCELk2ZvlXsz
	dLceSXBOINs+pZ5IlXVJTcMULAnPscIOmU6EO+5r3A3ntSHHeJgAE0QC3E2xeRUUsu7YJpXquHuhd
	bLj4KakSsj1VpOYWaS7c4uHsq3B9H+iUTamufewMtKNQWLqQnQiFAQgvVNhYvgMG+Z9qrw8aHSkwC
	hrSYmdWV2MxMUcUqZkt/+aXzxufKqoKgT6VUT/XE5U2mH3YRpTRyRouBOn8gzg+6svNNj5d6RV1Zb
	mHrfVLSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVslT-00Deck-6b; Thu, 30 Sep 2021 09:54:07 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVskh-00DeFy-PV
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 09:53:22 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20210930095315euoutp02d7e49aa6752f576783f1a95f3276e242~pkNed75q30046900469euoutp029
 for <linux-nvme@lists.infradead.org>; Thu, 30 Sep 2021 09:53:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20210930095315euoutp02d7e49aa6752f576783f1a95f3276e242~pkNed75q30046900469euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1632995595;
 bh=dXfx/WMyrIWN+HAvhSUPKljKtdHmk58fulLYoRVhSCA=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=e1Qmnd67Lr4Y4gmee2mrgSfbzgUhUzAYi8CkLB1cb00buI1uZ2xMqCYYKzvkKzWaK
 aePCGZPFBK8o8E2NBzwWysumTNmaNQ1kJT1yD4nT0F/P2MBDVTQn6xYqXolTOgz3WK
 njiGwRQLShsJD8liY1PAmlXQxqBYZw2xgyEkGjjE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210930095315eucas1p242b75713efbe09654512e314cb32f1e2~pkNeMkA8A1821518215eucas1p2E;
 Thu, 30 Sep 2021 09:53:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 5B.EC.42068.B0985516; Thu, 30
 Sep 2021 10:53:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210930095314eucas1p10f56a3c7bc3cc167d93b3bd472c6852a~pkNdq_OAy1563315633eucas1p1X;
 Thu, 30 Sep 2021 09:53:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210930095314eusmtrp2613aace3fff86eb43febc14d1c8711da~pkNdp4irE0109501095eusmtrp2p;
 Thu, 30 Sep 2021 09:53:14 +0000 (GMT)
X-AuditID: cbfec7f4-c89ff7000002a454-73-6155890b83b1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.9B.20981.A0985516; Thu, 30
 Sep 2021 10:53:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210930095314eusmtip1eb040877616c6f8f18287fae83016cfe~pkNdeTsf-2640426404eusmtip1J;
 Thu, 30 Sep 2021 09:53:14 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC02.scsc.local
 (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 30 Sep 2021 10:53:13 +0100
Date: Thu, 30 Sep 2021 11:53:12 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>, "bvanassche@acm.org"
 <bvanassche@acm.org>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "roland@purestorage.com"
 <roland@purestorage.com>, "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 Adam Manzanares <a.manzanares@samsung.com>, SelvaKumar S
 <selvakuma.s1@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>, "Kanchan
 Joshi" <joshi.k@samsung.com>, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20210930095312.jeipuaxzyyhd5e6e@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c1b0f954-0728-e6ab-73ab-7b466a7d2eb7@nvidia.com>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjde2+5vVTKLpXZN+LYVseyOAfqyPKyGXEfcZeI23SabN0yVuSm
 MsvH+iGicXSAswVaZyVDqkZkSoUqYvloG2w3MSvZAAdokRWpIOAI1arYJTIqjvbq5r9zznNO
 nuckD4kL9hKLyexcJSPPlchEBI/T5pr54/UF2i2SFY7jccg8vJ9AP96dwZFxyMdBdy6MRSCH
 /3AEGrM8wtD5WgOG6s2/YuhhmRdDho4BgBye19CxugkuKr9qI5DT58CRqXMOQwc0bgxdMgYJ
 dNHr5iBzEKH6mxia+vnLtc/Rl6+spw+U+Ln05R4VbWnQEnTziSL64KAJ0O1/qgn60HSAoK92
 WzFaV+In6HsTHg7dNqrj0nec7nlv1276viWe3vdLOfYxJeatzmJk2TsYedKar3jbWl3OiPx/
 eDsnK6YINWghy0AkCalkaBnz4WWARwqoUwCab13AWBIAUGN1RbDkPoD9pdeJJ5Hzdh0ewgLK
 BODha/H/mRp79ARLWgEc8VXPu0iSQyXAYl1UKEBQqbC/zhMOx1KJ0O0Z5Ib8ONUUCS21TeEN
 C6k0aGvaj4WyfGo1tHelh2Q+FQN/qx7nhDBOvQW1d4sjQhacioOmuXCdSGoNdDYPhWVILYWm
 qg3syXvg7y2ecDFIHeXBYY2Hww7eh0fagxiLF8KpzhYui5fAR/ZjjwMlAHafvoKzpALAoOEU
 YDe8DfXdMjbwDrRWjuKsHA0Hb8ewZ0ZDQ1vVY5kPNd8LWPcr0FbcCn4AS41PFTM+Vcz4f7Ea
 gDcAIaNS5EgZxapcpiBRIclRqHKliVvzcixg/lO75joDNmCaupfYATASdABI4qJY/gPhJxIB
 P0tSuIuR52XIVTJG0QHiSI5IyM9sOZ0hoKQSJbOdYfIZ+ZMpRkYuVmPVltTbn93ocy7ftFyZ
 VhjwoHdrHu5t1g8kyL3lMuwLoXDVqCvpTKo/s3K4RjdjbEwv7ak913dycqgdP2e3wudNM9KR
 zqzZa3vyQY6qdPyGdol3QjuR8upG8YdvBn/627e1oEH5edQ3ydJAyspNjUeTvhuaFvQd3+5f
 +8Eu66KXzOsq+9cpDC/ogC3rbCPmtd+MzetNcWRO+3e/8bJwB/h0xYP0OniCyfi2eCzZLD47
 vq+nUCM1iHe6lAl5Fw/pmy+VWjdsNtQXqYvU721ZZrxe0d2bPbBo8zODvQ3utIS/XjxzUBRz
 sv1WfupkdEm8umrkI//XUbPCjQXPxvjFfQv0I7MijmKbZOUyXK6Q/AvpltwAGAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsVy+t/xu7pcnaGJBkt3GVisvtvPZjHtw09m
 i1m3X7NYvD/4mNVi77vZrBaPN/1nstizaBKTxcrVR5ks/nbdY7KYdOgao8XeW9oW85c9Zbfo
 vr6DzWLf673MFsuP/2OymNhxlcni3Kw/bBaH711lsVj9x8Ji5TMmi1f74xxEPS5f8faY2PyO
 3ePy2VKPTas62Tw2L6n3mHxjOaPH7psNbB4zPn1h87h+ZjuTR2/zOzaPj09vsXhse9jL7vF+
 31Wg2tPVHp83yXm0H+hmChCI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
 t7NJSc3JLEst0rdL0MvYemwfa8EvrooXPa/YGhi3cHQxcnJICJhI7NnZywxiCwksZZT4/dYe
 Ii4j8enKR3YIW1jiz7Uuti5GLqCaj4wSq27dYYZwtjJKdG+ZwtLFyMHBIqAq0dTLA9LAJmAv
 cWnZLbChIgJ6Eldv3WAHqWcW2MApsWnRBjaQhLCAp8SODf1MIL28AjYSO0/7QMz8zSSx+tt9
 sGZeAUGJkzOfsIDYzAIWEjPnn2cEqWcWkJZY/g/sAU4BO4l9m2+zgoQlBJQllk/3hbi5VuLz
 32eMExiFZyEZNAvJoFkIgxYwMq9iFEktLc5Nzy020itOzC0uzUvXS87P3cQITCzbjv3csoNx
 5auPeocYmTgYDzFKcDArifD+EA9OFOJNSaysSi3Kjy8qzUktPsRoCgyIicxSosn5wNSWVxJv
 aGZgamhiZmlgamlmrCTOa3JkTbyQQHpiSWp2ampBahFMHxMHp1QDk0zi7xmLNk5zy1/9ae0O
 00i33yzHmpesEmnaGrYvcq3aW4E332dm7jfef//ew9ffphrq+M1W25A/a4POvyVmL8WnXgqr
 lli9ofro/Ul26x26pnS9Cik7kGozK6bz890nllnTLktPDdqbYjnXJnRH/K6pTJdUPs37lRZr
 r+pumJqQHdAxL33CqzM9UreblCSWmqT1nLthtL1a8L6T+Gwmu9KQ+feVYnfd2Rk+JXHBzMSk
 BbNT//76vj3Or/X5h3UrNU/HmbRduHrt2y31e+qvJ/b/CBf24p5gKxg8+W7+m4XshoKbxI1F
 YkM0vqS21Lf+CuwOf3D81Lap8gx30xY777cMPn15ms30JE9jB6nT658psRRnJBpqMRcVJwIA
 sh+3PrUDAAA=
X-CMS-MailID: 20210930095314eucas1p10f56a3c7bc3cc167d93b3bd472c6852a
X-Msg-Generator: CA
X-RootMTR: 20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
 <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c1b0f954-0728-e6ab-73ab-7b466a7d2eb7@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_025320_150229_5FD84BAC 
X-CRM114-Status: GOOD (  14.17  )
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

On 30.09.2021 09:43, Chaitanya Kulkarni wrote:
>Javier,
>
>>
>> Hi all,
>>
>> Since we are not going to be able to talk about this at LSF/MM, a few of
>> us thought about holding a dedicated virtual discussion about Copy
>> Offload. I believe we can use Chaitanya's thread as a start. Given the
>> current state of the current patches, I would propose that we focus on
>> the next step to get the minimal patchset that can go upstream so that
>> we can build from there.
>>
>
>I agree with having a call as it has been two years I'm trying to have
>this discussion.
>
>Before we setup a call, please summarize following here :-
>
>1. Exactly what work has been done so far.
>2. What kind of feedback you got.
>3. What are the exact blockers/objections.
>4. Potential ways of moving forward.
>
>Although this all information is present in the mailing archives it is
>scattered all over the places, looking at the long CC list above we need
>to get the everyone on the same page in order to have a productive call.
>
>Once we have above discussion we can setup a precise agenda and assign
>slots.

Sounds reasonable. Let me collect all this information and post it here.
I will maintain a list of people that has showed interest on joining.
For now:

   - Martin
   - Johannes
   - Fred
   - Chaitanya
   - Adam
   - Kanchan
   - Selva
   - Nitesh
   - Javier

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
