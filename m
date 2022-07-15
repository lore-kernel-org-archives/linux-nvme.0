Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE77C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 21:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wFmCNr6mVUQ1FQYknGOvyDMLqvMWptFfqJCcv+Tg63U=; b=NNAtI8LAgDggktwMd2avpRfB6U
	A0MAa4HJRaFrn7H2a6Sq8ZGvk5Icl1xJy7RPEAuTw/4jAzPrjgKT1tvQA3UHQOVE6uPGVXrFAIkNP
	z2B1v3fBGE3F8/Vt9aGMGmMor/4+dtLjt4Ui3hYIGJzQSvrY2HBnhBEhIJRRJ/+b9K4i9i3De9U79
	sXiqeC5Dg6kGocyGZwGIsc0UBoInpxEWflf5e8jj3gLvVv6I+P0BP9OohpUuUyN/v0HhoG1jgTNCf
	uUxYwuH+DBgzoywmoAFv8Fkfb0Bg1ivozlkHAuMhguHcpZDANEG+43Oq+Ji9YA4v+Us1JAof3VIll
	Y0jR5+kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCSg2-00AOvs-9y; Fri, 15 Jul 2022 21:16:46 +0000
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCSfz-00AOuM-CY
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 21:16:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657919801; bh=wFmCNr6mVUQ1FQYknGOvyDMLqvMWptFfqJCcv+Tg63U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=A4Izv9Fe//NUAg1lRZx/JgX3SPdgaHQsglPDXOmVRKeJvECDG9uNw/KT29SSMz/aUxHJ9ozv/LnqTzGeN+K+GnionrNzSMAAdxglyloYIP85VD9EFlsRpzJcXMBl2VEFJ/zSFsqG37CutFBCAZpO009g2ELSAXF4PYnckDDhYc2sYbe0u+NnAXS/aARGVke2WdtKMjSAFvz8oSr+l+StXYZj6z5ytjVpHUry5GHkMg7TBKV9EF0jMTmzVD/WciDw6K9D9Q5JxXarK2HvC1OsFz58lRFtKIRS/TD3vrXJt1Bru21BF5RQFvdUPPXPDgYrnNjtvlyJDVFaFIVAmuk+0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657919801; bh=lWZiPze4TQq48Q8QJmL7h57jOV3m8gGGIfMylY9J1Ls=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GHyhH4Nv3hLwkTOfIOADebulRud4gHQh9wZjufPCj+w24xHrG5gstkhzN7jmbS2hqT2NJBf5QvExem7Tp3CeQDMQZ+pCgVM4qEy9cGmVReX00EPGQ5l6tA03ToFJCUZZUUWcC5ekX1rfc7Hl/fZwtiJUnZoVybQSAMvqtlWZgHxnxjH4O+2YIKNRC2W+qXGTQy4s84OSzYAf9eI04koV0kNEhAzs+kAr/d111VmeBBmJFq5cmZpgczbE0WFY4FOtMOvXvgAMB4GYK0+lByftrEmyHQAnnVGqDBDoYLy5B2Jo5q7eGyPiWNXkrbynfD+gxsLbnQVNd/HN1Do/zrwOXw==
X-YMail-OSG: MBgKIqgVM1nQouXEJyBRqcqSvuf4CQat9W4ypP14Z4fJaygnJ_0vLavwAUOo6FV
 xVDfuG.C6c4mg14k0M3HIAnHUMAXlMCpuCzEa3lnFrr6M7ZXFRQiat1_LZ6eDQEJZOmhC9Er4a5G
 KgQkIcFELaembA54P_VRr_zwfqk.uvR7qdLUY4s2GmHWLsdUYRD_fqQ0m_lJa2c_yexIlcqsNkAV
 wti6rcr8GMHpcUhTlAbwMHbjaPLgUaRf3o8wZqQzj_Rkzsx8BOrhBoABxi3R_PAC_KJMwnAJ9sms
 QXKWoIvFm1xxrcmZu0Ksvdny1.v6G6Oj.jQen2Jn6Sc3Pz98afioGrra4V2gAiSuN8xrdFXQlnMQ
 XB.3tQzLiujYhfC9tzyz0uYoDS5K3fAdG88awM017XjgvE9bBdA7756G1atmsUAzxJRV.dv.vRsd
 s4iSAFiPjQeEBwBeeXcNLMAlZR_imNWNm_mDyZMk2ltxKkhi_MO5YMWj9otFHkFDlqJx8BlP0ozk
 5UVeXCpP_Lp7wGBFlkbLfKS9T7BLmZKDEG2lqdkl.bt7PkXrjPQxyRvdkuZAQk1z5t56M72ukdag
 IptKxX2uI89pZKVZZbjClMihhEqenewdCIYkIanqZvDQu7KxA31LSYVy6dooTj4VM2EwjIk_vUBb
 f.mzEzrE38r4ydkwqXAgRPpBiwHiNorhLyia23rgtDFOVfeRcOnp_ZtKy0vZIKWAAjVoLRC6r77Q
 PS2vtvGqyFAX_MDDikIQseOEpxnbZXioZ1AhHfHNAaQy2ADhBsPDmOCZHjqR.s2MOw.Fy8.R6CdC
 kXbS07A9ZSqWDEpNeXYxU2Ez6Yyhp_D7L9PhtO78vvTQUC5OVTD.YCWeLoXVabspxxYre6upuo5z
 2_ZhoQ647TOcB2y6ar8v9tgkpA_9T.tsuJ6buaYatrRqZfYAOwGw30PKX9Qa2zvIyQaCVJs5Gdjg
 wc__VHW0SKkG5myDirmA5lDbumv76e_NVz0cA.hob8zoc6_2D4WC2LGCZLODB7tRxCKh_BYiPCpb
 CC7g5pOHWYQ2rEQh012GJ8DsNniWAmeU.9dSSaYQziIFFGt0sdhlwZZaV0w4XYvcf0SP5.k1mrva
 XebODTp4_mL9KxwHJ3yvG8zIVnjf1jNV8B53J.G._LcAPl14rqOFJWXSvlc0E7heLjMMJ_ANP9rE
 0PmZFY.8HYNwcW.GCF65ee7xuaS.HyDeUOHwX5ixm2FnwVjgrwAQKtmZQVZrTyG4uBvDXzBmHPSW
 BxhMKNqzqGx6JkNMzsd7y7Hjhnoi5Vct1CAbdv8jVJmDaOM6bOEIhEllL7TSycdSmxKuhZuwdMxY
 caPWlq5kRMuzAQJbWZNv.U7kELGPnfvLoCUM5ejRMBtRMHwcnNW3o5.Ft6eqJlmQZu2G4kuK1LLy
 bvkjKaEwB8UjgPxSJUtU5PnUWJR3qxJDE7sdhnRQT2QWXGcWMIHFUDsIiAetQSsOVJQOMrjGrFWu
 iPSQ4wnZT.iOaJrzpBPqgFMUuPxBhw8oOMih.dSauzvRNPCroSN1x2jqFSPyqCd0kejV5aur3uHu
 uYEZb.x.sG36k4bT4TlReAAhuPz.DQqqix5bWtaJY8h_mx3.kVlKbbRdlB79mV7ySJ6BjscYuFNT
 4IV7nZlSGZdxe8X0tRyFanoIC3LUGioNUDxShKmYAqPH9qlu1FdRl6jPEWyYqbw3iTPYkDS424Da
 0aeuO.ZEwB6TElJ17NvLTSM9mUj4.1k8ggv2SiKDlwTAmgGkDYUSbsOMmdyP75iXBWCBSKRaHHSf
 Yq0sfhvENfLeQ6haqs4hRZeJheNuZ_iAYnFVrxh.2QuNtOt_vlA3.EVb7KUW68Tu4h93YY.jKZfz
 ibxwZ7snDt6ld159u9D3I_RBVFaKJh3GmZhUsLJ5VcXobPTk8jHANjJZbMOv.6nXvzMLn1UL4mdc
 yR_nXL71DrT7MQzT8YMLCrqREgwfDwWISMjE5KNEpKjVGbb7LwpZzvAaB9dpQeYHmXazA3AN3xzt
 1Zzjn5GxDRbyT1GpVgrcw.nLe4K2K5hRA9O4Z._adQObEuX4S4rUVhF.HqPkaeoOYyJf0kxaOVh_
 KAGwDtRreedQY46.1MkDLfQYkXB.WHbqSBrnpHx3xdrLCTmrkfGyFC3DKogMku9dnLF2zkixV_lC
 zMte7n0XPFRLDWeJSmnugS1hH2AYnPiQ_oSbjWy1fRtmhE2yLztuX99ZXNwdXlrPjxvvOXCxCNeG
 Yqcf3Vae9j2yr.Ce6qREY4CCD1iBZaqkfXRqKnAT5Ui.K
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Jul 2022 21:16:41 +0000
Received: by hermes--production-gq1-56bb98dbc7-r7f9c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5a5804bb51dabd48fee000183e3b2fa7;
          Fri, 15 Jul 2022 21:16:36 +0000 (UTC)
