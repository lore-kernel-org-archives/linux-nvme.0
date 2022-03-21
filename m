Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F599C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/XGZRHl7h1kPsQl3N/THXbHPKp+VetuF/lpvFocL3Ao=; b=HEzXKQggKXxnwXN1oXII+aE49O
	NuOQ6wGvK8dxw1w9IUf92OtiQHt67jI/sLDalRpk2THshYpH8Fj1FBJ7Whsh9JwExT8DyUI2e/Qr9
	xL3Emy+lUUa4g8XtPgUwdZmwOUDzfBJHlLdhMDFXO/DXDBXzIybJYRf4pY4HVhTFmAFqeSWhHpk5l
	4YQHzLK3VqRp0jOIAFApNPAG5iVE2LK3qEZYq79ENy4XKuxccD1mgy9cbXVaxQgKLpoIsIVhEMsDg
	iTLB1KrKmcFSp7R5mz3WP7gCnqMDWPBXnCuhSpGcNpPpJFKJSXjvgqZVxdFn4A+602SD2cnrEuxVC
	fIWc4D/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWCOI-006nqg-Rp; Mon, 21 Mar 2022 07:23:47 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWCO8-006nji-9L
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 07:23:39 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220321072328epoutp0378d4b52afbda7a72c24392b8df4191b2~eVHzO43160308303083epoutp035
 for <linux-nvme@lists.infradead.org>; Mon, 21 Mar 2022 07:23:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220321072328epoutp0378d4b52afbda7a72c24392b8df4191b2~eVHzO43160308303083epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647847408;
 bh=/XGZRHl7h1kPsQl3N/THXbHPKp+VetuF/lpvFocL3Ao=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gSma7kbtxXpqoRZzqFqFtEH9KZIMjOFzXC4MfpCZTDKmFb9GHpLH93J4Qa4A9hbIQ
 1eH7x9z1IROkXmnZf6YA817YryQawAFNHK5Z0DBWvnYrWsM9rfmdl5Tg/hlFtGXjPx
 IB5wWGAoUaBhQw4y0jLBAfQtYaDTEOjx4tDocbec=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220321072328epcas5p48fe0b3f570ee5b5ffb9ffe96669da3dc~eVHyw2L6C1086310863epcas5p4M;
 Mon, 21 Mar 2022 07:23:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4KMR141sg5z4x9QN; Mon, 21 Mar
 2022 07:23:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A7.AD.12523.4E728326; Mon, 21 Mar 2022 16:23:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20220321070713epcas5p1826cc38562ac865cc1deff8b2c6fda41~eU5mt68lG0400904009epcas5p1-;
 Mon, 21 Mar 2022 07:07:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220321070713epsmtrp1735ef0e08fb0a5cc56965857c3c9666b~eU5ms4IZG1883718837epsmtrp1R;
 Mon, 21 Mar 2022 07:07:13 +0000 (GMT)
X-AuditID: b6c32a4a-5b7ff700000030eb-fe-623827e4b334
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 3C.22.29871.02428326; Mon, 21 Mar 2022 16:07:12 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220321070710epsmtip27cc547b5b0ccf510e7767bb286ed7a07~eU5kTmEwD0845808458epsmtip2T;
 Mon, 21 Mar 2022 07:07:10 +0000 (GMT)
Date: Mon, 21 Mar 2022 12:32:08 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Pavel
 Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav
 <pankydev8@gmail.com>, Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 10/17] block: wire-up support for plugging
