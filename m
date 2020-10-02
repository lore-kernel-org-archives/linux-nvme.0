Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5DAC4363C
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 16:03:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39803206FA
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v97bxD7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39803206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F5f5UM/o+VYrCNosSFgXSr/+j3gOgUHoKGgWgwsbiPs=; b=v97bxD7vwmBhwin+bcdMTBzWm
	o/YpiW6I/s2qV83VRUUcKOAJr2JtSm2dCc4cXZrecUMN7Y9c5ElpwTVlo6aQQ1r43PDe57fJPwDNF
	qT3uZ2b19fatjRlzKo0INyxL5NOU5Kb4ra6T/icmciA+dHVbtgopenM2FYZVnfYXSyshnRMlz9bR4
	j+Y8jA1eX87VA2OHipK21UguZnpqXPCQ+fAuCCfKMAWroHIV+nHl6xvWux28jb29AEPObWhdebRrY
	LDkQo8xcYepQTWl6S0wneerq83Gf1YVXxvFK5C+rc3SiqPQroW0l4pnBaG6F8BNQZorM1JFt1KElU
	n+R2bs3SA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kONWz-0007vv-Vw; Fri, 02 Oct 2020 16:03:38 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kONWu-0007ta-Cg
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 16:03:33 +0000
Received: by mail-pj1-f68.google.com with SMTP id a17so395101pju.1
 for <linux-nvme@lists.infradead.org>; Fri, 02 Oct 2020 09:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z4jBKyt04l7B+xG5bw1Df7Ul9L3DDMY8BcN91jxZ07Y=;
 b=MxwMqp/cd/tfTCgOCshRRgu/OyTGpUhdAmLndKmaBin6CNzNiIxW1RQsyms/Qe0TRp
 QjlwHc5isBO4NzCNpXCIeaiutSz+UcAS/a8UTP66P0vwUDvQgkZRvgTh8Fh1tV5bbvB/
 BIEka1OKUNw2MyqCOT+njZ+BstBJI8pYimF2AceYVBGwB1EEz/wBBuEadBuDCUZ9S0gI
 f7u2PwISRGf32M7coDKOer5dlkTKTNjVu4GztTecL7Qa56DNMhtbqNLrG1CiJOSH7OxV
 Qg19UKdwdnHAIpo28QHW+gvMSMENj+p5jfsd779V6PvSbCeuqnLKuI/vAXmnm4VmTRzs
 HXFw==
X-Gm-Message-State: AOAM531FyOslGK76DZnw4/EBugYxbAhT27nGBm0q3VUgCJPhDzqmatGK
 7WKD1IU1R8/IJYsdVtYPKAE=
X-Google-Smtp-Source: ABdhPJz1YSZ8DOuPytZvCjUKbJzxkFDvSB1YDvQp4IJ8/p1a+CfRgRF0d9HXdePNS4nhwuB/xsVmcg==
X-Received: by 2002:a17:90a:3848:: with SMTP id
 l8mr3425209pjf.163.1601654609188; 
 Fri, 02 Oct 2020 09:03:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1be2:3dfb:f0b7:cc27?
 ([2601:647:4802:9070:1be2:3dfb:f0b7:cc27])
 by smtp.gmail.com with ESMTPSA id c4sm1961741pjq.7.2020.10.02.09.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 09:03:27 -0700 (PDT)
Subject: Re: [PATCH 10/20] nvme: freeze the queue over ->lba_shift updates
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-11-hch@lst.de>
 <39b98188-2803-2f49-e225-8d3fbe3bfb1f@grimberg.me>
 <20200929183214.GD12948@lst.de>
 <e6c5bbb7-ea1a-b449-541d-2c8317ed462d@grimberg.me>
Message-ID: <73932a4a-8618-5058-3d1d-434cf934aa18@grimberg.me>
Date: Fri, 2 Oct 2020 09:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e6c5bbb7-ea1a-b449-541d-2c8317ed462d@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201002_120332_456233_56E2E595 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gRW5zdXJlIHRoYXQgdGhlcmUgY2FuJ3QgYmUgYW55IEkvTyBpbiBmbGlnaHQgd2VudCB3
ZSBjaGFuZ2UgdGhlIGRpc2sKPj4+PiBnZW9tZXRyeSBpbiBudm1lX3VwZGF0ZV9uc19pbmZvLCBt
b3N0IG5vdGFibGUgdGhlIExCQSBzaXplIGJ5IGxpZnRpbmcKPj4+PiB0aGUgcXVldWUgZnJlZSBm
cm9tIG52bWVfdXBkYXRlX2Rpc2tfaW5mbyBpbnRvIHRoZSBjYWxsZXIKPj4+Cj4+PiBUaGUgcXVl
dWUgaXMgZnJvemVuIG9uIHRoZSBxdWV1ZSBsb2dpY2FsIGJsb2NrIHNpemUsIHdoeSBzaG91bGQK
Pj4+IHdlIGNhcmUgYWJvdXQgSS9PIHdoaWxlIG5zLT5sYmFfc2hpZnQ/Cj4+Cj4+IEJlY2F1c2Ug
d2UgdXNlIGl0IGZvciBhbGwga2luZHMgb2YgY2FsY3VsYXRpb25zIGluIHRoZSBJL08gcGF0aC7C
oCBCeQo+PiBtb3ZpbmcgYWxsIGFzc2lnbm1lbnRzIGludG8gdGhlIGZyb3plbiBxdWV1ZSBjcml0
aWNhbCBzZWN0aW9ucyB3ZQo+PiBhdm9pZCBhbGwgcG9zc2libHkgaW5jb25zaXN0ZW5jaWVzLgo+
IAo+IEknZCB0aGluayB0aGF0IGl0IHdvdWxkIGJlIGJldHRlciB0byBuZXZlciB1c2UgbnMtPmxi
YV9zaGlmdCBidXQgcmF0aGVyCj4gdGhlIHJlcXVlc3QgcXVldWUgYmxvY2sgc2l6ZSBhbmQga2Vl
cCB0aGUgcXVldWUgZnJlZXplIHNwYW4gb25seQo+IHRoYXQgbXV0YXRpb24uCgo/CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
