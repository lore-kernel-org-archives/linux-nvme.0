Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5EAC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Sz1nS/eOW4UzdWpKQw0bjjGkfC2p+spkihDbawLQhs=; b=hcp+99AY9sTqicq/VLnVU47wTO
	c0lufHrILHC9rZdoHaiCFiVI9AfhYQmoPh8zLUg8EQgxw/lUtStfOX/HRs4rc11XiolVaM8x0fa9M
	sK3YpKRX7IpZPxDt80TqCfh9+Qdf7922PlXJ+3s44QrOkN1eVXlUih3TpNtAKKigs3VT1GdgybrU2
	FryZHUovOjw1TYyNrazk4V61LbrHxXXDaHgE12WIYkckRUgs3KyakPyI2w0eQPqP4I4Ahcvf3SwQc
	J3sf0tCFWoRmQlyrldI0cViNgVccN4rk0SAkx+bnwWGGyLgHFyv++KFpqx+uIG8HEAaiwrujp/bhf
	Vu00GZAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp2WN-00000003fr4-28O6;
	Tue, 26 Mar 2024 08:51:03 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp2WJ-00000003fjS-3YdA
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 08:51:02 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240326085042epoutp014e30ac3b164f0cdd2a90bbef0dedd9d9~ARGEjTUk32778827788epoutp01G
	for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 08:50:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240326085042epoutp014e30ac3b164f0cdd2a90bbef0dedd9d9~ARGEjTUk32778827788epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711443042;
	bh=1Sz1nS/eOW4UzdWpKQw0bjjGkfC2p+spkihDbawLQhs=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=WIRKuS5IuV9/aC4t3npEphMzfCCRTuRoX8DSHC4x0CCUzgY6PzHaBNEYQlx2O4Sdh
	 8y5Rrqqyv3oCl3I5+GWeXeLdu7ay4N+n0NqYZfwGV+X9CwsXHaPI7cbvEwiSBUczmA
	 GpY0LhOK6EO1fIyP2/3zx4kM6giqIfYWGDLE4tp0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240326085042epcas5p34f48f4bf943bb0f21ef290b8d45f6f96~ARGEMsNsw2219822198epcas5p3D;
	Tue, 26 Mar 2024 08:50:42 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4V3k684Mstz4x9Q3; Tue, 26 Mar
	2024 08:50:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.C6.19431.E5C82066; Tue, 26 Mar 2024 17:50:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240326085037epcas5p4a8c7d7e330bdc9b267dcd1de358f4cae~ARGAS-s-73136131361epcas5p4E;
	Tue, 26 Mar 2024 08:50:37 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240326085037epsmtrp2b969b86472e40e6dc42edac79149afad~ARGASVeZx2820628206epsmtrp2d;
	Tue, 26 Mar 2024 08:50:37 +0000 (GMT)
X-AuditID: b6c32a50-f57ff70000004be7-d1-66028c5ed2a3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F6.AB.07541.D5C82066; Tue, 26 Mar 2024 17:50:37 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240326085037epsmtip298d2e93ce7ee51a6bf621076773f5a59~ARF-ytLgA1887618876epsmtip2h;
	Tue, 26 Mar 2024 08:50:37 +0000 (GMT)
