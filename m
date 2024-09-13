Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0274EEE26C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=ELbGSOq1s+pDnpQCfhL3FUj461
	3fTqTDvDV55tsKeSL8f/7XjQl0ZBLncVB1t2xp6NldXma0Q0okyeQafJ9IYRPK5/Xrk6HxhKZDT9u
	cGusl165ot003eGMeMOy49/HZd75AvC+NYmgCHWB2LwhURVJThfGyMtCgp5mxLFjhf1QMgV4otTkJ
	DXD3DZUG8saGcFbfS/ZUcl8KtrM5d2khUwCLEizVBz8XOKOnNpXqvk2tPrTzhe1T2x74tYU5iiC+6
	8/cX7XiPR5sUd3pcCFlOq5zrxahJl98LASnzVK7Bs+amCAYCaXbl62U1RHqTXX+wItwl0Utsnq742
	imHUXCkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5YO-0000000FvdJ-2piN;
	Fri, 13 Sep 2024 12:37:36 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5YA-0000000FvXs-3wMl
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 12:37:24 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240913123718epoutp03cf75c56adc6dfe7180cbabe694bf6697~0zfviCUo53071630716epoutp03-
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 12:37:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240913123718epoutp03cf75c56adc6dfe7180cbabe694bf6697~0zfviCUo53071630716epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726231038;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kG9oXzm3h91mJUYHnhAqwKdXXPT1vr1iahXUaX9cKza0wXX8TIN/yXFu+YVFAzHkm
	 dgF84jQjL/k28sg4TfuGZmAsKMNfIBYQ7Uxnvlgd5AYocQSy1fbtp+bs2M7hnuxlJo
	 0vPN/Q4w3TWzhkSKt+y1dOsVOaEYnIo8v8QUS7PY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240913123718epcas5p37b7b9498a251b23c18ae2be23c5d49b3~0zfu2saAe2105321053epcas5p39;
	Fri, 13 Sep 2024 12:37:18 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X4v2h6Xz9z4x9Pw; Fri, 13 Sep
	2024 12:37:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9C.C4.19863.CF134E66; Fri, 13 Sep 2024 21:37:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240913123716epcas5p3d4b78a180b6aaa94a56022abc138f850~0zftIIuDp2105321053epcas5p33;
	Fri, 13 Sep 2024 12:37:16 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240913123716epsmtrp15585570f7957e30ee88d6806c30acdbb~0zftHbatx1470714707epsmtrp1e;
	Fri, 13 Sep 2024 12:37:16 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-f8-66e431fc2557
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.0E.07567.CF134E66; Fri, 13 Sep 2024 21:37:16 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240913123714epsmtip1b1f382043164a354f15901bc16cd4c24~0zfrXHB_H3163131631epsmtip1N;
	Fri, 13 Sep 2024 12:37:14 +0000 (GMT)
