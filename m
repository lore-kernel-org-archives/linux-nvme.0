Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1798CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 21:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GVhgiwUec8+Ijkt3KghbOw4RhUiw9dtLTBEaP0iDHmc=; b=e/y3rhlAcAcT2H7s0Q/CskPtAR
	N33+qsZO54Q9mmSStR1FwkqtRglmI0/+k4mVyCGEqk+tXo5Vjza2agwk1iLWUcDCkOvnPJjMUqYTZ
	ogKSjdxUDrWAu9cXgElPY7UsYThG+MAi+Gwc/2k3EwS1FXPSpDMiF9WolYui8vHl3p2StNgwcC5Bk
	qZJcTtgdLuIKIc3rGYPZtbkspdAkBoDEUDEKL9RwkDrAHuVeFtm1/F2mubVTLEbJ7uH5imROk8RMu
	cvlrxACDYtlXjSPvQcxlg38ntKRJSPmuXg7Z806R5RLdTB3Hr421WmI4f+JF6QGxrvk20SYzyJbrn
	A2LzcT+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRhev-006Miw-Me; Tue, 08 Mar 2022 21:46:21 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRhes-006Mhs-E5
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 21:46:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BB286B81D96;
 Tue,  8 Mar 2022 21:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FEDC340EC;
 Tue,  8 Mar 2022 21:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646775975;
 bh=4NQDgg8rDLEMggBz3LqMK5Y31CHXEmbf5huKroKeVug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tTjSem06XXUAXfGknm1y00SGv6velA0nDArAbaZIknN3C+Cg5qeEG+3WWvq/nN02v
 E7RD/Z5YeFdudMIw02dAnJgEk982YfLlYbUptqBpOypbChuykEctwxp/4yfytESZKD
 tmem03zzNHQARta8jkC0n8RLcHFkhCBhE6vuWYd5Es0kGFVTUmf4t1ISE/6v3C62Ml
 pNGQ21vpX7Yyf6abzGXVgcaO4LCj5W2zZSAdRD3GB8qoJTFzyLddgh31uH2+ov5VvB
 EIpTEH3kD7iA4yZmbbaNxGo4C51IDEy5RDTQpWFbowZH+NHpcrnJG3IDfJupEWJPnI
 5aLl0SLvmYs3A==
Date: Tue, 8 Mar 2022 13:46:12 -0800
From: Keith Busch <kbusch@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <20220308214612.GB3502158@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_134618_659104_7633630A 
X-CRM114-Status: GOOD (  18.58  )
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

On Tue, Mar 08, 2022 at 12:27:47PM -0800, Keith Busch wrote:
> On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> > On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > > Hardware specific features may be able to calculate a crc64, so provide
> > > a framework for drivers to register their implementation. If nothing is
> > > registered, fallback to the generic table lookup implementation. The
> > > implementation is modeled after the crct10dif equivalent.
> > 
> > Hi Keith,
> > 
> > this is failing on big-endian systems. I get the following on s390:
> 
> Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
> action. I'll send an update, thank you for the report.

I'll set up a BE qemu target this week, but in the meantime, would you
be able to confirm if the following is successful?

---
diff --git a/crypto/crc64_rocksoft_generic.c b/crypto/crc64_rocksoft_generic.c
index 9e812bb26dba..12a8b0575ad1 100644
--- a/crypto/crc64_rocksoft_generic.c
+++ b/crypto/crc64_rocksoft_generic.c
@@ -28,14 +28,14 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 {
 	u64 *crc = shash_desc_ctx(desc);
 
-	put_unaligned_le64(*crc, out);
+	put_unaligned(*crc, (u64 *)out);
 	return 0;
 }
 
 static int __chksum_finup(u64 crc, const u8 *data, unsigned int len, u8 *out)
 {
 	crc = crc64_rocksoft_generic(crc, data, len);
-	put_unaligned_le64(crc, out);
+	put_unaligned(crc, (u64 *)out);
 	return 0;
 }
 
--