Message-ID: <dee7f8a3-34af-e12c-ac7d-721960fc0744@samsung.com>
Date: Tue, 26 Mar 2024 14:20:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] nvme: initialize identify ns data to NULL
Content-Language: en-US
To: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240325154503.11510-1-ikegami.t@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmlm5cD1OawZPpXBarT/SzWcxf9pTd
	gclj56y77B6bl9QHMEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
	Krn4BOi6ZeYAjVdSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr
	5aWWWBkaGBiZAhUmZGd8/NLBXNDBVLG+aRd7A+Nlxi5GTg4JAROJWXd/snQxcnEICexhlNi3
	aiYrhPOJUeLU/KvMEM43RolHM96zwrRsPvsBqmovo8Su6XuZIJy3jBKvV3xiA6niFbCT6H74
	FmwJi4CqxMfFnxgh4oISJ2c+YQGxRQWSJX52HQCq5+AQBqp/1JAOEmYWEJe49WQ+E4gtIuAl
	cffSRrASNgFNiQuTS0HCnAKWEqtWHGOEKJeX2P52DtihEgK72CVePDvPDHGoi8Smq+uhbGGJ
	V8e3sEPYUhKf3+1lg7CTJS7NPMcEYZdIPN5zEMq2l2g91c8MspcZaO/6XfoQu/gken8/YQIJ
	SwjwSnS0CUFUK0rcm/QUGjziEg9nLIGyPSQuvLoGDcMeYOhseMY8gVF+FlJAzELy8Swk78xC
	2LyAkWUVo1RqQXFuemqyaYGhbl5qOTySk/NzNzGCU5xWwA7G1Rv+6h1iZOJgPMQowcGsJMLb
	8oUhTYg3JbGyKrUoP76oNCe1+BCjKTBKJjJLiSbnA5NsXkm8oYmlgYmZmZmJpbGZoZI47+vW
	uSlCAumJJanZqakFqUUwfUwcnFINTAkmd3w0J+7paJt/+NVCSc2CvMYP65SmnFvv08NzIblC
	OetVtc4O9+rz8xfWsZ03n8/37Iu3qGxW/dr+jGkXTj57ohxtXer08GDRfcskvoUG/19tsng7
	0TyMzaftuV7tqnLmk2+fCshkB0fs28519eUkD+OyOqZJtrdT9r9k4eB56nrHcJbHkUPl96Ov
	n8y8xqdssFy67zjr13RDSYvXH85GXXmvtnzWg/MPHnFnG5c83Z2Yeyz7lea8jL2+702TP1xe
	+ObJMyPlV0kzL325LvCsp5zn02fl7GkWgk0hjwP5dHXZC8Uqr0jMClwseYbBt1D+r8hrh6A5
	asv3rDfa2JIZ/f/AisVlV9SeRfU+/avEUpyRaKjFXFScCAARMsO3+gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvG5sD1OawYxvOharT/SzWcxf9pTd
	gclj56y77B6bl9QHMEVx2aSk5mSWpRbp2yVwZXz80sFc0MFUsb5pF3sD42XGLkZODgkBE4nN
	Zz+wdjFycQgJ7GaUOPb8PwtEQlyi+doPdghbWGLlv+dgtpDAa0aJnVe1QGxeATuJ7odvwQax
	CKhKfFz8iREiLihxcuYTsDmiAskSL/9MBOrl4BAGqn/UkA4SZgYaf+vJfCYQW0TAS+LupY1s
	EDf0AN1w9zBYPZuApsSFyaUgNZwClhKrVhxjhOg1k+ja2gVly0tsfzuHeQKj4Cwkm2chWTEL
	ScssJC0LGFlWMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefnbmIEh7KWxg7Ge/P/6R1iZOJg
	PMQowcGsJMLb8oUhTYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWpRTBZ
	Jg5OqQammOPV4coFuvrXgpt/v9sifdvPYJdA57VI6XNVuV4zLMwmWTPJzObMu5ZmoWgvlfyg
	IU/uHdfn/MCXPcI2Jx94/3t/6rhpU6BqZEB33pqM2qC4k02qP3RmP/I48KQ5K3CRvEHrxpkp
	D1hqbJ38RI5pVHPJlp+b/XP7qruVTgW9bcU1/f1Rv9YvnfvS7PbhnKdF8X9efdDqND71OfHT
	Q95dBRFv1/z+e6UqXefVuqxvxxbmvJa505irG9HTyl4mdd6g+FZm4fygTwVn/r8XWszUvP3z
	xbv1u/kjdYK6un7rPy+eI9dTKRP/J+2StVv5vknc98LEgzaxr/PfVLi7unxlX1EC303WsJQf
	AlbbFJVYijMSDbWYi4oTATwYIOLUAgAA
X-CMS-MailID: 20240326085037epcas5p4a8c7d7e330bdc9b267dcd1de358f4cae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240325154544epcas5p4acf7f376241637872a433314489586fa
References: <CGME20240325154544epcas5p4acf7f376241637872a433314489586fa@epcas5p4.samsung.com>
	<20240325154503.11510-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_015100_311443_92EDCA6A 
X-CRM114-Status: GOOD (  12.06  )
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

On 3/25/2024 9:15 PM, Tokunori Ikegami wrote:
> Currently nvme_identify_ns() sets the data to NULL if failed.
> Also the data is not freed if the function returned failure.

If it fails, it frees the allocated memory too.
So I don't see how the patch helps.

