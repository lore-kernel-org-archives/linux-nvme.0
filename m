Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A5CEF99CA
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 01:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8zL4Y5PYgkwBlNndcO9Z6uLpzUMpiG3hPwRFzYxU7mk=; b=XpUw6aLSe3iUq02eiiPlaf0wKV
	dea+O6ldyvC/S0zIa4TyUx8bceeMO9neksrDnWrZ2tuLHch5XvSbalOBYXpe/c8vOMTHG6e6MRUoD
	DPFbg4n8jEwVBzO8xNy95+YHkQAGmnjfYdXpHbnT4iiGqlEyHmnBpnm4yWHbiViIfH7EkC4a0Jy/6
	xpi47ec0iEvt0wv2jcaslqjmG2/SrhGJDwH8IddiRPpE9hqJJ61WWgLTFtw+nbjY+6ahkuOQpDe5b
	84Hmlb2dTSBZZhWYWdkBmFRVavWpwt2PC1rup/6WCTOcqQm1tdUnD5WMUxVDNVKmRVSePAYzPh+K2
	7wkD+KPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr4Gw-000000047XL-3Z14;
	Sat, 14 Feb 2026 01:16:34 +0000
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr4Gu-000000047Wz-3r39
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 01:16:34 +0000
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so432594241.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 17:16:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771031791; cv=none;
        d=google.com; s=arc-20240605;
        b=PA6sHkMjA5XolyWiAChSx6RbTXfF09dH9tn+W3sQ5DBQcjpiQ7icy+HUo4vY5uPJ8C
         WgwAojIkj1E5Xn0xlceh9LYQsuxTtdqTnJcYEjdm5tfUGgPr6IYME4Yw66qTzz5ecTd3
         SCXXEOK6tMpY5hoIxQTfYKOqcjpsWX5LUNbYNZgWg/TlXHhjrDJ1kKcGMa8CgkxrE90b
         c0LSoKgqek38q2cxImqogpTvBGmelKJ1Oz0h7bQdWg2gLpRLiiFUd6/JGq+tCCWBhg1k
         ySuOk8X+rgaNXoAvNVRZXDRtt9KTOjiVPwFInEqD1aNj+hLNfcu3Eent97bmp8m9T+f+
         8w+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8zL4Y5PYgkwBlNndcO9Z6uLpzUMpiG3hPwRFzYxU7mk=;
        fh=3Tlqgh1LsgGR8umfo6arWKhBZwTEMs+8Mwp5+njhEMk=;
        b=bxrAlMK0AFKAA4n/m9X7hggw+h2sJJ6DMuk+Up4HcgmW6qYpJrLpHoSy96csM+OnHs
         UEsqrmhn2W46R1c2NIDhc2EpsO6bKW5KVRLK50vw5y7qnBrNyMPax16KpjLIIIOF+DaN
         1Nu4b/yxm9yzQ59KvnjoaQ7ZVPInQMwEOcFMLHhOPyfmhUcc8ZYQiB4UdLe0Oi38lVaW
         jb2Jy3hE6MnfKVzJoXee6YwWhx9ooknjYDPpidcCpB3bdiuqExhCldyiGgb/idFIgo7Y
         HEEg2gJrlnYoT/mUVbg/+3xN+cr4rMWGTxw/rUhC5bvjNzDAw/OknJW3nESQqhl13POf
         VqNA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771031791; x=1771636591; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8zL4Y5PYgkwBlNndcO9Z6uLpzUMpiG3hPwRFzYxU7mk=;
        b=gE+4aMNZZZp5F+xXj9w0XxxOeTjxSjBQVcPjIX+v4UhRWOVPCcYHL+uAuStK9chBBF
         pIn7cl6fYbvTcvaIZZX7JakpzONGmALTrRrBz2oDIDMCV4NNEEVzNFCsgn+5ayhSk0DM
         fYQflIhhL9MkkGSV2zl4FeA0a3KzEI3ARzI0Hk2ca6/OPyk51nnmqeGz2qEBOXQV8hWG
         hevuKLTIo69bwy9chRO76Q3XrAIJkZq9pa/3eluP4gSmh8FhS6dgEDYIan2M1YkB9py1
         AV+u69P26WmWWZpkvCrosiOHdS2oLB08Hig07vzYv/FlVXxqHu5oim1Q2s+zppiwTIkj
         ziew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771031791; x=1771636591;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zL4Y5PYgkwBlNndcO9Z6uLpzUMpiG3hPwRFzYxU7mk=;
        b=ubeMyNM6kv5woznqUEt+H10ndl+ZvCqXa9ZPT7mTdXxflozWM2jbW+OBggCxtp1kmL
         SSfEfFs4K0vBkb5zcLxpq6Hsrssmc69SHQfJu/L0jbH6xbqreSND1PsVTHuTPr5auDYr
         bJ0Gyj13uTcKVarqjEXTnhs9c3h7c4OUl0Ho1CIhOPKQ8YssAQoa4UPwWA1pQddRUKyj
         Bucy7Yg6ftsCePlTfMeZwsQtlzhDOUMV24s93u8E+tKZHPRrKpz8YcJsl/12ODC+oZb4
         Kslqe8/EPRbTdkNcGwPJl9CUdhYwrd1bwNtuYJxhgrb0RP8YBb1oX+jZ/fB59MlGRM/f
         EyFA==
