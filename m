Return-Path: <SRS0=JSVl=OK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA1C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 12:24:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4974A610A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 12:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4974A610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=fused.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fIUMYi+s5gM/aQf1ykFpBifVbN/2hy4tKK+SUPHLK2I=; b=tvMuWaSuImx3w+MNyLml0ZYoXs
	XIP5HEV6VlQQDFOKV03T4xsaEgw57xivNgTol7/928yQlcdpA8bMlihfHHZFOMngI3ytNGWZB9WR3
	iR2YZ0sSYEPG9yR/YwkhkptciAblTXUAUT9NTpy/cj/K5EmoE+H4BlZNvdmoyN2kZm1R6zBaAz3+Z
	1TU6cQTyDj0kWbQhTPRBQxdQkAVBmzKTQ3Ksy97dBAM1tRLi4J/cSkxO+zeCW/6ekZegR23djtKoW
	ZBiIBYLHkvkf7imxVFvGchZAXzzgaZtUqwhXL+Ix9gb0hVWPlU5ek9uU04n2Dbr0cZYPYDja66rwy
	Pn4n1kOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSIKi-001XBO-RP; Mon, 20 Sep 2021 12:23:40 +0000
Received: from bb-3.out.fused.email ([69.162.149.152])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSIKa-001X8R-Q3
 for linux-nvme@lists.infradead.org; Mon, 20 Sep 2021 12:23:35 +0000
Received: (Haraka outbound: OUT) with LOCAL id
 3CE32672-1E73-4576-ABAC-0663D263DD54.1; Mon, 20 Sep 2021 07:23:31 -0500
Received: from in7.smtp.fused.net ([10.77.1.147])
 by out-2.smtp.fused.email (Haraka) with ESMTP id
 3CE32672-1E73-4576-ABAC-0663D263DD54.1
 envelope-from <ylkml@fused.com>; Mon, 20 Sep 2021 07:23:31 -0500
Received: (Haraka outbound: IN) with LOCAL id
 70366823-5AF4-4D3F-BF3C-68C676898071.1; Mon, 20 Sep 2021 07:23:31 -0500
X-Haraka-FCrDNS: static-52-119-46-66.at.fused.hosting
Received: from [10.50.1.10] (static-52-119-46-66.at.fused.hosting
 [52.119.46.66]) by in7.smtp.fused.net (Haraka) with ESMTPSA id
 70366823-5AF4-4D3F-BF3C-68C676898071.1
 envelope-from <ylkml@fused.com> (authenticated bits=0)
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 20 Sep 2021 07:23:30 -0500
Subject: Re: test
To: linux-nvme@lists.infradead.org
References: <ccb0afac-61bf-12af-421a-1404207f6ce0@fused.com>
From: ylkml@fused.com
Organization: Fused
Message-ID: <feb8aa7c-95c8-f48a-b862-71f7ad6ead16@fused.com>
Date: Mon, 20 Sep 2021 15:23:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ccb0afac-61bf-12af-421a-1404207f6ce0@fused.com>
Content-Language: en-US
X-Haraka-Karma: connect: 9, history: 1198, total_connects: 1964, pass:auth_user,
 headers.pass, skip:penalty
Original-Authentication-Results: in7.smtp.fused.net; iprev=pass;
 auth=pass (plain)
DKIM-Signature: v=1; a=rsa-sha256;
 bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=; c=relaxed/simple; d=fused.com;
 h=from:subject:date:message-id:to:mime-version; s=default;
 b=Anfk4VzTFzWDJX6oJ/lI1B0Mu1KmqKIWliufeNHGam1JWWAxsRCa33sdW1F0l/bjx7WMqtofsMZK9GHPHYu4ibSAlIV9EYWfQPAjIXeWV4ca6q85jOhyflVC48IoDH8SsB7Vvln19eiws0HQAgbiMJQU42h5NtEVMTm01cqZTRbmm/SJ4MK3yvEtEAnLIC7793y6MxaxKqBr1C8A5YYwGrY1r7dv/ll5msTLusGae2rTl0UMxcepeNM5eC/o7TwAb8cFCZDrUb1keZFEDMMauKVvcaeRld6shLSl0zDrogq5N0f02aS7v2TYYkPK6XJB4BtHxgfRhDs1OBiIQqrPXQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210920_052332_953114_F301F4A5 
X-CRM114-Status: UNSURE (   5.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
