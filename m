Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EF7C55822
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2026 18:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYFf3AEYZGCpSwS9InYsHIhqLn93e8csrNvj0jii0uM=; b=Z8rg80yusQDoXsU7U+UVTR/Jcn
	KP6pTmTtK08GDUp8PR7DhfMzzoW1IYM8D3qw9rQM6FCjba7OW5T+S+XBcsSLGhXrygT8Bb8JWvlUs
	2X9lw1jzU1GejQ3tPWumpmi2KwtCMGTJTZcDzivYqfsbc4rO2wLZtDle4zgul7QZWkJSjb/MtAilg
	+d6t7xTqnYH9qaAhREbDy9V4zg1Sjalhuqjsj3Sw1gmmF2mZ82lp9FF1cg0ep8h6OUV9cwM+va3Iq
	7QH3/3WcpFEYEr7xKgKldbfGNDXPy2dhfWP/dguN4q+ZThgEX/z6oFl5vIWUQkCzJnMcRsV+wha5W
	iJmMv63Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqxIh-00000000Mg1-3ndC;
	Mon, 03 Aug 2026 18:22:11 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqxIf-00000000MfR-1VMw
	for linux-nvme@lists.infradead.org;
	Mon, 03 Aug 2026 18:22:10 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-38e347638adso4298898a91.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Aug 2026 11:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781328; x=1786386128;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYFf3AEYZGCpSwS9InYsHIhqLn93e8csrNvj0jii0uM=;
        b=XYprdC37m99Gx9RTGrNOPKbGy+JXXwRkf0O0ln4QqbrFFVlzSNTtaZuqpUj6oYUo7A
         nNJtZxG3T0h7KyXVNq1Whl8aAQ6WvjJmgb7SmZzNcc1rycmiyT9fK8v/lTKHtQ2QXpyX
         AenA4f5x2XEZ4RKGyGBdI87UifJcK9I10A1r7sEc5O6kpe5GFTTBUcPlccYu7pt3cXNK
         /EKHSm81pXUE+HtRj1yHCNDcr8NfUxPYj4BMLHVASzcGNubZ+XXT8tzdRZOL5SiyZYDT
         LqIb0oHsa0Il4C5/e8wTsoFgkvco667zaHH6+Z1QY4Zt+MAMGt/83BUa6OgEFOpqtzJy
         LB+A==
X-Forwarded-Encrypted: i=1; AHgh+RpspxMhetCKPIcONXyb92FHUvgY6bv/72Q83h9vZJz42kePDkp6keMs8+vPcGaHtSM+jHcB2DpRcUc0@lists.infradead.org
X-Gm-Message-State: AOJu0YzmiYPQ0FY5lD1hJrYFjy0XGuVGRKaHLfDYh3UzqWXccNQVc7Ns
	SHoH/9YTLhrSy2T+2M0fuveZLKS/woHOs61P5GwVYr117iEsm4abQJCm
X-Gm-Gg: AR+sD12xiaKy/uzvz1vGUymqA17CMtzyoezEU7O+ueV5VSXEN86gzeKjt6ImXLSQnQg
	mNpJhMNwhXn9Q8b4Nid3wPKGc4Dv5KbcT9CrTV58T6HtOnklGAEhpSl0K1UmqcB+nKhcMUarkTt
	2CTeAk6YA0wGUjGL9mfdPEWIMkWi5BBZeapN6SYulAHJkBSyBfH5Ykr6T1CK1Cl0eScBS84Tqdm
	ugzBADFRzZ3gRmf4AX7TEYecXAb8Fd1YuAw2SV4dHERphW7oSfyVcikte9gRTWaK2SCNgDW6I5b
	60tiPRwu0DIm9s8PYbsQvMmkNmp7OtNc8XxtO4kp+miM6uJY81cAIxX+HKWDYoGoU8czWFxsT8E
	cskGXvZcQYW1QLPJ4FDbglQ8KDd0UdzUKE0RWj3f2ENEbWFHIAz6XqL8tfN3/OFT+Mip3ZS3j9l
	Wj+k7yIeq7a9Nh0WAxTWm3rEeZy+zPVpGzgnbqhmSFHvGNwpPBcPTKkD2+7PCQkma71vM52bohD
	jtS6WzrDfKcUodd8xqkKB4hDA7n0M2MsjX0UxpIrlwhAVmkXhNGmj/QGWT2D8syx33/qfgMwK9l
	htVUr2cHn/qp
