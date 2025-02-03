Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81169C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7qRQVpC595G5pF4zWhHkaT239k+7+Iqrs0Hw5ybb7b8=; b=wevVez1vUAD4qBss4s0s0CU9yp
	z7afPN715q/UUwyAiTCa3RjTxo9kp/feeOOb4favII5RY/z1PGguLy/08cREAFEVc48pA31gce6TV
	mt+MzLVGOxU5qoSaBdFiG3Nz7Bl9URpR4dr/RrjBm1kg/2x+R410+KKrMB6jEcXSa9YaEQJZhmLvd
	mSfmaDBeo304QWGhlcr8AfJ93I6GxBzG3u2kd5gBT5q52k9qlqk7GTYcX9VsXe+QFHo1sKpnX9DDV
	0XAIYGJdArthPwPpQooDGN+vZmJ1IHd5PKJ7yql9je0fbjguuI9mbWy/5ronxekywyUdRDL/NP5G3
	WFZUoWKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tewU1-0000000FWBt-3toh;
	Mon, 03 Feb 2025 13:27:25 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tewTy-0000000FW9W-1Mul
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 13:27:24 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250203132718epoutp04a342b50abf4bc999209322171ce3478f~gtbN6_Vh40402104021epoutp04e
	for <linux-nvme@lists.infradead.org>; Mon,  3 Feb 2025 13:27:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250203132718epoutp04a342b50abf4bc999209322171ce3478f~gtbN6_Vh40402104021epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738589238;
	bh=7qRQVpC595G5pF4zWhHkaT239k+7+Iqrs0Hw5ybb7b8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tuq1iIzYFn92F1kUzsAVpqGM1Dw3TO1guw2a/o27AbDS+ruIiClTIcLl+KA4Hzk0D
	 tmt5TpHARe2HWyomER0QTMDaAdR1QpNIEqScOkUwzuVXP+1jNwhzbqZR3gZWNa9lXd
	 rU8MIBm5lcd7Y/3jeXAW0V36FLHLGiR6QD7R2JA0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250203132718epcas5p10bbd54d4c74a90f6b24582b2631401a1~gtbNsnEIj2389723897epcas5p1N;
	Mon,  3 Feb 2025 13:27:18 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YmnNN3YSdz4x9Pq; Mon,  3 Feb
	2025 13:27:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.CB.19933.434C0A76; Mon,  3 Feb 2025 22:27:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250203132715epcas5p29dbf773b56a348fec46b65dfaafd5a2f~gtbLckemg1482914829epcas5p2_;
	Mon,  3 Feb 2025 13:27:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250203132715epsmtrp282d9f63bd9406aed23744e3a0a1cb382~gtbLb6SzK3251132511epsmtrp29;
	Mon,  3 Feb 2025 13:27:15 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-18-67a0c43432df
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.76.18729.334C0A76; Mon,  3 Feb 2025 22:27:15 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250203132714epsmtip20bd1b67654ac22c879b34fd5f4e1ab7d~gtbJ1wywv0712307123epsmtip2Z;
	Mon,  3 Feb 2025 13:27:14 +0000 (GMT)