Message-ID: <20220321070208.GA5107@test-zns>
MIME-Version: 1.0
In-Reply-To: <Yi9T9UBIz/Qfciok@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+7tC1iXuwLhWOPEq8tWWKGVtlyQxxLddjfZQpjLlv0hXOCm
 ZdBH+sAHERGCCpGH4AQ6LDAoC4+g8mgYDIcFAwjDx1AGCMNBGbiJVTa2gZi1tCz+9znf3/d3
 fuf8fudwUN4ci89JUelprYpKw1meDEuf4C3h/JtEomjOJiTK+nYR2cUbKFHZaAFE03QRi2ho
 uoEQy7mjDCJv+DZC3HrchxAl1vuA6JkMJKrqbWyiLneARfxcbAOEtTQHIZonbAxiZcTEfAcj
 F+4tAPI74zSbzKl+wCB/+tFAtjbmsci2upNk90QWi7TULjHJJ9fuscjC9kZArrS+Huv1RWqE
 gqaSaa0/rUpSJ6eo5JH4wU/i98dLZSKxUBxGhOL+KkpJR+IHYmKF76WkOW6D+6dTaQaHFEvp
 dHhwVIRWbdDT/gq1Th+J05rkNI1EE6SjlDqDSh6kovXhYpFor9RhTEhVPM+dYGlmXzn6zeIk
 kgUueuYDDw7EJPDPX2pBPvDk8LBuADvX+1HX4hmAIyu97sgqgA32u+hWSmnLEtsV6AHQ3HHO
 vVgAcLjtL+B0MbA34NPpfCQfcDgsTABvlxqcsg+Gw+nppk0/ihUy4Nk7pk2/NxYFi9ZymU4/
 F3sb9p466pS52GtwqGKe4WQPbA80jT5GnOyL7Ya9lgHEuQ/EFjmwouMf4DrdAVj2bMbN3vDR
 QDvbxXy4VHTazTq49uAG6ko+C+B4VgXDFYiGd77f2KyAYimweaSD5dJ3wK9utrj1V2HB+jzi
 0rmw07TFu+BMiY3pYj/4sLzOzSSc/+P6Zut42HUE9nVIisFO40uXM75UzsXhMM+ezTQ6eoFi
 2+G3LzguFMDLXcHVgNkIttEanVJO66SavSr6yP8TT1IrW8Hmaw/4sBM8nLUHWQHCAVYAOSju
 w621hybyuMnUseO0Vh2vNaTROiuQOmZ1HuX7Jqkd30WljxdLwkQSmUwmCQuRiXE/7rD8CsXD
 5JSeTqVpDa3dykM4HvwspGtREEiFZyvIfxWWw79/dqLA6zwtOlnix2+rW1uwnbkMplZjBr8c
 Nx9uCeg2vb+q3Hbuwg9dd8vSo/fVHyQSxg716zuVkOG9xsx5+vm+mcCuXqm5wSorjxsdDxF2
 FI1NeW8Psn+9OrfnQmV4j1WY98gcMpjb3zUv5lcPeQTWjF2VF/QyPfOqKvYXiGrK6zdk5laf
 TFt1dBwvcdmXbfxoNpzX5rX85FjmccHNIeOMdOHSuteJbm7lTs21T9+9j04JfosSZJTLVFWT
 wrj250f4H7xQpQsv+siHg2N3j5xi+3XfunQowRKBXz2dEdrQkOFtjvm70Z45XtM8+PEVxo4z
 hb/iDJ2CEgegWh31H6hDUD52BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvK6CikWSwZsnNhbTDytaNE34y2wx
 Z9U2RovVd/vZLFauPspk8a71HItF5+kLTBbn3x5msph06Bqjxd5b2hbzlz1lt1jSepzN4saE
 p4wWhyY3M1msufmUxeLzmXmsDgIez64+Y/TYOesuu0fzgjssHpfPlnpsWtXJ5rF5Sb3H7psN
 bB7bFr9k9Xi/7yqbR9+WVYwenzfJBXBHcdmkpOZklqUW6dslcGXs2fOQraCfq+L9qyPMDYz3
 2bsYOTkkBEwkJq97CWRzcQgJ7GaU6Hz1hBkiIS7RfO0HVJGwxMp/z8FsIYEnjBLr59SC2CwC
 qhIf73YxdTFycLAJaEpcmFwKEhYRUJK4e3c12ExmgUksEtfP3ADrFRawk+j/1coKUs8roCNx
 oLECYu9BJomrHSfZQGp4BQQlTs58wgJiMwuYSczb/JAZpJ5ZQFpi+T8OkDCngIrEvHNvmUBs
 UQFliQPbjjNNYBSchaR7FpLuWQjdCxiZVzFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525i
 BMejluYOxu2rPugdYmTiYDzEKMHBrCTCu/iDeZIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtd
 J+OFBNITS1KzU1MLUotgskwcnFINTJylLHu8t/8Isv/9/E/oHh8nBZf+j1PmbJZ+t+DBdpb6
 O/XaYnaOcj/W1Hw89lT60233As3PfoIJeW/jPNxMquomnV7c7Db99uLsnsUn9JnvVtp2sYR8
 THt1/u9tddOZwhrXX7xbrfFSnsE3R0RmpmLCkyzTi2++lvfkl97536Xx7OyB5GuXObiUf2bs
 eOxz5rx82r4dz/58VgwRUdTc1/2ZV8drDuurYy4+/Ee2uzu98I+cXFW3I+XlOvPepHPPHM7X
 tzUmNDYxMU2t+lZ068mxo6l3yo7tVrzaKbdw2/t6hvuvQxS2qX67cuO43z4RQ8UNtlqy/vPa
 96S8vrLX2VS8ZL9xqg0ri+ZuXUbnEiWW4oxEQy3mouJEADTvNOY2AwAA
X-CMS-MailID: 20220321070713epcas5p1826cc38562ac865cc1deff8b2c6fda41
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_1325e8_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308152714epcas5p4c5a0d16512fd7054c9a713ee28ede492
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152714epcas5p4c5a0d16512fd7054c9a713ee28ede492@epcas5p4.samsung.com>
 <20220308152105.309618-11-joshi.k@samsung.com>
 <20220310083400.GD26614@lst.de>
 <CA+1E3rJMSc33tkpXUdnftSuxE5yZ8kXpAi+czSNhM74gQgk_Ag@mail.gmail.com>
 <Yi9T9UBIz/Qfciok@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_002336_780307_B7EE238D 
X-CRM114-Status: GOOD (  19.10  )
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

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_1325e8_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Mar 14, 2022 at 10:40:53PM +0800, Ming Lei wrote:
>On Thu, Mar 10, 2022 at 06:10:08PM +0530, Kanchan Joshi wrote:
>> On Thu, Mar 10, 2022 at 2:04 PM Christoph Hellwig <hch@lst.de> wrote:
>> >
>> > On Tue, Mar 08, 2022 at 08:50:58PM +0530, Kanchan Joshi wrote:
>> > > From: Jens Axboe <axboe@kernel.dk>
>> > >
>> > > Add support to use plugging if it is enabled, else use default path.
>> >
>> > The subject and this comment don't really explain what is done, and
>> > also don't mention at all why it is done.
>>
>> Missed out, will fix up. But plugging gave a very good hike to IOPS.
>
>But how does plugging improve IOPS here for passthrough request? Not
>see plug->nr_ios is wired to data.nr_tags in blk_mq_alloc_request(),
>which is called by nvme_submit_user_cmd().

Yes, one tag at a time for each request, but none of the request gets
dispatched and instead added to the plug. And when io_uring ends the
plug, the whole batch gets dispatched via ->queue_rqs (otherwise it used
to be via ->queue_rq, one request at a time).

Only .plug impact looks like this on passthru-randread:

KIOPS(depth_batch)  1_1    8_2    64_16    128_32
Without plug        159    496     784      785
With plug           159    525     991     1044

Hope it does clarify.

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_1325e8_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_1325e8_--

