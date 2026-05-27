Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CC2CD5BDE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 06:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MrZcQktF5DW8RNK/xMx1QZYMi2nSopdUUfZAgkLoHm4=; b=CmRoo4mJoJFYIo6A0l/mrkvQA2
	YHjifXrC7HpkrQCYpz0NQIYFVUrNSfYosSaXgQSWFsjHBEfj6sLnVwQM/sPber0X/3FaD7RdV9fbb
	bH2l/J6/LlFT9vDCdWPtocenHm5HjGM2arz+QZK7Gg0MUoWh7x50dlBDzdKbBmliheCJsLwPSjHas
	4oyMJtIQd/XV4ie3efc/gNAlI3lAgVWl61ZnUoxvJcg75NNaTfCegv97zdeGDLhaiyU0tSN6cV3pK
	b98Yph7ah5znWeKfu1HdaGkBT9sQf9Ijn0eNHjUIMdpWGwWeexAZTObFjyZEUxIn+TctnWWM3i7ps
	R8vHteuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS88l-00000003QSi-40C7;
	Wed, 27 May 2026 06:53:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS88f-00000003QQc-3lHg
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 06:53:18 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260527065305epoutp01c01a59537bc7545718830a0648e33baf~zWZemyAUX0868908689epoutp019
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 06:53:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260527065305epoutp01c01a59537bc7545718830a0648e33baf~zWZemyAUX0868908689epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779864785;
	bh=MrZcQktF5DW8RNK/xMx1QZYMi2nSopdUUfZAgkLoHm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GyQweJHktj/HHmf9Xtfk+I4oK6QGejuMSHsDamkdn5C8P66IMVcfGtRcGU16mC1GJ
	 y1F4olu8AtAvt26mOZHi712REpmrE8sevkXPW/hw9sKbfgRYJ1RWqv7aBs9or5EZXz
	 OfDrve+pOz6Iw6mhxX3mfOqkUGYso4nhTB8vEgpU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260527065305epcas5p23653ab432932de63119c72268beb9d00~zWZeU6McO0653306533epcas5p2F;
	Wed, 27 May 2026 06:53:05 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gQL0w64k3z2SSKj; Wed, 27 May
	2026 06:53:04 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260527065304epcas5p412cc877c24f6f61ef28a22a15948036f~zWZdeIN2q1893518935epcas5p4Q;
	Wed, 27 May 2026 06:53:04 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260527065303epsmtip2524766d6f232760c7328418546b93657~zWZcPnS7V0130601306epsmtip2D;
	Wed, 27 May 2026 06:53:02 +0000 (GMT)
Date: Wed, 27 May 2026 12:16:34 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme: add support multipath passthrough iostats
Message-ID: <20260527064634.czevilgtyivc3vto@green245.gost>
MIME-Version: 1.0
In-Reply-To: <20260526153921.2402015-3-kbusch@meta.com>
X-CMS-MailID: 20260527065304epcas5p412cc877c24f6f61ef28a22a15948036f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Jrw9jMc8q62Q-Jc2IxP2q-7gINpdWZOCnjMJ4YRu1Wh0Ew3m=_7f909_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260527065304epcas5p412cc877c24f6f61ef28a22a15948036f
References: <20260526153921.2402015-1-kbusch@meta.com>
	<20260526153921.2402015-3-kbusch@meta.com>
	<CGME20260527065304epcas5p412cc877c24f6f61ef28a22a15948036f@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_235315_231786_68063757 
X-CRM114-Status: UNSURE (   8.60  )
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

------Jrw9jMc8q62Q-Jc2IxP2q-7gINpdWZOCnjMJ4YRu1Wh0Ew3m=_7f909_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 26/05/26 08:39AM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>Don't skip io accounting for passthrough commands if the user enabled
>tracking these.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------Jrw9jMc8q62Q-Jc2IxP2q-7gINpdWZOCnjMJ4YRu1Wh0Ew3m=_7f909_
Content-Type: text/plain; charset="utf-8"


------Jrw9jMc8q62Q-Jc2IxP2q-7gINpdWZOCnjMJ4YRu1Wh0Ew3m=_7f909_--

