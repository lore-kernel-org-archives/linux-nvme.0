Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21004C64E8A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 10:29:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734552084C
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 10:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GIewrZDc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="W2pM13a9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734552084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=if6epmRatFO5GhC0Srqr2mjd/Ol34bk9EZlVe9Zw52M=; b=GIewrZDcSBUiZbYDK4Vb/uJjd
	fYbPd1MbNc5kRBLm1XpMASi7A1SpWjoeRBBn8/QwezjccmTzSbhah7D2RWj+0M7IWYfAM2WpHa3ss
	79xpBmRpkvGaYHa0uDu8L3n65v+qe4pDjQ4oU3HY5mdAlG+LkeUeIjWeN1FAiNKqMG8u/f4brVev9
	I5d1APFsDyuBdxu6X9T6NnapmNh/pJbpdDmh1ehz1e/m08kgScXjGxCVU7orgkoBl5LKZPAE+BgqR
	fdQclhERvk2chsQdv0yD5sz+KBCoj01xACzOjwhxfDV7aPFD0ECf5k2zyaKUiq07PURQSrTf58zLT
	r2YMhCYJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk2u0-0006Oe-83; Tue, 01 Dec 2020 10:28:56 +0000
Received: from smtp32.i.mail.ru ([94.100.177.92])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk2tw-0006J5-Ir
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 10:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail3; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc;
 bh=l1N6XIAne+McdY3ijU+uuVLe1pgShwCc1+08lGmsRLI=; 
 b=W2pM13a9w6mXURaDovfJjgjfMBXZvXeE1n7RwEn6cP/WCk63Bmx+swFPfOWeP6KQwuZaIgoixxKDk7thT1n7C+WdxBaDXVllKt6Aff3GXrN2NaqfLlU35qSOLkZgsOEemPTF69HwbV5b1N7lVp34D7RXMkAgSTpinp55AHwMzTQ=;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <alekseymmm@mail.ru>)
 id 1kk2tk-00016e-7J; Tue, 01 Dec 2020 13:28:41 +0300
Message-ID: <942255077c7caf5a2b1983570e30c3bf06410f62.camel@mail.ru>
Subject: Re: [RFC PATCH 1/2] block: add simple copy support
From: Aleksei Marov <alekseymmm@mail.ru>
To: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org
Date: Tue, 01 Dec 2020 13:28:38 +0300
In-Reply-To: <20201201053949.143175-2-selvakuma.s1@samsung.com>
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CGME20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63@epcas5p1.samsung.com>
 <20201201053949.143175-2-selvakuma.s1@samsung.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Authentication-Results: smtp32.i.mail.ru;
 auth=pass smtp.auth=alekseymmm@mail.ru
 smtp.mailfrom=alekseymmm@mail.ru
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD999A8EEC2DADA0D07E1BF0C4D8F2165D6BFD1794E82424750182A05F5380850409BE7A150ED1B00F1C022DD71FCE058B8DEFA2C7AF8D1056E373E27A7D4B55752
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE782A779A89F7D69B2C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE742D9BD90C58D50E0EA1F7E6F0F101C674E70A05D1297E1BBC6CDE5D1141D2B1C5EB6B0088F9EF39078F613C64E7469982E703C04DF1DF8D69FA2833FD35BB23D9E625A9149C048EE9ECD01F8117BC8BEA471835C12D1D9774AD6D5ED66289B524E70A05D1297E1BBF6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481F9449624AB7ADAF37CEDA8D6C8C3B0531D8FC6C240DEA76428AA50765F7900637C5678F1FF88595B3D81D268191BDAD3DBD4B6F7A4D31EC0B7A15B7713DBEF166D81D268191BDAD3D78DA827A17800CE79C97E770BC796042EC76A7562686271EEC990983EF5C032935872C767BF85DA29E625A9149C048EE3F735096452955E3837C4FEFBD1860714AD6D5ED66289B524E70A05D1297E1BB35872C767BF85DA227C277FBC8AE2E8BFF03D3B3299F339D75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A58B4D0912B3BC9DA9F1391F1CF3B19E0472EB6FD1610E9A0AD59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA75D299BBC8C521FD19410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC41E2768949EA6ADD8C54C4338DDBD92B00AAD22493C4BF0A8888A14071D875BB2D42BBAD9C943210154E7D1AE445192D9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEErOympIxBEhQUaV/Z7rJg==
X-Mailru-Sender: 8261CADE3D3FA0B4BDFD1058942BD7EABDEAF675FBD1B593B904FB4FE118C5F7AF19E46FE0E80F3EFEDCCAD94ABAB60078274A4A9E9E44FD4301F6103F424F867A458BE9B16E12C867EA787935ED9F1B
X-Mras: Ok
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_052852_891139_D34098E7 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, damien.lemoal@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, selvajove@gmail.com, linux-kernel@vger.kernel.org,
 nj.shetty@samsung.com, linux-block@vger.kernel.org, kbusch@kernel.org,
 javier.gonz@samsung.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2020-12-01 at 11:09 +0530, SelvaKumar S wrote:
> +	ret = __blkdev_issue_copy(bdev, dest, nr_srcs, rlist, gfp_mask, flags,
> +			&bio);
> +	if (!ret && bio) {
> +		ret = submit_bio_wait(bio);
> +		if (ret == -EOPNOTSUPP)
> +			ret = 0;
> +
> +		kfree(page_address(bio_first_bvec_all(bio)->bv_page) +
> +				bio_first_bvec_all(bio)->bv_offset);
> +		bio_put(bio);
> +	}
> +
> +	return ret;
> +}
I think  there is an issue here that if bio_add_page  returns error in
__blkdev_issue_copy then ret is -ENOMEM and we never do bio_put for bio
allocated in  __blkdev_issue_copy so it is small memory leak.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
