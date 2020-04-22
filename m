Return-Path: <SRS0=9Zwh=6G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F8FC55189
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 11:31:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B58220784
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 11:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o1Oj+x0f";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=kvr.at header.i=@kvr.at header.b="IODq+F4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B58220784
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=kvr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:To:From:References:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TrjgzQbWKjHHpOMR92CSV3JHA0e8AzaCRV802rJYkXQ=; b=o1Oj+x0fKaSbqqKshDCTAXal76
	0eHxy2f61LIapGBJ+klQqnfYP+YDQey+7hNtpqIC3bvrLq4aHyppt14IUOI8869LC34/YHJCYi1+4
	QFk3WnBxPHme9+Z401i4RxCd02o9FaRYXC7hl/QjdRRm5z24L6k9tZ4/AyOg9oNdIvjB0rcDczif1
	uHVqkci6RF16xxeX3l2l5agXLfjWbNgl9QWmi0E5orAxAG3e//saTlrDagphA5B77z3kMUzCvhG66
	Zo08knIQ8+5363mZMmOyhJQkZm1uVpiq/zD4adaW/fV7s2Lzvk13q/qrzuoHSGHbOPhl3aLlzRPos
	C0SeDEcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRDb1-0006d7-B1; Wed, 22 Apr 2020 11:31:15 +0000
Received: from smtp.kvr.at ([83.65.151.181])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRDay-0006Zt-OS
 for linux-nvme@lists.infradead.org; Wed, 22 Apr 2020 11:31:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kvr.at;
 s=20200417; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
 :Date:Message-ID:To:From:References:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/SvJIQiARpgdPy0g9R99pgrQSX4IjLY/AYK6SxihM+E=; b=IODq+F4j5Qb7naqW/kCy0pPj1e
 X4vPWUPug1K3c3a5xd37jQN1Bmi+6sRdbRbxY5OX2P+qFKmMNiaQAJ+B+rXfyCyOKlrMwGZZy3rRY
 FaEkSPHpywkRIAncHtN2MmyvERy1lT9X0ZkauU+4J6Kd+l5G6EeYeUHDggIanAG6xfQ8QjwJvAwNC
 xIRnoxyke3oRrz5xVwGsI7+UjHJRDJxHua7XIlTOSpRrGhfywSbkv06MyapmSP6DEYfiH65saCigQ
 fX0fAzu1btw3E6LdtRJgjyeFUck1gfxBHcU0h4hoKGsdZotzXJvLy/5WH9RwxlOra0LqVxNWpykVO
 Zwx7NsCwZxLVdVP4IFF3IzHcTJ6uKLt6eGLeQxilw+VAuUXenaTSLvu1k8hM92AEhM3BJXVoxDsct
 0+pXV98NbglAReVKRmejOs0vf+xcRKJKMnh4Sp1LtVT9rOKoQC8gNI/2bTdVnWxsci1QYiK3JN1UR
 MBDJDiKjMcEgf4mTjoWn9/Mji0R2hiL9esySXluuj1EB23nAmrT7sVxT2DdiyyQdPndOIrc21ywKm
 r6ekiBE5K1NPSVcNu+pG/D4aOBw0EWW7bWQWnPIiwVenlVPtRmIVQXm6CUyTaLEpIrt1g5VUutseL
 QJsQeYsWjDFXwCOp8rp+72T50YYmuOZnL7gDce4qU=;
Received: from [192.168.0.7] (port=58998)
 by smtp.kvr.at with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
 (Exim 4.93) (envelope-from <ckk@kvr.at>) id 1jRDaU-003XSb-0F
 for linux-nvme@lists.infradead.org; Wed, 22 Apr 2020 13:30:42 +0200
Subject: Re: NVME drive warns on power-off; smartd reports error log entry
 increase
References: <671cdd44-dfa1-730f-634f-0946f5b6beeb@kvr.at>
 <20200422084131.GA9192@infradead.org>
From: Christian Kastner <ckk@kvr.at>
Autocrypt: addr=ckk@kvr.at; keydata=
 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
To: linux-nvme@lists.infradead.org
Message-ID: <b62f5869-a5d1-3e25-6e9e-fc5daccb761e@kvr.at>
Date: Wed, 22 Apr 2020 13:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422084131.GA9192@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_043113_139076_ACBF53DC 
X-CRM114-Status: GOOD (  10.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-04-22 10:41, Christoph Hellwig wrote:
> Can you check with the latest Linux 5.6 upstream kernel if that still
> shows up?  I have a hard time figuring out what weird mix of patches
> any given distro kernel has.  Alternatively report it to the debian
> bug tracking system (bugs.debian.org).

I tried it with 5.6.6 and a olddefconfig, and I didn't see the warning
this time.

It could indeed be Debian-specific, or have been fixed after 5.4. I will
attempt to try out our own latest kernel to determine which is the case.

> For the error log:
> 
> Please run
> 
> nvme error-log /dev/nvme0
> 
> after the reboot (make sure nvme-cli is installed) which will tell us
> what entry showed up in the error log.

This never showed anything (I've tried it in the past):


Error Log Entries for device:nvme0 entries:64

.................
 Entry[ 0]
.................
error_count  : 0
sqid         : 0
cmdid        : 0
status_field : 0(SUCCESS: The command completed successfully)
parm_err_loc : 0
lba          : 0
nsid         : 0
vs           : 0
cs           : 0
.................


Oddly enough, smartctl keeps reporting an increase of what appears to be
a counter,

     Error Information Log Entries:      208

yet further down in the output, the nvme error-log output is mirrored again:

    Error Information (NVMe Log 0x01, max 64 entries)
    No Errors Logged

In any case, continuing this at bugs.debian.org as you suggested now
seems more appropriate.


Thanks,
Christian

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
