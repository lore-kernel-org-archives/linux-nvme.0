Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF72C88E4D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JDE3O54+uPB/NIAVVl/ufko6s1c+5dSjdyfyemrkrrc=; b=Rw3o/uqpKEY43L41uVkYp9erl/
	yFk+lXWDHmzHnPhJJxJ82QiDCZfRoww1ibCwnxk8F9psZD0e1MxDuc051LPzPWa2NXG3mQHC3WNAO
	aFI4g5CHhagQPEA3eF/9gS6XKGn7ex1ZNzc2oCdkmAxfzk4UNxEfGPixNBeMS4yW9WoiBBUUFxNsM
	X6ivtwdXjyF35Lb69hye0sV91OLRhOcrC/GzdTZF25Q3lqUBOR+8E/QSxzoIzaFhKUwC0LEjt7Nd/
	E4TeFck1NAwiPrQvVraSL9nNzeAJxxpmXpERAnTe9rUHm7KX09Qx2a5Sk+msSblT61Q8ox9/6m/7U
	2VVJ45gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5AYL-00000000Lxa-30cG;
	Fri, 11 Sep 2026 23:21:05 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5AYJ-00000000LxC-2Uhl
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 23:21:04 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1555472a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1789168862; x=1789773662; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDE3O54+uPB/NIAVVl/ufko6s1c+5dSjdyfyemrkrrc=;
        b=W5ZfoOE9W0ot/I6IG+khCKI3cwZjznqnUGpXzXGt/DMga0WjH0iIdT1cKCR3X9Wtzq
         LaoON1jyR0WYkwUc+SOj15AmHrXrwYORfBTdh36sxU6dl33qxY7vIWKstuzO5OffSkqv
         qpyMmvNUcIdMUcie2Qt+ArD1fLVEgHJtQHUkVpyWyY0oQCjpO5pHn11XWabWEbhVmiRd
         UEkxUzQ8nAvSw0cRBBDSedaZ36iLSWjo/mYVScoLzf8xLb4JTPl/eVruPGHjcIXyzNAu
         Saxr4Nvd4rjwZa+L9lACzb+6MEKbt5PM+D+TVZkjc6AsohrDoMWqoHjLkL1GS8ARdaN1
         9haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789168862; x=1789773662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDE3O54+uPB/NIAVVl/ufko6s1c+5dSjdyfyemrkrrc=;
        b=bNIcDVuzuteCJejnUE6nFTCXlv+Q2rRKJ+RwzGJHaaOZ8BiLF1s2bClGcgs0qa7pCn
         3ppLxjuK7vszK1PG7DYFV+OFTy735+lvFY9+aY12KOOGalThcNbARLlpoSXBFhbmoPyZ
         gXnU8NUTqNAKnnaVVY1xyr4B+QDdAZIvf51HG166tibyQponQj7XyDmBVA+thXrIuyqA
         quXnf8SQ4IsWizkf4+u2XQmjiqJA4iK3Fi4UMLi0mH2x02hB/neM/WU2hApz07+XLrZn
         QbB093UuDqoHAxfxf4dFdTL9QltpSP2Kanx2hGxWlCTrGNEKUKSFqAYtrAC2j+PZY5hs
         rtbA==
X-Forwarded-Encrypted: i=1; AKwUvBwzyfIZ4Iyqbk364kK1PuuuwdrTycqQQgGIfQ/fgERJnAjTIxxbOMKRdTONbMfl9EbiV63N73JtDQ04@lists.infradead.org
X-Gm-Message-State: AFuF++n8xXpdzkbwbxbgKQ783jwso7p6MOH1gaV1s0/O/3HUatG388Lg
	gKkHBlK7BUHNass5NIw5ylfjLZMFDiQ+1RUs1vj0l+V/9bOpNRUlnyK7nZ/NwnA96Eo=
