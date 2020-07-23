Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D9C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 21:59:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6B0206E3
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 21:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xPDM5QDo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="J/bEQ691"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6B0206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mA41/eCw/DQkBhOEIA4SOpy2SP7HrxfJyQtACFwPrR8=; b=xPDM5QDovbDjrTJQVOcCDwzrC
	fyRVPuTnCcxy6SPgnVBE8iM2/qUxjeshE3NPvSP0iBxngd0+cpP49s3eJWDFzbhuujY9xoIh3zhiY
	l33sxWx8FfT7/2ltA5oho+C+9VhpwkluzGZUfXRmnIi30Hf4JpETQhaFtbuLbdtcLI4XIut1jGVt9
	8ABglpi/0HcKy4thNw9GeSGptVXPuAcVC2xa8W1jlLJEFqF12LKL6NzJRnLF9NpQu4bVzm66zs92j
	ZqtaFldmmuBJGUeDyRtD6BFwVfdEfyZwr6e2oKPCKO8Ral3Q3LiKa0tm5dpCCTTf2nHjO+oxUHUSb
	7x7mba0KA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyjEz-0000Ml-F8; Thu, 23 Jul 2020 21:59:01 +0000
Received: from sonic314-14.consmr.mail.bf2.yahoo.com ([74.6.132.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyjEv-0000Le-PE
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 21:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1595541535; bh=Z7zYNBYe9So1RkREZh13dhyfcAymsEUwljuVrXqVyWg=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To:From:Subject;
 b=J/bEQ691uWtGTSdU+6Wq/R3+dOZuLxFHHQH67P35hHlLrT+dhHkJsx+EdUR4qUL45JDdoF2bhCSgkKElo54izGuaDbn5GimLyWwa1E7cMEdnOyGPssYbukbVJrYoRhO4ptyH/W8BQnHXCz/pfdnbJFSIjOigEZHU6xX/fNqolMSCJq4tqH/o/s6Icvi/Et5TksjOdfb2yIRLW2dms7R/zm17Ni3q/I7yg/6Ubi06vxmPoATCHlCgnT6BZVlcLbSf7nlXOzNScvZF1L/bLn3lBxWGUpCtBeUv/SjVOvxMeLJcRfvS17l+ajlQSLDFBXK7FVfj/67fiMbTG7r1Jp1+ZQ==
X-YMail-OSG: 2MPdt.YVM1nGlhoclOQBFLXcrnbIe9_b1dHew_SNR53SHJVNHYMkLhHxZxiNNOa
 YuGomdJiIgQV0pNzhXiFfMkVPP.ItoxcbNCweMZieMWQGc_6TX91_FQQFM21dN82y4efeUk_snVf
 EfcBeawGaeLp6.3Q.tGoDkwQ4GVDwNEtJ_X0ZfcHGhsw4_elzHUYiVfzp801SGBXMX5VPJOO6_OE
 vrOWW6QF7t02HBA6yjT0Gt1fD9q3Ry_DtO.yVgthrlsq5TyvUTSIbUvV.D5.2yA2NbjnFdqXfyPU
 4mFdpyrVNQ71UdOLXPgWCL4A.F5TgHqkymIiIYYU.abxrKhPHtHns.QrZmaLBLeoffBklCjA6lBv
 3OvBtoxj10rK6szNi._ozioSXH6S4a54VuNU0OBuWrPcOpjO9CROOdBHBGbf1m4KbAh8S_CGbrNj
 pZuxLilDHE1tLrmEZ6kn8S1a47MUc3fv7gGXxF7A_v9wKUpuf_2YHlcmvZl4cQ9lnK32wZb3LgaB
 Gq0tVgz7.OI8UBmYe1MvHv6ljSRf1HyEvF74ef1LW1vohxE1iBArurZU7hwZytnP5fq2GmMy0Esf
 RFecSSxs2DWw4pgl1MNTZO6xh6qJ1jdjNSC98PjdOHjSmWc57QNkS7vS4DErANwfRyBQG3A_goVh
 ksg7M_.Lkx.pIUmWRnfWNxbc6_bZRT682lkOKC3_epTTczX_NMzVIrp4KL6v83tYkRBDHFiBZFM_
 fbfQ.V54RLNmEAtqDArHN6pAGtCvHMq2_X_ieK8tezjC3ZJTMTM7ZuNUF06CHbX3e65rVehq4Gc5
 D8I4iAvriHf32YtZ0WVkHsJtg.jbOzpefnlNc2gGr7rnY4.HTAvWJBL3.Oc_s_8Z0mI4E_S.YfBD
 fvbbanrDzi._SUijNHNdGpK4FhMbbLYjphTRRMeA9m2_BWADhHEaEG9av9P65eVvGJVnWHv9IcJx
 oxq3BRUUEpT5.iVkyOAvZ7UKiDu7cBJkZTtSOMH0zNeyU4VcpmlEVSxyTSSAO0UE50.2ahRfwIBn
 JR8m8KxNBfywOMU1IxTcz7TyYmn4Aq1donl8nE.rf0pxfXbpXt_DL6bsV4MLs7OTYlQjAOZJyndD
 STPO1KPCu6pk29KR_3PwrK39D_6a5cYG4qa7VcShZSTbuI9plKpK8pW2ohbUaZRQLanpSWLnzvWy
 zGrXt5a90dfruDCORGYo9RwW1Hth8hF7fBEcTJ_MuJ7P2KB7qobqJB3nU3B9mNCkd4baw5xXaVy5
 lxOcPiXghZ_zOexiB3cGlAc_i0Jq.1x_BPnyHmBJsu4afLM9q2Gdy.hdziBNH9y99pGhYTj0vocx
 0R1NUYoXb3KKdbFOZwI8XKGhHEw98ZDKVql_klmItvBb0fQ1GcxcLTD3cjaLJE2MIG7k88vqC9v6
 T3Tqc2BxECAyoE.l7oESvqFSid0aSnStlCZFl6QQUvGOmMzR2FROfNPdpBTqnmdU7wa5kYc_UfyK
 YHxHJAehO2ubKKL.8dg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.bf2.yahoo.com with HTTP; Thu, 23 Jul 2020 21:58:55 +0000
Received: by smtp407.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 15395e4e31de4dd4e5a2d51df643cc21; 
 Thu, 23 Jul 2020 21:58:51 +0000 (UTC)
Mime-Version: 1.0 (1.0)
Subject: Re: DONATION OFFER
From: AMITAV GHOSH <aghosh90@yahoo.com>
X-Mailer: iPhone Mail (16G183)
In-Reply-To: <E1jyhDI-0008SD-Ut@srv01.znettelecom.net>
Date: Thu, 23 Jul 2020 14:58:49 -0700
Message-Id: <ED3EE155-D05E-4563-9907-DA02C09BA873@yahoo.com>
References: <E1jyhDI-0008SD-Ut@srv01.znettelecom.net>
To: stevelenkathomson12@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_175857_880612_42B8EEC0 
X-CRM114-Status: UNSURE (   5.05  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QnJpbmcgdGhlIG1vbmV5IHRvIEZvbHNvbSBsaWJyYXJ5IHRvbW9ycm93IGF0IDNwbQoKU2VudCBm
cm9tIG15IGlQaG9uZQoKPiBPbiBKdWwgMjMsIDIwMjAsIGF0IDEyOjQ5IFBNLCBTdGV2ZSBsZW5r
YSA8YWxhbkB6bmV0dGVsZWNvbS5uZXQ+IHdyb3RlOgo+IAo+IEhlbGxvLCBEb25hdGlvbiBvZiAx
LDAwMCwwMDAuMDAgR0JQIGdpdmVuIHRvIHlvdSBieSBTdGV2ZSAmIExlbmthIFRob21zb24sIFRo
aXMgaXMgdG8gaGVscCBmaWdodCBhZ2FpbnN0IENvcm9uYSBWaXJ1cyBhbmQgaGVscCB0aGUgcG9v
ciBwZW9wbGUgb2ZmIHRoZSBzdHJlZXRzLiBzZW5kIGVtYWlsIGZvciBtb3JlIGRldGFpbHM6IHN0
ZXZlbGVua2F0aG9tc29uMTJAZ21haWwuY29tCj4gU3RldmUgJiBMZW5rYSBUaG9tc29uCj4gCj4g
LS0gCj4gTCdhYnNlbmNlIGRlIHZpcnVzIGRhbnMgY2UgY291cnJpZXIgw6lsZWN0cm9uaXF1ZSBh
IMOpdMOpIHbDqXJpZmnDqWUgcGFyIGxlIGxvZ2ljaWVsIGFudGl2aXJ1cyBBdmFzdC4KPiBodHRw
czovL3d3dy5hdmFzdC5jb20vYW50aXZpcnVzCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1udm1lIG1haWxpbmcgbGlzdAo+IExp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
