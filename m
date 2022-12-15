Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC501C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 08:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ac4r7o4D3eIICXiUafaSr/3IAVJ+dWk193mfTAPjCFs=; b=L988CShO9+kaqRMaX1rg1ZMJxZ
	ChTRUwSTrh8KC+dsD4GwqjeTw8RIT9CpmVr7P+C/9ZfsC48Z9PxVzrxNXNvCtlKYpqQhBn3gWhTJe
	lUZsiyiKzLtPr5+9CaRblLBUNZ7bry53thhVcXVy0jW2Nol28hvQzOXStttIJB0tE5PfKmbG1fzCm
	mWPTs/uGEw9imyTamWe61q6yW/BxytS2e5ipJ2gkieRFTZINWRCPqcWH+6oTaba52XHh7ke4fiNt5
	JcT/5S0erk8XEEd3u7Ip6SJ1jlRASVqmChcRA5hetv4wJwbe+SJF7d5sO2xogHbaRIpb7BKU7cd+w
	95wmHIFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5jig-007kuR-FP; Thu, 15 Dec 2022 08:35:58 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5jiU-007kik-Qk
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 08:35:50 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221215083538epoutp049fe3c1223aa5cf19e0cb09c4d7e14779~w6omeB-7I0761507615epoutp04B
	for <linux-nvme@lists.infradead.org>; Thu, 15 Dec 2022 08:35:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221215083538epoutp049fe3c1223aa5cf19e0cb09c4d7e14779~w6omeB-7I0761507615epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1671093338;
	bh=Ac4r7o4D3eIICXiUafaSr/3IAVJ+dWk193mfTAPjCFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DkZCZn4IC0guEwvukTjwUVZLEIwP6iwki4VxjkY+Dut5qNqA1JmRTvtROb0sFVWIP
	 u9RRycPNke8YWJT8/7ydEH0K1e45twYkuvWxd24LiOhiqAnrR7teNyvGmZScI/Rsw8
	 AulJfz5S8ckuGH51BPyZckdlsFjOsXCymxyU4z2w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20221215083538epcas5p45e627150bd10e99c26e4b0d97fa957de~w6omMXJSf0548805488epcas5p4D;
	Thu, 15 Dec 2022 08:35:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4NXltK0rk4z4x9Q7; Thu, 15 Dec
	2022 08:35:37 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.D4.56352.85CDA936; Thu, 15 Dec 2022 17:35:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20221215083536epcas5p16888024477b9e6f118304b79ed0cf82a~w6okev7Wf1602116021epcas5p1H;
	Thu, 15 Dec 2022 08:35:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221215083536epsmtrp1fd5b79f2034f55fe97faf8a1beab3c91~w6okeH0l11963819638epsmtrp1c;
	Thu, 15 Dec 2022 08:35:36 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-91-639adc583f58
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.23.18644.85CDA936; Thu, 15 Dec 2022 17:35:36 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221215083535epsmtip1f6d6dd34dcbd048731e2f324247fbc35~w6ojNMTKg2295522955epsmtip1u;
	Thu, 15 Dec 2022 08:35:34 +0000 (GMT)
Date: Thu, 15 Dec 2022 13:54:10 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 9/9] nvme: don't allow unprivileged passthrough of
 commands that have effects
