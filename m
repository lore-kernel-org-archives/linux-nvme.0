Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4661BC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 18:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A4zU3LALN17PA2SGOvRHi8DxXYHL7vmlIhdDeCwlze8=; b=KHRwZjfBvxHizU7NSKsor3nqaT
	Zc/f77AxMzdrzVUP9ZOfY9Iae+Hlj437mWLoBU0MJaYnEx492X4MuGhvNul8Xg4xupmTR22soaUx3
	xXd4JE+UeXASoqETsQU9z5oLtMpsEzXxRObomBw64DnS6Lsy6GV1+cz0BULontRGzDNKTZnbPGy8v
	BFQP8R2Aacw3P/kApTaHwBX2EBw15imkCd6I8Y//cWVKJyvcuu7ykQ18fJJWp437lzW+NlIuCKAHZ
	WhJx3rVuYAsjQJmXHmpLeX83BV29ARQEc01TidNwMW7jgjBN84u5NHj/QxSIuxe45T0ZymRrmB6XC
	trKWoyLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEsq-00C5rf-Lj; Tue, 27 Sep 2022 18:00:40 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEsn-00C5qQ-Aw
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 18:00:39 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220927180034epoutp047cd10dca7e4ae75627dc95ef0fc5a3aa~YyYS34h3F0632406324epoutp04w
	for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 18:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220927180034epoutp047cd10dca7e4ae75627dc95ef0fc5a3aa~YyYS34h3F0632406324epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664301634;
	bh=A4zU3LALN17PA2SGOvRHi8DxXYHL7vmlIhdDeCwlze8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tgEw9jGbT/lSEzuw6ReTM1lGuk6/h7gg9LvRVWdKwR15S35KsKkZXu1HOdCkSQeke
	 uWGG11xZ/B1AsdCi8sQGGN3vR4GMb1zbDgkvxKBZyrtkxqTjCPqidFr6Nk+DJULPAB
	 Irjz5DoplOG0i5kzK9S0B9HQ29pilWBdwjm0nKQQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220927180033epcas5p41a63bd9b67bc650a20644cc43a7ff6c0~YyYSGM8XW2241822418epcas5p4C;
	Tue, 27 Sep 2022 18:00:33 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4McS8Z4m2Mz4x9Pr; Tue, 27 Sep
	2022 18:00:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.D8.26992.E3A33336; Wed, 28 Sep 2022 03:00:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220927180029epcas5p23ebdbe94b22e16fcba8926cac4701aa6~YyYO62vOl0100801008epcas5p2e;
	Tue, 27 Sep 2022 18:00:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220927180029epsmtrp1ff471f1290cfaf372c22f5e89065c0be~YyYO6L9ZH2478624786epsmtrp1V;
	Tue, 27 Sep 2022 18:00:29 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-91-63333a3efa92
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	3A.C6.18644.D3A33336; Wed, 28 Sep 2022 03:00:29 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220927180028epsmtip2d6316bbb9855b47deed9f568e9b9ac14~YyYNuuTPU2082120821epsmtip2i;
	Tue, 27 Sep 2022 18:00:28 +0000 (GMT)
