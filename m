Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98773C12002
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 05:51:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E91B613DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 05:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E91B613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sj5SNh81j3w4PRlBLoB3Z5fIxM2oV319KfWDtgrV4vU=; b=3IdivZkEHm5yL1
	Z3wJ/OCfVAJlvhtl3Q+9RIQS7blcFxLFPIuijdGVGRYbovytuquQkx5H+kt0EnB2G482laTDC6Rbe
	w5zLJDYEb8wsFF51uFjfqPt40VObl1kMV4jrvxO7HSHdbW7FuZobMblawpUOEjvHk7orsrrKQQVPt
	JFoq1AWoGf+PkdBOmvthCPo92uqhkOxIp1w7cyGlXIbNXtZcth3ua6Uke8c7Z1ciMUtXMfEyxXY9u
	lT99Oo65YLQP2CJnbiQj2ookRrfdATkdyPqv8m6EB6otczEuefUuk3kVHw1nTApdJ5GSS/2QtexNp
	T67ZMiea/DHRmAyjLXpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4GkR-003HZf-QL; Fri, 16 Jul 2021 05:50:55 +0000
Received: from vulcan.natalenko.name ([104.207.131.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4GkP-003HZ9-1h
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 05:50:55 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 2AFA8B3727F;
 Fri, 16 Jul 2021 07:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626414650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkD1+YfJKD2PbtLEBpDTmJMAI+qwaETSYREVcgaWIu0=;
 b=HoXZu9PfqtrdHb2zQonHLuFGrpPVulQTpblRdFNvLRIyBGF3xW3VbriAUaoFoIMM47JotH
 7lOUpbc1FyUGIn8cuGhcRpSPiSQN2guogSu5nyfP2KD0pcTzGMbO5lBgKGWrp+Ec56WWLd
 GG3kq3mfqcqNNvUvQShd29kdxKMDrwU=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Laurence Oberman <loberman@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Paolo Valente <paolo.valente@linaro.org>,
 Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date: Fri, 16 Jul 2021 07:50:47 +0200
Message-ID: <6257454.2i5GHAlHl1@natalenko.name>
In-Reply-To: <8b0023f5ba9ede85f6f75159847b4c185ab68f6f.camel@redhat.com>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPBD8z+yqC0ShjrZ@kroah.com>
 <8b0023f5ba9ede85f6f75159847b4c185ab68f6f.camel@redhat.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_225053_429431_7E311813 
X-CRM114-Status: GOOD (  11.01  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGVsbG8uCgpPbiDEjXR2cnRlayAxNS4gxI1lcnZlbmNlIDIwMjEgMjM6Mzc6MjEgQ0VTVCBMYXVy
ZW5jZSBPYmVybWFuIHdyb3RlOgo+IFtyb290QG1sMTUwIH5dIyB1bmFtZSAtYQo+IExpbnV4IG1s
MTUwIDUuMTQuMC1yYzErICMxIFNNUCBUaHUgSnVsIDE1IDE2OjQxOjA4IEVEVCAyMDIxIHg4Nl82
NAo+IHg4Nl82NCB4ODZfNjQgR05VL0xpbnV4Cj4gCj4gW3Jvb3RAbWwxNTAgfl0jIG52bWUgbGlz
dAo+IE5vZGUgICAgICAgICAgICAgU04gICAgICAgICAgICAgICAgICAgTW9kZWwKPiAgICAgICAg
IE5hbWVzcGFjZSBVc2FnZSAgICAgICAgICAgICAgICAgICAgICBGb3JtYXQgICAgICAgICAgIEZX
IFJldgo+IC0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQo+IC0tLS0tLS0tLSAtLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLSAtLS0tLQo+IC0tLQo+IC9kZXYvbnZtZTBuMSAg
ICAgQ1ZDUTUzNjMwMEM5NDAwQUdOICAgSU5URUwKPiBTU0RQRURNVzQwMEc0ICAgICAgICAgICAg
ICAgICAgICAgIDEgICAgICAgICA0MDAuMDkgIEdCIC8KPiA0MDAuMDkgIEdCICAgIDUxMiAgIEIg
KyAgMCBCICAgOEVWMTAxMzUKPiAvZGV2L252bWUxbjEgICAgIENWRlQ3MzgzMDAwVzQwMEJHTiAg
IElOVEVMCj4gU1NEUEVETUQ0MDBHNCAgICAgICAgICAgICAgICAgICAgICAxICAgICAgICAgNDAw
LjA5ICBHQiAvCj4gNDAwLjA5ICBHQiAgICA1MTIgICBCICsgIDAgQiAgIDhEVjEwMTcxCj4gCj4g
Zndpdwo+IAo+IEkgYnVpbHQgNS4xNCBhbmQgSSBoYXZlIDIgbnZtZSBkZXZpY2VzIGFuZCBJIGFt
IG5vdCBzZWVpbmcgdGhpcyBldmVuCj4gdXNpbmcgdGhlbSB0byBidWlsZCB0aGUga2VybmVsIG9u
LgoKVGhhbmtzIGZvciB0cnlpbmcuIFdoYXQgYWJvdXQgdjUuMTMuMj8gQWxzbywgYXJlIHVzaW5n
IEJGUT8gSXMgZGV2aWNlIG1hcHBlciAKaW4gdXNlPwoKLS0gCk9sZWtzYW5kciBOYXRhbGVua28g
KHBvc3QtZmFjdHVtKQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
