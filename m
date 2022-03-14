Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A109BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fje2hdOAeJXeMwXLGbynketnbDdN2GmtQrq3rcfIgFo=; b=0YU39PZRjwRBOJBjTUDM/pgM/U
	JhxVISvnpIYsgu7p/YGXJlyeP5sjvS5sO/IW/AIMdoQuGVHqMuG5JxK0GxzHNAIcJc054YAq0p+Uh
	MIn23lMkNxq4vtv/brDCoJPxRTJ3UU5rIS6HhPSuzJ1fO/XmJ312G7GF5pGhSBN6LxyhXNzuQ9f+B
	yWPKNzPOGe45/3CJNHQTV/V6dV8o9dUf0WmI37nCHiKAmvKFXngEgH7pwatClRP9FPhDqa6OnHliw
	wKD23++g+Plyqy1Fb0+hLfGBHkcHaM7FQOu5HLBYXaIZVi9XeKGOFyAFYFaUpXvHqOL7uDuQ46lA2
	jqmgsI9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nToQ7-006MRw-8S; Mon, 14 Mar 2022 17:23:47 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nToDc-006Hit-TV
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 17:10:55 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220314171047epoutp02e984ba337fbf518e09fd198dcaae67db~cTnmJOKHq3149331493epoutp02S
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 17:10:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220314171047epoutp02e984ba337fbf518e09fd198dcaae67db~cTnmJOKHq3149331493epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647277847;
 bh=Fje2hdOAeJXeMwXLGbynketnbDdN2GmtQrq3rcfIgFo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=urn3I3Sl6c27zbe8HCRzM+vI0wi/hCmtjY3zcVqOybxZBD3Qacfq4ErzJt9aq5+uI
 lNLYn71DWpjPm8cBe5WAjQMorIeUX7HBhRs1wJ4Yqk4Uc/x6gMLW+HtEnaocz3JqpR
 ktWbbhsk4MNri/08rLDJaDkiK/FsqPKzan7+LV9o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220314171047epcas5p11fd141c158ab59472725d22a9d5d38e2~cTnluSK7Z0110001100epcas5p1S;
 Mon, 14 Mar 2022 17:10:47 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4KHNN401cnz4x9Pp; Mon, 14 Mar
 2022 17:10:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F6.39.05590.3177F226; Tue, 15 Mar 2022 02:10:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220314162858epcas5p4a383d0b0d9a316b664858260309da317~cTDFbSjda1648016480epcas5p4j;
 Mon, 14 Mar 2022 16:28:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220314162858epsmtrp295265bf240e5a0dcee04cd1605987834~cTDFagFk_2854328543epsmtrp2z;
 Mon, 14 Mar 2022 16:28:58 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-1d-622f7713336d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 AA.AD.29871.A4D6F226; Tue, 15 Mar 2022 01:28:58 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220314162856epsmtip156951fa6e16a482e0c694ce1cfe6dd5a~cTDDajiyG2640826408epsmtip1f;
 Mon, 14 Mar 2022 16:28:56 +0000 (GMT)
