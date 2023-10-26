Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481FAC25B48
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ctyt4d/NMltHT38aBmzaQgfUW3F1tK8lJruLVMxhZSw=; b=pHUPRmRI7iDpbQOPRp/FZw8XRl
	xqPmjYlnxQXRjfZND68FpQPTxyTlMOHfXGpSB90noqJhquVPlvwzdQczsU492oiIqjW35JrRP5QTG
	XvWoRlj4Q3/I06ZCPIpGMF77rhakhY7vcd6doxSuiwJRWPTxmHirmNA+9rNyOBmq3xrjSuQv6ec7S
	JaD+f7Lj+On/fJ6vQlQANgO71jrXL3cPlVP17t4cfx5+ZtQVSHne8ZKwFpBLLIww1iiXNB+m6BmnZ
	9dhtsJYTMSFwvUhRIEtjtIygLPlQGTk2dyVTP2TAbcuOz0rpbRTw5rr2FH/cuPCzRel3od/T9IVUo
	hYXwZuuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1Ot-00Egha-1z;
	Thu, 26 Oct 2023 14:31:55 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1Ok-00EgZy-0K
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 14:31:47 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231026143140epoutp0396e90d261840b404b552b25addb5a685~RrsY-W0vV1264912649epoutp03L
	for <linux-nvme@lists.infradead.org>; Thu, 26 Oct 2023 14:31:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231026143140epoutp0396e90d261840b404b552b25addb5a685~RrsY-W0vV1264912649epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698330701;
	bh=Ctyt4d/NMltHT38aBmzaQgfUW3F1tK8lJruLVMxhZSw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LqmEvSrt1ngM5ahc8Bjde7v5EaJ/bUOn0vlvNLQyb+pnd6tXftlGPvPyLxRhruKDF
	 VCcTeyMzcRjfsavQAaldtMcIKozwQB/eIT+w5LkjEUWsphTH+k/Zrw7XPJjQ6SGjjM
	 SyoYMnmfSIbhDQp0rgwvY2HYqL3jiQJ9/6pqkTU4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231026143140epcas5p1dc99dc1635459de9745fffcb1735a6f6~RrsYzU6RB2361723617epcas5p1j;
	Thu, 26 Oct 2023 14:31:40 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SGSsl1Fftz4x9Pp; Thu, 26 Oct
	2023 14:31:39 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.F4.08567.B487A356; Thu, 26 Oct 2023 23:31:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231026143138epcas5p2eb370a908db53eeb21ef6fb38005d2ef~RrsXBSZ6C0390803908epcas5p2t;
	Thu, 26 Oct 2023 14:31:38 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231026143138epsmtrp2c0bf9be65d255907dabe554e1af500dc~RrsXAoghZ2591625916epsmtrp2U;
	Thu, 26 Oct 2023 14:31:38 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-4f-653a784bed09
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.A8.07368.A487A356; Thu, 26 Oct 2023 23:31:38 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231026143137epsmtip2bf0b9949844f69c207a78db708cbcbd1~RrsVxOqpz2163321633epsmtip2x;
	Thu, 26 Oct 2023 14:31:37 +0000 (GMT)
