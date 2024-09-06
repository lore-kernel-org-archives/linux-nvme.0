Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C75CD5BDD
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnxpRxmdKmzw51EzhHF0Og+SS/Jp3uqVbGv0cafQXvw=; b=UbsgRojgYm9nxo9vO6bN8rwESm
	x8Bh7MMPpDAih3z6YkbxI8njm9lwQRPAJV6kJY8uL5f3k7kxKYvTMQLOL0xg2C9yCyMobwoN+KDrs
	LaXYLQgGs4R8lmOWWYDi7ZYidnznjU5LT8xqJCbdi4DveZUqF9sGQxngZrraK26tQ/p74O1udSf+w
	4tlLiaKvYY7oeWGeFmVecHi6kM5KCooc1wnJa4dB88XvrZIBsHkIavuBRAb2lDiDzrSk1/qofKRrL
	LHEXnWvuEotq7oEaRKEhriKiW4HBVPKlrBxJNikT000p3UUTK2w2zCab8pyMNcxULvF2ReqrsiwUD
	OJYRaS7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smXMx-0000000C1aa-2EN6;
	Fri, 06 Sep 2024 11:43:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smXMk-0000000C1YO-42er
	for linux-nvme@bombadil.infradead.org;
	Fri, 06 Sep 2024 11:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:In-Reply-To:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AnxpRxmdKmzw51EzhHF0Og+SS/Jp3uqVbGv0cafQXvw=; b=jiOINUbs+PZVZnG4q6giJ7YWbo
	zvCfxXcrUYb85NJkC7kA1aM7GCTsG8g8a3gtplKqGQzL7CH7pjFRnUahu5CQHlLx0g1w3wu4Tzr3P
	YEJ815fDX6aGmplb0wIRtUNk1wWG95k18KxJXauvuKUWlPb2PGi2D/M91Erxrxx2Y13bc4qrUYOP0
	28rftISlVdMveJrqu8xc1oMc2CLwTyczaE2WuMjUrQ1YTIZT+zxVR3K7Drvjekpg6QHLbx/y8tgLn
	dsWYtJcOOzlBPvYFMxagdGgdJ/bPBktF61md8rV7r1gPv98rI97QaTKkxoQnjasmdVVMPUfk48ukD
	DmThN/qw==;
Received: from mailout4.samsung.com ([203.254.224.34])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1smXMg-00000000eeZ-3tFN
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 11:43:01 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240906114247epoutp04286fe4d882acf1f8690b3fa2841fd14d~ypPJEHJtz1680916809epoutp04T
	for <linux-nvme@lists.infradead.org>; Fri,  6 Sep 2024 11:42:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240906114247epoutp04286fe4d882acf1f8690b3fa2841fd14d~ypPJEHJtz1680916809epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725622967;
	bh=AnxpRxmdKmzw51EzhHF0Og+SS/Jp3uqVbGv0cafQXvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jYXtpDLhMjR4S4xtxN5yGBJ4eAPpD52tUpYmn+0A74at573/lUkp71NW65bAqypz6
	 7LvBmMc16rmGqOgucZBUXz776YAGlg1yv3smC73wk+z0DqQ07wMLtdMS7atgtUCrL4
	 MhyVOouEEZPk3LqBzGVs24rdY7Jdf1vM4n2Nlte4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240906114247epcas5p1a3143deee260a85dca86875edd6f0544~ypPIyQoPp2049120491epcas5p1o;
	Fri,  6 Sep 2024 11:42:47 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X0Z914r7Hz4x9Ps; Fri,  6 Sep
	2024 11:42:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	66.04.09642.5BAEAD66; Fri,  6 Sep 2024 20:42:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240906113209epcas5p27261b2b316d91ebf7bf5dc36fea84922~ypF3IYzcK2934829348epcas5p21;
	Fri,  6 Sep 2024 11:32:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240906113209epsmtrp19d9126f4985f18bfd0095f69383d7315~ypF3HqJim2363623636epsmtrp1Q;
	Fri,  6 Sep 2024 11:32:09 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-72-66daeab51803
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.18.08964.938EAD66; Fri,  6 Sep 2024 20:32:09 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240906113208epsmtip2b64793bbe20a919b319870bec16dddb4~ypF2BOKmZ2799027990epsmtip2O;
	Fri,  6 Sep 2024 11:32:08 +0000 (GMT)
Date: Fri, 6 Sep 2024 16:54:43 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org, Keith
	Busch <kbusch@kernel.org>
Subject: Re: [PATCH-part-2 5/9] nvme-pci: simplify io setup function
 parameters