Date: Mon, 14 Mar 2022 21:53:56 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 pankydev8@gmail.com, javier@javigon.com, mcgrof@kernel.org,
 a.manzanares@samsung.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Message-ID: <20220314162356.GA13902@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220311070148.GA17881@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmuq5wuX6Swbw2C4vphxUtmib8ZbaY
 s2obo8Xqu/1sFitXH2WyeNd6jsWi8/QFJovzbw8zWUw6dI3RYu8tbYv5y56yWyxpPc5mcWPC
 U0aLNTefslh8PjOP1YHf49nVZ4weO2fdZfdoXnCHxePy2VKPTas62Tw2L6n32H2zgc1j2+KX
 rB59W1YxenzeJBfAFZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr
 5OIToOuWmQP0g5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10v
 L7XEytDAwMgUqDAhO2PtHp2C+eYVV+d9YWpgXKnWxcjBISFgIrH0sVgXIxeHkMBuRonPW3vZ
 IJxPjBKT3pxh7mLkBHK+MUrs+C4LYoM0LN8/nR2iaC+jxO2eVijnGaPE+/bVTCBVLAKqEntn
 vGMGWcEmoClxYXIpSFhEQEni6auzjCD1zAInmCTm3psHVi8sECrR0toNZvMK6Erc+3aNBcIW
 lDg58wmYzSmgI7Hj4kQwW1RAWeLAtuNMIIMkBG5wSFz9cJEV4jwXiUWX37ND2MISr45vgbKl
 JD6/28sGYRdL/LpzlBmiuYNR4nrDTBaIhL3ExT1/wa5gFsiU2PxhA9RQWYmpp9ZBxfkken8/
 YYKI80rsmAdjK0rcm/QUql5c4uGMJayQAPaQWDJbGhJC9xklXrY/YJvAKD8LyXOzkKyDsK0k
 Oj80AdkcQLa0xPJ/HBCmpsT6XfoLGFlXMUqmFhTnpqcWmxYY56WWw+M7OT93EyM4hWt572B8
 9OCD3iFGJg7GQ4wSHMxKIrxWS/WShHhTEiurUovy44tKc1KLDzGaAiNrIrOUaHI+MIvklcQb
 mlgamJiZmZlYGpsZKonznkrfkCgkkJ5YkpqdmlqQWgTTx8TBKdXAdNVbh+n7aqdrq0IS370/
 7PXv2vYYwevNOo9PJPxWEz6hwMSQ42f18fxLddWFpWWiTXl7L9y5uXbuukIrL6nXf9rLPbau
 e6lk3Jwk/N2y79Ae5bqnm1Mt9Y9d8rM+yRK/4Vcqm8vE6kyz4kVPJHPOaCe/fv3N+bXhcsfa
 2x1iDzUnHHP0VHcJWS/6I/mUU5asK+vquy9/fos0NyuTWM174/dBTin9WJFF8yvYF8iHXnFe
 pceqL/HzzEFj4b9xC8O1w9eaeqdNz6lRbHmpN61rxv+EI82saw+2zPKout/5V1em9t6CrLdb
 WfOclXWLnzzWPbv/ge2bLaXzvLuOheoErhF/muhmWRGzLP3OOQVdJZbijERDLeai4kQA1cys
 KWoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnK5Xrn6SQfdMOYvphxUtmib8ZbaY
 s2obo8Xqu/1sFitXH2WyeNd6jsWi8/QFJovzbw8zWUw6dI3RYu8tbYv5y56yWyxpPc5mcWPC
 U0aLNTefslh8PjOP1YHf49nVZ4weO2fdZfdoXnCHxePy2VKPTas62Tw2L6n32H2zgc1j2+KX
 rB59W1YxenzeJBfAFcVlk5Kak1mWWqRvl8CV8eTSfvaCcyYVJ09tZ25g/KTcxcjJISFgIrF8
 /3T2LkYuDiGB3YwS95susUMkxCWar/2AsoUlVv57DlX0hFHi5b9bYAkWAVWJvTPeMXcxcnCw
 CWhKXJhcChIWEVCSePrqLCNIPbPAKSaJhm3vwOqFBUIlWlq7mUBsXgFdiXvfrrFADL3PKHFm
 2TuohKDEyZlPWEBsZgEziXmbH4ItYBaQllj+jwMkzCmgI7Hj4kSwElEBZYkD244zTWAUnIWk
 exaS7lkI3QsYmVcxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHn5bmDsbtqz7oHWJk
 4mA8xCjBwawkwmu1VC9JiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalF
 MFkmDk6pBqa1rw6ofvN+ZsS31XfPgl19CjNulZxsMdJIzz58QPSrY4uj3/ZShRtKz9Tfne9Y
 9ykx49Wv9hlikrf0nZjnL3Dr7T/+/p6XhWnffDHN5vbi/dLt3Zr/zR13S80wnb6+ITygYGPs
 vLA/0jmph6xz1sZMXcL2/X/JdGte54PaHAvvJn15b+t35FWcWKd84vk3D8IzrjAIxMw5HSSY
 uF9ujcqCZUamtqy1+yZZOk/4eU/6QHzQEaVFJyz9Su41fV6UNLPvk+SmRyaeG+bpq36t+SHw
 UfnsHZ0/DY/nHn4ducji9vW3RhVHd4lPV7/3Ja2We7+En9VuvyL5f9ZlktMUOTOmWi0+M3PO
 dReT3Hfrwz4osRRnJBpqMRcVJwIARqwT0C4DAAA=
