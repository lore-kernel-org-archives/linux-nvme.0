Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00549C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jdYsabMia+92xH4QGqS/qMyec4KFNU8G+sowHKRQmi0=; b=1ay+HzxtRQdaqvkQWYZGHF3f4M
	j4/JgO88vVtnvhLa8yGBUfVJmua5NBR0FfYaP/wO2BSvn9r9hAp286WueXVFrqlXdWpMbmv6i7v5S
	9IQnhcWXjxCT9vW1zbfsIYch1irOrECfUvCpFQyqfKJ8n/bM6mF9pSE5p2ll49NK67V8u13Xu1kUJ
	q5P67FrA3zpfreP52/4PUUfEnRCWIKrsduSYfaoqSDzlSIvWVHPl3/J9YxeFuVh+B5XhCo6rUCRHv
	F4SPcp/4tfWKEErGddNs67onj0170tyt7zCSb3Xfy5iO5U0bearYKSd2sWBoeKcrjSPWVKjztDYv6
	eNQcpxag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nryFk-00BLmW-Kf; Fri, 20 May 2022 08:44:56 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nryFh-00BLlb-GW
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 08:44:55 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220520084450epoutp0498dad8e30931f8517bcbf08763556fdd~ww79prTUp0897408974epoutp04j
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 08:44:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220520084450epoutp0498dad8e30931f8517bcbf08763556fdd~ww79prTUp0897408974epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653036290;
 bh=jdYsabMia+92xH4QGqS/qMyec4KFNU8G+sowHKRQmi0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jicaUWqG+gGLNasyEVpx7G8COGHAL6+IhAiN2WVYzusENihhEsWJdCL3BAi2E04mH
 ChWQgn+MFCESuAEOa54hko8341AynbPeQpg6hwQ/u+IsN2Mg4lZdhb8SnbEz51nD0x
 fntL4q6zlGlIYAo9lrKr+KorFIPEchODNKSv2mi0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220520084449epcas5p431dda6a17a417e1969da7e2e9a5c0356~ww78tK88z0942309423epcas5p49;
 Fri, 20 May 2022 08:44:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4L4KzK3j0jz4x9Q8; Fri, 20 May
 2022 08:44:45 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 41.35.09762.AF457826; Fri, 20 May 2022 17:44:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220520082648epcas5p4d4826c44628305891f92987132dc9aba~wwsOCz2Xn2581825818epcas5p4F;
 Fri, 20 May 2022 08:26:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220520082648epsmtrp2b14a0ed235771f089d12c558a8545c9b~wwsOCNyIe0321503215epsmtrp2P;
 Fri, 20 May 2022 08:26:48 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-a6-628754fa24ac
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 C1.37.08924.8C057826; Fri, 20 May 2022 17:26:48 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220520082647epsmtip2ee72fc8a0044c463b1462d15d252e58e~wwsNDRgfo2437824378epsmtip2w;
 Fri, 20 May 2022 08:26:47 +0000 (GMT)
Date: Fri, 20 May 2022 13:51:34 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
 gost.dev@samsung.com, joshiiitr@gmail.com
