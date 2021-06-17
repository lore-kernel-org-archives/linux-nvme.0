Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6EAC2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 05:46:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C819F60C3E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 05:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C819F60C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pzxbbZ6KuKE3qV/3L5FOeosQRFDC/ZxyfjGHtByEFFk=; b=2FNEFUi1v4+zr83BSdLVRK1Ez3
	3Kl94WgV9Y6eCzHmsrhdm2Nh1uH/8pDqlh71cCQEdUhRACL0DX/wJmY5ZFiohC06gYMZAcIBsIUrt
	PDVkgpvVgE1aUe0PiGM8O4U2Uj5elpnto90xxwKe7eYSGdaI1EB4sNKDF2YDHK34zpEGGN19z3We7
	CnzAqSFr1uRMjfukWZuIob3LDFv84a85gfn2eRC925CRmbxid0beoL4a2PYXJkChs391d2z6G3WWh
	aHw3X2omv4+afrUAmSnsth8lrDAGfg2PXR3s4WqAj0ogPnCxudVo32TabSetsv4SKeg2oNPNI5OrL
	B0V0692w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltkqy-008yGK-GQ; Thu, 17 Jun 2021 05:46:12 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltkqw-008yFk-5b
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 05:46:11 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECB381FDAE;
 Thu, 17 Jun 2021 05:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623908768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDKNgRptmkAcMKQIKpAC7tb28d0GeyKUlta9wxuVteI=;
 b=na5Vd5mGE1WfrDwWYq4IUSidiPBhQltmjiQ5Tu0Kv44x3TkzYk2zFNFELDskesD1PN7J7d
 TV/SJwjH8EVn4uAA14kCe7eVAUPPWIrlMBKmmEeN9R9zyBB2RNuDU10GibX6oLEa/n8+p8
 kaj5Udy8AXx/H4osb3JtD8xEdUOz8OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623908768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDKNgRptmkAcMKQIKpAC7tb28d0GeyKUlta9wxuVteI=;
 b=vNRDTWaDfr9RqWjjOlPl3Jn8ywIw3SG7SWLdss4EP/+iPgaJnuodZHR/SYHg0P1IcAFDcc
 vADZKCPPhYAhIiBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id CBA36118DD;
 Thu, 17 Jun 2021 05:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623908768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDKNgRptmkAcMKQIKpAC7tb28d0GeyKUlta9wxuVteI=;
 b=na5Vd5mGE1WfrDwWYq4IUSidiPBhQltmjiQ5Tu0Kv44x3TkzYk2zFNFELDskesD1PN7J7d
 TV/SJwjH8EVn4uAA14kCe7eVAUPPWIrlMBKmmEeN9R9zyBB2RNuDU10GibX6oLEa/n8+p8
 kaj5Udy8AXx/H4osb3JtD8xEdUOz8OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623908768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDKNgRptmkAcMKQIKpAC7tb28d0GeyKUlta9wxuVteI=;
 b=vNRDTWaDfr9RqWjjOlPl3Jn8ywIw3SG7SWLdss4EP/+iPgaJnuodZHR/SYHg0P1IcAFDcc
 vADZKCPPhYAhIiBQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id v/MoMaDhymATVgAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 17 Jun 2021 05:46:08 +0000
Subject: Re: [PATCH v3 2/4] nvme-pci: limit maximum queue depth to 4095
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210616211936.451128-1-sagi@grimberg.me>
 <20210616211936.451128-3-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6b71ca0d-c2b8-db04-65d8-3055690cbd22@suse.de>
Date: Thu, 17 Jun 2021 07:46:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210616211936.451128-3-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_224610_400559_14CB3EFF 
X-CRM114-Status: GOOD (  15.23  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi8xNi8yMSAxMToxOSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiBXZSBhcmUgZ29pbmcg
dG8gdXNlIHRoZSB1cHBlciA0LWJpdHMgb2YgdGhlIGNvbW1hbmRfaWQgZm9yIGEgZ2VuZXJhdGlv
bgo+IGNvdW50ZXIsIHNvIGVuZm9yY2UgdGhlIG5ldyBxdWV1ZSBkZXB0aCB1cHBlciBsaW1pdC4g
QXMgd2UgZW5mb3JjZQo+IGJvdGggbWluIGFuZCBtYXggcXVldWUgZGVwdGgsIHVzZSBwYXJhbV9z
ZXRfdWludF9taW5tYXggaXN0ZWFkIG9mCj4gb3BlbiBjb2RpbmcgaXQuCj4gCj4gUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KPiAtLS0KPiAgIGRy
aXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgMTUgKysrKysrLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+IApSZXZpZXdlZC1ieTogSGFu
bmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5u
ZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVu
ZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