Message-ID: <1b220ed8-c010-15f2-3bc2-6ec4b2e7532f@schaufler-ca.com>
Date: Fri, 15 Jul 2022 14:16:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file
 op
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, joshi.k@samsung.com,
 linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 a.manzanares@samsung.com, javier@javigon.com, casey@schaufler-ca.com
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <a91fdbe3-fe01-c534-29ee-f05056ffd74f@kernel.dk>
 <CAHC9VhRCW4PFwmwyAYxYmLUDuY-agHm1CejBZJUpHTVbZE8L1Q@mail.gmail.com>
 <711b10ab-4ac7-e82f-e125-658460acda89@kernel.dk>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <711b10ab-4ac7-e82f-e125-658460acda89@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_141643_495145_4ED7461C 
X-CRM114-Status: UNSURE (   7.04  )
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

On 7/15/2022 1:00 PM, Jens Axboe wrote:
> I agree that it should've been part of the initial series. As mentioned
> above, I wasn't much apart of that earlier discussion in the series, and
> hence missed that it was missing. And as also mentioned, LSM isn't much
> on my radar as nobody I know uses it.

There are well over 6 Billion systems deployed in the wild that use LSM.
Every Android device. Every Samsung TV, camera and watch. Chromebooks.
Data centers. AWS. HPC. Statistically, a system that does not use LSM is
extremely rare. The only systems that *don't* use LSM are the ones hand
configured by Linux developers for their own use.

>  This will cause oversights, even
> if they are unfortunate. My point is just that no ill intent should be
> assumed here.

I see no ill intent. And io_uring addresses an important issue.
It just needs to work for the majority of Linux systems, not just
the few that don't use LSM.


