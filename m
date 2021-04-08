Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29083C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:53:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70C161139
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70C161139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ukhgGFN+f4DH7tfdkQW+6NbPWRfknT7iC80piCAbcvc=; b=duAk+v41TtyuWtiQsHG0FLW8I
	a4ODiQbUWTND/HriN08SoxaiY7l5c+wsUZ5Af/b9wNKtM7u6273RX8qXERMSvnK++RkNK0zRwjIud
	q5JSQ2rpc3GzLVfAA16z2H4y0j+rej6W+C6KMmiAkLzz9qLEVRChlw/gSQqyCPIbdydCut7/QX8AK
	uEAqS8fV8EeFU6GDDt/FL5f1q2z/AlGwMwLlbbj+WcLD33E1KI5QpZ2LUctHsWWO82oalYcrLjh3d
	ThR68uwn8TCoyLR4aDU6Wa5JDzJQaFTij0NOThaBr6EyYWqIfYYoM9XBsaI8VuOoO57vBPsrFU6we
	qt2rnHiAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUPTF-007HFD-Cf; Thu, 08 Apr 2021 07:52:57 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUPT9-007HCa-F6
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 07:52:54 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210408075243epoutp01eab875f0d7d40ae67d40eda241962c12~z0rRSph7P1536415364epoutp011
 for <linux-nvme@lists.infradead.org>; Thu,  8 Apr 2021 07:52:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210408075243epoutp01eab875f0d7d40ae67d40eda241962c12~z0rRSph7P1536415364epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617868363;
 bh=YWEiwmlmwOGj27+L8xFslEhBe5wYosDd/rjYaPdULTk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JXHV6tiDezVT0siZQpN3jaNZw7CcH5PV9sV38/ckXgC7YhwDlfHobRpqxkA4sgyD7
 WHcALSIe9q1ze4y0Ova2nxiLVRHjpLxPGxwF3myRSAawEJaSD8pKEccQpjhbWN465I
 fQsfA4t6r5q6knSjqvp/ZrwYKdrMTVe6ieR0vqKs=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210408075242epcas5p245a548a9b90c09a7f4022b06551d891e~z0rQzdQJG0921209212epcas5p27;
 Thu,  8 Apr 2021 07:52:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 8F.70.15682.A46BE606; Thu,  8 Apr 2021 16:52:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210408075205epcas5p314456cfcffe8bbca80d8a6f4863423e4~z0quo61kQ0809108091epcas5p3n;
 Thu,  8 Apr 2021 07:52:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210408075205epsmtrp21d64fe102dc2fe24a3dd5a30c4ec6250~z0quoCMmA0817808178epsmtrp2f;
 Thu,  8 Apr 2021 07:52:05 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-c9-606eb64afb9c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 89.11.08745.526BE606; Thu,  8 Apr 2021 16:52:05 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20210408075204epsmtip1cdfae88a136135c7e30bbad96e7e0b38~z0qtEnT460086900869epsmtip1T;
 Thu,  8 Apr 2021 07:52:04 +0000 (GMT)
Date: Thu, 8 Apr 2021 13:21:26 +0530
From: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org,
 tasleson@redhat.com, tbzatek@redhat.com, prakash.v@samsung.com,
 d.palani@samsung.com, javier.gonz@samsung.com, k.jensen@samsung.com,
 mohit.kap@samsung.com, krish.reddy@samsung.com