X-CMS-MailID: 20220314162858epcas5p4a383d0b0d9a316b664858260309da317
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----whw7GLWDXQn0DNT5QbpmV5iNJmL06zVCQqLt8G63uv36fYb2=_110027_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <20220311070148.GA17881@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_101053_447969_05FF59A5 
X-CRM114-Status: GOOD (  32.23  )
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

------whw7GLWDXQn0DNT5QbpmV5iNJmL06zVCQqLt8G63uv36fYb2=_110027_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Mar 11, 2022 at 08:01:48AM +0100, Christoph Hellwig wrote:
>On Tue, Mar 08, 2022 at 08:50:53PM +0530, Kanchan Joshi wrote:
>> +/*
>> + * This overlays struct io_uring_cmd pdu.
>> + * Expect build errors if this grows larger than that.
>> + */
>> +struct nvme_uring_cmd_pdu {
>> +	u32 meta_len;
>> +	union {
>> +		struct bio *bio;
>> +		struct request *req;
>> +	};
>> +	void *meta; /* kernel-resident buffer */
>> +	void __user *meta_buffer;
>> +} __packed;
>
>Why is this marked __packed?
Did not like doing it, but had to.
If not packed, this takes 32 bytes of space. While driver-pdu in struct
io_uring_cmd can take max 30 bytes. Packing nvme-pdu brought it down to
28 bytes, which fits and gives 2 bytes back.

For quick reference - 
struct io_uring_cmd {
        struct file *              file;                 /*     0     8 */
        void *                     cmd;                  /*     8     8 */
        union {
                void *             bio;                  /*    16     8 */
                void               (*driver_cb)(struct io_uring_cmd *); /*    16     8 */
        };                                               /*    16     8 */
        u32                        flags;                /*    24     4 */
        u32                        cmd_op;               /*    28     4 */
        u16                        cmd_len;              /*    32     2 */
        u16                        unused;               /*    34     2 */
        u8                         pdu[28];              /*    36    28 */

        /* size: 64, cachelines: 1, members: 8 */
};
io_uring_cmd struct goes into the first cacheline of io_kiocb.
Last field is pdu, taking 28 bytes. Will be 30 if I evaporate above
field.
nvme-pdu after packing:
struct nvme_uring_cmd_pdu {
        u32                        meta_len;             /*     0     4 */
        union {
                struct bio *       bio;                  /*     4     8 */
                struct request *   req;                  /*     4     8 */
        };                                               /*     4     8 */
        void *                     meta;                 /*    12     8 */
        void *                     meta_buffer;          /*    20     8 */

        /* size: 28, cachelines: 1, members: 4 */
        /* last cacheline: 28 bytes */
} __attribute__((__packed__));

>In general I'd be much more happy if the meta elelements were a
>io_uring-level feature handled outside the driver and typesafe in
>struct io_uring_cmd, with just a normal private data pointer for the
>actual user, which would remove all the crazy casting.

Not sure if I got your point.

+static struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(struct io_uring_cmd *ioucmd)
+{
+       return (struct nvme_uring_cmd_pdu *)&ioucmd->pdu;
+}
+
+static void nvme_pt_task_cb(struct io_uring_cmd *ioucmd)
+{
+       struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);

Do you mean crazy casting inside nvme_uring_cmd_pdu()?
Somehow this looks sane to me (perhaps because it used to be crazier
earlier).

