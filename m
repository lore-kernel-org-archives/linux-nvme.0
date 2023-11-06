Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E1AC4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mu+81MaI5SnAIUsfN5Tcp/FOO/84RycrEprnhwELJnU=; b=waR3zyRFIIIBwU658i6XnwmLnc
	FXlvP75K/5NmnjkRZv0r//uWv30QnD+aPZx+mUU9mKGWqnbMPlyRtlUftiZBAV4YAwGlpT39+NOVA
	h3rrda4woaAPbE56MOnuI1hqCtiO4jz/Ir8KcX5rvcQp/3LBreI8MwA7guvGYd5INoE6/jQjiRX5N
	TAO5sQ4ic3VY8kf2uLvZxHAHZSvurs3jKnPkW+9vMU9Hpyn64tMgBCjg+yo3Wa71QqEkT2M9k76Xy
	x/uMh/oNbHKLt/OJRKwaveWRzoBPUmznMWa81bdDeFvkO4Cc7bwQPWoBXlSc4aJRCKHlSCEoPUFpq
	nMfGTGJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qzsLr-00Ftfx-2q;
	Mon, 06 Nov 2023 05:40:43 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qzsLk-00Ftfb-1C
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 05:40:39 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231106054028epoutp0414bbe9e767b70170d472429e0d24f151~U8iukzRqk1214912149epoutp04Y
	for <linux-nvme@lists.infradead.org>; Mon,  6 Nov 2023 05:40:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231106054028epoutp0414bbe9e767b70170d472429e0d24f151~U8iukzRqk1214912149epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699249228;
	bh=mu+81MaI5SnAIUsfN5Tcp/FOO/84RycrEprnhwELJnU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IfdbpRqcodgE68NUVnpDZQ4UeyBMfZamn1vcdOYOtHLYw8Vxs/w0i6jlE3obg7ATH
	 lKtbNFAGgYxDsgO2mUt9GmKghzMB0hjfK2HnpGALhLn12jDeie3vKbCYrDbtXZpHR0
	 5VT1mOAjLrEA3fo/OqUc9+5hNHV9WxEuMM6w6bSI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231106054028epcas5p2a70abc382c6df51083d8e86f35457cff~U8iuNDnGZ1537515375epcas5p2x;
	Mon,  6 Nov 2023 05:40:28 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SP0Yk75DKz4x9QB; Mon,  6 Nov
	2023 05:40:26 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9D.FF.09634.A4C78456; Mon,  6 Nov 2023 14:40:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231106054026epcas5p1ea97344659b603e2cdacfa95af6077a2~U8ishyItM1930419304epcas5p1T;
	Mon,  6 Nov 2023 05:40:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231106054026epsmtrp1229cb93dcd80efcd4f50dfd3faa0a499~U8ishORWA2543625436epsmtrp1w;
	Mon,  6 Nov 2023 05:40:26 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-13-65487c4a4fde
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.C3.08817.A4C78456; Mon,  6 Nov 2023 14:40:26 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231106054025epsmtip1b6d91fdf0b22132e641e498ac7d4d85f~U8irTIfok0843108431epsmtip1L;
	Mon,  6 Nov 2023 05:40:25 +0000 (GMT)
Message-ID: <17543a8f-d1cf-e158-3208-afedab7c539d@samsung.com>
Date: Mon, 6 Nov 2023 11:10:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2] nvme: fix error-handling for io_uring
 nvme-passthrough
