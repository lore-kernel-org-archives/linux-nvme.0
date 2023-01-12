Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF213C54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 05:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9iUeb+FoZd3Od0FJPyCMjXv858oUTOLcqhxsQFb90zI=; b=z1uamd0RiAiJRkuqv2GJJ4EHj+
	ziJJKz9muO3cMEJ0sudVx8DDKc8UicT5gUhnJ+VjO9jYoHJm6oW8D9/cHCo6BxvZ3925vU4vvCEqZ
	YpDOXqT82d6BrvCfEUVGvQ/GdbFlBSzJIcaYpKsakZCOltYsOqpyO26JjxpUyjjHhQa7ujk6LCmjI
	MgI4xjXPxb1XS03s89jNZa4Rp6mZveXEnC9iCcjPQpTW0XyFPse6ptxynsYVfS5eHpVYOyUSM68pX
	mFV6m+vwdgnE6d2Q+580VdZXl4tH7M/bl6Gm8elqIV1pcUmnCgzthztpbXbPf1ZiKLbLGx4zBGphu
	YBNruv3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFqHN-00Dr1S-5S; Thu, 12 Jan 2023 05:37:33 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFqHJ-00Dr0d-AJ
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 05:37:31 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230112053720epoutp0224edfe7a959f357ee61ae48bfd5b9177~5eQ6y5SMt2720527205epoutp02M
	for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 05:37:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230112053720epoutp0224edfe7a959f357ee61ae48bfd5b9177~5eQ6y5SMt2720527205epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1673501840;
	bh=9iUeb+FoZd3Od0FJPyCMjXv858oUTOLcqhxsQFb90zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uqKx46FWwDWkNCbsv6gsRi/jG0ufva6tmIFCXz9+zYppY1jMH+HU5pc/sHEE+zU2v
	 mgCsd2XMgO3jeRwZHmOUgZQEh09htfSp/rnGppkG9Nn3w+bCZe7cwyfK0qXsvc92z1
	 biZzqpH0a4KSKSD+EyC2Ch0f+vDG6mj5chDqTFbo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230112053720epcas5p4f4c4bc6fe97dba7065676d178145f7f2~5eQ6XM7Go0698706987epcas5p4y;
	Thu, 12 Jan 2023 05:37:20 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Nstbf72Kwz4x9Ps; Thu, 12 Jan
	2023 05:37:18 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.59.02301.E8C9FB36; Thu, 12 Jan 2023 14:37:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230112053718epcas5p20adbe330d7497712b2414e2c163c444f~5eQ4xHgAV0587305873epcas5p2A;
	Thu, 12 Jan 2023 05:37:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230112053718epsmtrp2fa58f24a30ce637d9b035e80945c5994~5eQ4wUD_I3020930209epsmtrp2L;
	Thu, 12 Jan 2023 05:37:18 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-aa-63bf9c8ecdc4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	14.3D.10542.E8C9FB36; Thu, 12 Jan 2023 14:37:18 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230112053716epsmtip2061ffda79f5264a496bddab1747e1c49~5eQ3PclA41557615576epsmtip2n;
	Thu, 12 Jan 2023 05:37:16 +0000 (GMT)
Date: Thu, 12 Jan 2023 11:06:55 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>, "smith,
 erik" <Erik.Smith@dell.com>, "Ghalam, Joe" <Joe.Ghalam@dell.com>, "Hayes,
 Stuart" <Stuart.Hayes@dell.com>, "White, Joseph L"
	<Joseph.L.White@dell.com>, "Glimcher, Boris" <Boris.Glimcher@dell.com>,
	axboe@kernel.dk