And on moving meta elements outside the driver, my worry is that it
reduces scope of uring-cmd infra and makes it nvme passthru specific.
At this point uring-cmd is still generic async ioctl/fsctl facility
which may find other users (than nvme-passthru) down the line. 
Organization of fields within "struct io_uring_cmd" is around the rule
that a field is kept out (of 28 bytes pdu) only if is accessed by both
io_uring and driver. 

>> +static void nvme_end_async_pt(struct request *req, blk_status_t err)
>> +{
>> +	struct io_uring_cmd *ioucmd = req->end_io_data;
>> +	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>> +	/* extract bio before reusing the same field for request */
>> +	struct bio *bio = pdu->bio;
>> +
>> +	pdu->req = req;
>> +	req->bio = bio;
>> +	/* this takes care of setting up task-work */
>> +	io_uring_cmd_complete_in_task(ioucmd, nvme_pt_task_cb);
>
>This is a bit silly.  First we defer the actual request I/O completion
>from the block layer to a different CPU or softirq and then we have
>another callback here.  I think it would be much more useful if we
>could find a way to enhance blk_mq_complete_request so that it could
>directly complet in a given task.  That would also be really nice for
>say normal synchronous direct I/O.

I see, so there is room for adding some efficiency.
Hope it will be ok if I carry this out as a separate effort.
Since this is about touching blk_mq_complete_request at its heart, and
improving sync-direct-io, this does not seem best-fit and slow this
series down.

FWIW, I ran the tests with counters inside blk_mq_complete_request_remote()

        if (blk_mq_complete_need_ipi(rq)) {
                blk_mq_complete_send_ipi(rq);
                return true;
        }

        if (rq->q->nr_hw_queues == 1) {
                blk_mq_raise_softirq(rq);
                return true;
        }
Deferring by ipi or softirq never occured. Neither for block nor for
char. Softirq is obvious since I was not running against scsi (or nvme with
single queue). I could not spot whether this is really a overhead, at
least for nvme.


>> +	if (ioucmd) { /* async dispatch */
>> +		if (cmd->common.opcode == nvme_cmd_write ||
>> +				cmd->common.opcode == nvme_cmd_read) {
>
>No we can't just check for specific commands in the passthrough handler.

Right. This is for inline-cmd approach. 
Last two patches of the series undo this (for indirect-cmd).
I will do something about it.

>> +			nvme_setup_uring_cmd_data(req, ioucmd, meta, meta_buffer,
>> +					meta_len);
>> +			blk_execute_rq_nowait(req, 0, nvme_end_async_pt);
>> +			return 0;
>> +		} else {
>> +			/* support only read and write for now. */
>> +			ret = -EINVAL;
>> +			goto out_meta;
>> +		}
>
>Pleae always handle error in the first branch and don't bother with an
>else after a goto or return.

Yes, that'll be better.
>> +static int nvme_ns_async_ioctl(struct nvme_ns *ns, struct io_uring_cmd *ioucmd)
>> +{
>> +	int ret;
>> +
>> +	BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
>> +
>> +	switch (ioucmd->cmd_op) {
>> +	case NVME_IOCTL_IO64_CMD:
>> +		ret = nvme_user_cmd64(ns->ctrl, ns, NULL, ioucmd);
>> +		break;
>> +	default:
>> +		ret = -ENOTTY;
>> +	}
>> +
>> +	if (ret >= 0)
>> +		ret = -EIOCBQUEUED;
>
>That's a weird way to handle the returns.  Just return -EIOCBQUEUED
>directly from the handler (which as said before should be split from
>the ioctl handler anyway).

Indeed. That will make it cleaner.

------whw7GLWDXQn0DNT5QbpmV5iNJmL06zVCQqLt8G63uv36fYb2=_110027_
Content-Type: text/plain; charset="utf-8"


------whw7GLWDXQn0DNT5QbpmV5iNJmL06zVCQqLt8G63uv36fYb2=_110027_--