Message-ID: <443db159-684a-9b0e-7b05-ccfa9de2e032@samsung.com>
Date: Fri, 13 Sep 2024 18:07:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCHv4 08/10] nvme-rdma: use request helper to get integrity
 segments
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240911201240.3982856-9-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmlu4fwydpBg//GFusvtvPZrFy9VEm
	i0mHrjFanLm6kMVi7y1ti/nLnrJbdF/fwWax/Pg/Jot1r9+zOHB6nL+3kcXj8tlSj02rOtk8
	Ni+p99h9s4HN49zFCo+PT2+xeHzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCo
	a2hpYa6kkJeYm2qr5OIToOuWmQN0m5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWn
	wKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PUjqVMBUYV1+b2MTUw6nYxcnJICJhI9BztY+5i
	5OIQEtjDKDHj9EpGCOcTo8TE1h0sEM43RolDv++ywbQcWHCaFSKxl1Fi4dY/UFVvGSU+vuwG
	q+IVsJPoefOfFcRmEVCVeP9qDStEXFDi5MwnLCC2qECSxK+rcxhBbGGBMImF19uYQWxmAXGJ
	W0/mM4EMFRE4ySixY8JVRoiEskRnz0f2LkYODjYBTYkLk0tBwpwC5hJHFt1lgSiRl9j+dg7Y
	QxICSzkk9hxezAhxtovE5wXtTBC2sMSr41vYIWwpiZf9bVB2tsSDRw9YIOwaiR2b+1ghbHuJ
	hj83WEH2MgPtXb9LH2IXn0Tv7ydMIGEJAV6JjjYhiGpFiXuTnkJ1iks8nLEEyvaQeH/6LDR4
	tzNKvHu2nXECo8IspGCZheT9WUjemYWweQEjyypGqdSC4tz01GTTAkPdvNRyeIQn5+duYgQn
	Xa2AHYyrN/zVO8TIxMF4iFGCg1lJhHcS26M0Id6UxMqq1KL8+KLSnNTiQ4ymwAiayCwlmpwP
	TPt5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwGUj8S/lQ9v3Z
	hqWbz69/9ao4veSHvuahzU1/zq0LWNCu8Mf0+tJjU/b3zgnnNLt07LlKwTvvf3MVAtwWa85b
	bPFjW+G9Zccz+9XDVnlm/vWdcnXvlIYX556mJ2y565h+1Enmkg77rnoBA98l7tfmBWpK6H5d
	JHl/afACif4vW5N7Hm6w/T+VW7ZnmlGoyszszO4tFm91l//dnj399tQQswUdij4+p87M6fn2
	fGf+t5P997/qramdwuZR01z2/crtv1ub12+xesuV+dt6Ycv8i3Eb3EszRFp8LtgcCRA7Jn2f
	IWzZe4Ej3WH7VWssz+h2W/lXhd1ierhbjO/+ZJvnS+un/c/6F5d/dmEh85P3dtOUWIozEg21
	mIuKEwGdr6YOQwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTveP4ZM0g0kXuSxW3+1ns1i5+iiT
	xaRD1xgtzlxdyGKx95a2xfxlT9ktuq/vYLNYfvwfk8W61+9ZHDg9zt/byOJx+Wypx6ZVnWwe
	m5fUe+y+2cDmce5ihcfHp7dYPD5vkgvgiOKySUnNySxLLdK3S+DKOLVjKVOBUcW1uX1MDYy6
	XYycHBICJhIHFpxm7WLk4hAS2M0ocX7+TxaIhLhE87Uf7BC2sMTKf8/ZIYpeM0pM3H6HFSTB
	K2An0fPmP5jNIqAq8f7VGqi4oMTJmU/ABokKJEnsud/IBGILC4RJLLzexgxiMwMtuPVkPhPI
	UBGBk4wSz758Y4JIKEt09nyE2radUWLxoXVAUzk42AQ0JS5MLgWp4RQwlziy6C4LRL2ZRNfW
	LkYIW15i+9s5zBMYhWYhuWMWkn2zkLTMQtKygJFlFaNkakFxbnpusmGBYV5quV5xYm5xaV66
	XnJ+7iZGcHxpaexgvDf/n94hRiYOxkOMEhzMSiK8k9gepQnxpiRWVqUW5ccXleakFh9ilOZg
	URLnNZwxO0VIID2xJDU7NbUgtQgmy8TBKdXAJHhKs0U/0HKq55qHKlLrQ2ufr1C9/N1w60pX
	Z8NiqRo3R6k9P5tOTfzCYZ93VCGSuUzqsCnz/Pl3n1Zan9V6EVqVsd7hY15Irqz1Ya290wTT
	tkQdONR++qStBccx55a9k1X/fl4yTT21kGW91uz0WXuNNjIKVjz/yXj/xmSZ9JhfKXekFI7u
	ZGUz2coVGP8nX3Hmx5hig83b0y8UFfK1H7vGOOWO9/PismXH62KEJEzdH5jOnLKId+qTtSv3
	vZbcefTN0muM/f+bb9mYb1zplXREvVb7P2symx2b4boHpqsemC1dxGzes15C4uphp0/BTre3
	iXiXtO8TE37gM6dr2wo5i6duGbdSbJ5WyteKKbEUZyQaajEXFScCAB9Jg5oeAwAA
X-CMS-MailID: 20240913123716epcas5p3d4b78a180b6aaa94a56022abc138f850
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911201416epcas5p437d397b7ad0e863b4cf334d864db199c
References: <20240911201240.3982856-1-kbusch@meta.com>
	<CGME20240911201416epcas5p437d397b7ad0e863b4cf334d864db199c@epcas5p4.samsung.com>
	<20240911201240.3982856-9-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_053723_324125_F9ABC172 
X-CRM114-Status: UNSURE (   6.39  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

