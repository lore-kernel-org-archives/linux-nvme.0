Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92587C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 08:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9eo0FIiSOetMqwE+9U2Ie9WW1i1bTo1eRTvTmsbECTY=; b=0Vq2DdhU0Zf+Bs08sLPEkTHYw8
	ToRVvRzNHI5t3kPzPAOimz08oYyrbcRaBcR901tvT9ks4GZcX75yg7hSZNWM1ecJrcd8dOHL1fhbe
	CWrL+07ri4OlEGA8QdgjQyUjeDoaSvaIxVdbPpnoYz6IJ+Y7D5gNQ9hwfgY9W/RJUTN4GT0ruCn/m
	/T461a4j9Wkt0sM8chP7ZkwpkQGKQeUCeqTnZDRwng0RiS2Ii6tuf5c03PvrQVwyS81ygNRQ1DgQH
	XHRrZQAstWwvWqWSisGWJLYP2RMsOVui3ZTLz2AdadHCHYAD4ze8a1oK+97+VUqlqq3q6/CdoEDbG
	IrODuoMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phRSe-00HABW-0b;
	Wed, 29 Mar 2023 08:47:16 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phRSY-00HA94-0n
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 08:47:15 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230329084702epoutp02f74ef86abed4f4e05f6601e258802c60~Q14PQIl8-2638326383epoutp02v
	for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 08:47:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230329084702epoutp02f74ef86abed4f4e05f6601e258802c60~Q14PQIl8-2638326383epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680079622;
	bh=9eo0FIiSOetMqwE+9U2Ie9WW1i1bTo1eRTvTmsbECTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JUn0vJgg1NnZJbIqC8Tw41t+c1Gu80dx3ny/JAZQpN6ca961H1EODhSbAZGdGKGet
	 B4TV9EeL2y9DuoxtBjzjdeEkKmSoYdV1SPnvHlsrubtNNjoJYP9oqLgqq+dBQ1VLbf
	 w8WN0YNORoBRHEPZCY+5PvM3pSMtTc87PdqNVHhg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230329084701epcas5p474b0aacf4f28606d1d70f5ae48dd8fa7~Q14O2Rm4_2290122901epcas5p44;
	Wed, 29 Mar 2023 08:47:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4PmgCS3b5Nz4x9Q2; Wed, 29 Mar
	2023 08:47:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.50.55678.40BF3246; Wed, 29 Mar 2023 17:47:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230329084659epcas5p3bfde5f30962dd3f30f4e401967c0cd76~Q14NA-W431743817438epcas5p33;
	Wed, 29 Mar 2023 08:46:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230329084659epsmtrp2bffb7b40d540a4d51a862b3de0f12a3c~Q14NAVkbB1583215832epsmtrp2j;
	Wed, 29 Mar 2023 08:46:59 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-b7-6423fb04c4a3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	CC.BC.31821.30BF3246; Wed, 29 Mar 2023 17:46:59 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230329084658epsmtip2b470edcbb08adcfa49d1c260c51b11e8~Q14L3FdDS1143311433epsmtip2g;
	Wed, 29 Mar 2023 08:46:58 +0000 (GMT)