Message-ID: <d3a0c5ff-8d10-aa8f-cfce-a87a09f880c3@samsung.com>
Date: Thu, 26 Oct 2023 20:01:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, vincentfu@gmail.com, stable@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231024070759.GE9847@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmhq53hVWqwYWdrBar7/azWdw8sJPJ
	YuXqo0wWkw5dY7SYv+wpu8W61+9ZLBZsfMRosaFN0IHDY+esu+we5+9tZPG4fLbUY9OqTjaP
	zUvqPXbfbGDz6NuyitHj8ya5AI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
	JYW8xNxUWyUXnwBdt8wcoLuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrF
	ibnFpXnpenmpJVaGBgZGpkCFCdkZWzafYyzYzVFxa/tmpgbGW2xdjJwcEgImEquOXGIGsYUE
	djNKbL+h3cXIBWR/YpRYOredCSLxjVGieYoITMOKvhvsEEV7GSUubtnECOG8ZZTYP/s12Fhe
	ATuJcz9ng3WzCKhKdC+4zwwRF5Q4OfMJC4gtKpAk8evqHEYQW1jAVeLZrBawOLOAuMStJ/PB
	ekUEnCW+fr7KBLKAWaCLUeLwy5esXYwcHGwCmhIXJpeC1HAKaEusebWEEaJXXmL72znMIPUS
	Ags5JO4vnw31p4vEhhWfmCBsYYlXx7ewQ9hSEp/f7YWqSZa4NPMcVE2JxOM9B6Fse4nWU/3M
	IHuZgfau36UPsYtPovf3EyaQsIQAr0RHmxBEtaLEvUlPWSFscYmHM5ZA2R4S7U1zoGHVyCxx
	9s0WxgmMCrOQgmUWkvdnIXlnFsLmBYwsqxglUwuKc9NTk00LDPNSy+HxnZyfu4kRnGq1XHYw
	3pj/T+8QIxMH4yFGCQ5mJRHeSB+LVCHelMTKqtSi/Pii0pzU4kOMpsD4mcgsJZqcD0z2eSXx
	hiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1MB07LtphI9ltw98wRV2I
	W1368r2qI25+LbaczG9STweWRz/e2H1UdvLWY9cfGvPMmdSe97vhw5S+v1wlL7ZHbYy174tc
	9+yh2SbOj0vmtTVGz1509szH+NrXkx+s9suokavVObJu3/FXvLcOtb3r/rf7dkHa/Q8dZk3N
	C9xfBmVI8zPxvN86N+HF4yf2Nw+euHK5aiqf3ZSEpQumWUjOeHJBoGkXY4r8Agdun2kiL86t
	Z9UTa4oKeb745coTqjs4vduPT9IWdhObYn2j5639p0Xc186V9wvbr+PcUH6YKe5Z8SnBsAnh
	P1/dfNtj+dy5p98lw0J8rkWNOrvntcz+h389Ht7fufZ8RZDHKrmWk1+VWIozEg21mIuKEwGH
	JDR0PgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXterwirV4O90HYvVd/vZLG4e2Mlk
	sXL1USaLSYeuMVrMX/aU3WLd6/csFgs2PmK02NAm6MDhsXPWXXaP8/c2snhcPlvqsWlVJ5vH
	5iX1HrtvNrB59G1ZxejxeZNcAEcUl01Kak5mWWqRvl0CV8aWzecYC3ZzVNzavpmpgfEWWxcj
	J4eEgInEir4b7F2MXBxCArsZJfYvnM4CkRCXaL72gx3CFpZY+e85VNFrRokHD54wgSR4Bewk
	zv2cDWazCKhKdC+4zwwRF5Q4OfMJ2CBRgSSJPfcbwWqEBVwlns1qAYszAy249WQ+WFxEwFni
	6+erTCALmAW6GCW+t81ng9jWyCzx8OMaoA4ODjYBTYkLk0tBGjgFtCXWvFrCCDHITKJraxeU
	LS+x/e0c5gmMQrOQ3DELyb5ZSFpmIWlZwMiyilEytaA4Nz032bDAMC+1XK84Mbe4NC9dLzk/
	dxMjOLa0NHYw3pv/T+8QIxMH4yFGCQ5mJRHeSB+LVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	hjNmpwgJpCeWpGanphakFsFkmTg4pRqYDHX6OC8+fs8r5soQHWjSs/MaQ0xU9GPXPJW8oqw+
	lqz9ibs+qHeaJc2f4ebpGq/iE5Dxdo3+rqPffgtHXDq05PMy9jNCl9ftLH7yKX8Bp9OiEzy3
	Fb/s4V+5SdblpOHTtJsCPc0ZXIfjvLdUJ4aYXOI+sXp6X/5FEZOoZ2mcLN13HvQnH1MrunW4
	7diUoJB1V8Mkk29nRkp0f5i/SHgOW19nEOPOWeePSAnIph3YcD/xb98Hrryq12+Y5jAuKJ4u
	xDBr3+z96yPen/1cW/dq7WyfB/4dXzIXqHG5+qiv2VX2ju/vOqXbS+RyGTq1X5/6kefq81P6
	UPib3Usr6hnVH7P4X4vbPCFng13WCQtfJZbijERDLeai4kQAjiFb9BwDAAA=
X-CMS-MailID: 20231026143138epcas5p2eb370a908db53eeb21ef6fb38005d2ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231016061151epcas5p1a0e18162b362ffbea754157e99f88995
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
	<20231016060519.231880-1-joshi.k@samsung.com>
	<ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
	<ZTBNfDzxD3D8loMm@kbusch-mbp> <20231019050411.GA14044@lst.de>
	<ZTKN7f7kzydfiwb2@kbusch-mbp> <20231023054456.GB11272@lst.de>
	<ZTaOzORdmFwxCW1c@kbusch-mbp> <20231024070759.GE9847@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_073146_503449_D7FF286F 
X-CRM114-Status: GOOD (  15.73  )
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

On 10/24/2023 12:37 PM, Christoph Hellwig wrote:
> On Mon, Oct 23, 2023 at 09:18:36AM -0600, Keith Busch wrote:
>> On Mon, Oct 23, 2023 at 07:44:56AM +0200, Christoph Hellwig wrote:
>>> Yes, you need someone with root access to change the device node
>>> persmissions.  But we allowed that under the assumption it is safe
>>> to do so, which it turns out it is not.
>>
>> Okay, iiuc, while we have to opt-in to allow this hole, we need another
>> option for users to set to allow this usage because it's not safe.
>>
>> Here are two options I have considered for unpriveledged access, please
>> let me know if you have others or thoughts.
>>
>>    Restrict access for processes with CAP_SYS_RAWIO, which can be granted
>>    to non-root users. This cap is already used in scsi subsystem, too.
> 
> Well, that's sensible in general.

With that someone needs to make each binary (that wants to use 
passthrough) capability-aware by doing:

setcap "CAP_SYS_RAWIO=ep" <binary>

Seems extra work for admins (or distros if they need to ship the binary 
that way).