X-Received: by 2002:a17:90b:510a:b0:38f:c925:d35c with SMTP id 98e67ed59e1d1-38fc925d3cdmr7844316a91.33.1785781327844;
        Mon, 03 Aug 2026 11:22:07 -0700 (PDT)
Received: from dancol.org (dancol.org. [2600:3c01:e000:3d8::1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f197sm41731752eec.6.2026.08.03.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org;
	s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date;
	bh=OYFf3AEYZGCpSwS9InYsHIhqLn93e8csrNvj0jii0uM=; b=Kv47mrXJv27yJLluICw4tgf9Vv
	SiJ8S3lJdeaU2iayibdJ+/sp4LwDXZAlFw2Br86rSsERTb3NSTKYPcBjARM5JkvAHla4DH4crLCAQ
	mAjTRDe8bBY1BzqZnqS/jlS2Pn/vVmzSGuKR1Li4T/ve719aD01t8TkAWAP0yXm/dTWLj7PJ1ZzE9
	tI1WoKJxCyXMbpl2ENtwk1hb1q8LHouznshVcqJm9ciTiLALr5Rn54jaMCcYZB802APYkCK4ag4fD
	3IPjwkJCTsApXVLOfw7Wt2nk6fX/PVpR359daHLQRc/G+md032QJGKg8Q8IH/q8Y+JSy3cqDsYpHT
	UcEDlvhg==;
Received: from [2600:1006:b355:c62b:65aa:1d24:e259:1cc3] (port=37226 helo=ehlo.thunderbird.net)
	by dancol.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <dancol@dancol.org>)
	id 1wqxIb-00000001igD-3Mc8;
	Mon, 03 Aug 2026 14:22:05 -0400
Date: Mon, 03 Aug 2026 14:22:04 -0400
From: Daniel Colascione <dancol@dancol.org>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: make sending wall-clock time to NVMe opt-in
User-Agent: K-9 Mail for Android
In-Reply-To: <anDY10XMfeRmAiFN@kbusch-mbp>
References: <20260713203443.322748-1-dancol@dancol.org> <alVQCljd3a0dRRPw@kbusch-mbp> <87qzl6k3bx.fsf@dancol.org> <87ldaoh08v.fsf@dancol.org> <anDY10XMfeRmAiFN@kbusch-mbp>
Message-ID: <000321DE-F4A2-4CAC-94FE-431967560DC5@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_112209_438493_0B08CD95 
X-CRM114-Status: GOOD (  14.10  )
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



On August 3, 2026 2:07:19 PM EDT, Keith Busch <kbusch@kernel=2Eorg> wrote:
>On Sun, Aug 02, 2026 at 01:59:28PM -0400, Daniel Colascione wrote:
>> Daniel Colascione <dancol@dancol=2Eorg> writes:
>> > I mostly care about having *some* knob to turn this off=2E Right now,=
 it's
>> > unconditional=2E I'm happy with either opt-in or opt-out, although I =
have
>> > a weak preference for the former=2E
>>=20
>> Ping=2E Is there anything I should be addressing in the patch? Thanks
>
>The historic behavior is that the timestamp feature happens=2E Making an
>option to change behavior usually leaves the historic behavior the
>default so that anything using it isn't suddenly having to scramble to
>restore what they had before=2E

Will do=2E Thanks!

