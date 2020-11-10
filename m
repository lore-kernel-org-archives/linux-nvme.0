Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4DAC388F7
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 15:53:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F24320674
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CH2JeYVt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="05QXNea3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F24320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X1VuipVz7pgt4MviWlOLkZjEN+0kKBpb//qWO0zQCls=; b=CH2JeYVt3AeR63QNjuH7FJ+Tl
	MAHdmLHpXq389Y6vWye34xC1aq57Ej6YI+2+epfvZcep+zC6jKBDJjKgGTHSdo4ViqESFeWTB3JtH
	3QTTCNmm1mpY+ICK/Ohn/2H0PCjOlYRLWgBQa+GAHnJ/3/zMqujF9/6ibHZCPvSIxQSwyusnkWOh6
	WHRNIj4KOYTd4ORuxTJEy55PgztkzJ20a34MIdMtHM2eC7zhXR+mtIkvkY/EXJDrDe+a71N8TYt4+
	PJ8zHATbpt6S5OCTFLSICowGv5oO/sSLt/qI0mIPEOqsfqDaalaZYHyOPGEXljiLa76LKTXWRVvW0
	ANR3Z+2rA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcVxG-0008SC-QV; Tue, 10 Nov 2020 15:53:10 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcVxD-0008R8-Qn
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 15:53:08 +0000
Received: by mail-ed1-x52c.google.com with SMTP id v4so13254101edi.0
 for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2020 07:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=blh0TM7uJoA9BF8R6HduWzSMqE4aY37AlNQs2jzT85E=;
 b=05QXNea3sjvnoh1/VZTHsd7S9cTspbIh29C0swjNCXRdbRNYPhE2Xuv+yduCHd6SFr
 mfPDnh6x8sUG7ouo0xLpXsHfI88CdaNCF4h13tpbGsNX3cObcnulm3jalz8zInGEXCC0
 kWTEZPy1gvIMTZIIK11h8lW8wjCMiY5IOOQzZo4WoipHq2SCfEd2DKoQrm9+c/zM/Tou
 keyiZZ/y0tR0ByQJIWwa5f4bK4wbxV/rr9pSv4asSs0RiLUSgR0zsVNbzWP2XCekHDEU
 KWCpMKuMmGTKJyDyZA13RlJ38RDegcsmxTQorYrEqVSzqB++6qSJDRy9kDp+mIVEDrS8
 2/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=blh0TM7uJoA9BF8R6HduWzSMqE4aY37AlNQs2jzT85E=;
 b=jaKUSUgmAcRMqtRisrU+8fwX1vlMsA2HVw01UZJrWT7HWcaYGm4iHzZb47FS2vIzwH
 8YjSm5YphWNdp/jGMo70mwZHkfo3W2JasZbe/qsYNthyICZxBDAvyAOSu0CGtDzaeHJU
 bNYmC3p6fl3MCLYZHj4wfCv7y4/2q3Rv3Z+8ZpQtkp1dKy99/CS/5C/V6awCrO4OFWKa
 AXx4YinPXIjQaO3W/P1CacDO6W0XqcSa342V0V73l+VFp2Lvr27T2G3TxqK9/AdobWgB
 xOJ2Yq9VCyoc6THmuf3XTulL3dk/6cNqNpsavyQSyuS8SeN4YZgiHnJbQp46ZB7hP06p
 OOsQ==
X-Gm-Message-State: AOAM530hvEQgcNtskOFX9URT58sq0kmlvCLpaoknGWaRPJb1toDfAQyi
 OgXiBzN3yyg/B3PEJFB/fHWdDg==
X-Google-Smtp-Source: ABdhPJzaKCeEtQ9fP0/nRXVhs1jsXDLUI2p42GIalSum/7A5z2g7/Gl2sVymBJyPx06wk0O2pnuU2Q==
X-Received: by 2002:a05:6402:17ad:: with SMTP id
 j13mr20789280edy.347.1605023586170; 
 Tue, 10 Nov 2020 07:53:06 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id nd5sm10671727ejb.37.2020.11.10.07.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 07:53:05 -0800 (PST)
Date: Tue, 10 Nov 2020 16:53:04 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: nvme: enable ro namespace for ZNS without append
Message-ID: <20201110155304.elqtz5dkjitofyxn@MacBook-Pro.localdomain>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
 <20201110141636.GD2221592@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110141636.GD2221592@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_105307_990031_C8577333 
X-CRM114-Status: GOOD (  11.83  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAuMTEuMjAyMCAwNjoxNiwgS2VpdGggQnVzY2ggd3JvdGU6Cj5PbiBUdWUsIE5vdiAxMCwg
MjAyMCBhdCAxMDozOTozOEFNICswMTAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiAgCWlm
ICghKGxlMzJfdG9fY3B1KGxvZy0+aW9jc1tudm1lX2NtZF96b25lX2FwcGVuZF0pICYKPj4gIAkJ
CU5WTUVfQ01EX0VGRkVDVFNfQ1NVUFApKSB7Cj4+ICsJCXNldF9iaXQoTlZNRV9OU19GT1JDRV9S
TywgJm5zLT5mbGFncyk7Cj4+ICAJCWRldl93YXJuKG5zLT5jdHJsLT5kZXZpY2UsCj4+IC0JCQki
YXBwZW5kIG5vdCBzdXBwb3J0ZWQgZm9yIHpvbmVkIG5hbWVzcGFjZTolZFxuIiwKPj4gKwkJCSJh
cHBlbmQgbm90IHN1cHBvcnRlZCBmb3Igem9uZWQgbmFtZXNwYWNlOiVkLiBGb3JjaW5nIHRvIHJl
YWQtb25seSBtb2RlXG4iLAo+PiAgCQkJbnMtPmhlYWQtPm5zX2lkKTsKPj4gLQkJcmV0dXJuIC1F
SU5WQUw7Cj4+ICAJfQo+Cj5JbiB0aGUgdW5saWtlbHkgZXZlbnQgdGhhdCBhIGYvdyB1cGdyYWRl
IGFkZHMgYXBwZW5kIHN1cHBvcnQsIGRvIHdlIHdhbnQKPnRvIGJvdGhlciBjbGVhcmluZyB0aGlz
IGZsYWc/IElmIHNvLCB3ZSB3b3VsZCBuZWVkIHRvIHJlZnJlc2ggdGhlCj5jb21tYW5kIGVmZmVj
dHMgbG9nIHBhZ2UuCgpHb29kIHBvaW50LiBBbHNvIHVzZWZ1bCB3aGVuIHNlbGVjdGluZyBhIG5l
dyBGVyBzbG90LiBXb3VsZCBpdCBtYWtlCnNlbnNlIHRvIG1vdmUgdGhlIGNoZWNrIHRvIHRoZSBy
ZXZhbGlkYXRlIHBhdGggYW5kIGV2ZW50dWFsbHkgY2xlYXIgdGhlCmZsYWc/CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