X-Gm-Gg: AYBFou2BuffpMAgNW5TfRR8RCeuHajClsvHJymxBIFoiwuvZ9TstlNlnaNdQ9lrcOki
	qXZJI7W8J/rmm6TZfTole+YkdhhNAgl5K9qiCpxHvYdVmmB7u+BYRYHBbO2O2h9t0R0cN3GO6+/
	SMG+S6fc1X6axGYHoKx2Nn7ym5g0QXRktU6jFo+FptbyYsR4nDnIzHmdpqjezJUCz06cCv1YkMO
	/Yak9I+pOYi8Tu2LAh4XaIsAL8UapWqqZqM8JwAQ1UivMH8rtDmICDL5Mj39lwhEyhJ73DM5ou9
	tReF4Hu52fV0yIKsCDWGJtwl89WYju0CEkswmyNZNQmXYlM5IPEd/g4Jp9T6MHMZQFWcVzdTdoE
	8j5Q6s8042E23TLIWF+NiL/XeArnzx/jjEHa+RdadKHuWZKqwgikW+BkVmCki1fTiNW7zlMLatV
	p2LCD06ShPsHrOujsNJihu9KbrCoPBwBlcch0PowQqU+qqjtFN3GaObUpJ7OoskIKR1lR5PeT3g
	nXHf7mxTHDm+litCift9yYFgq4CFYlsn/FrG/lMQrfq
X-Received: by 2002:a17:90b:384d:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-39d9c1b4a9dmr9730828a91.16.1789168862074;
        Fri, 11 Sep 2026 16:21:02 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([4.7.95.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e5193dsm8886173eec.10.2026.09.11.16.21.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 16:21:01 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Krishna Iyer <kiyer@crusoe.ai>,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	nilay@linux.ibm.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sj@kernel.org,
	saravanand@crusoe.ai
Subject: Re: [PATCH] nvme-multipath: add fail_io_now sysfs attribute to fail queued I/O
Date: Fri, 11 Sep 2026 16:20:59 -0700
Message-ID: <20260911232059.98122-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <8d06416e-a0be-4a0a-b1fe-f5b7831f8574@grimberg.me>
References: <20260904032605.65758-1-kiyer@crusoe.ai> <6b8ff0b7-c606-471d-b3be-12df3dac350b@grimberg.me> <20260906042235.71778-1-kiyer@crusoe.ai> <8d06416e-a0be-4a0a-b1fe-f5b7831f8574@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_162103_670907_8AFAC111 
X-CRM114-Status: GOOD (  15.53  )
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

On 9/11/26 2:37 PM, Sagi Grimberg wrote:

> At that point you can disconnect the controllers, which will teardown
> the inflight blocked IO.

That works, but it tears down every namespace on the controller and
someone has to reconnect afterwards. Our controllers back multiple
namespaces and we only want to fail I/O for one of them.

> If you have a namespace that is attached to controllers say X,Y,Z,W
> Now all of these controllers are unavailable, aren't all of the namespaces
> on these paths also unavailable?

Yes, they are all pathless. The difference between them is what to do
with the queued I/O. Holding it until a path returns is right for a
namespace whose user is still around, and wrong for one whose user is
gone. In our case a SIGKILLed VMM will never collect its completions,
while the neighboring namespaces belong to running VMs that should
keep queueing and resume once the fabric heals. The kernel cannot tell
these apart, only host software knows. That is why this needs to be a
per-namespace policy set by the admin, the same model as
fail_if_no_path in dm-multipath.

> Or is it that the paths are online, but the ANA group got into a state where
> there is no optimized path?

In our case no, the controllers sit in CONNECTING for the whole
outage, so there is no LIVE path. But v2 will cover that ANA case too:
with the policy set, a LIVE path with ANA inaccessible or
persistent-loss also does not count as usable.

Either way the no-path condition may be controller-wide, but the
remedy is not: anything controller-scoped releases I/O for every
namespace behind it, and we only want to release one. Hence a
per-namespace policy, which per Nilay's review v2 will rename to
fail_if_no_path and make persistent instead of self-clearing.

Thanks,
Krishna