Subject: Re: libnvme questions
Message-ID: <20210408075126.GC12847@test-zns>
MIME-Version: 1.0
In-Reply-To: <20210407233706.GB32309@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ977p7njrPHVfOpyBypjFPRevw2Mk/GxPwYs+noUbfq3O5K
 ZBZaQ6SIrc50pXS7suiutduVo8uvyI84mSVrhHDlOFJ+lLt7zua/1+f9+b4/v/YleRIjP4hU
 KDNYtVKeJhWI8MbWiLDZqxuViZF5hiBa2/UJp/u/9wjoNy9dBN12uJlPn7F1IrqivhqjddVv
 Cfpy3zTafvYij+549YKgy35/IZaNZYw1xwWMqSqH+Wx9JmBONdQg5uiNE1gCf5toURKbptjL
 qucsSRSltA3WYapaYt/Q/Vv4IaQX5CMhCdQ8ePfLxM9HIlJCNSEobGtAnoSE+orApE/iEi4E
 dbVlRD4ivQ6dGed0C4LSP3qCC965g9FRzOPGqelwxfEC8xgEVDT8yFvskf2padCtK/V241HD
 CKr7Or1j+FEh0F3/2N2ZIMXUbHBGelQxNQHaSntxDwupODA4O70c4C5zo/EO5ikDVAUJRZ+1
 iNsmDizWJxjHfvDxTgPBcRC4Bq4JOEMuAus3O84FRQjO6gZ8jqXQ0fzHyzwqBXRdAzinT4Zz
 9+p8+ngo+NXrey8Gc9k/DoU3j1t8Nw2G84avPp0BU55LwJ00FwNbvaoITdH+t532v3YcL4Dj
 ziN8rft2PHcp/QjJYQRcscwpR/waFMiqNOnJrCZGFaVks2QaebomU5ks27Un3Yi832pmvBl1
 9zhlNoSRyIaA5En9xeaC1ESJOEm+P5tV79mhzkxjNTYUTOLSiWJzZM8OCZUsz2BTWVbFqv9l
 MVIYdAiThG6xStpDhQm/O9aPJUtvXz52QDRhYXBM1k/dviqto0DaHMCED15QJKwZjY3pr3ho
 jY2DbS3xhlS+wRyQub1wRiUx7rpwMGpJ/NPWTtu3U7yp5bLTSYq7/hAOXa8rZ20+4PCvnbfl
 Q4h+uPfCq57AvtB+HI9e96VQJcu5Ld1pLHnvrLZkoxCd3y4mw1EfZrO3PioeOnldkZa+Qrt8
 9PmI4+Ykl3DqxvyWTbFbE41Zz5sq7f2TTPwpJVVrkz/pxu3ubloZPcxYNSERcnv7hvLiYFBa
 c67SuZHxZMmI5diPk9GBK8K2uuK04Q/m+x3MNs2dZYi4uWrnpXUfhvaOabdIcU2KPGomT62R
 /wVc0zHsxQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnK7qtrwEg4fX9S1m3X7NYvH26wM2
 i8d3PrNbnGzcw2ox6dA1RouFG5cxWcxf9pTdYs0LZYsrUxYxW1y8d5PdYt6fj+wO3B6bVnWy
 eWxeUu/xft9VNo++LasYPdoPdDMFsEZx2aSk5mSWpRbp2yVwZUz6v5il4C5LxefdbSwNjJ+Z
 uxg5OCQETCTm72DpYuTiEBLYwSjxq/kuWxcjJ1BcWmLfw+ssELawxMp/z9lBbCGBJ4wSz5/n
 gdgsAioS69/cZAKZwyZgJPG91RYkLCKgLHF3/kxWkJnMAj8ZJZa9uAY2U1hATuLuxguMXYzs
 HLwCuhIfDCDWNjNJ9P89zgpSwisgKHFy5hOwtcwCZhLzNj8EO5MZ6Jzl/zhAwpwCLhIrP1wD
 KxEFWnVg23GmCYyCs5B0z0LSPQuhewEj8ypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxN
 jOAY0dLawbhn1Qe9Q4xMHIyHGCU4mJVEeHf0ZicI8aYkVlalFuXHF5XmpBYfYpTmYFES573Q
 dTJeSCA9sSQ1OzW1ILUIJsvEwSnVwNTySbIzvKS0cs8FvyfFbvWWV91PVU8JMtsrHG5t0msX
 vP2mW0iM0u62vkNvY26zbOL/K3px+y71lNQny5X/yxhar/l7b8fNKbZdbA+kZj5doKnpt9lM
 7mTzv9NTX/zWnLDndF5C62rFssWr/eqvhP5i6rvTKe4a1nrd/9vtmzozKnc+i5tZ5Dh9ycHZ
 Yl9v6c7q6CtXmpG4LGjGw+RXS5d86xR5aTz//uaHHi9dvv1UPnD9YYRc9udeuyBX/pc3rOKY
 l9jIWrQ+mC0T9kjCePs1jdrlZlGhXU5/n84917BRrvJmu9m2218fZkR1WzfOuuvhwaG8tazL
 8ua/EHF17c/nsv5xPwj9HvmskP/2XVclluKMREMt5qLiRABjA+7BAAMAAA==
X-CMS-MailID: 20210408075205epcas5p314456cfcffe8bbca80d8a6f4863423e4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----rgEYhHy71ys_9Aik3zA05GggeZdzMrLcIo7_3H64ey3n7nJd=_5e9d5_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210407123854epcas5p48217db953741a57d651a8a8bf240ee23
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
 <20210407233706.GB32309@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_085252_171105_A8411E35 
X-CRM114-Status: GOOD (  14.23  )
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

------rgEYhHy71ys_9Aik3zA05GggeZdzMrLcIo7_3H64ey3n7nJd=_5e9d5_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Apr 08, 2021 at 08:37:06AM +0900, Keith Busch wrote:
>On Wed, Apr 07, 2021 at 06:08:06PM +0530, Padmakar Kalghatgi wrote:
>> Since most of the companies who develop SSDs, use MI(sideband) channel, we think this will be a good enhancement to the existing functionality which the nvme-cli provides.
>
>Can we even use this from a Linux host? I thought the sideband channel
>was typically connected to the baseboard management controller.
>
Yes, this can be used from Linux host by having additional hardwares, like TotalPhase's aardvark, Corelis etc, which are connected to the NVMe device.

------rgEYhHy71ys_9Aik3zA05GggeZdzMrLcIo7_3H64ey3n7nJd=_5e9d5_
Content-Type: text/plain; charset="utf-8"


------rgEYhHy71ys_9Aik3zA05GggeZdzMrLcIo7_3H64ey3n7nJd=_5e9d5_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

------rgEYhHy71ys_9Aik3zA05GggeZdzMrLcIo7_3H64ey3n7nJd=_5e9d5_--