Subject: Re: [PATCH v2 0/2] uring-passthrough for admin commands
Message-ID: <20220520082134.GA28050@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220520060143.GA16433@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmuu6vkPYkg/WzzC1W3+1ns7h5YCeT
 xcrVR5kszr89zGQx6dA1Rov5y56yO7B57Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNo2/LKsYA
 tqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
 yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ
 2RktS/axFkziqTjbmdjA+ISzi5GTQ0LAROL03e8sXYxcHEICuxklTj2+wwySEBL4xCix91Uq
 hP2ZUWLf7fouRg6whhuvVSHqdzFKfDy/mBXCecYosfHbBXaQBhYBVYmnnU/YQBrYBDQlLkwu
 BQmLCChJPH11lhHEZhYolljf8psFxBYWcJCYdfAi2F5eAV2J+7u6mSBsQYmTM5+A1XAK6Eh8
 +L4RrFdUQFniwLbjTCB7JQQaOSReXl7PBPGNi8SWVRdZIGxhiVfHt7BD2FISn9/tZYOwkyVa
 t19mh3imRGLJAnWIsL3ExT1/mSBuS5fYePsV1BhZiamn1kHF+SR6fz+BWsUrsWMejK0ocW/S
 U1YIW1zi4YwlULaHxNIzL5gh4bOaUeLtlv3MExjlZyH5bRaSfRC2lUTnhybWWUDnMQtISyz/
 xwFhakqs36W/gJF1FaNkakFxbnpqsWmBcV5qOTyyk/NzNzGCE6iW9w7GRw8+6B1iZOJgPMQo
 wcGsJMLLmNuSJMSbklhZlVqUH19UmpNafIjRFBhVE5mlRJPzgSk8ryTe0MTSwMTMzMzE0tjM
 UEmcV+B/Y5KQQHpiSWp2ampBahFMHxMHp1QDkxrH243Sc/eGJfRoxu+d0mhWkR7x4SiXzaPm
 1OMSV9T3iaV/s45KOlAveTGJ+VTXnqcV4XnKbkqxEhJrE/VzxXwv2k583x7fetv+T5am053g
 I292uojOOf9LhD3skMOa3ORXd1vESz2c6gU+8t19GNsjmHlJw6WusUa54Fv+NfPu6uSGt7OX
 1Mrkix11WVIyrzR3665wl9/Gq+IWVWTtbX3yK8q8f87JmGBrj7O2Nz9/Ew300m4+tfdcbcnh
 vE3zL53QPJokH6V0s/if38Ef9YznDmspV5k1Ga54E8updvrsuc1W9XbJ9hsT3uquPzNpz+mU
 auNVO3YbWdiebnA/de8CZ9bJa9dvXp9zvKRRiaU4I9FQi7moOBEA1Rh1DCkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSvO6JgPYkgx1XOSxW3+1ns7h5YCeT
 xcrVR5kszr89zGQx6dA1Rov5y56yO7B57Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNo2/LKsYA
 tigum5TUnMyy1CJ9uwSujF33XrEUHOeseLnmI3MD42b2LkYODgkBE4kbr1W7GLk4hAR2MEp8
 nXKPrYuREyguLtF87Qc7hC0ssfLfczBbSOAJo8Tes54gNouAqsTTzidsIHPYBDQlLkwuBQmL
 CChJPH11lhHEZhYolljf8psFxBYWcJCYdfAiM4jNK6ArcX9XNxPEyLWMElOXx0HEBSVOznzC
 AtFrJjFv80NmkPHMAtISy/9xgIQ5BXQkPnzfCDZeVEBZ4sC240wTGAVnIemehaR7FkL3Akbm
 VYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwaGvpbWDcc+qD3qHGJk4GA8xSnAwK4nw
 Mua2JAnxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXA5HF8
 v/vcJ7uPpB+57fm0IODrVPXOoI/n8u6u3HiD8c1di/7gpa+LGya8/Gqp2XZPx7M0jfnhcUYn
 mYJfvWY/Hm1/4eo/f5bV9IxXLlu+lruLXA9+MmtD0PrqlMyHMYpxD4omHUvMDX/sqmu4ZZc4
 1yzTbZ+TO14+MjO2T9s75+cFpz1/ra5cubFSbMWNjayqi3Xez5RJYxD23f5uZpmx85YV6yT0
 Cr0ntMeHlKUu9nM/FWO4a69M88b31stb5nPd+7Sz4sFGx8VvTl5zZPPhycwJu6Zg3fErccqC
 q5b8ra47jtc9lzsnFVO1Wuv5h+JnbxSEFu8++m9thf/rhX7uUfzn2+w3qzycNltA3eKq5UEl
 luKMREMt5qLiRADUh8Rr7AIAAA==
X-CMS-MailID: 20220520082648epcas5p4d4826c44628305891f92987132dc9aba
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----OaRT8jiSLvKUs3WAABZSk-FavpLm249Qe.Imk-d4uY-X0TwC=_5c57_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520050118epcas5p1f6a930419285ecdac65afaa22255c03f
References: <CGME20220520050118epcas5p1f6a930419285ecdac65afaa22255c03f@epcas5p1.samsung.com>
 <20220520045600.3773-1-joshi.k@samsung.com> <20220520060143.GA16433@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_014454_294691_58B647CC 
X-CRM114-Status: GOOD (  15.28  )
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

------OaRT8jiSLvKUs3WAABZSk-FavpLm249Qe.Imk-d4uY-X0TwC=_5c57_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, May 20, 2022 at 08:01:43AM +0200, Christoph Hellwig wrote:
>On Fri, May 20, 2022 at 10:25:58AM +0530, Kanchan Joshi wrote:
>> The series enables uring-passthrough for admin-commands.
>>
>> Patch 1 is prep.
>> Patch 2 adds new opcode for admin uring-passthrough, and enables it on
>> nvme controller dev(/dev/nvmeX). It reuses the code of io-command
>> passthrough, with the only difference that commands are issued on admin
>> queue.
>
>Looks good:
>
>Reviewed-by: Christoph Hellwig <hch@lst.de>
>
>Can we add vectored admin commands as well, please?  We basically
>get them for free, so I see no reason not to add them.

Sure. By free, you mean this I suppose: 

--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -699,6 +699,9 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
        case NVME_URING_CMD_ADMIN:
                ret = nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, false);
                break;
+       case NVME_URING_CMD_ADMIN_VEC:
+               ret = nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, true);
+               break;

anything else? I will fold this in, and submit v3 before Jens takes a
look.

------OaRT8jiSLvKUs3WAABZSk-FavpLm249Qe.Imk-d4uY-X0TwC=_5c57_
Content-Type: text/plain; charset="utf-8"


------OaRT8jiSLvKUs3WAABZSk-FavpLm249Qe.Imk-d4uY-X0TwC=_5c57_--

