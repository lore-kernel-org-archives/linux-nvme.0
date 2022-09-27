Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626F8C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8NeCFH5VTrQKIuvJY9zqix/2t13zJTtcuTkMr6Kj2Ck=; b=GW3DNRqHuA81jrKDBMUPipIr1X
	vh6PeHFzKgaheBmd16VuEJ+E/vhSxWUJBl5rIvQ2ZQgv9l+Fpm+jY/07AGnFOBjO0bvv920gE/Hoz
	+ZMnvnGXSwzeIvULWIPOzjixyTz0T5XfwUZsdDTi7/A0fmH0m4Cp76WDBZ9TrF1z/ARTcLLHc53BZ
	XFSILnsAG+MSNpaGTHagWxn0Eg3/9mR+zAQlGKEdgv1hEYu2MtrRsB89mb9b3I1ucuoAy7OlYOa/U
	6Q9XG03ytaiB1lONDba9W8Zc7mLBPq/PPrhkfn+utAGS9bpwupr/J2zCwKIXYfJ50JBm4cdGXlTwn
	CIs6SfeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odECJ-00BwIk-Oo; Tue, 27 Sep 2022 17:16:43 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odECG-00BwHs-Qt
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 17:16:42 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220927171636epoutp01a0089e3aee459735b7a9b7d01c99ec13~Yxx6Rm1TJ0258602586epoutp01S
	for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 17:16:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220927171636epoutp01a0089e3aee459735b7a9b7d01c99ec13~Yxx6Rm1TJ0258602586epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664298996;
	bh=8NeCFH5VTrQKIuvJY9zqix/2t13zJTtcuTkMr6Kj2Ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLN6npjpEdlwItSRIDxKpBYBszBzzlSfhwxPZMA8JGeJjHEFRfe4OkNIu32eAo2w9
	 Aw575kmksXJwRxzvC74N5oV9GIIH6HLunlMMvhLr/xQOF96Kbr/cRbSy9Cg75m3TW2
	 Xg791yGp09sxkdYSwqQuDNkrbJyP1OlsIeWPYLfI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220927171635epcas5p127051bbbc2a950799e6c2979d482ff13~Yxx5U1o2g1818618186epcas5p16;
	Tue, 27 Sep 2022 17:16:35 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4McR9s3JN8z4x9Pt; Tue, 27 Sep
	2022 17:16:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0A.9D.39477.1FF23336; Wed, 28 Sep 2022 02:16:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220927171633epcas5p431ad5ec149a53b6a6ebf4b1cb44c4eb5~Yxx3Ir5dH2110621106epcas5p4F;
	Tue, 27 Sep 2022 17:16:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220927171633epsmtrp12c40e17bbd01e0ef17f302fb4cf2d77b~Yxx3IAfbQ0357603576epsmtrp12;
	Tue, 27 Sep 2022 17:16:33 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-b7-63332ff1bdcf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.C5.18644.0FF23336; Wed, 28 Sep 2022 02:16:32 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220927171631epsmtip2e73c4ad6fb46dc88fb1812f80207fd21~Yxx2A_pDN1608816088epsmtip2j;
	Tue, 27 Sep 2022 17:16:31 +0000 (GMT)
