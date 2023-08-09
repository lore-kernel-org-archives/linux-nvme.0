Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B33C001B0
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 07:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMuXogKJl62Cp+6eL1pz4+YH7yx2PxLMpWmsYAwWT/Y=; b=x8ShqLlB/T2OjMtJZuMdZiiGwj
	6WxPBDcOOf5z+VtDsRVnQVxheAUeryQ2VS2p+S7NShN7tXhcoLtBiQExZUSDun4jva6BYyAM0Vn1O
	yDBnaw/IR5CzZi2kirSsPbvvqA27N84t62M9EtD2dyoBLgZ9JahV1mmT7iip0Li9MceAPlEWdLkyW
	qMG4G80tlUaxephlbDjGCTnHMvqe9CRTor5eOYyF01knC3M1cTC8WaZymeloZh9Ls3SHnjo0Qlrdp
	7awzmHlUlUTLVuTB06Jwt225zPTn2EWF62RviSEoik6DO3O0H7dO1geG7BS87j9vRMKc3I3XKKqwz
	EnSzwJOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTdDc-004CTF-0E;
	Wed, 09 Aug 2023 07:02:56 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTdDX-004CQn-2S
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 07:02:54 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230809070244epoutp029cfbeb28e2024c0067545a4dba778f85~5pQJBzQNq1899818998epoutp02S
	for <linux-nvme@lists.infradead.org>; Wed,  9 Aug 2023 07:02:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230809070244epoutp029cfbeb28e2024c0067545a4dba778f85~5pQJBzQNq1899818998epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691564564;
	bh=NMuXogKJl62Cp+6eL1pz4+YH7yx2PxLMpWmsYAwWT/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcwmpEMgSk5zi6rLCT3QREdBEpnMgDJ3m3D9jpkDmEDM1ErWuAuFVelyt1mdJSGEw
	 igTkv5yqfU6S/vKD+TTSg16RqKQ6NjfINKCGAXfEIDaecZXouuow3ZegeiGF0qTq7v
	 WySPz8SbcnVS2sQwbiPB1XQE0t3fh7YYBWhLk134=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230809070243epcas5p1097fa910ae05e16605168c524d802f76~5pQInd7K43046830468epcas5p1z;
	Wed,  9 Aug 2023 07:02:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4RLLbk3gyxz4x9Pt; Wed,  9 Aug
	2023 07:02:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	13.9E.55522.21A33D46; Wed,  9 Aug 2023 16:02:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230809070241epcas5p35e30b2fc1abfcd5abd1bde5ba37ab427~5pQGtoGTI2250222502epcas5p33;
	Wed,  9 Aug 2023 07:02:41 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230809070241epsmtrp1fc608a8713a1a1e94243048dda879550~5pQGs4xvQ0638506385epsmtrp1L;
	Wed,  9 Aug 2023 07:02:41 +0000 (GMT)
X-AuditID: b6c32a49-c94d0a800000d8e2-81-64d33a126268
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.95.14748.11A33D46; Wed,  9 Aug 2023 16:02:41 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230809070240epsmtip152885e1e42ea27fac825beec2d4565d2~5pQFgnAZy1620916209epsmtip1H;
	Wed,  9 Aug 2023 07:02:40 +0000 (GMT)
Date: Wed, 9 Aug 2023 12:29:20 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, Guangwu
	Zhang <guazhang@redhat.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] nvme: core: don't hold rcu read lock in
 nvme_ns_chr_uring_cmd_iopoll