Date: Wed, 29 Mar 2023 14:16:18 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <20230329084618.GB2800@green5>
MIME-Version: 1.0
In-Reply-To: <ZCL/RTHoflUVCMyw@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmhi7Lb+UUgyePpC1W3+1ns1i5+iiT
	xfm3h5ksJh26xmhx5upCFou9t7Qt5i97yu7A7rFz1l12j8tnSz02repk89i8pN5j980GNo9z
	Fys8Pm+SC2CPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQ
	dcvMATpGSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJl
	aGBgZApUmJCd8XzFb6aCS9IV91d+Ymxg7BDrYuTkkBAwkdi0bB1TFyMXh5DAbkaJCXv72SGc
	T4wSjz+8ZQWpEhL4zCgx8UsxTMfOzq+sEEW7GCW+72iEcp4wSrQ+nsgCUsUioCrR+XYpWxcj
	BwebgKbEhcmlIGERAWWJu/Nngg1lFljCKDFnTiqILSzgIrHuyAawOK+AlsSiwxcZIWxBiZMz
	n4CN5BSwl1j24ABYXBRozoFtx8HOlhCYyiExffpJFojrXCQu3e1igrCFJV4d38IOYUtJfH63
	lw3CTpa4NPMcVE2JxOM9B6Fse4nWU/3MEMdlSnTffcsCYfNJ9P5+wgTyi4QAr0RHmxBEuaLE
	vUlPWSFscYmHM5ZA2R4Ss1/sYYaEyV1midZVh1kmMMrNQvLPLCQrIGwric4PTawQtrxE89bZ
	zLOA1jELSEss/8cBYWpKrN+lv4CRbRWjZGpBcW56arFpgVFeajk8vpPzczcxgpOqltcOxocP
	PugdYmTiYDzEKMHBrCTC+/uaUooQb0piZVVqUX58UWlOavEhRlNgVE1klhJNzgem9bySeEMT
	SwMTMzMzE0tjM0MlcV5125PJQgLpiSWp2ampBalFMH1MHJxSDUxRmonXNzfyTdV2i663NVz/
	/1Zhdvndj3mPJ+xZ73Lq0oFUqbhH3qk2JpeNk79FiwlJrsluMN41b9luZWangnXqOu+2MfiL
	z63pCamZ5R//Wm/7Rwuz/1ofF38/zqzW6Md2S27Gd5/4x54MWkf3s66YxvXulNjMlAXbMmyr
	PlhJHprgnL/ZMcHrafPO1l7+jff9VEWOWFXfW5YIVO7KIS3XZnlLke+i2id3Z7nlk+Ta25vK
	+p5LvVLR2zQlWvFW9P65fV+3/52Y3SE7QXPJl4P7jaQNqqyObTZguKxivuuj1tRtMofELPfX
	fGq8L/3rwVuNcr6SIz+3/ZG7WppQt3Na3bYpJ58znwoOO2+lpsRSnJFoqMVcVJwIAJ4pmB4z
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvC7zb+UUg9sT1SxW3+1ns1i5+iiT
	xfm3h5ksJh26xmhx5upCFou9t7Qt5i97yu7A7rFz1l12j8tnSz02repk89i8pN5j980GNo9z
	Fys8Pm+SC2CP4rJJSc3JLEst0rdL4Mpo3/KcueCBRMXWt9/YGhg3C3cxcnJICJhI7Oz8ytrF
	yMUhJLCDUaLt2mImiIS4RPO1H+wQtrDEyn/P2SGKHjFK7Dm/lBkkwSKgKtH5dilbFyMHB5uA
	psSFyaUgYREBZYm782eygtjMAksYJebMSQWxhQVcJNYd2QAW5xXQklh0+CIjxMz7zBInWv4z
	QiQEJU7OfMIC0WwmMW/zQ2aQ+cwC0hLL/3FAhOUlmrfOBjuBU8BeYtmDA2CtokB7D2w7zjSB
	UWgWkkmzkEyahTBpFpJJCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBMePltYO
	xj2rPugdYmTiYDzEKMHBrCTC+/uaUooQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNIT
	S1KzU1MLUotgskwcnFINTAzcH3hKtyt4uH5fI2Q8q+XZPTsvjenqMg+jg0wuHnD8y2Th+559
	0b6klb6Lvkd4r5xmIFNruOrygtjimlk+56xaHube4A7z3Okx8+2iGZU+fTJsoasfHPHSmuFg
	sVr9NBe7y44FE2Wz5saGsKcumFF34fbZyN1yrTmu0vwOEpNVyyo0pOYpStXHn9Jw7XZ+tc1w
	exBjYnH59hY+y+Mzbtybuf1p1+KFFod5I1utZ3Un1Ztdlpnzrn1a753q7Df5Ih6Z6pybtm0V
	eip4vPWNmsrqfRvm8FzdWXJ3i3blU1Ex7o6CiO3/Nlr88OxwcQ3bkz0h+Muv7Vv6rPTu1W8T
	tHQ4JHMt5/X3j4Iq1QE7lViKMxINtZiLihMBqIAl0Q4DAAA=
