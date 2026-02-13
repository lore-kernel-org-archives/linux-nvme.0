Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D53EDF150
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=exsdaOyNsC7jrR7N0HceDEYFCU
	jil0o+oCl6yChwUbxvf2pK3cgYPxOnEcumLDuuhsbfngB+I/MXMUdmKqV7H2P+Ul0jSoVboxW8L0J
	vlBkI/B2F8QdkMAgby74/0tfX8ETLw+BNN7OijJrLfRxNf5im/VJq9r2rFmHESlepTaj90snqrFkk
	xFHMr1b7GMCuWJXno8XAQHP1oDS/JJWUwL5XWQzd+OEXqr75oppPrgpd6bwfuI4W2kzmRgdDsThFx
	gC6hUMuLflfm++BzpPT0pX91gx7wMvJ2KYg8UyqC6lFO9stOa8QkYszud4dPl7Vx56wfJANnTOWge
	Psq9djAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqqLM-00000003JSo-46Wk;
	Fri, 13 Feb 2026 10:24:12 +0000
Received: from [203.254.224.25] (helo=mailout2.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqqLJ-00000003JRM-20py
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 10:24:12 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260213102356epoutp0290b2a52ebab778b5bc0881b0c4f383a2~Tx1K75CbX0254202542epoutp02R
	for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 10:23:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260213102356epoutp0290b2a52ebab778b5bc0881b0c4f383a2~Tx1K75CbX0254202542epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770978236;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=u6jhLaa7oUqwNWeXOtTJkiUt7m9imzFt8wycfBskJOwgXukG1uEZTTuZNhi3p2HHQ
	 +dByZTMXFdFSutoE499WSR8VclGcwHXQ333ks55OTztSmKw6JnHYF9bvB7DnCatFJS
	 d6kyFhoq+Xi9hkz/j5Uf1LR/BoNGw+fHkYjtd0oc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260213102356epcas5p151471ac388674537b8c80067bb5f40c8~Tx1Kkc2Md0935709357epcas5p1N;
	Fri, 13 Feb 2026 10:23:56 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fC7Yl3Wfyz6B9m6; Fri, 13 Feb
	2026 10:23:55 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260213102354epcas5p3aa35e73938a074a37df07480a4f43491~Tx1JUg4Hb2896128961epcas5p3r;
	Fri, 13 Feb 2026 10:23:54 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260213102354epsmtip1a20557fb9bda35f96948da426eab619b~Tx1IsueMX2680026800epsmtip1v;
	Fri, 13 Feb 2026 10:23:54 +0000 (GMT)
Message-ID: <ef55e0f9-5d7b-4d6f-80bd-7c0f5fedaa38@samsung.com>
Date: Fri, 13 Feb 2026 15:53:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/3] nvme-pci: ensure we're polling a polled queue
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260212164733.3006071-2-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260213102354epcas5p3aa35e73938a074a37df07480a4f43491
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260212164747epcas5p303cd6fcf0fdb154291da896b7ce3bb4b
References: <20260212164733.3006071-1-kbusch@meta.com>
	<CGME20260212164747epcas5p303cd6fcf0fdb154291da896b7ce3bb4b@epcas5p3.samsung.com>
	<20260212164733.3006071-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_022410_006611_FFB132CF 
X-CRM114-Status: UNSURE (   5.03  )
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

