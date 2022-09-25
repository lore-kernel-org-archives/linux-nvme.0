Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AA1C54EE9
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Sep 2022 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cRqTry9gBIs8cPHfZabgzJB2qSu4QWaLHvmNNVi1nwo=; b=Ikmci8fmCNrAGmhabfRbWMp0fR
	mMGJ6X9+ppyayy2E7gYDriYWU2J0kmozAKN4N5mJnkcu9XGg7uAN6LyvgAsO4spH026/M8ZBzrRJj
	to+x6RsjDHwaSXZ41lD0UTO2fBawhILLcYhJdBt/DHLvx3b1X2afeFPRPZTY0rzNOuzq52rVrUI4c
	sVT90wQYSzPcg+RHLjRPFBQ7wkZyeyvbU0kaBivva4fHPTMLXQG4ODDcTfTk8NNlnSg4oBNHt9p35
	an6X/iE7UbIp8tqe4zpskVKMKR8Bew/ktjYFzxs3wWrcmBDuUb5xsODniDkncIKrzArMhNa8U5JsH
	/Be55iJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocW1K-00FZTe-9K; Sun, 25 Sep 2022 18:06:26 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocW1G-00FZQD-E9
	for linux-nvme@lists.infradead.org; Sun, 25 Sep 2022 18:06:24 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220925180618epoutp0414473fec284ead579f43668d9f31ceb3~YLKvDXWnY0162601626epoutp04L
	for <linux-nvme@lists.infradead.org>; Sun, 25 Sep 2022 18:06:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220925180618epoutp0414473fec284ead579f43668d9f31ceb3~YLKvDXWnY0162601626epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664129178;
	bh=cRqTry9gBIs8cPHfZabgzJB2qSu4QWaLHvmNNVi1nwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iBVFrwURxQbNQb7+TdLE8L2OyzQ7HDxMZ7koGBOgMwu96755IASgPq6K8R4oKu/+c
	 ABBHfyNK2sZ/ZPIdVAZ1yYGNU2a9qAtWUOEVXqJjJZez3T1HnMTQjckqg/BT8FowXX
	 0dzVmWd5m02gFUDGW1ePXrq3u/1zcbSm2+DOo/bs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220925180617epcas5p2e7d2e826fbe31163b10c7979d81d1eca~YLKugeBf42635426354epcas5p2F;
	Sun, 25 Sep 2022 18:06:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MbDN73LKDz4x9Pt; Sun, 25 Sep
	2022 18:06:15 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.CC.39477.79890336; Mon, 26 Sep 2022 03:06:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220925180615epcas5p415fb08b7a431281a678311ff41540765~YLKr0umQw1750217502epcas5p4I;
	Sun, 25 Sep 2022 18:06:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220925180615epsmtrp2c20e2498ccf924c10b91728cdfa54c3f~YLKr0ABad2897328973epsmtrp26;
	Sun, 25 Sep 2022 18:06:15 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-01-6330989710cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.1F.14392.69890336; Mon, 26 Sep 2022 03:06:14 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220925180613epsmtip1fc51fec7fd5af380c5d570b1039d0f2a~YLKqRJKWF1010510105epsmtip1c;
	Sun, 25 Sep 2022 18:06:13 +0000 (GMT)