Date: Tue, 27 Sep 2022 22:36:44 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH for-next 2/2] nvme: Make CAP_SYS_ADMIN fine-granular
Message-ID: <20220927170644.GA3581@test-zns>
MIME-Version: 1.0
In-Reply-To: <d47c3ad1-d654-1500-b20d-adf6b7522677@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmhu5HfeNkgx2fRSxW3+1ns3h/8DGr
	xc0DO5ksVq4+ymQx6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	vc3v2Dz6tqxiDGCPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
	8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeX
	WmJlaGBgZApUmJCd8evRGeaCaUIVU++eZG1gnMnfxcjJISFgIjFry1f2LkYuDiGB3YwSR9c8
	YoVwPjFKXDnzjQ3C+cwoMeP1fRaYlvv9MxkhErsYJWZ+a4RynjFKTPz4AKiKg4NFQFWi+Xws
	iMkmoClxYXIpSK+IgJ7E1Vs3wNYxC3QxSbzdepUJpEZYwENi1/EqkBpeAR2Ju1d/skPYghIn
	Zz4B28spYCexe8dnsLiogLLEgW3HmUDmSAj0ckhsX/KXGWSOhICLxP73mhB3Cku8Or6FHcKW
	knjZ3wZlJ0tcmnmOCcIukXi85yCUbS/ReqofbAyzQIbEwtseIGFmAT6J3t9PmCCm80p0tAlB
	VCtK3Jv0lBXCFpd4OGMJlO0h8fHeOmZIgLxnlPjWO4FlAqPcLCTfzELYMAtsg5VE54cmVoiw
	tMTyfxwQpqbE+l36CxhZVzFKphYU56anFpsWGOWllsMjODk/dxMjOHlqee1gfPjgg94hRiYO
	xkOMEhzMSiK8v48aJgvxpiRWVqUW5ccXleakFh9iNAVGzURmKdHkfGD6ziuJNzSxNDAxMzMz
	sTQ2M1QS5108QytZSCA9sSQ1OzW1ILUIpo+Jg1OqgUnGTfC81tqLb58uqLpo03qN/2bfug3F
	d7ZKqVd4dwUqi+9f9Xv+jQP7BPl/cQlo/dVIrZiWs2jXntrrtYIKu02dfgufcTlwi+MTx71v
	U9dpMy9/e8vojZ/C6xfCz/17n725flHbLlW6Y13dz4ZL86YXL7IWnPErQODCqVP+Hboulhr1
	s4UXuHxo0ndINV2vrCi41PX5lXc3cp4vWBRzYbf95O/Mh///OPi7X2H6JF6mdx5Kdd42rbUi
	sgElv8xjTS4v1LrjtC7plU/ROuPNp0s/PQtPevlpzdzb3RvP/T2ieDJ969LZsYX32CwPR66U
	q9m8dEbP/4cyEpOWTX4Q+i9+66qK/b/iVt6Y6CCceX6eqBJLcUaioRZzUXEiAJQ0GR4nBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO4HfeNkg8Z/Zhar7/azWbw/+JjV
	4uaBnUwWK1cfZbKYdOgao8X8ZU/ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
	3uZ3bB59W1YxBrBHcdmkpOZklqUW6dslcGX0L1rPXnCCv+LuyeesDYxPeboYOTkkBEwk7vfP
	ZOxi5OIQEtjBKLHr7i1miIS4RPO1H+wQtrDEyn/P2SGKnjBKXFtwgamLkYODRUBVovl8LIjJ
	JqApcWFyKUi5iICexNVbN8DKmQV6mCR+HrrEDFIjLOAhset4FUgNr4COxN2rP6FGvmeU+NR8
	kQkiIShxcuYTFhCbWcBMYt7mh2C9zALSEsv/cYCEOQXsJHbv+Ax2mqiAssSBbceZJjAKzkLS
	PQtJ9yyE7gWMzKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJjQktrB+OeVR/0DjEy
	cTAeYpTgYFYS4f191DBZiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalF
	MFkmDk6pBqatBw0OXlix+JVb2OMPlxkzprCzrOjc/v/bt7f/Yx7seapY7j/l1L4tF9dwRJVs
	eKeZPa0nrd6rWIV3biJn9h6n6ydSr6yZzSf2kJnfRMZHqDBa+IKJf2Hp08iJxXZebxN2nYio
	cdVU//7v0HTlOSWLb/3YqLnNLWDHfJeP/uwMr7bmzIgPYGTWyLtY7b07LTppclv8UcYErYf1
	y7+4WnMz3PjSkPZp+e/A47tDOFfNvLzoXhn7ZsvGd6YfWntM8lQOl5aaXPCsTrkfoZo08Wys
	bvdUNXfbX4ZHG4M25Wt/mvL2zJHFM7rzpj3r7P8nt6Jt63oV8Zxl56f+zf3Ualy86cCfJZrS
	51buWevqLCqjxFKckWioxVxUnAgAOYTPZfgCAAA=
X-CMS-MailID: 20220927171633epcas5p431ad5ec149a53b6a6ebf4b1cb44c4eb5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_178ea_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c
References: <20220926145430.81658-1-joshi.k@samsung.com>
	<CGME20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c@epcas5p2.samsung.com>
	<20220926145430.81658-3-joshi.k@samsung.com>
	<d47c3ad1-d654-1500-b20d-adf6b7522677@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_101641_373599_8FBAD279 
X-CRM114-Status: GOOD (  20.32  )
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

------Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_178ea_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Sep 26, 2022 at 10:30:14PM +0000, Chaitanya Kulkarni wrote:
>On 9/26/22 07:54, Kanchan Joshi wrote:
>> Change all the callers of CAP_SYS_ADMIN to go through nvme_cmd_allowed
>> for any decision making.
>> Since file open mode is taken into consideration for any
>> approval/denial, change at various places to keep file-mode information
>> handy.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> ---
>>   drivers/nvme/host/ioctl.c | 70 +++++++++++++++++++++------------------
>>   1 file changed, 38 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> index 6ca6477dd899..4e53a01e702d 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -259,7 +259,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
>>   }
>>
>>   static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> -			struct nvme_passthru_cmd __user *ucmd)
>> +			struct nvme_passthru_cmd __user *ucmd, fmode_t mode)
>>   {
>>   	struct nvme_passthru_cmd cmd;
>>   	struct nvme_command c;
>> @@ -267,10 +267,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>   	u64 result;
>>   	int status;
>>
>> -	if (!capable(CAP_SYS_ADMIN))
>> -		return -EACCES;
>>   	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
>>   		return -EFAULT;
>> +	if (!nvme_cmd_allowed(ns, cmd.opcode, mode))
>> +		return -EACCES;
>
>you are chaning the order of the check CAP_SYS_ADMIN, unless there is a
>specific reason for it (that is not listed in the commit log) move
>nvme_cmd_allowed() where CAP_SYS_ADMIN is to retain the original
>behaviour which seems right since you are avoiding kernel copy in case
>cmds are not allowed.

cmd.opcode is required to make the decision making. So it cannot be
moved any up. 
User-space does not come to know whether error comes before/after
kernel-copy, so that part does not fall into behavior-change category.

------Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_178ea_
Content-Type: text/plain; charset="utf-8"


------Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_178ea_--