Message-ID: <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
Date: Mon, 3 Feb 2025 18:57:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: Qu Wenruo <wqu@suse.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, "hch@infradead.org" <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "josef@toxicpanda.com" <josef@toxicpanda.com>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmhq7JkQXpBl8OiVucnrCIyeJv1z0m
	iz8PDS323tK2uPR4BbvFnr0nWSzmL3vKbrHv9V5mi9aen+wWa9Z9ZHfg8ti8Qstj85J6j8k3
	ljN6NJ05yuyxfstVFo8JmzeyenzeJOfRfqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON45
	3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hAJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmt
	UmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xvXrW9gK9rFXHHyxiL2BsZmti5GTQ0LA
	RGL3zfNANheHkMBuRomLa1axQzifGCUWXpwNlfnGKNF7bypcS2/Dc2aIxF5GiXlTDkJVvWWU
	eLLiChNIFa+AncTdpp8sIDaLgIrEtR9zWCHighInZz4Bi4sKyEvcvzWDHcQWFrCR6N51CGyD
	iECFRPfOl6wgQ5kFFjJL3J22DyzBLCAucevJfKAFHBxsApoSFyaXgoQ5gXoX773LAlEiL7H9
	7Ryw6yQEtnBIXPx6nBnibBeJyTd3skLYwhKvjm9hh7ClJD6/2wv1WrbEg0cPWCDsGokdm/ug
	6u0lGv7cYAXZywy0d/0ufYhdfBK9v5+AnSMhwCvR0SYEUa0ocW/SU6hOcYmHM5ZA2R4Sl1Zt
	ZoKE1RxmiQNnlrJOYFSYhRQss5B8OQvJO7MQNi9gZFnFKJlaUJybnlpsWmCUl1oOj/Hk/NxN
	jOAErOW1g/Hhgw96hxiZOBgPMUpwMCuJ8J7eviBdiDclsbIqtSg/vqg0J7X4EKMpMH4mMkuJ
	JucDc0BeSbyhiaWBiZmZmYmlsZmhkjhv886WdCGB9MSS1OzU1ILUIpg+Jg5OqQam2dlPl9jb
	nQ3yitCcp8NWG/ivbNmXPtGo25/PfpoeuOaQipvV3YcCudW7kp/Uh4fMvLojXPj2idRyz9OM
	rSo8Ot8EFmyp133DnuJ0ry6r0yp58t2NgluMLjJejTWZ6sdkfeS6jyW3qJjxN5aVe6dsXHNA
	Kz+2Mf1ftTrXFm5l4RMMK084Szi5tLkVy7yTTEgI3dhbLJ0nH2Wq37Z5x1+/rnt5n3zvH141
	J/3y8xdTJavbZIJmzP3vdb3RkqPjkcNl4Zu8xbUnrrMXy2k685wv8baNOvnTeoplH1/I75dH
	405win+P+vrZX/ropLorF70y1uxvCuJrEnh5T0XA9PDk/D08C4+zqpsevs/GrKHEUpyRaKjF
	XFScCAA+OxaZSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvK7xkQXpBttmGFmcnrCIyeJv1z0m
	iz8PDS323tK2uPR4BbvFnr0nWSzmL3vKbrHv9V5mi9aen+wWa9Z9ZHfg8ti8Qstj85J6j8k3
	ljN6NJ05yuyxfstVFo8JmzeyenzeJOfRfqCbKYAjissmJTUnsyy1SN8ugSvj+vUtbAX72CsO
	vljE3sDYzNbFyMkhIWAi0dvwnLmLkYtDSGA3o8SV5cvZIRLiEs3XfkDZwhIr/z1nhyh6zSix
	qa2LFSTBK2AncbfpJwuIzSKgInHtxxyouKDEyZlPwOKiAvIS92/NABskLGAj0b3rENhmEYEK
	ifuPHrCBDGUWWMws8fvJQ1aIDXOYJbZ1/GYEqWIGOuPWk/lMXYwcHGwCmhIXJpeChDmBBi3e
	e5cFosRMomtrF1S5vMT2t3OYJzAKzUJyxywkk2YhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRy
	veLE3OLSvHS95PzcTYzgaNPS3MG4fdUHvUOMTByMhxglOJiVRHhPb1+QLsSbklhZlVqUH19U
	mpNafIhRmoNFSZxX/EVvipBAemJJanZqakFqEUyWiYNTqoGpin+rudS78zOmLnJRWS6TtGpq
	BPvsyLcfH03slU15pLmUf/KbSXJpfyeY7b1nYbtOiKew+PvJTI91hWavY/fOC3Sbc8Oh+PnX
	GOkPfB9PhwdHLis7uFGOv3iK7y/bzkPLKuWLU6S2z+0pNu3inmp7UHDf/8sKy1pe5+7bsmPX
	8uKyzvnl/7tVCs+t2bhx67bwk8vlrUsl327KL6yRvxz4JSDq6JJ4RuGFhTr3b+2LP/RFx8oy
	+MzJrqniOzdHNV45tS/FqvfxscR/p2uyTFiXmXTwz/lwQpbhWtUP64zYYzE9LJIh98y4gyRk
	P8fyy9YdtpF9w+mY7M/+I3mq0qVpu8+eCWJNeTnBbee6bSa2SizFGYmGWsxFxYkARSa90CUD
	AAA=
X-CMS-MailID: 20250203132715epcas5p29dbf773b56a348fec46b65dfaafd5a2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
	<20250130091545.66573-1-joshi.k@samsung.com>
	<20250130142857.GB401886@mit.edu>
	<97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
	<b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
	<Z6B2oq_aAaeL9rBE@infradead.org>
	<bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
	<eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_052722_700060_F36CD873 
X-CRM114-Status: GOOD (  13.54  )
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

On 2/3/2025 1:46 PM, Qu Wenruo wrote:
>> ell for the WAF part, it'll save us 32 Bytes per FS sector (typically
>> 4k) in the btrfs case, that's ~0.8% of the space.
> 
> You forgot the csum tree COW part.
> 
> Updating csum tree is pretty COW heavy and that's going to cause quite 
> some wearing.
> 
> Thus although I do not think the RFC patch makes much sense compared to 
> just existing NODATASUM mount option, I'm interesting in the hardware 
> csum handling.

But, patches do exactly that i.e., hardware cusm support. And posted 
numbers [*] are also when hardware is checksumming the data blocks.

NODATASUM forgoes the data cums at Btrfs level, but its scope of 
control/influence ends there, as it knows nothing about what happens 
underneath.
Proposed option (DATASUM_OFFLOAD) ensures that the [only] hardware 
checksums the data blocks.

[*] 
https://lore.kernel.org/linux-block/20250129140207.22718-1-joshi.k@samsung.com/