Subject: Re: nvme-fabrics: devices are uninterruptable
Message-ID: <20230112053655.GA743@green5>
MIME-Version: 1.0
In-Reply-To: <BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmlm7fnP3JBlNeWFisvtvPZvHmyjFG
	i8OPJ7FbnN69nMliz6JJTBYT9+pY3N3wicli/rKn7BbnZi1hsZj6YxaTA5fHpJkzmD0uny31
	2Lyk3mPz6eoAlqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRef
	AF23zByga5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eakl
	VoYGBkamQIUJ2RkznixgKbjCXfG5vZGxgfE7ZxcjJ4eEgInE08OfmEBsIYHdjBIHNrJ2MXIB
	2Z8YJeasmswI4XxmlNjZd4QVpmPF5yNMEIldjBJb7y5mhWh/wijRskMHxGYRUJX40v4GqIiD
	g01AU+LC5FKQsIiAocSbFXNYQHqZBd4xSdxvuQXWKyxgJvHgzS8wmxeo/kbnBBYIW1Di5Mwn
	YDanQKzEtIZ/bCC2qICyxIFtx8GOkBBo5ZC4fXMWC8gyCQEXiafNIhCHCku8Or6FHcKWkvj8
	bi8bhJ0scWnmOSYIu0Ti8Z6DULa9ROupfmYQm1kgQ+L4/99QNp9E7+8nTBDjeSU62oQgyhUl
	7k16Cg0TcYmHM5ZA2R4Sm95th4bPBkaJN7desE5glJuF5J1ZSFZA2FYSnR+aWGcBrWAWkJZY
	/o8DwtSUWL9LfwEj6ypGydSC4tz01GLTAsO81HJ4FCfn525iBCdPLc8djHcffNA7xMjEwXiI
	UYKDWUmEV8V/f7IQb0piZVVqUX58UWlOavEhRlNg9ExklhJNzgem77ySeEMTSwMTMzMzE0tj
	M0Mlcd7UrfOThQTSE0tSs1NTC1KLYPqYODilGpimm9heyJotI+okcmBzZAz3Ke7su1bZm/hX
	B58V9W27Uqw3S97f7OPfW0cXynko9Mu2T5gsq2cinx6XLKa/9fmyXbZ2IUt/HA9cYqx0fGu2
	VW9KsseLyZ97Mvx6NPcuviR6sKwo/IzjVPevoZMV5+5q/d8/u+JIzb0I12/Zn24pswY3p6z5
	56f1zz/OYv17p26u4hplk/8nanbP8t5xPXzrwlX2CxKt+OILHatb1Cxn/p40Ze0++/92SvqS
	v3WkH+mqVzqzTQn/tDrjuaJzSGdrTfjNCs9rS7XVM8oat2qkRzhMtNc7VWywUWCxqF0LH5No
	ottZ7zsbHJonBx2oKlJrOryf8V7O5lI1W4UeJZbijERDLeai4kQAsBU6qicEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvG7fnP3JBpP2CFisvtvPZvHmyjFG
	i8OPJ7FbnN69nMliz6JJTBYT9+pY3N3wicli/rKn7BbnZi1hsZj6YxaTA5fHpJkzmD0uny31
	2Lyk3mPz6eoAligum5TUnMyy1CJ9uwSujM13VrEUtHFWtDf1szQwHmbvYuTkkBAwkVjx+QhT
	FyMXh5DADkaJxh87WCES4hLN135AFQlLrPz3nB2i6BGjxOK7P8GKWARUJb60vwHq5uBgE9CU
	uDC5FCQsImAo8WbFHBaQemaBD0wS5+d3soAkhAXMJB68+QXWywtUf6NzAgvE0A2MEnPm3GeB
	SAhKnJz5BMxmBmqYt/khM8gCZgFpieX/OEDCnAKxEtMa/rGB2KICyhIHth1nmsAoOAtJ9ywk
	3bMQuhcwMq9ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOCS2tHYx7Vn3QO8TIxMF4
	iFGCg1lJhFfFf3+yEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJM
	HJxSDUzrIsO8hfg38zpvjpdNzfCv7WxTEJKwbF33UMrB9MBnT2uva+GOkc5up77JMNzKjtjQ
	d2gNtxvbFZOXdQn75i4XjmMo3VDpEm5q7XvNY83Tw2+srWI/X/KQFtnZqhmn3nnONMLVr7j9
	iXWj01IfcV/zg3fz0151BV1TeLS8XvpeGdPRSeJCD6erqsc/a2c5fuKe3vWHG79MWrXPeV3v
	gtJ/BRf/fGKc+eU3j0iKfwFH8oWfi1pKnjxzmB+u/HvhB6Fnzzn7mu6w7FFfwrfD4oee38+P
	eYfPJnL07l8T5Vqjpdxy9M32l3osHlFPN7wqCTixojtgMc/UVMctCnGZ3/yFTuyxyy6WNJ/P
	2SP8WomlOCPRUIu5qDgRAFoNkND4AgAA
X-CMS-MailID: 20230112053718epcas5p20adbe330d7497712b2414e2c163c444f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_9f753_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230111144340epcas5p3940d3fbf8bd19771bf1fb55ba56ecf95
References: <CGME20230111144340epcas5p3940d3fbf8bd19771bf1fb55ba56ecf95@epcas5p3.samsung.com>
	<BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_213730_077641_7EA48AF7 
X-CRM114-Status: GOOD (  14.20  )
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

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_9f753_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Jan 11, 2023 at 02:37:58PM +0000, Belanger, Martin wrote:
>POSIX.1 specifies that certain functions such as read() or write() can act as cancellation points.
>
>Ref: https://pubs.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_09.html#tag_02_09_05_02

Not exactly related to the original question, but I hear the
cancellation requirement for passthrough too.

And it seems feasible as io_uring provides cancellation interface
(IORING_OP_ASYNC_CANCEL) to user-space.
It is only at io_uring level, and does not percolate down to lower
layers (as we don't have an interface).
Will it make sense to grow such interface for uring_cmd. Either
a new file-op ->uring_cmd_cancel or existing ->uring_cmd with new
cancel-flag. 
Not sure if ublk too needs it, but NVMe can support this (new op/flag)
cancellation by issuing abort-command to the device.

Down in nvme, we would need command-id/queue-id to issue abort command,
and that maybe tricky to store (although it is something we do for
iopoll). Maybe I can figure something out while cooking up a RFC.

But first things first, 
Christoph, Jens: does this sound reasonable?

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_9f753_
Content-Type: text/plain; charset="utf-8"


------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_9f753_--