Content-Language: en-US
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, Niklas.Cassel@wdc.com
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231018192430.43606-1-joshi.k@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmuq5XjUeqwbYWK4umCX+ZLVbf7Wez
	uHlgJ5PFytVHmSzOvz3MZDHp0DVGi/nLnrJbPPjzmN2Bw2PnrLvsHpfPlnpsWtXJ5rF5Sb3H
	7psNbB59W1YxerQf6GYKYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshL
	zE21VXLxCdB1y8wBOkpJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtc
	mpeul5daYmVoYGBkClSYkJ2xtOMWc4Fixde53awNjGJdjJwcEgImErP6bjCC2EICuxklvt6t
	hLA/MUrMu63RxcgFZH9jlNh+YTc7TMOPfbsYIRJ7GSW2PvkM5bxllGjc/wtsFK+AncTDNT/A
	bBYBFYm2WR1QcUGJkzOfsIDYogJJEr+uzgGLCwsESNxs+8UEYjMLiEvcejIfzBYR8JTounSN
	HSJeJNH8bDFzFyMHB5uApsSFyaUgYU4BS4kT91+wQJTIS2x/O4cZ5B4JgZkcEot77rJAXO0i
	MX/LEWYIW1ji1fEtUN9ISbzsb4OykyUuzTzHBGGXSDzecxDKtpdoPdUPtpcZaO/6XfoQu/gk
	en8/YQIJSwjwSnS0CUFUK0rcm/SUFcIWl3g4YwmU7SHxZMp8FkhQ9TBKLLm7hHUCo8IspFCZ
	heT7WUjemYWweQEjyypGydSC4tz01GLTAsO81HJ4ZCfn525iBKdXLc8djHcffNA7xMjEwXiI
	UYKDWUmE96+9R6oQb0piZVVqUX58UWlOavEhRlNg9ExklhJNzgcm+LySeEMTSwMTMzMzE0tj
	M0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGphYi7sjphz7o+vILbc87U+VmNTZjS7vDnd8
	r7TnuMF8MLnJaNX0vzvPcSzWT/0wWVFlQ6RqoKBskbdhtqHcaUaRpEs36mfq9rpMP3s6XXfq
	m7nKv06+Xjfbv/ynkM0DW9n2I/+/7Nv6T9rM9WT+jXjNb54BE46uM1n06Rnr8a8zT25I33gt
	cXWqS1FXju1l579zcyrsJQ5FNNf3crJ/1fp/cPr+E1OlZT7Kn2XNXZnfq3TjTY56xS3lDbPK
	rSde3rVisZmC/lv3F8IrDlzapP9Lk6vgpYjvIfnI/VMUNoifPcFro/PG9s7cJeHakdvUOM5v
	4L93c8+DD/eeqB70eRx66ADTxsBdjLrRWUfiYkPnKrEUZyQaajEXFScCAIReDYg4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTterxiPVoPuwhEXThL/MFqvv9rNZ
	3Dywk8li5eqjTBbn3x5msph06BqjxfxlT9ktHvx5zO7A4bFz1l12j8tnSz02repk89i8pN5j
	980GNo++LasYPdoPdDMFsEdx2aSk5mSWpRbp2yVwZSztuMVcoFjxdW43awOjWBcjJ4eEgInE
	j327GLsYuTiEBHYzShzsXM0MkRCXaL72gx3CFpZY+e85O0TRa0aJC5uWM4IkeAXsJB6u+QFm
	swioSLTN6oCKC0qcnPmEBcQWFUiS2HO/kQnEFhbwk/jdeowVxGYGWnDryXywuIiAp0TXpWvs
	EPEiiR/HHrFALOthlOh41QtUxMHBJqApcWFyKUgNp4ClxIn7L1gg6s0kurZ2MULY8hLb385h
	nsAoNAvJGbOQrJuFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC40lL
	awfjnlUf9A4xMnEwHmKU4GBWEuH9a++RKsSbklhZlVqUH19UmpNafIhRmoNFSZz32+veFCGB
	9MSS1OzU1ILUIpgsEwenVAMT97WH4VfX7mW0lWUOvioq2v4va77TJUEv4ztCF7ZyOqQraMaH
	Vp/psLI5fzrnseXOTwZvJu3bkBPe4b5fpbqw3bp13ZQsxQyJ2zW7V5X/bfPS/lrXsGiZ09FO
	mwC+nCSrzkPre7TNbhyPqjrQNtNabbaL65orF10uyS9eZXb99ZVHhVNW54i47718hCnIuy11
	x+tFjGuqGQ4srG9qv+0nuWuC5ezHde3znyUbR0n9Y7XTe7U8JcO2ZYFL4Ltze8Pj7dMmOfek
	cbA/Oxzh6eJT7xe69+6DILkta5deyn69c2+M/+GPO24yz33/3ds2e96Bd3zmf9WemcwoWih4
	v2tPkFaad4foc0/XiqLLbt+UWIozEg21mIuKEwFrsuXXFgMAAA==
X-CMS-MailID: 20231106054026epcas5p1ea97344659b603e2cdacfa95af6077a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018193056epcas5p404b1fb38d3e9037862703690336d2d10
References: <CGME20231018193056epcas5p404b1fb38d3e9037862703690336d2d10@epcas5p4.samsung.com>
	<20231018192430.43606-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231105_214037_053049_6DEAD1BC 
X-CRM114-Status: UNSURE (   7.34  )
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

Keith,

Can this be picked?