Date: Sun, 25 Sep 2022 23:26:25 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@lst.de, kbusch@kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v8 0/5] fixed-buffer for uring-cmd/passthru
Message-ID: <20220925175625.GC6320@test-zns>
MIME-Version: 1.0
In-Reply-To: <c9750503-b16b-a756-b3e3-c9dfa0c482c3@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmhu70GQbJBt3PRCxW3+1ns7h5YCeT
	xcrVR5ks3rWeY7GYdOgao8XeW9oW85c9ZXdg97h8ttRj06pONo/NS+o9dt9sYPPo27KK0ePz
	JrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
	Q5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkam
	QIUJ2RnnPsxlKjjLVdF98RBTA2MjZxcjJ4eEgInEtKXT2UBsIYHdjBKvZ3p1MXIB2Z8YJSbO
	3sYK4XxjlHj0fQc7TMedj/PYIBJ7GSXuXfvHDOE8Y5T4Ou09C0gVi4CqxLLzc4ASHBxsApoS
	FyaXgoRFBBQken6vBGtmFpjEKPF87W+wemEBD4nuldsYQWxeAR2JJQc/QNmCEidnPgGr4RSw
	lZh2uocVxBYVUJY4sO04E8ggCYG/7BIznn1khTjPReL0pyVMELawxKvjW6DOlpL4/G4vG4Sd
	LHFp5jmomhKJx3sOQtn2Eq2n+plBbGaBdInHjbtZIGw+id7fT5hAnpEQ4JXoaBOCKFeUuDfp
	KdRacYmHM5ZA2R4Sf7evZocEyj5GiTuTtrNPYJSbheSfWUhWQNhWEp0fmlhnAa1gFpCWWP6P
	A8LUlFi/S38BI+sqRsnUguLc9NRi0wKjvNRyeCQn5+duYgSnTS2vHYwPH3zQO8TIxMF4iFGC
	g1lJhDflom6yEG9KYmVValF+fFFpTmrxIUZTYPxMZJYSTc4HJu68knhDE0sDEzMzMxNLYzND
	JXHexTO0koUE0hNLUrNTUwtSi2D6mDg4pRqYuIWaZr6SPF20amfNifS6K32S8+Tf35r2ks14
	f1a1iziLAVPvf5f06KOVz0W9zZ33rl/KfcWl8EFX7/zPTMluYd7vgo+6ZP5Zlv9c3aJnscaq
	1xMPa622U++7Vik/M7dw0+aAtGdWqdfL318NWsnoqZz5sOiZ0WmTqGMHG45M8in8JV9tZtPb
	LfHEi6P1xpFLytt1D+3MuC/UOGWdbFBn6QOhkoaVGQaPTab46wgabfT8K1EftMaQSfPfwQ6F
	PUftNil7nT69+dwzHttP/25EiWy8xuVZu4dFKcPPfM8FaR/LHxM+npHb+3L34hCmgLteN6ND
	MnbrXeSTCQs03u1g4Xb4dcQVO0txtvQzxfVKLMUZiYZazEXFiQCVWlEjJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnO60GQbJBnunW1msvtvPZnHzwE4m
	i5WrjzJZvGs9x2Ix6dA1Rou9t7Qt5i97yu7A7nH5bKnHplWdbB6bl9R77L7ZwObRt2UVo8fn
	TXIBbFFcNimpOZllqUX6dglcGf+2X2MqaOKouPtLv4HxAlsXIyeHhICJxJ2P88BsIYHdjBKH
	7phDxMUlmq/9YIewhSVW/nvODlHzhFHi1DENEJtFQFVi2fk5zF2MHBxsApoSFyaXgoRFBBQk
	en6vBBrJxcEsMIlR4vna3ywgCWEBD4nuldsYQWxeAR2JJQc/MELM3McosXVJJERcUOLkzCdg
	9cwCZhLzNj8Em88sIC2x/B8HSJhTwFZi2ukeVhBbVEBZ4sC240wTGAVnIemehaR7FkL3Akbm
	VYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwRGgpbmDcfuqD3qHGJk4GA8xSnAwK4nw
	plzUTRbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBqcLu
	R4YYm1eAsvl3ufgPr94IVG14/vn0y5LV5ivqLoowpLmkKLTb9gVvbPDpmXGJ8VpU18urLz+p
	fsyf41qlkceR+HnfBctX3s9To4+5hPCmLzN5p35/3/n36/7Ixsj6CFyZ77asb9b7apMe9mnF
	erLmV1dcnXhH4fthPqm6jI5j0Sf+2ryeb/Bu/ulDEttNtxwyf8l81Eul2/uv6fkEe7OPin0i
	6ZOsOv8mxbxaXuPAuy515in92YVcrtYd8YET+JIvRrgKzdrnME/yyv4tf7dX6pt61Z1rzTrw
	LcP+5cRJWTo7fta+m7gk6iuvtqCPybKfK3jql77/7LTvVSPH2oB/YcJcpfsentvBH3/wqxJL
	cUaioRZzUXEiAEa2+trvAgAA
X-CMS-MailID: 20220925180615epcas5p415fb08b7a431281a678311ff41540765
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_b81f_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220923093906epcas5p1308a262f3de722a923339c2e804fc5ee
References: <CGME20220923093906epcas5p1308a262f3de722a923339c2e804fc5ee@epcas5p1.samsung.com>
	<20220923092854.5116-1-joshi.k@samsung.com>
	<c9750503-b16b-a756-b3e3-c9dfa0c482c3@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220925_110622_966425_DCEE3479 
X-CRM114-Status: GOOD (  12.45  )
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

------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_b81f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Sep 23, 2022 at 08:15:28AM -0600, Jens Axboe wrote:
>On 9/23/22 3:28 AM, Kanchan Joshi wrote:
>> Currently uring-cmd lacks the ability to leverage the pre-registered
>> buffers. This series adds that support in uring-cmd, and plumbs
>> nvme passthrough to work with it.
>>
>> Using registered-buffers showed IOPS hike from 1.9M to 2.2M in my tests.
>
>Ran my peak test on this, specifically:
>
>t/io_uring -pX -d128 -b512 -s32 -c32 -F1 -B0 -R1 -X1 -n24 -P1 -u1 -O0 /dev/ng0n1 /dev/ng1n1 /dev/ng2n1 /dev/ng3n1 /dev/ng4n1 /dev/ng5n1 /dev/ng6n1 /dev/ng7n1 /dev/ng8n1 /dev/ng9n1 /dev/ng10n1 /dev/ng11n1 /dev/ng12n1 /dev/ng13n1 /dev/ng14n1 /dev/ng15n1 /dev/ng16n1 /dev/ng17n1 /dev/ng18n1 /dev/ng19n1 /dev/ng20n1 /dev/ng21n1 /dev/ng22n1 /dev/ng23n1
>
>Before:
>
>Polled (-p1): 96.8M IOPS
>IRQ driven (-p0): 56.2M IOPS
>
>With patches, set -B1 in the above:
>
>Polled (-p1): 121.8M IOPS
>IRQ driven (-p0): 68.7M IOPS
>
>+22-26% improvement, which is not unexpected.

Thanks for giving it a whirl.
>

------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_b81f_
Content-Type: text/plain; charset="utf-8"


------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_b81f_--