Message-ID: <20230809065920.GA19415@green245>
MIME-Version: 1.0
In-Reply-To: <20230809020440.174682-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmpq6Q1eUUg0PLZSyaJvxltlhyZTeL
	xcrVR5ksJh26xmgxf9lTdotDk5uZLNa9fs/iwO5x/t5GFo9NqzrZPDYvqffYfbOBzeP9vqts
	Hn1bVjEGsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
	ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
	MDAyBSpMyM648Hoie8EKzoqTV/czNTD+Ye9i5OSQEDCRePTnNAuILSSwm1Hi8WIvCPsTo0RP
	m2UXIxeQ/Y1R4kxDAxNMw75T/WwQib2MEh3/OlggnGeMEtOOvgcbyyKgItH74zZQBwcHm4Cm
	xIXJpSBhEQElibt3V7OD1DMLXGSUmP5pHStIQlggWmL7+0VgZ/AK6Er8W/ebCcIWlDg58wlY
	nFPASqJr6R+wuKiAssSBbceZQAZJCHRySPz42sMIcZ6LxOnOC1C2sMSr41ug/pSSeNnfBmUn
	S1yaeQ7qnRKJx3sOQtn2Eq2n+plBjmYWyJA4uSERJMwswCfR+/sJ2C8SArwSHW1CENWKEvcm
	PWWFsMUlHs5YAmV7SEy+184OCZNeYAC1vWGawCg3C8k7sxA2zALbYCXR+aGJFSIsLbH8HweE
	qSmxfpf+AkbWVYySqQXFuempxaYFhnmp5fAYTs7P3cQITptanjsY7z74oHeIkYmD8RCjBAez
	kgivbfClFCHelMTKqtSi/Pii0pzU4kOMpsDYmcgsJZqcD0zceSXxhiaWBiZmZmYmlsZmhkri
	vK9b56YICaQnlqRmp6YWpBbB9DFxcEo1MJnfrt6dvy3RZfUjmQdWVa8P8U6JbXj7bln1q/a+
	aWsv6fbtuf/y7O5F2Uwzg3apVK41bdiwZ9nPy5vWlBqVPfq7z0bkz5pAO9XZOzybHAK21Yhd
	n7pd0/qwuaTaUZX7SpM6JLgMz6oHr/x1n5v3+JQsf8u+27I/hefuqv7bfvKQBGej6D+uD+sf
	W4n7zOEwFk2vsLaettPiQYd15EE2vnvB711z1x5WkktjODJZ45z84apP9veUP8pymhm/duQR
	cSiu3lz3Y7/BJYdrLHu8ezi0BP4/3MXVf6X+S93r1ZnNOr9XHfjT8G2J16oXrBPXsHUkBXRp
	dz/5NHN6TseM2D0vpvmz3jvdNjHA691W9kolluKMREMt5qLiRADrAT/fJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnK6g1eUUg647yhZNE/4yWyy5spvF
	YuXqo0wWkw5dY7SYv+wpu8Whyc1MFutev2dxYPc4f28ji8emVZ1sHpuX1HvsvtnA5vF+31U2
	j74tqxgD2KK4bFJSczLLUov07RK4Mi63nWQuuMVW0X9gHVMD4wnWLkZODgkBE4l9p/rZuhi5
	OIQEdjNKdL2cywSREJdovvaDHcIWllj57zmYLSTwhFFi9QJLEJtFQEWi98dtoHoODjYBTYkL
	k0tBwiICShJ3765mB5nJLHCZUWLmjb1gy4QFoiW2v1/EAmLzCuhK/Fv3mwlicS+jxNajp1kh
	EoISJ2c+AStiFjCTmLf5ITPIAmYBaYnl/zhAwpwCVhJdS/+A3SkqoCxxYNtxpgmMgrOQdM9C
	0j0LoXsBI/MqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzgaNDS2MF4b/4/vUOMTByM
	hxglOJiVRHhtgy+lCPGmJFZWpRblxxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbL
	xMEp1cDEbStU8SozJezsYpeNh28wet/anxDa/Zb//ZPNLw8emqTjXecfpbM25POezXJH3mbH
	hmqtYGVcadR5ebWvwcVeXZsm5esmv05cMk+dzLH7WElG/kb+Aw/2PUoMcxC+ZML8t8XISEMx
	5YJQJR9fcuH9LNfUOVy20YWTalayJXw6yrT9YqdKyeGKz9eFVn6L44zpm7npvL/MzYznYrvn
	rz6+f2NV5rX9X5+d5jrs/0Te1/7thB814l4pza+enlu+S6rW8tfCUPZL7zUea4j+/Lzs0ryJ
	K625r4sUHag8vLeO+fbX0jn86VKLJ8nOjfy21/rAibQipb4D+YIW35u1dz2e0+1ycfbr66k6
	yw5L+UkWK7EUZyQaajEXFScCAPYkT/v1AgAA
X-CMS-MailID: 20230809070241epcas5p35e30b2fc1abfcd5abd1bde5ba37ab427
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_3d5ae_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230809020844epcas5p30e520491fa59ab8c20836d4275931e8f
References: <CGME20230809020844epcas5p30e520491fa59ab8c20836d4275931e8f@epcas5p3.samsung.com>
	<20230809020440.174682-1-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_000252_614684_09DBCE2A 
X-CRM114-Status: GOOD (  14.03  )
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

------Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_3d5ae_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Aug 09, 2023 at 10:04:40AM +0800, Ming Lei wrote:
>Now nvme_ns_chr_uring_cmd_iopoll() has switched to request based io
>polling, and the associated NS is guaranteed to be live in case of
>io polling, so request is guaranteed to be valid because blk-mq uses
>pre-allocated request pool.
>
>Remove the rcu read lock in nvme_ns_chr_uring_cmd_iopoll(), which
>isn't needed any more after switching to request based io polling.

>Fix "BUG: sleeping function called from invalid context" because
>set_page_dirty_lock() from blk_rq_unmap_user() may sleep.
>
>Fixes: 585079b6e425 ("nvme: wire up async polling for io passthrough commands")
>Reported-by: Guangwu Zhang <guazhang@redhat.com>

Thanks Ming. Looks fine, but any link to this report?
I don't see this breaking in my tests. 
So I wonder how to reproduce and improve the coverage.

------Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_3d5ae_
Content-Type: text/plain; charset="utf-8"


------Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_3d5ae_--