Message-ID: <20221215082410.GB27656@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221215081829.GA3816@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTSzfyzqxkgz9rmCxWrj7KZDHp0DVG
	i6dXZzFZzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRmXbZKQmpqQW
	KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
	K+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ0xa+pet4BZ7
	xYxX/9gaGE+zdTFyckgImEg8v/2GsYuRi0NIYDejxNz5e9ghnE+MEhuvfmGGcD4zSjQ86maH
	aenavJgVIrGLUeLYyX1QLc8YJaaf/c0EUsUioCqxbcdDoCoODjYBTYkLk0tBwiICShJPX50F
	28cs0MMoca59JStIQlggWWLp65NgNq+ArsSypd/ZIGxBiZMzn7CA2JwC2hKd53eAzRcVUJY4
	sO04E8ggCYGv7BI3Hk5ngTjPRWLRnG2sELawxKvjW6DOlpJ42d8GZSdLXJp5jgnCLpF4vOcg
	lG0v0XqqnxnEZhbIkLizcjkjhM0n0fv7CRPIMxICvBIdbUIQ5YoS9yY9hVolLvFwxhIo20Pi
	/pZOJkigvGeU+L5oIssERrlZSP6ZhWQFhG0l0fmhiXUW0ApmAWmJ5f84IExNifW79Bcwsq5i
	lEwtKM5NTy02LTDOSy2Hx3Jyfu4mRnCC1PLewfjowQe9Q4xMHIyHGCU4mJVEePfLzEoW4k1J
	rKxKLcqPLyrNSS0+xGgKjJ+JzFKiyfnAFJ1XEm9oYmlgYmZmZmJpbGaoJM67dEpHspBAemJJ
	anZqakFqEUwfEwenVANTn7j8pPir0bcPnbpUe5oj+vhJ7v3cQZurUpP5+WZx+X8+9phR1/WS
	7JLEN5bqBooXy04H2WWm9jEtZGzndRNcx/uF+cb7SXKHy64XHj1RzzO3cKdCRl35tpsL9j/p
	Tjz71U53vv7/cI0VIqWH81OfFxdNvNtg4Oqr46cifeHxSTVOt6RNx31K0kMVtA3Dv0gLz5Qy
	Uslbe+yh7EEnX97l99mvv2yvOWSzdcUvVYdPWQuvXRO6qCx35e3HYLv4Jws4ntiuEquJsN2y
	N+JR0d2WutVrNi6Iz9eP8N8b/nLbhczn79m8ZjWpqgn0Jzx2mviLty7/zl3Lpsv1p2Rmu066
	/bPipJqj4f3XP3mm/StTYinOSDTUYi4qTgQAVaGjNRkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnG7EnVnJBqf3ilisXH2UyWLSoWuM
	Fk+vzmKymL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjeKySUnNySxL
	LdK3S+DK6Pz7m72gh7Vi2uVrbA2M01m6GDk5JARMJLo2L2btYuTiEBLYwSgxb9MTRoiEuETz
	tR/sELawxMp/z9khip4wSjRMns8EkmARUJXYtuMhUDcHB5uApsSFyaUgYREBJYmnr84ygtQz
	C/QwSpxrX8kKkhAWSJZY+vokmM0roCuxbOl3NoihHxkllj/6ywKREJQ4OfMJmM0sYCYxb/ND
	ZpAFzALSEsv/cYCEOQW0JTrP7wC7QVRAWeLAtuNMExgFZyHpnoWkexZC9wJG5lWMkqkFxbnp
	ucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMEBr6W1g3HPqg96hxiZOBgPMUpwMCuJ8O6XmZUsxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1P3RWbe+bWN159+
	3++R+y56mVdIipNzRvK08h3/OE4a2BzOrJF1vGj5PkyEw6ixymmDpPKdsA5bPa5FW3OCKnJq
	O1fzBiheFDBInCTGJXdu+udbIq13Mm63RFeu+7p70+HX0jdbSmTWhVZmPPoi+93XKLJbj4O7
	L+ShXvGxfxU7ZrSkfRNM6OktP71nx4pzUXO0ze7t+GP24Mi0+fqPqnuWc33/x8J7/8ZNDvFJ
	S89vMq+4eJMv5cIr5fbsDxsfr/LY5bJq9aKqI7L5vet5PtZb9Bzg/LDI0Zflr8PFDZJ+gtzq
	TTFPD4ftr30YuSLBwNt8Ded2kfYVu1pmZKk7fu/imT9v6oUN+/6bsa5qVFdiKc5INNRiLipO
	BABYX2W45wIAAA==
X-CMS-MailID: 20221215083536epcas5p16888024477b9e6f118304b79ed0cf82a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_362b5_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221214161926epcas5p49ec1cfa4cdc583b00bf6b8b066eb1964
References: <20221214161347.764071-1-hch@lst.de>
	<CGME20221214161926epcas5p49ec1cfa4cdc583b00bf6b8b066eb1964@epcas5p4.samsung.com>
	<20221214161347.764071-10-hch@lst.de> <20221215071405.GA27656@test-zns>
	<20221215081829.GA3816@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_003549_226431_71292259 
X-CRM114-Status: GOOD (  13.83  )
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

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_362b5_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Dec 15, 2022 at 09:18:29AM +0100, Christoph Hellwig wrote:
>On Thu, Dec 15, 2022 at 12:44:05PM +0530, Kanchan Joshi wrote:
>> So even for operation that do not alter anything (e.g. nvme_cmd_read)
>> nvme_is_write will return false, but nvme_command_effects will return
>> true and we will ask for FMODE_WRITE. Is that intentional?
>>
>> I think doing "nvme_command_effects(ctrl, ns, opcode) &
>> ~NVME_CMD_EFFECTS_CSUPP"
>> is better to avoid that?
>
>Take a look at patch 6.

But that patch still takes NVME_CMD_EFFECTS_CSUPP into account while
returning effects. It should be removed from there, and we need nothing
else here.

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_362b5_
Content-Type: text/plain; charset="utf-8"


------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_362b5_--

