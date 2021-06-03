Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF54C47096
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 21:10:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE90613EA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 21:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE90613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4xsexE7FArblF2rpJms/SUM61gmKeikKmbVY4gt8Kdo=; b=BxNp4jucIDKw/r
	3B9o6AcZuc7Joq2CFoqJKV/xWCBuVmckdFNr9EjdWi8GaifaD40LIMuKVF5wYZzTaEfiiS4PNkdkz
	8ZdYyQ7gsU2Xuva+tmNChPp/4XGpy1n5pm76iLujVDoOV2o9BEjRw3J9bDIl36U6ApPz3BaHJzkP5
	SDFk1SM6fkNqsPE+MR2CYv1f+EKkeraC+k/UU5faaHhSLHUC4yeQpMIRT0V2CSCr1LftFlD7ve2Aw
	JHruuQHqp65eVvMTXW3uBKLr0jQ0Sac1jW2fImEIcEwLbnnKrIj7cppu/D1kofcKjlxSTML13l1/B
	1WacwEVsJvmbLWYNoL9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loubS-00Aao3-1Q; Thu, 03 Jun 2021 21:10:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loubO-00AanV-BL
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 21:10:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id 9CBE2613EA;
 Thu,  3 Jun 2021 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622754605;
 bh=lbDFdHaBMvJl/yFHn0zrTbFJo59Ca7lfA6cg4Gr/kM0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=jGOuMSsGIJ9AdhBUkOSBeD/2dq3LSINmzoG8/Bg2YDggux9i5r/3hn1Jm2lKjLmxF
 MmiCfieEVu3pfEQqUISCSml+NmZM5xGGt7v85oDGw2rbq3/9dScLe9/bKruDPUg0P7
 V3qhpt/X3HV7CzhZTnWZ3XtD5vsPVe+WB5aFO+8Q5QcM9LhqkDo67gs+6Hrx3YqU3H
 XwvS2KtvMu0xWWUZkLHal2PY5CgtvyPlMMzlQY1rZIMeda+BFArOIKadjuwAeAaKnx
 jWSChMRMjgKq/cqlv+1NzZgPzf8VwAAclF9lCZh3lpNA4IGKq3bbGYzYbwuNpJaVfA
 rFoG5jP7zbgtA==
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] QED NVMeTCP Offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162275460557.4513.1472731666027007171.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jun 2021 21:10:05 +0000
References: <20210602171655.23581-1-smalin@marvell.com>
In-Reply-To: <20210602171655.23581-1-smalin@marvell.com>
To: Shai Malin <smalin@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, prabhakar.pkin@gmail.com,
 malin1024@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_141006_425203_EE2F7A5B 
X-CRM114-Status: UNSURE (   9.76  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGVsbG86CgpUaGlzIHNlcmllcyB3YXMgYXBwbGllZCB0byBuZXRkZXYvbmV0LW5leHQuZ2l0IChy
ZWZzL2hlYWRzL21hc3Rlcik6CgpPbiBXZWQsIDIgSnVuIDIwMjEgMjA6MTY6NDggKzAzMDAgeW91
IHdyb3RlOgo+IEhpIERhdmUsCj4gCj4gSW50cm86Cj4gPT09PT09Cj4gVGhpcyBpcyB0aGUgcWVk
IHBhcnQgb2YgTWFydmVsbOKAmXMgTlZNZVRDUCBvZmZsb2FkIHNlcmllcywgc2hhcmVkIGFzCj4g
UkZDIHNlcmllcyAiTlZNZVRDUCBPZmZsb2FkIFVMUCBhbmQgUUVETiBEZXZpY2UgRHJpdmUiLgo+
IFRoaXMgcGFydCBpcyBhIHN0YW5kYWxvbmUgc2VyaWVzLCBhbmQgaXMgbm90IGRlcGVuZGVudCBv
biBvdGhlciBwYXJ0cwo+IG9mIHRoZSBSRkMuCj4gVGhlIG92ZXJhbGwgZ29hbCBpcyB0byBhZGQg
cWVkbiBhcyB0aGUgb2ZmbG9hZCBkcml2ZXIgZm9yIE5WTWVUQ1AsCj4gYWxvbmdzaWRlIHRoZSBl
eGlzdGluZyBvZmZsb2FkIGRyaXZlcnMgKHFlZHIsIHFlZGkgYW5kIHFlZGYgZm9yIHJkbWEsCj4g
aXNjc2kgYW5kIGZjb2UgcmVzcGVjdGl2ZWx5KS4KPiAKPiBbLi4uXQoKSGVyZSBpcyB0aGUgc3Vt
bWFyeSB3aXRoIGxpbmtzOgogIC0gWzEvN10gcWVkOiBBZGQgVENQX1VMUCBGVyByZXNvdXJjZSBs
YXlvdXQKICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbmV0ZGV2L25ldC1uZXh0L2MvMWJkNGY1
NzE2ZmMzCiAgLSBbMi83XSBxZWQ6IEFkZCBOVk1lVENQIE9mZmxvYWQgUEYgTGV2ZWwgRlcgYW5k
IEhXIEhTSQogICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9uZXRkZXYvbmV0LW5leHQvYy84OTdl
ODdhMTBjMzUKICAtIFszLzddIHFlZDogQWRkIE5WTWVUQ1AgT2ZmbG9hZCBDb25uZWN0aW9uIExl
dmVsIEZXIGFuZCBIVyBIU0kKICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbmV0ZGV2L25ldC1u
ZXh0L2MvNzY2ODRhYjhmNGY5CiAgLSBbNC83XSBxZWQ6IEFkZCBzdXBwb3J0IG9mIEhXIGZpbHRl
ciBibG9jawogICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9uZXRkZXYvbmV0LW5leHQvYy8yMDNk
MTM2ZTg5NTgKICAtIFs1LzddIHFlZDogQWRkIE5WTWVUQ1AgT2ZmbG9hZCBJTyBMZXZlbCBGVyBh
bmQgSFcgSFNJCiAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL25ldGRldi9uZXQtbmV4dC9jL2Fi
NDdiZGZkMmUyZQogIC0gWzYvN10gcWVkOiBBZGQgTlZNZVRDUCBPZmZsb2FkIElPIExldmVsIEZX
IEluaXRpYWxpemF0aW9ucwogICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9uZXRkZXYvbmV0LW5l
eHQvYy84MjZkYTQ4NjE0MzAKICAtIFs3LzddIHFlZDogQWRkIElQIHNlcnZpY2VzIEFQSXMgc3Vw
cG9ydAogICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9uZXRkZXYvbmV0LW5leHQvYy84MDZlZTdm
ODFhMmIKCllvdSBhcmUgYXdlc29tZSwgdGhhbmsgeW91IQotLQpEZWV0LWRvb3QtZG90LCBJIGFt
IGEgYm90LgpodHRwczovL2tvcmcuZG9jcy5rZXJuZWwub3JnL3BhdGNod29yay9wd2JvdC5odG1s
CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