X-CMS-MailID: 20230329084659epcas5p3bfde5f30962dd3f30f4e401967c0cd76
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_117d1b_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427
References: <20230324212803.1837554-1-kbusch@meta.com>
	<CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
	<20230324212803.1837554-2-kbusch@meta.com> <20230327135810.GA8405@green5>
	<ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
	<CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
	<ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com>
	<20230328074939.GA2800@green5>
	<ZCL/RTHoflUVCMyw@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_014710_595249_F8B0463F 
X-CRM114-Status: GOOD (  34.96  )
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

------KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_117d1b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, Mar 28, 2023 at 08:52:53AM -0600, Keith Busch wrote:
>On Tue, Mar 28, 2023 at 01:19:39PM +0530, Kanchan Joshi wrote:
>> On Mon, Mar 27, 2023 at 06:48:30PM -0600, Keith Busch wrote:
>> > On Mon, Mar 27, 2023 at 10:50:47PM +0530, Kanchan Joshi wrote:
>> > > On Mon, Mar 27, 2023 at 8:59 PM Keith Busch <kbusch@kernel.org> wrote:
>> > > > > >     rcu_read_lock();
>> > > > > > -   bio = READ_ONCE(ioucmd->cookie);
>> > > > > > -   ns = container_of(file_inode(ioucmd->file)->i_cdev,
>> > > > > > -                   struct nvme_ns, cdev);
>> > > > > > -   q = ns->queue;
>> > > > > > -   if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
>> > > > > > -           ret = bio_poll(bio, iob, poll_flags);
>> > > > > > +   req = READ_ONCE(ioucmd->cookie);
>> > > > > > +   if (req) {
>> > > > >
>> > > > > This is risky. We are not sure if the cookie is actually "req" at this
>> > > > > moment.
>> > > >
>> > > > What else could it be? It's either a real request from a polled hctx tag, or
>> > > > NULL at this point.
>> > >
>> > > It can also be a function pointer that gets assigned on irq-driven completion.
>> > > See the "struct io_uring_cmd" - we are tight on cacheline, so cookie
>> > > and task_work_cb share the storage.
>> > >
>> > > > It's safe to check the cookie like this and rely on its contents.
>> > > Hence not safe. Please try running this without poll-queues (at nvme
>> > > level), you'll see failures.
>> >
>> > Okay, you have a iouring polling instance used with a file that has poll
>> > capabilities, but doesn't have any polling hctx's. It would be nice to exclude
>> > these from io_uring's polling since they're wasting CPU time, but that doesn't
>> > look easily done.
>>
>> Do you mean having the ring with IOPOLL set, and yet skip the attempt of
>> actively reaping the completion for certain IOs?
>
>Yes, exactly. It'd be great if non-polled requests don't get added to the
>ctx->iopoll_list in the first place.
>
>> > This simple patch atop should work though.
>> >
>> > ---
>> > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> > index 369e8519b87a2..e3ff019404816 100644
>> > --- a/drivers/nvme/host/ioctl.c
>> > +++ b/drivers/nvme/host/ioctl.c
>> > @@ -612,6 +612,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> >
>> > 	if (blk_rq_is_poll(req))
>> > 		WRITE_ONCE(ioucmd->cookie, req);
>> > +	else if (issue_flags & IO_URING_F_IOPOLL)
>> > +		ioucmd->flags |= IORING_URING_CMD_NOPOLL;
>>
>> If IO_URING_F_IOPOLL would have come here as part of "ioucmd->flags", we
>> could have just cleared that here. That would avoid the need of NOPOLL flag.
>> That said, I don't feel strongly about new flag too. You decide.
>
>IO_URING_F_IOPOLL, while named in an enum that sounds suspiciouly like it is
>part of ioucmd->flags, is actually ctx flags, so a little confusing. And we
>need to be a litle careful here: the existing ioucmd->flags is used with uapi
>flags.

Indeed. If this is getting crufty, series can just enable polling on
no-payload requests. Reducing nvme handlers - for another day.

------KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_117d1b_
Content-Type: text/plain; charset="utf-8"


------KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_117d1b_--