Date: Tue, 27 Sep 2022 23:20:40 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next 2/2] nvme: Make CAP_SYS_ADMIN fine-granular
Message-ID: <20220927175040.GA4890@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220927073250.GB16831@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTXdfOyjjZ4OEOFYvVd/vZLG4e2Mlk
	sXL1USaLSYeuMVrMX/aU3WLd6/csDmwe5+9tZPG4fLbUY9OqTjaPzUvqPXbfbGDz6NuyijGA
	LSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
	ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
	dsbymXOZC+YKVKxpWsXUwHiBt4uRk0NCwERiccM+xi5GLg4hgd2MEjuWnIFyPjFKnHg6ix3C
	+cwo0bl7JRNMS2NnHytEYhejRNfs2VAtzxglbi2ewQxSxSKgKtH5YTFQBwcHm4CmxIXJpSBh
	EQEliaevzjKC2MwCBRLv2xYzg5QIC3hI7DpeBRLmFdCROHb/IzuELShxcuYTFhCbEyg+ee9G
	MFtUQFniwLbjTCBrJQT+sks8eneCFeI4F4m+K33MELawxKvjW9ghbCmJl/1tUHayxKWZ56Ce
	KZF4vOcglG0v0XqqnxnitgyJ6/1XmSBsPone30/AXpEQ4JXoaBOCKFeUuDfpKdRacYmHM5ZA
	2R4SH++tY4YEyW1GiVeNf5knMMrNQvLPLCQrIGwrYGg1sc4CWsEsIC2x/B8HhKkpsX6X/gJG
	1lWMkqkFxbnpqcWmBYZ5qeXwOE7Oz93ECE6XWp47GO8++KB3iJGJg/EQowQHs5II7++jhslC
	vCmJlVWpRfnxRaU5qcWHGE2BsTORWUo0OR+YsPNK4g1NLA1MzMzMTCyNzQyVxHkXz9BKFhJI
	TyxJzU5NLUgtgulj4uCUamDaHu66S4E7R+L013DDWW/4Ta/8t59h82jbOYZbd9xSrPVX+Ej8
	yjj5KFLj8YOlF5yWWFoJO87a4/lXcBmXT/aOKfwaStlpy+RM3FST704wEn10/qF11bpXfO41
	NW/k4tyNFylf6/+srP7lZ2vLDfkeNXYf3SobIec9jVo+wkdEq49sErSV6n17/HgoXyTLl8VX
	FVo2V2o3hhs+DNqw361+Hd+7J2sLwg5LsL6Ki12x/g6zvtDtwMsxtrslJd9d5HQKqog99l4u
	/LS9D8/BvAW8BtM5etY98y0UD5YM5PiqO2tdaEHBq+/vf/23fHBmQ32iW+8SMb1r9fOCQ0sT
	FsmGvz20PXF2y1eGXzy3dyuxFGckGmoxFxUnAgDUM7nyIAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSvK6tlXGywfsjBhar7/azWdw8sJPJ
	YuXqo0wWkw5dY7SYv+wpu8W61+9ZHNg8zt/byOJx+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
	WxSXTUpqTmZZapG+XQJXxoa1C9kLzvNWrJ55grGBcQ53FyMnh4SAiURjZx8riC0ksINRYu4R
	DYi4uETztR/sELawxMp/z9khap4wStz6aQpiswioSnR+WMzUxcjBwSagKXFhcilIWERASeLp
	q7OMIDazQIHE+7bFzCAlwgIeEruOV4GEeQV0JI7d/wg0kQto4l1Giebfy1kgEoISJ2c+YYHo
	NZOYt/khWC+zgLTE8n8cIGFOoN7JezeClYgKKEsc2HacaQKj4Cwk3bOQdM9C6F7AyLyKUTK1
	oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM49LW0djDuWfVB7xAjEwfjIUYJDmYlEd7fRw2T
	hXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDasXjF1lNT
	moVv/Pgru8fB92bsGcNjli8er1vOUvvX5uza00f/+DsynN165/WBpSk3PIpzSpX+HDA+PDtg
	ydOlk1J4dk0xsLCQ15C/fnLF76KTv1wLd7ufe87dOVfqu/VBLvPVjCfus4b+Kfpx1Sa49Nq2
	562P/numaC41fdXCwvSER76+0PnFrLzZDzN3f942ozrnstbM7axazW98bP9Klp7682TG7iVm
	G/Z/f7VFcnXp6qOM50Tu/HKbeNGT2cv2TMSn5H2szVIcJqbXtk9p3id3IrPta/P+FI97myrK
	2hlvr5ljU5rN9PRncNkZtXlRU1uXrfhvm/b9b2Wk3XtbVk/uRxdbNghmfuJuvvxeZpkSS3FG
	oqEWc1FxIgCiphIu7AIAAA==
X-CMS-MailID: 20220927180029epcas5p23ebdbe94b22e16fcba8926cac4701aa6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_179d0_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c
References: <20220926145430.81658-1-joshi.k@samsung.com>
	<CGME20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c@epcas5p2.samsung.com>
	<20220926145430.81658-3-joshi.k@samsung.com> <20220927073250.GB16831@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_110037_864343_D0083FDC 
X-CRM114-Status: GOOD (  18.15  )
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

------Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_179d0_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Sep 27, 2022 at 09:32:50AM +0200, Christoph Hellwig wrote:
>On Mon, Sep 26, 2022 at 08:24:30PM +0530, Kanchan Joshi wrote:
>> Change all the callers of CAP_SYS_ADMIN to go through nvme_cmd_allowed
>> for any decision making.
>> Since file open mode is taken into consideration for any
>> approval/denial, change at various places to keep file-mode information
>> handy.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> ---
>>  drivers/nvme/host/ioctl.c | 70 +++++++++++++++++++++------------------
>>  1 file changed, 38 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> index 6ca6477dd899..4e53a01e702d 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -259,7 +259,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
>>  }
>>
>>  static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> -			struct nvme_passthru_cmd __user *ucmd)
>> +			struct nvme_passthru_cmd __user *ucmd, fmode_t mode)
>>  {
>>  	struct nvme_passthru_cmd cmd;
>>  	struct nvme_command c;
>> @@ -267,10 +267,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>  	u64 result;
>>  	int status;
>>
>> -	if (!capable(CAP_SYS_ADMIN))
>> -		return -EACCES;
>>  	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
>>  		return -EFAULT;
>> +	if (!nvme_cmd_allowed(ns, cmd.opcode, mode))
>> +		return -EACCES;
>
>Btw, what speaks against moving this check a little bit later,
>so that we can pass the nvme_command to nvme_cmd_allowed, and thus
>can simply use nvme_is_write?

Moving down is good to me. Just after we have put the opcode into
nvme_command. Will do that in v2.


------Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_179d0_
Content-Type: text/plain; charset="utf-8"


------Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_179d0_--