Message-ID: <20240906112443.wapsen4sxrti7roe@green245>
MIME-Version: 1.0
In-Reply-To: <20240904183818.713941-6-kbusch@meta.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTU3frq1tpBicmKVusXH2UyWLSoWuM
	FmeuLmSxmL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB5nLtYEcAalW2TkZqYklqk
	kJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RbSaEsMacUKBSQWFys
	pG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsenxNOaCSawV
	k+afYW5g3MfSxcjJISFgIrGh6SeYLSSwm1FixQJzCPsTo8SV3/xdjFxA9jdGifPvfzJ3MXKA
	NWy5HwAR38socWTGKnYI5xmjxKWL18EmsQioSBzafZ0RxGYTUJc48rwVzBYRUJQ4D/Q/iM0s
	kCyx/dQJVpChwgKBEs93VoOEeQXMJC4vPcUIYQtKnJz5BGwkJ1D8y5QdYLaogIzEjKVfmUH2
	Sgi8ZZe4ee8mG8Q3LhLP2xqZIWxhiVfHt7BD2FISL/vboOx0iR+XnzJB2AUSzcf2MULY9hKt
	p/qZIW5Ll5jTtgoaQrISU0+tY4KI80n0/n4C1csrsWMejK0k0b5yDpQtIbH3XAOU7SHx9/ga
	FkgAbWWUWHbiM+MERvlZSJ6bhWQfhG0l0fmhiXUWMFyYBaQllv/jgDA1Jdbv0l/AyLqKUTK1
	oDg3PbXYtMA4L7UcHt3J+bmbGMEJU8t7B+OjBx/0DjEycTAeYpTgYFYS4X3qeStNiDclsbIq
	tSg/vqg0J7X4EKMpMK4mMkuJJucDU3ZeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6Yklqdmp
	qQWpRTB9TBycUg1Mxgtatri8u++/QMDMIv72Ua5JLyPD/zAKhzdUXQt1OWAqP6/LMLvmeLXP
	6ZiVD/Y/Euc7fuSfr999GTYDG4sZ0gU2ewWZGAxy/V1kf81PaXwTrXvAburB+5Fqt5995K39
	et/tx7m2PeaXeM8snnTXQ+HJqodiuV9F1mZ5nee+lPyuOf7Szl//9D5aN77LUHYtVbNpT1f9
	9rnqbnlFwg1ZhtcVn0oE9i9rUKuIMuYpXP1h4oVGJhHNJT8d2rJdhI+enbky3SMv1WFJ7Mez
	sl/i8lfZuH5s5Z0e6d3lfzbzQfGDb3/b1h84FXhDXCHdO+Ls6cTjij4yypHrfZ/MW6HOEtpa
	OVF48Y5zbx9kZEgrsRRnJBpqMRcVJwIA+DxJYSEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvK7li1tpBp+vGlisXH2UyWLSoWuM
	FmeuLmSxmL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB5nLtYEcAaxWWTkpqTWZZa
	pG+XwJXRtHo1U8FxporuB5PZGxh7mboYOTgkBEwkttwP6GLk5BAS2M0ocfaMN4gtISAhcerl
	MkYIW1hi5b/n7F2MXEA1Txglzl/tZAZJsAioSBzafR2siE1AXeLI81YwW0RAUeI80BEgNrNA
	ssSOHffZQHYJCwRKPN9ZDRLmFTCTuLz0FCPE3kSJ1Q9PMEPEBSVOznzCAtFqJjFv80NmkFZm
	AWmJ5f84QMKcQOEvU3aAlYgKyEjMWPqVeQKj4Cwk3bOQdM9C6F7AyLyKUTK1oDg3PbfYsMAw
	L7Vcrzgxt7g0L10vOT93EyM4zLU0dzBuX/VB7xAjEwfjIUYJDmYlEd6nnrfShHhTEiurUovy
	44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTD1vnuxUzBdJ5HlzL788uz4
	iXmiG3umsf0O7eMs0xC1UEiRt9m+xr4/7plzaefC7z+j9IwFPr7IKTu+wTzK55vD96mh0WHd
	Uiemxmn9vXpjkxCHddqePVv93kxfID49Nefwu6TVQTy2+V+7/B1D+N+YV69h+/pl6qLtP9y+
	7eb2m3LlY87djkm/7N6cqy+8X570V1D/8urynIvdhdXtzdvmO897/+GPku8ehoCPAeKz74iL
	X+eunvSm86dbnp2s7bQNZ5YtMlx5i3/ChcNtUdof/L00TVQXMU3kPRw8w2bpv2zvRZd1vBZz
	cyXJPV1dfWW17GSrz1r1E+ZpzVmwdtZVu3mfP6Zw2rW+uvk/wV9NiaU4I9FQi7moOBEAESYv
	J+ICAAA=
X-CMS-MailID: 20240906113209epcas5p27261b2b316d91ebf7bf5dc36fea84922
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----BXry2NbAWZo9yJTNih6DAV11S-FgciuNcVifFwRAucM.VCOc=_5b4e_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240906113209epcas5p27261b2b316d91ebf7bf5dc36fea84922
References: <20240904183818.713941-1-kbusch@meta.com>
	<20240904183818.713941-6-kbusch@meta.com>
	<CGME20240906113209epcas5p27261b2b316d91ebf7bf5dc36fea84922@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_124259_880115_E9594AE1 
X-CRM114-Status: UNSURE (   9.73  )
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

------BXry2NbAWZo9yJTNih6DAV11S-FgciuNcVifFwRAucM.VCOc=_5b4e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/09/24 11:38AM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>We're threading a reference to the nvme_command through all functions
>before it's needed. It's also redundant since it's a part of the request
>that has to be provided anway. Remove the extra reference and only get

Nit: s/anway/anyway

------BXry2NbAWZo9yJTNih6DAV11S-FgciuNcVifFwRAucM.VCOc=_5b4e_
Content-Type: text/plain; charset="utf-8"


------BXry2NbAWZo9yJTNih6DAV11S-FgciuNcVifFwRAucM.VCOc=_5b4e_--