X-Forwarded-Encrypted: i=1; AJvYcCUukQHsGweQY0XTkSqB7XtglEhhHEhVdbOB4aH+s1liWbRD3T6f9ZcNodTElViqGrrap6V1RPO35Jem@lists.infradead.org
X-Gm-Message-State: AOJu0YwUukaIYprQS1+937zkoW9ZDfpopNMytP+RSKL6SVVrFQPHeI7f
	ITmkqVA+38qBw1lFFnbBKdotfRAlt1tW/aB0SIh8mdAPiP0PTpdywYyJS9x79DlWpOlOH17pVCk
	wFg8jdsEC1M/PoXdCnqr02YUxuhpwj1Hr1aJOlAuy5n4FVmohbsvt5wg=
X-Gm-Gg: AZuq6aJtt7shB5Lv8gr+Hvt7EcW56IxD33elAH/FvOnhrzRymXZFuss7FY2wPYpfsQU
	gXw15SWjxV/6ugm/w6zUgk7XnK4qckLgaFh1hhmv/csS474jQ01G+sk253kG9UGacS3TU84QbVu
	eWtaHrGlw69TfSZaXbKdaavrGax4RH8/EcjAhaAER31GMmGZ26WNwEV7pUvIvT452BxmXnor2c1
	MGB5JA3sQOwnLun84U2q+hsw6T9pze2Ds/nUbHi38ST1aK5io2suUTdPf2Qw3z3VrdNC9cXcIQS
	c0eH0NKM
X-Received: by 2002:a05:6102:cd1:b0:5fd:f744:660e with SMTP id
 ada2fe7eead31-5fe1ae23d90mr1473604137.28.1771031791352; Fri, 13 Feb 2026
 17:16:31 -0800 (PST)
MIME-Version: 1.0
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 13 Feb 2026 17:16:20 -0800
X-Gm-Features: AaiRm50MdcmGnCscUbEW6xlMt5SMidDFlVMmWz5pc2zGxaev3OUE4D16zk3mQaU
Message-ID: <CAPpK+O3zB4Y7L6u0jmVkM2eQs2D1DEJJMG_AXgM+HBs4wkLStg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] demo Linux nvme initiator driver stretched and
 dispersed subsystems
To: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_171632_961038_492A7D1B 
X-CRM114-Status: UNSURE (   4.59  )
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

I'd like to demonstrate the Linux nvme initiator driver interacting
with a stretched and a dispersed subsystem, run through some workflows
and illustrate usecases that are possible with one and not the other.
No, this is not necessarily production code.

Sincerely,
Randy Jennings

