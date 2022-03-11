Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B43C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wnCqx+/VTK/nVCf+yOkYO0xfxpD0CUcSDhQQ+Ptxl0A=; b=189SnRvI+rFatM83YqtYOF5c88
	0IA9mJzxd/25+hXzwnsuBcHwv8AUL8xDmEmzznyVSD94/6VObOl+T1p1PF15gFXkVu/iiQoIOPOBe
	0Lk04O+QpfSMhIxVnAeCTN2NyyLGHcIwO4Tyll09ZI0FpgdzjNCVLDe9TXgKeiUD+fewsY/buolFc
	u2ACAfIZ+lLTBdmePUN0YD9kZ4HSkOgRvK9ZM7uuEbdeVXyxltVSmXzuUUjHZBlTBjXQ2fFVIigWP
	PVAw7QOpa6BXCO2WHKJVisVr/iXufaV8LEd3A9YTsVeUv3Ak2SnZgSfUu7VB47yI5QPM0mJSLgODp
	0mfkaTiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSlRL-0008x8-Cy; Fri, 11 Mar 2022 20:00:43 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSlRI-0008vJ-BG
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 20:00:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7F028B82CB5;
 Fri, 11 Mar 2022 20:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B7BC340E9;
 Fri, 11 Mar 2022 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647028837;
 bh=TvxVgxvG902p5ANsA/iC3earRyw+vVTX1cKROKGiNFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UgTXinLpIlSBzQqHijYtsJGrX9FB+JuMlSnN0mz7ExSXSdHSzcSiMu45bW+TkfDlb
 +L8zp9ft0x73hdPxtx7QpRuSs+veNB9KWwmU6IolZLyqJE8R1YIgUC34gaLUuJ17w8
 KpU8RQS8Sbh2gYyrCQZpXHfNQ3O4xfp/6J1IQZvcA1pq969ff3wPD8mRSq4Ogdo6ot
 PsOEdfXx2bqJdGndBwKRak4jM5i1aXIf55GroeIXKTvRT+aL9GSxr7FSYnegEfIZfT
 jGQERWV9+CKOAltuH5D9vVzKF8K+qNzEBC7aiK0HO+CZRnzv+9WOcGRoqdXQmh7+cx
 jlKJwrqWy9rPw==
Date: Fri, 11 Mar 2022 12:00:34 -0800
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <20220311200034.GA413555@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
 <YigzoKRJ1EHFRZY9@sol.localdomain>
 <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
 <YikEs7RNgPXTQolv@gmail.com>
 <20220310153959.GB329710@dhcp-10-100-145-180.wdc.com>
 <YipFP8B8MxMxTVBR@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YipFP8B8MxMxTVBR@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_120040_569319_BF9B707D 
X-CRM114-Status: GOOD (  10.64  )
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

On Thu, Mar 10, 2022 at 06:36:47PM +0000, Eric Biggers wrote:
> I think the lib functions should still use native endianness, like what crc32
> does.

Gotcha, then it should simply be this patch:

---
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index f1a22794c404..f9e5f601c657 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -3686,11 +3686,11 @@ static const struct hash_testvec crc64_rocksoft_tv_template[] = {
 	{
 		.plaintext	= zeroes,
 		.psize		= 4096,
-		.digest		= (u8 *)(u64[]){ 0x6482d367eb22b64eull },
+		.digest		= "\x4e\xb6\x22\xeb\x67\xd3\x82\x64",
 	}, {
 		.plaintext	= ones,
 		.psize		= 4096,
-		.digest		= (u8 *)(u64[]){ 0xc0ddba7302eca3acull },
+		.digest		= "\xac\xa3\xec\x02\x73\xba\xdd\xc0",
 	}
 };
 
--

